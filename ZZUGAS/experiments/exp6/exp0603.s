	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.file	"exp0603.c"
	.def	"?insertSort@@YAXQEAHH@Z";
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	"?insertSort@@YAXQEAHH@Z"       # -- Begin function ?insertSort@@YAXQEAHH@Z
	.p2align	4
"?insertSort@@YAXQEAHH@Z":              # 
.seh_proc "?insertSort@@YAXQEAHH@Z"
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	.seh_endprologue
	cmpl	$2, %edx
	jl	.LBB0_21
# %bb.1:
	movl	%edx, %eax
	addq	$-2, %rax
	movl	$1, %edx
	xorl	%r9d, %r9d
	movq	%rcx, %r8
	jmp	.LBB0_4
	.p2align	4
.LBB0_2:                                #   in Loop: Header=BB0_4 Depth=1
	xorl	%esi, %esi
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=1
	shlq	$30, %rsi
	sarq	$28, %rsi
	movl	%r11d, (%rcx,%rsi)
	addq	$4, %r8
	incq	%rdx
	cmpq	%rax, %r10
	je	.LBB0_21
.LBB0_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_11 Depth 2
                                        #     Child Loop BB0_7 Depth 2
	movq	%r9, %r10
	movq	%rdx, %rdi
	andq	$-4, %rdi
	incq	%r9
	movl	4(%rcx,%r10,4), %r11d
	cmpq	$4, %r9
	jae	.LBB0_10
.LBB0_5:                                #   in Loop: Header=BB0_4 Depth=1
	testb	$3, %r9b
	je	.LBB0_2
# %bb.6:                                #   in Loop: Header=BB0_4 Depth=1
	negq	%rdi
	movq	%rdi, %rsi
	.p2align	4
.LBB0_7:                                #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r8,%rsi,4), %edi
	cmpl	%r11d, %edi
	jle	.LBB0_16
# %bb.8:                                #   in Loop: Header=BB0_7 Depth=2
	movl	%edi, 4(%r8,%rsi,4)
	decq	%rsi
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	jne	.LBB0_7
	jmp	.LBB0_2
	.p2align	4
.LBB0_10:                               #   in Loop: Header=BB0_4 Depth=1
	xorl	%esi, %esi
	.p2align	4
.LBB0_11:                               #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_17
# %bb.12:                               #   in Loop: Header=BB0_11 Depth=2
	movl	%ebx, 4(%r8,%rsi,4)
	movl	-4(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_18
# %bb.13:                               #   in Loop: Header=BB0_11 Depth=2
	movl	%ebx, (%r8,%rsi,4)
	movl	-8(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_19
# %bb.14:                               #   in Loop: Header=BB0_11 Depth=2
	movl	%ebx, -4(%r8,%rsi,4)
	movl	-12(%r8,%rsi,4), %ebx
	cmpl	%r11d, %ebx
	jle	.LBB0_20
# %bb.15:                               #   in Loop: Header=BB0_11 Depth=2
	movl	%ebx, -8(%r8,%rsi,4)
	addq	$-4, %rsi
	movq	%rdi, %rbx
	addq	%rsi, %rbx
	jne	.LBB0_11
	jmp	.LBB0_5
.LBB0_16:                               #   in Loop: Header=BB0_4 Depth=1
	addq	%rdx, %rsi
	jmp	.LBB0_3
.LBB0_17:                               #   in Loop: Header=BB0_4 Depth=1
	addq	%r10, %rsi
	incq	%rsi
	jmp	.LBB0_3
.LBB0_18:                               #   in Loop: Header=BB0_4 Depth=1
	addq	%r10, %rsi
	jmp	.LBB0_3
.LBB0_19:                               #   in Loop: Header=BB0_4 Depth=1
	addq	%r10, %rsi
	decq	%rsi
	jmp	.LBB0_3
.LBB0_20:                               #   in Loop: Header=BB0_4 Depth=1
	addq	%r10, %rsi
	addq	$-2, %rsi
	jmp	.LBB0_3
.LBB0_21:
	.seh_startepilogue
	popq	%rbx
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.globl	main                            # -- Begin function main
	.p2align	4
main:                                   # 
.seh_proc main
# %bb.0:
	pushq	%rax
	.seh_stackalloc 8
	.seh_endprologue
	stmxcsr	4(%rsp)
	orl	$32832, 4(%rsp)                 # imm = 0x8040
	ldmxcsr	4(%rsp)
	xorl	%eax, %eax
	.seh_startepilogue
	popq	%rcx
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
