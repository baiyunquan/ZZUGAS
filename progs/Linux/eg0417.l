GAS LISTING ./progs/eg0417.s 			page 1


   1              		.file	"eg0417.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	eg0420
   5              		.type	eg0420, @function
   6              	eg0420:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 4831F7   		xor	rdi, rsi
  10 0003 488D0452 		lea	rax, [rdx+rdx*2]
  11 0007 48C1E004 		sal	rax, 4
  12 000b 81E70F0F 		and	edi, 252645135
  12      0F0F
  13 0011 4829F8   		sub	rax, rdi
  14 0014 C3       		ret
  15              		.cfi_endproc
  16              	.LFE0:
  17              		.size	eg0420, .-eg0420
  18              		.ident	"GCC: (GNU) 10.3.1"
  19              		.section	.note.GNU-stack,"",@progbits
