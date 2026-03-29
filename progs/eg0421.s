/* eg0421.s */
.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
	.data	#定义数据段
	msg:.byte 0,0,0
	table: .ascii "0123456789ABCDEF"

	.text	#定义代码段
        .globl main
main:		# 程序执行起始位置
	lea rbx, table[rip]
	
	mov al, 100
    mov ah,al
     
    and al, 0xf0
    shr al,4
    movzx rcx, al
    mov al, [rbx+rcx]
    mov msg[rip],al
    
    mov al, ah
    and al, 0xf
    movzx rcx, al
    mov al, [rbx+rcx]
    mov msg[rip+1],al
	
	lea rax, msg[rip]
	call dispmsg
	
    mov eax,0
	ret                   # 程序正常执行结束
	
