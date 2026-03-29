GAS LISTING /tmp/ccGmsvNI.s 			page 1


   1              	# 1 "./5/eg0507a.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./5/eg0507a.S"
   8              	 .file "eg0507.c"
   9              	 .intel_syntax noprefix
  10              	 .text
  11              	 .globl fac
  12              	 .type fac, @function
  13              	fac:
  14              	.LFB11:
  15              	 .cfi_startproc
  16 0000 B8010000 	 mov eax, 1
  16      00
  17 0005 83FF01   	 .L4: cmp edi, 1
  18 0008 7E08     	 jng .L2
  19              	.L3:
  20 000a 0FAFC7   	 imul eax, edi
  21 000d 83EF01   	 sub edi, 1
  22 0010 EBF3     	    jmp .L4
  23              	.L2:
  24 0012 C3       	 ret
  25              	 .cfi_endproc
  26              	.LFE11:
  27              	 .size fac, .-fac
  28              	 .section .rodata.str1.1,"aMS",@progbits,1
  29              	.LC0:
  30 0000 256400   	 .string "%d"
  31              	 .text
  32              	 .globl main
  33              	 .type main, @function
  34              	main:
  35              	.LFB12:
  36              	 .cfi_startproc
  37 0013 4883EC08 	 sub rsp, 8
  38              	 .cfi_def_cfa_offset 16
  39 0017 BF0A0000 	 mov edi, 10
  39      00
  40 001c E8000000 	 call fac
  40      00
  41 0021 89C6     	 mov esi, eax
  42 0023 BF000000 	 mov edi, OFFSET FLAT:.LC0
  42      00
  43 0028 B8000000 	 mov eax, 0
  43      00
  44 002d E8000000 	 call printf
  44      00
  45 0032 B8000000 	 mov eax, 0
  45      00
  46 0037 4883C408 	 add rsp, 8
  47              	 .cfi_def_cfa_offset 8
  48 003b C3       	 ret
  49              	 .cfi_endproc
  50              	.LFE12:
GAS LISTING /tmp/ccGmsvNI.s 			page 2


  51              	 .size main, .-main
  52              	 .ident "GCC: (GNU) 10.3.1"
  53              	 .section .note.GNU-stack,"",@progbits
