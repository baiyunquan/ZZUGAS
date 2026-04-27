    .data

	.text
	.globl main
main:
    subq $40, %rsp
    movl $1, %eax
    call dispuid
    call dispcrlf
    movl $1, %eax
    call dispuid
    call dispcrlf
    movl $1, %eax
    movl $1, %ebx
    movl $45, %ecx

Fib:
    addl %ebx, %eax
    push %rcx
    push %rbx
    push %rax
    call dispuid
    call dispcrlf
    pop %rax
    pop %rbx
    pop %rcx
    xchgl %eax, %ebx
    loop Fib 
    
Done:
    addq $40, %rsp
    xorl %eax, %eax
    ret
