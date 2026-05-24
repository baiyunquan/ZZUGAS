# eg0528s.s

.intel_syntax noprefix

.text
.global dprf #dprf声明为全局函数，可被其他模块调用
/*.global main
main:
 sub	rsp, 32 
 mov al, 0x80
 sub al, 1
 call dprf
 add rsp, 32
 mov eax, 0
 ret
 */
#子程序要在代码段中
dprf:
   pushf
   pop rax #rax=rflags
   sub rsp, 72 #建立栈帧
   
   mov 32[rsp],rax#保存标志寄存器
   mov dword ptr 40[rsp], 0x414C4652 #字符串"RFLAGS ="
   mov dword ptr 44[rsp], 0x3D205347
   
   lea rdi, 48[rsp] #eax对应的十六进制字符串首地址
   call hdtoasc # eax转换为十六进制形式字符串
   
   mov eax, 32[rsp] #恢复标志寄存器
   lea rsi, 56[rsp]
   
   test al, 1  #判断CF=1？
   jz L1    
   mov word ptr [rsi],0x4320 #CF=1
   add rsi, 2
   L1:
   test al, 4  #判断PF=1？
   jz L2    
   mov word ptr [rsi],0x5020 #PF=1
   add rsi, 2
   L2:
   test al, 0x40  #判断ZF=1？
   jz L3    
   mov word ptr [rsi],0x5a20 #ZF=1
   add rsi, 2
   L3:
   test al, 0x80  #判断SF=1？
   jz L4    
   mov word ptr [rsi],0x5320 #SF=1
   add rsi, 2
   L4:
   test ax, 0x800 #判断OF=1？
   jz L5    
   mov word ptr [rsi],0x4f20 #OF=1
   add rsi, 2
   L5:
   mov byte ptr [rsi],'\n' #字符串结束
   mov byte ptr [rsi+1],0 #字符串结束
   
   lea rcx,40[rsp] # 调用printf的入口参数
   call	printf
   
   add rsp,72 #释放栈帧
   ret

hdtoasc: # eax转换为十六进制形式字符串
	  xor rbx,rbx	#使用rbx相对寻址访问REGD字符串
	mov ecx,8	# 8位十六进制数
again:	rol eax,4	#高4位循环移位进入低4位，作为子程序的入口参数
	push rax	#子程序利用AL返回结果，所以需要保存EAX中的数据
	call htoasc	#调用子程序
	mov [rdi+rbx],al	#保存转换后的ASCII码
	pop rax	#恢复保存的数据
	inc rbx
	loop again
	ret

htoasc:	#将AL低4位表达的一位十六进制数转换为ASCII码
   	and al,0xf	#只取AL的低4位
	or al,0x30	#AL高4位变成3，实现加30H
	cmp al,0x39	#是0～9，还是A～F
	jbe htoend
	add al,7	#是A～F，其ASCII码再加上7
htoend: ret	#子程序返回 
