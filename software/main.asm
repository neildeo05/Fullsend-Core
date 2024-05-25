.global _boot
.text

_boot:                    /* x0  = 0    0x000 */


/* Stall Example 0 */
   lw x7, 7(x0)
   lw x1, 5(x0)
   add x5, x1, x7
   lw x6, 6(x0)
   sub x8, x6, x7
   and x9, x6, x7
/* Stall example 1  */
   lw x2, 5(x0)
   lw x4, 5(x0)
   add x3, x2, x4
   


/* Forwarding Example 1 
    addi x6, x0, 6
    addi x7, x6, 1 */

/*
    Forwarding Example 2
    addi x1, x0, 1
    lw x4, 0(x1)
    sw x4, 12(x1) */


