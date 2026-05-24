.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	string: .ascii "This is    a test"
	        .byte 0
	        
	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	      lea rax, string[rip]
	      call dispmsg
	      call dispcrlf
	      
	       lea rsi,string[rip]
   outlp:  cmp byte ptr[rsi],0
           #外循环，先判断后循环
           jz done  #为0结束
   again:  cmp byte ptr [rsi],' '   	#是否是空格
	       jnz next			#不是空格继续循环
	       mov rdi,rsi		#是空格，剔除分支
    inlp:  inc rdi			#该分支是循环程序
	       mov al,[rdi]		#前移一个位置
	       mov -1[rdi],al
           cmp byte ptr [rdi],0
           #内循环，先循环后判断
           jnz inlp	#内循环结束处
           jmp again
           #再次判断是否为空格（处理连续空格）
     next: inc rsi
	       #继续对后续字符进行判断处理
	       jmp outlp	#外循环结束处
	       
done:	   lea rax, string[rip]
	       call dispmsg 
	       

      mov eax,0
	  ret                   # 程序正常执行结束
	