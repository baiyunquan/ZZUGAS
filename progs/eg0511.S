	.file	"eg0511.c"
	.intel_syntax noprefix
	.text
	.globl	fib1
	.def	fib1;	.scl	2;	.type	32;	.endef
	.seh_proc	fib1
fib1:
	.seh_endprologue
	movsx	rdx, edx
	lea	r8, [rcx+rdx*4]
	mov	DWORD PTR [rcx], 1
	lea	rax, 8[rcx]
	mov	DWORD PTR 4[rcx], 1
	jmp	.L2
	.p2align 5
.L3:
	mov	edx, DWORD PTR -8[rax]
	add	edx, DWORD PTR -4[rax]
	mov	DWORD PTR [rax], edx
	add	rax, 4
.L2:
	cmp	rax, r8
	jb	.L3
	ret
	.seh_endproc
	.globl	fib2
	.def	fib2;	.scl	2;	.type	32;	.endef
	.seh_proc	fib2
fib2:
	.seh_endprologue
	mov	DWORD PTR [rcx], 1
	mov	DWORD PTR 4[rcx], 1
	mov	eax, 3
	jmp	.L5
	.p2align 5
.L6:
	movsx	r8, eax
	mov	r9d, DWORD PTR -8[rcx+r8*4]
	add	r9d, DWORD PTR -4[rcx+r8*4]
	mov	DWORD PTR [rcx+r8*4], r9d
	add	eax, 1
.L5:
	cmp	eax, edx
	jl	.L6
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d \0"
.LC1:
	.ascii "\12%d \0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 80
	.seh_stackalloc	80
	.seh_endprologue
	call	__main
	lea	rcx, 32[rsp]
	mov	edx, 10
	call	fib1
	mov	ebx, 0
	jmp	.L8
.L9:
	movsx	rax, ebx
	mov	edx, DWORD PTR 32[rsp+rax*4]
	lea	rcx, .LC0[rip]
	call	printf
	add	ebx, 1
.L8:
	cmp	ebx, 9
	jle	.L9
	lea	rcx, 32[rsp]
	mov	edx, 10
	call	fib2
	mov	ebx, 0
	jmp	.L10
.L11:
	movsx	rax, ebx
	mov	edx, DWORD PTR 32[rsp+rax*4]
	lea	rcx, .LC1[rip]
	call	printf
	add	ebx, 1
.L10:
	cmp	ebx, 9
	jle	.L11
	mov	eax, 0
	add	rsp, 80
	pop	rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
