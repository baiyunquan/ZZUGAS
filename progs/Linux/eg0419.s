# eg0419.s in Linux Terminal for GAS
        
        .intel_syntax noprefix
        
        .include "io32_linux.s"
        
       
        .section .data
         #数据定义
array: .long 587,-632,777,234,-34		#假设一个数组
count	=(.-array)/4	#数组的元素个数


        .section .text

        .global _start
        _start:
        #主程序
    
   #显示原始数组
    mov ecx, count
    mov ebx, 0
    again1:mov eax, [array+ebx*4]
    call dispsid
    mov al,0x20
    call dispc
    inc ebx
    loop again1
    call dispcrlf

   #排序
    mov ecx,count	#ECX←数组元素个数
	dec ecx	#元素个数减1为外循环次数
outlp:	mov edx,ecx	#EDX←内循环次数
	mov ebx,offset array
inlp:	mov eax,[ebx]	#取前一个元素
    
	cmp eax,[ebx+4]	#与后一个元素比较
	jng next
	#前一个不大于后一个元素，则不进行交换
	xchg eax,[ebx+4]	#否则，进行交换
	mov [ebx],eax
next:	add ebx,4	#下一对元素
	dec edx
	jnz inlp	#内循环尾
	loop outlp	#外循环尾

    #输出排序后的结果
    mov ecx, count
    mov ebx, 0
    again2:mov eax, [array+ebx*4]
    call dispsid
    mov al,0x20
    call dispc
    inc ebx
    loop again2
call dispcrlf

        exit
        #子程序
