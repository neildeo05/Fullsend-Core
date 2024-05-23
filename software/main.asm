.global _boot
.text

_boot:                    /* x0  = 0    0x000 */
    /* Test ADDI */
    addi x6, x0, 6
    addi x7, x0, 7
    addi x1 , x0,   -1000  /* x1  = 1000 0x3E8 */
    nop
    nop
    nop
    nop
    add x5, x6, x7
    sub x8, x6, x7
    lw  x2, 1(x0) /* x2 <- mem[1] */ 
    nop
    nop
    nop
    nop
    add x4, x2, x6
    nop
    nop
    nop
    nop
    nop
    add x4, x4, x7 
    nop
    nop
    nop
    nop
