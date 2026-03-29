GAS LISTING /tmp/cckZhFCD.s 			page 1


   1              	# 1 "./5/eg0514.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./5/eg0514.S"
   8              	# eg0514.s
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11 0000 EA       	 key: .byte 234 #假设的一个密钥
  12              	    .equ bufnum , 255
  13 0001 54686973 	msg1: .ascii "This is a screte." #源字符串
  13      20697320 
  13      61207363 
  13      72657465 
  13      2E
  14              	        .equ count , .-msg1
  15 0012 00       	        .byte 0
  16 0013 456E6372 	msg2: .ascii "Encrypted message:\0 "
  16      79707465 
  16      64206D65 
  16      73736167 
  16      653A0020 
  17 0027 0A4F7269 	msg3: .ascii "\nOriginal messge:\0"
  17      67696E61 
  17      6C206D65 
  17      73736765 
  17      3A00
  18              	
  19              	 .text #定义代码段
  20              	        .globl main
  21              	main: # 程序执行起始位置
  22 0000 B9110000 	 mov ecx, count#ECX＝实际输入的字符个数，作为循环的次数
  22      00
  23 0005 4831DB   	 xor rbx,rbx #RBX指向输入字符
  24 0008 8A050000 	 mov al,key[rip] #AL＝密钥
  24      0000
  25 000e 488D3500 	 lea rsi,msg1[rip]
  25      000000
  26 0015 30041E   	encrypt: xor [rsi+rbx],al #异或加密
  27 0018 48FFC3   	 inc rbx
  28 001b E2F8     	 loop encrypt #处理下一个字符, 等同于指令dec ecx jnz encrypt
  29              	
  30 001d 488D0500 	 lea rax, msg2[rip]
  30      000000
  31 0024 E8000000 	 call dispmsg
  31      00
  32 0029 488D0500 	 lea rax,msg1[rip] #显示加密后的密文
  32      000000
  33 0030 E8000000 	 call dispmsg
  33      00
  34              	
  35 0035 488D3500 	 lea rsi,msg1[rip]
  35      000000
  36 003c B9110000 	 mov ecx, count #ECX＝实际输入的字符个数，作为循环的次数
  36      00
GAS LISTING /tmp/cckZhFCD.s 			page 2


  37 0041 4831DB   	 xor rbx,rbx #RBX指向输入字符
  38 0044 8A050000 	 mov al,key[rip] #AL＝密钥
  38      0000
  39 004a 30041E   	decrypt: xor [rsi+rbx],al #异或解密
  40 004d 48FFC3   	 inc rbx
  41 0050 E2F8     	 loop decrypt #处理下一个字符,等同于指令dec ecx jnz decrypt
  42              	
  43 0052 488D0500 	 lea rax, msg3[rip]
  43      000000
  44 0059 E8000000 	 call dispmsg
  44      00
  45 005e 488D0500 	 lea rax, msg1[rip] #显示解密后的明文
  45      000000
  46 0065 E8000000 	 call dispmsg
  46      00
  47              	
  48              	
  49 006a B8000000 	      mov eax,0
  49      00
  50 006f C3       	 ret # 程序正常执行结束
