/* eg0414.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        .section .text
        .globl main
        main:
        mov  eax, -100
        #CDQ
        mov edx,0
        mov  ebx, 10
        #idiv  ebx

        div  ebx

        push rdx
        pushfq
        call dispuid
        call dispcrlf
       
       pop rax
       
        
        call disphd
        call dispcrlf


        pop rdx
        mov eax, edx
        call disphd
        call dispcrlf
        
        
        
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret