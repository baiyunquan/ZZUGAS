.data
DVAR:   .long 0x57
IsOne:  .byte 'L'
NotOne: .byte 'M'

	.text
	.globl main
main:
    movl DVAR(%rip), %eax
    andl $0x80000000, %eax
    jz  label_NotOne
    movb IsOne(%rip), %al
    call dispc
    jmp Done

label_NotOne:
    movb NotOne(%rip), %al
    call dispc
	
Done:
    call dispcrlf
	xorl %eax, %eax
	ret
