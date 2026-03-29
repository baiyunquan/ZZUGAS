	.file	"eg0801_x86.c"
	.intel_syntax noprefix
	.text
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "The message is: %sThe length is %lu\12\0"
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
	movabs	rax, 8388271297133892164
	movabs	rdx, 5495035117574246432
	mov	QWORD PTR 32[rsp], rax
	mov	QWORD PTR 40[rsp], rdx
	mov	DWORD PTR 48[rsp], 663877
/APP
 # 8 "./progs/eg0801_x86.c" 1
	.intel_syntax noprefix
mov rbx, 0
tol1: mov al , [32[rsp]+rbx]
cmp al, 0
jz tol3
cmp al, 'A'
jb tol2
cmp al, 'Z'
ja tol2
xor al, 0x20
mov [32[rsp]+rbx],al
tol2: add rbx, 1
jmp tol1
tol3: mov DWORD PTR 60[rsp], rbx

 # 0 "" 2
/NO_APP
	lea	rdx, 32[rsp]
	mov	r8d, DWORD PTR 60[rsp]
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 64
	pop	rbx
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
