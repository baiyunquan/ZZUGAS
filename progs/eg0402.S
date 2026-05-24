	.file	"eg0402.c"
	.intel_syntax noprefix
	.text
	.globl	scale
	.def	scale;	.scl	2;	.type	32;	.endef
	.seh_proc	scale
scale:
	.seh_endprologue
	lea	eax, [rcx+rdx*4]
	lea	edx, [r8+r8*2]
	lea	eax, [rax+rdx*4]
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
