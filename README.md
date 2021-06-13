Gamers Only OS (GOOS)
=====================

An operating system that targets RISC-V architecture.

Steps
-----

1. Set up a GCC cross-compiler for RISC-V ELF/Newlib. See
[this][riscv-gnu-toolchain] for instructions.

2. Set your environment prefix to point to your cross-compiler.

3. Run `make`.

Dependencies
------------

- GCC 10.2.0
- GNU Binutils 2.36.1
- GNU Make 4.2.1
- QEMU 4.2.1

Linux Reference
---------------

See [this][deb-riscv-vm] for instructions on how to create a Debian disk image
for RISC-V and run it on QEMU using OpenSBI and U-Boot.

[deb-riscv-vm]: https://wiki.debian.org/RISC-V#Setting_up_a_riscv64_virtual_machine
[riscv-gnu-toolchain]: https://github.com/riscv/riscv-gnu-toolchain
