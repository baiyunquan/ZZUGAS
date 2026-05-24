.section    .rodata
    .text
    .globl  dispc
    .type   dispc, @function
dispc:
    # Print the low byte in EAX as a single character to stdout.
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movb    %al, -1(%rbp)
    movl    $1, %eax
    movl    $1, %edi
    leaq    -1(%rbp), %rsi
    movl    $1, %edx
    syscall
    leave
    ret
    .size   dispc, .-dispc

    .globl  dprflags
    .type   dprflags, @function
dprflags:
.LFB0:
    pushfq
    popq    %rax

    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movq    %rax, -8(%rbp)         

    movl    -8(%rbp), %eax
    nop
    nop
    andl    $1, %eax
    testl   %eax, %eax
    je  .L2
    movq     $67, %rax             # 'C'
        call     dispc
    movq     $46, %rax             # 
        call     dispc
.L2:
    
    movl    -8(%rbp), %eax
    andl    $64, %eax              # 
    testl   %eax, %eax
    je  .L3
    movq     $90, %rax             # 'Z'
        call     dispc
    movq     $46, %rax
        call     dispc
.L3:

    movl    -8(%rbp), %eax
    andl    $128, %eax            
    testl   %eax, %eax
    je  .L4
    movq     $83, %rax             # 'S'
     call     dispc
    movq     $46, %rax
     call     dispc
.L4:

    movl    -8(%rbp), %eax
    andl    $2048, %eax            
    testl   %eax, %eax
    je  .L5
    movq     $79, %rax             # 'O'
    call     dispc
    movq     $46, %rax
    call     dispc
.L5:
    
    movl    -8(%rbp), %eax
    andl    $16, %eax              
    testl   %eax, %eax
    je  .L6
    movq     $65, %rax             # 'A'
    call     dispc
    movq     $46, %rax
    call     dispc
.L6:
    
    movl    -8(%rbp), %eax
    andl    $4, %eax               
    testl   %eax, %eax
    je  .L8
    movq     $80, %rax             # 'P'
    call     dispc
    movq     $46, %rax
    call     dispc
.L8:
    movq     $10, %rax             
    call     dispc
    leave                       
    ret
.LFE0:
    .size   dprflags, .-dprflags
    .globl  main
    .type   main, @function
main:
.LFB1:
    pushq   %rbp
    movq    %rsp, %rbp

    pushfq
    popq    %rax
    andq    $0xfffffffffffff72a, %rax
    orq     $0x91, %rax
    pushq   %rax
    popfq

    movl    $0, %eax
    call    dprflags
    movl    $0, %eax
    popq    %rbp
    ret
