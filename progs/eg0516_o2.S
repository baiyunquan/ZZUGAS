	.file	"eg0516.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	bubble_sort
	.def	bubble_sort;	.scl	2;	.type	32;	.endef
	.seh_proc	bubble_sort
bubble_sort:
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	mov	ebx, edx
	cmp	edx, 1
	jle	.L1
	movsx	rax, edx
	mov	edx, 1
	lea	r11, -4[rcx+rax*4]
	.p2align 4
	.p2align 3
.L3:
	mov	r8d, edx
	mov	rax, rcx
	.p2align 6
	.p2align 4
	.p2align 3
.L5:
	mov	r9d, DWORD PTR [rax]
	mov	r10d, DWORD PTR 4[rax]
	cmp	r9d, r10d
	jle	.L4
	mov	DWORD PTR [rax], r10d
	movsx	r10, r8d
	mov	DWORD PTR [rcx+r10*4], r9d
.L4:
	add	rax, 4
	add	r8d, 1
	cmp	rax, r11
	jne	.L5
	add	edx, 1
	sub	r11, 4
	cmp	ebx, edx
	jne	.L3
.L1:
	pop	rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "\305\305\320\362\307\260:\0"
.LC2:
	.ascii "%d \0"
.LC3:
	.ascii "\12\305\305\320\362\272\363:\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 72
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	lea	rbp, 32[rsp]
	lea	rdi, 52[rsp]
	movdqa	xmm0, XMMWORD PTR .LC0[rip]
	lea	rcx, .LC1[rip]
	mov	DWORD PTR 48[rsp], -34
	mov	rbx, rbp
	mov	rsi, rbp
	movaps	XMMWORD PTR 32[rsp], xmm0
	call	puts
.L9:
	mov	edx, DWORD PTR [rsi]
	lea	rcx, .LC2[rip]
	add	rsi, 4
	call	printf
	cmp	rsi, rdi
	jne	.L9
	mov	rcx, rbp
	mov	edx, 5
	call	bubble_sort
	lea	rcx, .LC3[rip]
	call	puts
.L10:
	mov	edx, DWORD PTR [rbx]
	lea	rcx, .LC2[rip]
	add	rbx, 4
	call	printf
	cmp	rbx, rdi
	jne	.L10
	xor	eax, eax
	add	rsp, 72
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 16
.LC0:
	.long	587
	.long	-632
	.long	777
	.long	234
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
