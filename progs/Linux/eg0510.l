GAS LISTING ./5/eg0510.s 			page 1


   1              		.file	"eg0510.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	mystrlen
   5              		.type	mystrlen, @function
   6              	mystrlen:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 B8000000 		mov	eax, 0
   9      00
  10 0005 EB06     		jmp	.L2
  11              	.L3:
  12 0007 83C001   		add	eax, 1
  13 000a 4889D7   		mov	rdi, rdx
  14              	.L2:
  15 000d 488D5701 		lea	rdx, [rdi+1]
  16 0011 803F00   		cmp	BYTE PTR [rdi], 0
  17 0014 75F1     		jne	.L3
  18 0016 C3       		ret
  19              		.cfi_endproc
  20              	.LFE11:
  21              		.size	mystrlen, .-mystrlen
  22              		.globl	mystrlen1
  23              		.type	mystrlen1, @function
  24              	mystrlen1:
  25              	.LFB12:
  26              		.cfi_startproc
  27 0017 B8000000 		mov	eax, 0
  27      00
  28 001c EB03     		jmp	.L5
  29              	.L6:
  30 001e 83C001   		add	eax, 1
  31              	.L5:
  32 0021 4863D0   		movsx	rdx, eax
  33 0024 803C1700 		cmp	BYTE PTR [rdi+rdx], 0
  34 0028 75F4     		jne	.L6
  35 002a C3       		ret
  36              		.cfi_endproc
  37              	.LFE12:
  38              		.size	mystrlen1, .-mystrlen1
  39              		.section	.rodata.str1.1,"aMS",@progbits,1
  40              	.LC0:
  41 0000 256400   		.string	"%d"
  42              		.text
  43              		.globl	main
  44              		.type	main, @function
  45              	main:
  46              	.LFB13:
  47              		.cfi_startproc
  48 002b 4883EC38 		sub	rsp, 56
  49              		.cfi_def_cfa_offset 64
  50 002f 48B84368 		movabs	rax, 8316213789752649795
  50      696E6120 
  50      6973
  51 0039 48BA2061 		movabs	rdx, 8389772277102698784
  51      20636F75 
  51      6E74
GAS LISTING ./5/eg0510.s 			page 2


  52 0043 48890424 		mov	QWORD PTR [rsp], rax
  53 0047 48895424 		mov	QWORD PTR [rsp+8], rdx
  53      08
  54 004c 48B87279 		movabs	rax, 2335244403110607218
  54      20776974 
  54      6820
  55 0056 48BA6120 		movabs	rdx, 7503110703212666977
  55      6C6F6E67 
  55      2068
  56 0060 48894424 		mov	QWORD PTR [rsp+16], rax
  56      10
  57 0065 48895424 		mov	QWORD PTR [rsp+24], rdx
  57      18
  58 006a 48B86973 		movabs	rax, 13081381331825513
  58      746F7279 
  58      2E00
  59 0074 48894424 		mov	QWORD PTR [rsp+32], rax
  59      20
  60 0079 4889E7   		mov	rdi, rsp
  61 007c E8000000 		call	mystrlen
  61      00
  62 0081 89C6     		mov	esi, eax
  63 0083 BF000000 		mov	edi, OFFSET FLAT:.LC0
  63      00
  64 0088 B8000000 		mov	eax, 0
  64      00
  65 008d E8000000 		call	printf
  65      00
  66 0092 B8000000 		mov	eax, 0
  66      00
  67 0097 4883C438 		add	rsp, 56
  68              		.cfi_def_cfa_offset 8
  69 009b C3       		ret
  70              		.cfi_endproc
  71              	.LFE13:
  72              		.size	main, .-main
  73              		.ident	"GCC: (GNU) 10.3.1"
  74              		.section	.note.GNU-stack,"",@progbits
