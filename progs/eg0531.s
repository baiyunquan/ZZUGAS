.intel_syntax noprefix  #采用Intel语法，面向X86处理器时使用
#宏定义
.macro dreg32 reg32
	push rdx  #保护寄存器
	push rcx
	push rbx
	push rax
	mov eax,\reg32	#显示reg32寄存器
	mov ecx,8 
	xor ebx,ebx
1:	rol eax,4
	mov edx,eax
	and dl,0xf
	add dl,0x30	#转化为相应的ASCII码值
	cmp dl,0x39	#区别0～9和A～F数码
	jbe 2f                  #前向引用
	add dl,7
2:	lea r9,rd\reg32[rip]
    mov [r9+rbx+4],dl	#存于对应的字符串
	inc rbx
	cmp ebx,ecx
	jb 1b                   #向后引用
	pop rax     #保护寄存器
	pop rbx  
	pop rcx
	pop rdx
	.endm
	.data
rdeax:	.ascii "EAX=00000000, "
rdebx:	.ascii "EBX=00000000, "
rdecx:	.ascii "ECX=00000000, "
rdedx:	.asciz "EDX=00000000\n"

	.text
	.global main
main:
	mov eax,0x12345678	#假设一些数据
	mov ebx,0x0abcdef00
	mov ecx,eax
	mov edx,ebx
	
	dreg32 eax	#显示EAX
	dreg32 ebx	#显示EBX
	dreg32 ecx	#显示ECX
	dreg32 edx	#显示EDX
	
	lea rax, rdeax[rip]
	call dispmsg
	
	mov eax, 0
	ret
	

