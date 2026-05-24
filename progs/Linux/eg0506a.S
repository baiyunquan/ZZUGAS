	.file	"eg0506.c"
	.intel_syntax noprefix
	.text
	.globl	caculator
	.type	caculator, @function
caculator:
.LFB11:
	.cfi_startproc
	mov	ecx, edx
	sub	edi, 42
	cmp	dil, 20
	ja	.L10
	movzx	edi, dil
	jmp	[QWORD PTR .L4[0+rdi*8]]
	.section	.rodata
	.align 8
	.align 4
.L4:
	.quad	.L9
	.quad	.L8
	.quad	.L10
	.quad	.L7
	.quad	.L10
	.quad	.L6
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L10
	.quad	.L5
	.quad	.L10
	.quad	.L3
	.text
.L8:
	lea	eax, [rdx+rsi]
	ret
.L7:
	mov	eax, esi
	sub	eax, edx
	ret
.L9:
	mov	eax, edx
	imul	eax, esi
	ret
.L6:
	mov	eax, esi
	cdq
	idiv	ecx
	ret
.L5:
	lea	eax, [rsi+rsi]
	ret
.L3:
	mov	eax, edx
	sar	eax, 2
	ret
.L10:
	mov	eax, 0
	ret
	.cfi_endproc
.LFE11:
	.size	caculator, .-caculator
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%c"
.LC1:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rsi, [rsp+15]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	__isoc99_scanf
	movsx	edi, BYTE PTR [rsp+15]
	mov	edx, -300
	mov	esi, 200
	call	caculator
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 24
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
