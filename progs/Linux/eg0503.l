GAS LISTING ./5/eg0503.s 			page 1


   1              		.file	"eg0503.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	Uchar
   5              		.type	Uchar, @function
   6              	Uchar:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 89F8     		mov	eax, edi
  10 0002 8D57BF   		lea	edx, [rdi-65]
  11 0005 80FA19   		cmp	dl, 25
  12 0008 7703     		ja	.L2
  13 000a 8D4720   		lea	eax, [rdi+32]
  14              	.L2:
  15 000d C3       		ret
  16              		.cfi_endproc
  17              	.LFE0:
  18              		.size	Uchar, .-Uchar
  19              		.ident	"GCC: (GNU) 10.3.1"
  20              		.section	.note.GNU-stack,"",@progbits
