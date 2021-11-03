.PHONY: all
all: $(KERN_OBJ:kernel/%=%)

boot.o:

irq.o: irq.h qemu.h uart.h

main.o: irq.h uart.h

uart.o: qemu.h uart.h
