GAS LISTING /tmp/ccoxOSYa.s 			page 1


   1              	# 1 "./5/eg0512.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./5/eg0512.S"
   8              	#eg0512.s
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 00000000 	 N: .long 0
  12 0004 6F766572 	 error: .ascii "overflower\n"
  12      666C6F77 
  12      65720A
  13 000f 00       	       .byte 0
  14              	 .text #定义代码段
  15              	        .globl main
  16              	main: # 程序执行起始位置
  17 0000 B8010000 	 mov eax, 1
  17      00
  18 0005 8B0D0000 	 mov ecx, N[rip]
  18      0000
  19 000b 83F900   	      cmp ecx, 0
  20 000e 7411     	      jz L1
  21 0010 0FAFC1   	again: imul eax, ecx
  22 0013 83F800   	 cmp eax,0
  23 0016 7809     	 js L1
  24 0018 E2F6     	 loop again
  25 001a E8000000 	    call dispsid
  25      00
  26 001f EB0C     	    jmp L2
  27 0021 488D0500 	  L1: lea rax, error[rip]
  27      000000
  28 0028 E8000000 	  call dispmsg
  28      00
  29 002d B8000000 	 L2: mov eax,0
  29      00
  30 0032 C3       	 ret # 程序正常执行结束
