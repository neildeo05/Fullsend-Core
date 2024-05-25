.global _boot
.text

_boot:                    /* x0  = 0    0x000 */
   lw x1, 5(x0)
   lw x2, 5(x0)
   add x3, x1, x2
   


/* Forwarding Example 1 
    addi x6, x0, 6
    addi x7, x6, 1 */

/*
    Forwarding Example 2
    addi x1, x0, 1
    lw x4, 0(x1)
    sw x4, 12(x1) */


