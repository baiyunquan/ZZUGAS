/* eg0403.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        pushf
        pop rax
        call disphx
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret