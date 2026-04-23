	.file	"exp0603.c"
	.intel_syntax noprefix
	.text
	.globl	insertSort
	.type	insertSort, @function
insertSort:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-12], 1
	jmp	.L2
.L6:
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-12]
	sub	eax, 1
	mov	DWORD PTR [rbp-8], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	add	rax, 1
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	sub	DWORD PTR [rbp-8], 1
.L3:
	cmp	DWORD PTR [rbp-8], 0
	js	.L4
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-4]
	jg	.L5
.L4:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	add	rax, 1
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-4]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-12], 1
.L2:
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-28]
	jl	.L6
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	insertSort, .-insertSort
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	printList
	.type	printList, @function
printList:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-4], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	add	DWORD PTR [rbp-4], 1
.L8:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-28]
	jl	.L9
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	printList, .-printList
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rbp-8], rax
	xor	eax, eax
	mov	DWORD PTR [rbp-32], 587
	mov	DWORD PTR [rbp-28], -632
	mov	DWORD PTR [rbp-24], 777
	mov	DWORD PTR [rbp-20], 234
	mov	DWORD PTR [rbp-16], -34
	lea	rax, [rbp-32]
	mov	esi, 5
	mov	rdi, rax
	call	printList
	lea	rax, [rbp-32]
	mov	esi, 5
	mov	rdi, rax
	call	insertSort
	lea	rax, [rbp-32]
	mov	esi, 5
	mov	rdi, rax
	call	printList
	mov	eax, 0
	mov	rdx, QWORD PTR [rbp-8]
	xor	rdx, QWORD PTR fs:40
	je	.L12
	call	__stack_chk_fail
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
