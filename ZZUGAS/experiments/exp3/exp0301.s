.intel_syntax noprefix

.data
x:    .long 0x12345678, 0x9ABCDEF0, 0x3456789A
msg:  .ascii "effect address of x = "
y:    .ascii "12345"
.equ  len, .-x

.text
.globl main
.type  main, @function

main:

    mov rcx, len
    mov rax, -100

    mov bx, ax
    mov bl, al
    mov ah, al
    mov esi, eax

    mov eax, x[rip]
    mov eax, y[rip]
    mov rax, x[rip+4]
    mov rax, msg[rip]

    lea rax, x[rip]

    mov bl, [rax]
    mov bx, [rax]
    mov ebx, [rax]
    mov rbx, QWORD ptr [rax]

    mov bl, [rax+1]
    mov bx, [rax+2]
    mov ebx, [rax+4]
    mov rbx, [rax+8]

    mov rbx, 16

    mov ebx, [rax+rbx]
    mov ebx, [rax+rbx+2]
    mov ebx, [rax+rbx+4]

    mov eax, [rax+rbx*4]
    mov eax, [rax+rbx*4+32]

    mov eax, 0
    ret
    