    .data

	.text
	.globl printEAX
printEAX:
    # Save the current value of EAX to a local variable
    movl %eax, %ebx
    movl $4, %ecx

    # Print EAX in binary format
print_loop:
    movl %ebx, %eax
    andl $0xFF000000, %eax
    shrl $24, %eax
    shll $8, %ebx
    push %rcx
    push %rbx
    call dispbb
    pop %rbx
    pop %rcx
    loop print_loop

    xorl %eax, %eax
    ret
