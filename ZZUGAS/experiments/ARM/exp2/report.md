# 实验二报告：分支和循环程序设计

## 1. 实验目的
理解分支和循环程序结构的特点，掌握分支和循环结构程序的编写。

## 2. 实验内容
1. 编写 ARM64 汇编在整数数组中查找最大值。
2. 编写 ARM64 汇编实现字符串复制（strcpy 功能）。

## 3. 实现过程与核心代码
### 3.1 查找最大值
```asm
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
```

### 3.2 字符串复制
```asm
strcpy_asm:
    mov x2, x0

.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x2], #1
    cbnz w3, .Lcopy
    ret
```

## 4. 编译与运行
```bash
gcc -g -O0 -o exp2_max_find exp2/find_max.s exp2/max_find.c
gcc -g -O0 -o exp2_strcpy exp2/strcpy.s exp2/strcpy_demo.c
./exp2_max_find
./exp2_strcpy
```

## 5. 运行结果（嵌入）
```text
max value = 99
dst = AArch64 strcpy demo
```

## 6. 实验总结
1. 使用了条件跳转（CBZ/CBNZ/B.NE）和条件选择（CSEL）实现循环判断与分支逻辑。
2. 掌握了后索引访存形式在循环中的应用，代码简洁且效率较高。
3. 对数组遍历与字符串逐字节复制的 ARM64 实现方式有了完整实践。
