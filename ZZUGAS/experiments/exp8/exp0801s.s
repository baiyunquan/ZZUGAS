.intel_syntax noprefix

.data
input_fmt: .asciz "%d"
output_fmt: .asciz "%s"
writebuf: .space 16

.text
.globl read10sid
.globl mean_sid32
.globl write_sid
.extern scanf
.extern printf

# read10sid(int *array, int count)
read10sid:
    push ebp
    mov ebp, esp
    push ebx
    push esi

    mov esi, [ebp+8]
    mov ebx, [ebp+12]

.L_read_loop:
    lea eax, [input_fmt]
    push esi
    push eax
    call scanf
    add esp, 8
    add esi, 4
    dec ebx
    jnz .L_read_loop

    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

# mean_sid32(int *array, int count) -> EAX
mean_sid32:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    xor eax, eax
    xor edx, edx

.L_mean_loop:
    mov ebx, [esi]
    mov edi, ebx
    sar edi, 31
    add eax, ebx
    adc edx, edi
    add esi, 4
    dec ecx
    jnz .L_mean_loop

    mov ecx, [ebp+12]
    idiv ecx

    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

# write_sid(int value)
write_sid:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov eax, [ebp+8]
    lea edi, [writebuf]
    test eax, eax
    jnz .L_write_nonzero

    mov byte ptr [edi], '0'
    inc edi
    jmp .L_write_finish

.L_write_nonzero:
    jns .L_write_positive
    mov byte ptr [edi], '-'
    inc edi
    neg eax

.L_write_positive:
    mov ebx, 10
    push ebx

.L_write_digits:
    test eax, eax
    jz .L_write_pop
    xor edx, edx
    div ebx
    add edx, '0'
    push edx
    jmp .L_write_digits

.L_write_pop:
    pop edx
    cmp edx, ebx
    je .L_write_finish
    mov byte ptr [edi], dl
    inc edi
    jmp .L_write_pop

.L_write_finish:
    mov byte ptr [edi], 0
    lea eax, [writebuf]
    push eax
    lea eax, [output_fmt]
    push eax
    call printf
    add esp, 8

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
