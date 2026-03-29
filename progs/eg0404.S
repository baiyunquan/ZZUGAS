/* eg0404.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        
        .section .text
        .globl main
        main:
        mov al,0x7
        add al, 0xfb
       pushf
       # pushf
       # call disphb
        #call dispcrlf
        pop rax 
        #call disphd
       # pop rax
        call disprf
        call dispcrlf
        
        mov eax, 0x10000
        add eax, 0x20000
        pushf
        #call disphd
        #call dispcrlf
        pop rax
        call disprf
        
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret