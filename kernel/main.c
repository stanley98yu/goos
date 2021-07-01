#include "irq.h"
#include "uart.h"

int main(void)
{
	irq_init();
	uart_init();

	uart_puts("Hello gamers! Move using WASD.\n");
	return 0;
}
