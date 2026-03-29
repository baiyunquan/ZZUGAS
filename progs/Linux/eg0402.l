GAS LISTING ./progs/eg0402.s 			page 1


   1              		.file	"eg0402.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	scale
   5              		.type	scale, @function
   6              	scale:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 8D04B7   		lea	eax, [rdi+rsi*4]
  10 0003 8D1452   		lea	edx, [rdx+rdx*2]
  11 0006 8D0490   		lea	eax, [rax+rdx*4]
  12 0009 C3       		ret
  13              		.cfi_endproc
  14              	.LFE0:
  15              		.size	scale, .-scale
  16              		.ident	"GCC: (GNU) 10.3.1"
  17              		.section	.note.GNU-stack,"",@progbits
