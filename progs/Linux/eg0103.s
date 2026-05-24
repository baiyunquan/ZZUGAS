 /* eg0103.s  
gcc -o eg0103 ./progs/eg0103.s ./lib/io_linux64.a */
        .intel_syntax noprefix
        .section .data
         msg:  .asciz "Hello, World!\n"
        .section .text
        .globl main
        main:
        lea rax,  msg[rip]        # 入口参数: 字符串首地址
        call dispmsg
        xor eax,eax        #程序结束返回
        ret
        