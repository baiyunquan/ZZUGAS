        .intel_syntax noprefix
        
        //.extern printf
        //.extern scanf
       
        .data
         #数据定义
         msg: .asciz "Enter a real number:  "
         format1:	.asciz "%f"
         var:	.byte 0,0,0,0
         msg2:	.asciz "\nThe codes in machine:  %X\n"

       .text
        .global main
        main:
        #主程序
  //      sub rsp, 8
        lea rcx,  msg[rip]
       // xor eax, eax        #Linux:对于整数/指针参数，AL=向量寄存器使用数量(0)
        call printf

        lea rcx, format1[rip]
        lea rdx, var[rip]
//        mov eax, 1        #Linux:表示有浮点参数
        call scanf

        lea rcx,  msg2[rip]
        mov rdx, var[rip]
   //     xor eax, eax        #Linux:
        call printf
//        add rsp,8 
        mov eax, 0
        ret