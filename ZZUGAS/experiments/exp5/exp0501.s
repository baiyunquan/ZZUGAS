.section .data
ch1:
	.asciz "N\n"
ch2:
	.asciz "a\n"
ch3:
	.asciz "8\n"
	.align 8
error_msg:
	.asciz "Error! Next One！\n"
correct_msg:
	.asciz "Great！\n"

.section .text
.globl main
.type  main, @function

main:
	leaq ch1(%rip), %rax
	call dispmsg
	movb ch1(%rip), %al
	cmpb $'0', %al
	jl NotNumOne
	cmpb $'9', %al
	jg NotNumOne
	leaq correct_msg(%rip), %rax
	call dispmsg
	jmp NumTwo

NotNumOne:
	leaq error_msg(%rip), %rax
	call dispmsg

NumTwo:
	leaq ch2(%rip), %rax
	call dispmsg
	movb ch2(%rip), %al
	cmpb $'0', %al
	jl NotNumTwo
	cmpb $'9', %al
	jg NotNumTwo
	leaq correct_msg(%rip), %rax
	call dispmsg
	jmp NumThree

NotNumTwo:
	leaq error_msg(%rip), %rax
	call dispmsg

NumThree:
	leaq ch3(%rip), %rax
	call dispmsg
	movb ch3(%rip), %al
	cmpb $'0', %al
	jl NotNumThree
	cmpb $'9', %al
	jg NotNumThree
	leaq correct_msg(%rip), %rax
	call dispmsg
	jmp Done

NotNumThree:
	leaq error_msg(%rip), %rax
	call dispmsg

Done:
	xorl %eax, %eax
	ret
