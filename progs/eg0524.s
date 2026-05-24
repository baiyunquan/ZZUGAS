#eg0524.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
temp:	.space 4  	#共享变量
Decstr1: .asciz "+123456"
.equ len1, .-Decstr1
Decstr2: .asciz "-123456"
.equ len2, .-Decstr2
Decstr3: .asciz "01234560"
.equ len3, .-Decstr3
Decstr4: .asciz "1?23456"
.equ len4, .-Decstr4
	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
	lea rdx, Decstr1[rip] #入口参数rdx
	mov rcx, len1 #入口参数rcx,字符长度
	call DStoD
	mov eax,temp[rip]	#获得出口参数
	call dispsid	
	call dispcrlf
	
	lea rdx, Decstr2[rip] #入口参数rdx
	mov rcx, len2 #入口参数rcx,字符长度
	call DStoD
	mov eax,temp[rip]	#获得出口参数
	call dispsid
	call dispcrlf
		
	lea rdx, Decstr3[rip] #入口参数rdx
	mov rcx, len3 #入口参数rcx,字符长度
	call DStoD
	mov eax,temp[rip]	#获得出口参数
	call dispsid
	call dispcrlf
		
	lea rdx, Decstr4[rip] #入口参数rdx
	mov rcx, len4 #入口参数rcx,字符长度
	call DStoD
	mov eax,temp[rip]	#获得出口参数
	call dispsid
	call dispcrlf	
	
	mov eax, 0
	ret
	
	#子程序
DStoD:	#十进制字符串转换为双字数值子程序
	push rax	#出口参数：变量TEMP＝补码表示的二进制数值
	push rbx	#说明：负数用“－”引导
	push rcx
	push rdx
read0:	
	test ecx,ecx
	jz err	#没有输入数据，转向错误处理
	cmp ecx,12
	ja err	#输入超过12个字符，转向错误处理
	
	xor ebx,ebx	#EBX保存结果
	xor r8d,r8d	#r8d为正负标志，0为正，－1为负
	mov al,[rdx]	#取一个字符
	cmp al,'+'	#是“＋”，继续
	jz L1
	cmp al,'-'	#是“－”，设置－1标志
	jnz L2
	mov r8d,-1
L1:	inc rdx	#取下一个字符
	mov al,[rdx]
	test al,al	#是结尾0，转向求补码
	jz L3
L2:	cmp al,'0'	#不是0～9之间的数码，则输入错误
	jb err
	cmp al,'9'
	ja err
	sub al,0x30	#是0～9之间的数码，则转换为二进制数
	imul ebx,10	#原数值乘10：EBX＝EBX×10
	jc err	#CF＝1，说明乘积溢出，输入数据超出32位范围，出错
	movzx eax,al	#零位扩展，便于相加
	add ebx,eax	#原数值乘10后，与新数码相加
	cmp ebx,0x80000000	#数据超过2^31，出错
	jbe L1	#继续转换下一个数位
err:	lea rax, errmsg[rip]	#显示出错信息
	call dispmsg
	stc
	jmp L5
	########################
L3:	test r8d,r8d	#判断是正数还是负数
	jz L4
	neg ebx	#是负数，进行求补
	jmp L6
L4:	cmp ebx,0x7fffffff	#正数超过2^31-1，出错
	ja err
L6:	mov temp[rip],ebx	#设置出口参数
    clc
L5:	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret	#子程序返回
errmsg:	.asciz "string error, ending\n"





