.global _boot

.text
_boot:
	addi x3, x0, 3
	addi x4, x0, 4
	sw x4, 0(x3)
	lw x5, -1(x4)
	add x4, x3, x4
	sw x4, -2(x3)
	sll x6, x3, x3
	sw x6, 10(x0)
	addi x1, x0, 1
	lw x20, 9(x1)
        sw x3, 0(x20)
        sw x20, -1(x20)
