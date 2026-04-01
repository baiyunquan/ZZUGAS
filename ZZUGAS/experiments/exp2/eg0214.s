	.file	"eg0214.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " x = %x = %d = %u \12\0"
.LC1:
	.ascii " u = %x = %d = %u \12\0"
.LC2:
	.ascii " l = %x = %ld = %llu \12\0"
.LC3:
	.ascii " s = %x = %d = %u \12\0"
.LC4:
	.ascii " us = %x = %d = %u \12\0"
.LC5:
	.ascii " c = %x = %d = %u = %c \12\0"
.LC6:
	.ascii " uc = %x = %d = %u = %c \12\0"
.LC7:
	.ascii " str = %s\12 \0"
.LC8:
	.ascii " str1 = %s\12 \0"
.LC9:
	.ascii " ps = %x = %ld \0"
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
	lea	rcx, .LC0[rip]
	call	printf
	mov	edx, DWORD PTR u[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC1[rip]
	call	printf
	mov	edx, DWORD PTR l[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC2[rip]
	call	printf
	movsx	edx, WORD PTR s[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC3[rip]
	call	printf
	movzx	edx, WORD PTR us[rip]
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC4[rip]
	call	printf
	movsx	edx, BYTE PTR c[rip]
	mov	DWORD PTR 32[rsp], edx
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC5[rip]
	call	printf
	movzx	edx, BYTE PTR uc[rip]
	mov	DWORD PTR 32[rsp], edx
	mov	r9d, edx
	mov	r8d, edx
	lea	rcx, .LC6[rip]
	call	printf
	lea	rdx, str[rip]
	lea	rcx, .LC7[rip]
	call	printf
	lea	rdx, str1[rip]
	lea	rcx, .LC8[rip]
	call	printf
	mov	rdx, QWORD PTR ps[rip]
	lea	rcx, .LC9[rip]
	call	printf
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
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	printf;	.scl	2;	.type	32;	.endef
