	.intel_syntax noprefix

	.section .rdata,"dr"
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

	.text
	.globl main
main:
	lea rax, ch1[rip]
	call dispmsg
	mov al, byte ptr ch1[rip]
	cmp al, '0'
	jl NotNumOne
	cmp al, '9'
	jg NotNumOne
	lea rax, correct_msg[rip]
	call dispmsg
	jmp NumTwo

NotNumOne:
	lea rax, error_msg[rip]
	call dispmsg

NumTwo:
	lea rax, ch2[rip]
	call dispmsg
	mov al, byte ptr ch2[rip]
	cmp al, '0'
	jl NotNumTwo
	cmp al, '9'
	jg NotNumTwo
	lea rax, correct_msg[rip]
	call dispmsg
	jmp NumThree

NotNumTwo:
	lea rax, error_msg[rip]
	call dispmsg

NumThree:
	lea rax, ch3[rip]
	call dispmsg
	mov al, byte ptr ch3[rip]
	cmp al, '0'
	jl NotNumThree
	cmp al, '9'
	jg NotNumThree
	lea rax, correct_msg[rip]
	call dispmsg
	jmp Done

NotNumThree:
	lea rax, error_msg[rip]
	call dispmsg

Done:
	xor eax, eax
	ret
