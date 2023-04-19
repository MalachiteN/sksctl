# sksctl

用于某些地方校园网的 CLI 工具包

---

# 免责声明

这个项目的目的是 **学习web逆向的技能，并充分利用CDHT的校园网络（你知道它在哪里）** 。

它 **不是** 为以下行为设计的：
- 破解任何系统；
- 窃取任何人的账户；
- 阻止任何人将他/她的新设备与他/她的账户绑定；
- 禁止任何设备使用校园网；

或任何其他类似的有毒事情。

用户 **不应该** 使用这些脚本来做任何有害的事情。我们的贡献者 **不** 对任何滥用行为负责。

~~维护者 **没有** 声称她 **不是** 一个猫娘。你 **应该** 抚摸她的耳朵。~~

~~我是脚本小猫~~

# 描述

该项目是一个自动利用SKS（某公司）的智能多业务网关（广泛用于学校的公共无线网络，例如在 [此列表](http://www.skspruce.com.cn/news/10/) 中的学校）的 **公共** API的工具。

根据它发送HTTP请求的API，它可以做很多事情，包括：

- [x] 免改 URL，一键（甚至自动）将你的设备连接到互联网；
- [x] 使用自动生成随机MAC、写入白名单等手段防止你的设备被老师拉黑；
- [x] 使用备用账户永久注册你的设备；
- [x] 自动记录你同学们的登录活动并进行统计；

_等等..._

还有很多功能还没有实现：

- [ ] 创建自己的账户，以及为了安全起见，使用后将其删除；
- [ ] 操纵登录门户，比如重置被禁止的登录门户，或者改变它们的登录方式；

_..._

事实上，我们的维护者不知道为什么这样重要的API会在没有任何认证的情况下暴露给公众。然而，它们已经被暴露了，我们可以利用它们。

# 环境

我们支持 `Termux` ，安卓设备上的高级终端模拟器。

> 注意：这套脚本 **只** 为 [Termux](https://github.com/termux/termux-app) 设计。不要问为什么它不能在你的 _manylinux_ 机器上运行。
>
> 如果你决心这样做，你可以尝试运行一个[Docker中的Termux容器](https://github.com/termux/termux-docker) 。这种方式是由Termux团队正式支持的。但在我们现在的计划中，我们不会正式支持它或任何 _manylinux_ 系统。

从[F-DROID](https://f-droid.org/) 安装这个应用程序：

- [Termux](https://f-droid.org/en/packages/com.termux)
- [Termux:Styling](https://f-droid.org/en/packages/com.termux.styling)

第一个是本体, 第二个是插件。如果你想换更好看的终端字体、终端主题，或者你设备上 `Termux` 的字体非常诡异（通常是由于设备没有内置等宽字体，渲染器强行将非等宽字体拉伸成等宽导致的），你就需要 `Termux Styling` 。

应从同一来源（例如 F-DROID）下载安装 `Termux` 及其全部插件。否则，插件会因为 Shared UID 错误而无法成功安装。

> 小心，安装 Kali Nethunter 附带的 “F-DROID” 背后是 Kali 自己的构建系统。使用它会不兼容真正的 F-DROID 里下载的插件。
>
> 另外，我们不知道UTermux或任何其他类似的怪东西是否与sksctl兼容。你应该自己试试（这句话意味着没有任何正式支持）。

# 安装

## 选择最快的镜像

在安装`git`和/或安装我们的工具之前，你可以选择一个离你很近的Termux软件包仓库镜像，以获得更高的下载速度。

```shell
termux-change-repo
```
这个命令会自动运行`apt update`，因此你的软件包管理器的缓存会是最新的。

如果你以前搞过这个，你可以跳过这一步。作为替代，你将需要运行 `apt update`。

## clone 这个仓库

`git` 是用来 clone 这个仓库到你的设备上的工具。如果还没有安装，请安装它。

```shell
apt install git
```

很明显下一步就是clone这个 repo。或者你可以fork我的，然后clone你的。欢迎这么干。

```shell
git clone https://github.com/MalachiteN/sksctl.git
cd sksctl
```
## 手动安装

### 安装依赖项

```shell
apt install vim sqlite iproute2
```

- 我们需要`vim`来执行`xxd`命令，它在生成随机MAC和编码URI方面起着重要作用；
- `sqlite`为我们提供了管理收集的学生登录活动信息的能力；
- 为了得到你网关的IP和MAC地址，我们需要`iproute2`，它提供`ip`命令。

### 复制文件和设定权限

现在，安装目录**必须**是`~/.local/share/kdsy`。否则，一些功能（特别是自动信息收集）将无法工作。

> 这是因为该脚本曾经被命名为`kdsy`，是维护者学校的名称缩写。
>
> 现在，你仍然可以调用`kdsy`。不过它现在是`sksctl`的一个具有特定环境变量（使用本校网关IP与MAC）的别名。

``shell
insdir='~/.local/share/kdsy' 。
crondir=$PREFIX'/var/spool/cron/'
mkdir -p $crondir
mkdir -p $insdir
cp -r . $insdir
chmod +x $insdir/bin/*
chmod +x $insdir/kdsy
```

现在它已经安装好了。如果你是我校友，你可以运行`kdsy`进行测试。

### 配置环境变量

对于更通用的用途，你需要这个步骤。

``shell
ac=`ip route show table all|grep '^default'|cut -d' ' -f3`。
ac_mac=`arp $ac|grep $ac|sed 's/\s\+/\t/g'|cut -f3`。
echo 'export KDSY=~/.local/share/kdsy' >> ~/.profile
echo 'export PATH=$PATH:$KDSY' >> ~/.profile
echo 'export ACIP='""$ac"'">> ~/.profile
echo 'export ACMAC='"'"$ac_mac"'">> ~/.profile
# 不要害怕忘记如何退出vim!>w<
source ~/.profile
```

## 使用安装脚本

除了手动安装，我们还有一个自动安装脚本。

**但是，它还没有完成，而且充满了错误。欢迎提出PR。**

``shell
# chmod +x install.sh （如果需要的话）
./install.sh -i
source ~/.profile
```

这将是简单的，但现在它给你的Termux环境带来严重的问题。**不要使用它！**。

一旦安装程序脚本稳定下来，我们将把它设置为推荐的安装方法。

## 完成!😋

`sksctl`现在应该工作了。输入`sksctl`和一些子命令来测试它是否被正确安装。

如果你想设置自动信息收集功能，请查看[设置crontab](#设置crontab)部分的说明。

# 用法

```shell
sksctl help
```

你可能对 Linux CLI 不熟悉。不要惊慌，冷静下来，并尝试探索如何使用我们的工具。

这里唯一的提示是 "sksctl help"。

# 设置crontab

自动信息收集功能需要这个步骤。你只有在获取 root 之后才能启用这个功能。

在Linux中，程序`Cron`执行我们安排的命令。时间表被称为`crontab`。我们使用`crontab -e`来编辑我们的任务时间表。

在Termux中，我们需要手动安装它。它属于软件源`root-repo`。

```shell
apt install root-repo
apt update
apt install termux-service runit crontab
```

无需人工输入时间表。把预设的crontab复制到你的Cron配置目录。

```shell
cp $KDSY/crontab.rc $PREFIX/var/spool/cron/`whoami`。
```

最后，`crond`（crontab的守护进程）需要一点帮助才能启用。

```shell
sv-enable crond
```

# 帮助我们

我们的项目需要你的帮助! 如果你能为我们做这些事，我们会很感激你：

## 安装程序脚本测试

如果你有一个干净的Docker容器或一个备用的Android设备，你可以帮助我们测试我们的安装脚本。

## 为你的学校测试（如果需要，移植）它

如果你在 [此列表](http://www.skspruce.com.cn/news/10/) 中的学校上学，你可以测试 `sksctl` 是否在你学校的公共无线网络中工作。
如果它不能工作，但你有解决方案，欢迎新建你的分支并将我们的脚本移植到你的学校。这对你和你的同学，当然还有我们的项目，都是有益的。

通过DeepL翻译 https://www.deepl.com/app/?utm_source=android&utm_medium=app&utm_campaign=share-translation
