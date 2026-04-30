/* eg0533.s */
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
#宏定义
.macro maxnum dvar1,dvar2,dvar3
	    mov eax,\dvar1
	    cmp eax,\dvar2
	    jge 1f
	    mov eax,\dvar2
	1:
	   .ifnb \dvar3	#当有DVAR3实参时，汇编如下语句
	     cmp eax,\dvar3
	     jge 2f
	     mov eax,\dvar3
	   .endif
     2:
	    .endm
	
	.text #代码段
	.globl main
main:	
    maxnum 3,5
	call disphd
	maxnum 3,5,7
	call disphd
	
	mov eax, 0
	ret
	
