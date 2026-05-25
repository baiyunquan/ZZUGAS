# 实验四报告：与 C 语言的混合编程

## 1. 实验目的
熟悉模块连接与嵌入汇编生成可执行文件的混合编程方法。

## 2. 实验内容
1. 汇编调用 C 函数（比较两个整数大小）。
2. C 调用汇编子程序（字符串复制）。
3. C 代码中使用 GCC 内联汇编实现比较逻辑。

## 3. 实现过程与核心代码
### 3.1 汇编调用 C 函数 compare_data
```asm
main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov w0, #23
    mov w1, #42
    bl compare_data

    mov w3, w0
    mov w1, #23
    mov w2, #42
    adrp x0, fmt
    add x0, x0, :lo12:fmt
    bl printf
```

### 3.2 C 调用汇编字符串复制子程序
```asm
strcpy1:
    mov x2, x0
.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy
    ret
```

### 3.3 C 内联汇编比较
```c
asm volatile(
    "cmp %w1, %w2\n\t"
    "csel %w0, %w1, %w2, ge\n\t"
    : "=r"(result)
    : "r"(a), "r"(b)
    : "cc");
```

## 4. 编译与运行
```bash
gcc -g -O0 -o exp4_compare_main exp4/main.s exp4/compare.c
gcc -g -O0 -o exp4_c_strcpy exp4/strcpy1.s exp4/main.c
gcc -g -O0 -o exp4_inline_compare exp4/inline_compare.c

./exp4_compare_main
./exp4_c_strcpy
./exp4_inline_compare
```

## 5. 运行结果（嵌入）
```text
compare_data(23, 42) = 42
dst = C calls an ARM64 subroutine
inline compare result = 73
```

## 6. 实验总结
1. 完成了汇编与 C 双向调用，掌握了 extern 与全局符号的连接方式。
2. 掌握了 GCC 内联汇编的输入/输出约束和 clobber 约束写法。
3. 对模块化混合编程的可扩展性与工程实用性有了直接认识。
