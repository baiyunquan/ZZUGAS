	.file	"eg0506.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	caculator
	.def	caculator;	.scl	2;	.type	32;	.endef
	.seh_proc	caculator
caculator:
	.seh_endprologue
	sub	ecx, 42
	cmp	cl, 20
	ja	.L11
	lea	r10, .L4[rip]
	movzx	ecx, cl
	movsx	rax, DWORD PTR [r10+rcx*4]
	add	rax, r10
	jmp	rax
	.section .rdata,"dr"
	.align 4
.L4:
	.long	.L9-.L4
	.long	.L8-.L4
	.long	.L11-.L4
	.long	.L7-.L4
	.long	.L11-.L4
	.long	.L6-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L11-.L4
	.long	.L5-.L4
	.long	.L11-.L4
	.long	.L3-.L4
	.text
	.p2align 4,,10
	.p2align 3
.L11:
	mov	eax, 1
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	sar	r8d, 2
	xor	eax, eax
	mov	DWORD PTR [r9], r8d
.L13:
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	imul	r8d, edx
	xor	eax, eax
	mov	DWORD PTR [r9], r8d
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L8:
	add	r8d, edx
	xor	eax, eax
	mov	DWORD PTR [r9], r8d
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L7:
	sub	edx, r8d
	xor	eax, eax
	mov	DWORD PTR [r9], edx
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L6:
	mov	eax, edx
	cdq
	idiv	r8d
	mov	DWORD PTR [r9], eax
	xor	eax, eax
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L5:
	add	edx, edx
	xor	eax, eax
	mov	DWORD PTR [r9], edx
	jmp	.L13
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%c\0"
.LC1:
	.ascii "%d\0"
.LC2:
	.ascii "input error\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	lea	rdx, 43[rsp]
	lea	rcx, .LC0[rip]
	call	scanf
	movsx	ecx, BYTE PTR 43[rsp]
	lea	r9, 44[rsp]
	mov	r8d, -300
	mov	edx, 200
	call	caculator
	test	eax, eax
	jne	.L15
	mov	edx, DWORD PTR 44[rsp]
	lea	rcx, .LC1[rip]
	call	printf
.L16:
	xor	eax, eax
	add	rsp, 56
	ret
.L15:
	lea	rcx, .LC2[rip]
	call	printf
	jmp	.L16
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
