	.file	"eg0309.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "%d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	lea	rbx, .LC0[rip]
	mov	edx, DWORD PTR array[rip]
	mov	rcx, rbx
	call	printf
	mov	DWORD PTR i[rip], 1
	mov	edx, DWORD PTR array[rip+4]
	mov	rcx, rbx
	call	printf
	mov	DWORD PTR i[rip], 2
	mov	edx, DWORD PTR array[rip+8]
	mov	rcx, rbx
	call	printf
	mov	rax, QWORD PTR pi[rip]
	mov	edx, DWORD PTR [rax]
	mov	rcx, rbx
	call	printf
	mov	rax, QWORD PTR pi[rip]
	lea	rdx, 4[rax]
	mov	QWORD PTR pi[rip], rdx
	mov	edx, DWORD PTR 4[rax]
	mov	rcx, rbx
	call	printf
	mov	rax, QWORD PTR pi[rip]
	lea	rdx, 4[rax]
	mov	QWORD PTR pi[rip], rdx
	mov	edx, DWORD PTR 4[rax]
	mov	rcx, rbx
	call	printf
	mov	eax, 0
	add	rsp, 32
	pop	rbx
	ret
	.seh_endproc
	.globl	pi
	.data
	.align 8
pi:
	.quad	array
	.globl	i
	.bss
	.align 4
i:
	.space 4
	.globl	array
	.data
	.align 8
array:
	.long	12345
	.long	-12345
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
