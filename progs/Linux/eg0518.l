GAS LISTING ./5/eg0518.s 			page 1


   1              		.file	"eg0518.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	mult2
   5              		.type	mult2, @function
   6              	mult2:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 89F8     		mov	eax, edi
  10 0002 0FAFC6   		imul	eax, esi
  11 0005 C3       		ret
  12              		.cfi_endproc
  13              	.LFE11:
  14              		.size	mult2, .-mult2
  15              		.globl	multstore
  16              		.type	multstore, @function
  17              	multstore:
  18              	.LFB12:
  19              		.cfi_startproc
  20 0006 53       		push	rbx
  21              		.cfi_def_cfa_offset 16
  22              		.cfi_offset 3, -16
  23 0007 4889D3   		mov	rbx, rdx
  24 000a E8000000 		call	mult2
  24      00
  25 000f 8903     		mov	DWORD PTR [rbx], eax
  26 0011 5B       		pop	rbx
  27              		.cfi_def_cfa_offset 8
  28 0012 C3       		ret
  29              		.cfi_endproc
  30              	.LFE12:
  31              		.size	multstore, .-multstore
  32              		.section	.rodata.str1.1,"aMS",@progbits,1
  33              	.LC0:
  34 0000 33202A20 		.string	"3 * 5 =%d"
  34      35203D25 
  34      6400
  35              		.text
  36              		.globl	main
  37              		.type	main, @function
  38              	main:
  39              	.LFB13:
  40              		.cfi_startproc
  41 0013 4883EC18 		sub	rsp, 24
  42              		.cfi_def_cfa_offset 32
  43 0017 488D5424 		lea	rdx, [rsp+12]
  43      0C
  44 001c BE050000 		mov	esi, 5
  44      00
  45 0021 BF030000 		mov	edi, 3
  45      00
  46 0026 E8000000 		call	multstore
  46      00
  47 002b 8B74240C 		mov	esi, DWORD PTR [rsp+12]
  48 002f BF000000 		mov	edi, OFFSET FLAT:.LC0
  48      00
  49 0034 B8000000 		mov	eax, 0
GAS LISTING ./5/eg0518.s 			page 2


  49      00
  50 0039 E8000000 		call	printf
  50      00
  51 003e B8000000 		mov	eax, 0
  51      00
  52 0043 4883C418 		add	rsp, 24
  53              		.cfi_def_cfa_offset 8
  54 0047 C3       		ret
  55              		.cfi_endproc
  56              	.LFE13:
  57              		.size	main, .-main
  58              		.ident	"GCC: (GNU) 10.3.1"
  59              		.section	.note.GNU-stack,"",@progbits
