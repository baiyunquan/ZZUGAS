	.file	"eg0501.c"
	.intel_syntax noprefix
	.text
	.globl	diffabs
	.type	diffabs, @function
diffabs:
.LFB0:
	.cfi_startproc
	cmp	edi, esi
	jge	.L4
	mov	eax, esi
	sub	eax, edi
.L3:
	ret
.L4:
	mov	eax, edi
	sub	eax, esi
	ret
	.cfi_endproc
.LFE0:
	.size	diffabs, .-diffabs
	.globl	find
	.type	find, @function
find:
.LFB1:
	.cfi_startproc
	mov	eax, 0
	jmp	.L6
.L10:
	add	eax, 1
.L6:
	cmp	eax, 2
	jg	.L9
	movsx	rdx, eax
	cmp	DWORD PTR [rdi+rdx*4], esi
	jne	.L10
	jmp	.L5
.L9:
	mov	eax, -1
.L5:
	ret
	.cfi_endproc
.LFE1:
	.size	find, .-find
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
