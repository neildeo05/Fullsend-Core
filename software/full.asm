.global _start

_start:
	addi x1, x1, 1
        sw x1, 4(x0)
	add x2, x1, x1
	add x2, x2, x1
	add x2, x1, x2
	addi x4, x0, 4
	lw x3, 4(x0)
	add x2, x3, x4
	sw x5, 8(x5)
	lw x5, 4(x0)
	sw x5, 7(x5)
        lw x6, 8(x0)
	
