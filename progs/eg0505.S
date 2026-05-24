	.file	"eg0505.c"
	.intel_syntax noprefix
	.text
	.globl	print
	.def	print;	.scl	2;	.type	32;	.endef
	.seh_proc	print
print:
	.seh_endprologue
	lea	eax, -1[rdx]
	cmp	eax, 7
	ja	.L3
	movsx	rdx, edx
	mov	rax, QWORD PTR -8[rcx+rdx*8]
.L1:
	ret
.L3:
	mov	eax, 0
	jmp	.L1
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
.LC1:
	.ascii "%s\0"
.LC2:
	.ascii "input error\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	call	__main
	lea	rdx, 44[rsp]
	lea	rcx, .LC0[rip]
	call	scanf
	mov	edx, DWORD PTR 44[rsp]
	lea	rcx, msgs[rip]
	call	print
	mov	rdx, rax
	test	rax, rax
	je	.L5
	lea	rcx, .LC1[rip]
	call	printf
.L6:
	mov	eax, 0
	add	rsp, 56
	ret
.L5:
	lea	rcx, .LC2[rip]
	call	printf
	jmp	.L6
	.seh_endproc
	.globl	msgs
	.section .rdata,"dr"
.LC3:
	.ascii "Chapter 1: Fundamentals\12\0"
	.align 8
.LC4:
	.ascii "Chapter 2: Data Representation\12\0"
	.align 8
.LC5:
	.ascii "Chapter 3: x86 Intruction Set Architecture\12\0"
	.align 8
.LC6:
	.ascii "Chapter 4: Basic Instructions\12\0"
.LC7:
	.ascii "Chapter 5: Program Structure\12\0"
	.align 8
.LC8:
	.ascii "Chapter 6: ARM Intruction Set Architecture\12\0"
	.align 8
.LC9:
	.ascii "Chapter 7: ARM Assembly Language Programming\12\0"
	.align 8
.LC10:
	.ascii "Chapter 8: Assembly Language Applications\12\0"
	.data
	.align 32
msgs:
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
