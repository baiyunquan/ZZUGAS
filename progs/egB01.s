# egB01.s in Linux Terminal for GAS
        .intel_syntax noprefix
        .include "io32_linux.s"
        .section .data
         msg:
        .asciz "Hello, World!\n"
        .section .text
        .global main
        main:
        mov eax,offset msg
        call dispmsg
        exit
