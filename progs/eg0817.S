#eg0817.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点
main:
	jmp L1
	intoff:	.word 0
	intseg:	.word 0
	intmsg: 	.ascii "A Instruction Interrupt !"
		.byte 0

L1:
	mov ax, cs          #将 .data 段地址存入 AX
	mov ds, ax          #  设置 DS = AX
	mov bx,0x0
	mov es,bx	#设置附加段ES＝0，指向物理地址低端
	mov bx,0x80	#BL＝AL＝N＝0x80
	shl bx,0x1
	shl bx,0x1	#BX＝N×4
	mov ax,es:[bx]	#获取中断服务程序的偏移地址
	mov [intoff-main+0x100],ax
	mov ax,es:[bx+0x2]	#获取中断服务程序的段基地址
	mov [intseg-main+0x100],ax
	#设置本程序的80H中断服务程序地址
	mov ax, new80h-main+0x100
	mov es:[bx],ax	#设置偏移地址
	mov ax,cs
	mov es:[bx+0x2],ax	#设置段基地址
	#中断调用
	mov dx, intmsg-main+0x100	#设置入口参数DS和DX
	int 0x80	#调用0x80中断服务程序，显示字符串
	#恢复系统的原0x80中断服务程序地址
	mov ax,[intoff-main+0x100]
	mov es:[bx],ax	#恢复偏移地址
	mov ax,[intseg-main+0x100]
	mov es:[bx+0x2],ax	#恢复段基地址
	mov ax,0x4c00
	int 0x21
	#0x80内部中断服务程序：显示字符串（以0结尾）；DS∶DX＝缓冲区首地址
new80h:
	sti	#开中断
	push ax	#保护寄存器
	push bx
	push si
	mov si,dx
new1:	mov al,[si]	#获取欲显示字符
	cmp al,0x0	#为“0”结束
	jz new2
	mov bx,0x0	#采用ROM-BIOS调用显示一个字符
	mov ah,0x0e
	int 0x10
	inc si	#显示下一个字符
	jmp new1
new2:	pop si	#恢复寄存器
	pop bx
	pop ax
	iret	#中断返回


	
