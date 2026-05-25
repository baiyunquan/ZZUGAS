.arch armv8-a

.section .rodata
fmt:
    .string "compare_data(%d, %d) = %d\n"

.text
.align 2
.global main
.type main, %function
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov w0, #23
    mov w1, #42
    bl compare_data

    mov w3, w0
    mov w1, #23
    mov w2, #42
    adrp x0, fmt
    add x0, x0, :lo12:fmt
    bl printf

    mov w0, wzr
    ldp x29, x30, [sp], 16
    ret
