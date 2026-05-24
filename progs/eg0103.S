	/* eg0103.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
         msg:  .asciz "Hello, World!\n"
        .section .text
        .globl main
        main:
        lea rax,  msg[rip]        # 入口参数: 字符串首地址
        call dispmsg
       #返回值
       xor eax,eax        #返回0
       ret

