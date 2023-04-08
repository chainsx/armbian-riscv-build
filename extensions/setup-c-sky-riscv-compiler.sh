function fetch_compiler__setup-c-sky-riscv-compiler() {
	wget https://github.com/chainsx/armbian-d1-build/releases/download/toolchain/riscv64-linux-x86_64-20200528.tar.xz -O /opt/riscv64-gcc.tar.xz
  tar -xvf /opt/riscv64-gcc.tar.xz -C /opt
  mv /opt/riscv64-linux-x86_64-20200528 /opt/riscv64-compiler
}
