GAS LISTING /tmp/ccBzH3zM.s 			page 1


   1              	# 1 "./progs/eg0419.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0419.S"
   8              	#eg0419.S
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 54686520 	 buffer: .ascii "The processor vendor ID is "
  11      70726F63 
  11      6573736F 
  11      72207665 
  11      6E646F72 
  12 001b 00000000 	         .space 12 , 0
  12      00000000 
  12      00000000 
  13              	            bufsize= .- buffer
  14 0027 0A00     	            .asciz "\n"
  15              	
  16              	 # 数据定义（数据待填）
  17              	 .text #定义代码段
  18              	        .globl main
  19              	main: # 程序执行起始位置
  20 0000 B8000000 	 mov eax,0
  20      00
  21 0005 0FA2     	 cpuid #执行处理器识别指令
  22 0007 891D0000 	 mov dword ptr buffer[rip+bufsize-12],ebx
  22      0000
  23 000d 89150000 	 mov dword ptr buffer[rip+bufsize-8],edx
  23      0000
  24 0013 890D0000 	 mov dword ptr buffer[rip+bufsize-4],ecx
  24      0000
  25 0019 488D0500 	 lea rax,buffer[rip] #显示信息
  25      000000
  26 0020 E8000000 	 call dispmsg
  26      00
  27              	
  28 0025 B8000000 	    mov eax,0
  28      00
  29 002a C3       	 ret # 程序正常执行结束
