	.file	"eg0518.c"
	.intel_syntax noprefix
	.text
	.globl	_mult2
	.def	_mult2;	.scl	2;	.type	32;	.endef
_mult2:
LFB0:
	.cfi_startproc
	mov	eax, DWORD PTR [esp+8]
	imul	eax, DWORD PTR [esp+4]
	ret
	.cfi_endproc
LFE0:
	.globl	_multstore
	.def	_multstore;	.scl	2;	.type	32;	.endef
_multstore:
LFB1:
	.cfi_startproc
	sub	esp, 8
	.cfi_def_cfa_offset 12
	mov	eax, DWORD PTR [esp+16]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [esp+12]
	mov	DWORD PTR [esp], eax
	call	_mult2
	mov	edx, DWORD PTR [esp+20]
	mov	DWORD PTR [edx], eax
	add	esp, 8
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE1:
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB2:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16
	sub	esp, 32
	call	___main
	lea	eax, [esp+28]
	mov	DWORD PTR [esp+8], eax
	mov	DWORD PTR [esp+4], 5
	mov	DWORD PTR [esp], 3
	call	_multstore
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2:
	.def	___main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
