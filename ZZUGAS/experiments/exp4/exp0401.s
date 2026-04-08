.intel_syntax noprefix

.data


.text
.globl main
.type  main, @function

main:
    mov eax,0b10011100
    and eax,0x80
    or eax,0x7f
    xor eax,0xfe
    mov eax,0b1010 
    shr eax,2
    shl eax,1
    and eax,3
    mov eax,0b1011
    rol eax,2
    rcr eax,1
    or eax,3
    xor eax,eax

    mov eax, 0
    ret
    