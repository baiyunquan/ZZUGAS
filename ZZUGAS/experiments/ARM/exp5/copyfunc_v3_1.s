.arch armv8-a

.text
.align 2
.global memorycopy
.type memorycopy, %function
memorycopy:
.Lcopy:
    ldp x3, x4, [x1], #16
    stp x3, x4, [x0], #16
    sub x2, x2, #16
    cbnz x2, .Lcopy
    ret
