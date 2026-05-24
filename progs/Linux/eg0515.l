GAS LISTING /tmp/ccOgTupG.s 			page 1


   1              	# 1 "./5/eg0515.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./5/eg0515.S"
   8              	# eg0515.s
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 0000FF00 	 str: .byte 0,0,-1,0,0,0,39,67,9,10
  11      00002743 
  11      090A
  12              	 .equ count, .- str
  13 000a 206E6F74 	 msg: .ascii " not found!\n"
  13      20666F75 
  13      6E64210A 
  14              	
  15              	 .text #定义代码段
  16              	        .globl main
  17              	main: # 程序执行起始位置
  18 0000 488D1D00 	 lea rbx,str[rip]
  18      000000
  19 0007 B90A0000 	 mov ecx,count #计算器ecx清零
  19      00
  20 000c B8FFFFFF 	 mov eax, -1 #rdx记录下标
  20      FF
  21              	
  22 0011 FFC0     	 again: inc eax
  23 0013 4863C0   	 movsx rax, eax
  24 0016 803C0300 	 cmp byte ptr [rbx+rax], 0 #是否为0
  25 001a E1F5     	 loopz again #ZF=1,即是0则继续比较
  26              	
  27 001c 67E307   	 jecxz nofound #循环结束，如果ecx=0, 表示没有找到,等同于jz
  28              	
  29              	
  30 001f E8000000 	 call dispsid #显示下标
  30      00
  31 0024 EB0C     	 jmp done
  32              	 nofound:
  33 0026 488D0500 	 lea rax, msg[rip]
  33      000000
  34 002d E8000000 	 call dispmsg #显示not found
  34      00
  35              	 done:
  36 0032 B8000000 	      mov eax,0
  36      00
  37 0037 C3       	   ret # 程序正常执行结束
