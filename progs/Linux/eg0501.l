GAS LISTING ./5/eg0501.s 			page 1


   1              		.file	"eg0501.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	diffabs
   5              		.type	diffabs, @function
   6              	diffabs:
   7              	.LFB0:
   8              		.cfi_startproc
   9 0000 39F7     		cmp	edi, esi
  10 0002 7D05     		jge	.L4
  11 0004 89F0     		mov	eax, esi
  12 0006 29F8     		sub	eax, edi
  13              	.L3:
  14 0008 C3       		ret
  15              	.L4:
  16 0009 89F8     		mov	eax, edi
  17 000b 29F0     		sub	eax, esi
  18 000d C3       		ret
  19              		.cfi_endproc
  20              	.LFE0:
  21              		.size	diffabs, .-diffabs
  22              		.globl	find
  23              		.type	find, @function
  24              	find:
  25              	.LFB1:
  26              		.cfi_startproc
  27 000e B8000000 		mov	eax, 0
  27      00
  28 0013 EB03     		jmp	.L6
  29              	.L10:
  30 0015 83C001   		add	eax, 1
  31              	.L6:
  32 0018 83F802   		cmp	eax, 2
  33 001b 7F0A     		jg	.L9
  34 001d 4863D0   		movsx	rdx, eax
  35 0020 393497   		cmp	DWORD PTR [rdi+rdx*4], esi
  36 0023 75F0     		jne	.L10
  37 0025 EB05     		jmp	.L5
  38              	.L9:
  39 0027 B8FFFFFF 		mov	eax, -1
  39      FF
  40              	.L5:
  41 002c C3       		ret
  42              		.cfi_endproc
  43              	.LFE1:
  44              		.size	find, .-find
  45              		.ident	"GCC: (GNU) 10.3.1"
  46              		.section	.note.GNU-stack,"",@progbits
