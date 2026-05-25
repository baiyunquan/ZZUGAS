# 实验五报告：利用流水线优化汇编代码性能

## 1. 实验目的
掌握在 AArch64 架构下，通过循环展开与访存指令组织提升内存拷贝性能的方法。

## 2. 实验内容
1. 基础版 memorycopy（逐字节循环）。
2. 第一阶段优化（循环展开 2 与 4，逐字节访存）。
3. 第二阶段优化（使用 LDP/STP，每次处理 16 字节并继续展开）。
4. 扩展：使用 nvcc 进行 GPU 内存拷贝速度测试。

## 3. 实现过程与核心代码
### 3.1 基础版
```asm
memorycopy:
.Lcopy:
    ldrb w3, [x1], #1
    strb w3, [x0], #1
    sub x2, x2, #1
    cbnz x2, .Lcopy
    ret
```

### 3.2 第一阶段优化示例（展开 4）
```asm
memorycopy:
    sub x1, x1, #1
    sub x0, x0, #1
.Lcopy:
    ldrb w3, [x1, #1]
    ldrb w4, [x1, #2]
    ldrb w5, [x1, #3]
    ldrb w6, [x1, #4]!
    strb w3, [x0, #1]
    strb w4, [x0, #2]
    strb w5, [x0, #3]
    strb w6, [x0, #4]!
    sub x2, x2, #4
    cbnz x2, .Lcopy
    ret
```

### 3.3 第二阶段优化示例（LDP/STP + 展开 4）
```asm
memorycopy:
    sub x1, x1, #16
    sub x0, x0, #16
.Lcopy:
    ldp x3, x4, [x1, #16]
    ldp x5, x6, [x1, #32]
    ldp x7, x8, [x1, #48]
    ldp x9, x10, [x1, #64]!
    stp x3, x4, [x0, #16]
    stp x5, x6, [x0, #32]
    stp x7, x8, [x0, #48]
    stp x9, x10, [x0, #64]!
    sub x2, x2, #64
    cbnz x2, .Lcopy
    ret
```

### 3.4 GPU 扩展测试思路
1. 使用 nvcc 编译 GPU 内存拷贝基准程序。
2. 对比 Device-to-Device 的 cudaMemcpyAsync 与向量化 kernel 拷贝。
3. 输出总耗时、带宽（GB/s）与最佳路径。

## 4. 编译与运行
```bash
# CPU 版本
gcc -g -O0 -o exp5_m1  exp5/copyfunc.s      exp5/memorycopy.c
gcc -g -O0 -o exp5_m21 exp5/copyfunc_v2_1.s exp5/memorycopy.c
gcc -g -O0 -o exp5_m22 exp5/copyfunc_v2_2.s exp5/memorycopy.c
gcc -g -O0 -o exp5_m31 exp5/copyfunc_v3_1.s exp5/memorycopy.c
gcc -g -O0 -o exp5_m32 exp5/copyfunc_v3_2.s exp5/memorycopy.c
gcc -g -O0 -o exp5_m33 exp5/copyfunc_v3_3.s exp5/memorycopy.c

# GPU 版本
nvcc -O2 -o exp5_cuda_device_test exp5/cuda_device_test.cu
nvcc -O3 -lineinfo -o exp5_cuda_memcpy_bench exp5/memorycopy_cuda_bench.cu
```

## 5. 运行结果（嵌入）
### 5.1 CPU 版本结果
```text
exp5_m1  : memorycopy time is 42930792 ns, verify = ok
exp5_m21 : memorycopy time is 33147861 ns, verify = ok
exp5_m22 : memorycopy time is 32993903 ns, verify = ok
exp5_m31 : memorycopy time is 15466759 ns, verify = ok
exp5_m32 : memorycopy time is 15594155 ns, verify = ok
exp5_m33 : memorycopy time is 15373924 ns, verify = ok
```

### 5.2 GPU 设备检查结果
```text
CUDA device count: 1
Using device 0: Orin
Compute capability: 8.7
Kernel verification: PASS
```

### 5.3 GPU 内存拷贝测速结果
```text
GPU memcpy benchmark
Device: Orin (cc 8.7)
Bytes per iteration: 268435456 (256.00 MiB)
Iterations: 80
D2D cudaMemcpyAsync: 673.880 ms total, 31.87 GB/s
D2D vector kernel:   447.012 ms total, 48.04 GB/s
Verification: PASS
Best path: vector copy kernel
```

## 6. 结果分析
1. CPU 优化路径中，LDP/STP + 更大循环展开显著降低了访存开销和循环分支开销。
2. 从 m1 到 m33，耗时从约 42.9ms 降到约 15.4ms，性能提升明显。
3. 在当前设备上，GPU 向量化 kernel 拷贝带宽高于 cudaMemcpyAsync D2D，成为本次测试最佳路径。

## 7. 实验结论
通过分阶段优化与实测验证，完成了对 AArch64 流水线和访存优化策略的实践；并通过 nvcc 扩展测试给出了 GPU 侧内存拷贝性能对比结果，形成了可复现实验闭环。
