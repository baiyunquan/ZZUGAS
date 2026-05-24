#eg0521.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	regd:	.ascii "EAX=" #显示EAX内容，
	        .space 8      #预留8个字符（字节）空间
	        .byte 13,10,0 #回车换行，以0结尾
	.text	#定义代码段
    .globl main
main:		# 程序执行起始位置
       mov eax, 0x1234abcd	#假设一个要显示的数据
	   xor rbx,rbx	#使用rBX相对寻址访问REGD字符串
	   lea rdi,regd[rip]
	mov ecx,8	#8位十六进制数
again:	rol eax,4	#高4位循环移位进入低4位，作为子程序的入口参数
	push rax	#子程序利用AL返回结果，所以需要保存EAX中的数据
	call htoasc1	#调用子程序
	mov 4[rdi+rbx],al	#保存转换后的ASCII码
	pop rax	#恢复保存的数据
	inc rbx
	loop again
	
	lea rax,regd[rip] #等价于 mov rax, offset regd[rip]
	call dispmsg	#显示

        mov eax,0
        ret                   # 程序正常执行结束
        #子程序
htoasc:	#将AL低4位表达的一位十六进制数转换为ASCII码
   
  
	and al,0xf	#只取AL的低4位
	or al,0x30	#AL高4位变成3，实现加30H
	cmp al,0x39	#是0～9，还是A～F
	jbe htoend
	add al,7	#是A～F，其ASCII码再加上7

htoend: ret	#子程序返回

htoasc1:	#将AL低4位表达的一位十六进制数转换为ASCII码
    push rdi
	and rax, 0xf
	lea rdi,.ASCII[rip]
	mov al, [rdi+rax]
	pop rdi
	ret	#子程序返回
#子程序的局部数据
.ASCII:	.ascii "0123456789ABCDEF"
    
    