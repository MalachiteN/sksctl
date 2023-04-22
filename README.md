# sksctl

A CLI Tool for a campus network somewhere

English | [中文版](https://github.com/MalachiteN/sksctl/blob/main/README_CN.md)

---

# DISCLAIMER

This project is designed for **the only purpose of studying skills of reverse engineering and make full use of campus network in CDHT(you know where it is)**.

It **ISN'T** designed for:
- Cracking into any system;
- Stealing anyone's account;
- Preventing anyone from binding his/her new device to his/her account;
- Banning any device from using campus network;

Or any other toxic things like them.

Users **SHOULDN'T** use these scripts to do anything harmful. We contributors **AREN'T** responsible to any abusers.

The maintainer **DIDN'T** declared she ISN'T a catgirl. You **ARE SUPPOSED TO** caress her ears.

# Description

This project is a tool automatically exploits the **public** APIs of SKS's Smart Multi-service Gateway (widely used in schools' public wireless network, for example in [this list](http://www.skspruce.com.cn/news/10/) ).

Depending on what API it sends HTTP requests to, it can do many things, including:

- [x] Automatically connects your devices to internet;
- [x] Prevents your device from being banned by teachers;
- [x] Uses spare accounts to register your device permanently;
- [x] Automatically records your schoolmates' login activity and making statistics;

_And so on..._

There's also a lot of functions haven't been implemented yet:

- [ ] Creates your own account, and delete it after using for safety;
- [ ] Manipulates the login portal, like reseting banned ones, or changing their login methods;

...

Actually the maintainer doesn't know why such vital APIs could be exposed to the public without any authentication. However, exposed they are, we can make use of them.

# Environment

> Notice: This set of scripts **IS ONLY** designed for [Termux](https://github.com/termux/termux-app). Don't ask why it doesn't run on your _manylinux_ machines. 
>
> If you're determined to do this, you may try to run a [Termux container in Docker](https://github.com/termux/termux-docker). This way is officially supported by Termux team. We won't officially support it or any manylinux system in our plan NOW.

Install this Apps from [F-DROID](https://f-droid.org/):

- [Termux](https://f-droid.org/en/packages/com.termux)
- [Termux:Styling](https://f-droid.org/en/packages/com.termux.styling)

The first is our terminal emulator, and the second is the styling plugin. If the font looks strange on your device (mostly caused by the absence of the monospace font), you'll need it.

They should be installed from the same source, or the plugins won't be installed successfully due to wrong shared UID.

> We DON'T KNOW whether UTermux or any other mess like it IS OR ISN'T compatible to sksctl. You should try it out yourself.

# Install

## Select the fastest mirror

Before installing `git` and/or install our tools, you can choose a Termux package repository mirror close to you for higher download speed.

```shell
termux-change-repo
```
This command automatically runs `apt update`, thus your package manager cache will be up to date.

If you have this done before, you can skip this step. Instead, you will need `apt update`.

## Clone this repo

`git` is the tool to clone this repository to your device. If it isn't installed, install it.

```shell
apt install git
```

Anyway we should clone this repo, or you can fork mine and clone your.

```shell
git clone https://github.com/MalachiteN/sksctl.git
cd sksctl
```

## Use the installer script

We have a automatic installer script, simplifying our installing process.**However, it is not completed yet, and may cause some errors. Pull requests are welcomed.**

```shell
# chmod +x install.sh if required
./install.sh -i
source ~/.profile
```

It is tested in Termux and Kali container in it. As soon as the installer script comes stable, we'll set it the recommended method for installation.

> **CAUTION: NOW IT'S BROKEN ON ALMOST ALL DEVICES OVER ANDROID 10, SO THEIR USERS SHOULD MANUALLY INSTALL THIS TOOL**

## Manually install

If the installer script doesn't work, you can fallback to this way.

### Install dependencies

```shell
apt install vim sqlite3 iproute2 curl
```

- We need `vim` for the command `xxd`, which plays a significant role in both generating random MAC and encodeURI;
- `sqlite3` provides us the ability of managing gathered information about students' login activity;
- In order to get the IP and MAC address of your gateway, we need `iproute2`, which provides command `ip`.
- Most Linux distributions, as well as Termux, has `curl`. However, some containers doesn't. In the case we need to install it manually.

### Copy files and change permissions

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
chmod +x $insdir/kdsy
```

Now it is installed. If you're my schoolmate, you can run `kdsy` for testing.

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

## Finish! 😋

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

In Linux, the program `Cron` executes commands we scheduled. The time table is called `crontab`. We use `crontab -e` to edit our task schedule.

In Termux, we need to install it manually. It belongs to the source `root-repo`.

```shell
apt install root-repo
apt update
apt install termux-service runit cronie
```

Then, copy our preset crontab to your Cron's directory.

```shell
cp $KDSY/crontab.rc $PREFIX/var/spool/cron/`whoami`
```

Also, `crond`(the daemon of crontab) needs a little help to be started.

```shell
sv-enable crond
```

# Help us

Our project needs your help! We'll appreciate you if you can do these for us:

## Installer script testing

If you have a clean Docker container or a spare Android device, you can help us to test our installer script.

## Test (and/or port, if necessary) it for your school

If you're attending a school in [this list](http://www.skspruce.com.cn/news/10/), you can test whether `sksctl` works in your school's public wireless network.
If it doesn't work but you have a solution, opening your branch and port our script to your school is welcomed, and beneficial to both you, your schoolmates, and of course our project.
