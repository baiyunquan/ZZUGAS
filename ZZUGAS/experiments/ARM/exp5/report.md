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

### 3.4 GPU 设备测试代码（`cuda_device_test.cu`）
```cuda
#include <cstdio>
#include <cuda_runtime.h>

__global__ void vector_add_one(const int *in, int *out, int n)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        out[idx] = in[idx] + 1;
    }
}

static bool check_cuda(cudaError_t err, const char *step)
{
    if (err != cudaSuccess) {
        std::fprintf(stderr, "%s failed: %s\n", step, cudaGetErrorString(err));
        return false;
    }
    return true;
}

int main()
{
    int count = 0;
    if (!check_cuda(cudaGetDeviceCount(&count), "cudaGetDeviceCount"))
        return 1;

    std::printf("CUDA device count: %d\n", count);
    if (count <= 0) {
        std::printf("No CUDA device available.\n");
        return 0;
    }

    cudaDeviceProp prop{};
    if (!check_cuda(cudaGetDeviceProperties(&prop, 0), "cudaGetDeviceProperties"))
        return 1;

    std::printf("Using device 0: %s\n", prop.name);
    std::printf("Compute capability: %d.%d\n", prop.major, prop.minor);

    constexpr int n = 256;
    constexpr size_t bytes = n * sizeof(int);
    int h_in[n], h_out[n];
    for (int i = 0; i < n; ++i) { h_in[i] = i; h_out[i] = 0; }

    int *d_in = nullptr, *d_out = nullptr;
    if (!check_cuda(cudaMalloc(&d_in, bytes), "cudaMalloc d_in") ||
        !check_cuda(cudaMalloc(&d_out, bytes), "cudaMalloc d_out")) {
        cudaFree(d_in); cudaFree(d_out);
        return 1;
    }

    bool ok = true;
    ok = ok && check_cuda(cudaMemcpy(d_in, h_in, bytes, cudaMemcpyHostToDevice),
                          "cudaMemcpy H2D");
    vector_add_one<<<(n + 127) / 128, 128>>>(d_in, d_out, n);
    ok = ok && check_cuda(cudaGetLastError(), "kernel launch");
    ok = ok && check_cuda(cudaDeviceSynchronize(), "cudaDeviceSynchronize");
    ok = ok && check_cuda(cudaMemcpy(h_out, d_out, bytes, cudaMemcpyDeviceToHost),
                          "cudaMemcpy D2H");

    if (ok) {
        bool pass = true;
        for (int i = 0; i < n; ++i)
            if (h_out[i] != h_in[i] + 1) { pass = false; break; }
        std::printf("Kernel verification: %s\n", pass ? "PASS" : "FAIL");
    }

    cudaFree(d_in); cudaFree(d_out);
    return ok ? 0 : 1;
}
```

### 3.5 GPU 内存拷贝测速代码（`memorycopy_cuda_bench.cu`）
```cuda
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <cuda_runtime.h>

namespace {

constexpr size_t kDefaultBytes = 256ULL * 1024ULL * 1024ULL;
constexpr int kDefaultIters = 80;

bool check(cudaError_t err, const char *step) { /* 省略错误检查封装 */ }

__global__ void copy_kernel_u4(const uint4 *src, uint4 *dst, size_t n_vec4)
{
    size_t i = static_cast<size_t>(blockIdx.x) * blockDim.x + threadIdx.x;
    size_t stride = static_cast<size_t>(gridDim.x) * blockDim.x;
    for (; i < n_vec4; i += stride)
        dst[i] = src[i];
}

// benchmark_d2d_memcpy_async(): 用 cudaMemcpyAsync 在 stream 中拷贝 iters 次
// benchmark_kernel_copy(): 用 copy_kernel_u4 在 stream 中启动 iters 次
// calc_bandwidth_gbps(): 根据总字节数和总毫秒数计算带宽

} // namespace

int main(int argc, char **argv)
{
    // 解析参数，分配 H2D/D2D 缓冲区，
    // 运行 warmup → benchmark → 校验收缩 → 打印结果
    // 输出 D2D cudaMemcpyAsync 与 D2D vector kernel 的耗时与带宽
}
```

完整源码见附件 `memorycopy_cuda_bench.cu`，核心思路：
1. 使用 `uint4`（16 字节）向量化拷贝 kernel，每个线程处理多个元素。
2. 对比 `cudaMemcpyAsync` Device-to-Device 与自定义 kernel 的性能。
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

## 5. 运行结果

### 5.1 CPU 版本多设备对比

以下结果来自 **6 台不同设备**，均使用同一套汇编代码编译运行。测试数据量为 **1 MiB**（1048576 字节）。

| 实现版本 | Allwinner H3<br>4×1.30 GHz<br>ARMv7 32-bit | Allwinner A733<br>2×A76+6×A55<br>≤2.00 GHz | Jetson Nano<br>4×A57<br>1.48 GHz | Raspberry Pi 4<br>4×BCM2711<br>1.80 GHz | Samsung S23<br>SD 8 Gen 2<br>3.36 GHz | Jetson Orin Nano<br>（报告内基准） |
|:----------|:---:|:---:|:---:|:---:|:---:|:---:|
| **m1**（逐字节，无展开） | 352,205,407 ns | 140,624,272 ns | 119,255,818 ns | 336,823,672 ns | 34,331,354 ns | 42,930,792 ns |
| **m21**（展开 2，字节） | 327,764,157 ns | 108,218,133 ns | 98,985,035 ns | 99,665,676 ns | 27,014,636 ns | 33,147,861 ns |
| **m22**（展开 4，字节） | 249,034,741 ns | 101,165,335 ns | 84,494,557 ns | 263,383,610 ns | 28,178,125 ns | 32,993,903 ns |
| **m31**（LDP/STP 展开 4） | 187,536,610 ns | 53,811,918 ns | 54,693,597 ns | 78,311,513 ns | 15,775,052 ns | 15,466,759 ns |
| **m32**（LDP/STP 展开 4'） | 191,435,624 ns | 53,192,907 ns | 54,519,222 ns | 159,205,612 ns | 15,352,239 ns | 15,594,155 ns |
| **m33**（LDP/STP 展开 4''） | 191,445,665 ns | 53,077,455 ns | 55,871,842 ns | 149,022,996 ns | 15,294,792 ns | 15,373,924 ns |

**各设备加速比（以 m1 为基线）：**

| 实现版本 | H3 | A733 | Jetson Nano | RPi4 | S23 | Orin Nano |
|:----------|:--:|:----:|:-----------:|:----:|:---:|:---------:|
| m1 → m21 | 1.07× | 1.30× | 1.20× | 3.38× | 1.27× | 1.30× |
| m1 → m22 | 1.41× | 1.39× | 1.41× | 1.28× | 1.22× | 1.30× |
| m1 → m31 | **1.88×** | **2.61×** | **2.18×** | **4.30×** | **2.18×** | **2.78×** |
| m1 → m32 | 1.84× | 2.64× | 2.19× | 2.12× | 2.24× | 2.75× |
| m1 → m33 | 1.84× | 2.65× | 2.13× | 2.26× | 2.24× | 2.79× |

### 5.2 GPU 设备检查结果（Jetson Orin Nano）
```text
CUDA device count: 1
Using device 0: Orin
Compute capability: 8.7
Kernel verification: PASS
```

### 5.3 GPU 内存拷贝测速结果（Jetson Orin Nano）
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

### 6.1 CPU 优化路径分析
1. **循环展开的效果**：从 m1（逐字节无展开）到 m21/m22（展开 2/4），分支指令 `cbnz` 的执行频率降低了 2–4 倍，循环开销显著减少。Samsung S23 和 Orin Nano 上展开 2 已接近最优，进一步展开到 4 收益很小，说明其流水线前端已经能很好地隐藏分支延迟。
2. **LDP/STP 访存指令的关键作用**：从 m22 到 m31（改用 LDP/STP 每次 16 字节），性能再次大幅提升。在 A733 上加速比从 1.39× 跃升到 2.61×，说明 64 位访存指令对内存带宽利用率的提升远大于单纯的循环展开。
3. **指令组织对流水线的影响**：m31/m32/m33 三者性能接近，表明在 LDP/STP + 展开 4 的配置下，指令重排带来的额外收益已经饱和，瓶颈转向内存带宽本身而非指令发射。

### 6.2 跨设备对比分析
1. **架构位宽差异**：Allwinner H3（ARMv7 32-bit）的整体性能最差，m1 耗时达 352ms，是 S23 的 10 倍以上。32 位架构缺少 LDP/STP 等 64 位双载入指令是根本原因——m31 仍达 187ms，而 AArch64 设备均在 80ms 以内。
2. **微架构差异**：Raspberry Pi 4 的 Cortex-A72 在 LDP/STP 模式下 m31 为 78ms，慢于 Jetson Nano Cortex-A57 的 55ms，说明 A57 的内存子系统在本测试中更高效。但 RPi4 的 m22（展开 4 字节访存）高达 263ms，远超 Nano 的 84ms，表明 A72 在未使用 LDP/STP 时访存效率较低。
3. **最高频率优势**：Samsung S23（Snapdragon 8 Gen 2, 3.36 GHz）在各项测试中均拔得头筹，m33 仅 15.3ms，是所有设备中最快的。其 m1 → m31 加速比 2.18× 虽不是最高，但绝对耗时最低。
4. **Allwinner A733（Cortex-A76+A55）** 表现出色，m31 仅 53.8ms，接近 Jetson Orin Nano 的 15.5ms 的两倍——考虑到频率差异（2.00 GHz vs 未知 Orin 频率），其每周期性能非常可观。

### 6.3 GPU 对比分析
1. 在 Jetson Orin Nano 上，GPU 向量化 kernel 拷贝（48.04 GB/s）显著快于 `cudaMemcpyAsync` D2D（31.87 GB/s），带宽高出约 51%。
2. 自定义 kernel 通过手动 `uint4` 向量化加载/存储，避免了 `cudaMemcpyAsync` 内部的额外开销，在 Device-to-Device 场景中更优。
3. 256 MiB × 80 次迭代的数据量确保了测试结果的可信度，校验均通过。

### 6.4 CPU vs GPU 带宽对比（Jetson Orin Nano）
| 拷贝方式 | 总耗时 | 等效带宽 |
|:---------|:------:|:--------:|
| CPU m1（逐字节） | 42.9 ms | ~24 MB/s |
| CPU m31（LDP/STP 展开 4） | 15.5 ms | ~68 MB/s |
| GPU cudaMemcpyAsync D2D | 673.9 ms（80 次） | 31.87 GB/s |
| GPU vector kernel D2D | 447.0 ms（80 次） | 48.04 GB/s |

GPU 带宽比 CPU 优化版本高出约 3 个数量级（GB/s vs MB/s），充分说明了专用 DMA 硬件和并行内存通道在批量拷贝中的巨大优势。

## 7. 实验结论

通过分阶段优化与跨 6 台设备的实测验证，完成了对 AArch64 及 ARMv7 架构下流水线和访存优化策略的全面实践：

1. **循环展开可降低分支开销**，但收益受限于微架构的前端能力。
2. **LDP/STP 双载入指令是 AArch64 内存拷贝性能提升的关键**，在支持该指令的平台上加速可达 2–4×。
3. **不同微架构对优化策略的敏感度不同**：RPi4 的 A72 对未使用 LDP/STP 的代码效率极低，而 S23 的 Kryo 核心即使逐字节拷贝也表现优异。
4. **GPU 向量化 kernel 可超越 cuMemcpyAsync 的 D2D 拷贝速度**，是 GPU 内存拷贝的最佳路径。
5. 通过 nvcc 扩展测试给出了 GPU 侧内存拷贝性能对比结果，形成了 CPU + GPU 双平台的可复现实验闭环。
