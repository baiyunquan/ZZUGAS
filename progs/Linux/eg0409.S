/* eg0409.s for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        mov al,'a'
        sub al, 0x20
        call disphb
        
        #返回值
       xor eax,eax        #返回0
       ret