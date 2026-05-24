	.file	"eg0415.c"
	.intel_syntax noprefix
	.text
	.globl	sum
	.def	sum;	.scl	2;	.type	32;	.endef
	.seh_proc	sum
sum:
	.seh_endprologue
	lea	eax, 1[rcx]
	imul	eax, ecx
	shr	eax
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%lu\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	mov	ecx, DWORD PTR N[rip]
	call	sum
	mov	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.globl	N
	.data
	.align 4
N:
	.long	3456
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
