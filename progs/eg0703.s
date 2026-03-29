.data
    hola:   .asciz  "Hola, world!"
    hello:  .asciz  "Hello, world!"

.text
    .global main
    main:
        STP     X29, X30, [SP, -16]!
        ADR     X0, hola
        BL      puts
        ADR     X0, hello
        BL      puts
        MOV     X0, 0
        LDP     X29, X30, [SP], 16
        RET
