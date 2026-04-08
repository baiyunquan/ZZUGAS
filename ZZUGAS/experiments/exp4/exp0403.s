	.file	"exp0403.c"
	.intel_syntax noprefix
	.text
	.globl	arith2
	.type	arith2, @function
arith2:
.LFB23:
	.cfi_startproc
	or	rsi, rdi
	sar	rsi, 3
	not	rsi
	mov	rax, rdx
	sub	rax, rsi
	ret
	.cfi_endproc
.LFE23:
	.size	arith2, .-arith2
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"1\n0000006a"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
