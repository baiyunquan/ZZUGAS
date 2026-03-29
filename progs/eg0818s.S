#eg0819s.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点
main:
	jmp L1
	intmsg: .ascii "Overflow !"
		.byte 0
	tsrmsg: .ascii "INT 04H Program Installed !$"

L1:
	mov ax, cs          #将 .data 段地址存入 AX
	mov ds, ax          #  设置 DS = AX
	#设置04H中断服务程序地址
 	mov bx,0x0
	mov es,bx		#设置附加段ES＝0，指向物理地址低端
	mov ax, new04h-main+0x100 
	mov es:[4*4],ax	#设置偏移地址
	mov ax,cs
	mov es:[4*4+2],ax	#设置段基地址
	# 显示安装信息
	mov ah,0x9
	mov dx, tsrmsg-main+0x100
	int 0x21
	#计算驻留内存程序的长度
	mov dx, end_tsr-main+0x100
	add dx,0x100	#增加256个字节（程序段前缀空间）
	add dx,0x0F
	mov cl,0x4
	shr dx,cl		#调整为以“节”（16个字节）为单位
	mov ax,0x3100	#程序驻留，返回DOS	
	int 0x21

new04h:			#中断服务程序
	sti
	push ax		#保存寄存器
	push bx
	push si
	push ds
	mov ax,cs		#数据在代码段中，故DS＝CS
	mov ds,ax
	mov si, intmsg-main+0x100	#溢出提示信息首地址
dps1:	mov al,[si]
	cmp al,0x0
	jz dps2
	mov bx,0x0	#调用ROM-BIOS功能显示AL中的字符
	mov ah,0x0e
	int 0x10
	inc si
	jmp dps1
dps2:	pop ds		#恢复寄存器
	pop si
	pop bx
	pop ax
	iret		#中断返回

end_tsr:                # 驻留程序结束标记（用于计算驻留大小）
