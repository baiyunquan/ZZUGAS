#eg0519.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
        call dpcrlf
        mov eax,0
        ret                   # 程序正常执行结束
        #子程序
dpcrlf:	#回车换行子程序
	push rax	#保护寄存器
	mov al,0x0d	#输出回车字符
	call dispc	#子程序中调用子程序，实现子程序嵌套
	mov al,0x0a	#输出换行字符
	call dispc	#子程序中调用子程序，实现子程序嵌套
	pop rax	#恢复寄存器
	ret	#子程序返回


