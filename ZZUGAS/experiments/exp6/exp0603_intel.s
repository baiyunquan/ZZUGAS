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
	subq	$32, %rsp
	.seh_stackalloc 32
	.seh_endprologue
	movl	%edx, 28(%rsp)
	movq	%rcx, 16(%rsp)
	movl	$1, 12(%rsp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	movl	12(%rsp), %eax
	cmpl	28(%rsp), %eax
	jge	.LBB0_10
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movq	16(%rsp), %rax
	movslq	12(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 8(%rsp)
	movl	12(%rsp), %eax
	subl	$1, %eax
	movl	%eax, 4(%rsp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	cmpl	$0, 4(%rsp)
	movb	%al, 3(%rsp)                    # 1-byte Spill
	jl	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
	movq	16(%rsp), %rax
	movslq	4(%rsp), %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	8(%rsp), %eax
	setg	%al
	movb	%al, 3(%rsp)                    # 1-byte Spill
.LBB0_5:                                #   in Loop: Header=BB0_3 Depth=2
	movb	3(%rsp), %al                    # 1-byte Reload
	testb	$1, %al
	jne	.LBB0_6
	jmp	.LBB0_8
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=2
	movq	16(%rsp), %rax
	movslq	4(%rsp), %rcx
	movl	(%rax,%rcx,4), %edx
	movq	16(%rsp), %rax
	movl	4(%rsp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.7:                                #   in Loop: Header=BB0_3 Depth=2
	movl	4(%rsp), %eax
	addl	$-1, %eax
	movl	%eax, 4(%rsp)
	jmp	.LBB0_3
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
	movl	8(%rsp), %edx
	movq	16(%rsp), %rax
	movl	4(%rsp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movl	%edx, (%rax,%rcx,4)
# %bb.9:                                #   in Loop: Header=BB0_1 Depth=1
	movl	12(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 12(%rsp)
	jmp	.LBB0_1
.LBB0_10:
	.seh_startepilogue
	addq	$32, %rsp
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
	subq	$56, %rsp
	.seh_stackalloc 56
	.seh_endprologue
	movl	$0, 52(%rsp)
	movq	.L__const.main.list(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	.L__const.main.list+8(%rip), %rax
	movq	%rax, 40(%rsp)
	movl	.L__const.main.list+16(%rip), %eax
	movl	%eax, 48(%rsp)
	leaq	32(%rsp), %rcx
	movl	$5, %edx
	callq	"?insertSort@@YAXQEAHH@Z"
	xorl	%eax, %eax
	.seh_startepilogue
	addq	$56, %rsp
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.section	.rdata,"dr"
	.p2align	4, 0x0                          # 
.L__const.main.list:
	.long	5                               # 0x5
	.long	4                               # 0x4
	.long	3                               # 0x3
	.long	2                               # 0x2
	.long	1                               # 0x1

