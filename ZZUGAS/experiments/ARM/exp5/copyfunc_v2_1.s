.arch armv8-a

.text
.align 2
.global memorycopy
.type memorycopy, %function
memorycopy:
    sub x1, x1, #1
    sub x0, x0, #1

.Lcopy:
    ldrb w3, [x1, #1]
    ldrb w4, [x1, #2]!
    strb w3, [x0, #1]
    strb w4, [x0, #2]!
    sub x2, x2, #2
    cbnz x2, .Lcopy
    ret
