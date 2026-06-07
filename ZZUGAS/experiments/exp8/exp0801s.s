.intel_syntax noprefix

.text
.globl read10sid
.globl mean_sid32
.globl write_sid
.extern readsid
.extern dispsid

# read10sid(int *array, int count)
# 使用 io_windows64 库的 readsid 循环读取10个有符号十进制数
read10sid:
    push rbp
    mov rbp, rsp
    push rbx
    push r12

    mov r12, rcx                   # r12 = 数组指针
    mov ebx, edx                   # ebx = 计数器

.L_read_loop:
    sub rsp, 32                    # 为 readsid 预留影子空间
    call readsid                   # 调用 io_windows64 读取一个有符号数
    add rsp, 32
    mov [r12], eax                 # 存入数组
    add r12, 4                     # 指针后移
    dec ebx
    jnz .L_read_loop               # 循环10次

    pop r12
    pop rbx
    pop rbp
    ret

# mean_sid32(int *array, int count) -> EAX
# 求32位有符号数组的平均值，返回 EAX
mean_sid32:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov r12, rcx                   # r12 = 数组指针
    mov r13d, edx                  # r13d = 原始个数(保存供除法使用)
    mov ecx, edx                   # ecx = 循环计数器
    xor eax, eax                   # 累加和低32位
    xor edx, edx                   # 累加和高32位(符号扩展)

.L_mean_loop:
    mov ebx, [r12]                 # 取数组元素
    mov r10d, ebx
    sar r10d, 31                   # 符号扩展到 r10d
    add eax, ebx                   # 累加
    adc edx, r10d                  # 带进位加符号扩展
    add r12, 4                     # 指针后移
    dec ecx
    jnz .L_mean_loop

    mov ecx, r13d                  # 恢复除数(元素个数)
    idiv ecx                       # EDX:EAX / ECX -> EAX(商), EDX(余数)

    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

# write_sid(int value)
# 使用 io_windows64 库的 dispsid 输出有符号十进制数
write_sid:
    push rbp
    mov rbp, rsp

    mov eax, ecx                   # 参数在 RCX 中，传给 EAX
    call dispsid                   # 调用 io_windows64 输出有符号数

    pop rbp
    ret
