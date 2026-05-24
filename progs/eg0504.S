	.file	"eg0504.c"
	.intel_syntax noprefix
	.text
	.globl	sub_of
	.def	sub_of;	.scl	2;	.type	32;	.endef
	.seh_proc	sub_of
sub_of:
	.seh_endprologue
	sub	ecx, edx
	mov	DWORD PTR [r8], ecx
	mov	eax, 0
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "x-y = %d = %u = %x\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	lea	r8, 44[rsp]
	mov	edx, -999999999
	mov	ecx, 1234567890
	call	sub_of
	mov	edx, DWORD PTR 44[rsp]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 56
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
