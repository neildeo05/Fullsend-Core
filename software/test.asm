xreg_init:                    /* x0  = 0    0x000 */
	la x31, xreg_init_data
        la x1, xreg_output_data
	lw x2, 0(x31)
/*        sw x2, 0(x1)*/


.data
.align 4
xreg_init_data:
reg_x1_init: .word 0x00010F2C
xreg_output_data:
reg_x1_output: .word 0xcafebabe
