	.file	"eg0418.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%x"
	.text
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	movsx	esi, WORD PTR num[rip]
	movzx	ecx, BYTE PTR n[rip]
	sar	esi, cl
	movzx	ecx, BYTE PTR m[rip]
	mov	eax, -1
	sal	eax, cl
	not	eax
	and	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.globl	m
	.data
	.type	m, @object
	.size	m, 1
m:
	.byte	8
	.globl	n
	.type	n, @object
	.size	n, 1
n:
	.byte	4
	.globl	num
	.align 2
	.type	num, @object
	.size	num, 2
num:
	.value	-21555
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
