	.file	"eg0517.c"
	.intel_syntax noprefix
	.text
	.globl	del_char1
	.type	del_char1, @function
del_char1:
.LFB11:
	.cfi_startproc
	mov	ecx, 0
	mov	edx, 0
	jmp	.L2
.L3:
	add	edx, 1
.L2:
	movsx	rax, edx
	movzx	eax, BYTE PTR [rdi+rax]
	test	al, al
	je	.L5
	cmp	al, sil
	je	.L3
	movsx	r8, ecx
	mov	BYTE PTR [rdi+r8], al
	lea	ecx, [rcx+1]
	jmp	.L3
.L5:
	movsx	rcx, ecx
	mov	BYTE PTR [rdi+rcx], 0
	ret
	.cfi_endproc
.LFE11:
	.size	del_char1, .-del_char1
	.globl	del_char
	.type	del_char, @function
del_char:
.LFB12:
	.cfi_startproc
	mov	rdx, rdi
	jmp	.L7
.L8:
	add	rdi, 1
.L7:
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L10
	cmp	al, sil
	je	.L8
	mov	BYTE PTR [rdx], al
	lea	rdx, [rdx+1]
	jmp	.L8
.L10:
	mov	BYTE PTR [rdx], 0
	ret
	.cfi_endproc
.LFE12:
	.size	del_char, .-del_char
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	sub	rsp, 40
	.cfi_def_cfa_offset 48
	movabs	rax, 2338328219631577172
	movabs	rdx, 7598263559140745248
	mov	QWORD PTR [rsp], rax
	mov	QWORD PTR [rsp+8], rdx
	mov	WORD PTR [rsp+16], 26478
	mov	BYTE PTR [rsp+18], 0
	mov	rdi, rsp
	call	puts
	mov	esi, 32
	mov	rdi, rsp
	call	del_char
	mov	rsi, rsp
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 40
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
