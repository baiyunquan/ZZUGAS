	.file	"eg0417.c"
	.intel_syntax noprefix
	.text
	.globl	eg0420
	.def	eg0420;	.scl	2;	.type	32;	.endef
	.seh_proc	eg0420
eg0420:
	.seh_endprologue
	xor	ecx, edx
	lea	eax, [r8+r8*2]
	sal	eax, 4
	and	ecx, 252645135
	sub	eax, ecx
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
