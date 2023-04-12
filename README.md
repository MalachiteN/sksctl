# sksctl
A CLI Tool for a campus network somewhere
---
# Install
```shell
git clone git@github.com:MalachiteN/sksctl.git
cd sksctl
# chmod +x if required
./install.sh
source ~/.profile
```
# Usage
```shell
sksctl help
```
# Setting up crontab
Automatic infomation gathering needs this step.
```shell
crontab -e # input it yourself >∆<
# stuff below should be pasted to your editor
SHELL=/data/data/com.termux/files/usr/bin/bash
PREFIX=/data/data/com.termux/files/usr
PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/home/.local/share/kdsy
MAILTO=root
HOME=/data/data/com.termux/files/home
KDSY=/data/data/com.termux/files/home/.local/share/kdsy
*/30 * * * * $KDSY/cron.sh >> $KDSY/gather.log
# DONT FORGET HOW TO EXIT VIM!>√<
```
