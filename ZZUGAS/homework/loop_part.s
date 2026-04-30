.intel_syntax noprefix

.data

.text
.globl main

main:
    mov rax,0xCCACB
    mov ecx,16
    mov bx,ax # bx = ax
next: 
    shr ax,1 # ax = ax >> 1
    rcr edx,1 
    shr bx,1 # bx = bx >> 1
    rcr edx,1
    loop next
    mov eax,edx

    # 共16位，右移16位后，ax , bx值为0

    xor eax,eax
    ret