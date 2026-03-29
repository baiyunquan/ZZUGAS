GAS LISTING ./5/eg0511.s 			page 1


   1              		.file	"eg0511.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	fib1
   5              		.type	fib1, @function
   6              	fib1:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 4863F6   		movsx	rsi, esi
  10 0003 488D0CB7 		lea	rcx, [rdi+rsi*4]
  11 0007 C7070100 		mov	DWORD PTR [rdi], 1
  11      0000
  12 000d 488D4708 		lea	rax, [rdi+8]
  13 0011 C7470401 		mov	DWORD PTR [rdi+4], 1
  13      000000
  14 0018 EB0C     		jmp	.L2
  15              	.L3:
  16 001a 8B50F8   		mov	edx, DWORD PTR [rax-8]
  17 001d 0350FC   		add	edx, DWORD PTR [rax-4]
  18 0020 8910     		mov	DWORD PTR [rax], edx
  19 0022 4883C004 		add	rax, 4
  20              	.L2:
  21 0026 4839C8   		cmp	rax, rcx
  22 0029 72EF     		jb	.L3
  23 002b C3       		ret
  24              		.cfi_endproc
  25              	.LFE11:
  26              		.size	fib1, .-fib1
  27              		.globl	fib2
  28              		.type	fib2, @function
  29              	fib2:
  30              	.LFB12:
  31              		.cfi_startproc
  32 002c C7070100 		mov	DWORD PTR [rdi], 1
  32      0000
  33 0032 C7470401 		mov	DWORD PTR [rdi+4], 1
  33      000000
  34 0039 BA030000 		mov	edx, 3
  34      00
  35 003e EB15     		jmp	.L5
  36              	.L6:
  37 0040 4863C2   		movsx	rax, edx
  38 0043 48C1E002 		sal	rax, 2
  39 0047 8B4C07F8 		mov	ecx, DWORD PTR [rdi-8+rax]
  40 004b 034C07FC 		add	ecx, DWORD PTR [rdi-4+rax]
  41 004f 890C07   		mov	DWORD PTR [rdi+rax], ecx
  42 0052 83C201   		add	edx, 1
  43              	.L5:
  44 0055 39F2     		cmp	edx, esi
  45 0057 7CE7     		jl	.L6
  46 0059 C3       		ret
  47              		.cfi_endproc
  48              	.LFE12:
  49              		.size	fib2, .-fib2
  50              		.section	.rodata.str1.1,"aMS",@progbits,1
  51              	.LC0:
  52 0000 25642000 		.string	"%d "
GAS LISTING ./5/eg0511.s 			page 2


  53              	.LC1:
  54 0004 0A256420 		.string	"\n%d "
  54      00
  55              		.text
  56              		.globl	main
  57              		.type	main, @function
  58              	main:
  59              	.LFB13:
  60              		.cfi_startproc
  61 005a 53       		push	rbx
  62              		.cfi_def_cfa_offset 16
  63              		.cfi_offset 3, -16
  64 005b 4883EC30 		sub	rsp, 48
  65              		.cfi_def_cfa_offset 64
  66 005f BE0A0000 		mov	esi, 10
  66      00
  67 0064 4889E7   		mov	rdi, rsp
  68 0067 E8000000 		call	fib1
  68      00
  69 006c BB000000 		mov	ebx, 0
  69      00
  70 0071 EB18     		jmp	.L8
  71              	.L9:
  72 0073 4863C3   		movsx	rax, ebx
  73 0076 8B3484   		mov	esi, DWORD PTR [rsp+rax*4]
  74 0079 BF000000 		mov	edi, OFFSET FLAT:.LC0
  74      00
  75 007e B8000000 		mov	eax, 0
  75      00
  76 0083 E8000000 		call	printf
  76      00
  77 0088 83C301   		add	ebx, 1
  78              	.L8:
  79 008b 83FB09   		cmp	ebx, 9
  80 008e 7EE3     		jle	.L9
  81 0090 BE0A0000 		mov	esi, 10
  81      00
  82 0095 4889E7   		mov	rdi, rsp
  83 0098 E8000000 		call	fib2
  83      00
  84 009d BB000000 		mov	ebx, 0
  84      00
  85 00a2 EB18     		jmp	.L10
  86              	.L11:
  87 00a4 4863C3   		movsx	rax, ebx
  88 00a7 8B3484   		mov	esi, DWORD PTR [rsp+rax*4]
  89 00aa BF000000 		mov	edi, OFFSET FLAT:.LC1
  89      00
  90 00af B8000000 		mov	eax, 0
  90      00
  91 00b4 E8000000 		call	printf
  91      00
  92 00b9 83C301   		add	ebx, 1
  93              	.L10:
  94 00bc 83FB09   		cmp	ebx, 9
  95 00bf 7EE3     		jle	.L11
  96 00c1 B8000000 		mov	eax, 0
GAS LISTING ./5/eg0511.s 			page 3


  96      00
  97 00c6 4883C430 		add	rsp, 48
  98              		.cfi_def_cfa_offset 16
  99 00ca 5B       		pop	rbx
 100              		.cfi_def_cfa_offset 8
 101 00cb C3       		ret
 102              		.cfi_endproc
 103              	.LFE13:
 104              		.size	main, .-main
 105              		.ident	"GCC: (GNU) 10.3.1"
 106              		.section	.note.GNU-stack,"",@progbits
