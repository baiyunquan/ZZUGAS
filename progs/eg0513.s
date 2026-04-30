# eg0513.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	array:	.long -3,0,20,900,587,-632,777,234,-34,-56		#假设一个数组
    .equ count, (. - array)/4	#数组的元素个数
    max:	    .space  4   	#存放最大值

	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov ecx, count-1	#元素个数减1是循环次数
	lea rsi, array[rip]
	mov eax,[rsi]	#取出第一个元素给EAX，用于暂存最大值
again:	add rsi,4
	cmp eax,[rsi]	#与下一个数据比较
	jge next	#已经是较大值，继续下一个循环比较
	mov eax,[rsi]	#EAX取得更大的数据
next:	loop again	#计数循环
	mov max[rip],eax	#保存最大值
    call dispsid
    
      mov eax,0
	ret                   # 程序正常执行结束
	
