TARGET = riscv64-unknown-elf-
CC = $(RV_TOOLCHAIN_DIR)/$(TARGET)gcc
CFLAGS = -g -Wall -Wextra -O3 -ffreestanding

OBJ := format.o string.o

.PHONY: all
all: $(OBJ)

format.o: format.h string.h

string.o: string.h

.PHONY: clean
clean:
	rm -f *.o
