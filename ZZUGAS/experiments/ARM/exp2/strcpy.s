.arch armv8-a

.text
.align 2
.global strcpy_asm
.type strcpy_asm, %function
strcpy_asm:
    mov x2, x0

.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy
    ret
