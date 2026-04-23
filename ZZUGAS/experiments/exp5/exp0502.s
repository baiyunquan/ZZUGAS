.data
DVAR:   .long 0x57
UpOne:  .byte 'L'
LowOne: .byte 'R'
AllZero: .byte 'M'

	.text
	.globl main
main:
    movl DVAR(%rip), %eax
    andl $0x80000000, %eax
    jz  label_judgeLow

label_UpOne:
    movb UpOne(%rip), %al
    call dispc
    jmp Done

label_judgeLow:
    movl DVAR(%rip), %eax
    andl $0x1, %eax
    jz  label_AllZero

label_LowOne:
    movb LowOne(%rip), %al
    call dispc
    jmp Done

label_AllZero:
    movb LowOne(%rip), %al
    call dispc

Done:
 #   call dispcrlf
	xorl %eax, %eax
	ret
