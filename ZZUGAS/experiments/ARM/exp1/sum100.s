.arch armv8-a
.section .rodata
fmt:
    .string "sum(1..100) = %ld\n"

.text
.align 2
.global main
.type main, %function
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    mov x1, #100
    add x2, x1, #1
    mul x1, x1, x2
    lsr x1, x1, #1
    adrp x0, fmt
    add x0, x0, :lo12:fmt
    bl printf
    mov w0, wzr
    ldp x29, x30, [sp], 16
    ret
