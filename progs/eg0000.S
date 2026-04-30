/* AS汇编语言基本框架 */
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	……	# 数据定义（数据待填）
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	……	#主程序（指令待填）
        
	ret                   # 程序正常执行结束
	……	#子程序（指令待填）



	
