#eg0523.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
temp:	.space 4  	#共享变量
Binstr: .asciz "01111111"
	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
	lea rdx, Binstr[rip] #入口参数rdx
	call BtoD
	mov eax,temp[rip]	#获得出口参数
	call disphd
	
	mov eax, 0
	ret
	
	#子程序
BtoD:	#二进制字符串转换为双字数值子程序
	push rax	#出口参数eax：共享变量TEMP
	push rbx
 	push rcx
 	push rdx
 	
	xor ebx,ebx	#rbx用于存放二进制结果
	mov ecx,32	#限制最多字符的个数
L2:	mov al,[rdx]	#输入一个字符
    cmp al,0
	jz L1       #字符串以0结尾
	sub al,'0'	#对输入的字符进行转化
	shl ebx,1	#EBX的值乘以2
	or bl,al	#BL和AL相加
	inc rdx
	loop L2	#循环键入字符
L1:	mov temp[rip],ebx	#把EBX的二进制结果存放TEMP返回
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret





