.arch armv8-a

.text
.align 2
.global find_max
.type find_max, %function
find_max:
    cbz x1, .Lempty
    ldr w2, [x0], #4
    sub x1, x1, #1
    cbz x1, .Ldone

.Lloop:
    ldr w3, [x0], #4
    cmp w2, w3
    csel w2, w2, w3, ge
    subs x1, x1, #1
    b.ne .Lloop

.Ldone:
    mov w0, w2
    ret

.Lempty:
    mov w0, wzr
    ret
