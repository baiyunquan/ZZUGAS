GAS LISTING ./5/eg0516.s 			page 1


   1              		.file	"eg0516.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	bubble_sort
   5              		.type	bubble_sort, @function
   6              	bubble_sort:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 4189F1   		mov	r9d, esi
  10 0003 41B80100 		mov	r8d, 1
  10      0000
  11 0009 EB30     		jmp	.L2
  12              	.L3:
  13 000b 83C001   		add	eax, 1
  14              	.L5:
  15 000e 4489CA   		mov	edx, r9d
  16 0011 4429C2   		sub	edx, r8d
  17 0014 39C2     		cmp	edx, eax
  18 0016 7E1F     		jle	.L7
  19 0018 4863D0   		movsx	rdx, eax
  20 001b 488D3497 		lea	rsi, [rdi+rdx*4]
  21 001f 8B0E     		mov	ecx, DWORD PTR [rsi]
  22 0021 8B549704 		mov	edx, DWORD PTR [rdi+4+rdx*4]
  23 0025 39D1     		cmp	ecx, edx
  24 0027 7EE2     		jle	.L3
  25 0029 8916     		mov	DWORD PTR [rsi], edx
  26 002b 418D1400 		lea	edx, [r8+rax]
  27 002f 4863D2   		movsx	rdx, edx
  28 0032 890C97   		mov	DWORD PTR [rdi+rdx*4], ecx
  29 0035 EBD4     		jmp	.L3
  30              	.L7:
  31 0037 4183C001 		add	r8d, 1
  32              	.L2:
  33 003b 4539C8   		cmp	r8d, r9d
  34 003e 7D07     		jge	.L8
  35 0040 B8000000 		mov	eax, 0
  35      00
  36 0045 EBC7     		jmp	.L5
  37              	.L8:
  38 0047 C3       		ret
  39              		.cfi_endproc
  40              	.LFE11:
  41              		.size	bubble_sort, .-bubble_sort
  42              		.section	.rodata.str1.1,"aMS",@progbits,1
  43              	.LC0:
  44 0000 E68E92E5 		.string	"\346\216\222\345\272\217\345\211\215:"
  44      BA8FE589 
  44      8D3A00
  45              	.LC1:
  46 000b 25642000 		.string	"%d "
  47              	.LC2:
  48 000f 0AE68E92 		.string	"\n\346\216\222\345\272\217\345\220\216:"
  48      E5BA8FE5 
  48      908E3A00 
  49              		.text
  50              		.globl	main
  51              		.type	main, @function
GAS LISTING ./5/eg0516.s 			page 2


  52              	main:
  53              	.LFB12:
  54              		.cfi_startproc
  55 0048 53       		push	rbx
  56              		.cfi_def_cfa_offset 16
  57              		.cfi_offset 3, -16
  58 0049 4883EC20 		sub	rsp, 32
  59              		.cfi_def_cfa_offset 48
  60 004d C704244B 		mov	DWORD PTR [rsp], 587
  60      020000
  61 0054 C7442404 		mov	DWORD PTR [rsp+4], -632
  61      88FDFFFF 
  62 005c C7442408 		mov	DWORD PTR [rsp+8], 777
  62      09030000 
  63 0064 C744240C 		mov	DWORD PTR [rsp+12], 234
  63      EA000000 
  64 006c C7442410 		mov	DWORD PTR [rsp+16], -34
  64      DEFFFFFF 
  65 0074 BF000000 		mov	edi, OFFSET FLAT:.LC0
  65      00
  66 0079 E8000000 		call	puts
  66      00
  67 007e BB000000 		mov	ebx, 0
  67      00
  68 0083 EB18     		jmp	.L10
  69              	.L11:
  70 0085 4863C3   		movsx	rax, ebx
  71 0088 8B3484   		mov	esi, DWORD PTR [rsp+rax*4]
  72 008b BF000000 		mov	edi, OFFSET FLAT:.LC1
  72      00
  73 0090 B8000000 		mov	eax, 0
  73      00
  74 0095 E8000000 		call	printf
  74      00
  75 009a 83C301   		add	ebx, 1
  76              	.L10:
  77 009d 83FB04   		cmp	ebx, 4
  78 00a0 7EE3     		jle	.L11
  79 00a2 BE050000 		mov	esi, 5
  79      00
  80 00a7 4889E7   		mov	rdi, rsp
  81 00aa E8000000 		call	bubble_sort
  81      00
  82 00af BF000000 		mov	edi, OFFSET FLAT:.LC2
  82      00
  83 00b4 E8000000 		call	puts
  83      00
  84 00b9 BB000000 		mov	ebx, 0
  84      00
  85 00be EB18     		jmp	.L12
  86              	.L13:
  87 00c0 4863C3   		movsx	rax, ebx
  88 00c3 8B3484   		mov	esi, DWORD PTR [rsp+rax*4]
  89 00c6 BF000000 		mov	edi, OFFSET FLAT:.LC1
  89      00
  90 00cb B8000000 		mov	eax, 0
  90      00
GAS LISTING ./5/eg0516.s 			page 3


  91 00d0 E8000000 		call	printf
  91      00
  92 00d5 83C301   		add	ebx, 1
  93              	.L12:
  94 00d8 83FB04   		cmp	ebx, 4
  95 00db 7EE3     		jle	.L13
  96 00dd B8000000 		mov	eax, 0
  96      00
  97 00e2 4883C420 		add	rsp, 32
  98              		.cfi_def_cfa_offset 16
  99 00e6 5B       		pop	rbx
 100              		.cfi_def_cfa_offset 8
 101 00e7 C3       		ret
 102              		.cfi_endproc
 103              	.LFE12:
 104              		.size	main, .-main
 105              		.ident	"GCC: (GNU) 10.3.1"
 106              		.section	.note.GNU-stack,"",@progbits
