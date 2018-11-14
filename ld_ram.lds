/* Linker script */
MEMORY {
	rom (rx) : ORIGIN = 0x08000000, LENGTH = 128K
	ram (!rx) : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS {
	.text : {
		*(.text)
	} > ram

	.data : {
		*(.data)
	} > ram

	.rodata : {
		*(.rodata)
	} > ram

	.bss : {
		_bss_start = . ;
		*(.bss) *(COMMON)
		_bss_end = . ;
	} > ram
}

ENTRY(_start)
_stack_top = ORIGIN(ram);
