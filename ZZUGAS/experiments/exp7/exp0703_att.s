	.file	"exp0703.c"
	.section	.rodata
.LC0:
	.string	"CZSOAP"
	.text
	.globl	dprflags
	.type	dprflags, @function
dprflags:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	$.LC0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -16(%rbp)
	movl	-12(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L2
	addl	$1, -16(%rbp)
.L2:
	movl	-12(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L3
	addl	$1, -16(%rbp)
.L3:
	movl	-12(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L4
	addl	$1, -16(%rbp)
.L4:
	movl	-12(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L5
	addl	$1, -16(%rbp)
.L5:
	movl	-12(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L6
	addl	$1, -16(%rbp)
.L6:
	movl	-12(%rbp), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L8
	addl	$1, -16(%rbp)
.L8:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	dprflags, .-dprflags
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	call	dprflags
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
