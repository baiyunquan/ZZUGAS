GAS LISTING ./progs/eg0301.s 			page 1


   1              	/*eg0301.S*/
   2              	.intel_syntax noprefix
   3              	.data
   4              	.text
   5              	 .globl main
   6              	main:		# 程序执行起始位置
   7 0000 B064     	mov al, 100 /*将0x64赋值到al寄存器*/
   8 0002 E8000000 	call disphb
   8      00
   9 0007 E8000000 	call dispcrlf
   9      00
  10 000c 66B86400 	mov ax,  100 /*将0x0064赋值到ax寄存器*/
  11 0010 E8000000 	call disphw
  11      00
  12 0015 E8000000 	call dispcrlf
  12      00
  13 001a B8640000 	mov eax, 100 /*将0x00000064赋值到eax寄存器*/
  13      00
  14 001f E8000000 	call disphd
  14      00
  15 0024 E8000000 	call dispcrlf
  15      00
  16 0029 48C7C064 	mov rax, 100 /*将0x0000000000000064赋值到rax寄存器*/
  16      000000
  17 0030 E8000000 	call disphx
  17      00
  18 0035 E8000000 	call dispcrlf
  18      00
  19              	
  20              	
  21 003a B8000000 	mov eax,0
  21      00
  22 003f C3       	ret
  23              	
