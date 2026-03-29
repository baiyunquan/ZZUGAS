	.file	"eg0526.c"
	.intel_syntax noprefix
	.text
	.globl	swap_add
	.def	swap_add;	.scl	2;	.type	32;	.endef
	.seh_proc	swap_add
swap_add:
	.seh_endprologue
	mov	eax, DWORD PTR [rcx]
	mov	r8d, DWORD PTR [rdx]
	mov	DWORD PTR [rcx], r8d
	mov	DWORD PTR [rdx], eax
	add	eax, r8d
	ret
	.seh_endproc
	.globl	caller
	.def	caller;	.scl	2;	.type	32;	.endef
	.seh_proc	caller
caller:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	mov	DWORD PTR 44[rsp], 534
	mov	DWORD PTR 40[rsp], 1057
	lea	rdx, 40[rsp]
	lea	rcx, 44[rsp]
	call	swap_add
	mov	edx, DWORD PTR 44[rsp]
	sub	edx, DWORD PTR 40[rsp]
	imul	eax, edx
	add	rsp, 56
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
