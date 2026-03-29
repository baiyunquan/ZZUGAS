	.file	"eg0511.c"
	.intel_syntax noprefix
	.text
	.globl	fib1
	.type	fib1, @function
fib1:
.LFB11:
	.cfi_startproc
	movsx	rsi, esi
	lea	rcx, [rdi+rsi*4]
	mov	DWORD PTR [rdi], 1
	lea	rax, [rdi+8]
	mov	DWORD PTR [rdi+4], 1
	jmp	.L2
.L3:
	mov	edx, DWORD PTR [rax-8]
	add	edx, DWORD PTR [rax-4]
	mov	DWORD PTR [rax], edx
	add	rax, 4
.L2:
	cmp	rax, rcx
	jb	.L3
	ret
	.cfi_endproc
.LFE11:
	.size	fib1, .-fib1
	.globl	fib2
	.type	fib2, @function
fib2:
.LFB12:
	.cfi_startproc
	mov	DWORD PTR [rdi], 1
	mov	DWORD PTR [rdi+4], 1
	mov	edx, 3
	jmp	.L5
.L6:
	movsx	rax, edx
	sal	rax, 2
	mov	ecx, DWORD PTR [rdi-8+rax]
	add	ecx, DWORD PTR [rdi-4+rax]
	mov	DWORD PTR [rdi+rax], ecx
	add	edx, 1
.L5:
	cmp	edx, esi
	jl	.L6
	ret
	.cfi_endproc
.LFE12:
	.size	fib2, .-fib2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
.LC1:
	.string	"\n%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	sub	rsp, 48
	.cfi_def_cfa_offset 64
	mov	esi, 10
	mov	rdi, rsp
	call	fib1
	mov	ebx, 0
	jmp	.L8
.L9:
	movsx	rax, ebx
	mov	esi, DWORD PTR [rsp+rax*4]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	add	ebx, 1
.L8:
	cmp	ebx, 9
	jle	.L9
	mov	esi, 10
	mov	rdi, rsp
	call	fib2
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
	cmp	ebx, 9
	jle	.L11
	mov	eax, 0
	add	rsp, 48
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
