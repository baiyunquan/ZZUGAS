.arch armv8-a

.text
.align 2
.global strcpy_sub
.type strcpy_sub, %function
strcpy_sub:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    mov x2, x0

.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy

    ldp x29, x30, [sp], 16
    ret
