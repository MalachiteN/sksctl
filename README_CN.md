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
- [Termux:Boot](https://f-droid.org/en/packages/com.termux.boot)

第一个是本体，另外两个是插件。如果需要自动信息收集功能自启动，你就需要 `Termux:Boot` 。如果你想换更好看的终端字体、终端主题，或者你设备上 `Termux` 的字体非常诡异（通常是由于设备没有内置等宽字体，渲染器强行将非等宽字体拉伸成等宽导致的），你就需要 `Termux Styling` 。

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

# 用法

```shell
sksctl help
```

你可能对 Linux CLI 不熟悉。不要惊慌，冷静下来，并尝试探索如何使用我们的工具。

这里唯一的提示是 "sksctl help"。

# 设置crontab

自动信息收集功能需要这个步骤。

事实上，"crontab "和工作计划是在安装过程中设置的。然而，在Termux中，`crond`（crontab的守护进程）需要一点帮助才能启动。

当然，你可以手动启动`crond`，或者在登录时运行它（例如使用`.profile`）。但这并不是最好的方法。

不要忘了那个之前提到过的插件，`Termux:Boot`。一旦安装，它将在你的Android启动时按顺序运行`$HOME/.termux/boot/`中的一系列脚本。

```shell
mkdir -p ~/.termux/boot
echo -e 'termux-wake-lock\ncrond' > ~/.termux/boot/cron.sh
chmod +x ~/.termux/boot/cron.sh
```

# 帮助我们

我们的项目需要你的帮助! 如果你能为我们做这些事，我们会很感激你：

## 安装程序脚本测试

如果你有一个干净的Docker容器或一个备用的Android设备，你可以帮助我们测试我们的安装脚本。

## 为你的学校测试（如果需要，移植）它

如果你在 [此列表](http://www.skspruce.com.cn/news/10/) 中的学校上学，你可以测试 `sksctl` 是否在你学校的公共无线网络中工作。
如果它不能工作，但你有解决方案，欢迎新建你的分支并将我们的脚本移植到你的学校。这对你和你的同学，当然还有我们的项目，都是有益的。

通过DeepL翻译 https://www.deepl.com/app/?utm_source=android&utm_medium=app&utm_campaign=share-translation