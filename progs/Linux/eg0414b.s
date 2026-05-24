	.file	"eg0414b.c"
	.intel_syntax noprefix
	.text
	.globl	eg0414a
	.type	eg0414a, @function
eg0414a:
.LFB0:
	.cfi_startproc
	mov	rax, rdi
	mov	rdi, rdx
	mov	edx, 0
	div	rsi
	mov	QWORD PTR [rdi], rax
	mov	QWORD PTR [rcx], rdx
	ret
	.cfi_endproc
.LFE0:
	.size	eg0414a, .-eg0414a
	.globl	eg0414b
	.type	eg0414b, @function
eg0414b:
.LFB1:
	.cfi_startproc
	mov	rax, rdi
	mov	rdi, rdx
	cqo
	idiv	rsi
	mov	QWORD PTR [rdi], rax
	mov	QWORD PTR [rcx], rdx
	ret
	.cfi_endproc
.LFE1:
	.size	eg0414b, .-eg0414b
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
