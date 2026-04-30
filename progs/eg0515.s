# eg0515.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	str: .byte  0,0,-1,0,0,0,39,67,9,10
	.equ count, .- str
	msg: .ascii " not found!\n\0"

	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	lea rbx,str[rip]
	mov ecx,count			#计算器ecx清零
	mov eax, -1  #rdx记录下标   
	
	again: inc eax
	movsx rax, eax               #可以省略 
	cmp  byte ptr [rbx+rax], 0			#是否为0
	loopz   again	      	#ZF=1,即是0则继续比较
	
	jecxz  nofound 	      	#循环结束，如果ecx=0, 表示没有找到,等同于jz
	
	
	call dispsid #显示下标
	jmp  done
	nofound:
	lea rax, msg[rip]
	call dispmsg	#显示not found
	done:    
      mov eax,0
	  ret                   # 程序正常执行结束
	