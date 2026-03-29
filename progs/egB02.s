# egB02.s in Linux Terminal and Windows for GAS
        .intel_syntax noprefix
        .data
         msg:
        .asciz "Hello, World!\n"
        .text
        .global main
        main:
        lea rax,msg[rip]
        call dispmsg
        mov eax, 0
ret
