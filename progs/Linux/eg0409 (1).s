	.file	"eg0409.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"x-y =%d\n"
.LC1:
	.string	"c =%c\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, DWORD PTR x[rip]
	sub	esi, DWORD PTR y[rip]
	sub	esi, 250
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	movsx	esi, BYTE PTR c[rip]
	sub	esi, 32
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.globl	c
	.data
	.type	c, @object
	.size	c, 1
c:
	.byte	97
	.globl	y
	.align 4
	.type	y, @object
	.size	y, 4
y:
	.long	-978522123
	.globl	x
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	123456789
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
