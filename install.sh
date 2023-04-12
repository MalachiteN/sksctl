#!/bin/bash
fhelp() {
    echo "./install.sh [OPTIONS]"
    echo "安装或更新高新西区校园网 CLI 组件"
    echo "OPTIONS:"
    echo "	-i:	初始化（initial）安装，通常用于全新安装"
    echo -e "		\e[31m命令为 termux 定制，若非 termux 环境，将会报错退出\e[0m"
    echo "	-u:	更新（update）安装"
    echo "	-h:	显示帮助"
    exit
}
while getopts 'iuh' opt ;do
	case $opt in
		i)
			termux-setup-storage
			termux-change-repo
			pkg upgrade
			pkg ins vim sqlite crontab termux-services runit
			mkdir -p $PREFIX/var/spool/cron/
			cp ./crontab.rc $PREFIX/var/spool/cron/`whoami`
			upd=true
		;;
		u) upd=true ;;
		h) fhelp ;;
		?) fhelp ;;
	esac
done
if [[ $upd != true ]] ;then
	fhelp
fi
linenum=`grep -c KDSY ~/.profile`
ac=`ip route show table all|grep '^default'|cut -d' ' -f3`
ac_mac=`arp $ac|grep $ac|sed 's/\s\+/\t/g'|cut -f3`
if [[ $linenum == 0 ]] ;then
	echo 'export KDSY=~/.local/share/kdsy' >> ~/.profile
	echo 'export PATH=$PATH:$KDSY' >> ~/.profile
	echo 'export ACIP='"'"$ac"'" >> ~/.profile
	echo 'export ACMAC='"'"$ac_mac"'" >> ~/.profile
	echo -e '\e[33m设定了环境变量。安装结束后请手动执行 source ~/.profile\e[0m'
	source ~/.profile
fi
if [ -d $KDSY ] ;then
	echo '正在更新数据'
	rm -r $KDSY
fi
mkdir -p $KDSY
cp -r ./* $KDSY
ls -s $KDSY
