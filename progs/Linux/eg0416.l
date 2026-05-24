GAS LISTING ./progs/eg0416.s 			page 1


   1              		.file	"eg0416.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	CtoF
   5              		.type	CtoF, @function
   6              	CtoF:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 0FBFFF   		movsx	edi, di
  10 0003 8D14FF   		lea	edx, [rdi+rdi*8]
  11 0006 4863C2   		movsx	rax, edx
  12 0009 4869C067 		imul	rax, rax, 1717986919
  12      666666
  13 0010 48C1F821 		sar	rax, 33
  14 0014 C1FA1F   		sar	edx, 31
  15 0017 29D0     		sub	eax, edx
  16 0019 83C020   		add	eax, 32
  17 001c C3       		ret
  18              		.cfi_endproc
  19              	.LFE11:
  20              		.size	CtoF, .-CtoF
  21              		.section	.rodata.str1.1,"aMS",@progbits,1
  22              	.LC0:
  23 0000 256400   		.string	"%d"
  24              		.text
  25              		.globl	main
  26              		.type	main, @function
  27              	main:
  28              	.LFB12:
  29              		.cfi_startproc
  30 001d 4883EC08 		sub	rsp, 8
  31              		.cfi_def_cfa_offset 16
  32 0021 0FBF3D00 		movsx	edi, WORD PTR C[rip]
  32      000000
  33 0028 E8000000 		call	CtoF
  33      00
  34 002d 0FBFF0   		movsx	esi, ax
  35 0030 BF000000 		mov	edi, OFFSET FLAT:.LC0
  35      00
  36 0035 B8000000 		mov	eax, 0
  36      00
  37 003a E8000000 		call	printf
  37      00
  38 003f B8000000 		mov	eax, 0
  38      00
  39 0044 4883C408 		add	rsp, 8
  40              		.cfi_def_cfa_offset 8
  41 0048 C3       		ret
  42              		.cfi_endproc
  43              	.LFE12:
  44              		.size	main, .-main
  45              		.globl	C
  46              		.data
  47              		.align 2
  48              		.type	C, @object
  49              		.size	C, 2
  50              	C:
GAS LISTING ./progs/eg0416.s 			page 2


  51 0000 1A00     		.value	26
  52              		.ident	"GCC: (GNU) 10.3.1"
  53              		.section	.note.GNU-stack,"",@progbits
