	.file	"eg0215.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	" %.2x"
	.text
	.globl	show_bytes
	.type	show_bytes, @function
show_bytes:
.LFB11:
	.cfi_startproc
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	r12, rdi
	mov	rbp, rsi
	mov	ebx, 0
	jmp	.L2
.L3:
	movzx	esi, BYTE PTR [r12+rbx]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	add	rbx, 1
.L2:
	cmp	rbx, rbp
	jb	.L3
	mov	edi, 10
	call	putchar
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	show_bytes, .-show_bytes
	.section	.rodata.str1.1
.LC1:
	.string	"f= %f,d= %lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	pxor	xmm0, xmm0
	cvtss2sd	xmm0, DWORD PTR f[rip]
	movsd	xmm1, QWORD PTR d[rip]
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 2
	call	printf
	mov	esi, 4
	mov	edi, OFFSET FLAT:f
	call	show_bytes
	mov	esi, 8
	mov	edi, OFFSET FLAT:d
	call	show_bytes
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	d
	.data
	.align 8
	.type	d, @object
	.size	d, 8
d:
	.long	0
	.long	-1067900928
	.globl	f
	.align 4
	.type	f, @object
	.size	f, 4
f:
	.long	-1027014656
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
