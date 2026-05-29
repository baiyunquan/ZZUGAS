.data
msg1: .string "Enter 10 numbers:\n"
msg2: .string "The mean is:"

	.text
	.globl main
main:
    # init, malloc stack for ten num
    subl $40, %esp
    movl $9, %ecx

    leaq msg1(%rip) , %rax
    call dispmsg

InputNums:
    push %rcx
    call readsid
    pop  %rcx
    nop
    movl %eax , 0(%esp , %ecx , 4)
    decl %ecx             
    cmpl $0, %ecx 
    jge InputNums

    # reload ecx, reset eax
    leaq msg2(%rip) , %rax
    call dispmsg
    movl $9, %ecx
    xorl %eax, %eax

SumNums:
    addl 0(%esp , %ecx , 4) , %eax
    decl %ecx             
    cmpl $0, %ecx 
    jge SumNums

# AVG calculate and display
    movl $10 , %ebx
    xorl %edx , %edx
    cltd
    idivl %ebx
    call dispuid

# restore stack
    addl $40, %esp
	xorl %eax, %eax
	ret
