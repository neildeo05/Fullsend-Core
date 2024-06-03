.global _boot
.text

_boot:                    /* x0  = 0    0x000 */


   addi x6, x0, 6
   add  x8, x6, x0 


    addi x6, x0, 6
    addi x7, x0, 7
    add  x6, x6, x7 

  addi x1, x0, 1
  addi x1, x1, 2
  sub x4, x3, x1

