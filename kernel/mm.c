/* Memory management */
#include <stdint.h>
#include "string.h"

#define PAGE_SIZE    4096

extern const unsigned int __heap_size;
extern const unsigned int __heap_bottom;
uint64_t HEAP_SIZE = (uint64_t)&__heap_size;
uint64_t HEAP_BOTTOM = (uint64_t)&__heap_bottom;

struct page {
	uint8_t flags;        // LAST | EMPTY/TAKEN
};

struct free_page {
	struct free_page *next;
};

void mm_init()
{
	int num_pages = HEAP_SIZE / PAGE_SIZE;
	struct page *heapp = (struct page *)HEAP_BOTTOM;

	for (int i = 0; i < num_pages; i++) {
		memset(heapp, 0, sizeof(heapp));
	}
}

/**
 * Allocate pages
 *
 * @order: Power of two of number of pages to allocate
 *
 * Return: Pointer to allocated page or NULL on failure
 */
uint32_t alloc_pages(uint32_t order)
{
	return order;
}
