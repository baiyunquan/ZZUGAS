	.file	"eg0507.c"
	.intel_syntax noprefix
	.text
	.globl	fac
	.type	fac, @function
fac:
.LFB11:
	.cfi_startproc
	mov	eax, 1
 .L4: cmp	edi, 1
	jng	.L2
.L3:
	imul	eax, edi
	sub	edi, 1
    jmp .L4
.L2:
	ret
	.cfi_endproc
.LFE11:
	.size	fac, .-fac
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	edi, 10
	call	fac
	mov	esi, eax
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
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
