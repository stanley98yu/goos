TARGET = riscv64-unknown-elf-
AS = $(RV_TOOLCHAIN_DIR)/$(TARGET)as
CC = $(RV_TOOLCHAIN_DIR)/$(TARGET)gcc
OBJDUMP = $(RV_TOOLCHAIN_DIR)/$(TARGET)objdump

CFLAGS = -g -Wall -Wextra -O3 -ffreestanding -isysroot $(ROOT_DIR) -iquote =/lib 
LDFLAGS = -nostdlib -lgcc -O3 -ffreestanding

LDLIBS =

QEMU = qemu-system-riscv64
QEMU_CMD = $(QEMU) -machine virt -m 1G -nographic \
	   -bios none
QEMU_DBGFLAGS = -gdb tcp::1234 -S

KERN_S := $(wildcard kernel/*.s)
KERN_C := $(wildcard kernel/*.c)
KERN_OBJ := $(KERN_C:%.c=%.o) $(KERN_S:%.s=%.o)
LIB_C := $(wildcard lib/*.c)
LIB_OBJ := $(LIB_C:%.c=%.o)

.PHONY: all 
all: __sub-make goos.elf goos.dump

goos.elf: $(KERN_OBJ) $(LIB_OBJ)
	$(CC) -T kernel/linker.ld -o $@ $^ $(LDFLAGS)

goos.dump: goos.elf
	$(OBJDUMP) -d $< > $@

.PHONY: __sub-make
__sub-make:
	$(MAKE) -C lib
	$(MAKE) -C kernel

.PHONY: run
run: goos.elf
	@$(QEMU_CMD) -kernel $<

.PHONY: debug
debug: goos.elf
	@echo "Now run GDB in another terminal and connect to localhost:1234."
	@echo "Exit QEMU by pressing 'Ctrl+a' then 'x'."
	@echo "====="
	$(QEMU_CMD) $(QEMU_DBGFLAGS) -kernel $<

.PHONY: gdb
gdb: goos.elf
	$(RV_TOOLCHAIN_DIR)/$(TARGET)gdb --tui $<

.PHONY: clean
clean:
	rm -f lib/*.o
	rm -f kernel/*.o
	rm -f *.elf *.dump
