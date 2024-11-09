.global _boot
.text

_boot:                    /* x0  = 0    0x000 */


   addi x12, x0, 12
   div x11, x12, x0
.data
.align 4
xreg_output_data:
