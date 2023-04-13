# sksctl

A CLI Tool for a campus network somewhere

---

# DISCLAIMER

This project is designed for **the only purpose of studying skills of reverse engineering and make full use of campus network in CDHT(you know where it is)**.

It **ISN'T** designed for:
- Cracking into any system;
- Stealing anyone's account;
- Preventing anyone from binding he/her's new device to he/her's account;
- Banning any device from using campus network;
Or any other toxic things like them.

Users **SHOULDN'T** use these scripts to do anything harmful. We contributors **AREN'T** responsible to any abusers.

The maintainer **DIDN'T** declared she ISN'T a catgirl. You **ARE SUPPOSED TO** caress her ears.

# Environment

> Notice: This set of scripts **IS ONLY** designed for [Termux](https://github.com/termux/termux-app). Don't ask why it doesn't run on your _manylinux_ machines. 
>
> If you're determined to do this, you may try to run a [Termux container in Docker](https://github.com/termux/termux-docker). This way is officially supported by Termux team. We won't officially support it or any manylinux system in our plan NOW.

Install this Apps from [F-DROID](https://f-droid.org/):

- [Termux](https://f-droid.org/en/packages/com.termux)
- [Termux:Styling](https://f-droid.org/en/packages/com.termux.styling)
- [Termux:Boot](https://f-droid.org/en/packages/com.termux.boot)

They should be installed from the same source, or the last 2 plugins won't be installed successfully due to wrong shared UID.

> We DON'T KNOW whether UTermux or any other mess like it IS OR ISN'T compatible to sksctl. You should try it out yourself.

# Install

Anyway we should clone this repo, or you can fork me and clone your.

```shell
git clone git@github.com:MalachiteN/sksctl.git
cd sksctl
```

## Installer script

We have a automatic installer script. However, it is not fully tested. Pull requests are welcomed.

```shell
# chmod +x install.sh if required
./install.sh -i
source ~/.profile
```

## Manual install

### Choose a Termux package repository mirror close to you.

```shell
termux-change-repo
```

This command automatically runs `apt update`, thus your package manager cache will be up to date.

If you have this done before, you can skip this step. Instead, you will need `apt update`.

### Install dependencies

```shell
apt install vim sqlite iproute2 crontab termux-services runit
```

- `vim` is for command `xxd`, which plays a significant role in both generating random MAC and encodeURI;
- `sqlite` provides us the ability of managing gathered information about students' login activity;
- For getting the IP and MAC address of your gateway, we need `iproute2`, which provides command `ip`.
- the last three ones are related to automatic information gathering.

### Perform the installation

Now the installation directory **MUST** be `~/.local/share/kdsy`, or some functions (especially automatic information gathering) won't work.

> It is because the script is once named `kdsy`, the name of the maintainer's school.
>
> Now, you can still call `kdsy` as a special alias of `sksctl` with specified environment variables.

```shell
insdir='~/.local/share/kdsy'
crondir=$PREFIX'/var/spool/cron/'
mkdir -p $crondir
mkdir -p $insdir
cp -r . $insdir
chmod +x $insdir/bin/*
chmod +x $insdir/kdsy $insdir/sksctl $insdir/cron.sh
cp ./crontab.rc $crondir/`whoami`
```

Now it is installed, and if you're my schoolmate, you can run `kdsy` for testing.

### Configuring environment variables

For general usage, you'll need this step.

```shell
ac=`ip route show table all|grep '^default'|cut -d' ' -f3`
ac_mac=`arp $ac|grep $ac|sed 's/\s\+/\t/g'|cut -f3`
echo 'export KDSY=~/.local/share/kdsy' >> ~/.profile
echo 'export PATH=$PATH:$KDSY' >> ~/.profile
echo 'export ACIP='"'"$ac"'" >> ~/.profile
echo 'export ACMAC='"'"$ac_mac"'" >> ~/.profile
# Don't afraid to forget how to exit vim! >w<
source ~/.profile
```

### Finish! 😋

`sksctl` should work now. Type `sksctl` and some subcommands to test if it is installed properly.

If you want to set up the automatic information gathering function, check section [Setting up crontab](#Setting-up-crontab) for instructions.

# Usage

```shell
sksctl help
```

You may be not familar to Linux CLI. Don't panic, clam down, and try to find out how to use our tools yourself.

the only tip here is `sksctl help`. QwQ

# Setting up crontab

Automatic infomation gathering needs this step.

In fact, `crontab` and the job schedule is set during the install procedure. However, in Termux, `crond`(the daemon of crontab) needs a bit help to be started.

Of course you can manually start `crond`, or run it on login (for example to use `.profile`). But this isn't the best way.

Don't forget Termux had given us a plugin mentioned called `Termux:Boot`. Once installed in your Android system, it will run a batch of scripts in `$HOME/.termux/boot/` when your Android boots.

```shell
mkdir -p ~/.termux/boot
echo -e 'termux-wake-lock\ncrond' > ~/.termux/boot/cron.sh
chmod +x ~/.termux/boot/cron.sh
```
