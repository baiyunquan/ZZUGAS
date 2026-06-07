.intel_syntax noprefix

.data
msg1: .asciz "Enter 10 numbers:\n"
msg2: .asciz "The mean is: "

.text
.globl main
.extern dispmsg
.extern read10sid
.extern mean_sid32
.extern write_sid

main:
    push rbp
    mov rbp, rsp
    sub rsp, 64                     # 数组(40B)+局部变量+对齐

    # 显示提示信息
    lea rax, [rip + msg1]
    call dispmsg

    # 调用 read10sid 读10个数到栈上数组
    lea rcx, [rbp-48]               # 参数1: 数组地址
    mov edx, 10                     # 参数2: 个数
    call read10sid

    # 调用 mean_sid32 计算平均值
    lea rcx, [rbp-48]
    mov edx, 10
    call mean_sid32
    mov [rbp-52], eax               # 保存平均值

    # 显示结果
    lea rax, [rip + msg2]
    call dispmsg

    mov ecx, [rbp-52]               # 参数1: 平均值(Windows x64第一参数在RCX)
    call write_sid

    xor eax, eax
    leave
    ret
