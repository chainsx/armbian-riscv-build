# LicheePi 4A 安装方法

## 支持情况

GPU: 等官方

风扇：支持

桌面：在没有 GPU 驱动的情况下使用 xfce 桌面，Ubuntu 20.04 能流畅使用，Ubuntu 22.04 有明显卡顿情况。

## 下载系统和 u-boot 文件

1.  到本项目 [Release](https://github.com/chainsx/armbian-riscv-build/releases) 下载适用于 LicheePi 4A 的系统，可以选择 Debian 或 Ubuntu。
2.  到本项目 [Release](https://github.com/chainsx/armbian-riscv-build/releases) 下载适用于 LicheePi 4A 引导 SD 卡镜像的 u-boot：u-boot-with-spl.bin

## 刷写 u-boot 到 EMMC

参考[官方Wiki](https://wiki.sipeed.com/hardware/zh/lichee/th1520/lpi4a/4_burn_image.html)

按住板子上的 BOOT 键，使用数据线将 lpi4a 与电脑相连，然后进行以下操作。


```
sudo ./fastboot flash ram ./images/u-boot-with-spl.bin
sudo ./fastboot reboot
sleep 10
sudo ./fastboot flash uboot ./images/u-boot-with-spl.bin
```

*注意，本项目提供的 u-boot 不会修改分区表*

## 刷写系统到 SD 卡

这个不用我说了吧

## 刷写系统到 EMMC

1.  使用 u-boot 的 UMS（USB Mass Storage）功能（实验性）：
    
    有拨码开关的请设置为 EMMC 模式。
    
    使用串口在 u-boot 倒计时读秒时使用 `Ctrl^C` 中断以进入 u-boot 命令行，然后输入以下指令：
    ```
    ums 0 emmc 0
    ```
    然后 EMMC 将会以 USB Mass Storage 设备映射在电脑上。
    
    自动进入 ums 功能正在开发，有兴趣的可以一起帮忙开发：https://github.com/chainsx/thead-u-boot/tree/emmc-flasher
    
2.  使用 SD 卡启动之后将 img 镜像 dd 到 EMMC 中。

## 需要注意的事

1.  目前系统正在完善，遇到问题可以发 issue。
2.  对于 u-boot 的修改是本人进行支持的，不兼容官方系统（当然我也在修改以想办法与达成官方统一），使用本系统产生的问题请发在 issue 里，系统稳定性与 Sipeed 无关，需要稳定系统请使用官方系统。
3.  本系统仅作为想自定义系统的用户使用，请勿使用本系统进行任何硬件测试并公开测试报告。

## u-boot 系统选择顺序

SD 优先于 EMMC
