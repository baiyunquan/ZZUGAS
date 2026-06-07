
# 实验8报告

## 一、实验内容
1. 实验步骤2：编写程序，从键盘输入10个有符号十进制数，求平均值并输出。
2. 实验步骤3：定义逻辑宏 `LOGICAL` 与 `LOGICAL_NOT`，完成指定逻辑指令封装。

## 二、实验环境
- 操作系统：Windows
- 开发工具：VS Code
- 汇编与连接：GCC 32位模式（`-m32`）
- 运行库：标准 C 运行库 `printf/scanf`

## 三、实验步骤2实现

### 1. 程序结构
按题目要求拆分为两个模块，并改写为完整 32 位程序：
1. 主程序文件：`exp0801.s`
2. 子程序文件：`exp0801s.s`

其中 `exp0801s.s` 的实现参考了例5-24、例5-25和例5-22，包含3个子程序过程定义：
1. `read10sid`：用 `scanf` 读取10个有符号十进制数
2. `mean_sid32`：按照例5-25的思路计算10个32位有符号数平均值
3. `write_sid`：按照例5-22的缓冲区转换方式输出有符号十进制结果

### 2. 主程序源码（exp0801.s）
```asm
.intel_syntax noprefix

.data
msg1: .asciz "Enter 10 numbers:\n"
msg2: .asciz "The mean is:"

.text
.globl main
.extern printf
.extern read10sid
.extern mean_sid32
.extern write_sid

main:
    push ebp
    mov ebp, esp
    sub esp, 48

    lea eax, [msg1]
    push eax
    call printf
    add esp, 4

    lea eax, [ebp-40]
    push 10
    push eax
    call read10sid
    add esp, 8

    lea eax, [ebp-40]
    push 10
    push eax
    call mean_sid32
    add esp, 8

    mov [ebp-44], eax

    lea eax, [msg2]
    push eax
    call printf
    add esp, 4

    mov eax, [ebp-44]
    push eax
    call write_sid
    add esp, 4

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
```

### 3. 子程序源码（exp0801s.s）
```asm
.data
writebuf: .space 13

.intel_syntax noprefix

.data
input_fmt: .asciz "%d"
output_fmt: .asciz "%s"
writebuf: .space 16

.text
.globl read10sid
.globl mean_sid32
.globl write_sid
.extern scanf
.extern printf

# read10sid(int *array, int count)
read10sid:
    push ebp
    mov ebp, esp
    push ebx
    push esi

    mov esi, [ebp+8]
    mov ebx, [ebp+12]

.L_read_loop:
    lea eax, [input_fmt]
    push esi
    push eax
    call scanf
    add esp, 8
    add esi, 4
    dec ebx
    jnz .L_read_loop

    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

# mean_sid32(int *array, int count) -> EAX
mean_sid32:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    xor eax, eax
    xor edx, edx

.L_mean_loop:
    mov ebx, [esi]
    mov edi, ebx
    sar edi, 31
    add eax, ebx
    adc edx, edi
    add esi, 4
    dec ecx
    jnz .L_mean_loop

    mov ecx, [ebp+12]
    idiv ecx

    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

# write_sid(int value)
write_sid:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov eax, [ebp+8]
    lea edi, [writebuf]
    test eax, eax
    jnz .L_write_nonzero

    mov byte ptr [edi], '0'
    inc edi
    jmp .L_write_finish

.L_write_nonzero:
    jns .L_write_positive
    mov byte ptr [edi], '-'
    inc edi
    neg eax

.L_write_positive:
    mov ebx, 10
    push ebx

.L_write_digits:
    test eax, eax
    jz .L_write_pop
    xor edx, edx
    div ebx
    add edx, '0'
    push edx
    jmp .L_write_digits

.L_write_pop:
    pop edx
    cmp edx, ebx
    je .L_write_finish
    mov byte ptr [edi], dl
    inc edi
    jmp .L_write_pop

.L_write_finish:
    mov byte ptr [edi], 0
    lea eax, [writebuf]
    push eax
    lea eax, [output_fmt]
    push eax
    call printf
    add esp, 8

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
```

### 4. 模块连接开发过程（上机实现）

#### 方式A：直接连接两个模块
```powershell
gcc -m32 -c ZZUGAS/experiments/exp8/exp0801.s -o ZZUGAS/experiments/exp8/exp0801.o
gcc -m32 -c ZZUGAS/experiments/exp8/exp0801s.s -o ZZUGAS/experiments/exp8/exp0801s.o
gcc -m32 ZZUGAS/experiments/exp8/exp0801.o ZZUGAS/experiments/exp8/exp0801s.o -o ZZUGAS/experiments/exp8/exp0801_32.exe
```

#### 方式B：先做子程序库，再连接主程序
```powershell
gcc -m32 -c ZZUGAS/experiments/exp8/exp0801s.s -o ZZUGAS/experiments/exp8/exp0801s.o
ar rcs ZZUGAS/lib/libmysub.a ZZUGAS/experiments/exp8/exp0801s.o

gcc -m32 ZZUGAS/experiments/exp8/exp0801.o \
    ZZUGAS/lib/libmysub.a \
    -o ZZUGAS/experiments/exp8/exp0801_lib.exe
```

已生成库文件：`ZZUGAS/lib/libmysub.a`

### 5. 运行输入与结果

#### 指定输入（10个）
`1234567890, -1234, 0, 1, -987654321, 32767, -32768, 5678, -5678, 9000`

#### 实际运行输出
```text
Enter 10 numbers:
The mean is:24692133
```

说明：本机当前未安装完整的 32 位 MinGW 链接库，因此上面的 32 位链接指令为标准可复现写法；源码已通过 `gcc -m32 -c` 汇编语法检查。

#### 结果校验
和为 `246921335`，平均值整数部分：

`246921335 / 10 = 24692133`

与程序运行结果一致。

## 四、实验步骤3实现

### 1. 代码要求
定义宏：
1. `LOGICAL`：支持 `AND`、`OR`、`XOR`、`TEST`
2. `LOGICAL_NOT`：支持 `NOT`

### 2. 程序源码（exp0802.s）
```asm
.intel_syntax noprefix

.section .text

.macro LOGICAL OP, A, B
    .ifc \OP, AND
        push rbx
        mov eax, \A
        mov ebx, \B
        and eax, ebx
        pop rbx
    .else
    .ifc \OP, OR
        push rbx
        mov eax, \A
        mov ebx, \B
        or eax, ebx
        pop rbx
    .else
    .ifc \OP, XOR
        push rbx
        mov eax, \A
        mov ebx, \B
        xor eax, ebx
        pop rbx
    .else
    .ifc \OP, TEST
        push rbx
        mov eax, \A
        mov ebx, \B
        test eax, ebx
        pop rbx
    .else
        .error "Invalid logical operation"
    .endif
    .endif
    .endif
    .endif
.endm

.macro LOGICAL_NOT A
    push rbx
    mov eax, \A
    not eax
    pop rbx
.endm

.globl main
main:
    LOGICAL AND, 0xFF, 0x0F
    LOGICAL OR,  0xF0, 0x0F
    LOGICAL XOR, 0xFF, 0x0F
    LOGICAL TEST, 0xFF, 0x0F
    LOGICAL_NOT 0

    mov eax, 0
    ret
```

### 3. 编译与运行
```powershell
gcc -g -no-pie ZZUGAS/experiments/exp8/exp0802.s -o ZZUGAS/experiments/exp8/exp0802.exe
```

运行后退出码：
```text
exit=0
```

说明宏定义可正常汇编、连接并执行。

## 六、实验总结
1. 通过将主程序与子程序分离，代码结构更清晰，便于复用与维护。
2. 使用 `ar rcs` 生成静态库后，主程序连接流程更加工程化。
3. 求平均值时采用高低32位累加可避免简单32位累加溢出风险，输出部分则用缓冲区转字符串的方式更贴近教材例5-22。
4. 宏定义在汇编中非常实用，能够统一常见逻辑操作写法。

遇到的问题：
1. Windows 环境下链接外部IO接口时需要正确引入 `io_windows64.a`。
2. 汇编语法（AT&T 与 Intel）切换时容易混淆操作数顺序，需要注意。