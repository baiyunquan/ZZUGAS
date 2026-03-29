	.file	"eg0507.c"
	.intel_syntax noprefix
	.text
	.globl	fac
	.def	fac;	.scl	2;	.type	32;	.endef
	.seh_proc	fac
fac:
	.seh_endprologue
	mov	eax, 1
	.L2:
	cmp	ecx, 1
	jng	.L4
jmp	.L2
	.p2align 4
.L3:
	imul	eax, ecx
	sub	ecx, 1
      jmp .L2
	.L4: ret
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
	mov	ecx, 10
	call	fac
	mov	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
