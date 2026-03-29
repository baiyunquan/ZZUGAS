GAS LISTING ./5/eg0505.s 			page 1


   1              		.file	"eg0505.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	print
   5              		.type	print, @function
   6              	print:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 8D46FF   		lea	eax, [rsi-1]
  10 0003 83F807   		cmp	eax, 7
  11 0006 7709     		ja	.L3
  12 0008 4863F6   		movsx	rsi, esi
  13 000b 488B44F7 		mov	rax, QWORD PTR [rdi-8+rsi*8]
  13      F8
  14 0010 C3       		ret
  15              	.L3:
  16 0011 B8000000 		mov	eax, 0
  16      00
  17 0016 C3       		ret
  18              		.cfi_endproc
  19              	.LFE11:
  20              		.size	print, .-print
  21              		.section	.rodata.str1.1,"aMS",@progbits,1
  22              	.LC0:
  23 0000 256400   		.string	"%d"
  24              	.LC1:
  25 0003 257300   		.string	"%s"
  26              	.LC2:
  27 0006 696E7075 		.string	"input error"
  27      74206572 
  27      726F7200 
  28              		.text
  29              		.globl	main
  30              		.type	main, @function
  31              	main:
  32              	.LFB12:
  33              		.cfi_startproc
  34 0017 4883EC18 		sub	rsp, 24
  35              		.cfi_def_cfa_offset 32
  36 001b 488D7424 		lea	rsi, [rsp+12]
  36      0C
  37 0020 BF000000 		mov	edi, OFFSET FLAT:.LC0
  37      00
  38 0025 B8000000 		mov	eax, 0
  38      00
  39 002a E8000000 		call	__isoc99_scanf
  39      00
  40 002f 8B74240C 		mov	esi, DWORD PTR [rsp+12]
  41 0033 BF000000 		mov	edi, OFFSET FLAT:msgs
  41      00
  42 0038 E8000000 		call	print
  42      00
  43 003d 4885C0   		test	rax, rax
  44 0040 741C     		je	.L5
  45 0042 4889C6   		mov	rsi, rax
  46 0045 BF000000 		mov	edi, OFFSET FLAT:.LC1
  46      00
GAS LISTING ./5/eg0505.s 			page 2


  47 004a B8000000 		mov	eax, 0
  47      00
  48 004f E8000000 		call	printf
  48      00
  49              	.L6:
  50 0054 B8000000 		mov	eax, 0
  50      00
  51 0059 4883C418 		add	rsp, 24
  52              		.cfi_remember_state
  53              		.cfi_def_cfa_offset 8
  54 005d C3       		ret
  55              	.L5:
  56              		.cfi_restore_state
  57 005e BF000000 		mov	edi, OFFSET FLAT:.LC2
  57      00
  58 0063 B8000000 		mov	eax, 0
  58      00
  59 0068 E8000000 		call	printf
  59      00
  60 006d EBE5     		jmp	.L6
  61              		.cfi_endproc
  62              	.LFE12:
  63              		.size	main, .-main
  64              		.globl	msgs
  65              		.section	.rodata.str1.1
  66              	.LC3:
  67 0012 43686170 		.string	"Chapter 1: Fundamentals\n"
  67      74657220 
  67      313A2046 
  67      756E6461 
  67      6D656E74 
  68              		.section	.rodata.str1.8,"aMS",@progbits,1
  69              		.align 8
  70              	.LC4:
  71 0000 43686170 		.string	"Chapter 2: Data Representation\n"
  71      74657220 
  71      323A2044 
  71      61746120 
  71      52657072 
  72              		.align 8
  73              	.LC5:
  74 0020 43686170 		.string	"Chapter 3: x86 Intruction Set Architecture\n"
  74      74657220 
  74      333A2078 
  74      38362049 
  74      6E747275 
  75 004c 00000000 		.align 8
  76              	.LC6:
  77 0050 43686170 		.string	"Chapter 4: Basic Instructions\n"
  77      74657220 
  77      343A2042 
  77      61736963 
  77      20496E73 
  78              		.section	.rodata.str1.1
  79              	.LC7:
  80 002b 43686170 		.string	"Chapter 5: Program Structure\n"
  80      74657220 
GAS LISTING ./5/eg0505.s 			page 3


  80      353A2050 
  80      726F6772 
  80      616D2053 
  81              		.section	.rodata.str1.8
  82 006f 00       		.align 8
  83              	.LC8:
  84 0070 43686170 		.string	"Chapter 6: ARM Intruction Set Architecture\n"
  84      74657220 
  84      363A2041 
  84      524D2049 
  84      6E747275 
  85 009c 00000000 		.align 8
  86              	.LC9:
  87 00a0 43686170 		.string	"Chapter 7: ARM Assembly Language Programming\n"
  87      74657220 
  87      373A2041 
  87      524D2041 
  87      7373656D 
  88 00ce 0000     		.align 8
  89              	.LC10:
  90 00d0 43686170 		.string	"Chapter 8: Assembly Language Applications\n"
  90      74657220 
  90      383A2041 
  90      7373656D 
  90      626C7920 
  91              		.data
  92              		.align 32
  93              		.type	msgs, @object
  94              		.size	msgs, 64
  95              	msgs:
  96 0000 00000000 		.quad	.LC3
  96      00000000 
  97 0008 00000000 		.quad	.LC4
  97      00000000 
  98 0010 00000000 		.quad	.LC5
  98      00000000 
  99 0018 00000000 		.quad	.LC6
  99      00000000 
 100 0020 00000000 		.quad	.LC7
 100      00000000 
 101 0028 00000000 		.quad	.LC8
 101      00000000 
 102 0030 00000000 		.quad	.LC9
 102      00000000 
 103 0038 00000000 		.quad	.LC10
 103      00000000 
 104              		.ident	"GCC: (GNU) 10.3.1"
 105              		.section	.note.GNU-stack,"",@progbits
