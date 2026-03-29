	.file	"eg0414b.c"
	.intel_syntax noprefix
	.text
	.globl	eg0414a
	.def	eg0414a;	.scl	2;	.type	32;	.endef
	.seh_proc	eg0414a
eg0414a:
	.seh_endprologue
	mov	eax, ecx
	mov	r10d, edx
	mov	edx, 0
	div	r10d
	mov	DWORD PTR [r8], eax
	mov	DWORD PTR [r9], edx
	ret
	.seh_endproc
	.globl	eg0414b
	.def	eg0414b;	.scl	2;	.type	32;	.endef
	.seh_proc	eg0414b
eg0414b:
	.seh_endprologue
	mov	eax, ecx
	mov	r10d, edx
	cdq
	idiv	r10d
	mov	DWORD PTR [r8], eax
	mov	DWORD PTR [r9], edx
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
