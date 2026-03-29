	.file	"eg0501.c"
	.intel_syntax noprefix
	.text
	.globl	diffabs
	.def	diffabs;	.scl	2;	.type	32;	.endef
	.seh_proc	diffabs
diffabs:
	.seh_endprologue
	cmp	ecx, edx
	jge	.L4
	mov	eax, edx
	sub	eax, ecx
.L3:
.L1:
	ret
.L4:
	mov	eax, ecx
	sub	eax, edx
	jmp	.L1
	.seh_endproc
	.globl	find
	.def	find;	.scl	2;	.type	32;	.endef
	.seh_proc	find
find:
	.seh_endprologue
	mov	eax, 0
	jmp	.L6
	.p2align 5
.L10:
	add	eax, 1
.L6:
	cmp	eax, 2
	jg	.L9
	movsx	r8, eax
	cmp	DWORD PTR [rcx+r8*4], edx
	jne	.L10
	jmp	.L5
.L9:
	mov	eax, -1
.L5:
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
