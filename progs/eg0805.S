        .intel_syntax noprefix
        .extern printf
        .section .data
         #数据定义
         msg: .asciz "Hello Assembly!"
        .section .text
        .global main
        main:
        #主程序
        lea rcx, msg[rip]
        //xor eax, eax        #对于整数/指针参数，AL=向量寄存器使用数量(0)
        call printf

        mov eax, 0
        ret

