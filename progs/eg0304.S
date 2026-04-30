/* eg0304.S*/
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
    x: .long 0x12345678,0x9ABCDEF0
   msg: .ascii "effect address of x = "
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
    lea rax,msg[rip]
    call dispmsg
    call dispcrlf
    
    lea rax,x[rip] /*x地址复制到rax*/
    call disphx
    call dispcrlf

    lea rax,x[rip] 
    mov bl, [rax] /*有效地址=rax，将str的字节值复制到bl*/
    mov al, bl
    call disphb
    call dispcrlf
    
    lea rax,x[rip] /*x地址复制到rax*/
    mov bx, [rax] /*有效地址=rax，将str的字值复制到bx */
    mov ax, bx
    call disphw
    call dispcrlf
    
    lea rax,x[rip] /*x地址复制到rax*/
    mov ebx,[rax] /*有效地址=rax，将str的双字值复制到ebx */
    mov eax, ebx
    call disphd
    call dispcrlf
    
    lea rax,x[rip] /*x地址复制到rax*/
    mov rbx,QWORD ptr [rax] /*有效地址=rax，将str的四字值复制到rax */
    mov rax, rbx
    call disphx
    call dispcrlf

    #主程序（指令待填）
    mov eax,0
	ret                   # 程序正常执行结束