# eg0000.s in Linux Terminal for GAS
        
        .intel_syntax noprefix
        
        .include "io32_linux.s"
        
       
        .section .data
         #数据定义

        .section .text

        .global _start
        _start:
        #主程序
        mov eax,888	#假设一个数据
	    add eax,1	#个数加1
	    rcr eax,1	#数据右移进行折半
	    call dispuid	#显示结果
        call dispcrlf
        exit
        #子程序
