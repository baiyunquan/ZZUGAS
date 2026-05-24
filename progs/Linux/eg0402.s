	.file	"eg0402.c"
	.intel_syntax noprefix
	.text
	.globl	scale
	.type	scale, @function
scale:
.LFB0:
	.cfi_startproc
	lea	eax, [rdi+rsi*4]
	lea	edx, [rdx+rdx*2]
	lea	eax, [rax+rdx*4]
	ret
	.cfi_endproc
.LFE0:
	.size	scale, .-scale
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
