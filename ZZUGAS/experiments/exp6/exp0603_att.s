	.file	"exp0603.c"
	.text
	.p2align 4
	.globl	insertSort
	.def	insertSort;	.scl	2;	.type	32;	.endef
	.seh_proc	insertSort
insertSort:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	cmpl	$1, %edx
	jle	.L1
	leaq	4(%rcx), %r11
	leal	-1(%rdx), %ebx
	xorl	%r10d, %r10d
	.p2align 4
	.p2align 3
.L6:
	movl	(%r11), %r9d
	movl	%r10d, %edx
	movq	%r11, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L3:
	movl	-4(%rax), %r8d
	cmpl	%r9d, %r8d
	jle	.L11
	subl	$1, %edx
	movl	%r8d, (%rax)
	subq	$4, %rax
	cmpl	$-1, %edx
	jne	.L3
	movq	%rcx, %rax
.L4:
	addq	$1, %r10
	movl	%r9d, (%rax)
	addq	$4, %r11
	cmpq	%r10, %rbx
	jne	.L6
.L1:
	popq	%rbx
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	addl	$1, %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,4), %rax
	jmp	.L4
	.seh_endproc
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	leaq	32(%rsp), %rcx
	movdqu	.LC0(%rip), %xmm0
	movl	$5, %edx
	movl	$1, 48(%rsp)
	movups	%xmm0, 32(%rsp)
	call	insertSort
	xorl	%eax, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 16
.LC0:
	.long	5
	.long	4
	.long	3
	.long	2
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
