/* eg0413.s in Windows Terminal for GCC_64*/
        .intel_syntax noprefix
        
        .section .data
        x: .long 0x80000000 #0x0fffe1234
      	y: .long 0x7FFFFFFF#001e1234
       	result: .quad 0

       
        .section .text
        .globl main
        main:
        mov eax,x[rip]			#eax<-x,eax=fffeh
        #mul dword ptr y[rip] 			#乘法：eax*y，edx.eax=0x0000001E11F95A90
        #imul dword ptr y[rip] 			#乘法：eax*y，edx.eax=0x0000FFFFFFC55A90
        imul eax,y[rip] #eax=FEFB5A90
        pushf
        call disphd
        pop rax
        call disprf
        
        #mov dword ptr result[rip] , eax		#存放乘积的低双字部分
        #mov dword ptr result[rip+2],edx		#存放乘积的高双字部分

        #mov rax, result[rip]
        #call disphx
        
        
        #返回值
       xor eax,eax        #返回0
       ret