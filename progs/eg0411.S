/* eg0411.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
       
        .section .text
        .globl main
        main:
        mov  eax, -100
        call disphd
        call dispcrlf
        
        
        mov  eax, -100
        neg   eax
        call disphd
        
        
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret