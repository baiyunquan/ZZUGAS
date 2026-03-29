GAS LISTING ./progs/eg0302.s 			page 1


   1              	/*eg0302.S*/
   2              	.intel_syntax noprefix
   3              	.data
   4              	.text
   5              	 .globl main
   6              	main:		# 程序执行起始位置
   7 0000 66BB6400 	mov bx, 100 /*将0x64赋值到al寄存器*/
   8 0004 6689D8   	mov ax, bx/*将bx的值复制到ax*/
   9 0007 E8000000 	call disphw
   9      00
  10 000c E8000000 	call dispcrlf
  10      00
  11              	
  12 0011 88C2     	mov dl,al/*将al的值复制到dl*/
  13 0013 88D0     	mov al, dl
  14 0015 E8000000 	call disphb
  14      00
  15 001a E8000000 	call dispcrlf
  15      00
  16              	
  17 001f 48C7C12C 	mov rcx, 300
  17      010000
  18 0026 88CD     	mov ch, cl/*将cl的值复制到ch*/
  19 0028 88E8     	mov al, ch
  20 002a E8000000 	call disphb
  20      00
  21 002f E8000000 	call dispcrlf
  21      00
  22              	
  23 0034 BA9CFFFF 	mov edx, -100
  23      FF
  24 0039 89D6     	mov esi, edx /*将edx的值复制到esi*/
  25 003b 89F0     	mov eax, esi
  26 003d E8000000 	call disphd
  26      00
  27 0042 E8000000 	call dispcrlf
  27      00
  28              	
  29 0047 49C7C039 	mov r8, 12345
  29      300000
  30 004e 4C89C0   	mov rax, r8/*将r8的值复制到rax*/
  31 0051 E8000000 	call disphx
  31      00
  32 0056 E8000000 	call dispcrlf
  32      00
  33              	
  34 005b B8000000 	mov eax,0
  34      00
  35 0060 C3       	ret
