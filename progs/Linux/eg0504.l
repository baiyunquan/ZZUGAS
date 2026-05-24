GAS LISTING ./5/eg0504.s 			page 1


   1              		.file	"eg0504.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	sub_of
   5              		.type	sub_of, @function
   6              	sub_of:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 29F7     		sub	edi, esi
  10 0002 893A     		mov	DWORD PTR [rdx], edi
  11 0004 B8000000 		mov	eax, 0
  11      00
  12 0009 C3       		ret
  13              		.cfi_endproc
  14              	.LFE11:
  15              		.size	sub_of, .-sub_of
  16              		.section	.rodata.str1.1,"aMS",@progbits,1
  17              	.LC0:
  18 0000 782D7920 		.string	"x-y = %d = %u = %x"
  18      3D202564 
  18      203D2025 
  18      75203D20 
  18      257800
  19              		.text
  20              		.globl	main
  21              		.type	main, @function
  22              	main:
  23              	.LFB12:
  24              		.cfi_startproc
  25 000a 4883EC18 		sub	rsp, 24
  26              		.cfi_def_cfa_offset 32
  27 000e 488D5424 		lea	rdx, [rsp+12]
  27      0C
  28 0013 BE013665 		mov	esi, -999999999
  28      C4
  29 0018 BFD20296 		mov	edi, 1234567890
  29      49
  30 001d E8000000 		call	sub_of
  30      00
  31 0022 8B74240C 		mov	esi, DWORD PTR [rsp+12]
  32 0026 89F1     		mov	ecx, esi
  33 0028 89F2     		mov	edx, esi
  34 002a BF000000 		mov	edi, OFFSET FLAT:.LC0
  34      00
  35 002f B8000000 		mov	eax, 0
  35      00
  36 0034 E8000000 		call	printf
  36      00
  37 0039 B8000000 		mov	eax, 0
  37      00
  38 003e 4883C418 		add	rsp, 24
  39              		.cfi_def_cfa_offset 8
  40 0042 C3       		ret
  41              		.cfi_endproc
  42              	.LFE12:
  43              		.size	main, .-main
  44              		.ident	"GCC: (GNU) 10.3.1"
GAS LISTING ./5/eg0504.s 			page 2


  45              		.section	.note.GNU-stack,"",@progbits
