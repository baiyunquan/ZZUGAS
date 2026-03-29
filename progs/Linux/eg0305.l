GAS LISTING ./progs/eg0305.s 			page 1


   1              	/* eg0305.S*/
   2              	.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
   3              		.data	#定义数据段
   4 0000 78563412 	    x: .long 0x12345678,0x9ABCDEF0
   4      F0DEBC9A 
   5              	   
   6              		.text	#定义代码段
   7              	        .globl main
   8              	main:		# 程序执行起始位置
   9 0000 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
   9      000000
  10 0007 8A5801   	    mov bl, [rax+1] /*有效地址=rax，将x的字节值复制到bl*/
  11 000a 88D8     	    mov al, bl
  12 000c E8000000 	    call disphb
  12      00
  13 0011 E8000000 	    call dispcrlf
  13      00
  14              	    
  15 0016 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  15      000000
  16 001d 668B5802 	    mov bx, [rax+2] /*有效地址=rax，将x的字值复制到bx */
  17 0021 6689D8   	    mov ax, bx
  18 0024 E8000000 	    call disphw
  18      00
  19 0029 E8000000 	    call dispcrlf
  19      00
  20              	    
  21 002e 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  21      000000
  22 0035 8B5804   	    mov ebx,[rax+4] /*有效地址=rax，将x的双字值复制到ebx */
  23 0038 89D8     	    mov eax, ebx
  24 003a E8000000 	    call disphd
  24      00
  25 003f E8000000 	    call dispcrlf
  25      00
  26              	    
  27 0044 488D0500 	    lea rax,x[rip] /*x地址复制到rax*/
  27      000000
  28 004b 488B5804 	    mov rbx,[rax+4] /*有效地址=rax，将x的四字值复制到rax */
  29 004f 4889D8   	    mov rax, rbx
  30 0052 E8000000 	    call disphx
  30      00
  31 0057 E8000000 	    call dispcrlf
  31      00
  32              	
  33              	    #主程序（指令待填）
  34 005c B8000000 	    mov eax,0
  34      00
  35 0061 C3       		ret                   # 程序正常执行结束
