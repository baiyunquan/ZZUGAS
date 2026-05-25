.arch armv8-a

.text
.align 2
.global strcpy1
.type strcpy1, %function
strcpy1:
    mov x2, x0

.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy
    ret
