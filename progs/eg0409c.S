	.file	"eg0409.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "x-y =%d\12\0"
.LC1:
	.ascii "c =%c\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	mov	edx, DWORD PTR x[rip]
	sub	edx, DWORD PTR y[rip]
	sub	edx, 250
	lea	rcx, .LC0[rip]
	call	printf
	movsx	edx, BYTE PTR c[rip]
	sub	edx, 32
	lea	rcx, .LC1[rip]
	call	printf
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.globl	c
	.data
c:
	.byte	97
	.globl	y
	.align 4
y:
	.long	-978522123
	.globl	x
	.align 4
x:
	.long	123456789
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
