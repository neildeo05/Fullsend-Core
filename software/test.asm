xreg_init:                    /* x0  = 0    0x000 */
	la x31, xreg_init_data
        la x1, xreg_output_data
	lw x2, 0(x31)
        addi x2, x2, 6
        sw x2, 0(x1)
        lw x3, 0(x1)
        add x3, x3, x2
        sw x3, 8(x1)
        add x5, x0, 1
        add x6, x0, 1

.data
.align 4
xreg_init_data:
reg_x1_init: .word 0x00010F26
xreg_output_data:
reg_x1_output: .word 0xcafebabe
reg_x2_output: .word 0xcafebabe
reg_x3_output:  .word 0xcafebabe
