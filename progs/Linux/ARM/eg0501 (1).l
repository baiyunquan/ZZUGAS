AARCH64 GAS  ./eg0501.s 			page 1


   1              		.arch armv8-a
   2              		.file	"eg0501.c"
   3              		.text
   4              		.align	2
   5              		.global	diffabs
   6              		.type	diffabs, %function
   7              	diffabs:
   8              	.LFB0:
   9              		.cfi_startproc
  10 0000 1F00016B 		cmp	w0, w1
  11 0004 6A000054 		bge	.L4
  12 0008 2000004B 		sub	w0, w1, w0
  13              	.L3:
  14              	.L1:
  15 000c C0035FD6 		ret
  16              	.L4:
  17 0010 0000014B 		sub	w0, w0, w1
  18 0014 FEFFFF17 		b	.L1
  19              		.cfi_endproc
  20              	.LFE0:
  21              		.size	diffabs, .-diffabs
  22              		.align	2
  23              		.global	find
  24              		.type	find, %function
  25              	find:
  26              	.LFB1:
  27              		.cfi_startproc
  28 0018 E20300AA 		mov	x2, x0
  29 001c 00008052 		mov	w0, 0
  30 0020 02000014 		b	.L6
  31              	.L10:
  32 0024 00040011 		add	w0, w0, 1
  33              	.L6:
  34 0028 1F080071 		cmp	w0, 2
  35 002c AC000054 		bgt	.L9
  36 0030 43D860B8 		ldr	w3, [x2, w0, sxtw 2]
  37 0034 7F00016B 		cmp	w3, w1
  38 0038 61FFFF54 		bne	.L10
  39 003c 02000014 		b	.L5
  40              	.L9:
  41 0040 00008012 		mov	w0, -1
  42              	.L5:
  43 0044 C0035FD6 		ret
  44              		.cfi_endproc
  45              	.LFE1:
  46              		.size	find, .-find
  47              		.ident	"GCC: (GNU) 10.3.1"
  48              		.section	.note.GNU-stack,"",@progbits
