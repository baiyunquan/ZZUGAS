	.file	"eg0503.c"
	.intel_syntax noprefix
	.text
	.globl	Uchar
	.type	Uchar, @function
Uchar:
.LFB0:
	.cfi_startproc
	mov	eax, edi
	lea	edx, [rdi-65]
	cmp	dl, 25
	ja	.L2
	lea	eax, [rdi+32]
.L2:
	ret
	.cfi_endproc
.LFE0:
	.size	Uchar, .-Uchar
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
