#eg0819m.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点
main:
	jmp L1
	msg: .ascii "No overflow !$"

L1:
	mov ax, cs          #将 .data 段地址存入 AX
	mov ds, ax          #  设置 DS = AX
	mov al, 0x20 	#设置AL初值位32
	add al,0x64
	jno noflow	#没有溢出，转移（可以删除）
	into		#有溢出，产生溢出中断
	jmp done		#可以删除
noflow:	mov dx, msg-main+0x100	#显示无溢出信息
	mov ah, 0x9
	int 0x21
done:
	mov ah, 0x4C 	# 执行结束
	int 0x21

