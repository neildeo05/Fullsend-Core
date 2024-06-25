/* Linker script for a memory with total size of 0x800 (2048) */
/* ROM is first half (0x0000 to 0x03FF) */
/* RAM is second half (0x0400 to 0x07FF) */

MEMORY
{
    ROM (rx) : ORIGIN = 0x0000, LENGTH = 0x0800
    RAM (rw) : ORIGIN = 0x0800, LENGTH = 0x0800
}

SECTIONS
{
    .text :
    {
        _stext = .;
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        _etext = .;
    } > ROM

    .data : AT (_etext)
    {
        _sdata = .;
        *(.data)
        *(.data.*)
        _edata = .;
    } > RAM

    .bss :
    {
        _sbss = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        _ebss = .;
    } > RAM

    /* Stack and heap can be defined if needed */
    /* _stack = ORIGIN(RAM) + LENGTH(RAM); */
    /* _heap = _ebss; */
}
