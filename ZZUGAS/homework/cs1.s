.section .rdata,"dr"
a:  .byte -68
b:  .byte -80

    .text
    .globl main

main:
    # 将内存中的值加载到寄存器
    movb a(%rip), %al
    movb b(%rip), %bl

    # c = a + b
    movb a(%rip), %cl
    addb %bl, %cl      # %cl = %cl + %bl

    # d = a - b
    movb a(%rip), %dl
    subb %bl, %dl      # %dl = %dl - %bl

    # 设置返回值 0 并返回
    movl $0, %eax
    ret
