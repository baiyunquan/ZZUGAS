GAS LISTING /tmp/ccXn7I6j.s 			page 1


   1              	# 1 "./progs/eg0411.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0411.S"
   8              	
   9              	        .intel_syntax noprefix
  10              	
  11              	        .section .data
  12              	
  13              	        .section .text
  14              	        .globl main
  15              	        main:
  16 0000 B89CFFFF 	        mov eax, -100
  16      FF
  17 0005 E8000000 	        call disphd
  17      00
  18 000a E8000000 	        call dispcrlf
  18      00
  19              	
  20              	
  21 000f B89CFFFF 	        mov eax, -100
  21      FF
  22 0014 F7D8     	        neg eax
  23 0016 E8000000 	        call disphd
  23      00
  24              	
  25              	
  26              	        #返回值
  27 001b 31C0     	       xor eax,eax #返回0
  28 001d C3       	       ret
