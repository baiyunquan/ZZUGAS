	.file	"eg0216.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii " %.2x\0"
	.text
	.globl	show_bytes
	.def	show_bytes;	.scl	2;	.type	32;	.endef
	.seh_proc	show_bytes
show_bytes:
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rdi, rcx
	mov	rsi, rdx
	mov	ebx, 0
	jmp	.L2
.L3:
	movzx	edx, BYTE PTR [rdi+rbx]
	lea	rcx, .LC0[rip]
	call	__mingw_printf
	add	rbx, 1
.L2:
	cmp	rbx, rsi
	jb	.L3
	mov	ecx, 10
	call	putchar
	nop
	add	rsp, 32
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	.seh_endproc
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR l[rip], eax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	movss	DWORD PTR f[rip], xmm0
	cvtss2sd	xmm0, xmm0
	movsd	QWORD PTR d[rip], xmm0
	mov	BYTE PTR c[rip], al
	mov	edx, 4
	lea	rcx, i[rip]
	call	show_bytes
	mov	edx, 4
	lea	rcx, l[rip]
	call	show_bytes
	mov	edx, 1
	lea	rcx, c[rip]
	call	show_bytes
	mov	edx, 4
	lea	rcx, f[rip]
	call	show_bytes
	mov	edx, 8
	lea	rcx, d[rip]
	call	show_bytes
	mov	eax, 0
	add	rsp, 40
	ret
	.seh_endproc
	.globl	d
	.data
	.align 8
d:
	.long	0
	.long	-1074790400
	.globl	f
	.align 4
f:
	.long	-1082130432
	.globl	c
c:
	.byte	-1
	.globl	l
	.align 4
l:
	.long	-1
	.globl	i
	.align 4
i:
	.long	-12345
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	putchar;	.scl	2;	.type	32;	.endef
