GAS LISTING ./5/eg0520.s 			page 1


   1              		.file	"eg0520.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	fact
   5              		.type	fact, @function
   6              	fact:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 85FF     		test	edi, edi
  10 0002 7506     		jne	.L8
  11 0004 B8010000 		mov	eax, 1
  11      00
  12 0009 C3       		ret
  13              	.L8:
  14 000a 53       		push	rbx
  15              		.cfi_def_cfa_offset 16
  16              		.cfi_offset 3, -16
  17 000b 89FB     		mov	ebx, edi
  18 000d 8D7FFF   		lea	edi, [rdi-1]
  19 0010 E8000000 		call	fact
  19      00
  20 0015 0FAFC3   		imul	eax, ebx
  21 0018 5B       		pop	rbx
  22              		.cfi_def_cfa_offset 8
  23 0019 C3       		ret
  24              		.cfi_endproc
  25              	.LFE0:
  26              		.size	fact, .-fact
  27              		.globl	main
  28              		.type	main, @function
  29              	main:
  30              	.LFB1:
  31              		.cfi_startproc
  32 001a 4883EC08 		sub	rsp, 8
  33              		.cfi_def_cfa_offset 16
  34 001e BF030000 		mov	edi, 3
  34      00
  35 0023 E8000000 		call	fact
  35      00
  36 0028 B8000000 		mov	eax, 0
  36      00
  37 002d 4883C408 		add	rsp, 8
  38              		.cfi_def_cfa_offset 8
  39 0031 C3       		ret
  40              		.cfi_endproc
  41              	.LFE1:
  42              		.size	main, .-main
  43              		.ident	"GCC: (GNU) 10.3.1"
  44              		.section	.note.GNU-stack,"",@progbits
