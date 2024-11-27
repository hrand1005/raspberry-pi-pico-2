/**
 * Minimal linker script.
 * Defines the following:
 *
 *  __text_start
 *  __text_end
 *  __image_def_start
 *  __image_def_end
 *  __data_load_start
 *  __data_start
 *  __data_end
 *  __rodata_start
 *  __rodata_end
 *  __bss_start
 *  __bss_end
 *  __stack0_limit
 *  __stack0_base
 *  __stack1_limit
 *  __stack1_base
 *
 */

MEMORY
{
    FLASH(rx) : ORIGIN = 0x10000000, LENGTH = 16M
    RAM(rwx) : ORIGIN = 0x20000000, LENGTH = 512k
}

ENTRY(_entry_point)

SECTIONS
{
    .text : {
        /* reset section contains _entry_point */
        KEEP (*(.reset))
        KEEP (*(.vectors))
        __image_def_start = .;
        KEEP (*(.image_def))
        __image_def_end = .;
        __text_start = .;
        *(.text)
        __text_end = .;
    } > FLASH

    .data : {
        . = ALIGN(4);
        __data_load_start = LOADADDR(.data);
        __data_start = .;
        *(.data)
        __data_end = .;
    } > RAM AT > FLASH

    .rodata : {
        . = ALIGN(4);
        __rodata_start = .;
        *(.rodata)
        __rodata_end = .;
    } > FLASH

    .bss (NOLOAD) : {
        . = ALIGN(4);
        __bss_start = .;
        *(.bss)
        __bss_end = .;
    } > RAM

    /* core 0 */
    __stack0_size = 0x2000;
    .stack0 (NOLOAD) :
    {
        . = ALIGN(4);
        __stack0_limit = .;
        . += __stack0_size;
        __stack0_base = .;
    } > RAM


    /* core 1 */
    __stack1_size = 0x2000;
    .stack1 (NOLOAD) :
    {
        . = ALIGN(4);
        __stack1_limit = .;
        . += __stack1_size;
        __stack1_base = .;
    } > RAM
}

