GAS LISTING /tmp/cc8BxMLJ.s 			page 1


   1              	# 1 "./progs/eg0421.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0421.S"
   8              	
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 000000   	 msg:.byte 0,0,0
  12 0003 30313233 	 table: .ascii "0123456789ABCDEF"
  12      34353637 
  12      38394142 
  12      43444546 
  13              	
  14              	 .text #定义代码段
  15              	        .globl main
  16              	main: # 程序执行起始位置
  17 0000 488D1D00 	 lea rbx, table[rip]
  17      000000
  18              	
  19 0007 B064     	 mov al, 100
  20 0009 88C4     	    mov ah,al
  21              	
  22 000b 24F0     	    and al, 0xf0
  23 000d C0E804   	    shr al,4
  24 0010 480FB6C8 	    movzx rcx, al
  25 0014 8A040B   	    mov al, [rbx+rcx]
  26 0017 88050000 	    mov msg[rip],al
  26      0000
  27              	
  28 001d 88E0     	    mov al, ah
  29 001f 240F     	    and al, 0xf
  30 0021 480FB6C8 	    movzx rcx, al
  31 0025 8A040B   	    mov al, [rbx+rcx]
  32 0028 88050000 	    mov msg[rip+1],al
  32      0000
  33              	
  34 002e 488D0500 	 lea rax, msg[rip]
  34      000000
  35 0035 E8000000 	 call dispmsg
  35      00
  36              	
  37 003a B8000000 	    mov eax,0
  37      00
  38 003f C3       	 ret # 程序正常执行结束
