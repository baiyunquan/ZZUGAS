.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
.data
.set char, 0x20	#定义第一个可显示字符：空格，其ASCII值是20H
space:.byte char
	.rept 6 #重复6行
	   .rept 16	 #每行16个字符
	    .set char , char +1
	    .byte char,0x20
	   .endr
	   .ascii "\n"
	.endr
	.byte 0
	
	.text #代码段
	.global main
	main:
	lea rax,space[rip]
	call dispmsg
	mov eax, 0
	ret
	
