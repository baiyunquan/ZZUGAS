#宏定义
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用

.macro  rfbit  bit1, bit2
	xor ebx,ebx	    # EBX清0，用于保存字符
	rol eax,\bit1	# 将某个标志左移bit1位，进入当前CF
	adc ebx,0x30	# 转换为ASCII字符
	mov rfmsg[rip+\bit2],bl	# 保存于字符串bit2位置
	.endm

	.data
rfmsg:	.asciz "OF=0, SF=0, ZF=0, AF=0, PF=0, CF=0   \n" #初始化
	.text
	.globl main
main:		# 程序执行起始位置
    sub rsp, 40
	mov al,50
	sub al,80	#假设一个运算
	pushfq	#将标志位寄存器的内容（保护上条指令影响的状态标志）压入堆栈
	pop rax	#将标志位寄存器的内容存入RAX
    
	rfbit 21,3	#显示OF（原来的OF需左移21位，进入当前CF）
	rfbit 4,9	#显示SF（原来的SF再左移4位，进入当前CF）
	rfbit 1,15	#显示ZF（原来的ZF再左移1位，进入当前CF）
	rfbit 2,21	#显示AF（原来的AF再左移2位，进入当前CF）
	rfbit 2,27	#显示PF（原来的PF再左移2位，进入当前CF）
	rfbit 2,33	#显示CF（原来的CF再左移2位，进入当前CF）
	lea rax,rfmsg[rip]
	call dispmsg
    mov eax,0
    add rsp, 40
	ret                   # 程序正常执行结束