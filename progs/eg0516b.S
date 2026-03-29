	.file	"eg0516.c"
	.intel_syntax noprefix
	.text
	.globl	bubble_sort
	.def	bubble_sort;	.scl	2;	.type	32;	.endef
	.seh_proc	bubble_sort
bubble_sort:
	.seh_endprologue
	mov	r11d, 1
	jmp	.L2
	.p2align 6
.L3:
	add   r10,4
      sub	eax, 1
.L5:
	cmp	eax,0 #内循环计数是否为0
	jle	.L7
	
	mov	r9d, DWORD PTR [r10]
	mov	r8d, DWORD PTR 4[r10]
	cmp	r9d, r8d
	jle	.L3
	mov	DWORD PTR [r10], r8d
	mov	DWORD PTR 4[r10], r9d
	
      jmp	.L3
.L7:
	add	r11d, 1
.L2:
	cmp	r11d, edx
	jge	.L8
	mov	r10, rcx     # r10 = &a[0]，等同于 lea r10，[rcx]
      mov   eax, edx
	sub	eax, r11d   # eax =n-i 
	jmp	.L5
.L8:
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "\305\305\320\362\307\260:\0"
.LC1:
	.ascii "%d \0"
.LC2:
	.ascii "\12\305\305\320\362\272\363:\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 64
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	mov	DWORD PTR 32[rsp], 587
	mov	DWORD PTR 36[rsp], -632
	mov	DWORD PTR 40[rsp], 777
	mov	DWORD PTR 44[rsp], 234
	mov	DWORD PTR 48[rsp], -34
	lea	rcx, .LC0[rip]
	call	puts
	mov	ebx, 0
	jmp	.L10
.L11:
	movsx	rax, ebx
	mov	edx, DWORD PTR 32[rsp+rax*4]
	lea	rcx, .LC1[rip]
	call	printf
	add	ebx, 1
.L10:
	cmp	ebx, 4
	jle	.L11
	lea	rcx, 32[rsp]
	mov	edx, 5
	call	bubble_sort
	lea	rcx, .LC2[rip]
	call	puts
	mov	ebx, 0
	jmp	.L12
.L13:
	movsx	rax, ebx
	mov	edx, DWORD PTR 32[rsp+rax*4]
	lea	rcx, .LC1[rip]
	call	printf
	add	ebx, 1
.L12:
	cmp	ebx, 4
	jle	.L13
	mov	eax, 0
	add	rsp, 64
	pop	rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
