/* eg0409.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        mov al,'a'
        sub al, 0x20
        call disphb
        
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret