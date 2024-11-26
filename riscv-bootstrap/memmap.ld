
    /* NOTE: in original linker script
     * TODO: look up what these are used for again...
     *
        SCRATCH_X(rwx) : ORIGIN = 0x20080000, LENGTH = 4k
        SCRATCH_Y(rwx) : ORIGIN = 0x20081000, LENGTH = 4k
    */

MEMORY
{
    FLASH(rx) : ORIGIN = 0x10000000, LENGTH = 16M
    RAM(rwx) : ORIGIN = 0x20000000, LENGTH = 512k
}

ENTRY(_entry_point)

SECTIONS
{
    .vectors : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        *(.vectors)
    } > FLASH

    .binary_info_header : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        *(.binary_info_header)
    } > FLASH

    .text : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        KEEP (*(.vectors)) /* Ensure .vectors section is preserved */
        KEEP (*(.binary_info_header)) /* Ensure .binary_info_header is preserved */
        __text_start = .;
        *(.text)
        __text_end = .;
    } > FLASH

    .data : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        __data_start = .;
        *(.data)
        __data_end = .;
    } > RAM AT > FLASH

    .rodata : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        __rodata_start = .;
        *(.rodata)
        __rodata_end = .;
    } > FLASH

    .bss (NOLOAD) : {
        . = ALIGN(4); /* Manually align to 4 bytes */
        __bss_start = .;
        *(.bss)
        __bss_end = .;
    } > RAM

    .stack (NOLOAD) :
    {
        . = ALIGN(4); /* Manually align to 4 bytes */
        __stack_start = .;
        __stack_size = 0x2000;
        . += __stack_size;
        __stack_end = .;
    } > RAM
}

