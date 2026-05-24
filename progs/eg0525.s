#eg0525.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
array: .long  675, 354, -34, 198, 267, 0, 9, 2371, -67, 4257
.equ len,(.-array)/4
	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
	push len	#压入数据个数
    lea rax, array[rip]
	push rax	#压数组的偏移地址
	call mean_v2	#调用求平均值子程序，出口参数：EAX＝平均值（整数部分）
	add rsp,16	#平衡堆栈（压入了16个字节数据）
	call dispsid	#显示
	mov eax, 0
	ret
	
	#子程序
mean:		#计算32位有符号数平均值子程序
	push rbp	#入口参数：顺序压入数据个数和数组偏移地址
	mov rbp,rsp	#出口参数：EAX＝平均值
	push rbx	#保护寄存器
	push rcx
	push rdx
	mov rbx,[rbp+16]	#EBX＝堆栈中取出的偏移地址
	mov rcx,[rbp+24]	#ECX＝堆栈中取出的数据个数
	xor eax,eax	#EAX保存和值
	xor rdx,rdx	#EDX＝指向数组元素
mean1:	add eax,[rbx+rdx*4]	#求和
	add edx,1	#指向下一个数据
	cmp edx,ecx	#比较个数
	jb mean1	#循环
	cdq	#将累加和EAX符号扩展到EDX
	idiv ecx	#有符号数除法，EAX＝平均值（余数在EDX中）
	pop rdx	#恢复寄存器
	pop rcx
	pop rbx
	pop rbp
	ret
	
mean_v2:		#改进计算32位有符号数平均值子程序
	push rbp	#入口参数：顺序压入数据个数和数组偏移地址
	mov rbp,rsp	#出口参数：EAX＝平均值
	push rbx	#保护寄存器
	push rcx
	push rdx
	push rsi
	push rdi
	mov rbx,[rbp+16]	#EBX＝堆栈中取出的偏移地址
	mov rcx,[rbp+24]	#ECX＝堆栈中取出的数据个数
	xor rsi,rsi         #ESI＝求和的低32位值
	mov rdi,rsi         #EDI＝求和的高32位值
	
mean1_v2:	
	mov eax,[rbx]	#EAX＝取出一个数据
	cdq	#EAX符号扩展到EDX
	add esi,eax	#求和低32位
	adc edi,edx	#求和高32位
	add rbx,4	#指向下一个数据
	dec ecx	#数据个数减少一个
	jnz mean1_v2	#循环（这两条指令等同于LOOP指令）
	mov eax,esi	#累加和在EDX.EAX
	mov edx,edi
	idiv dword ptr [rbp+24]	#有符号数除法，EAX＝平均值（余数在EDX中）
	pop rdi	#恢复寄存器
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rbp
	ret







