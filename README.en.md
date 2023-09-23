## Getting started

### Prepare your environment

- x64 machine with at least 2GB of memory and ~35GB of disk space for a VM, container or native OS,
- Ubuntu Jammy 22.04 x64 or for native building or any [Docker](https://docs.armbian.com/Developer-Guide_Building-with-Docker/) capable x64 Linux for containerised,
- Superuser rights (configured sudo or root access).

### Simply start with the build script

```bash
apt-get -y install git
git clone https://github.com/chainsx/armbian-d1-build
cd build
./compile.sh
```

<a href="#how-to-build-an-image-or-a-kernel"><img src=".github/README.gif" alt="Armbian logo" width="100%"></a>

- Interactive graphical interface.
- The workspace will be prepared by installing the necessary dependencies and sources.
- It guides the entire process until a kernel package or ready-to-use image of the SD card is created.

### Build parameter examples

Show work in progress areas in interactive mode:

```bash
./compile.sh EXPERT="yes"
```

Run build framework inside Docker container:

```bash
./compile.sh docker
```

Build minimal CLI Armbian Focal image for Orangepi Zero. Use modern kernel and write image to the SD card:

```bash
./compile.sh \
BOARD=orangepizero \
BRANCH=current \
RELEASE=focal \
BUILD_MINIMAL=yes \
BUILD_DESKTOP=no \
KERNEL_ONLY=no \
KERNEL_CONFIGURE=no \
CARD_DEVICE="/dev/sda"
```

[Build parameters, advanced build options, user defined configuration, build with Docker?](https://docs.armbian.com/Developer-Guide_Build-Preparation/)

## Compare with industry standards

Check similarity, advantages and disadvantages compared with leading industry standard build software.

Function | Armbian | Yocto | Buildroot |
|:--|:--|:--|:--|
| Target | general purpose | embedded | embedded / IOT |
| U-boot and kernel | compiled from sources | compiled from sources | compiled from sources |
| Board support maintenance &nbsp; | complete | outside | outside |
| Root file system | Debian or Ubuntu based| custom | custom |
| Package manager | APT | any | none |
| Configurability | limited | large | large |
| Initramfs support | yes | yes | yes |
| Getting started | quick | very slow | slow |
| Cross compilation | yes | yes | yes |

## Project structure

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
│   ├── kernel                           Linux kernel patches
|   |   └── family-branch                Per kernel family and branch
│   ├── misc                             Linux kernel packaging patches
│   └── u-boot                           Universal boot loader patches
|       ├── u-boot-board                 For specific board
|       └── u-boot-family                For entire kernel family
├── tools                                Tools for dealing with kernel patches and configs
└── userpatches                          User: configuration patching area
    ├── lib.config                       User: framework common config/override file
    ├── config-default.conf              User: default user config file
    ├── customize-image.sh               User: script will execute just before closing the image
    ├── kernel                           User: Linux kernel per kernel family
    ├── misc                             User: various
    └── u-boot                           User: universal boot loader patches
```

## License

This software is published under the GPL-2.0 License license.
