xreg_init:
	auipc x31, 1
        /*
	la x31, xreg_init_data
	lw x0, 0(x31)
        j foo

foo:
	lw x1, 1(x31)
	
        */

        .data
        .align 4
xreg_init_data:
reg_x0_init:    .word 0xcafebabe
        
