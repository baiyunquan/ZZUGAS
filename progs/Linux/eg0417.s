	.file	"eg0417.c"
	.intel_syntax noprefix
	.text
	.globl	eg0420
	.type	eg0420, @function
eg0420:
.LFB0:
	.cfi_startproc
	xor	rdi, rsi
	lea	rax, [rdx+rdx*2]
	sal	rax, 4
	and	edi, 252645135
	sub	rax, rdi
	ret
	.cfi_endproc
.LFE0:
	.size	eg0420, .-eg0420
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
