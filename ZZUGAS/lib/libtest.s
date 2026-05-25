In archive libtest.a:

dispc.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispc>:
   0:	90000001 	adrp	x1, 0 <dispc>
   4:	91000021 	add	x1, x1, #0x0
   8:	f9000020 	str	x0, [x1]
   c:	d2800000 	mov	x0, #0x0                   	// #0
  10:	d2800022 	mov	x2, #0x1                   	// #1
  14:	d2800808 	mov	x8, #0x40                  	// #64
  18:	d4000001 	svc	#0x0
  1c:	d65f03c0 	ret

readc.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readc>:
   0:	d2800000 	mov	x0, #0x0                   	// #0
   4:	90000001 	adrp	x1, 0 <readc>
   8:	91000021 	add	x1, x1, #0x0
   c:	d2800042 	mov	x2, #0x2                   	// #2
  10:	d28007e8 	mov	x8, #0x3f                  	// #63
  14:	d4000001 	svc	#0x0
  18:	8b000021 	add	x1, x1, x0
  1c:	52800002 	mov	w2, #0x0                   	// #0
  20:	381ff022 	sturb	w2, [x1, #-1]
  24:	cb000021 	sub	x1, x1, x0
  28:	39400020 	ldrb	w0, [x1]
  2c:	d65f03c0 	ret

dispmsg.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispmsg>:
   0:	aa0003e1 	mov	x1, x0
   4:	d2800002 	mov	x2, #0x0                   	// #0

0000000000000008 <find_null>:
   8:	38626823 	ldrb	w3, [x1, x2]
   c:	34000063 	cbz	w3, 18 <display>
  10:	91000442 	add	x2, x2, #0x1
  14:	17fffffd 	b	8 <find_null>

0000000000000018 <display>:
  18:	d2800020 	mov	x0, #0x1                   	// #1
  1c:	d2800808 	mov	x8, #0x40                  	// #64
  20:	d4000001 	svc	#0x0
  24:	d65f03c0 	ret

readmsg.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readmsg>:
   0:	aa0003e1 	mov	x1, x0
   4:	d28003c2 	mov	x2, #0x1e                  	// #30
   8:	d28007e8 	mov	x8, #0x3f                  	// #63
   c:	d2800000 	mov	x0, #0x0                   	// #0
  10:	d4000001 	svc	#0x0
  14:	f100001f 	cmp	x0, #0x0
  18:	540000cb 	b.lt	30 <readmsg_error>  // b.tstop
  1c:	8b000021 	add	x1, x1, x0
  20:	52800002 	mov	w2, #0x0                   	// #0
  24:	381ff022 	sturb	w2, [x1, #-1]
  28:	cb000021 	sub	x1, x1, x0
  2c:	d65f03c0 	ret

0000000000000030 <readmsg_error>:
  30:	d2800000 	mov	x0, #0x0                   	// #0
  34:	d65f03c0 	ret

dispsix.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispsix>:
   0:	d2800002 	mov	x2, #0x0                   	// #0
   4:	90000001 	adrp	x1, 0 <dispsix>
   8:	91000021 	add	x1, x1, #0x0
   c:	f100001f 	cmp	x0, #0x0
  10:	540000a1 	b.ne	24 <neg>  // b.any
  14:	52800603 	mov	w3, #0x30                  	// #48
  18:	39000023 	strb	w3, [x1]
  1c:	d2800022 	mov	x2, #0x1                   	// #1
  20:	14000018 	b	80 <disp3>

0000000000000024 <neg>:
  24:	aa0003e7 	mov	x7, x0
  28:	b6f80107 	tbz	x7, #63, 48 <pos>
  2c:	cb0703e7 	neg	x7, x7
  30:	528005a3 	mov	w3, #0x2d                  	// #45
  34:	39000023 	strb	w3, [x1]
  38:	d2800000 	mov	x0, #0x0                   	// #0
  3c:	d2800022 	mov	x2, #0x1                   	// #1
  40:	d2800808 	mov	x8, #0x40                  	// #64
  44:	d4000001 	svc	#0x0

0000000000000048 <pos>:
  48:	d2800262 	mov	x2, #0x13                  	// #19
  4c:	d2800146 	mov	x6, #0xa                   	// #10

0000000000000050 <disp1>:
  50:	9ac608e5 	udiv	x5, x7, x6
  54:	9b069ca3 	msub	x3, x5, x6, x7
  58:	1100c063 	add	w3, w3, #0x30
  5c:	38226823 	strb	w3, [x1, x2]
  60:	f10000bf 	cmp	x5, #0x0
  64:	54000080 	b.eq	74 <disp2>  // b.none
  68:	d1000442 	sub	x2, x2, #0x1
  6c:	aa0503e7 	mov	x7, x5
  70:	17fffff8 	b	50 <disp1>

0000000000000074 <disp2>:
  74:	8b020021 	add	x1, x1, x2
  78:	d2800283 	mov	x3, #0x14                  	// #20
  7c:	cb020062 	sub	x2, x3, x2

0000000000000080 <disp3>:
  80:	d2800000 	mov	x0, #0x0                   	// #0
  84:	d2800808 	mov	x8, #0x40                  	// #64
  88:	d4000001 	svc	#0x0
  8c:	d65f03c0 	ret

disphx.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <disphx>:
   0:	90000001 	adrp	x1, 0 <disphx>
   4:	91000021 	add	x1, x1, #0x0
   8:	aa1f03e2 	mov	x2, xzr

000000000000000c <disp1>:
   c:	93c0f000 	ror	x0, x0, #60
  10:	12000c03 	and	w3, w0, #0xf
  14:	1100c063 	add	w3, w3, #0x30
  18:	7100e47f 	cmp	w3, #0x39
  1c:	54000049 	b.ls	24 <disp2>  // b.plast
  20:	11001c63 	add	w3, w3, #0x7

0000000000000024 <disp2>:
  24:	38226823 	strb	w3, [x1, x2]
  28:	91000442 	add	x2, x2, #0x1
  2c:	f100405f 	cmp	x2, #0x10
  30:	54fffee3 	b.cc	c <disp1>  // b.lo, b.ul, b.last
  34:	d2800000 	mov	x0, #0x0                   	// #0
  38:	d2800808 	mov	x8, #0x40                  	// #64
  3c:	d4000001 	svc	#0x0
  40:	d65f03c0 	ret

dispuix.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispuix>:
   0:	d2800002 	mov	x2, #0x0                   	// #0
   4:	90000001 	adrp	x1, 0 <dispuix>
   8:	91000021 	add	x1, x1, #0x0
   c:	f100001f 	cmp	x0, #0x0
  10:	540000a1 	b.ne	24 <neg>  // b.any
  14:	52800603 	mov	w3, #0x30                  	// #48
  18:	39000023 	strb	w3, [x1]
  1c:	d2800022 	mov	x2, #0x1                   	// #1
  20:	14000010 	b	60 <disp3>

0000000000000024 <neg>:
  24:	aa0003e7 	mov	x7, x0

0000000000000028 <pos>:
  28:	d2800262 	mov	x2, #0x13                  	// #19
  2c:	d2800146 	mov	x6, #0xa                   	// #10

0000000000000030 <disp1>:
  30:	9ac608e5 	udiv	x5, x7, x6
  34:	9b069ca3 	msub	x3, x5, x6, x7
  38:	1100c063 	add	w3, w3, #0x30
  3c:	38226823 	strb	w3, [x1, x2]
  40:	f10000bf 	cmp	x5, #0x0
  44:	54000080 	b.eq	54 <disp2>  // b.none
  48:	d1000442 	sub	x2, x2, #0x1
  4c:	aa0503e7 	mov	x7, x5
  50:	17fffff8 	b	30 <disp1>

0000000000000054 <disp2>:
  54:	8b020021 	add	x1, x1, x2
  58:	d2800283 	mov	x3, #0x14                  	// #20
  5c:	cb020062 	sub	x2, x3, x2

0000000000000060 <disp3>:
  60:	d2800000 	mov	x0, #0x0                   	// #0
  64:	d2800808 	mov	x8, #0x40                  	// #64
  68:	d4000001 	svc	#0x0
  6c:	d65f03c0 	ret

readbbx.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readbbx>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	d2800003 	mov	x3, #0x0                   	// #0
   8:	d2800204 	mov	x4, #0x10                  	// #16

000000000000000c <read1>:
   c:	94000000 	bl	0 <readc>
  10:	f100c01f 	cmp	x0, #0x30
  14:	54000163 	b.cc	40 <readerr>  // b.lo, b.ul, b.last
  18:	f100c41f 	cmp	x0, #0x31
  1c:	54000128 	b.hi	40 <readerr>  // b.pmore
  20:	d100c000 	sub	x0, x0, #0x30
  24:	d37ff863 	lsl	x3, x3, #1
  28:	aa000063 	orr	x3, x3, x0
  2c:	f1000484 	subs	x4, x4, #0x1
  30:	54fffee1 	b.ne	c <read1>  // b.any
  34:	aa0303e0 	mov	x0, x3
  38:	a8c17bfd 	ldp	x29, x30, [sp], #16
  3c:	d65f03c0 	ret

0000000000000040 <readerr>:
  40:	58000080 	ldr	x0, 50 <readerr+0x10>
  44:	94000000 	bl	0 <dispmsg>
  48:	17fffff1 	b	c <read1>
	...

readuix.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readuix>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!

0000000000000004 <read0>:
   4:	90000000 	adrp	x0, 0 <readuix>
   8:	91000000 	add	x0, x0, #0x0
   c:	94000000 	bl	0 <readmsg>
  10:	f100301f 	cmp	x0, #0xc
  14:	54000228 	b.hi	58 <readerr>  // b.pmore
  18:	90000002 	adrp	x2, 0 <readuix>
  1c:	91000042 	add	x2, x2, #0x0
  20:	d2800003 	mov	x3, #0x0                   	// #0

0000000000000024 <read1>:
  24:	39400045 	ldrb	w5, [x2]
  28:	91000442 	add	x2, x2, #0x1
  2c:	35000045 	cbnz	w5, 34 <read2>
  30:	1400000d 	b	64 <read3>

0000000000000034 <read2>:
  34:	7100c0bf 	cmp	w5, #0x30
  38:	54000103 	b.cc	58 <readerr>  // b.lo, b.ul, b.last
  3c:	7100e4bf 	cmp	w5, #0x39
  40:	540000c8 	b.hi	58 <readerr>  // b.pmore
  44:	5100c0a5 	sub	w5, w5, #0x30
  48:	52800147 	mov	w7, #0xa                   	// #10
  4c:	1b077c63 	mul	w3, w3, w7
  50:	0b050063 	add	w3, w3, w5
  54:	17fffff4 	b	24 <read1>

0000000000000058 <readerr>:
  58:	580000c0 	ldr	x0, 70 <read3+0xc>
  5c:	94000000 	bl	0 <dispmsg>
  60:	17ffffe9 	b	4 <read0>

0000000000000064 <read3>:
  64:	aa0303e0 	mov	x0, x3
  68:	a8c17bfd 	ldp	x29, x30, [sp], #16
  6c:	d65f03c0 	ret
	...

readsix.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readsix>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!

0000000000000004 <read0>:
   4:	90000000 	adrp	x0, 0 <readsix>
   8:	91000000 	add	x0, x0, #0x0
   c:	94000000 	bl	0 <readmsg>
  10:	f100001f 	cmp	x0, #0x0
  14:	54000340 	b.eq	7c <readerr>  // b.none
  18:	f100301f 	cmp	x0, #0xc
  1c:	54000308 	b.hi	7c <readerr>  // b.pmore
  20:	90000002 	adrp	x2, 0 <readsix>
  24:	91000042 	add	x2, x2, #0x0
  28:	d2800003 	mov	x3, #0x0                   	// #0
  2c:	d2800004 	mov	x4, #0x0                   	// #0
  30:	39400045 	ldrb	w5, [x2]
  34:	7100acbf 	cmp	w5, #0x2b
  38:	54000080 	b.eq	48 <read1>  // b.none
  3c:	7100b4bf 	cmp	w5, #0x2d
  40:	540000c1 	b.ne	58 <read2>  // b.any
  44:	92800004 	mov	x4, #0xffffffffffffffff    	// #-1

0000000000000048 <read1>:
  48:	91000442 	add	x2, x2, #0x1
  4c:	39400045 	ldrb	w5, [x2]
  50:	710000bf 	cmp	w5, #0x0
  54:	540001a0 	b.eq	88 <read3>  // b.none

0000000000000058 <read2>:
  58:	7100c0bf 	cmp	w5, #0x30
  5c:	54000103 	b.cc	7c <readerr>  // b.lo, b.ul, b.last
  60:	7100e4bf 	cmp	w5, #0x39
  64:	540000c8 	b.hi	7c <readerr>  // b.pmore
  68:	5100c0a5 	sub	w5, w5, #0x30
  6c:	52800147 	mov	w7, #0xa                   	// #10
  70:	1b077c63 	mul	w3, w3, w7
  74:	0b050063 	add	w3, w3, w5
  78:	17fffff4 	b	48 <read1>

000000000000007c <readerr>:
  7c:	58000120 	ldr	x0, a0 <read4+0xc>
  80:	94000000 	bl	0 <dispmsg>
  84:	17ffffe0 	b	4 <read0>

0000000000000088 <read3>:
  88:	f100009f 	cmp	x4, #0x0
  8c:	54000040 	b.eq	94 <read4>  // b.none
  90:	cb0303e3 	neg	x3, x3

0000000000000094 <read4>:
  94:	aa0303e0 	mov	x0, x3
  98:	a8c17bfd 	ldp	x29, x30, [sp], #16
  9c:	d65f03c0 	ret
	...

dispbx.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispbx>:
   0:	90000001 	adrp	x1, 0 <dispbx>
   4:	91000021 	add	x1, x1, #0x0
   8:	d2800002 	mov	x2, #0x0                   	// #0
   c:	d2800004 	mov	x4, #0x0                   	// #0

0000000000000010 <dphx1>:
  10:	93c0fc00 	ror	x0, x0, #63
  14:	12000003 	and	w3, w0, #0x1
  18:	91000484 	add	x4, x4, #0x1
  1c:	f101009f 	cmp	x4, #0x40
  20:	540000a0 	b.eq	34 <branch>  // b.none
  24:	7100007f 	cmp	w3, #0x0
  28:	54ffff40 	b.eq	10 <dphx1>  // b.none
  2c:	321c0463 	orr	w3, w3, #0x30
  30:	14000007 	b	4c <dphx3>

0000000000000034 <branch>:
  34:	321c0463 	orr	w3, w3, #0x30
  38:	14000005 	b	4c <dphx3>

000000000000003c <dphx2>:
  3c:	93c0fc00 	ror	x0, x0, #63
  40:	12000003 	and	w3, w0, #0x1
  44:	91000484 	add	x4, x4, #0x1
  48:	321c0463 	orr	w3, w3, #0x30

000000000000004c <dphx3>:
  4c:	38226823 	strb	w3, [x1, x2]
  50:	91000442 	add	x2, x2, #0x1
  54:	f101009f 	cmp	x4, #0x40
  58:	54ffff23 	b.cc	3c <dphx2>  // b.lo, b.ul, b.last
  5c:	d2800000 	mov	x0, #0x0                   	// #0
  60:	d2800808 	mov	x8, #0x40                  	// #64
  64:	d4000001 	svc	#0x0
  68:	d65f03c0 	ret

readhx.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readhx>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!

0000000000000004 <read0>:
   4:	90000000 	adrp	x0, 0 <readhx>
   8:	91000000 	add	x0, x0, #0x0
   c:	94000000 	bl	0 <readmsg>
  10:	d2800002 	mov	x2, #0x0                   	// #0
  14:	d1000400 	sub	x0, x0, #0x1
  18:	aa0003e4 	mov	x4, x0
  1c:	d2800000 	mov	x0, #0x0                   	// #0
  20:	90000001 	adrp	x1, 0 <readhx>
  24:	91000021 	add	x1, x1, #0x0

0000000000000028 <read1>:
  28:	39400022 	ldrb	w2, [x1]
  2c:	91000421 	add	x1, x1, #0x1
  30:	7100c05f 	cmp	w2, #0x30
  34:	540001a3 	b.cc	68 <readerr1>  // b.lo, b.ul, b.last
  38:	7101185f 	cmp	w2, #0x46
  3c:	54000208 	b.hi	7c <readerr2>  // b.pmore
  40:	5100c042 	sub	w2, w2, #0x30
  44:	7100245f 	cmp	w2, #0x9
  48:	54000049 	b.ls	50 <read2>  // b.plast
  4c:	51001c42 	sub	w2, w2, #0x7

0000000000000050 <read2>:
  50:	d37cec00 	lsl	x0, x0, #4
  54:	aa020000 	orr	x0, x0, x2
  58:	d1000484 	sub	x4, x4, #0x1
  5c:	b5fffe64 	cbnz	x4, 28 <read1>
  60:	a8c17bfd 	ldp	x29, x30, [sp], #16
  64:	d65f03c0 	ret

0000000000000068 <readerr1>:
  68:	58000140 	ldr	x0, 90 <readerr2+0x14>
  6c:	94000000 	bl	0 <dispmsg>
  70:	58000140 	ldr	x0, 98 <readerr2+0x1c>
  74:	94000000 	bl	0 <dispmsg>
  78:	17ffffe3 	b	4 <read0>

000000000000007c <readerr2>:
  7c:	58000120 	ldr	x0, a0 <readerr2+0x24>
  80:	94000000 	bl	0 <dispmsg>
  84:	580000a0 	ldr	x0, 98 <readerr2+0x1c>
  88:	94000000 	bl	0 <dispmsg>
  8c:	17ffffde 	b	4 <read0>
	...

readbx.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <readbx>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	aa1f03e3 	mov	x3, xzr
   8:	aa1f03e2 	mov	x2, xzr

000000000000000c <read1>:
   c:	90000000 	adrp	x0, 0 <readbx>
  10:	91000000 	add	x0, x0, #0x0
  14:	94000000 	bl	0 <readmsg>
  18:	aa1f03e0 	mov	x0, xzr

000000000000001c <read2>:
  1c:	38626820 	ldrb	w0, [x1, x2]
  20:	34000140 	cbz	w0, 48 <done>
  24:	7100c01f 	cmp	w0, #0x30
  28:	54000163 	b.cc	54 <readerr>  // b.lo, b.ul, b.last
  2c:	7100c41f 	cmp	w0, #0x31
  30:	54000128 	b.hi	54 <readerr>  // b.pmore
  34:	5100c000 	sub	w0, w0, #0x30
  38:	d37ff863 	lsl	x3, x3, #1
  3c:	aa000063 	orr	x3, x3, x0
  40:	91000442 	add	x2, x2, #0x1
  44:	17fffff6 	b	1c <read2>

0000000000000048 <done>:
  48:	aa0303e0 	mov	x0, x3
  4c:	a8c17bfd 	ldp	x29, x30, [sp], #16
  50:	d65f03c0 	ret

0000000000000054 <readerr>:
  54:	58000060 	ldr	x0, 60 <readerr+0xc>
  58:	94000000 	bl	0 <dispmsg>
  5c:	17ffffec 	b	c <read1>
	...

dispcrlf.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <dispcrlf>:
   0:	d10043ff 	sub	sp, sp, #0x10
   4:	f90003e0 	str	x0, [sp]
   8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   c:	d2800140 	mov	x0, #0xa                   	// #10
  10:	94000000 	bl	0 <dispc>
  14:	a8c17bfd 	ldp	x29, x30, [sp], #16
  18:	910043ff 	add	sp, sp, #0x10
  1c:	f94003e0 	ldr	x0, [sp]
  20:	d65f03c0 	ret

ftoieee.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <ftoieee>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	fd400000 	ldr	d0, [x0]
   8:	9e660000 	fmov	x0, d0
   c:	94000000 	bl	0 <disphx>
  10:	a8c17bfd 	ldp	x29, x30, [sp], #16
  14:	d65f03c0 	ret

disptips.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <disptips>:
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	90000000 	adrp	x0, 0 <disptips>
   8:	91000000 	add	x0, x0, #0x0
   c:	94000000 	bl	0 <dispmsg>
  10:	90000000 	adrp	x0, 0 <disptips>
  14:	91000000 	add	x0, x0, #0x0
  18:	94000000 	bl	0 <dispmsg>
  1c:	90000000 	adrp	x0, 0 <disptips>
  20:	91000000 	add	x0, x0, #0x0
  24:	94000000 	bl	0 <dispmsg>
  28:	90000000 	adrp	x0, 0 <disptips>
  2c:	91000000 	add	x0, x0, #0x0
  30:	94000000 	bl	0 <dispmsg>
  34:	90000000 	adrp	x0, 0 <disptips>
  38:	91000000 	add	x0, x0, #0x0
  3c:	94000000 	bl	0 <dispmsg>
  40:	90000000 	adrp	x0, 0 <disptips>
  44:	91000000 	add	x0, x0, #0x0
  48:	94000000 	bl	0 <dispmsg>
  4c:	90000000 	adrp	x0, 0 <disptips>
  50:	91000000 	add	x0, x0, #0x0
  54:	94000000 	bl	0 <dispmsg>
  58:	90000000 	adrp	x0, 0 <disptips>
  5c:	91000000 	add	x0, x0, #0x0
  60:	94000000 	bl	0 <dispmsg>
  64:	90000000 	adrp	x0, 0 <disptips>
  68:	91000000 	add	x0, x0, #0x0
  6c:	94000000 	bl	0 <dispmsg>
  70:	90000000 	adrp	x0, 0 <disptips>
  74:	91000000 	add	x0, x0, #0x0
  78:	94000000 	bl	0 <dispmsg>
  7c:	a8c17bfd 	ldp	x29, x30, [sp], #16
  80:	d65f03c0 	ret
