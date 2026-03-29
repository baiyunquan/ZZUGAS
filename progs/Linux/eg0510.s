	.file	"eg0510.c"
	.intel_syntax noprefix
	.text
	.globl	mystrlen
	.type	mystrlen, @function
mystrlen:
.LFB11:
	.cfi_startproc
	mov	eax, 0
	jmp	.L2
.L3:
	add	eax, 1
	mov	rdi, rdx
.L2:
	lea	rdx, [rdi+1]
	cmp	BYTE PTR [rdi], 0
	jne	.L3
	ret
	.cfi_endproc
.LFE11:
	.size	mystrlen, .-mystrlen
	.globl	mystrlen1
	.type	mystrlen1, @function
mystrlen1:
.LFB12:
	.cfi_startproc
	mov	eax, 0
	jmp	.L5
.L6:
	add	eax, 1
.L5:
	movsx	rdx, eax
	cmp	BYTE PTR [rdi+rdx], 0
	jne	.L6
	ret
	.cfi_endproc
.LFE12:
	.size	mystrlen1, .-mystrlen1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	sub	rsp, 56
	.cfi_def_cfa_offset 64
	movabs	rax, 8316213789752649795
	movabs	rdx, 8389772277102698784
	mov	QWORD PTR [rsp], rax
	mov	QWORD PTR [rsp+8], rdx
	movabs	rax, 2335244403110607218
	movabs	rdx, 7503110703212666977
	mov	QWORD PTR [rsp+16], rax
	mov	QWORD PTR [rsp+24], rdx
	movabs	rax, 13081381331825513
	mov	QWORD PTR [rsp+32], rax
	mov	rdi, rsp
	call	mystrlen
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 56
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
