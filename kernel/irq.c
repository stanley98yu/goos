/* Currently only handles PLIC interrupts, specifically from UART */
#include <stdint.h>
#include "irq.h"
#include "qemu.h"
#include "uart.h"

uint32_t *plic_prio = (uint32_t *)(PLIC_BASE_ADDR);
uint32_t *plic_enable = (uint32_t *)(PLIC_BASE_ADDR+0x2000);
uint32_t *plic_thresh = (uint32_t *)(PLIC_BASE_ADDR+0x200000);
uint32_t *plic_cl = (uint32_t *)(PLIC_BASE_ADDR+0x200004);

void enable(int id)
{
	*plic_enable |= 1 << id;
}

/* Priority must be between 0 and 7 */
void set_prio(int id, uint8_t prio)
{
	*(plic_prio+id) = (prio&7);
}

void set_thresh(uint8_t thresh)
{
	*(plic_thresh) = (thresh&7);
}

/*
 * Claims the ID of the next available interrupt by highest prio. An ID of 0
 * means no interrupt is available to claim.
 */
int claim(void)
{
	return *(plic_cl);
}

void complete(int id)
{
	*(plic_cl) = id;
}

void handle_interrupt(void)
{
	int id;

	switch ((id = claim())) {
		/* UART device (pin 10) */
		case 10:
			interp(uart_getc());
			break;
		default:
			break;
	}
	complete(id);
}

void irq_init(void)
{
	set_thresh(0);
	enable(10);
	set_prio(10, 1);
}
