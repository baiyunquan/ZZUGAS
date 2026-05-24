	.file	"eg0526.c"
	.intel_syntax noprefix
	.text
	.globl	swap_add
	.type	swap_add, @function
swap_add:
.LFB0:
	.cfi_startproc
	mov	rax, QWORD PTR [rdi]
	mov	rdx, QWORD PTR [rsi]
	mov	QWORD PTR [rdi], rdx
	mov	QWORD PTR [rsi], rax
	add	rax, rdx
	ret
	.cfi_endproc
.LFE0:
	.size	swap_add, .-swap_add
	.globl	caller
	.type	caller, @function
caller:
.LFB1:
	.cfi_startproc
	sub	rsp, 16
	.cfi_def_cfa_offset 24
	mov	QWORD PTR [rsp+8], 534
	mov	QWORD PTR [rsp], 1057
	mov	rsi, rsp
	lea	rdi, [rsp+8]
	call	swap_add
	mov	rdx, QWORD PTR [rsp+8]
	sub	rdx, QWORD PTR [rsp]
	imul	rax, rdx
	add	rsp, 16
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
	.size	caller, .-caller
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
