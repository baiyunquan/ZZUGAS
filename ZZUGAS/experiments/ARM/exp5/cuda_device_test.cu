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
    if (!check_cuda(cudaGetDeviceCount(&count), "cudaGetDeviceCount")) {
        return 1;
    }

    std::printf("CUDA device count: %d\n", count);
    if (count <= 0) {
        std::printf("No CUDA device available.\n");
        return 0;
    }

    cudaDeviceProp prop{};
    if (!check_cuda(cudaGetDeviceProperties(&prop, 0), "cudaGetDeviceProperties")) {
        return 1;
    }

    std::printf("Using device 0: %s\n", prop.name);
    std::printf("Compute capability: %d.%d\n", prop.major, prop.minor);

    constexpr int n = 256;
    constexpr size_t bytes = n * sizeof(int);
    int h_in[n];
    int h_out[n];

    for (int i = 0; i < n; ++i) {
        h_in[i] = i;
        h_out[i] = 0;
    }

    int *d_in = nullptr;
    int *d_out = nullptr;
    if (!check_cuda(cudaMalloc(&d_in, bytes), "cudaMalloc d_in") ||
        !check_cuda(cudaMalloc(&d_out, bytes), "cudaMalloc d_out")) {
        cudaFree(d_in);
        cudaFree(d_out);
        return 1;
    }

    bool ok = true;
    ok = ok && check_cuda(cudaMemcpy(d_in, h_in, bytes, cudaMemcpyHostToDevice), "cudaMemcpy H2D");

    vector_add_one<<<(n + 127) / 128, 128>>>(d_in, d_out, n);
    ok = ok && check_cuda(cudaGetLastError(), "kernel launch");
    ok = ok && check_cuda(cudaDeviceSynchronize(), "cudaDeviceSynchronize");
    ok = ok && check_cuda(cudaMemcpy(h_out, d_out, bytes, cudaMemcpyDeviceToHost), "cudaMemcpy D2H");

    if (ok) {
        bool pass = true;
        for (int i = 0; i < n; ++i) {
            if (h_out[i] != h_in[i] + 1) {
                pass = false;
                break;
            }
        }
        std::printf("Kernel verification: %s\n", pass ? "PASS" : "FAIL");
    }

    cudaFree(d_in);
    cudaFree(d_out);
    return ok ? 0 : 1;
}