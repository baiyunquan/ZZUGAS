	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	add
	.def	add;	.scl	2;	.type	32;	.endef
	.seh_proc	add
add:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx
	mov	DWORD PTR 24[rbp], edx
	mov	QWORD PTR 32[rbp], r8
	mov	edx, DWORD PTR 16[rbp]
	mov	eax, DWORD PTR 24[rbp]
	add	edx, eax
	mov	rax, QWORD PTR 32[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR 32[rbp]
	mov	eax, DWORD PTR [rax]
	pop	rbp
	ret
	.seh_endproc
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	call	__main
	lea	rax, -4[rbp]
	mov	r8, rax
	mov	edx, 4
	mov	ecx, 3
	call	add
	mov	eax, 0
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev13, Built by MSYS2 project) 15.2.0"
