.global _boot
.text

_boot:
   /*lw x3, 0(x0)*/
   addi x3, x0, 3
   sw x3, 1(x0)
   /*addi x1, x0, 2*/
   /*addi x3, x0, 3*/
   /*addi x1, x3, 7*/
   


