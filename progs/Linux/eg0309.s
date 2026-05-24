# eg0309.s in Linux Terminal for GAS
        
        .intel_syntax noprefix
        
        .include "io32_linux.s"
        
       
        .section .data
         #数据定义

        qvar:	.quad 0x1234567887654321
        ascii:	.byte '3','8'
        bcd:	.byte 0



        .section .text

        .global _start
        _start:
        #主程序
        mov ecx,4 
again:	shr dword ptr qvar+4,1	#先移动高32位
        rcr dword ptr qvar,1	#后移动低32位
        loop again
        ;
        mov al,ascii
        and al,0x0f	#处理低4位对应的字符
        mov ah,ascii+1
        shl ah,4	#处理高4位对应的字符
        or al,ah	#组合形成压缩BCD码
        mov bcd,al

        call disphb
        call dispcrlf

        exit
        #子程序

