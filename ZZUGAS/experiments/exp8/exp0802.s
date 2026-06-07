.intel_syntax noprefix

.section .text

.macro LOGICAL OP, A, B
    .ifc \OP, AND
        push rbx            
        mov eax, \A         
        mov ebx, \B
        and eax, ebx
        pop rbx
    .else
    .ifc \OP, OR
        push rbx
        mov eax, \A
        mov ebx, \B
        or eax, ebx
        pop rbx
    .else
    .ifc \OP, XOR
        push rbx
        mov eax, \A
        mov ebx, \B
        xor eax, ebx
        pop rbx
    .else
    .ifc \OP, TEST
        push rbx
        mov eax, \A
        mov ebx, \B
        test eax, ebx
        pop rbx
    .else
        .error "Invalid logical operation"
    .endif
    .endif
    .endif
    .endif
.endm

.macro LOGICAL_NOT A
    push rbx
    mov eax, \A
    not eax
    pop rbx
.endm

.globl main
main:
    LOGICAL AND, 0xFF, 0x0F
    call dispuid
    mov eax, 10
    call dispc
    LOGICAL OR,  0xF0, 0x0F
    call dispuid
    mov eax, 10
    call dispc
    LOGICAL XOR, 0xFF, 0x0F
    call dispuid
    mov eax, 10
    call dispc
    LOGICAL TEST, 0xFF, 0x0F
    call dispuid
    mov eax, 10
    call dispc
    LOGICAL_NOT 0
    call dispsid
    mov eax, 10
    call dispc

    mov eax, 0
    ret
