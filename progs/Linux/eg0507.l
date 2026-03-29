GAS LISTING ./5/eg0507.s 			page 1


   1              		.file	"eg0507.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	fac
   5              		.type	fac, @function
   6              	fac:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 B8010000 		mov	eax, 1
   9      00
  10 0005 EB06     		jmp	.L2
  11              	.L3:
  12 0007 0FAFC7   		imul	eax, edi
  13 000a 83EF01   		sub	edi, 1
  14              	.L2:
  15 000d 83FF01   		cmp	edi, 1
  16 0010 7FF5     		jg	.L3
  17 0012 C3       		ret
  18              		.cfi_endproc
  19              	.LFE11:
  20              		.size	fac, .-fac
  21              		.section	.rodata.str1.1,"aMS",@progbits,1
  22              	.LC0:
  23 0000 256400   		.string	"%d"
  24              		.text
  25              		.globl	main
  26              		.type	main, @function
  27              	main:
  28              	.LFB12:
  29              		.cfi_startproc
  30 0013 4883EC08 		sub	rsp, 8
  31              		.cfi_def_cfa_offset 16
  32 0017 BF0A0000 		mov	edi, 10
  32      00
  33 001c E8000000 		call	fac
  33      00
  34 0021 89C6     		mov	esi, eax
  35 0023 BF000000 		mov	edi, OFFSET FLAT:.LC0
  35      00
  36 0028 B8000000 		mov	eax, 0
  36      00
  37 002d E8000000 		call	printf
  37      00
  38 0032 B8000000 		mov	eax, 0
  38      00
  39 0037 4883C408 		add	rsp, 8
  40              		.cfi_def_cfa_offset 8
  41 003b C3       		ret
  42              		.cfi_endproc
  43              	.LFE12:
  44              		.size	main, .-main
  45              		.ident	"GCC: (GNU) 10.3.1"
  46              		.section	.note.GNU-stack,"",@progbits
