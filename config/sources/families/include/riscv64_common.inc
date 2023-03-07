ARCH=riscv64
OPENSBI_COMPILE="yes"
INITRD_ARCH="riscv"
GOVERNOR="ondemand"
NAME_KERNEL="Image"
NAME_INITRD="uInitrd"
MAIN_CMDLINE="rw no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0"
KERNEL_IMAGE_TYPE=Image
SKIP_BOOTSPLASH="yes"
KERNELDIR="linux-riscv"
#UEFI_GRUB_TARGET="riscv64-efi"

family_tweaks() {

#	if [[ $BOARD == starfive ]]; then

		install -m 644 $SRC/packages/blobs/riscv64/10-hdmi.conf $SDCARD/etc/X11/xorg.conf.d/10-hdmi.conf

#	fi

}
