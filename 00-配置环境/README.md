*你可能需要提前用谷歌搜索的概念：Linux、Mac、终端、编译器、模拟器、nasm、qemu*

**目标：安装运行本教程所需的软件**

我使用的是Mac，不过Linux更好，因为它已经为你准备好了所有标准工具。

在Mac上，[安装Homebrew](http://brew.sh)，然后执行 `brew install qemu nasm`

不要使用Xcode开发工具中的 `nasm`（如果你已安装），它们在大多数情况下无法正常工作。请始终使用 `/usr/local/bin/nasm`

在某些系统上，qemu会被拆分为多个二进制文件。你可能需要执行 `qemu-system-x86_64 binfile`
