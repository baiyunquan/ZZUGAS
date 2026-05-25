.arch armv8-a

.text
.align 2
.global memorycopy
.type memorycopy, %function
memorycopy:
.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x0], #1
    sub x2, x2, #1
    cbnz x2, .Lcopy
    ret
