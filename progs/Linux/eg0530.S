.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
.macro absol oprd
	cmp  \oprd,0
	jge 1f
	neg  \oprd
1:
	.endm	#这个伪指令要独占一行

	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov al,0x80
	absol al
	mov al,0x8
	absol al
    mov eax,0
	ret                   # 程序正常执行结束
