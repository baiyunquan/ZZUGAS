	.file	"tu0507.c"
	.intel_syntax noprefix
	.text
	.globl	proc
	.def	proc;	.scl	2;	.type	32;	.endef
	.seh_proc	proc
proc:
	.seh_endprologue
	mov	r10d, ecx
	mov	rcx, rdx
	mov	rdx, QWORD PTR 48[rsp]
	mov	rax, QWORD PTR 64[rsp]
	add	DWORD PTR [rcx], r10d
	add	DWORD PTR [r9], r8d
	mov	ecx, DWORD PTR 40[rsp]
	add	WORD PTR [rdx], cx
	mov	edx, DWORD PTR 56[rsp]
	add	BYTE PTR [rax], dl
	ret
	.seh_endproc
	.globl	call_proc
	.def	call_proc;	.scl	2;	.type	32;	.endef
	.seh_proc	call_proc
call_proc:
	sub	rsp, 88
	.seh_stackalloc	88
	.seh_endprologue
	mov	DWORD PTR 76[rsp], 1
	mov	DWORD PTR 72[rsp], 2
	mov	WORD PTR 70[rsp], 3
	mov	BYTE PTR 69[rsp], 4
	lea	rdx, 76[rsp]
	lea	rax, 69[rsp]
	mov	QWORD PTR 56[rsp], rax
	mov	DWORD PTR 48[rsp], 4
	lea	rax, 70[rsp]
	mov	QWORD PTR 40[rsp], rax
	mov	DWORD PTR 32[rsp], 3
	lea	r9, 72[rsp]
	mov	r8d, 2
	mov	ecx, 1
	call	proc
	mov	eax, DWORD PTR 72[rsp]
	add	eax, DWORD PTR 76[rsp]
	movsx	edx, WORD PTR 70[rsp]
	movsx	ecx, BYTE PTR 69[rsp]
	sub	edx, ecx
	imul	eax, edx
	add	rsp, 88
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r2) 15.1.0"
