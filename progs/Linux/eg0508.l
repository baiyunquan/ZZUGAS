GAS LISTING ./5/eg0508.s 			page 1


   1              		.file	"eg0508.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	fac
   5              		.type	fac, @function
   6              	fac:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 B8010000 		mov	eax, 1
   9      00
  10              	.L2:
  11 0005 0FAFC7   		imul	eax, edi
  12 0008 83EF01   		sub	edi, 1
  13 000b 83FF01   		cmp	edi, 1
  14 000e 7FF5     		jg	.L2
  15 0010 C3       		ret
  16              		.cfi_endproc
  17              	.LFE11:
  18              		.size	fac, .-fac
  19              		.section	.rodata.str1.1,"aMS",@progbits,1
  20              	.LC0:
  21 0000 256400   		.string	"%d"
  22              		.text
  23              		.globl	main
  24              		.type	main, @function
  25              	main:
  26              	.LFB12:
  27              		.cfi_startproc
  28 0011 4883EC08 		sub	rsp, 8
  29              		.cfi_def_cfa_offset 16
  30 0015 BF0A0000 		mov	edi, 10
  30      00
  31 001a E8000000 		call	fac
  31      00
  32 001f 89C6     		mov	esi, eax
  33 0021 BF000000 		mov	edi, OFFSET FLAT:.LC0
  33      00
  34 0026 B8000000 		mov	eax, 0
  34      00
  35 002b E8000000 		call	printf
  35      00
  36 0030 B8000000 		mov	eax, 0
  36      00
  37 0035 4883C408 		add	rsp, 8
  38              		.cfi_def_cfa_offset 8
  39 0039 C3       		ret
  40              		.cfi_endproc
  41              	.LFE12:
  42              		.size	main, .-main
  43              		.ident	"GCC: (GNU) 10.3.1"
  44              		.section	.note.GNU-stack,"",@progbits
