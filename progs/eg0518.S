	.file	"eg0518.c"
	.intel_syntax noprefix
	.text
	.globl	mult2
	.def	mult2;	.scl	2;	.type	32;	.endef
	.seh_proc	mult2
mult2:
	.seh_endprologue
	mov	eax, ecx
	imul	eax, edx
	ret
	.seh_endproc
	.globl	multstore
	.def	multstore;	.scl	2;	.type	32;	.endef
	.seh_proc	multstore
multstore:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rbx, r8
	call	mult2
	mov	DWORD PTR [rbx], eax
	add	rsp, 32
	pop	rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "3 * 5 =%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	lea	r8, 44[rsp]
	mov	edx, 5
	mov	ecx, 3
	call	multstore
	mov	edx, DWORD PTR 44[rsp]
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 56
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
