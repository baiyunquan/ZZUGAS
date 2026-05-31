.intel_syntax noprefix

.data
msg1: .asciz "Enter 10 numbers:\n"
msg2: .asciz "The mean is:"

.text
.globl main
.extern printf
.extern read10sid
.extern mean_sid32
.extern write_sid

main:
    push ebp
    mov ebp, esp
    sub esp, 48

    lea eax, [msg1]
    push eax
    call printf
    add esp, 4

    lea eax, [ebp-40]
    push 10
    push eax
    call read10sid
    add esp, 8

    lea eax, [ebp-40]
    push 10
    push eax
    call mean_sid32
    add esp, 8

    mov [ebp-44], eax

    lea eax, [msg2]
    push eax
    call printf
    add esp, 4

    mov eax, [ebp-44]
    push eax
    call write_sid
    add esp, 4

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
