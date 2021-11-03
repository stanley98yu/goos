Gamers Only OS (GOOS)
=====================

An operating system that targets [RISC-V][riscv], specifically QEMU's `virt`
board.

Steps
-----

1. Set up a GCC cross-compiler for RISC-V ELF/Newlib. See
[this][riscv-gnu-toolchain] for instructions.

2. Run `make`.

Dependencies
------------

- GCC 11.1.0
- GNU Binutils 2.37
- GNU gdb 10.1
- GNU Make 4.2.1
- QEMU 4.2.1

Linux Reference
---------------

See [this][deb-riscv-vm] for instructions on how to create a Debian disk image
for RISC-V and run it on QEMU using OpenSBI and U-Boot.

Resources
---------

The following were very useful resources and references:

Unofficial:

- [OS Dev Wiki][os-dev-wiki]
- [SOS][sos]: Targets ARMv7-A but was a useful reference when starting for basic
organization and build processes.
- [Stephen Marz's Blog][stephen-marz]: Lots of good explanations about RISC-V
arch/asm, even though I'm not using Rust.

Official:

- Linux
- [QEMU mirror][qemu-mirror]
- [RISC-V Specifications][riscv-specs]
- [SiFive FU540-C000 Manual][sifive-fu540-manual]: QEMU's VIRTIO board emulates
the same PLIC as the SiFive Freedom U540's. This was very helpful when
implementing interrupt handlers.

[deb-riscv-vm]: https://wiki.debian.org/RISC-V#Setting_up_a_riscv64_virtual_machine
[os-dev-wiki]: https://wiki.osdev.org/Main_Page
[qemu-mirror]: https://github.com/qemu/qemu
[riscv]: https://riscv.org/
[riscv-gnu-toolchain]: https://github.com/riscv/riscv-gnu-toolchain
[riscv-specs]: https://riscv.org/technical/specifications/
[sifive-fu540-manual]: https://sifive.cdn.prismic.io/sifive%2F834354f0-08e6-423c-bf1f-0cb58ef14061_fu540-c000-v1.0.pdf
[sos]: https://github.com/brenns10/sos
[stephen-marz]: https://osblog.stephenmarz.com/index.html
