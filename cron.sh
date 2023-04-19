#!/data/data/com.termux/files/usr/bin/bash
SHELL=/data/data/com.termux/files/usr/bin/bash
PREFIX=/data/data/com.termux/files/usr
PATH=/data/data/com.termux/files/usr/bin
MAILTO=root
HOME=/data/data/com.termux/files/home
KDSY=$HOME/.local/share/kdsy
PATH=$PATH:$KDSY
ACIP='10.72.174.2'
ACMAC='04:8b:42:10:c6:20'
sz=60

h=`date -Ih |sed -e's/^.*T//' -e's/+.*$//'`
if ((h < 7)) ;then
	echo '此时没有必要收集'
	exit
elif ((h == 11)) ;then
	sz=300
fi

echo -e '\e[33m=== === ===		BEGIN		=== === ===\e[0m'
$KDSY/bin/kdsy-gather -s $sz
echo -e '\e[33m=== === ===		END		=== === ===\e[0m\n'
