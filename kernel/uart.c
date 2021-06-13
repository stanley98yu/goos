/* UART driver */
#include "uart.h"

#define UART_ADDR    0x10000000

volatile unsigned int *uartp = (unsigned int *)UART_ADDR;

void print_uart(char *s)
{
	while (*s != '\0') {
		*uartp = (unsigned int)(*s);
		s++;
	}
}

int uart_init()
{
	print_uart("Hello gamers!\n");
	return 0;
}
