/* eg0306.S*/
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
    x: .long 0x12345678,0x9ABCDEF0
   
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
        
    lea rax,x[rip] /*x地址复制到rax*/
    mov rbx,0
    mov ebx,[rax+rbx] /*有效地址=rax+rbx,将有效地址的双字值复制到ebx */
    mov eax, ebx
    call disphd
    call dispcrlf
    
    lea rax,x[rip] /*x地址复制到rax*/
    mov rbx,4
    mov ebx,[rax+rbx] /*有效地址=rax+rbx,将有效地址的双字值复制到ebx */
    mov eax, ebx
    call disphd
    call dispcrlf

    #主程序（指令待填）
    mov eax,0
	ret                   # 程序正常执行结束