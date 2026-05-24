	.file	"eg0415.c"
	.intel_syntax noprefix
	.text
	.globl	sum
	.type	sum, @function
sum:
.LFB11:
	.cfi_startproc
	lea	rax, [rdi+1]
	imul	rax, rdi
	shr	rax
	ret
	.cfi_endproc
.LFE11:
	.size	sum, .-sum
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%lu"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	rdi, QWORD PTR N[rip]
	call	sum
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	N
	.data
	.align 8
	.type	N, @object
	.size	N, 8
N:
	.quad	3456
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
