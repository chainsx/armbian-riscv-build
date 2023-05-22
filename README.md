## 开始

### 目前支持的开发板

#### Thead TH1520

1.  [LicheePi-4A （8+8 内测版）](./doc/licheepi-4a-install-guide.md)

#### Allwinner D1

1.  MangpoPi-MQ-Pro

2.  Lichee RV Dock

3.  Dongshan Nezha Stu

4.  Nezha

### 预构建版本下载

|  |  |  |
| :----- | :----- | :----- |
| LicheePi 4A | U-Boot  | [下载链接](https://github.com/chainsx/armbian-riscv-build/releases/download/20230522-0600/u-boot-with-spl.bin) |
| LicheePi 4A | Ubuntu 20.04 xfce  | [下载链接](https://github.com/chainsx/armbian-riscv-build/releases/download/20230522-0600/Armbian_23.05.15-riscv_Licheepi-4a_focal_current_5.10.113_xfce_desktop.img.xz) |
| LicheePi 4A | Ubuntu 22.04 server | [下载链接](https://github.com/chainsx/armbian-riscv-build/releases/download/20230522-0600/Armbian_23.05.15-riscv_Licheepi-4a_jammy_current_5.10.113.img.xz) |
| LicheePi 4A | Debian 12 server | [下载链接](https://github.com/chainsx/armbian-riscv-build/releases/download/20230522-0600/Armbian_23.05.15-riscv_Licheepi-4a_sid_current_5.10.113.img.xz) |
| MangoPi-MQ-Pro | Ubuntu 22.04 server | [下载链接](https://github.com/chainsx/armbian-riscv-build/releases/download/20230522-0600/Armbian_23.05.15-riscv_Mangopi-mq-pro_jammy_current_5.19.17.img.xz) |

### 环境准备

- x64 内存不少于 2GB 和磁盘空间不少于 35GB 的 x64 主机或虚拟机，
- Ubuntu Jammy 22.04 x64 或者使用 [Docker](https://docs.armbian.com/Developer-Guide_Building-with-Docker/)，
- 具有 root 权限（能通过 sudo 认证的用户或者直接使用 root 用户运行）。

### 如何使用脚本

```bash
apt-get -y install git
git clone https://github.com/chainsx/armbian-riscv-build
cd build
./compile.sh
```

### 构建参数举例

以交互模式显示正在进行的工作：

```bash
./compile.sh EXPERT="yes"
```

在 Docker 容器里运行脚本：

```bash
./compile.sh docker
```

压缩后的 Mangpi-MQ-Pro 构建命令如下：

```
        ./compile.sh \
        BOARD=mangopi-mq-pro \
        BRANCH=current \
        RELEASE=jammy \
        BUILD_MINIMAL=yes \
        BUILD_DESKTOP=no \
        KERNEL_ONLY=no \
        KERNEL_CONFIGURE=no \
        EXPERT=yes \
        COMPRESS_OUTPUTIMAGE=sha,gpg,xz
```

压缩后的 LicheePi-4A 构建命令如下：

```
        ./compile.sh
        BOARD=licheepi-4a
        BRANCH=current
        RELEASE=jammy
        BUILD_MINIMAL=yes
        BUILD_DESKTOP=no
        KERNEL_ONLY=no
        KERNEL_CONFIGURE=no
        COMPRESS_OUTPUTIMAGE=sha,gpg,xz
```

[构建参数，高级构建选项，用户自定义配置，使用 Docker 构建？](https://docs.armbian.com/Developer-Guide_Build-Preparation/)

## 项目结构

```text
├── cache                                Work / cache directory
│   ├── rootfs                           Compressed vanilla Debian and Ubuntu rootfilesystem cache
│   ├── sources                          Kernel, u-boot and various drivers sources. Mainly C code
│   ├── toolchains                       External cross compilers from Linaro™ or ARM™
├── config                               Packages repository configurations
│   ├── targets.conf                     Board build target configuration
│   ├── boards                           Board configurations
│   ├── bootenv                          Initial boot loaders environments per family
│   ├── bootscripts                      Initial Boot loaders scripts per family
│   ├── cli                              CLI packages configurations per distribution
│   ├── desktop                          Desktop packages configurations per distribution
│   ├── distributions                    Distributions settings
│   ├── kernel                           Kernel build configurations per family
│   ├── sources                          Kernel and u-boot sources locations and scripts
│   ├── templates                        User configuration templates which populate userpatches
│   └── torrents                         External compiler and rootfs cache torrents
├── extensions                           extend build system with specific functionality
├── lib                                  Main build framework libraries
├── output                               Build artifact
│   └── deb                              Deb packages
│   └── images                           Bootable images - RAW or compressed
│   └── debug                            Patch and build logs
│   └── config                           Kernel configuration export location
│   └── patch                            Created patches location
├── packages                             Support scripts, binary blobs, packages
│   ├── blobs                            Wallpapers, various configs, closed source bootloaders
│   ├── bsp-cli                          Automatically added to armbian-bsp-cli package 
│   ├── bsp-desktop                      Automatically added to armbian-bsp-desktopo package
│   ├── bsp                              Scripts and configs overlay for rootfs
│   └── extras-buildpkgs                 Optional compilation and packaging engine
├── patch                                Collection of patches
│   ├── atf                              ARM trusted firmware
│   ├── kernel                           Linux kernel patches
|   |   └── family-branch                Per kernel family and branch
│   ├── misc                             Linux kernel packaging patches
│   └── u-boot                           Universal boot loader patches
├── tools                                Tools for dealing with kernel patches and configs
└── userpatches                          User: configuration patching area
    ├── lib.config                       User: framework common config/override file
    ├── config-default.conf              User: default user config file
    ├── customize-image.sh               User: script will execute just before closing the image
    ├── atf                              User: ARM trusted firmware
    ├── kernel                           User: Linux kernel per kernel family
    ├── misc                             User: various
    └── u-boot                           User: universal boot loader patches
```

## 开放源代码许可

This software is published under the GPL-2.0 License license.
