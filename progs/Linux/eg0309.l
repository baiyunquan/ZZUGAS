GAS LISTING /tmp/cccDaLGL.s 			page 1


   1              	# 1 "./eg0309.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./eg0309.S"
   8              	 .file "eg0309.c"
   9              	 .intel_syntax noprefix
  10              	 .text
  11              	 .section .rodata.str1.1,"aMS",@progbits,1
  12              	.LC0:
  13 0000 25640A00 	 .string "%d\n"
  14              	 .text
  15              	 .globl main
  16              	 .type main, @function
  17              	main:
  18              	.LFB11:
  19              	 .cfi_startproc
  20 0000 4883EC08 	 sub rsp, 8
  21              	 .cfi_def_cfa_offset 16
  22 0004 8B350000 	 mov esi, DWORD PTR array[rip]
  22      0000
  23 000a BF000000 	 mov edi, OFFSET FLAT:.LC0
  23      00
  24 000f B8000000 	 mov eax, 0
  24      00
  25 0014 E8000000 	 call printf
  25      00
  26 0019 C7050000 	 mov DWORD PTR i[rip], 1
  26      00000100 
  26      0000
  27 0023 8B350000 	 mov esi, DWORD PTR array[rip+4]
  27      0000
  28 0029 BF000000 	 mov edi, OFFSET FLAT:.LC0
  28      00
  29 002e B8000000 	 mov eax, 0
  29      00
  30 0033 E8000000 	 call printf
  30      00
  31 0038 C7050000 	 mov DWORD PTR i[rip], 2
  31      00000200 
  31      0000
  32 0042 8B350000 	 mov esi, DWORD PTR array[rip+8]
  32      0000
  33 0048 BF000000 	 mov edi, OFFSET FLAT:.LC0
  33      00
  34 004d B8000000 	 mov eax, 0
  34      00
  35 0052 E8000000 	 call printf
  35      00
  36 0057 488B0500 	 mov rax, QWORD PTR pi[rip]
  36      000000
  37 005e 8B30     	 mov esi, DWORD PTR [rax]
  38 0060 BF000000 	 mov edi, OFFSET FLAT:.LC0
  38      00
  39 0065 B8000000 	 mov eax, 0
GAS LISTING /tmp/cccDaLGL.s 			page 2


  39      00
  40 006a E8000000 	 call printf
  40      00
  41 006f 488B0500 	 mov rax, QWORD PTR pi[rip]
  41      000000
  42 0076 488D5004 	 lea rdx, [rax+4]
  43 007a 48891500 	 mov QWORD PTR pi[rip], rdx
  43      000000
  44 0081 8B7004   	 mov esi, DWORD PTR [rax+4]
  45 0084 BF000000 	 mov edi, OFFSET FLAT:.LC0
  45      00
  46 0089 B8000000 	 mov eax, 0
  46      00
  47 008e E8000000 	 call printf
  47      00
  48 0093 488B0500 	 mov rax, QWORD PTR pi[rip]
  48      000000
  49 009a 488D5004 	 lea rdx, [rax+4]
  50 009e 48891500 	 mov QWORD PTR pi[rip], rdx
  50      000000
  51 00a5 8B7004   	 mov esi, DWORD PTR [rax+4]
  52 00a8 BF000000 	 mov edi, OFFSET FLAT:.LC0
  52      00
  53 00ad B8000000 	 mov eax, 0
  53      00
  54 00b2 E8000000 	 call printf
  54      00
  55 00b7 B8000000 	 mov eax, 0
  55      00
  56 00bc 4883C408 	 add rsp, 8
  57              	 .cfi_def_cfa_offset 8
  58 00c0 C3       	 ret
  59              	 .cfi_endproc
  60              	.LFE11:
  61              	 .size main, .-main
  62              	 .globl pi
  63              	 .data
  64              	 .align 8
  65              	 .type pi, @object
  66              	 .size pi, 8
  67              	pi:
  68 0000 00000000 	 .quad array
  68      00000000 
  69              	 .globl i
  70              	 .bss
  71              	 .align 4
  72              	 .type i, @object
  73              	 .size i, 4
  74              	i:
  75 0000 00000000 	 .zero 4
  76              	 .globl array
  77              	 .data
  78              	 .align 8
  79              	 .type array, @object
  80              	 .size array, 8
  81              	array:
  82 0008 39300000 	 .long 12345
GAS LISTING /tmp/cccDaLGL.s 			page 3


  83 000c C7CFFFFF 	 .long -12345
  84              	 .ident "GCC: (GNU) 10.3.1"
  85              	 .section .note.GNU-stack,"",@progbits
