# LicheePi 4A 安装方法

## 1.  下载对应仓库的系统和 u-boot 文件

### Armbian:

1.  到本项目 [Release](https://github.com/chainsx/armbian-riscv-build/releases) 下载适用于 LicheePi 4A 的系统，可以选择 Debian 或 Ubuntu。
2.  到 [chainsx/thead-u-boot Actions](https://github.com/chainsx/thead-u-boot/actions) 或者其他使用该源码仓库的项目例如 [chainsx/fedora-riscv-builder](https://github.com/chainsx/fedora-riscv-builder/releases) 下载适用于对应内存版本 LicheePi 4A 引导 SD 卡镜像的 u-boot.

### 其他使用 https://github.com/chainsx/thead-u-boot 的系统都是按照以下方式进行刷写

## 2.  刷写 u-boot 到 EMMC （必须）

按住板子上的 BOOT 键，使用数据线将 lpi4a 与电脑相连，然后进行以下操作。

```
sudo ./fastboot flash ram ./images/u-boot-with-spl.bin
sudo ./fastboot reboot
sleep 10
sudo ./fastboot flash uboot ./images/u-boot-with-spl.bin
```

*注意，本项目提供的 u-boot 不会修改分区表*

安装驱动等参考[官方Wiki](https://wiki.sipeed.com/hardware/zh/lichee/th1520/lpi4a/4_burn_image.html)

## 3.  刷写系统

### 方式一：刷写系统到 SD 卡

这个不用我说了吧

### 方式二：刷写系统到 EMMC

(1)  使用 u-boot 的 UMS（USB Mass Storage）功能（实验性）：
    
    有拨码开关的请设置为 EMMC 模式。
    
    使用串口在 u-boot 倒计时读秒时使用 `Ctrl^C` 中断以进入 u-boot 命令行，然后输入以下指令：
    ```
    ums 0 mmc 0
    ```
    然后 EMMC 将会以 USB Mass Storage 设备映射在电脑上。
    
    自动进入 ums 功能正在开发，有兴趣的可以一起帮忙开发（超小声）：https://github.com/chainsx/thead-u-boot/tree/emmc-flasher
    
(2)  使用 SD 卡启动之后将 img 镜像 `dd` 到 EMMC 中。

## 需要注意的事

1.  遇到问题发 issue，系统稳定性与 Sipeed 无关。
2.  对于 u-boot 的修改是本人进行支持的，不兼容官方系统（当然我也在修改以想办法与达成官方统一），使用本系统产生的问题请发在 issue 里，系统稳定性与 Sipeed 无关，需要稳定系统请使用官方系统。
3.  本系统仅作为想自定义系统的用户使用，请勿使用本系统进行任何硬件测试并公开测试报告，系统稳定性与 Sipeed 无关。

## u-boot 系统选择顺序

SD 优先于 EMMC

## Armbian 支持情况

GPU: Work In Progress.

风扇：支持

桌面：在没有 GPU 驱动的情况下使用 xfce 桌面，Ubuntu 20.04 能流畅使用，Ubuntu 22.04 有明显卡顿情况。

[Armbian 官方构建框架](https://github.com/armbian/build)支持：已经提交到官方仓库，但是是不可能使用优化编译工具链的，，，

[Armbian 官方构建框架](https://github.com/armbian/build)预构建版本：[由 GitHub Action 自动构建](https://github.com/chainsx/image-armbian-licheepi-4a/releases)

## 我想给 Armbian 官方构建仓库提 PR

欢迎向 [Armbian 官方构建仓库](https://github.com/armbian/build)提交 PR，如果是关于 LicheePi 4A 的，请在 reviewers 选择 `chainsx`，并及时通知我。
