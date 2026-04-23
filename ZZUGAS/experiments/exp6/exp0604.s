	.file	"exp0604.c"
	.intel_syntax noprefix
	.section	.rodata
	.align 8
.LC0:
	.ascii	"10 | 0 1 2 3 4 5 6 7 8 9 A B C D "
	.string	"E F\n-- + --------------------------------\n20 |  ! \" # $ % & ' ( ) * + , - . /\n30 |0 1 2 3 4 5 6 7 8 9 : ; < = > ?\n40 |@ A B C D E F G H I J K L M N O\n50 |P Q R S T U V W X Y Z [ \\ ] ^ _\n60 |` a b c d e f g h i j k l m n o\n70 |p q r s t u v w x y z { | } ~\n"
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
	mov	rax, QWORD PTR stdout[rip]
	mov	rcx, rax
	mov	edx, 289
	mov	esi, 1
	mov	edi, OFFSET FLAT:.LC0
	call	fwrite
	mov	eax, 0
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
