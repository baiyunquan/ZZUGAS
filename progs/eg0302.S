/*eg0302.S*/
.intel_syntax noprefix
.data
.text
 .globl main
main:		# 程序执行起始位置
mov bx, 100 /*将0x64赋值到al寄存器*/
mov ax, bx/*将bx的值复制到ax*/
call disphw
call dispcrlf

mov dl,al/*将al的值复制到dl*/
mov al, dl
call disphb
call dispcrlf

mov rcx, 300
mov ch, cl/*将cl的值复制到ch*/
mov al, ch
call disphb
call dispcrlf

mov edx, -100
mov esi, edx /*将edx的值复制到esi*/
mov eax, esi
call disphd
call dispcrlf

mov r8, 12345
mov rax, r8/*将r8的值复制到rax*/
call disphx
call dispcrlf

mov eax,0
ret
