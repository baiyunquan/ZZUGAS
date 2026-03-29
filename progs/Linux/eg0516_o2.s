	.file	"eg0516.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
.LFB11:
	.cfi_startproc
	mov	r8, rdi
	mov	r9d, 1
	mov	edi, esi
	cmp	esi, 1
	jle	.L10
	.p2align 4,,10
	.p2align 3
.L2:
	mov	rax, r8
	mov	edx, r9d
	.p2align 4,,10
	.p2align 3
.L5:
	mov	ecx, DWORD PTR [rax]
	mov	esi, DWORD PTR [rax+4]
	cmp	ecx, esi
	jle	.L4
	mov	DWORD PTR [rax], esi
	movsx	rsi, edx
	mov	DWORD PTR [r8+rsi*4], ecx
.L4:
	add	edx, 1
	add	rax, 4
	cmp	edx, edi
	jne	.L5
	add	r9d, 1
	cmp	edi, r9d
	jne	.L2
	ret
.L10:
	ret
	.cfi_endproc
.LFE11:
	.size	bubble_sort, .-bubble_sort
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\346\216\222\345\272\217\345\211\215:"
.LC1:
	.string	"%d "
.LC2:
	.string	"\n\346\216\222\345\272\217\345\220\216:"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	edi, OFFSET FLAT:.LC0
	movabs	rax, -2714419330485
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	sub	rsp, 32
	.cfi_def_cfa_offset 64
	mov	QWORD PTR [rsp], rax
	mov	rbx, rsp
	lea	r12, [rsp+20]
	mov	rbp, rsp
	movabs	rax, 1005022348041
	mov	DWORD PTR [rsp+16], -34
	mov	QWORD PTR [rsp+8], rax
	call	puts
.L12:
	mov	esi, DWORD PTR [rbp+0]
	mov	edi, OFFSET FLAT:.LC1
	xor	eax, eax
	add	rbp, 4
	call	printf
	cmp	rbp, r12
	jne	.L12
	mov	rdi, rsp
	mov	esi, 5
	call	bubble_sort
	mov	edi, OFFSET FLAT:.LC2
	call	puts
.L13:
	mov	esi, DWORD PTR [rbx]
	mov	edi, OFFSET FLAT:.LC1
	xor	eax, eax
	add	rbx, 4
	call	printf
	cmp	rbx, r12
	jne	.L13
	add	rsp, 32
	.cfi_def_cfa_offset 32
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
