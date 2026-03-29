GAS LISTING ./progs/eg0304.s 			page 1


   1              	/* eg0304.S*/
   2              	.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
   3              		.data	#定义数据段
   4 0000 78563412 	    x: .long 0x12345678,0x9ABCDEF0
   4      F0DEBC9A 
   5 0008 65666665 	   msg: .ascii "effect address of x = "
   5      63742061 
   5      64647265 
   5      7373206F 
   5      66207820 
   6              		.text	#定义代码段
   7              	        .globl main
   8              	main:		# 程序执行起始位置
   9 0000 488D0500 	    lea rax,msg[rip]
   9      000000
  10 0007 E8000000 	    call dispmsg
  10      00
  11 000c E8000000 	    call dispcrlf
  11      00
  12              	    
  13 0011 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  13      000000
  14 0018 E8000000 	    call disphx
  14      00
  15 001d E8000000 	    call dispcrlf
  15      00
  16              	
  17 0022 488D0500 	    lea rax,x[rip] 
  17      000000
  18 0029 8A18     	    mov bl, [rax] /*有效地址=rax，将str的字节值复制到bl*/
  19 002b 88D8     	    mov al, bl
  20 002d E8000000 	    call disphb
  20      00
  21 0032 E8000000 	    call dispcrlf
  21      00
  22              	    
  23 0037 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  23      000000
  24 003e 668B18   	    mov bx, [rax] /*有效地址=rax，将str的字值复制到bx */
  25 0041 6689D8   	    mov ax, bx
  26 0044 E8000000 	    call disphw
  26      00
  27 0049 E8000000 	    call dispcrlf
  27      00
  28              	    
  29 004e 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  29      000000
  30 0055 8B18     	    mov ebx,[rax] /*有效地址=rax，将str的双字值复制到ebx */
  31 0057 89D8     	    mov eax, ebx
  32 0059 E8000000 	    call disphd
  32      00
  33 005e E8000000 	    call dispcrlf
  33      00
  34              	    
  35 0063 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  35      000000
  36 006a 488B18   	    mov rbx,QWORD ptr [rax] /*有效地址=rax，将str的四字值复制到rax */
GAS LISTING ./progs/eg0304.s 			page 2


  37 006d 4889D8   	    mov rax, rbx
  38 0070 E8000000 	    call disphx
  38      00
  39 0075 E8000000 	    call dispcrlf
  39      00
  40              	
  41              	    #主程序（指令待填）
  42 007a B8000000 	    mov eax,0
  42      00
  43 007f C3       		ret                   # 程序正常执行结束
