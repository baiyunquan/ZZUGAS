GAS LISTING ./progs/eg0303.s 			page 1


   1              	/* eg0303.S*/
   2              	      .intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
   3              		.data	#定义数据段
   4 0000 78563412 	    x: .long 0x12345678,0x9ABCDEF0
   4      F0DEBC9A 
   5 0008 31323334 	    y:  .ascii "12345"
   5      35
   6              		.text	#定义代码段
   7              	        .globl main
   8              	main:		# 程序执行起始位置
   9 0000 8B050000 	    mov eax,x[rip] /*有效地址=x+rip,将有效地址的双字值复制到ebx */
   9      0000
  10 0006 E8000000 	    call disphd
  10      00
  11 000b E8000000 	    call dispcrlf
  11      00
  12 0010 8B050000 	    mov eax,y[rip] /*有效地址=y+rip,将有效地址的双字值复制到ebx */
  12      0000
  13 0016 E8000000 	    call disphd
  13      00
  14 001b E8000000 	    call dispcrlf
  14      00
  15 0020 488B0500 	    mov rax,x[rip+4] /*有效地址=x+rip+4,将有效地址的四字值复制到rbx */
  15      000000
  16 0027 E8000000 	    call disphx
  16      00
  17 002c E8000000 	    call dispcrlf
  17      00
  18              	    #主程序（指令待填）
  19 0031 B8000000 	    mov eax,0
  19      00
  20 0036 C3       		ret                   # 程序正常执行结束
  21              		
