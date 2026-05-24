#eg0419.S
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	buffer:	.ascii "The processor vendor ID is "
	        .space  12 , 0
            bufsize= .- buffer
            .asciz "\n"
    
	# 数据定义（数据待填）
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov eax,0
	cpuid	#执行处理器识别指令
	mov dword ptr buffer[rip+bufsize-12],ebx
	mov dword ptr buffer[rip+bufsize-8],edx
	mov dword ptr buffer[rip+bufsize-4],ecx
	lea rax,buffer[rip]	#显示信息
	call dispmsg

    mov eax,0
	ret                   # 程序正常执行结束
