TARGET = riscv64-unknown-elf-

AS = $(TARGET)as
CC = $(TARGET)gcc
LD = $(TARGET)ld
OBJDUMP = $(TARGET)objdump

CFLAGS = -g -ffreestanding --sysroot=$(CURDIR) -I =/lib \
	 -Wall -Wextra -O2 -std=gnu17
LDFLAGS = -nostdlib

SUBDIRS := lib kernel
VPATH = $(SUBDIRS)
LIB_C := $(wildcard lib/*.c)
LIB_OBJ := $(LIB_C:.c=.o)
KERN_S := $(wildcard kernel/*.s)
KERN_C := $(wildcard kernel/*.c)
KERN_OBJ := $(KERN_C:.c=.o) $(KERN_S:.s=.o)
OBJ := $(LIB_OBJ) $(KERN_OBJ)

export AS CC CFLAGS LIB_OBJ KERN_OBJ

QEMU = qemu-system-riscv64
QEMU_CMD = $(QEMU) -M virt -m 1G -nographic \
	   -bios none
QEMU_DBG = -gdb tcp::1234 -S

.PHONY: all
all: __sub-make goos.elf goos.dump

goos.elf: $(OBJ)
	$(LD) -T kernel/linker.ld -o $@ $^ $(LDFLAGS)

goos.dump: goos.elf
	$(OBJDUMP) -d $< > $@

.PHONY: __sub-make $(SUBDIRS)
__sub-make: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: run
run: goos.elf
	@$(QEMU_CMD) -kernel $<

.PHONY: debug
debug: goos.elf
	@echo "Now run GDB in another terminal and connect to localhost:1234."
	@echo "Exit QEMU by pressing 'Ctrl+a' then 'x'."
	@echo "=============================="
	$(QEMU_CMD) $(QEMU_DBG) -kernel $<

.PHONY: gdb
gdb: goos.elf
	$(TARGET)gdb --tui $<

.PHONY: clean
clean:
	-rm -f $(OBJ) *.elf *.dump
