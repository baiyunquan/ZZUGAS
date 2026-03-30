	.file	"exp0201.c"
	.intel_syntax noprefix
	.text
.Ltext0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	" %.2x"
	.text
	.globl	show_bytes
	.type	show_bytes, @function
show_bytes:
.LFB23:
	.file 1 "exp0201.c"
	.loc 1 5 0
	.cfi_startproc
.LVL0:
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	r12, rdi
	mov	rbp, rsi
.LVL1:
	.loc 1 7 0
	mov	ebx, 0
	jmp	.L2
.LVL2:
.L3:
	.loc 1 8 0 discriminator 3
	movzx	edx, BYTE PTR [r12+rbx]
.LVL3:
.LBB26:
.LBB27:
	.file 2 "/usr/include/x86_64-linux-gnu/bits/stdio2.h"
	.loc 2 104 0 discriminator 3
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL4:
.LBE27:
.LBE26:
	.loc 1 7 0 discriminator 3
	add	rbx, 1
.LVL5:
.L2:
	.loc 1 7 0 is_stmt 0 discriminator 1
	cmp	rbx, rbp
	jb	.L3
	.loc 1 9 0 is_stmt 1
	pop	rbx
	.cfi_def_cfa_offset 24
.LVL6:
	pop	rbp
	.cfi_def_cfa_offset 16
.LVL7:
	pop	r12
	.cfi_def_cfa_offset 8
.LVL8:
	ret
	.cfi_endproc
.LFE23:
	.size	show_bytes, .-show_bytes
	.section	.rodata.str1.1
.LC1:
	.string	"x = %x = %d = %u "
.LC2:
	.string	"u = %x = %d = %u "
.LC3:
	.string	"l = %lx = %ld = %lu "
.LC4:
	.string	"s = %x = %d = %u "
.LC5:
	.string	"us = %x = %d = %u "
.LC6:
	.string	"c = %x = %d = %u = %c "
.LC7:
	.string	"uc = %x = %d = %u = %c "
.LC8:
	.string	"str = %s "
.LC9:
	.string	"str1 = %s "
.LC10:
	.string	"ps = 0x601060 "
.LC11:
	.string	"f = %f, d = %lf"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.loc 1 27 0
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	.loc 1 28 0
	mov	edx, DWORD PTR x[rip]
.LVL9:
.LBB28:
.LBB29:
	.loc 2 104 0
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC1
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL10:
.LBE29:
.LBE28:
	.loc 1 29 0
	mov	edx, DWORD PTR u[rip]
.LVL11:
.LBB30:
.LBB31:
	.loc 2 104 0
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC2
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL12:
.LBE31:
.LBE30:
	.loc 1 30 0
	mov	rdx, QWORD PTR l[rip]
.LVL13:
.LBB32:
.LBB33:
	.loc 2 104 0
	mov	r8, rdx
	mov	rcx, rdx
	mov	esi, OFFSET FLAT:.LC3
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL14:
.LBE33:
.LBE32:
	.loc 1 31 0
	movsx	edx, WORD PTR s[rip]
.LVL15:
.LBB34:
.LBB35:
	.loc 2 104 0
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC4
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL16:
.LBE35:
.LBE34:
	.loc 1 32 0
	movzx	edx, WORD PTR us[rip]
.LVL17:
.LBB36:
.LBB37:
	.loc 2 104 0
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC5
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL18:
.LBE37:
.LBE36:
	.loc 1 33 0
	movsx	edx, BYTE PTR c[rip]
.LVL19:
.LBB38:
.LBB39:
	.loc 2 104 0
	mov	r9d, edx
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC6
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL20:
.LBE39:
.LBE38:
	.loc 1 34 0
	movzx	edx, BYTE PTR uc[rip]
.LVL21:
.LBB40:
.LBB41:
	.loc 2 104 0
	mov	r9d, edx
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC7
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL22:
.LBE41:
.LBE40:
.LBB42:
.LBB43:
	mov	edx, OFFSET FLAT:str
	mov	esi, OFFSET FLAT:.LC8
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL23:
.LBE43:
.LBE42:
.LBB44:
.LBB45:
	mov	edx, OFFSET FLAT:str1
	mov	esi, OFFSET FLAT:.LC9
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL24:
.LBE45:
.LBE44:
.LBB46:
.LBB47:
	mov	esi, OFFSET FLAT:.LC10
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
.LVL25:
.LBE47:
.LBE46:
	.loc 1 38 0
	cvtss2sd	xmm0, DWORD PTR f[rip]
.LVL26:
.LBB48:
.LBB49:
	.loc 2 104 0
	movsd	xmm1, QWORD PTR d[rip]
	mov	esi, OFFSET FLAT:.LC11
	mov	edi, 1
	mov	eax, 2
	call	__printf_chk
.LVL27:
.LBE49:
.LBE48:
	.loc 1 39 0
	mov	esi, 4
	mov	edi, OFFSET FLAT:f
	call	show_bytes
.LVL28:
	.loc 1 40 0
	mov	esi, 8
	mov	edi, OFFSET FLAT:d
	call	show_bytes
.LVL29:
	.loc 1 42 0
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.globl	ps
	.data
	.align 8
	.type	ps, @object
	.size	ps, 8
ps:
	.quad	str
	.globl	str1
	.type	str1, @object
	.size	str1, 6
str1:
	.byte	67
	.byte	104
	.byte	105
	.byte	110
	.byte	97
	.byte	0
	.globl	str
	.align 16
	.type	str, @object
	.size	str, 16
str:
	.string	"Hello Assembly!"
	.globl	uc
	.type	uc, @object
	.size	uc, 1
uc:
	.byte	-56
	.globl	c
	.type	c, @object
	.size	c, 1
c:
	.byte	65
	.globl	us
	.align 2
	.type	us, @object
	.size	us, 2
us:
	.value	-1
	.globl	s
	.align 2
	.type	s, @object
	.size	s, 2
s:
	.value	-1
	.globl	ul
	.align 8
	.type	ul, @object
	.size	ul, 8
ul:
	.quad	-1
	.globl	l
	.align 8
	.type	l, @object
	.size	l, 8
l:
	.quad	-1
	.globl	u
	.align 4
	.type	u, @object
	.size	u, 4
u:
	.long	-2147483648
	.globl	x
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	-1
	.globl	d
	.align 8
	.type	d, @object
	.size	d, 8
d:
	.long	0
	.long	-1067900928
	.globl	f
	.align 4
	.type	f, @object
	.size	f, 4
f:
	.long	3267952640
	.text
.Letext0:
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/5/include/stddef.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 5 "/usr/include/libio.h"
	.file 6 "/usr/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x80d
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF55
	.byte	0xc
	.long	.LASF56
	.long	.LASF57
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x3
	.byte	0xd8
	.long	0x38
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x4
	.byte	0x83
	.long	0x69
	.uleb128 0x2
	.long	.LASF9
	.byte	0x4
	.byte	0x84
	.long	0x69
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF10
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x95
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0x7
	.long	.LASF41
	.byte	0xd8
	.byte	0x5
	.byte	0xf1
	.long	0x219
	.uleb128 0x8
	.long	.LASF12
	.byte	0x5
	.byte	0xf2
	.long	0x62
	.byte	0
	.uleb128 0x8
	.long	.LASF13
	.byte	0x5
	.byte	0xf7
	.long	0x8f
	.byte	0x8
	.uleb128 0x8
	.long	.LASF14
	.byte	0x5
	.byte	0xf8
	.long	0x8f
	.byte	0x10
	.uleb128 0x8
	.long	.LASF15
	.byte	0x5
	.byte	0xf9
	.long	0x8f
	.byte	0x18
	.uleb128 0x8
	.long	.LASF16
	.byte	0x5
	.byte	0xfa
	.long	0x8f
	.byte	0x20
	.uleb128 0x8
	.long	.LASF17
	.byte	0x5
	.byte	0xfb
	.long	0x8f
	.byte	0x28
	.uleb128 0x8
	.long	.LASF18
	.byte	0x5
	.byte	0xfc
	.long	0x8f
	.byte	0x30
	.uleb128 0x8
	.long	.LASF19
	.byte	0x5
	.byte	0xfd
	.long	0x8f
	.byte	0x38
	.uleb128 0x8
	.long	.LASF20
	.byte	0x5
	.byte	0xfe
	.long	0x8f
	.byte	0x40
	.uleb128 0x9
	.long	.LASF21
	.byte	0x5
	.value	0x100
	.long	0x8f
	.byte	0x48
	.uleb128 0x9
	.long	.LASF22
	.byte	0x5
	.value	0x101
	.long	0x8f
	.byte	0x50
	.uleb128 0x9
	.long	.LASF23
	.byte	0x5
	.value	0x102
	.long	0x8f
	.byte	0x58
	.uleb128 0x9
	.long	.LASF24
	.byte	0x5
	.value	0x104
	.long	0x251
	.byte	0x60
	.uleb128 0x9
	.long	.LASF25
	.byte	0x5
	.value	0x106
	.long	0x257
	.byte	0x68
	.uleb128 0x9
	.long	.LASF26
	.byte	0x5
	.value	0x108
	.long	0x62
	.byte	0x70
	.uleb128 0x9
	.long	.LASF27
	.byte	0x5
	.value	0x10c
	.long	0x62
	.byte	0x74
	.uleb128 0x9
	.long	.LASF28
	.byte	0x5
	.value	0x10e
	.long	0x70
	.byte	0x78
	.uleb128 0x9
	.long	.LASF29
	.byte	0x5
	.value	0x112
	.long	0x46
	.byte	0x80
	.uleb128 0x9
	.long	.LASF30
	.byte	0x5
	.value	0x113
	.long	0x54
	.byte	0x82
	.uleb128 0x9
	.long	.LASF31
	.byte	0x5
	.value	0x114
	.long	0x25d
	.byte	0x83
	.uleb128 0x9
	.long	.LASF32
	.byte	0x5
	.value	0x118
	.long	0x26d
	.byte	0x88
	.uleb128 0x9
	.long	.LASF33
	.byte	0x5
	.value	0x121
	.long	0x7b
	.byte	0x90
	.uleb128 0x9
	.long	.LASF34
	.byte	0x5
	.value	0x129
	.long	0x8d
	.byte	0x98
	.uleb128 0x9
	.long	.LASF35
	.byte	0x5
	.value	0x12a
	.long	0x8d
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF36
	.byte	0x5
	.value	0x12b
	.long	0x8d
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF37
	.byte	0x5
	.value	0x12c
	.long	0x8d
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF38
	.byte	0x5
	.value	0x12e
	.long	0x2d
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF39
	.byte	0x5
	.value	0x12f
	.long	0x62
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF40
	.byte	0x5
	.value	0x131
	.long	0x273
	.byte	0xc4
	.byte	0
	.uleb128 0xa
	.long	.LASF58
	.byte	0x5
	.byte	0x96
	.uleb128 0x7
	.long	.LASF42
	.byte	0x18
	.byte	0x5
	.byte	0x9c
	.long	0x251
	.uleb128 0x8
	.long	.LASF43
	.byte	0x5
	.byte	0x9d
	.long	0x251
	.byte	0
	.uleb128 0x8
	.long	.LASF44
	.byte	0x5
	.byte	0x9e
	.long	0x257
	.byte	0x8
	.uleb128 0x8
	.long	.LASF45
	.byte	0x5
	.byte	0xa2
	.long	0x62
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x220
	.uleb128 0x6
	.byte	0x8
	.long	0x9c
	.uleb128 0xb
	.long	0x95
	.long	0x26d
	.uleb128 0xc
	.long	0x86
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x219
	.uleb128 0xb
	.long	0x95
	.long	0x283
	.uleb128 0xc
	.long	0x86
	.byte	0x13
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x289
	.uleb128 0xd
	.long	0x95
	.uleb128 0x2
	.long	.LASF46
	.byte	0x1
	.byte	0x2
	.long	0x299
	.uleb128 0x6
	.byte	0x8
	.long	0x3f
	.uleb128 0xe
	.long	.LASF59
	.byte	0x2
	.byte	0x66
	.long	0x62
	.byte	0x3
	.long	0x2bc
	.uleb128 0xf
	.long	.LASF60
	.byte	0x2
	.byte	0x66
	.long	0x2bc
	.uleb128 0x10
	.byte	0
	.uleb128 0x11
	.long	0x283
	.uleb128 0x12
	.long	.LASF48
	.byte	0x1
	.byte	0x4
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x34b
	.uleb128 0x13
	.long	.LASF47
	.byte	0x1
	.byte	0x4
	.long	0x28e
	.long	.LLST0
	.uleb128 0x14
	.string	"len"
	.byte	0x1
	.byte	0x4
	.long	0x2d
	.long	.LLST1
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x6
	.long	0x2d
	.long	.LLST2
	.uleb128 0x16
	.long	0x29f
	.quad	.LBB26
	.quad	.LBE26-.LBB26
	.byte	0x1
	.byte	0x8
	.uleb128 0x17
	.long	0x2af
	.long	.LLST3
	.uleb128 0x18
	.quad	.LVL4
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	.LASF49
	.byte	0x1
	.byte	0x1a
	.long	0x62
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x6c2
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB28
	.quad	.LBE28-.LBB28
	.byte	0x1
	.byte	0x1c
	.long	0x3b1
	.uleb128 0x17
	.long	0x2af
	.long	.LLST4
	.uleb128 0x18
	.quad	.LVL10
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB30
	.quad	.LBE30-.LBB30
	.byte	0x1
	.byte	0x1d
	.long	0x3f6
	.uleb128 0x17
	.long	0x2af
	.long	.LLST5
	.uleb128 0x18
	.quad	.LVL12
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB32
	.quad	.LBE32-.LBB32
	.byte	0x1
	.byte	0x1e
	.long	0x43b
	.uleb128 0x17
	.long	0x2af
	.long	.LLST6
	.uleb128 0x18
	.quad	.LVL14
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB34
	.quad	.LBE34-.LBB34
	.byte	0x1
	.byte	0x1f
	.long	0x480
	.uleb128 0x17
	.long	0x2af
	.long	.LLST7
	.uleb128 0x18
	.quad	.LVL16
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB36
	.quad	.LBE36-.LBB36
	.byte	0x1
	.byte	0x20
	.long	0x4c5
	.uleb128 0x17
	.long	0x2af
	.long	.LLST8
	.uleb128 0x18
	.quad	.LVL18
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB38
	.quad	.LBE38-.LBB38
	.byte	0x1
	.byte	0x21
	.long	0x50a
	.uleb128 0x17
	.long	0x2af
	.long	.LLST9
	.uleb128 0x18
	.quad	.LVL20
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB40
	.quad	.LBE40-.LBB40
	.byte	0x1
	.byte	0x22
	.long	0x54f
	.uleb128 0x17
	.long	0x2af
	.long	.LLST10
	.uleb128 0x18
	.quad	.LVL22
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB42
	.quad	.LBE42-.LBB42
	.byte	0x1
	.byte	0x23
	.long	0x5a1
	.uleb128 0x17
	.long	0x2af
	.long	.LLST11
	.uleb128 0x18
	.quad	.LVL23
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	str
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB44
	.quad	.LBE44-.LBB44
	.byte	0x1
	.byte	0x24
	.long	0x5f3
	.uleb128 0x17
	.long	0x2af
	.long	.LLST12
	.uleb128 0x18
	.quad	.LVL24
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC9
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	str1
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB46
	.quad	.LBE46-.LBB46
	.byte	0x1
	.byte	0x25
	.long	0x638
	.uleb128 0x17
	.long	0x2af
	.long	.LLST13
	.uleb128 0x18
	.quad	.LVL25
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x29f
	.quad	.LBB48
	.quad	.LBE48-.LBB48
	.byte	0x1
	.byte	0x26
	.long	0x67d
	.uleb128 0x17
	.long	0x2af
	.long	.LLST14
	.uleb128 0x18
	.quad	.LVL27
	.long	0x805
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC11
	.byte	0
	.byte	0
	.uleb128 0x1c
	.quad	.LVL28
	.long	0x2c1
	.long	0x6a1
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	f
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x34
	.byte	0
	.uleb128 0x18
	.quad	.LVL29
	.long	0x2c1
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	d
	.uleb128 0x19
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x38
	.byte	0
	.byte	0
	.uleb128 0x1d
	.long	.LASF50
	.byte	0x6
	.byte	0xa8
	.long	0x257
	.uleb128 0x1d
	.long	.LASF51
	.byte	0x6
	.byte	0xa9
	.long	0x257
	.uleb128 0x1e
	.string	"f"
	.byte	0x1
	.byte	0xb
	.long	0x6eb
	.uleb128 0x9
	.byte	0x3
	.quad	f
	.uleb128 0x3
	.byte	0x4
	.byte	0x4
	.long	.LASF52
	.uleb128 0x1e
	.string	"d"
	.byte	0x1
	.byte	0xc
	.long	0x705
	.uleb128 0x9
	.byte	0x3
	.quad	d
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.long	.LASF53
	.uleb128 0x1e
	.string	"x"
	.byte	0x1
	.byte	0xe
	.long	0x62
	.uleb128 0x9
	.byte	0x3
	.quad	x
	.uleb128 0x1e
	.string	"u"
	.byte	0x1
	.byte	0xf
	.long	0x4d
	.uleb128 0x9
	.byte	0x3
	.quad	u
	.uleb128 0x1e
	.string	"l"
	.byte	0x1
	.byte	0x10
	.long	0x69
	.uleb128 0x9
	.byte	0x3
	.quad	l
	.uleb128 0x1e
	.string	"ul"
	.byte	0x1
	.byte	0x11
	.long	0x38
	.uleb128 0x9
	.byte	0x3
	.quad	ul
	.uleb128 0x1e
	.string	"s"
	.byte	0x1
	.byte	0x12
	.long	0x5b
	.uleb128 0x9
	.byte	0x3
	.quad	s
	.uleb128 0x1e
	.string	"us"
	.byte	0x1
	.byte	0x13
	.long	0x46
	.uleb128 0x9
	.byte	0x3
	.quad	us
	.uleb128 0x1e
	.string	"c"
	.byte	0x1
	.byte	0x14
	.long	0x95
	.uleb128 0x9
	.byte	0x3
	.quad	c
	.uleb128 0x1e
	.string	"uc"
	.byte	0x1
	.byte	0x15
	.long	0x3f
	.uleb128 0x9
	.byte	0x3
	.quad	uc
	.uleb128 0xb
	.long	0x95
	.long	0x7b7
	.uleb128 0xc
	.long	0x86
	.byte	0xf
	.byte	0
	.uleb128 0x1e
	.string	"str"
	.byte	0x1
	.byte	0x16
	.long	0x7a7
	.uleb128 0x9
	.byte	0x3
	.quad	str
	.uleb128 0xb
	.long	0x95
	.long	0x7dc
	.uleb128 0xc
	.long	0x86
	.byte	0x5
	.byte	0
	.uleb128 0x1f
	.long	.LASF54
	.byte	0x1
	.byte	0x17
	.long	0x7cc
	.uleb128 0x9
	.byte	0x3
	.quad	str1
	.uleb128 0x1e
	.string	"ps"
	.byte	0x1
	.byte	0x18
	.long	0x8f
	.uleb128 0x9
	.byte	0x3
	.quad	ps
	.uleb128 0x20
	.long	.LASF61
	.long	.LASF61
	.byte	0x2
	.byte	0x57
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
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
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
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x27
	.uleb128 0x19
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
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.quad	.LVL0-.Ltext0
	.quad	.LVL2-.Ltext0
	.value	0x1
	.byte	0x55
	.quad	.LVL2-.Ltext0
	.quad	.LVL8-.Ltext0
	.value	0x1
	.byte	0x5c
	.quad	.LVL8-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LLST1:
	.quad	.LVL0-.Ltext0
	.quad	.LVL2-.Ltext0
	.value	0x1
	.byte	0x54
	.quad	.LVL2-.Ltext0
	.quad	.LVL7-.Ltext0
	.value	0x1
	.byte	0x56
	.quad	.LVL7-.Ltext0
	.quad	.LFE23-.Ltext0
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
.LLST2:
	.quad	.LVL1-.Ltext0
	.quad	.LVL2-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL2-.Ltext0
	.quad	.LVL6-.Ltext0
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LLST3:
	.quad	.LVL3-.Ltext0
	.quad	.LVL4-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST4:
	.quad	.LVL9-.Ltext0
	.quad	.LVL10-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST5:
	.quad	.LVL11-.Ltext0
	.quad	.LVL12-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC2
	.byte	0x9f
	.quad	0
	.quad	0
.LLST6:
	.quad	.LVL13-.Ltext0
	.quad	.LVL14-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC3
	.byte	0x9f
	.quad	0
	.quad	0
.LLST7:
	.quad	.LVL15-.Ltext0
	.quad	.LVL16-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC4
	.byte	0x9f
	.quad	0
	.quad	0
.LLST8:
	.quad	.LVL17-.Ltext0
	.quad	.LVL18-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC5
	.byte	0x9f
	.quad	0
	.quad	0
.LLST9:
	.quad	.LVL19-.Ltext0
	.quad	.LVL20-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC6
	.byte	0x9f
	.quad	0
	.quad	0
.LLST10:
	.quad	.LVL21-.Ltext0
	.quad	.LVL22-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC7
	.byte	0x9f
	.quad	0
	.quad	0
.LLST11:
	.quad	.LVL22-.Ltext0
	.quad	.LVL23-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC8
	.byte	0x9f
	.quad	0
	.quad	0
.LLST12:
	.quad	.LVL23-.Ltext0
	.quad	.LVL24-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC9
	.byte	0x9f
	.quad	0
	.quad	0
.LLST13:
	.quad	.LVL24-.Ltext0
	.quad	.LVL25-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC10
	.byte	0x9f
	.quad	0
	.quad	0
.LLST14:
	.quad	.LVL26-.Ltext0
	.quad	.LVL27-.Ltext0
	.value	0xa
	.byte	0x3
	.quad	.LC11
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF20:
	.string	"_IO_buf_end"
.LASF28:
	.string	"_old_offset"
.LASF53:
	.string	"double"
.LASF23:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"size_t"
.LASF10:
	.string	"sizetype"
.LASF33:
	.string	"_offset"
.LASF17:
	.string	"_IO_write_ptr"
.LASF12:
	.string	"_flags"
.LASF19:
	.string	"_IO_buf_base"
.LASF54:
	.string	"str1"
.LASF24:
	.string	"_markers"
.LASF14:
	.string	"_IO_read_end"
.LASF55:
	.string	"GNU C11 5.4.0 20160609 -masm=intel -mtune=generic -march=x86-64 -g -Og -fstack-protector-strong"
.LASF52:
	.string	"float"
.LASF32:
	.string	"_lock"
.LASF6:
	.string	"long int"
.LASF59:
	.string	"printf"
.LASF29:
	.string	"_cur_column"
.LASF45:
	.string	"_pos"
.LASF48:
	.string	"show_bytes"
.LASF57:
	.string	"/headless/Desktop/ZZUassembly/ZZUGAS/experiments/exp2"
.LASF44:
	.string	"_sbuf"
.LASF41:
	.string	"_IO_FILE"
.LASF1:
	.string	"unsigned char"
.LASF4:
	.string	"signed char"
.LASF3:
	.string	"unsigned int"
.LASF42:
	.string	"_IO_marker"
.LASF31:
	.string	"_shortbuf"
.LASF16:
	.string	"_IO_write_base"
.LASF40:
	.string	"_unused2"
.LASF13:
	.string	"_IO_read_ptr"
.LASF47:
	.string	"start"
.LASF2:
	.string	"short unsigned int"
.LASF11:
	.string	"char"
.LASF46:
	.string	"byte_pointer"
.LASF49:
	.string	"main"
.LASF43:
	.string	"_next"
.LASF34:
	.string	"__pad1"
.LASF35:
	.string	"__pad2"
.LASF36:
	.string	"__pad3"
.LASF37:
	.string	"__pad4"
.LASF38:
	.string	"__pad5"
.LASF60:
	.string	"__fmt"
.LASF0:
	.string	"long unsigned int"
.LASF18:
	.string	"_IO_write_end"
.LASF9:
	.string	"__off64_t"
.LASF8:
	.string	"__off_t"
.LASF25:
	.string	"_chain"
.LASF22:
	.string	"_IO_backup_base"
.LASF50:
	.string	"stdin"
.LASF27:
	.string	"_flags2"
.LASF39:
	.string	"_mode"
.LASF15:
	.string	"_IO_read_base"
.LASF30:
	.string	"_vtable_offset"
.LASF61:
	.string	"__printf_chk"
.LASF21:
	.string	"_IO_save_base"
.LASF56:
	.string	"exp0201.c"
.LASF26:
	.string	"_fileno"
.LASF51:
	.string	"stdout"
.LASF58:
	.string	"_IO_lock_t"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
