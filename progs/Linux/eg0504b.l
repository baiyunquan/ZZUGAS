GAS LISTING ./5/eg0504b.s 			page 1


   1              		.file	"eg0504b.c"
   2              		.intel_syntax noprefix
   3              		.text
   4              		.globl	sub_of
   5              		.type	sub_of, @function
   6              	sub_of:
   7              	.LFB11:
   8              		.cfi_startproc
   9 0000 29F7     		sub	edi, esi
  10 0002 893A     		mov	DWORD PTR [rdx], edi
  11              	    #########################
  12 0004 7107     	      jno L1
  13 0006 B8010000 	      mov eax,1
  13      00
  14 000b EB05     	      jmp L2
  15              	    #########################
  16              	
  17 000d B8000000 		L1: mov	eax, 0
  17      00
  18 0012 C3       		L2: ret
  19              		.cfi_endproc
  20              	.LFE11:
  21              		.size	sub_of, .-sub_of
  22              		.section	.rodata.str1.1,"aMS",@progbits,1
  23              	.LC0:
  24 0000 782D7920 		.string	"x-y = %d = %u = %x"
  24      3D202564 
  24      203D2025 
  24      75203D20 
  24      257800
  25              	.LC1:
  26 0013 E6BAA2E5 		.string	"\346\272\242\345\207\272"
  26      87BA00
  27              		.text
  28              		.globl	main
  29              		.type	main, @function
  30              	main:
  31              	.LFB12:
  32              		.cfi_startproc
  33 0013 4883EC18 		sub	rsp, 24
  34              		.cfi_def_cfa_offset 32
  35 0017 488D5424 		lea	rdx, [rsp+12]
  35      0C
  36 001c BE013665 		mov	esi, -999999999
  36      C4
  37 0021 BFD20296 		mov	edi, 1234567890
  37      49
  38 0026 E8000000 		call	sub_of
  38      00
  39 002b 85C0     		test	eax, eax
  40 002d 751C     		jne	.L3
  41 002f 8B74240C 		mov	esi, DWORD PTR [rsp+12]
  42 0033 89F1     		mov	ecx, esi
  43 0035 89F2     		mov	edx, esi
  44 0037 BF000000 		mov	edi, OFFSET FLAT:.LC0
  44      00
  45 003c E8000000 		call	printf
GAS LISTING ./5/eg0504b.s 			page 2


  45      00
  46              	.L4:
  47 0041 B8000000 		mov	eax, 0
  47      00
  48 0046 4883C418 		add	rsp, 24
  49              		.cfi_remember_state
  50              		.cfi_def_cfa_offset 8
  51 004a C3       		ret
  52              	.L3:
  53              		.cfi_restore_state
  54 004b BF000000 		mov	edi, OFFSET FLAT:.LC1
  54      00
  55 0050 B8000000 		mov	eax, 0
  55      00
  56 0055 E8000000 		call	printf
  56      00
  57 005a EBE5     		jmp	.L4
  58              		.cfi_endproc
  59              	.LFE12:
  60              		.size	main, .-main
  61              		.ident	"GCC: (GNU) 10.3.1"
  62              		.section	.note.GNU-stack,"",@progbits
