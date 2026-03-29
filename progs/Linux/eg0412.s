# eg0412.s in Linux Terminal for GAS
        
        .intel_syntax noprefix
        
        .include "io32_linux.s"
        
       
        .section .data
         #数据定义
dvar1:  .long 1234567890	#假设两个数据
dvar2:  .long -999999999
dvar3:  .long 0
okmsg:   .asciz "Correct!\n"	#正确信息
errmsg:  .asciz  "ERROR ! Overflow!\n"	#错误信息
        .section .text

        .global _start
        _start:
        #主程序
mov eax,dvar1 
	sub eax,dvar2	#求差
	jo error	#有溢出，转移
	mov dvar3,eax	#无溢出，保存差值
	mov eax,offset okmsg	#显示正确
	jmp disp
error:	mov eax,offset errmsg	#显示错误
disp:	call dispmsg

        exit
        #子程序
