.arch armv8-a
.section .rodata
msg:
    .string "Hello, World!\n"

.text
.align 2
.global main
.type main, %function
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    adr x0, msg
    bl dispmsg
    mov w0, wzr
    ldp x29, x30, [sp], 16
    ret
