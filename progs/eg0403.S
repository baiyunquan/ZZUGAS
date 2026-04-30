/* eg0403.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        pushf
        pop rax
        call disphx
        #返回值
       xor eax,eax        #返回0
       ret