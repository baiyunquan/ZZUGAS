AARCH64 GAS  ./eg0708.s 			page 1


   1              		.arch armv8-a
   2              		.file	"eg0708.c"
   3              		.text
   4              		.align	2
   5              		.global	sum_for
   6              		.type	sum_for, %function
   7              	sum_for:
   8              	.LFB11:
   9              		.cfi_startproc
  10 0000 E203002A 		mov	w2, w0
  11 0004 21008052 		mov	w1, 1
  12 0008 00008052 		mov	w0, 0
  13 000c 03000014 		b	.L2
  14              	.L3:
  15 0010 0000010B 		add	w0, w0, w1
  16 0014 21040011 		add	w1, w1, 1
  17              	.L2:
  18 0018 3F00026B 		cmp	w1, w2
  19 001c ADFFFF54 		ble	.L3
  20 0020 C0035FD6 		ret
  21              		.cfi_endproc
  22              	.LFE11:
  23              		.size	sum_for, .-sum_for
  24              		.align	2
  25              		.global	sum_while
  26              		.type	sum_while, %function
  27              	sum_while:
  28              	.LFB12:
  29              		.cfi_startproc
  30 0024 E203002A 		mov	w2, w0
  31 0028 00008052 		mov	w0, 0
  32 002c 21008052 		mov	w1, 1
  33 0030 03000014 		b	.L5
  34              	.L6:
  35 0034 0000010B 		add	w0, w0, w1
  36 0038 21040011 		add	w1, w1, 1
  37              	.L5:
  38 003c 3F00026B 		cmp	w1, w2
  39 0040 ADFFFF54 		ble	.L6
  40 0044 C0035FD6 		ret
  41              		.cfi_endproc
  42              	.LFE12:
  43              		.size	sum_while, .-sum_while
  44              		.align	2
  45              		.global	sum_until
  46              		.type	sum_until, %function
  47              	sum_until:
  48              	.LFB13:
  49              		.cfi_startproc
  50 0048 E203002A 		mov	w2, w0
  51 004c 00008052 		mov	w0, 0
  52 0050 21008052 		mov	w1, 1
  53              	.L8:
  54 0054 0000010B 		add	w0, w0, w1
  55 0058 21040011 		add	w1, w1, 1
  56 005c 3F00026B 		cmp	w1, w2
  57 0060 ADFFFF54 		ble	.L8
AARCH64 GAS  ./eg0708.s 			page 2


  58 0064 C0035FD6 		ret
  59              		.cfi_endproc
  60              	.LFE13:
  61              		.size	sum_until, .-sum_until
  62              		.section	.rodata.str1.8,"aMS",@progbits,1
  63              		.align	3
  64              	.LC0:
  65 0000 256400   		.string	"%d"
  66              		.text
  67              		.align	2
  68              		.global	main
  69              		.type	main, %function
  70              	main:
  71              	.LFB14:
  72              		.cfi_startproc
  73 0068 FD7BBEA9 		stp	x29, x30, [sp, -32]!
  74              		.cfi_def_cfa_offset 32
  75              		.cfi_offset 29, -32
  76              		.cfi_offset 30, -24
  77 006c FD030091 		mov	x29, sp
  78 0070 F30B00F9 		str	x19, [sp, 16]
  79              		.cfi_offset 19, -16
  80 0074 800C8052 		mov	w0, 100
  81 0078 00000094 		bl	sum_for
  82 007c 13000090 		adrp	x19, .LC0
  83 0080 73020091 		add	x19, x19, :lo12:.LC0
  84 0084 E103002A 		mov	w1, w0
  85 0088 E00313AA 		mov	x0, x19
  86 008c 00000094 		bl	printf
  87 0090 800C8052 		mov	w0, 100
  88 0094 00000094 		bl	sum_while
  89 0098 E103002A 		mov	w1, w0
  90 009c E00313AA 		mov	x0, x19
  91 00a0 00000094 		bl	printf
  92 00a4 800C8052 		mov	w0, 100
  93 00a8 00000094 		bl	sum_until
  94 00ac E103002A 		mov	w1, w0
  95 00b0 E00313AA 		mov	x0, x19
  96 00b4 00000094 		bl	printf
  97 00b8 00008052 		mov	w0, 0
  98 00bc F30B40F9 		ldr	x19, [sp, 16]
  99 00c0 FD7BC2A8 		ldp	x29, x30, [sp], 32
 100              		.cfi_restore 30
 101              		.cfi_restore 29
 102              		.cfi_restore 19
 103              		.cfi_def_cfa_offset 0
 104 00c4 C0035FD6 		ret
 105              		.cfi_endproc
 106              	.LFE14:
 107              		.size	main, .-main
 108              		.ident	"GCC: (GNU) 10.3.1"
 109              		.section	.note.GNU-stack,"",@progbits
