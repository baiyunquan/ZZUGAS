	.file	"eg0401.c"
	.intel_syntax noprefix
	.text
	.globl	exchange
	.type	exchange, @function
exchange:
.LFB0:
	.cfi_startproc
	mov	rax, QWORD PTR [rdi]
	mov	QWORD PTR [rdi], rsi
	ret
	.cfi_endproc
.LFE0:
	.size	exchange, .-exchange
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
