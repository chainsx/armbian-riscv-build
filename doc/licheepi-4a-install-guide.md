# LicheePi 4A 安装方法

## 支持情况

GPU: 等官方

风扇：支持

桌面：待测试

## 下载系统和 u-boot 文件

1.  到本项目 [Release](https://github.com/chainsx/armbian-riscv-build/releases) 下载适用于 LicheePi 4A 的系统，可以选择 Debian 或 Ubuntu。
2.  到本项目 [Release](https://github.com/chainsx/armbian-riscv-build/releases) 下载适用于 LicheePi 4A 引导 SD 卡镜像的 u-boot：u-boot-with-spl.bin

## 刷写 u-boot 到 EMMC

参考[官方Wiki](https://wiki.sipeed.com/hardware/zh/lichee/th1520/lpi4a/4_burn_image.html)

```
sudo ./fastboot flash ram ./images/u-boot-with-spl.bin
sudo ./fastboot reboot
sleep 10
sudo ./fastboot flash uboot ./images/u-boot-with-spl.bin
```

*注意，本项目提供的 u-boot 不会修改分区表*

## 刷写系统到 SD 卡

这个不用我说了吧

## 需要注意的事

1.  目前系统支持正在做，遇到问题可以发 issue。
2.  对于 u-boot 的修改只是将 cmdline 从官方 u-boot 里剥离出来以 u-boot env 的格式放在 /boot/config.txt 里，受支持的 u-boot env 可以添加进去。

## 如何使用 EMMC 中的官方系统

本项目提供的 u-boot 支持引导官方系统，将 SD 卡中的 /boot/config.txt 复制到 EMMC 的 boot 分区（第二分区），修改 `root=` 这项参数为 `mmcblk0p3`，关机，拔掉 SD 卡之后启动。

## u-boot 系统选择顺序

SD 优先于 EMMC
