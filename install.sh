
#!/bin/bash
fhelp() {
    echo "./install.sh [OPTIONS]"
    echo "安装或更新 kdsy 校园网 CLI 组件"
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
if [[ $linenum == 0 ]] ;then
	echo 'export KDSY=~/.local/share/kdsy' >> ~/.profile
	echo -e '\e[33m设定了环境变量。安装结束后请手动执行 export ~/.profile\e[0m'
	source ~/.profile
fi
if [ -d $KDSY ] ;then
	echo '正在更新数据'
	rm -r $KDSY
fi
mkdir $KDSY
cp ./kdsy-* $PREFIX/bin/
cp ./*.txt $KDSY
ls -s $KDSY
