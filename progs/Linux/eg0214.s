	.file	"eg0214.c"
	.intel_syntax noprefix
	.text
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
.LFB11:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	esi, DWORD PTR x[rip]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	esi, DWORD PTR u[rip]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	mov	rsi, QWORD PTR l[rip]
	mov	rcx, rsi
	mov	rdx, rsi
	mov	edi, OFFSET FLAT:.LC2
	mov	eax, 0
	call	printf
	movsx	esi, WORD PTR s[rip]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC3
	mov	eax, 0
	call	printf
	movzx	esi, WORD PTR us[rip]
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC4
	mov	eax, 0
	call	printf
	movsx	esi, BYTE PTR c[rip]
	mov	r8d, esi
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC5
	mov	eax, 0
	call	printf
	movzx	esi, BYTE PTR uc[rip]
	mov	r8d, esi
	mov	ecx, esi
	mov	edx, esi
	mov	edi, OFFSET FLAT:.LC6
	mov	eax, 0
	call	printf
	mov	esi, OFFSET FLAT:str
	mov	edi, OFFSET FLAT:.LC7
	mov	eax, 0
	call	printf
	mov	esi, OFFSET FLAT:str1
	mov	edi, OFFSET FLAT:.LC8
	mov	eax, 0
	call	printf
	mov	rsi, QWORD PTR ps[rip]
	mov	edi, OFFSET FLAT:.LC9
	mov	eax, 0
	call	printf
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
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
	.string	"China"
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
	.ident	"GCC: (GNU) 10.3.1"
	.section	.note.GNU-stack,"",@progbits
