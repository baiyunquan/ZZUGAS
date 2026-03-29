GAS LISTING ./progs/eg0404.s 			page 1


   1              	/* eg0404.s*/
   2              	        .intel_syntax noprefix
   3              	        
   4              	        .section .data
   5              	        
   6              	        .section .text
   7              	        .globl main
   8              	        main:
   9 0000 B007     	        mov al,0x7
  10 0002 04FB     	        add al, 0xfb
  11 0004 9C       	       pushf
  12              	       # pushf
  13              	       # call disphb
  14              	        #call dispcrlf
  15 0005 58       	        pop rax 
  16              	        #call disphd
  17              	       # pop rax
  18 0006 E8000000 	        call disprf
  18      00
  19 000b E8000000 	        call dispcrlf
  19      00
  20              	        
  21 0010 B8000001 	        mov eax, 0x10000
  21      00
  22 0015 05000002 	        add eax, 0x20000
  22      00
  23 001a 9C       	        pushf
  24              	        #call disphd
  25              	        #call dispcrlf
  26 001b 58       	        pop rax
  27 001c E8000000 	        call disprf
  27      00
  28              	        
  29              	        #返回值
  30 0021 31C0     	       xor eax,eax        #返回0
  31 0023 C3       	       ret
