	.file	"eg0520.c"
	.intel_syntax noprefix
	.text
	.globl	fact
	.type	fact, @function
fact:
.LFB0:
	.cfi_startproc
	test	edi, edi
	jne	.L8
	mov	eax, 1
	ret
.L8:
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	ebx, edi
	lea	edi, [rdi-1]
	call	fact
	imul	eax, ebx
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.size	fact, .-fact
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	edi, 3
	call	fact
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
