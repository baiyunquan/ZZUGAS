AARCH64 GAS  /tmp/cck5zubq.s 			page 1


   1              	# 1 "./eg0705.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./eg0705.S"
   8              	 .arch armv8-a
   9              	 .file "eg0705.c"
  10              	 .text
  11              	 .align 2
  12              	 .global isletter
  13              	 .type isletter, %function
  14              	isletter:
  15              	.LFB11:
  16              	 .cfi_startproc
  17              	
  18              	
  19              	
  20              	
  21              	
  22              	
  23 0000 410F8052 	    mov w1, 122
  24              	
  25 0004 1F840171 	    cmp w0, 97
  26 0008 0220417A 	    ccmp w0,w1,#0b0010,hs
  27 000c 68000054 	    bhi .L3
  28 0010 20008052 	 mov w0, 1
  29              	
  30              	.L1:
  31 0014 C0035FD6 	 ret
  32              	.L3:
  33 0018 00008012 	 mov w0, -1
  34 001c FEFFFF17 	 b .L1
  35              	 .cfi_endproc
  36              	.LFE11:
  37              	 .size isletter, .-isletter
  38              	 .align 2
  39              	 .global main
  40              	 .type main, %function
  41              	main:
  42              	.LFB12:
  43              	 .cfi_startproc
  44 0020 FD7BBFA9 	 stp x29, x30, [sp, -16]!
  45              	 .cfi_def_cfa_offset 16
  46              	 .cfi_offset 29, -16
  47              	 .cfi_offset 30, -8
  48 0024 FD030091 	 mov x29, sp
  49 0028 20088052 	 mov w0, 'A'
  50 002c 00000094 	 bl isletter
  51 0030 1F040071 	 cmp w0, 1
  52 0034 C0000054 	 beq .L8
  53 0038 C0098052 	 mov w0, 78
  54 003c 00000094 	 bl putchar
  55              	.L6:
  56 0040 00008052 	 mov w0, 0
  57 0044 FD7BC1A8 	 ldp x29, x30, [sp], 16
AARCH64 GAS  /tmp/cck5zubq.s 			page 2


  58              	 .cfi_remember_state
  59              	 .cfi_restore 30
  60              	 .cfi_restore 29
  61              	 .cfi_def_cfa_offset 0
  62 0048 C0035FD6 	 ret
  63              	.L8:
  64              	 .cfi_restore_state
  65 004c 200B8052 	 mov w0, 89
  66 0050 00000094 	 bl putchar
  67 0054 FBFFFF17 	 b .L6
  68              	 .cfi_endproc
  69              	.LFE12:
  70              	 .size main, .-main
  71              	 .ident "GCC: (GNU) 10.3.1"
  72              	 .section .note.GNU-stack,"",@progbits
