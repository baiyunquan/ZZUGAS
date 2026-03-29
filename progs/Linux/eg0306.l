GAS LISTING ./progs/eg0306.s 			page 1


   1              	/* eg0306.S*/
   2              	.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
   3              		.data	#定义数据段
   4 0000 78563412 	    x: .long 0x12345678,0x9ABCDEF0
   4      F0DEBC9A 
   5              	   
   6              		.text	#定义代码段
   7              	        .globl main
   8              	main:		# 程序执行起始位置
   9              	        
  10 0000 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  10      000000
  11 0007 48C7C300 	    mov rbx,0
  11      000000
  12 000e 8B1C18   	    mov ebx,[rax+rbx] /*有效地址=rax+rbx,将有效地址的双字值复制到ebx */
  13 0011 89D8     	    mov eax, ebx
  14 0013 E8000000 	    call disphd
  14      00
  15 0018 E8000000 	    call dispcrlf
  15      00
  16              	    
  17 001d 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  17      000000
  18 0024 48C7C304 	    mov rbx,4
  18      000000
  19 002b 8B1C18   	    mov ebx,[rax+rbx] /*有效地址=rax+rbx,将有效地址的双字值复制到ebx */
  20 002e 89D8     	    mov eax, ebx
  21 0030 E8000000 	    call disphd
  21      00
  22 0035 E8000000 	    call dispcrlf
  22      00
  23              	
  24              	    #主程序（指令待填）
  25 003a B8000000 	    mov eax,0
  25      00
  26 003f C3       		ret                   # 程序正常执行结束
