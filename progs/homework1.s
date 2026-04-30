.data
    # my1b为字符串变量：PersonalComputer
    my1b: .asciz "PersonalComputer"
    # my2b为用十进制数表示的字节变量：20
    my2b: .byte 20
    # my3b为用十六进制数表示的字节变量：20
    my3b: .byte 0x20
    # my4b为用二进制数表示的字节变量：20
    my4b: .byte 0b10010
    .align 4
    # my6c为100的常量
    .set my6c, 100

.bss
    # my5w为20个未赋值的字变量分配内存空间
    .lcomm my5w, 40

.text
    .global main
main:

    
    int $0x80
    ret
