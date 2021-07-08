TARGET = riscv64-unknown-elf-
AS = $(RV_TOOLCHAIN_DIR)/$(TARGET)as
CC = $(RV_TOOLCHAIN_DIR)/$(TARGET)gcc
CFLAGS = -g -Wall -Wextra -O3 -ffreestanding -isysroot $(ROOT_DIR) -iquote =/lib

OBJ := boot.o irq.o main.o uart.o

.PHONY: all
all: $(OBJ)

boot.o:

irq.o: irq.h mmio.h uart.h

main.o: irq.h uart.h

uart.o: mmio.h uart.h

.PHONY: clean
clean:
	rm -f *.o
