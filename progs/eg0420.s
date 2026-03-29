/* eg0420.s */
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	
	mov al, 0x80
	add al, 0x80
	
	pushfq
	
	mov eax, dword ptr [rsp]
	call disphd
	call dispcrlf
	
	mov eax, dword ptr [rsp]
	and eax, 1 #截取CF， D0
	call dispuid
	call dispcrlf
	
	mov eax, dword ptr [rsp]
	shr eax, 6
	and eax, 1 #截取ZF， D6
	call dispuid
	call dispcrlf
	
	mov eax, dword ptr [rsp]
	shr eax, 7
	and eax, 1 #截取SF， D7
	call dispuid
	call dispcrlf
	
	mov eax, dword ptr [rsp]
	shr eax, 11
	and eax, 1 #截取OF， D11
	call dispuid
	
	pop rcx
      mov eax,0
	ret                   # 程序正常执行结束
	
