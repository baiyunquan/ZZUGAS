	.file	"eg0504.c"
	.intel_syntax noprefix
	.text
	.globl	sub_of
	.type	sub_of, @function
sub_of:
.LFB11:
	.cfi_startproc
	sub	edi, esi
	mov	DWORD PTR [rdx], edi
	mov	eax, 0
	ret
	.cfi_endproc
.LFE11:
	.size	sub_of, .-sub_of
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"x-y = %d = %u = %x"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rdx, [rsp+12]
	mov	esi, -999999999
	mov	edi, 1234567890
	call	sub_of
	mov	esi, DWORD PTR [rsp+12]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC0
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
