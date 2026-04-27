/*eg0301.S*/
.intel_syntax noprefix
.data
.text
 .globl main
main:		# 程序执行起始位置
mov al, 100 /*将0x64赋值到al寄存器*/
call disphb
call dispcrlf
mov ax,  100 /*将0x0064赋值到ax寄存器*/
call disphw
call dispcrlf
mov eax, 100 /*将0x00000064赋值到eax寄存器*/
call disphd
call dispcrlf
mov rax, 100 /*将0x0000000000000064赋值到rax寄存器*/
call disphx
call dispcrlf
mov rax, 0x123456789abcdef1 /*将0x0000000000000064赋值到rax寄存器*/
call disphx
call dispcrlf



mov eax,0
ret

