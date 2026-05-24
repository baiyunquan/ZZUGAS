	.file	"eg0527s.c"
	.intel_syntax noprefix
	.text
	.globl	print
	.def	print;	.scl	2;	.type	32;	.endef
	.seh_proc	print
print:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	printf
	nop
	add	rsp, 40
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
