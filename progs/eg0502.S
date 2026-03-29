	.file	"eg0502.c"
	.intel_syntax noprefix
	.text
	.globl	iabs
	.def	iabs;	.scl	2;	.type	32;	.endef
	.seh_proc	iabs
iabs:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx
	cmp	DWORD PTR 16[rbp], 0
	jns	.L2
	neg	DWORD PTR 16[rbp]
.L2:
	mov	eax, DWORD PTR 16[rbp]
	pop	rbp
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
