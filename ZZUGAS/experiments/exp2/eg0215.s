	.file	"eg0215.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %.2x\0"
	.text
	.globl	show_bytes
	.def	show_bytes;	.scl	2;	.type	32;	.endef
	.seh_proc	show_bytes
show_bytes:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
	jmp	.L2
.L3:
	mov	rdx, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movzx	eax, al
	lea	rcx, .LC0[rip]
	mov	edx, eax
	call	printf
	add	QWORD PTR -8[rbp], 1
.L2:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR 24[rbp]
	jb	.L3
	mov	ecx, 10
	call	putchar
	nop
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.globl	f
	.data
	.align 4
f:
	.long	-1027014656
	.globl	d
	.align 8
d:
	.long	0
	.long	-1067900928
	.section .rdata,"dr"
.LC1:
	.ascii "f= %f,d= %lf\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movsd	xmm1, QWORD PTR d[rip]
	movss	xmm0, DWORD PTR f[rip]
	cvtss2sd	xmm0, xmm0
	movapd	xmm2, xmm1
	movapd	xmm1, xmm2
	movq	rcx, xmm2
	movapd	xmm2, xmm0
	movapd	xmm0, xmm2
	movq	rdx, xmm2
	lea	rax, .LC1[rip]
	movapd	xmm2, xmm1
	mov	r8, rcx
	movapd	xmm1, xmm0
	mov	rcx, rax
	call	printf
	lea	rax, f[rip]
	mov	edx, 4
	mov	rcx, rax
	call	show_bytes
	lea	rax, d[rip]
	mov	edx, 8
	mov	rcx, rax
	call	show_bytes
	mov	eax, 0
	add	rsp, 32
	pop	rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
