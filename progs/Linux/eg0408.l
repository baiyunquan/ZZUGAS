GAS LISTING /tmp/ccm7LVzz.s 			page 1


   1              	# 1 "./progs/eg0408.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0408.S"
   8              	
   9              	        .intel_syntax noprefix
  10              	
  11              	        .section .data
  12 0000 56783482 	        dvar1: .long 0x82347856,0x67783000
  12      00307867 
  13 0008 98893412 	        dvar2: .long 0x12348998,0x67762000
  13      00207667 
  14 0010 00000000 	        dvar3: .quad 0
  14      00000000 
  15              	
  16              	        .section .text
  17              	        .globl main
  18              	        main:
  19 0000 B0FB     	        mov al, 0xfb
  20 0002 2C07     	        sub al,0x7
  21 0004 9C       	        pushf
  22 0005 E8000000 	        call disphb
  22      00
  23 000a E8000000 	        call dispcrlf
  23      00
  24              	
  25 000f 58       	        pop rax
  26 0010 E8000000 	        call disprf
  26      00
  27              	
  28 0015 B8000001 	        mov eax, 0x10000
  28      00
  29 001a 2D002000 	        sub eax, 0x2000
  29      00
  30 001f 9C       	        pushf
  31 0020 E8000000 	        call disphd
  31      00
  32 0025 E8000000 	        call dispcrlf
  32      00
  33              	
  34 002a 58       	        pop rax
  35 002b E8000000 	        call disprf
  35      00
  36              	        #返回值
  37 0030 31C0     	       xor eax,eax #返回0
  38 0032 C3       	       ret
