#eg0816.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点
main:
	jmp L1
	msg: .ascii "No divide overflow !$"

L1:
	mov ax, cs          #将 .data 段地址存入 AX
	mov ds, ax          #  设置 DS = AX
	mov ax, 0x10 	#被除数设为16
	mov bl, 0x1
	div bl		#没有溢出
	mov dx, msg-main+0x100 	#指定字符串的偏移地址
	mov ah,0x9	#显示字符串
	int 0x21

	mov ax, 0x100 	#被除数设为256
	mov bl, 0x1
	div bl		#产生溢出

	mov ah, 0x4C 	# 执行结束
	int 0x21


