GAS LISTING /tmp/cc5HtoAO.s 			page 1


   1              	# 1 "./progs/eg0413.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0413.S"
   8              	
   9              	        .intel_syntax noprefix
  10              	
  11              	        .section .data
  12 0000 00000080 	        x: .long 0x80000000 #0x0fffe1234
  13 0004 FFFFFF7F 	       y: .long 0x7FFFFFFF#001e1234
  14 0008 00000000 	        result: .quad 0
  14      00000000 
  15              	
  16              	
  17              	        .section .text
  18              	        .globl main
  19              	        main:
  20 0000 8B050000 	        mov eax,x[rip] #eax<-x,eax=fffeh
  20      0000
  21              	        #mul dword ptr y[rip] #乘法：eax*y，edx.eax=0x0000001E11F95A90
  22              	        #imul dword ptr y[rip] #乘法：eax*y，edx.eax=0x0000FFFFFFC55A90
  23 0006 0FAF0500 	        imul eax,y[rip] #eax=FEFB5A90
  23      000000
  24 000d 9C       	        pushf
  25 000e E8000000 	        call disphd
  25      00
  26 0013 58       	        pop rax
  27 0014 E8000000 	        call disprf
  27      00
  28              	
  29              	        #mov dword ptr result[rip] , eax #存放乘积的低双字部分
  30              	        #mov dword ptr result[rip+2],edx #存放乘积的高双字部分
  31              	
  32              	        #mov rax, result[rip]
  33              	        #call disphx
  34              	
  35              	
  36              	        #返回值
  37 0019 31C0     	       xor eax,eax #返回0
  38 001b C3       	       ret
