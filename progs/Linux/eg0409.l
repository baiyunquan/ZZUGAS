GAS LISTING ./progs/eg0409.s 			page 1


   1              		.file	"eg0409.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.section	.rodata.str1.1,"aMS",@progbits,1
   5              	.LC0:
   6 0000 782D7920 		.string	"x-y =%d\n"
   6      3D25640A 
   6      00
   7              	.LC1:
   8 0009 63203D25 		.string	"c =%c\n"
   8      630A00
   9              		.text
  10              		.globl	main
  11              		.type	main, @function
  12              	main:
  13              	.LFB11:
  14              		.cfi_startproc
  15 0000 4883EC08 		sub	rsp, 8
  16              		.cfi_def_cfa_offset 16
  17 0004 8B350000 		mov	esi, DWORD PTR x[rip]
  17      0000
  18 000a 2B350000 		sub	esi, DWORD PTR y[rip]
  18      0000
  19 0010 81EEFA00 		sub	esi, 250
  19      0000
  20 0016 BF000000 		mov	edi, OFFSET FLAT:.LC0
  20      00
  21 001b B8000000 		mov	eax, 0
  21      00
  22 0020 E8000000 		call	printf
  22      00
  23 0025 0FBE3500 		movsx	esi, BYTE PTR c[rip]
  23      000000
  24 002c 83EE20   		sub	esi, 32
  25 002f BF000000 		mov	edi, OFFSET FLAT:.LC1
  25      00
  26 0034 B8000000 		mov	eax, 0
  26      00
  27 0039 E8000000 		call	printf
  27      00
  28 003e B8000000 		mov	eax, 0
  28      00
  29 0043 4883C408 		add	rsp, 8
  30              		.cfi_def_cfa_offset 8
  31 0047 C3       		ret
  32              		.cfi_endproc
  33              	.LFE11:
  34              		.size	main, .-main
  35              		.globl	c
  36              		.data
  37              		.type	c, @object
  38              		.size	c, 1
  39              	c:
  40 0000 61       		.byte	97
  41              		.globl	y
  42 0001 000000   		.align 4
  43              		.type	y, @object
GAS LISTING ./progs/eg0409.s 			page 2


  44              		.size	y, 4
  45              	y:
  46 0004 F5EFACC5 		.long	-978522123
  47              		.globl	x
  48              		.align 4
  49              		.type	x, @object
  50              		.size	x, 4
  51              	x:
  52 0008 15CD5B07 		.long	123456789
  53              		.ident	"GCC: (GNU) 10.3.1"
  54              		.section	.note.GNU-stack,"",@progbits
