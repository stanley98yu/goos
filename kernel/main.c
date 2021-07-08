#include "format.h"
#include "irq.h"
#include "uart.h"

/* Temporary print function for registers */
void print_reg(char *name, int reg)
{
	char buf[256];

	uart_puts(name);
	uart_puts(": ");
	itoa(reg, buf, 16);
	uart_puts(buf);
	uart_puts("\n");
}

int main(void)
{
	int misa, mvendorid, marchid, mimpid, mhartid;

	irq_init();
	uart_init();

	asm volatile ("csrr %0, misa" : "=r" (misa));
	asm volatile ("csrr %0, mvendorid" : "=r" (mvendorid));
	asm volatile ("csrr %0, marchid" : "=r" (marchid));
	asm volatile ("csrr %0, mimpid" : "=r" (mimpid));
	asm volatile ("csrr %0, mhartid" : "=r" (mhartid));
	print_reg("misa", misa);
	print_reg("mvendorid", mvendorid);
	print_reg("marchid", marchid);
	print_reg("mimpid", mimpid);
	print_reg("mhartid", mhartid);
	uart_puts("==============================\n");

	uart_puts("Hello gamers! Move using WASD.\n");
	return 0;
}
