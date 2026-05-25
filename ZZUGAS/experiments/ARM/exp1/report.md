# 实验一报告：ARM64 汇编语言开发过程

## 1. 实验目的
熟悉 ARM64 汇编语言的语句格式和程序框架，掌握 ARM64 汇编语言程序的开发流程。

## 2. 实验内容
1. 输出字符串 Hello, World!。
2. 使用公式 n*(n+1)/2 计算 1 到 100 的和。

## 3. 实现过程与核心代码
### 3.1 Hello 程序
```asm
.arch armv8-a
.section .rodata
msg:
    .string "Hello, World!\n"

.text
.align 2
.global main
.type main, %function
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    adr x0, msg
    bl dispmsg
    mov w0, wzr
    ldp x29, x30, [sp], 16
    ret
```

### 3.2 sum(1..100) 程序
```asm
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    mov x1, #100
    add x2, x1, #1
    mul x1, x1, x2
    lsr x1, x1, #1
    adrp x0, fmt
    add x0, x0, :lo12:fmt
    bl printf
    mov w0, wzr
    ldp x29, x30, [sp], 16
    ret
```

## 4. 编译与运行
```bash
gcc -g -O0 -o exp1_hello exp1/hello.s ../../lib/libtest.a
gcc -g -O0 -o exp1_sum100 exp1/sum100.s
./exp1_hello
./exp1_sum100
```

## 5. 运行结果（嵌入）
```text
Hello, World!
sum(1..100) = 5050
```

## 6. 实验总结
1. 掌握了 ARM64 程序的基本函数框架：保存/恢复栈帧、参数传递与返回。
2. 学会了通过汇编调用 C 函数（如 printf）及链接外部库（libtest.a）。
3. 对 ADR/ADRP 与 PC 相对寻址、整数运算与移位实现公式求值有了实践认识。
