	.file	"eg0217.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %.2x\0"
	.text
	.p2align 4
	.globl	show_bytes
	.def	show_bytes;	.scl	2;	.type	32;	.endef
	.seh_proc	show_bytes
show_bytes:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L2
	movq	%rcx, %rbx
	leaq	(%rcx,%rdx), %rsi
	.p2align 4
	.p2align 3
.L3:
	movzbl	(%rbx), %edx
	leaq	.LC0(%rip), %rcx
	addq	$1, %rbx
	call	__mingw_printf
	cmpq	%rsi, %rbx
	jne	.L3
.L2:
	movl	$10, %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	jmp	putchar
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "sizeof X = %d \12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$12, %edx
	leaq	.LC1(%rip), %rcx
	call	__mingw_printf
	movl	$12, %edx
	leaq	x(%rip), %rcx
	call	show_bytes
	xorl	%eax, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	x
	.data
	.align 8
x:
	.long	-100
	.byte	97
	.space 3
	.long	-200
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
