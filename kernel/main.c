#include "uart.h"

void read_input() {
	char c;

	while ((c = uart_getc())) {
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
}

int main()
{
	uart_init();
	uart_puts("Hello gamers! Move using WASD.\n");
	read_input();

	return 0;
}
