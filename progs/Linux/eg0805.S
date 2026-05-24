.intel_syntax noprefix
        .extern printf
         .data
         #数据定义
         msg: .asciz "Hello Assembly!"
        .section .text
        .global main
        main:
        #主程序
       // sub rsp, 32
        lea rdi, msg[rip]
        xor eax, eax        #对于整数/指针参数，AL=向量寄存器使用数量(0)
        call printf
      //  add rsp, 32
        mov eax, 0
        ret

