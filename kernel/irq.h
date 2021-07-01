#include <stdint.h>

void enable(int id);
void set_prio(int id, uint8_t prio);
void set_thresh(uint8_t thresh);
int claim(void);
void complete(int id);
void handle_interrupt(void);
void irq_init(void);
