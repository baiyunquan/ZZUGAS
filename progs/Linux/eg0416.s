	.file	"eg0416.c"
	.intel_syntax noprefix
	.text
	.globl	CtoF
	.type	CtoF, @function
CtoF:
.LFB11:
	.cfi_startproc
	movsx	edi, di
	lea	edx, [rdi+rdi*8]
	movsx	rax, edx
	imul	rax, rax, 1717986919
	sar	rax, 33
	sar	edx, 31
	sub	eax, edx
	add	eax, 32
	ret
	.cfi_endproc
.LFE11:
	.size	CtoF, .-CtoF
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	movsx	edi, WORD PTR C[rip]
	call	CtoF
	movsx	esi, ax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	C
	.data
	.align 2
	.type	C, @object
	.size	C, 2
C:
	.value	26
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
