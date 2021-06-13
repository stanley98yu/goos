TARGET=riscv64-unknown-elf-
AS=$(RV_TOOLCHAIN_DIR)/$(TARGET)as
CC=$(RV_TOOLCHAIN_DIR)/$(TARGET)gcc
OBJDUMP=$(RV_TOOLCHAIN_DIR)/$(TARGET)objdump

CFLAGS=-ffreestanding -O0 -Wall -Wextra -g    # Remove -g if not debug
LDFLAGS=-ffreestanding -O0 -nostdlib -lgcc

QEMU=qemu-system-riscv64
QEMU_CMD=$(QEMU) -machine virt -m 1G -nographic
QEMU_DBGFLAGS=-gdb tcp::1234 -S

KERN_DIR=kernel
KERN_S:=$(wildcard $(KERN_DIR)/*.s)
KERN_C:=$(wildcard $(KERN_DIR)/*.c)
KERN_OBJ:=$(KERN_C:%.c=%.o) $(KERN_S:%.s=%.o)

.PHONY: all 
all: $(KERN_DIR) goos.elf goos.dump

goos.elf: $(KERN_OBJ)
	$(CC) -T $(KERN_DIR)/linker.ld -o $@ $^ $(LDFLAGS)

goos.dump: goos.elf
	$(OBJDUMP) -d $< > $@

.PHONY: $(KERN_DIR)
$(KERN_DIR):
	$(MAKE) -C $@

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
	rm -f $(KERN_DIR)/*.o
	rm -f *.elf *.dump
