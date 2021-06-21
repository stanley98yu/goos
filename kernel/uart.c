/* NS16550A UART driver */
#include "uart.h"

#define UART_BASE_ADDR    0x10000000

char *base = (char *)UART_BASE_ADDR;
char *ier = (char *)(UART_BASE_ADDR+1);    // Interrupt enable register
char *fcr = (char *)(UART_BASE_ADDR+2);    // FIFO control register
char *lcr = (char *)(UART_BASE_ADDR+3);    // Line control register
char *lsr = (char *)(UART_BASE_ADDR+5);    // Line status register

void uart_putc(char c)
{
	*base = c;
}

void uart_puts(char *s)
{
	while (*s != '\0') {
		uart_putc(*(s++));
	}
}

int uart_getc()
{
	if (*lsr & 1) {
		return *base;
	}
	return -1;
}

/* Initialization steps necessary for enabling interrupts from the UART */
void uart_init()
{
	// Set word length to 8 bits, enable FIFO, and enable receiver interrupts
	*lcr |= 3;
	*fcr |= 1;
	*ier |= 1;;
}
