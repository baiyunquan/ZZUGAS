	.file	"exp0302.c"
	.intel_syntax noprefix
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	edx, DWORD PTR array[rip]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	DWORD PTR i[rip], 1
	mov	edx, DWORD PTR array[rip+4]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	DWORD PTR i[rip], 2
	mov	edx, DWORD PTR array[rip+8]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	rax, QWORD PTR pi[rip]
	mov	edx, DWORD PTR [rax]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	rax, QWORD PTR pi[rip]
	lea	rdx, [rax+4]
	mov	QWORD PTR pi[rip], rdx
	mov	edx, DWORD PTR [rax+4]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	rax, QWORD PTR pi[rip]
	lea	rdx, [rax+4]
	mov	QWORD PTR pi[rip], rdx
	mov	edx, DWORD PTR [rax+4]
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	pi
	.data
	.align 8
	.type	pi, @object
	.size	pi, 8
pi:
	.quad	array
	.comm	i,4,4
	.globl	array
	.align 8
	.type	array, @object
	.size	array, 8
array:
	.long	12345
	.long	-12345
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
