GAS LISTING ./5/eg0502.s 			page 1


   1              		.file	"eg0502.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	iabs
   5              		.type	iabs, @function
   6              	iabs:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 89F8     		mov	eax, edi
  10 0002 85FF     		test	edi, edi
  11 0004 7801     		js	.L3
  12              	.L2:
  13 0006 C3       		ret
  14              	.L3:
  15 0007 F7D8     		neg	eax
  16 0009 EBFB     		jmp	.L2
  17              		.cfi_endproc
  18              	.LFE0:
  19              		.size	iabs, .-iabs
  20              		.ident	"GCC: (GNU) 10.3.1"
  21              		.section	.note.GNU-stack,"",@progbits
