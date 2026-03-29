/* eg0534.s */
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
#宏定义
	.altmacro   # 启用替代宏语法
.macro  printf	format,var

	mov eax,\var[rip]
	.ifc "\format","b"
	call disphd	#二进制显示用格式符“b”
	.endif

	.ifc "format","x"
	call disphd	#十六进制显示用格式符“x”
	.endif
	.ifc "\format","d"
	call dispsid	#十进制显示用格式符“d”
	.endif
	.ifc "\format","c"
	call dispc	#字符显示用格式符“c”
	.endif
	.endm
	
	.data #数据段
var: .byte 0b01100100
	.text #代码段
	.global main
	main:
	printf b,var	#二进制形式显示：01100100
	call dispcrlf	#回车换行（用于分隔）
	printf x,var	#十六进制形式显示：64
	call dispcrlf	#回车换行（用于分隔）
	printf d,var	#十进制形式显示：100
	call dispcrlf	#回车换行（用于分隔）
	printf c,var	#字符显示：d
	mov eax, 0
	ret
	
