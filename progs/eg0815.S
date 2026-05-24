#eg0815.S
.code16                 # 16位代码
.intel_syntax noprefix  # 使用 Intel 语法

 .text
start:
jmp L1

freq:	.word 1989	#600Hz频率对应的计数值：1193180/600≈1989
L1:	mov ax,cs
	mov ds,ax
	mov ax,[freq]
	call speaker	#设置扬声器的音调
	call speakon	#打开扬声器声音
	mov ah,1	#等待按键
	int 0x21 
	call speakoff	#关闭扬声器声音

	mov ax,0x4c00	#执行结束
	int 0x21
speakon:	#扬声器开子程序
	push ax
	in al,0x61	#读取61H端口的原控制信息
	or al,0x03	#D1D0＝PB1PB0＝11，其他位不变
	out 0x61,al	#直接控制发声
	pop ax
	ret

	
speakoff:		#扬声器关子程序
	push ax
	in al,0x61
	and al,0x0fc	#D1D0＝PB1PB0＝00，其他位不变 
	out 0x61,al	#直接控制闭音
	pop ax
	ret

speaker:	
	push ax	#暂存入口参数以免被破坏
	mov al,0x0b6	#方式控制字：定时器2为方式3，先低后高写入16位计数值
	out 0x43,al	#输出到控制端口
	pop ax	#恢复入口参数
	out 0x42,al	#写入低8位计数值
	mov al,ah
	out 0x42,al	#写入高8位计数值
	ret



