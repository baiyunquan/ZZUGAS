	.file	"eg0214.c"
	.intel_syntax noprefix
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	" x = %x = %d = %u \n"
.LC1:
	.string	" u = %x = %d = %u \n"
.LC2:
	.string	" l = %x = %ld = %llu \n"
.LC3:
	.string	" s = %x = %d = %u \n"
.LC4:
	.string	" us = %x = %d = %u \n"
.LC5:
	.string	" c = %x = %d = %u = %c \n"
.LC6:
	.string	" uc = %x = %d = %u = %c \n"
.LC7:
	.string	" str = %s\n "
.LC8:
	.string	" str1 = %s\n "
.LC9:
	.string	" ps = %x = %ld "
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	edx, DWORD PTR x[rip]
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC0
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	edx, DWORD PTR u[rip]
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC1
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	rdx, QWORD PTR l[rip]
	mov	r8, rdx
	mov	rcx, rdx
	mov	esi, OFFSET FLAT:.LC2
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	movsx	edx, WORD PTR s[rip]
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC3
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	movzx	edx, WORD PTR us[rip]
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC4
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	movsx	edx, BYTE PTR c[rip]
	mov	r9d, edx
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC5
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	movzx	edx, BYTE PTR uc[rip]
	mov	r9d, edx
	mov	r8d, edx
	mov	ecx, edx
	mov	esi, OFFSET FLAT:.LC6
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	edx, OFFSET FLAT:str
	mov	esi, OFFSET FLAT:.LC7
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	edx, OFFSET FLAT:str1
	mov	esi, OFFSET FLAT:.LC8
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	rdx, QWORD PTR ps[rip]
	mov	esi, OFFSET FLAT:.LC9
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
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
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
