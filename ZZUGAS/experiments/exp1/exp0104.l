GAS LISTING exp0104.s 			page 1


   1              		/* eg0103.s in Windows Terminal for GCC_64*/
   2              	        .intel_syntax noprefix
   3              	        
   4              	        .section .data
   5 0000 48656C6C 	         msg:  .asciz "Hello, Assembly!\n"
   5      6F2C2041 
   5      7373656D 
   5      626C7921 
   5      0A00
   6              	        .section .text
   7              	        .globl main
   8              	        main:
   9 0000 488D0500 	        lea rax,  msg[rip]        # 入口参数: 字符串首地址
   9      000000
  10 0007 E8000000 	        call dispmsg
  10      00
  11              	       #返回值
  12 000c 31C0     	       xor eax,eax        #返回0
  13 000e C3       	       ret
  14              	
