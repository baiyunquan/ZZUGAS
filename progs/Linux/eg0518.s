	.file	"eg0518.c"
	.intel_syntax noprefix
	.text
	.globl	mult2
	.type	mult2, @function
mult2:
.LFB11:
	.cfi_startproc
	mov	eax, edi
	imul	eax, esi
	ret
	.cfi_endproc
.LFE11:
	.size	mult2, .-mult2
	.globl	multstore
	.type	multstore, @function
multstore:
.LFB12:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rdx
	call	mult2
	mov	DWORD PTR [rbx], eax
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	multstore, .-multstore
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"3 * 5 =%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rdx, [rsp+12]
	mov	esi, 5
	mov	edi, 3
	call	multstore
	mov	esi, DWORD PTR [rsp+12]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 24
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
