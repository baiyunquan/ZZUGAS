	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.file	"exp0603.c"
	.def	insertSort;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",one_only,insertSort,unique,0
	.globl	insertSort
	.p2align	4
insertSort:
.seh_proc insertSort
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	.seh_endprologue
	cmpl	$2, %edx
	jl	.LBB0_20
	movl	%edx, %eax
	addq	$-2, %rax
	movl	$1, %edx
	xorl	%r9d, %r9d
	movq	%rcx, %r8
	jmp	.LBB0_4
	.p2align	4
.LBB0_2:
	xorl	%esi, %esi
.LBB0_3:
	shlq	$30, %rsi
	sarq	$28, %rsi
	movl	%r11d, (%rcx,%rsi)
	incq	%rdx
	addq	$4, %r8
	cmpq	%rax, %r10
	je	.LBB0_20
.LBB0_4:
	movq	%r9, %r10
	movq	%rdx, %rdi
	andq	$-4, %rdi
	incq	%r9
	movl	4(%rcx,%r10,4), %r11d
	cmpq	$4, %r9
	jae	.LBB0_10
.LBB0_5:
	testb	$3, %r9b
	je	.LBB0_2
	movl	$1, %esi
	subq	%rdi, %rsi
	.p2align	4
.LBB0_7:
	movl	-4(%r8,%rsi,4), %edi
	cmpl	%r11d, %edi
	jle	.LBB0_16
	movl	%edi, (%r8,%rsi,4)
	decq	%rsi
	movq	%r10, %rdi
	addq	%rsi, %rdi
	jne	.LBB0_7
	jmp	.LBB0_2
	.p2align	4
.LBB0_10:
	xorl	%esi, %esi
	.p2align	4
.LBB0_11:
	movl	(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_17
	movl	%ebx, 4(%r8,%rsi,4)
	movl	-4(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_16
	movl	%ebx, (%r8,%rsi,4)
	movl	-8(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_18
	movl	%ebx, -4(%r8,%rsi,4)
	movl	-12(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_19
	movl	%ebx, -8(%r8,%rsi,4)
	addq	$-4, %rsi
	movq	%rdi, %rbx
	addq	%rsi, %rbx
	jne	.LBB0_11
	jmp	.LBB0_5
	.p2align	4
.LBB0_16:
	addq	%r10, %rsi
	jmp	.LBB0_3
.LBB0_17:
	addq	%r10, %rsi
	incq	%rsi
	jmp	.LBB0_3
.LBB0_18:
	addq	%r10, %rsi
	decq	%rsi
	jmp	.LBB0_3
.LBB0_19:
	addq	%r10, %rsi
	addq	$-2, %rsi
	jmp	.LBB0_3
.LBB0_20:
	.seh_startepilogue
	popq	%rbx
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
	.seh_endproc

	.def	main;
	.scl	2;
	.type	32;
	.endef
	.section	.text,"xr",one_only,main,unique,1
	.globl	main
	.p2align	4
main:
.seh_proc main
	pushq	%rax
	.seh_stackalloc 8
	.seh_endprologue
	stmxcsr	4(%rsp)
	orl	$32832, 4(%rsp)
	ldmxcsr	4(%rsp)
	xorl	%eax, %eax
	.seh_startepilogue
	popq	%rcx
	.seh_endepilogue
	retq
	.seh_endproc

	.section	.drectve,"yni"
	.ascii	" /DEFAULTLIB:libcmt.lib"
	.ascii	" /DEFAULTLIB:libircmt.lib"
	.ascii	" /DEFAULTLIB:svml_dispmt.lib"
	.ascii	" /DEFAULTLIB:libmmt.lib"
	.ascii	" /DEFAULTLIB:oldnames.lib"
