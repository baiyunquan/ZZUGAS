GAS LISTING /tmp/ccOUBtP8.s 			page 1


   1              	# 1 "./progs/eg0409.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0409.S"
   8              	
   9              	        .intel_syntax noprefix
  10              	
  11              	        .section .data
  12              	
  13              	        .section .text
  14              	        .globl main
  15              	        main:
  16 0000 B061     	        mov al,'a'
  17 0002 2C20     	        sub al, 0x20
  18 0004 E8000000 	        call disphb
  18      00
  19              	
  20              	        #返回值
  21 0009 31C0     	       xor eax,eax #返回0
  22 000b C3       	       ret
