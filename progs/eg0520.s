	.file	"eg0520.c"
	.intel_syntax noprefix
	.text
	.globl	fact
	.def	fact;	.scl	2;	.type	32;	.endef
	.seh_proc	fact
fact:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	ebx, ecx
	test	ecx, ecx
	jne	.L4
	mov	eax, 1
.L1:
	add	rsp, 32
	pop	rbx
	ret
.L4:
	lea	ecx, -1[rcx]
	call	fact
	imul	eax, ebx
	jmp	.L1
	.seh_endproc
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	mov	ecx, 3
	call	fact
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
