GAS LISTING /tmp/ccZgjXnN.s 			page 1


   1              	# 1 "./progs/eg0420.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0420.S"
   8              	
   9              	.intel_syntax noprefix #采用Intel语法，面向X86处理器时使用
  10              	 .data #定义数据段
  11              	
  12              	 .text #定义代码段
  13              	        .globl main
  14              	main: # 程序执行起始位置
  15              	
  16 0000 B080     	 mov al, 0x80
  17 0002 0480     	 add al, 0x80
  18              	
  19 0004 9C       	 pushfq
  20              	
  21 0005 8B0424   	 mov eax, dword ptr [rsp]
  22 0008 E8000000 	 call disphd
  22      00
  23 000d E8000000 	 call dispcrlf
  23      00
  24              	
  25 0012 8B0424   	 mov eax, dword ptr [rsp]
  26 0015 83E001   	 and eax, 1 #截取CF， D0
  27 0018 E8000000 	 call dispuid
  27      00
  28 001d E8000000 	 call dispcrlf
  28      00
  29              	
  30 0022 8B0424   	 mov eax, dword ptr [rsp]
  31 0025 C1E806   	 shr eax, 6
  32 0028 83E001   	 and eax, 1 #截取ZF， D6
  33 002b E8000000 	 call dispuid
  33      00
  34 0030 E8000000 	 call dispcrlf
  34      00
  35              	
  36 0035 8B0424   	 mov eax, dword ptr [rsp]
  37 0038 C1E807   	 shr eax, 7
  38 003b 83E001   	 and eax, 1 #截取SF， D7
  39 003e E8000000 	 call dispuid
  39      00
  40 0043 E8000000 	 call dispcrlf
  40      00
  41              	
  42 0048 8B0424   	 mov eax, dword ptr [rsp]
  43 004b C1E80B   	 shr eax, 11
  44 004e 83E001   	 and eax, 1 #截取OF， D11
  45 0051 E8000000 	 call dispuid
  45      00
  46              	
  47 0056 59       	 pop rcx
  48 0057 B8000000 	      mov eax,0
GAS LISTING /tmp/ccZgjXnN.s 			page 2


  48      00
  49 005c C3       	 ret # 程序正常执行结束
