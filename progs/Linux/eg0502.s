	.file	"eg0502.c"
	.intel_syntax noprefix
	.text
	.globl	iabs
	.type	iabs, @function
iabs:
.LFB0:
	.cfi_startproc
	mov	eax, edi
	test	edi, edi
	js	.L3
.L2:
	ret
.L3:
	neg	eax
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	iabs, .-iabs
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
