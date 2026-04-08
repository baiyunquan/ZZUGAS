	.file	"eg0403.c"
	.intel_syntax noprefix
	.text
	.globl	arith2
	.type	arith2, @function
arith2:
.LFB0:
	.cfi_startproc
	or	rsi, rdi
	sar	rsi, 3
	not	rsi
	mov	rax, rdx
	sub	rax, rsi
	ret
	.cfi_endproc
.LFE0:
	.size	arith2, .-arith2
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
