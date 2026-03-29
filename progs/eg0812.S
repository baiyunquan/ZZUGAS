/*eg0814.S*/
.intel_syntax noprefix

STD_INPUT_HANDLE = -10 /*标准输入句柄*/
STD_OUTPUT_HANDLE = -11 /*标准输出句柄*/
.section .text
.extern GetStdHandle  /* 声明外部函数（kernel32.dll）*/
.extern WriteConsoleA     /* 声明外部函数（kernel32.dll）*/
.extern ReadConsoleA     /* 声明外部函数（kernel32.dll）*/
.extern ExitProcess   /* 声明外部函数（kernel32.dll）*/
.global main
main:
	sub     rsp, 32         /* 影子空间(32字节) + 参数空间(8字节) + 对齐 */

	lea rax, [rip + msg1]	/*提示输入*/
	call dispmsg
	lea rax, [rip + nbuf]	/*输入信息*/
	call readmsg
	lea rax, [rip + msg2]
	call dispmsg
	lea rax, [rip + nbuf]	/*显示输入信息*/
	call dispmsg
	lea rax, [rip + msg3]
	call dispmsg

	 /* 调用ExitProcess */
	xor     rcx, rcx      /* uExitCode = 0 */
	call    ExitProcess
	add     rsp, 32         /* 恢复栈指针 */
	ret

dispmsg:	/*字符串显示子程序，入口参数：RAX＝字符串地址*/
	push rax
	push rbx
	push rcx
	push rdx
	push rax	/*保存入口参数，即字符串地址*/
	mov rcx, STD_OUTPUT_HANDLE
	call GetStdHandle/*获取标准输出句柄*/
	mov [rip+_outhandle],rax	/*句柄实例保存，以便后面使用*/
	pop rbx	/*从堆栈弹出字符串地址送RBX*/
	xor rcx,rcx	/*计算字符串长度*/
dispm1:	mov al,[rbx+rcx]
	test al,al
	jz dispm2
	inc rcx
	jmp dispm1
dispm2:	
	mov r8, rcx/*参数：字符串长度*/
	mov rcx,[rip+_outhandle]/*参数：输出句柄*/
	mov rdx,rbx/*参数：指向字符串的指针*/
	lea r9, [rsp + 28]/*参数：实际输出字符数量的指针*/
	push 0/*参数：保留，必须为0*/
	call WriteConsoleA
	add rsp,8/*释放参数空间*/
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

readmsg:	/*字符串输入子程序，入口参数：RAX＝缓冲区地址*/
	push rbx
	push rcx
	push rdx
	push rax	/*保护输入的缓冲区地址参数*/
	mov rcx, STD_INPUT_HANDLE
	call GetStdHandle/*获取标准输入句柄*/
	mov rcx,rax/*参数：输入句柄*/
	lea rdx, [rip+_inbuffer]/*参数：输入缓冲区指针*/
	mov r8, 255/*参数：可读取字符的最大数量*/
	lea r9, [rsp + 28]/*参数：保存实际读取字节数的指针*/
	push 0/*参数：保留，必须为0*/
	call ReadConsoleA
	add rsp,8/*释放参数空间*/
	xor rcx,rcx
	mov ecx, [rsp + 28]       /* 获取实际读取的字节数 (32位)*/
	mov qword ptr[rip+_insize], rcx
	sub qword ptr[rip+_insize], 2	/*实际输入的字符不包括回车和换行字符*/
	xor rcx,rcx
	pop rbx	/*获得缓冲区地址*/
readm1:	
	lea rdx,[rip+_inbuffer]
	mov al,[rcx+rdx]
	mov [rbx+rcx],al	/*将输入的字符串复制到用户缓冲区*/
	inc rcx
	cmp rcx,[rip+_insize]
	jb readm1
	mov byte ptr[rbx+rcx],0	/*最后填入结尾字符0*/
	mov rax,rcx	/*返回实际的字符个数，不含结尾标志0*/
	pop rdx
	pop rcx
	pop rbx
	ret

.section .data
	msg1:	.asciz "Please enter your name: "
	msg2:	.asciz "Welcome "
	nbuf:	.space 80
	msg3:	.asciz " to Win32 Console!"
	_outsize:	.quad 0
	_outhandle:	.quad 0
	_insize:	.quad 0
	_inbuffer:	.space 255/*设置输入缓冲区最大255个字符*/	
