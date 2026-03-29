GAS LISTING /tmp/ccBbvWVH.s 			page 1


   1              	# 1 "./progs/eg0410.S"
   2              	# 1 "<built-in>"
   3              	# 1 "<command-line>"
   4              	# 31 "<command-line>"
   5              	# 1 "/usr/include/stdc-predef.h" 1 3 4
   6              	# 32 "<command-line>" 2
   7              	# 1 "./progs/eg0410.S"
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
  19 0000 48C7C300 	        mov rbx,0
  19      000000
  20              	
  21 0007 4C8D0500 	        lea r8,dvar1[rip]
  21      000000
  22 000e 4C8D0D00 	        lea r9,dvar2[rip]
  22      000000
  23 0015 4C8D1500 	        lea r10,dvar3[rip]
  23      000000
  24              	
  25 001c 418B0418 	        mov eax,[r8+rbx]
  26 0020 412B0419 	        sub eax,[r9+rbx]#低位双字相减，eax=0x6fffeebe,EFLAGS=0x00000A16
  27 0024 4189041A 	        mov [r10+rbx],eax
  28              	
  29 0028 418B4418 	        mov eax,[r8+rbx+4]
  29      04
  30 002d 411B4419 	        sbb eax,[r9+rbx+4]
  30      04
  31              	        #高位双字相减，再减CF，eax=0x00021000,EFLAGS=0x00000206
  32 0032 4189441A 	        mov [r10+rbx+4],eax
  32      04
  33              	
  34              	
  35 0037 488B0500 	        mov rax,dvar3[rip]
  35      000000
  36 003e E8000000 	        call disphx
  36      00
  37 0043 E8000000 	        call dispcrlf
  37      00
  38              	
  39              	        #返回值
  40 0048 31C0     	       xor eax,eax #返回0
  41 004a C3       	       ret
