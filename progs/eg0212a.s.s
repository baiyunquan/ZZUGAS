.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	var:	.long 0x92345678
	# 数据定义（数据待填）
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov eax,var[rip]
	call disphd	#十六进制形式显示：92345678
	call dispcrlf	#回车换行（用于分隔）
	mov eax,var[rip]
	call dispuid	#十进制形式显示无符号数：2452903544
	call dispcrlf	#回车换行（用于分隔）
	mov eax,var[rip]
	call dispsid	#十进制形式显示有符号数：-1842063752
	call dispcrlf	#回车换行（用于分隔）
	mov al,byte ptr var[rip]
	call dispc	#字符显示：x

    mov eax,0
	ret                   # 程序正常执行结束
