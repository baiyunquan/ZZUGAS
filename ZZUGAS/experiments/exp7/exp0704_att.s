	.file	"exp0704.c"
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$100032, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-100016(%rbp), %rax
	movl	$100001, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	movl	$2, -100028(%rbp)
	jmp	.L2
.L6:
	movl	-100028(%rbp), %eax
	cltq
	movzbl	-100016(%rbp,%rax), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L3
	movl	-100028(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -100024(%rbp)
	jmp	.L4
.L5:
	movl	-100024(%rbp), %eax
	cltq
	movb	$1, -100016(%rbp,%rax)
	movl	-100028(%rbp), %eax
	addl	%eax, -100024(%rbp)
.L4:
	cmpl	$100000, -100024(%rbp)
	jle	.L5
.L3:
	addl	$1, -100028(%rbp)
.L2:
	cmpl	$100000, -100028(%rbp)
	jle	.L6
	movl	$0, -100020(%rbp)
	movl	$2, -100028(%rbp)
	jmp	.L7
.L10:
	movl	-100028(%rbp), %eax
	cltq
	movzbl	-100016(%rbp,%rax), %eax
	testb	%al, %al
	je	.L8
	movl	$0, %eax
	jmp	.L9
.L8:
	movl	$1, %eax
.L9:
	addl	%eax, -100020(%rbp)
	addl	$1, -100028(%rbp)
.L7:
	cmpl	$100000, -100028(%rbp)
	jle	.L10
	movl	-100020(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L12
	call	__stack_chk_fail
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
