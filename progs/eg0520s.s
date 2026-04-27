.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	N: .long 10
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov rcx, N[rip]	#主程序（指令待填）
    call fact
    call dispsid
    mov eax,0
	ret                   # 程序正常执行结束
	#子程序（指令待填）
	fact:
	push  rbx     #保存rbx
	mov ebx, ecx  #入口参数rcx：n
	test ecx, ecx 
	je .L2       # n=0时，返回1
.L4:	lea ecx, -1[rcx] # n不等于0，则计算n*fact(n-1)
	call fact        #递归调用fact
	imul eax, ebx    #fact（n-1）返回，n*fact（n-1）
	jmp .L2
.L1:         mov eax, 1   # 返回值在eax
.L2:	pop rbx      #恢复rbx
	ret          #函数返回
