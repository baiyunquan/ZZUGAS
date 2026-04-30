#eg0512.s
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	N: .long 0
	error: .ascii "overflower\n"
	      .byte 0
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	mov eax, 1
	mov ecx, N[rip]	
      cmp ecx, 0
      jz L1
again:	imul eax, ecx
	cmp eax,0
	js L1
	loop again
    call dispsid
    jmp L2
  L1: lea rax, error[rip]  
  call dispmsg
 L2:   mov eax,0
	ret                   # 程序正常执行结束
	

