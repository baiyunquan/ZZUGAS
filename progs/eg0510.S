	.file	"eg0510.c"
	.intel_syntax noprefix
	.text
	.globl	mystrlen
	.def	mystrlen;	.scl	2;	.type	32;	.endef
	.seh_proc	mystrlen
mystrlen:
	.seh_endprologue
	mov	eax, 0
	jmp	.L2
	.p2align 4
.L3:
	add	eax, 1
	mov	rcx, rdx
.L2:
	lea	rdx, 1[rcx]
	cmp	BYTE PTR [rcx], 0
	jne	.L3
	ret
	.seh_endproc
	.globl	mystrlen1
	.def	mystrlen1;	.scl	2;	.type	32;	.endef
	.seh_proc	mystrlen1
mystrlen1:
	.seh_endprologue
	mov	eax, 0
	jmp	.L5
	.p2align 4
.L6:
	add	eax, 1
.L5:
	movsx	rdx, eax
	cmp	BYTE PTR [rcx+rdx], 0
	jne	.L6
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 88
	.seh_stackalloc	88
	.seh_endprologue
	call	__main
	movabs	rax, 8316213789752649795
	movabs	rdx, 8389772277102698784
	mov	QWORD PTR 32[rsp], rax
	mov	QWORD PTR 40[rsp], rdx
	movabs	rax, 2335244403110607218
	movabs	rdx, 7503110703212666977
	mov	QWORD PTR 48[rsp], rax
	mov	QWORD PTR 56[rsp], rdx
	movabs	rax, 13081381331825513
	mov	QWORD PTR 64[rsp], rax
	lea	rcx, 32[rsp]
	call	mystrlen
	mov	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 88
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
