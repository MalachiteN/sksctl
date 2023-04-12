# sksctl

A CLI Tool for a campus network somewhere

---

# DISCLAIMER

This project is designed for **the only purpose of studying skills of reverse engineering and make full use of campus network in CDHT(you know where it is)**. It **ISN'T** designed for cracking into any system, stealing anyone's account, Banning any device from using campus network, or any other toxic things like them.

Users **SHOULDN'T** use these scripts to do anything harmful. We contributors **AREN'T** responsible to any abusers.

The maintainer **DIDN'T** declared she ISN'T a catgirl. You **ARE SUPPOSED TO** caress her ears.

# Environment

> Notice: This set of scripts **IS ONLY DESIGNED FOR Termux**. Don't ask why it doesn't run on your _manylinux_ machines. 
> If you're determined to do this, you may try to run a Termux container in Docker. This way is officially supported by Termux team. We won't officially support it or any manylinux system in our plan NOW.

Install this Apps from F-DROID:

- Termux
- Termux Styling
- Termux Boot

They should be installed from the same source, or the last 2 plugins won't be installed successfully due to wrong shared UID.

> We DON'T KNOW whether UTermux or any other mess like it IS OR ISN'T compatible to sksctl. You should try it out yourself.

# Install
```shell
git clone git@github.com:MalachiteN/sksctl.git
cd sksctl
# chmod +x if required
./install.sh -i
source ~/.profile
```
# Usage

```shell
sksctl help
```

You may be not familar to Linux CLI. Don't panic, clam down, try to find out how to use our tools yourself.

the only tip here is `sksctl help`. QwQ

# Setting up crontab
Automatic infomation gathering needs this step.

In fact, `crontab` and the job schedule is set during the install procedure. However, in Termux, `crond`(the daemon of crontab) needs a bit help to be started.

Of course you can manually start `crond`, or run it on login (for example to use `.profile`). But this isn't the best way.

Don't forget Termux had given us a plugin mentioned called `Termux Boot`. Once installed in your Android system, it will run a batch of scripts in `$HOME/.termux/boot/` when your Android boots.

```shell
mkdir -p ~/.termux/boot
echo -e 'termux-wake-lock\ncrond' > ~/.termux/boot/cron.sh
# Don't afraid to forget how to exit vim! >w<
chmod +x ~/.termux/boot/cron.sh
```
