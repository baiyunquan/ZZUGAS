GAS LISTING ./5/eg0509.s 			page 1


   1              		.file	"eg0509.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	fac
   5              		.type	fac, @function
   6              	fac:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 B8010000 		mov	eax, 1
   9      00
  10 0005 BA010000 		mov	edx, 1
  10      00
  11 000a EB06     		jmp	.L2
  12              	.L3:
  13 000c 0FAFD0   		imul	edx, eax
  14 000f 83C001   		add	eax, 1
  15              	.L2:
  16 0012 39F8     		cmp	eax, edi
  17 0014 7EF6     		jle	.L3
  18 0016 89D0     		mov	eax, edx
  19 0018 C3       		ret
  20              		.cfi_endproc
  21              	.LFE11:
  22              		.size	fac, .-fac
  23              		.section	.rodata.str1.1,"aMS",@progbits,1
  24              	.LC0:
  25 0000 256400   		.string	"%d"
  26              		.text
  27              		.globl	main
  28              		.type	main, @function
  29              	main:
  30              	.LFB12:
  31              		.cfi_startproc
  32 0019 4883EC08 		sub	rsp, 8
  33              		.cfi_def_cfa_offset 16
  34 001d BF0A0000 		mov	edi, 10
  34      00
  35 0022 E8000000 		call	fac
  35      00
  36 0027 89C6     		mov	esi, eax
  37 0029 BF000000 		mov	edi, OFFSET FLAT:.LC0
  37      00
  38 002e B8000000 		mov	eax, 0
  38      00
  39 0033 E8000000 		call	printf
  39      00
  40 0038 B8000000 		mov	eax, 0
  40      00
  41 003d 4883C408 		add	rsp, 8
  42              		.cfi_def_cfa_offset 8
  43 0041 C3       		ret
  44              		.cfi_endproc
  45              	.LFE12:
  46              		.size	main, .-main
  47              		.ident	"GCC: (GNU) 10.3.1"
  48              		.section	.note.GNU-stack,"",@progbits
