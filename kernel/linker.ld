OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
	ram (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
	.text :
	{
		*(.text.init) *(.text)
	} > ram
	PROVIDE(__global_pointer$ = .);

	.rodata :
	{
		*(.rodata)
	} > ram

	.data :
	{
		*(.data)
	} > ram

	.bss :
	{
		PROVIDE(__bss_start = .);
		*(.bss)
		PROVIDE(__bss_end = .);
	} > ram

	PROVIDE(__heap_bottom = __bss_end);
	/* 512 KiB stack */
	PROVIDE(__stack_bottom = ORIGIN(ram) + LENGTH(ram));
	PROVIDE(__stack_top = __stack_bottom - 0x80000);
	PROVIDE(__heap_size = __stack_top - __heap_bottom);
}
