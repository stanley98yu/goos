/* 16550a UART driver */
#include <stdint.h>
#include "qemu.h"
#include "uart.h"

volatile uint8_t *base = (uint8_t *)UART_BASE_ADDR;
volatile uint8_t *ier = (uint8_t *)(UART_BASE_ADDR+1); // Interrupt enable reg
volatile uint8_t *fcr = (uint8_t *)(UART_BASE_ADDR+2); // FIFO control reg
volatile uint8_t *lcr = (uint8_t *)(UART_BASE_ADDR+3); // Line control reg
volatile uint8_t *lsr = (uint8_t *)(UART_BASE_ADDR+5); // Line status reg

void uart_putc(char c)
{
	*base = (uint8_t)c;
}

void uart_puts(char *s)
{
	while (*s != '\0') {
		uart_putc(*(s++));
	}
}

int uart_getc(void)
{
	if (*lsr & 1) {
		return (int)*base;
	}
	return -1;
}

void interp(char c)
{
	switch (c) {
		case 'w':
			uart_puts("Up!\n");
			break;
		case 'a':
			uart_puts("Left!\n");
			break;
		case 's':
			uart_puts("Down!\n");
			break;
		case 'd':
			uart_puts("Right!\n");
			break;
		default:
			break;
	}
}

/* Initialization steps necessary for enabling interrupts from the UART */
void uart_init(void)
{
	/* Set word length to 8 bits, enable FIFO, and enable receiver interrupts */
	*lcr |= 3;
	*fcr |= 1;
	*ier |= 1;
}
