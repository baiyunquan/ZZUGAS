	.file	"eg0418.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%x\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movsx	edx, WORD PTR num[rip]
	movzx	ecx, BYTE PTR n[rip]
	sar	edx, cl
	movzx	ecx, BYTE PTR m[rip]
	mov	eax, -1
	sal	eax, cl
	not	eax
	and	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.globl	m
	.data
m:
	.byte	8
	.globl	n
n:
	.byte	4
	.globl	num
	.align 2
num:
	.word	-21555
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
