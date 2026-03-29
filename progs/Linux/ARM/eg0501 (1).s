	.arch armv8-a
	.file	"eg0501.c"
	.text
.Ltext0:
	.align	2
	.global	diffabs
	.type	diffabs, %function
diffabs:
.LVL0:
.LFB0:
	.file 1 "./eg0501.c"
	.loc 1 3 26 view -0
	.cfi_startproc
	.loc 1 4 1 view .LVU1
	.loc 1 5 1 view .LVU2
	.loc 1 5 3 is_stmt 0 view .LVU3
	cmp	w0, w1
	bge	.L4
	.loc 1 10 2 is_stmt 1 view .LVU4
	.loc 1 10 3 is_stmt 0 view .LVU5
	sub	w0, w1, w0
.LVL1:
.L3:
	.loc 1 12 2 is_stmt 1 view .LVU6
.L1:
	.loc 1 13 1 is_stmt 0 view .LVU7
	ret
.LVL2:
.L4:
	.loc 1 7 2 is_stmt 1 view .LVU8
	.loc 1 7 3 is_stmt 0 view .LVU9
	sub	w0, w0, w1
.LVL3:
	.loc 1 8 2 is_stmt 1 view .LVU10
	b	.L1
	.cfi_endproc
.LFE0:
	.size	diffabs, .-diffabs
	.align	2
	.global	find
	.type	find, %function
find:
.LVL4:
.LFB1:
	.loc 1 15 32 view -0
	.cfi_startproc
	.loc 1 15 32 is_stmt 0 view .LVU12
	mov	x2, x0
	.loc 1 16 5 is_stmt 1 view .LVU13
	.loc 1 17 5 view .LVU14
.LVL5:
	.loc 1 17 12 is_stmt 0 view .LVU15
	mov	w0, 0
.LVL6:
	.loc 1 17 5 view .LVU16
	b	.L6
.LVL7:
.L10:
	.loc 1 17 24 is_stmt 1 discriminator 2 view .LVU17
	.loc 1 17 25 is_stmt 0 discriminator 2 view .LVU18
	add	w0, w0, 1
.LVL8:
.L6:
	.loc 1 17 17 is_stmt 1 discriminator 1 view .LVU19
	.loc 1 17 5 is_stmt 0 discriminator 1 view .LVU20
	cmp	w0, 2
	bgt	.L9
	.loc 1 18 9 is_stmt 1 view .LVU21
	.loc 1 18 14 is_stmt 0 view .LVU22
	ldr	w3, [x2, w0, sxtw 2]
	.loc 1 18 12 view .LVU23
	cmp	w3, w1
	bne	.L10
	b	.L5
.L9:
	.loc 1 22 11 view .LVU24
	mov	w0, -1
.LVL9:
.LDL1:
.L5:
	.loc 1 26 1 view .LVU25
	ret
	.cfi_endproc
.LFE1:
	.size	find, .-find
	.align	2
	.global	main
	.type	main, %function
main:
.LFB2:
	.loc 1 29 11 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 30 5 view .LVU27
	.loc 1 31 5 view .LVU28
	.loc 1 32 1 is_stmt 0 view .LVU29
	mov	w0, 0
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.global	y
	.global	x
	.data
	.align	2
	.type	y, %object
	.size	y, 4
y:
	.word	5
	.type	x, %object
	.size	x, 4
x:
	.word	3
	.text
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x140
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF2
	.byte	0xc
	.4byte	.LASF3
	.4byte	.LASF4
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.string	"x"
	.byte	0x1
	.byte	0x1c
	.byte	0x5
	.4byte	0x41
	.uleb128 0x9
	.byte	0x3
	.8byte	x
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.string	"y"
	.byte	0x1
	.byte	0x1c
	.byte	0x9
	.4byte	0x41
	.uleb128 0x9
	.byte	0x3
	.8byte	y
	.uleb128 0x4
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1d
	.byte	0x5
	.4byte	0x41
	.8byte	.LFB2
	.8byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x5
	.4byte	.LASF6
	.byte	0x1
	.byte	0xf
	.byte	0x5
	.4byte	0x41
	.8byte	.LFB1
	.8byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xdf
	.uleb128 0x6
	.string	"v"
	.byte	0x1
	.byte	0xf
	.byte	0xe
	.4byte	0xdf
	.4byte	.LLST2
	.4byte	.LVUS2
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0xf
	.byte	0x18
	.4byte	0x41
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x8
	.string	"i"
	.byte	0x1
	.byte	0x10
	.byte	0x9
	.4byte	0x41
	.4byte	.LLST3
	.4byte	.LVUS3
	.uleb128 0x9
	.4byte	.LASF1
	.byte	0x1
	.byte	0x18
	.byte	0x1
	.8byte	.LDL1
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.4byte	0x41
	.uleb128 0xb
	.4byte	.LASF7
	.byte	0x1
	.byte	0x3
	.byte	0x5
	.4byte	0x41
	.8byte	.LFB0
	.8byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x6
	.string	"x"
	.byte	0x1
	.byte	0x3
	.byte	0x11
	.4byte	0x41
	.4byte	.LLST0
	.4byte	.LVUS0
	.uleb128 0xc
	.string	"y"
	.byte	0x1
	.byte	0x3
	.byte	0x18
	.4byte	0x41
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x8
	.string	"t"
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	0x41
	.4byte	.LLST1
	.4byte	.LVUS1
	.uleb128 0xd
	.string	"L1"
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.8byte	.L3
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xa
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xa
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LVUS2:
	.uleb128 0
	.uleb128 .LVU16
	.uleb128 .LVU16
	.uleb128 0
.LLST2:
	.8byte	.LVL4-.Ltext0
	.8byte	.LVL6-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL6-.Ltext0
	.8byte	.LFE1-.Ltext0
	.2byte	0x1
	.byte	0x52
	.8byte	0
	.8byte	0
.LVUS3:
	.uleb128 .LVU15
	.uleb128 .LVU17
	.uleb128 .LVU17
	.uleb128 .LVU25
.LLST3:
	.8byte	.LVL5-.Ltext0
	.8byte	.LVL7-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	.LVL7-.Ltext0
	.8byte	.LVL9-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	0
	.8byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU8
	.uleb128 .LVU8
	.uleb128 .LVU10
	.uleb128 .LVU10
	.uleb128 0
.LLST0:
	.8byte	.LVL0-.Ltext0
	.8byte	.LVL1-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL1-.Ltext0
	.8byte	.LVL2-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.8byte	.LVL2-.Ltext0
	.8byte	.LVL3-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL3-.Ltext0
	.8byte	.LFE0-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.8byte	0
	.8byte	0
.LVUS1:
	.uleb128 .LVU6
	.uleb128 .LVU8
	.uleb128 .LVU10
	.uleb128 0
.LLST1:
	.8byte	.LVL1-.Ltext0
	.8byte	.LVL2-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL3-.Ltext0
	.8byte	.LFE0-.Ltext0
	.2byte	0x1
	.byte	0x50
	.8byte	0
	.8byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF6:
	.string	"find"
.LASF4:
	.string	"/assembly"
.LASF7:
	.string	"diffabs"
.LASF2:
	.string	"GNU C17 10.3.1 -mlittle-endian -mabi=lp64 -g -Og"
.LASF1:
	.string	"found"
.LASF3:
	.string	"./eg0501.c"
.LASF5:
	.string	"main"
.LASF0:
	.string	"target"
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
