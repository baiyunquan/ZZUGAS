GAS LISTING ./5/eg0506.s 			page 1


   1              		.file	"eg0506.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	caculator
   5              		.type	caculator, @function
   6              	caculator:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 89D1     		mov	ecx, edx
  10 0002 83EF2A   		sub	edi, 42
  11 0005 4080FF14 		cmp	dil, 20
  12 0009 772A     		ja	.L10
  13 000b 400FB6FF 		movzx	edi, dil
  14 000f FF24FD00 		jmp	[QWORD PTR .L4[0+rdi*8]]
  14      000000
  15              		.section	.rodata
  16              		.align 8
  17              		.align 4
  18              	.L4:
  19 0000 00000000 		.quad	.L9
  19      00000000 
  20 0008 00000000 		.quad	.L8
  20      00000000 
  21 0010 00000000 		.quad	.L10
  21      00000000 
  22 0018 00000000 		.quad	.L7
  22      00000000 
  23 0020 00000000 		.quad	.L10
  23      00000000 
  24 0028 00000000 		.quad	.L6
  24      00000000 
  25 0030 00000000 		.quad	.L10
  25      00000000 
  26 0038 00000000 		.quad	.L10
  26      00000000 
  27 0040 00000000 		.quad	.L10
  27      00000000 
  28 0048 00000000 		.quad	.L10
  28      00000000 
  29 0050 00000000 		.quad	.L10
  29      00000000 
  30 0058 00000000 		.quad	.L10
  30      00000000 
  31 0060 00000000 		.quad	.L10
  31      00000000 
  32 0068 00000000 		.quad	.L10
  32      00000000 
  33 0070 00000000 		.quad	.L10
  33      00000000 
  34 0078 00000000 		.quad	.L10
  34      00000000 
  35 0080 00000000 		.quad	.L10
  35      00000000 
  36 0088 00000000 		.quad	.L10
  36      00000000 
  37 0090 00000000 		.quad	.L5
  37      00000000 
GAS LISTING ./5/eg0506.s 			page 2


  38 0098 00000000 		.quad	.L10
  38      00000000 
  39 00a0 00000000 		.quad	.L3
  39      00000000 
  40              		.text
  41              	.L8:
  42 0016 8D0432   		lea	eax, [rdx+rsi]
  43 0019 C3       		ret
  44              	.L7:
  45 001a 89F0     		mov	eax, esi
  46 001c 29D0     		sub	eax, edx
  47 001e C3       		ret
  48              	.L9:
  49 001f 89D0     		mov	eax, edx
  50 0021 0FAFC6   		imul	eax, esi
  51 0024 C3       		ret
  52              	.L6:
  53 0025 89F0     		mov	eax, esi
  54 0027 99       		cdq
  55 0028 F7F9     		idiv	ecx
  56 002a C3       		ret
  57              	.L5:
  58 002b 8D0436   		lea	eax, [rsi+rsi]
  59 002e C3       		ret
  60              	.L3:
  61 002f 89D0     		mov	eax, edx
  62 0031 C1F802   		sar	eax, 2
  63 0034 C3       		ret
  64              	.L10:
  65 0035 B8000000 		mov	eax, 0
  65      00
  66 003a C3       		ret
  67              		.cfi_endproc
  68              	.LFE11:
  69              		.size	caculator, .-caculator
  70              		.section	.rodata.str1.1,"aMS",@progbits,1
  71              	.LC0:
  72 0000 256300   		.string	"%c"
  73              	.LC1:
  74 0003 256400   		.string	"%d"
  75              		.text
  76              		.globl	main
  77              		.type	main, @function
  78              	main:
  79              	.LFB12:
  80              		.cfi_startproc
  81 003b 4883EC18 		sub	rsp, 24
  82              		.cfi_def_cfa_offset 32
  83 003f 488D7424 		lea	rsi, [rsp+15]
  83      0F
  84 0044 BF000000 		mov	edi, OFFSET FLAT:.LC0
  84      00
  85 0049 B8000000 		mov	eax, 0
  85      00
  86 004e E8000000 		call	__isoc99_scanf
  86      00
  87 0053 0FBE7C24 		movsx	edi, BYTE PTR [rsp+15]
GAS LISTING ./5/eg0506.s 			page 3


  87      0F
  88 0058 BAD4FEFF 		mov	edx, -300
  88      FF
  89 005d BEC80000 		mov	esi, 200
  89      00
  90 0062 E8000000 		call	caculator
  90      00
  91 0067 89C6     		mov	esi, eax
  92 0069 BF000000 		mov	edi, OFFSET FLAT:.LC1
  92      00
  93 006e B8000000 		mov	eax, 0
  93      00
  94 0073 E8000000 		call	printf
  94      00
  95 0078 B8000000 		mov	eax, 0
  95      00
  96 007d 4883C418 		add	rsp, 24
  97              		.cfi_def_cfa_offset 8
  98 0081 C3       		ret
  99              		.cfi_endproc
 100              	.LFE12:
 101              		.size	main, .-main
 102              		.ident	"GCC: (GNU) 10.3.1"
 103              		.section	.note.GNU-stack,"",@progbits
