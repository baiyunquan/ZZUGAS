#eg0522.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	array:	.long 1234567890,-1234,0,1,-987654321,32767,-32768,5678,-5678,9000
	.equ len, (.-array)/4
      writebuf: .space 13 #显示缓冲区              

	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
       mov rcx,len
	 mov rbx,0
again:	
     	lea rsi,array[rip]
      lea rdi,writebuf[rip]	#入口参数：rdi，指向显示缓冲区
      mov eax,[rsi+rbx*4] 	#EAX＝入口参数
	call write	#调用子程序，显示一个数据
	inc rbx
	loop again
     
      mov eax,0
      ret                   # 程序正常执行结束
        #子程序
write:		#显示有符号十进制数的子程序，EAX，RDI＝入口参数
	push rbx	#保护寄存器
	push rcx
	push rdx
	push rsi

      mov r12,rdi
	test eax,eax	#判断数据是零、正数或负数
	jnz write1	#不是零，跳转
	mov byte ptr [r12],'0'	#是零，设置“0”
	inc r12
	jmp write5	#转向显示
write1: jns write2	#是正数，跳转
	mov byte ptr [r12],'-'	#是负数，设置负号“－”
	inc r12
	neg eax	#数据求补（绝对值）
write2:	mov ecx,10
      push rcx	#10压入堆栈，作为退出标志
write3:	cmp eax,0	#数据（商）为零，转向保存
	jz write4 
	xor edx,edx	#零位扩展被除数为EDX.EAX
	div ecx	#数据除以10：EDX.EAX÷10
	add edx,0x30	#余数（0～9）转换为ASCII码
	push rdx	#数据各位先低位后高位压入堆栈
	jmp write3
write4:	pop rdx	#数据各位先高位后低位弹出堆栈
	cmp edx,ecx	#是结束标志10，转向显示
	je write5
	mov [r12],dl	#数据保存到缓冲区
	inc r12
	jmp write4
	
write5: mov byte ptr [r12],'\n'	#给显示内容加上回车换行和结尾标志
	  mov byte ptr 1[r12],0
	
      mov rax, rdi
	call dispmsg

	pop rsi #恢复寄存器
	pop rdx	
	pop rcx
	pop rbx	
      ret	#子程序返回


