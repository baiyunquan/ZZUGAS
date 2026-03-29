GAS LISTING ./5/eg0517.s 			page 1


   1              		.file	"eg0517.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	del_char1
   5              		.type	del_char1, @function
   6              	del_char1:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 B9000000 		mov	ecx, 0
   9      00
  10 0005 BA000000 		mov	edx, 0
  10      00
  11 000a EB03     		jmp	.L2
  12              	.L3:
  13 000c 83C201   		add	edx, 1
  14              	.L2:
  15 000f 4863C2   		movsx	rax, edx
  16 0012 0FB60407 		movzx	eax, BYTE PTR [rdi+rax]
  17 0016 84C0     		test	al, al
  18 0018 7411     		je	.L5
  19 001a 4038F0   		cmp	al, sil
  20 001d 74ED     		je	.L3
  21 001f 4C63C1   		movsx	r8, ecx
  22 0022 42880407 		mov	BYTE PTR [rdi+r8], al
  23 0026 8D4901   		lea	ecx, [rcx+1]
  24 0029 EBE1     		jmp	.L3
  25              	.L5:
  26 002b 4863C9   		movsx	rcx, ecx
  27 002e C6040F00 		mov	BYTE PTR [rdi+rcx], 0
  28 0032 C3       		ret
  29              		.cfi_endproc
  30              	.LFE11:
  31              		.size	del_char1, .-del_char1
  32              		.globl	del_char
  33              		.type	del_char, @function
  34              	del_char:
  35              	.LFB12:
  36              		.cfi_startproc
  37 0033 4889FA   		mov	rdx, rdi
  38 0036 EB04     		jmp	.L7
  39              	.L8:
  40 0038 4883C701 		add	rdi, 1
  41              	.L7:
  42 003c 0FB607   		movzx	eax, BYTE PTR [rdi]
  43 003f 84C0     		test	al, al
  44 0041 740D     		je	.L10
  45 0043 4038F0   		cmp	al, sil
  46 0046 74F0     		je	.L8
  47 0048 8802     		mov	BYTE PTR [rdx], al
  48 004a 488D5201 		lea	rdx, [rdx+1]
  49 004e EBE8     		jmp	.L8
  50              	.L10:
  51 0050 C60200   		mov	BYTE PTR [rdx], 0
  52 0053 C3       		ret
  53              		.cfi_endproc
  54              	.LFE12:
  55              		.size	del_char, .-del_char
GAS LISTING ./5/eg0517.s 			page 2


  56              		.section	.rodata.str1.1,"aMS",@progbits,1
  57              	.LC0:
  58 0000 257300   		.string	"%s"
  59              		.text
  60              		.globl	main
  61              		.type	main, @function
  62              	main:
  63              	.LFB13:
  64              		.cfi_startproc
  65 0054 4883EC28 		sub	rsp, 40
  66              		.cfi_def_cfa_offset 48
  67 0058 48B85468 		movabs	rax, 2338328219631577172
  67      69732069 
  67      7320
  68 0062 48BA2020 		movabs	rdx, 7598263559140745248
  68      61207374 
  68      7269
  69 006c 48890424 		mov	QWORD PTR [rsp], rax
  70 0070 48895424 		mov	QWORD PTR [rsp+8], rdx
  70      08
  71 0075 66C74424 		mov	WORD PTR [rsp+16], 26478
  71      106E67
  72 007c C6442412 		mov	BYTE PTR [rsp+18], 0
  72      00
  73 0081 4889E7   		mov	rdi, rsp
  74 0084 E8000000 		call	puts
  74      00
  75 0089 BE200000 		mov	esi, 32
  75      00
  76 008e 4889E7   		mov	rdi, rsp
  77 0091 E8000000 		call	del_char
  77      00
  78 0096 4889E6   		mov	rsi, rsp
  79 0099 BF000000 		mov	edi, OFFSET FLAT:.LC0
  79      00
  80 009e B8000000 		mov	eax, 0
  80      00
  81 00a3 E8000000 		call	printf
  81      00
  82 00a8 B8000000 		mov	eax, 0
  82      00
  83 00ad 4883C428 		add	rsp, 40
  84              		.cfi_def_cfa_offset 8
  85 00b1 C3       		ret
  86              		.cfi_endproc
  87              	.LFE13:
  88              		.size	main, .-main
  89              		.ident	"GCC: (GNU) 10.3.1"
  90              		.section	.note.GNU-stack,"",@progbits
