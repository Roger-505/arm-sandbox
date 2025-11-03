ENTRY(_start)

/* Memory region constants */
ROM_BASE  = 0x0000000040080000;
ROM_SIZE  = 32K;
RAM_SIZE  = ROM_SIZE;
RAM_BASE  = ROM_BASE + ROM_SIZE;

MEMORY
{
    ROM (rx!w) : ORIGIN = ROM_BASE, LENGTH = ROM_SIZE
    RAM (rw!x) : ORIGIN = RAM_BASE, LENGTH = RAM_SIZE
}

SECTIONS
{
    .text : 
    {
        start.o
        *(.text*)
        _etext = .;
        . = ALIGN(16);
    } > ROM
    .data : AT(ADDR(.text) + SIZEOF(.text))
    {
        . = ALIGN(16);
        _data = .;
        *(.data .data.*) 
	    *(.rodata .rodata.*)
        _edata = .;
    } > RAM
    .bss SIZEOF(.data) + ADDR(.data) (NOLOAD): 
    {
        . = ALIGN(16);
        _bss = .; 
        *(.bss) 
        *(COMMON)
        _ebss = .;
    } > RAM
    
    .stack (NOLOAD):
    {
        . = ALIGN(16);
        stack_bottom = .;
        stack_top = ORIGIN(RAM) + LENGTH(RAM);  /* stack_top at the top of RAM */
    } > RAM
    _data_load_start = LOADADDR(.data);
    _data_load_end   = _data_load_start + SIZEOF(.data);
}
