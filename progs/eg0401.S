	.file	"eg0401.c"
	.intel_syntax noprefix
	.text
	.globl	exchange
	.def	exchange;	.scl	2;	.type	32;	.endef
	.seh_proc	exchange
exchange:
	.seh_endprologue
	mov	eax, DWORD PTR [rcx]
	mov	DWORD PTR [rcx], edx
	ret
	.seh_endproc
	.globl	exchangell
	.def	exchangell;	.scl	2;	.type	32;	.endef
	.seh_proc	exchangell
exchangell:
	.seh_endprologue
	mov	rax, QWORD PTR [rcx]
	mov	QWORD PTR [rcx], rdx
	ret
	.seh_endproc
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
