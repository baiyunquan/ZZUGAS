# 实验三报告：子程序设计

## 1. 实验目的
理解子程序结构特点，熟悉参数传递方式，掌握子程序编写方法。

## 2. 实验内容
1. 编写字符串复制子程序。
2. 编写 C 主程序验证子程序功能。

## 3. 实现过程与核心代码
### 3.1 子程序实现
```asm
strcpy_sub:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    mov x2, x0

.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy

    ldp x29, x30, [sp], 16
    ret
```

说明：
1. X0 传入目标地址，X1 传入源地址。
2. 使用 STP/LDP 建立和恢复栈帧，符合子程序调用规范。
3. 遇到字符串结束符（0）后退出循环并返回。

## 4. 编译与运行
```bash
gcc -g -O0 -o exp3_strcpy_sub exp3/strcpy_sub.s exp3/strcpy_sub_demo.c
./exp3_strcpy_sub
```

## 5. 运行结果（嵌入）
```text
dst = Stack-aware strcpy subroutine
```

## 6. 实验总结
1. 实践了 ARM64 子程序入口与返回流程。
2. 理解了寄存器参数传递和返回控制（LR/X30）的机制。
3. 通过栈帧保护提高了子程序结构完整性和可维护性。
