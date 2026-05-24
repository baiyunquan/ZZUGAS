	.file	"exp0704.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 100032
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rbp-8], rax
	xor	eax, eax
	lea	rax, [rbp-100016]
	mov	edx, 100001
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	DWORD PTR [rbp-100028], 2
	jmp	.L2
.L6:
	mov	eax, DWORD PTR [rbp-100028]
	cdqe
	movzx	eax, BYTE PTR [rbp-100016+rax]
	xor	eax, 1
	test	al, al
	je	.L3
	mov	eax, DWORD PTR [rbp-100028]
	add	eax, eax
	mov	DWORD PTR [rbp-100024], eax
	jmp	.L4
.L5:
	mov	eax, DWORD PTR [rbp-100024]
	cdqe
	mov	BYTE PTR [rbp-100016+rax], 1
	mov	eax, DWORD PTR [rbp-100028]
	add	DWORD PTR [rbp-100024], eax
.L4:
	cmp	DWORD PTR [rbp-100024], 100000
	jle	.L5
.L3:
	add	DWORD PTR [rbp-100028], 1
.L2:
	cmp	DWORD PTR [rbp-100028], 100000
	jle	.L6
	mov	DWORD PTR [rbp-100020], 0
	mov	DWORD PTR [rbp-100028], 2
	jmp	.L7
.L10:
	mov	eax, DWORD PTR [rbp-100028]
	cdqe
	movzx	eax, BYTE PTR [rbp-100016+rax]
	test	al, al
	je	.L8
	mov	eax, 0
	jmp	.L9
.L8:
	mov	eax, 1
.L9:
	add	DWORD PTR [rbp-100020], eax
	add	DWORD PTR [rbp-100028], 1
.L7:
	cmp	DWORD PTR [rbp-100028], 100000
	jle	.L10
	mov	eax, DWORD PTR [rbp-100020]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	mov	rcx, QWORD PTR [rbp-8]
	xor	rcx, QWORD PTR fs:40
	je	.L12
	call	__stack_chk_fail
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
