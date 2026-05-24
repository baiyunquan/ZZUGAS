	.file	"eg0517.c"
	.intel_syntax noprefix
	.text
	.globl	del_char1
	.def	del_char1;	.scl	2;	.type	32;	.endef
	.seh_proc	del_char1
del_char1:
	.seh_endprologue
	mov	r9d, 0
	mov	r8d, 0
	jmp	.L2
	.p2align 5
.L3:
	add	r8d, 1
.L2:
	movsx	rax, r8d
	movzx	eax, BYTE PTR [rcx+rax]
	test	al, al
	je	.L5
	cmp	al, dl
	je	.L3
	movsx	r10, r9d
	mov	BYTE PTR [rcx+r10], al
	lea	r9d, 1[r9]
	jmp	.L3
.L5:
	movsx	r9, r9d
	mov	BYTE PTR [rcx+r9], 0
	ret
	.seh_endproc
	.globl	del_char
	.def	del_char;	.scl	2;	.type	32;	.endef
	.seh_proc	del_char
del_char:
	.seh_endprologue
	mov	r8, rcx
	jmp	.L7
	.p2align 4
.L8:
	add	rcx, 1
.L7:
	movzx	eax, BYTE PTR [rcx]
	test	al, al
	je	.L10
	cmp	al, dl
	je	.L8
	mov	BYTE PTR [r8], al
	lea	r8, 1[r8]
	jmp	.L8
.L10:
	mov	BYTE PTR [r8], 0
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%s\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 64
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	movabs	rax, 2338328219631577172
	movabs	rdx, 7598263559140745248
	mov	QWORD PTR 32[rsp], rax
	mov	QWORD PTR 40[rsp], rdx
	mov	DWORD PTR 47[rsp], 6778473
	lea	rbx, 32[rsp]
	mov	rcx, rbx
	call	puts
	mov	edx, 32
	mov	rcx, rbx
	call	del_char
	mov	rdx, rbx
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 64
	pop	rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
