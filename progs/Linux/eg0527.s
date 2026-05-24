	.file	"eg0527.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	mov	DWORD PTR [rsp+10], 1819043144
	mov	WORD PTR [rsp+14], 111
	lea	rdi, [rsp+10]
	call	print
	mov	eax, 0
	add	rsp, 24
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
