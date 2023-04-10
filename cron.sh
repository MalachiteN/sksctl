#!/data/data/com.termux/files/usr/bin/bash
SHELL=/data/data/com.termux/files/usr/bin/bash
PREFIX=/data/data/com.termux/files/usr
PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/home/.local/share/kdsy
MAILTO=root
HOME=/data/data/com.termux/files/home
KDSY=/data/data/com.termux/files/home/.local/share/kdsy

sz=40

h=`date -Ih |sed -e's/^.*T//' -e's/+.*$//'`
if ((h < 7)) ;then
	echo '此时没有必要收集'
	exit
elif ((h == 7)) ;then
	sz=300
fi

echo -e '\e[33m=== === ===		BEGIN		=== === ===\e[0m'
echo `date`
kdsy-gather -s $sz
echo `date`
echo -e '\e[33m=== === ===		END		=== === ===\e[0m\n'
