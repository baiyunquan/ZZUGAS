GAS LISTING ./progs/eg0103.s 			page 1


   1              	 /* eg0103.s  */
   2              	        .intel_syntax noprefix
   3              	        .section .data
   4 0000 48656C6C 	         msg:  .asciz "Hello, World!\n"
   4      6F2C2057 
   4      6F726C64 
   4      210A00
   5              	        .section .text
   6              	        .globl main
   7              	        main:
   8 0000 488D0500 	        lea rax,  msg[rip]        # 入口参数: 字符串首地址
   8      000000
   9 0007 E8000000 	        call dispmsg
   9      00
  10 000c 31C0     	        xor eax,eax        #程序结束返回
  11 000e C3       	        ret
