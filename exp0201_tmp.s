	.file	"exp0201.c"
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
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rdi, rcx
	mov	rsi, rdx
	mov	ebx, 0
	jmp	.L2
.L3:
	movzx	edx, BYTE PTR [rdi+rbx]
	lea	rcx, .LC0[rip]
	call	printf
	add	rbx, 1
.L2:
	cmp	rbx, rsi
	jb	.L3
	add	rsp, 32
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "x = %x = %d = %u \0"
.LC2:
	.ascii "u = %x = %d = %u \0"
.LC3:
	.ascii "l = %lx = %ld = %lu \0"
.LC4:
	.ascii "s = %x = %d = %u \0"
.LC5:
	.ascii "us = %x = %d = %u \0"
.LC6:
	.ascii "c = %x = %d = %u = %c \0"
.LC7:
	.ascii "uc = %x = %d = %u = %c \0"
.LC8:
	.ascii "str = %s \0"
.LC9:
	.ascii "str1 = %s \0"
.LC10:
	.ascii "ps = 0x601060 \0"
.LC11:
	.ascii "f = %f, d = %lf\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	mov	edx, DWORD PTR x[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC1[rip]
	call	printf
	mov	edx, DWORD PTR u[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC2[rip]
	call	printf
	mov	edx, DWORD PTR l[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC3[rip]
	call	printf
	movsx	edx, WORD PTR s[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC4[rip]
	call	printf
	movzx	edx, WORD PTR us[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC5[rip]
	call	printf
	movsx	edx, BYTE PTR c[rip]
	mov	DWORD PTR 32[rsp], edx
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC6[rip]
	call	printf
	movzx	edx, BYTE PTR uc[rip]
	mov	DWORD PTR 32[rsp], edx
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC7[rip]
	call	printf
	lea	rdx, str[rip]
	lea	rcx, .LC8[rip]
	call	printf
	lea	rdx, str1[rip]
	lea	rcx, .LC9[rip]
	call	printf
	lea	rcx, .LC10[rip]
	call	printf
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, DWORD PTR f[rip]
	movsd	xmm2, QWORD PTR d[rip]
	movq	r8, xmm2
	movq	rdx, xmm1
	lea	rcx, .LC11[rip]
	call	printf
	mov	edx, 4
	lea	rcx, f[rip]
	call	show_bytes
	mov	edx, 8
	lea	rcx, d[rip]
	call	show_bytes
	mov	eax, 0
	add	rsp, 56
	ret
	.seh_endproc
	.globl	ps
	.data
	.align 8
ps:
	.quad	str
	.globl	str1
str1:
	.ascii "China\0"
	.globl	str
	.align 16
str:
	.ascii "Hello Assembly!\0"
	.globl	uc
uc:
	.byte	-56
	.globl	c
c:
	.byte	65
	.globl	us
	.align 2
us:
	.word	-1
	.globl	s
	.align 2
s:
	.word	-1
	.globl	ul
	.align 4
ul:
	.long	-1
	.globl	l
	.align 4
l:
	.long	-1
	.globl	u
	.align 4
u:
	.long	-2147483648
	.globl	x
	.align 4
x:
	.long	-1
	.globl	d
	.align 8
d:
	.long	0
	.long	-1067900928
	.globl	f
	.align 4
f:
	.long	-1027014656
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	printf;	.scl	2;	.type	32;	.endef
