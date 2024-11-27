/**
 * This entry point will be located at the binary's the lowest address.
 * It is the first thing the bootrom will execute after interpreting the
 * metadata in the binary info header section.
 */
.section .reset, "ax"
.global _entry_point
_entry_point:
    j _reset_handler

_reset_handler:
    ebreak
    j _reset_handler

/**
 * Note that in X mode, the vector table must be 64 byte aligned.
 * See rp2350 datasheet section 3.8.4.2.1
 * See riscv-privileged-20211203 section 3.1.7
 */
.section .vectors, "ax"
.p2align 6
       /** TODO: implement the riscv vector table */
       
/**
 * This is the initial IMAGE_DEF item.
 * See rp2350 datasheet section 5.9.3.1 (IMAGE_DEF)
 * See rp2350 datasheet section 5.9.5.2 (Minimum Viable Image Definition)
 *
 * There is additional startup configuration that could be encoded here.
 * Instead, with this minimal configuration, the bootrom simply starts
 * executing at the lowest address (0x10000000), where we have defined
 * our entry point.
 *
 * Note that this must be found in the first 4 KB of flash.
 */
.section .image_def, "a"
.word 0xffffded3
.word 0x11010142
.word 0x000001ff
.word 0x00000000
.word 0xab123579
