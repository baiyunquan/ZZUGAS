	.file	"eg0516.c"
	.intel_syntax noprefix
	.text
	.globl	bubble_sort
	.type	bubble_sort, @function
bubble_sort:
.LFB11:
	.cfi_startproc
	mov	r9d, esi
	mov	r8d, 1
	jmp	.L2
.L3:
	add	eax, 1
.L5:
	mov	edx, r9d
	sub	edx, r8d
	cmp	edx, eax
	jle	.L7
	movsx	rdx, eax
	lea	rsi, [rdi+rdx*4]
	mov	ecx, DWORD PTR [rsi]
	mov	edx, DWORD PTR [rdi+4+rdx*4]
	cmp	ecx, edx
	jle	.L3
	mov	DWORD PTR [rsi], edx
	lea	edx, [r8+rax]
	movsx	rdx, edx
	mov	DWORD PTR [rdi+rdx*4], ecx
	jmp	.L3
.L7:
	add	r8d, 1
.L2:
	cmp	r8d, r9d
	jge	.L8
	mov	eax, 0
	jmp	.L5
.L8:
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	sub	rsp, 32
	.cfi_def_cfa_offset 48
	mov	DWORD PTR [rsp], 587
	mov	DWORD PTR [rsp+4], -632
	mov	DWORD PTR [rsp+8], 777
	mov	DWORD PTR [rsp+12], 234
	mov	DWORD PTR [rsp+16], -34
	mov	edi, OFFSET FLAT:.LC0
	call	puts
	mov	ebx, 0
	jmp	.L10
.L11:
	movsx	rax, ebx
	mov	esi, DWORD PTR [rsp+rax*4]
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	add	ebx, 1
.L10:
	cmp	ebx, 4
	jle	.L11
	mov	esi, 5
	mov	rdi, rsp
	call	bubble_sort
	mov	edi, OFFSET FLAT:.LC2
	call	puts
	mov	ebx, 0
	jmp	.L12
.L13:
	movsx	rax, ebx
	mov	esi, DWORD PTR [rsp+rax*4]
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	add	ebx, 1
.L12:
	cmp	ebx, 4
	jle	.L13
	mov	eax, 0
	add	rsp, 32
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
