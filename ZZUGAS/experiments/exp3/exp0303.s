.section .data
x:  .long 0x12345678
y:  .long 0x9ABCDEF0
m:  .long 0x3456789A
n:  .long 0x96543210
.equ DATA_LEN, 16

.section .text
.globl main
.type  main, @function

main:
    movl $n, %ebx 
    movl (%ebx), %eax
    call dispsid

    movl $x, %ebx
    movl 12(%ebx), %eax
    call dispsid

    movl $1, %eax
    xorl %ebx, %ebx
    int  $0x80
	