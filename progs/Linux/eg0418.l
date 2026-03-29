GAS LISTING ./progs/eg0418.s 			page 1


   1              		.file	"eg0418.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.section	.rodata.str1.1,"aMS",@progbits,1
   5              	.LC0:
   6 0000 257800   		.string	"%x"
   7              		.text
   8              		.globl	main
   9              		.type	main, @function
  10              	main:
  11              	.LFB11:
  12              		.cfi_startproc
  13 0000 4883EC08 		sub	rsp, 8
  14              		.cfi_def_cfa_offset 16
  15 0004 0FBF3500 		movsx	esi, WORD PTR num[rip]
  15      000000
  16 000b 0FB60D00 		movzx	ecx, BYTE PTR n[rip]
  16      000000
  17 0012 D3FE     		sar	esi, cl
  18 0014 0FB60D00 		movzx	ecx, BYTE PTR m[rip]
  18      000000
  19 001b B8FFFFFF 		mov	eax, -1
  19      FF
  20 0020 D3E0     		sal	eax, cl
  21 0022 F7D0     		not	eax
  22 0024 21C6     		and	esi, eax
  23 0026 BF000000 		mov	edi, OFFSET FLAT:.LC0
  23      00
  24 002b B8000000 		mov	eax, 0
  24      00
  25 0030 E8000000 		call	printf
  25      00
  26 0035 B8000000 		mov	eax, 0
  26      00
  27 003a 4883C408 		add	rsp, 8
  28              		.cfi_def_cfa_offset 8
  29 003e C3       		ret
  30              		.cfi_endproc
  31              	.LFE11:
  32              		.size	main, .-main
  33              		.globl	m
  34              		.data
  35              		.type	m, @object
  36              		.size	m, 1
  37              	m:
  38 0000 08       		.byte	8
  39              		.globl	n
  40              		.type	n, @object
  41              		.size	n, 1
  42              	n:
  43 0001 04       		.byte	4
  44              		.globl	num
  45              		.align 2
  46              		.type	num, @object
  47              		.size	num, 2
  48              	num:
  49 0002 CDAB     		.value	-21555
GAS LISTING ./progs/eg0418.s 			page 2


  50              		.ident	"GCC: (GNU) 10.3.1"
  51              		.section	.note.GNU-stack,"",@progbits
