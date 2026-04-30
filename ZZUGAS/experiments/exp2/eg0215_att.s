	.file	"eg0215.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %.2x\0"
	.text
	.globl	show_bytes
	.def	show_bytes;	.scl	2;	.type	32;	.endef
	.seh_proc	show_bytes
show_bytes:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L2
.L3:
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	leaq	.LC0(%rip), %rcx
	movl	%eax, %edx
	call	printf
	addq	$1, -8(%rbp)
.L2:
	movq	-8(%rbp), %rax
	cmpq	24(%rbp), %rax
	jb	.L3
	movl	$10, %ecx
	call	putchar
	nop
	addq	$48, %rsp
	popq	%rbp
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
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movsd	d(%rip), %xmm1
	movss	f(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movapd	%xmm1, %xmm2
	movapd	%xmm2, %xmm1
	movq	%xmm2, %rcx
	movapd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	movq	%xmm2, %rdx
	leaq	.LC1(%rip), %rax
	movapd	%xmm1, %xmm2
	movq	%rcx, %r8
	movapd	%xmm0, %xmm1
	movq	%rax, %rcx
	call	printf
	leaq	f(%rip), %rax
	movl	$4, %edx
	movq	%rax, %rcx
	call	show_bytes
	leaq	d(%rip), %rax
	movl	$8, %edx
	movq	%rax, %rcx
	call	show_bytes
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
