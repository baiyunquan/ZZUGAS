GAS LISTING ./progs/eg0403.s 			page 1


   1              	#eg0403.s in Linux Console
   2              	# assembly]# ./nmake32.sh ./progs/eg0403 
   3              	
   4              	
   5              	        .intel_syntax noprefix
   6              	        
   7              	        .section .data
   8              	        
   9              	        .section .text
  10              	        .globl main
  11              	        main:
  12 0000 9C       	        pushf
  13 0001 58       	        pop rax
  14 0002 E8000000 	        call disphx
  14      00
  15              	        #返回值
  16 0007 31C0     	       xor eax,eax        #返回0
  17 0009 C3       	       ret
