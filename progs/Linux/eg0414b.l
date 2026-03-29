GAS LISTING ./progs/eg0414b.s 			page 1


   1              		.file	"eg0414b.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	eg0414a
   5              		.type	eg0414a, @function
   6              	eg0414a:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 4889F8   		mov	rax, rdi
  10 0003 4889D7   		mov	rdi, rdx
  11 0006 BA000000 		mov	edx, 0
  11      00
  12 000b 48F7F6   		div	rsi
  13 000e 488907   		mov	QWORD PTR [rdi], rax
  14 0011 488911   		mov	QWORD PTR [rcx], rdx
  15 0014 C3       		ret
  16              		.cfi_endproc
  17              	.LFE0:
  18              		.size	eg0414a, .-eg0414a
  19              		.globl	eg0414b
  20              		.type	eg0414b, @function
  21              	eg0414b:
  22              	.LFB1:
  23              		.cfi_startproc
  24 0015 4889F8   		mov	rax, rdi
  25 0018 4889D7   		mov	rdi, rdx
  26 001b 4899     		cqo
  27 001d 48F7FE   		idiv	rsi
  28 0020 488907   		mov	QWORD PTR [rdi], rax
  29 0023 488911   		mov	QWORD PTR [rcx], rdx
  30 0026 C3       		ret
  31              		.cfi_endproc
  32              	.LFE1:
  33              		.size	eg0414b, .-eg0414b
  34              		.ident	"GCC: (GNU) 10.3.1"
  35              		.section	.note.GNU-stack,"",@progbits
