GAS LISTING ./progs/eg0401.s 			page 1


   1              		.file	"eg0401.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	exchange
   5              		.type	exchange, @function
   6              	exchange:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 488B07   		mov	rax, QWORD PTR [rdi]
  10 0003 488937   		mov	QWORD PTR [rdi], rsi
  11 0006 C3       		ret
  12              		.cfi_endproc
  13              	.LFE0:
  14              		.size	exchange, .-exchange
  15              		.ident	"GCC: (GNU) 10.3.1"
  16              		.section	.note.GNU-stack,"",@progbits
