GAS LISTING ./progs/eg0415.s 			page 1


   1              		.file	"eg0415.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	sum
   5              		.type	sum, @function
   6              	sum:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 488D4701 		lea	rax, [rdi+1]
  10 0004 480FAFC7 		imul	rax, rdi
  11 0008 48D1E8   		shr	rax
  12 000b C3       		ret
  13              		.cfi_endproc
  14              	.LFE11:
  15              		.size	sum, .-sum
  16              		.section	.rodata.str1.1,"aMS",@progbits,1
  17              	.LC0:
  18 0000 256C7500 		.string	"%lu"
  19              		.text
  20              		.globl	main
  21              		.type	main, @function
  22              	main:
  23              	.LFB12:
  24              		.cfi_startproc
  25 000c 4883EC08 		sub	rsp, 8
  26              		.cfi_def_cfa_offset 16
  27 0010 488B3D00 		mov	rdi, QWORD PTR N[rip]
  27      000000
  28 0017 E8000000 		call	sum
  28      00
  29 001c 4889C6   		mov	rsi, rax
  30 001f BF000000 		mov	edi, OFFSET FLAT:.LC0
  30      00
  31 0024 B8000000 		mov	eax, 0
  31      00
  32 0029 E8000000 		call	printf
  32      00
  33 002e B8000000 		mov	eax, 0
  33      00
  34 0033 4883C408 		add	rsp, 8
  35              		.cfi_def_cfa_offset 8
  36 0037 C3       		ret
  37              		.cfi_endproc
  38              	.LFE12:
  39              		.size	main, .-main
  40              		.globl	N
  41              		.data
  42              		.align 8
  43              		.type	N, @object
  44              		.size	N, 8
  45              	N:
  46 0000 800D0000 		.quad	3456
  46      00000000 
  47              		.ident	"GCC: (GNU) 10.3.1"
  48              		.section	.note.GNU-stack,"",@progbits
