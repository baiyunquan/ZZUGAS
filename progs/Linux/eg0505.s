	.file	"eg0505.c"
	.intel_syntax noprefix
	.text
	.globl	print
	.type	print, @function
print:
.LFB11:
	.cfi_startproc
	lea	eax, [rsi-1]
	cmp	eax, 7
	ja	.L3
	movsx	rsi, esi
	mov	rax, QWORD PTR [rdi-8+rsi*8]
	ret
.L3:
	mov	eax, 0
	ret
	.cfi_endproc
.LFE11:
	.size	print, .-print
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"%s"
.LC2:
	.string	"input error"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	lea	rsi, [rsp+12]
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	__isoc99_scanf
	mov	esi, DWORD PTR [rsp+12]
	mov	edi, OFFSET FLAT:msgs
	call	print
	test	rax, rax
	je	.L5
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
.L6:
	mov	eax, 0
	add	rsp, 24
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	jmp	.L6
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	msgs
	.section	.rodata.str1.1
.LC3:
	.string	"Chapter 1: Fundamentals\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Chapter 2: Data Representation\n"
	.align 8
.LC5:
	.string	"Chapter 3: x86 Intruction Set Architecture\n"
	.align 8
.LC6:
	.string	"Chapter 4: Basic Instructions\n"
	.section	.rodata.str1.1
.LC7:
	.string	"Chapter 5: Program Structure\n"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"Chapter 6: ARM Intruction Set Architecture\n"
	.align 8
.LC9:
	.string	"Chapter 7: ARM Assembly Language Programming\n"
	.align 8
.LC10:
	.string	"Chapter 8: Assembly Language Applications\n"
	.data
	.align 32
	.type	msgs, @object
	.size	msgs, 64
msgs:
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
