GAS LISTING ./progs/eg0308.s 			page 1


   1              	/* eg0308.S*/
   2              	.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
   3              		.data	#定义数据段
   4 0000 78563412 	   x: .long 0x12345678,0x9ABCDEF0,0x3456789A
   4      F0DEBC9A 
   4      9A785634 
   5              	   
   6              		.text	#定义代码段
   7              	        .globl main
   8              	main:		# 程序执行起始位置
   9              	        
  10 0000 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  10      000000
  11 0007 48C7C301 	    mov rbx,1
  11      000000
  12 000e 8B0498   	    mov eax,[rax+rbx*4] /*有效地址=rax+rbx+2,将有效地址的双字值复制到ebx */
  13 0011 E8000000 	    call disphd
  13      00
  14 0016 E8000000 	    call dispcrlf
  14      00
  15              	    
  16 001b 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  16      000000
  17 0022 48C7C301 	    mov rbx,1
  17      000000
  18 0029 8B449804 	    mov eax,[rax+rbx*4+4] /*有效地址=rax+rbx+4,将有效地址的双字值复制到ebx */
  19 002d E8000000 	    call disphd
  19      00
  20 0032 E8000000 	    call dispcrlf
  20      00
  21              	
  22              	    #主程序（指令待填）
  23 0037 B8000000 	    mov eax,0
  23      00
  24 003c C3       		ret                   # 程序正常执行结束
