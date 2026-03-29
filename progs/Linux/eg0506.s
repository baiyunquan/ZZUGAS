	.file	"eg0506.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	caculator
	.type	caculator, @function
caculator:
.LFB11:
	.cfi_startproc
	sub	edi, 42
	mov	ecx, edx
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
	.p2align 4,,10
	.p2align 3
.L10:
	xor	eax, eax
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	mov	eax, edx
	sar	eax, 2
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	mov	eax, edx
	imul	eax, esi
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	lea	eax, [rdx+rsi]
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	mov	eax, esi
	sub	eax, edx
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	mov	eax, esi
	cdq
	idiv	ecx
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	lea	eax, [rsi+rsi]
	ret
	.cfi_endproc
.LFE11:
	.size	caculator, .-caculator
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%c"
.LC1:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	mov	edi, OFFSET FLAT:.LC0
	xor	eax, eax
	lea	rsi, [rsp+15]
	call	__isoc99_scanf
	movsx	edi, BYTE PTR [rsp+15]
	mov	edx, -300
	mov	esi, 200
	call	caculator
	mov	edi, OFFSET FLAT:.LC1
	mov	esi, eax
	xor	eax, eax
	call	printf
	xor	eax, eax
	add	rsp, 24
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
