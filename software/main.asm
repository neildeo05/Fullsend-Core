.global _boot
.text

_boot:                    /* x0  = 0    0x000 */


   la x11, xreg_output_data
   addi x12, x0, 12
   sw x12, 0(x11)
   lw x1, 0(x11)
   div x10, x1, x12
   mul x5, x1, x12
.data
.align 4
xreg_output_data:
reg_x1_output: .word 0xcafedead
