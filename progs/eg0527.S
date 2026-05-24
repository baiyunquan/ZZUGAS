	.file	"eg0527.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	mov	DWORD PTR 42[rsp], 1819043144
	mov	WORD PTR 46[rsp], 111
	lea	rcx, 42[rsp]
	call	print
	mov	eax, 0
	add	rsp, 56
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	print;	.scl	2;	.type	32;	.endef
