#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>

#include <cuda_runtime.h>

namespace {

constexpr size_t kDefaultBytes = 256ULL * 1024ULL * 1024ULL;
constexpr int kDefaultIters = 80;

bool check(cudaError_t err, const char *step)
{
    if (err != cudaSuccess) {
        std::fprintf(stderr, "%s failed: %s\n", step, cudaGetErrorString(err));
        return false;
    }
    return true;
}

__global__ void copy_kernel_u4(const uint4 *src, uint4 *dst, size_t n_vec4)
{
    size_t i = static_cast<size_t>(blockIdx.x) * blockDim.x + threadIdx.x;
    size_t stride = static_cast<size_t>(gridDim.x) * blockDim.x;
    for (; i < n_vec4; i += stride) {
        dst[i] = src[i];
    }
}

double benchmark_d2d_memcpy_async(void *d_dst, const void *d_src, size_t bytes, int iters, cudaStream_t stream)
{
    cudaEvent_t ev_start{}, ev_stop{};
    if (!check(cudaEventCreate(&ev_start), "cudaEventCreate start") ||
        !check(cudaEventCreate(&ev_stop), "cudaEventCreate stop")) {
        return -1.0;
    }

    for (int i = 0; i < 10; ++i) {
        if (!check(cudaMemcpyAsync(d_dst, d_src, bytes, cudaMemcpyDeviceToDevice, stream), "warmup memcpy async")) {
            cudaEventDestroy(ev_start);
            cudaEventDestroy(ev_stop);
            return -1.0;
        }
    }
    if (!check(cudaStreamSynchronize(stream), "warmup sync")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    if (!check(cudaEventRecord(ev_start, stream), "event record start") ||
        !check(cudaGetLastError(), "pre-benchmark state")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    for (int i = 0; i < iters; ++i) {
        if (!check(cudaMemcpyAsync(d_dst, d_src, bytes, cudaMemcpyDeviceToDevice, stream), "benchmark memcpy async")) {
            cudaEventDestroy(ev_start);
            cudaEventDestroy(ev_stop);
            return -1.0;
        }
    }

    if (!check(cudaEventRecord(ev_stop, stream), "event record stop") ||
        !check(cudaEventSynchronize(ev_stop), "event sync stop")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    float ms = 0.0f;
    if (!check(cudaEventElapsedTime(&ms, ev_start, ev_stop), "elapsed time")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    cudaEventDestroy(ev_start);
    cudaEventDestroy(ev_stop);
    return static_cast<double>(ms);
}

double benchmark_kernel_copy(const uint4 *d_src, uint4 *d_dst, size_t n_vec4, int iters, cudaStream_t stream)
{
    cudaEvent_t ev_start{}, ev_stop{};
    if (!check(cudaEventCreate(&ev_start), "cudaEventCreate start") ||
        !check(cudaEventCreate(&ev_stop), "cudaEventCreate stop")) {
        return -1.0;
    }

    int block = 256;
    int grid = static_cast<int>((n_vec4 + block - 1) / block);
    if (grid < 1) {
        grid = 1;
    }
    if (grid > 4096) {
        grid = 4096;
    }

    for (int i = 0; i < 10; ++i) {
        copy_kernel_u4<<<grid, block, 0, stream>>>(d_src, d_dst, n_vec4);
    }
    if (!check(cudaGetLastError(), "warmup kernel launch") ||
        !check(cudaStreamSynchronize(stream), "warmup kernel sync")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    if (!check(cudaEventRecord(ev_start, stream), "event record start") ||
        !check(cudaGetLastError(), "pre-kernel benchmark state")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    for (int i = 0; i < iters; ++i) {
        copy_kernel_u4<<<grid, block, 0, stream>>>(d_src, d_dst, n_vec4);
    }

    if (!check(cudaGetLastError(), "benchmark kernel launch") ||
        !check(cudaEventRecord(ev_stop, stream), "event record stop") ||
        !check(cudaEventSynchronize(ev_stop), "event sync stop")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    float ms = 0.0f;
    if (!check(cudaEventElapsedTime(&ms, ev_start, ev_stop), "elapsed time")) {
        cudaEventDestroy(ev_start);
        cudaEventDestroy(ev_stop);
        return -1.0;
    }

    cudaEventDestroy(ev_start);
    cudaEventDestroy(ev_stop);
    return static_cast<double>(ms);
}

double calc_bandwidth_gbps(size_t bytes, int iters, double ms_total)
{
    const double seconds = ms_total / 1000.0;
    if (seconds <= 0.0) {
        return 0.0;
    }
    const double total_bytes = static_cast<double>(bytes) * static_cast<double>(iters);
    return total_bytes / seconds / 1e9;
}

} // namespace

int main(int argc, char **argv)
{
    size_t bytes = kDefaultBytes;
    int iters = kDefaultIters;

    if (argc >= 2) {
        long long mib = std::atoll(argv[1]);
        if (mib > 0) {
            bytes = static_cast<size_t>(mib) * 1024ULL * 1024ULL;
        }
    }
    if (argc >= 3) {
        int parsed = std::atoi(argv[2]);
        if (parsed > 0) {
            iters = parsed;
        }
    }

    int dev_count = 0;
    if (!check(cudaGetDeviceCount(&dev_count), "cudaGetDeviceCount") || dev_count <= 0) {
        std::fprintf(stderr, "No CUDA device available.\n");
        return 1;
    }
    if (!check(cudaSetDevice(0), "cudaSetDevice")) {
        return 1;
    }

    cudaDeviceProp prop{};
    if (!check(cudaGetDeviceProperties(&prop, 0), "cudaGetDeviceProperties")) {
        return 1;
    }

    std::printf("GPU memcpy benchmark\n");
    std::printf("Device: %s (cc %d.%d)\n", prop.name, prop.major, prop.minor);
    std::printf("Bytes per iteration: %zu (%.2f MiB)\n", bytes, static_cast<double>(bytes) / 1024.0 / 1024.0);
    std::printf("Iterations: %d\n", iters);

    if (bytes < sizeof(uint4)) {
        std::fprintf(stderr, "Buffer is too small.\n");
        return 1;
    }

    const size_t aligned_bytes = bytes - (bytes % sizeof(uint4));
    const size_t n_vec4 = aligned_bytes / sizeof(uint4);

    uint8_t *h_src = nullptr;
    uint8_t *h_dst = nullptr;
    uint8_t *d_src = nullptr;
    uint8_t *d_dst = nullptr;
    cudaStream_t stream{};

    bool ok = true;
    ok = ok && check(cudaMallocHost(&h_src, aligned_bytes), "cudaMallocHost h_src");
    ok = ok && check(cudaMallocHost(&h_dst, aligned_bytes), "cudaMallocHost h_dst");
    ok = ok && check(cudaMalloc(&d_src, aligned_bytes), "cudaMalloc d_src");
    ok = ok && check(cudaMalloc(&d_dst, aligned_bytes), "cudaMalloc d_dst");
    ok = ok && check(cudaStreamCreateWithFlags(&stream, cudaStreamNonBlocking), "cudaStreamCreateWithFlags");

    if (!ok) {
        cudaFreeHost(h_src);
        cudaFreeHost(h_dst);
        cudaFree(d_src);
        cudaFree(d_dst);
        if (stream) {
            cudaStreamDestroy(stream);
        }
        return 1;
    }

    std::memset(h_src, 0x5a, aligned_bytes);
    std::memset(h_dst, 0x00, aligned_bytes);

    ok = ok && check(cudaMemcpyAsync(d_src, h_src, aligned_bytes, cudaMemcpyHostToDevice, stream), "H2D init copy");
    ok = ok && check(cudaStreamSynchronize(stream), "H2D init sync");
    if (!ok) {
        cudaFreeHost(h_src);
        cudaFreeHost(h_dst);
        cudaFree(d_src);
        cudaFree(d_dst);
        cudaStreamDestroy(stream);
        return 1;
    }

    double memcpy_ms = benchmark_d2d_memcpy_async(d_dst, d_src, aligned_bytes, iters, stream);
    double kernel_ms = benchmark_kernel_copy(reinterpret_cast<const uint4 *>(d_src),
                                             reinterpret_cast<uint4 *>(d_dst),
                                             n_vec4,
                                             iters,
                                             stream);

    ok = ok && check(cudaMemcpyAsync(h_dst, d_dst, aligned_bytes, cudaMemcpyDeviceToHost, stream), "D2H verify copy");
    ok = ok && check(cudaStreamSynchronize(stream), "D2H verify sync");

    bool verify_ok = true;
    if (ok) {
        verify_ok = (std::memcmp(h_src, h_dst, aligned_bytes) == 0);
    }

    double memcpy_bw = calc_bandwidth_gbps(aligned_bytes, iters, memcpy_ms);
    double kernel_bw = calc_bandwidth_gbps(aligned_bytes, iters, kernel_ms);

    std::printf("D2D cudaMemcpyAsync: %.3f ms total, %.2f GB/s\n", memcpy_ms, memcpy_bw);
    std::printf("D2D vector kernel:   %.3f ms total, %.2f GB/s\n", kernel_ms, kernel_bw);
    std::printf("Verification: %s\n", verify_ok ? "PASS" : "FAIL");

    if (memcpy_bw >= kernel_bw) {
        std::printf("Best path: cudaMemcpyAsync D2D\n");
    } else {
        std::printf("Best path: vector copy kernel\n");
    }

    cudaStreamDestroy(stream);
    cudaFreeHost(h_src);
    cudaFreeHost(h_dst);
    cudaFree(d_src);
    cudaFree(d_dst);

    if (!ok || !verify_ok || memcpy_ms <= 0.0 || kernel_ms <= 0.0) {
        return 1;
    }
    return 0;
}