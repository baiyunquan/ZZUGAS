	.file	"eg0503.c"
	.intel_syntax noprefix
	.text
	.globl	Uchar
	.def	Uchar;	.scl	2;	.type	32;	.endef
	.seh_proc	Uchar
Uchar:
	.seh_endprologue
	mov	eax, ecx
	lea	edx, -65[rcx]
	cmp	dl, 25
	ja	.L2
	lea	eax, 32[rcx]
.L2:
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
