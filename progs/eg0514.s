# eg0514.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	key: .byte 234	#假设的一个密钥
    
msg1:	.ascii "This is a screte." #源字符串
        .equ count , .-msg1
        .byte 0
msg2:	.ascii "Encrypted message:\0 "
msg3:   .ascii "\nOriginal messge:\0"

	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov ecx, count#ECX＝实际输入的字符个数，作为循环的次数
      
	#xor rbx,rbx	#RBX指向输入字符
	mov al,key[rip]	#AL＝密钥
	lea rsi,msg1[rip] 
encrypt:	#xor [rsi+rbx],al	#异或加密
      xor -1[rsi+rcx],al
	#inc rbx
      loop encrypt #处理下一个字符, 等同于指令dec ecx  jnz encrypt
	
	lea rax, msg2[rip]
	call dispmsg
	lea rax,msg1[rip]	#显示加密后的密文
	call dispmsg
	
	lea rsi,msg1[rip] 
	mov ecx, count #ECX＝实际输入的字符个数，作为循环的次数
      
	#xor rbx,rbx	 #RBX指向输入字符
	mov al,key[rip]	#AL＝密钥
decrypt:	#xor [rsi+rbx],al	#异或解密
	#inc rbx
      xor -1[rsi+rcx],al
	loop decrypt #处理下一个字符,等同于指令dec ecx  jnz decrypt
	
	lea rax, msg3[rip]
	call dispmsg
	lea rax, msg1[rip]	#显示解密后的明文
	call dispmsg

    
      mov eax,0
	ret                   # 程序正常执行结束
	
