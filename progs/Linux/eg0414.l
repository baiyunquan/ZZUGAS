GAS LISTING /tmp/ccDpyDsE.s 			page 1


   1              	# 1 "./progs/eg0414.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0414.S"
   8              	
   9              	        .intel_syntax noprefix
  10              	
  11              	        .section .data
  12              	        .section .text
  13              	        .globl main
  14              	        main:
  15 0000 B89CFFFF 	        mov eax, -100
  15      FF
  16              	        #CDQ
  17 0005 BA000000 	        mov edx,0
  17      00
  18 000a BB0A0000 	        mov ebx, 10
  18      00
  19              	        #idiv ebx
  20              	
  21 000f F7F3     	        div ebx
  22              	
  23 0011 52       	        push rdx
  24 0012 9C       	        pushfq
  25 0013 E8000000 	        call dispuid
  25      00
  26 0018 E8000000 	        call dispcrlf
  26      00
  27              	
  28 001d 58       	       pop rax
  29              	
  30              	
  31 001e E8000000 	        call disphd
  31      00
  32 0023 E8000000 	        call dispcrlf
  32      00
  33              	
  34              	
  35 0028 5A       	        pop rdx
  36 0029 89D0     	        mov eax, edx
  37 002b E8000000 	        call disphd
  37      00
  38 0030 E8000000 	        call dispcrlf
  38      00
  39              	
  40              	
  41              	
  42              	        #返回值
  43 0035 31C0     	       xor eax,eax #返回0
  44 0037 C3       	       ret
