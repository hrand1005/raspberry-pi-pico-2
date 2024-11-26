/* --- .vectors section --- */
.section .vectors, "ax"
.p2align 6
.global _entry_point
_entry_point:
    ebreak
    mv a0, a0
    j _entry_point

.global main
main:
    ebreak
    j main

/* --- .binary_info_header */
.p2align 6
.section .binary_info_header, "a"
.word 0xffffded3
.word 0x11010142
.word 0x000001ff
.word 0x00000000
.word 0xab123579


dead:
    ebreak
