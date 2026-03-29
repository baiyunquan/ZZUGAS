GAS LISTING /tmp/ccDexQNQ.s 			page 1


   1              	# 1 "./5/eg0513.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./5/eg0513.S"
   8              	# eg0513.s
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 FDFFFFFF 	 array: .long -3,0,20,900,587,-632,777,234,-34,-56 #假设一个数组
  11      00000000 
  11      14000000 
  11      84030000 
  11      4B020000 
  12              	    .equ count, (. - array)/4 #数组的元素个数
  13 0028 00000000 	    max: .space 4 #存放最大值
  14              	
  15              	 .text #定义代码段
  16              	        .globl main
  17              	main: # 程序执行起始位置
  18 0000 B9090000 	 mov ecx, count-1 #元素个数减1是循环次数
  18      00
  19 0005 488D3500 	 lea rsi, array[rip]
  19      000000
  20 000c 8B06     	 mov eax,[rsi] #取出第一个元素给EAX，用于暂存最大值
  21 000e 4883C604 	again: add rsi,4
  22 0012 3B06     	 cmp eax,[rsi] #与下一个数据比较
  23 0014 7D02     	 jge next #已经是较大值，继续下一个循环比较
  24 0016 8B06     	 mov eax,[rsi] #EAX取得更大的数据
  25 0018 E2F4     	next: loop again #计数循环
  26 001a 89050000 	 mov max[rip],eax #保存最大值
  26      0000
  27 0020 E8000000 	    call dispsid
  27      00
  28              	
  29 0025 B8000000 	      mov eax,0
  29      00
  30 002a C3       	 ret # 程序正常执行结束
