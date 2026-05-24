.intel_syntax noprefix
.text 
.global strcpya # 子程序 
//.type strcpya, %function 
strcpya: 
#入口参数rdx=源串地址，rcx=目的串地址，字符串以0结尾
push rbx
mov rbx,0
again:
mov al,  [rdx+rbx] # 载入源字符串一个字符，并指向下一个字符 
cmp al, 0
jz L2 # al=0,字符串结束，退出

mov [rcx+rbx], al # 存入目的字符串，并指向下一个位置
inc rbx
jmp again # 不是 0（结尾），继续复制 

L2:
mov [rcx+rbx],byte ptr 0
pop rbx
ret
