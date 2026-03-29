/* eg0408.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        dvar1: .long 0x82347856,0x67783000
        dvar2: .long 0x12348998,0x67762000
        dvar3: .quad 0

        .section .text
        .globl main
        main:
        mov al, 0x80
        sub al,0x7
        pushf
        call disphb
        call dispcrlf
        
        pop rax
        call disprf
        
        mov eax, 0x80
        sub eax, 0x7
        pushf
        call disphd
        call dispcrlf
        
        pop rax
        call disprf
        #·µ»ØÖµ
       xor eax,eax        #·µ»Ø0
       ret