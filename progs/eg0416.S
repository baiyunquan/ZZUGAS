	.file	"eg0416.c"
	.intel_syntax noprefix
	.text
	.globl	CtoF
	.def	CtoF;	.scl	2;	.type	32;	.endef
	.seh_proc	CtoF
CtoF:
	.seh_endprologue
	movsx	ecx, cx
	lea	edx, [rcx+rcx*8]
	movsx	rax, edx
	imul	rax, rax, 1717986919
	sar	rax, 33
	sar	edx, 31
	sub	eax, edx
	add	eax, 32
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movsx	ecx, WORD PTR C[rip]
	call	CtoF
	movsx	edx, ax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.globl	C
	.data
	.align 2
C:
	.word	26
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
