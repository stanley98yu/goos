TARGET=riscv64-unknown-elf-
AS=$(RV_TOOLCHAIN_DIR)/$(TARGET)as
CC=$(RV_TOOLCHAIN_DIR)/$(TARGET)gcc
CFLAGS=-ffreestanding -O0 -Wall -Wextra -g    # Remove -g if not debug

OBJ:=boot.o main.o uart.o

.PHONY: all
all: $(OBJ)

main.o: uart.h

uart.o: uart.h

.PHONY: clean
clean:
	rm -f *.o
