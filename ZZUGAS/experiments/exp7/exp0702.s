/* exp0702.s */
.intel_syntax noprefix

.data
msg: .ascii "This is a test!"

.text
.globl main

main:
	# 取字符串地址到 EAX，字节个数到 ECX，调用 DISPMEM
	lea rax, msg[rip]
	mov ecx, 15
	call DISPMEM

	xor eax, eax
	ret


# 子程序 DISPMEM
# 入口参数：EAX=主存偏移地址，ECX=字节个数
# 出口参数：无
# 功能：从低地址到高地址逐个字节显示主存区域内容（十六进制）
DISPMEM:
	push r12			# 保存非易失寄存器
	push rbx
	push rax

	mov rbx, rax		# RBX ← 内存起始地址
	mov r12d, ecx		# R12D ← 字节个数（R12 为非易失寄存器）

.Lloop:
	mov al, [rbx]		# AL ← 当前字节
	call disphb		# 显示该字节的十六进制形式

	dec r12d		# 字节个数减1
	jz .Ldone		# 若为0，结束

	mov al, ' '		# 显示空格分隔
	call dispc

	inc rbx			# 指向下一字节
	jmp .Lloop

.Ldone:
	call dispcrlf		# 换行

	pop rax
	pop rbx
	pop r12
	ret
