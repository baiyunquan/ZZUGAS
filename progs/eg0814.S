#eg0814.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

.text
.globl main           # 入口点
main:
	
	mov ax, cs          #将 .data 段地址存入 AX
	mov ds, ax          #  设置 DS = AX
	mov al,0x09	#AL＝9（准备从9号单元获取年代数据）
	out 0x70,al	#从70H的I/O地址输出，选择CMOS RAM的9号单元
	in al,0x71	#从71H的I/O地址输入，获取9号单元的内容，保存在AL
	call dispal	#显示AL内容，即年代
	mov dl,'-'	#显示分隔符“－”
	mov ah,0x02
	int 0x21

	mov al,0x08	#AL＝8（从8号单元获取月份数据）
	out 0x70,al
	in al,0x71
	call dispal	#显示月份
	mov dl,'-'	#显示分隔符“－”
	mov ah,0x02
	int 0x21

	mov al,0x07	#AL＝7（从7号单元获取日期数据）
	out 0x70,al
	in al,0x71
	call dispal	

	mov ah, 0x4C # 执行结束
	int 0x21

dispal:
	push ax
	push cx
	mov cx,0x02	#两位十六进制数
dispal1:	rol al,0x4		#高4位循环移位到低4位
	push ax
	and al,0x0f	#取低4位
	or al,0x30		#得到ASCII码
	mov ah,0x02	#显示一位数
	mov dl,al
	int 0x21
	pop ax
	loop dispal1
	pop cx
	pop ax
	ret

