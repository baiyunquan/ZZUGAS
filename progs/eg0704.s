.data
    a:   .xword  10
    b:   .xword  20

.text
    .global main
    main:
        STP     X29, X30, [SP, -16]!
        
ldr x1, a
ldr x2, b
cmp x1, x2
b.le Part2
Part1:
//... ...
b End
Part2:
//... ...
End:

        MOV     X0, 0
        LDP     X29, X30, [SP], 16
        RET
