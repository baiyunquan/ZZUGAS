/* eg0303.S*/
      .intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
    x: .long 0x12345678,0x9ABCDEF0
    y:  .ascii "12345"
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
    mov eax,x[rip] /*有效地址=x+rip,将有效地址的双字值复制到ebx */
    call disphd
    call dispcrlf
    mov eax,y[rip] /*有效地址=y+rip,将有效地址的双字值复制到ebx */
    call disphd
    call dispcrlf
    mov rax,x[rip+4] /*有效地址=x+rip+4,将有效地址的四字值复制到rbx */
    call disphx
    call dispcrlf
    #主程序（指令待填）
    mov eax,0
	ret                   # 程序正常执行结束
	