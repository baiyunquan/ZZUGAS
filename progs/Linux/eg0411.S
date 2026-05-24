/* eg0411.s for GCC_64*/
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
        
        
        #返回值
       xor eax,eax        #返回0
       ret