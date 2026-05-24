	.file	"eg0102.c"
	.intel_syntax noprefix
	.text
	.globl	add
	.type	add, @function
add:
.LFB23:
	.cfi_startproc
	lea	eax, [rdi+rsi]
	ret
	.cfi_endproc
.LFE23:
	.size	add, .-add
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, 256
	mov	edi, 100
	call	add
	mov	edx, eax
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
