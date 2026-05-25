#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUT_DIR="$SCRIPT_DIR"
LOG_DIR="$SCRIPT_DIR/logs"
LIBTEST="$SCRIPT_DIR/../../lib/libtest.a"

mkdir -p "$LOG_DIR"

timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
echo "[$timestamp] Start all ARM experiment builds/tests" | tee "$LOG_DIR/summary.log"
echo "Script dir: $SCRIPT_DIR" | tee -a "$LOG_DIR/summary.log"
echo "Output dir: $OUT_DIR" | tee -a "$LOG_DIR/summary.log"

collect_system_info() {
    local info_log="$LOG_DIR/system_info_fastfetch.txt"
    {
        echo "=== fastfetch ($(date '+%Y-%m-%d %H:%M:%S')) ==="
        if command -v fastfetch >/dev/null 2>&1; then
            fastfetch --pipe false
        else
            echo "fastfetch is not installed"
        fi
        echo
        echo "=== basic uname info ==="
        uname -a
        echo
        echo "=== gcc version ==="
        gcc --version | head -n 2
        echo
        echo "=== nvcc version ==="
        if command -v nvcc >/dev/null 2>&1; then
            nvcc --version
        else
            echo "nvcc is not installed"
        fi
    } >"$info_log" 2>&1

    echo "Saved system info to $info_log" | tee -a "$LOG_DIR/summary.log"
}

build_and_run() {
    local name="$1"
    shift
    local exe="$OUT_DIR/$name"
    local log="$LOG_DIR/${name}.log"

    {
        echo "=== BUILD: $name ==="
        echo "Command: gcc -g -O0 -o $exe $*"
        gcc -g -O0 -o "$exe" "$@"
        echo
        echo "=== RUN: $name ==="
        "$exe"
        echo
    } >"$log" 2>&1

    echo "OK: $name (log: $log)" | tee -a "$LOG_DIR/summary.log"
}

build_and_run_nvcc() {
    local name="exp5_cuda_device_test"
    local src="$SCRIPT_DIR/exp5/cuda_device_test.cu"
    local exe="$OUT_DIR/$name"
    local log="$LOG_DIR/${name}.log"

    {
        echo "=== BUILD: $name ==="
        if ! command -v nvcc >/dev/null 2>&1; then
            echo "nvcc is not installed; skip GPU test build"
            exit 0
        fi
        echo "Command: nvcc -O2 -o $exe $src"
        nvcc -O2 -o "$exe" "$src"
        echo
        echo "=== RUN: $name ==="
        "$exe"
        echo
    } >"$log" 2>&1 || true

    if grep -q "CUDA device count" "$log"; then
        echo "OK: $name (log: $log)" | tee -a "$LOG_DIR/summary.log"
    else
        echo "WARN: $name did not run successfully, check $log" | tee -a "$LOG_DIR/summary.log"
    fi
}

build_and_run_nvcc_memcpy_bench() {
    local name="exp5_cuda_memcpy_bench"
    local src="$SCRIPT_DIR/exp5/memorycopy_cuda_bench.cu"
    local exe="$OUT_DIR/$name"
    local log="$LOG_DIR/${name}.log"

    {
        echo "=== BUILD: $name ==="
        if ! command -v nvcc >/dev/null 2>&1; then
            echo "nvcc is not installed; skip GPU memcpy benchmark build"
            exit 0
        fi
        echo "Command: nvcc -O3 -lineinfo -o $exe $src"
        nvcc -O3 -lineinfo -o "$exe" "$src"
        echo
        echo "=== RUN: $name ==="
        "$exe"
        echo
    } >"$log" 2>&1 || true

    if grep -q "Best path" "$log"; then
        echo "OK: $name (log: $log)" | tee -a "$LOG_DIR/summary.log"
    else
        echo "WARN: $name did not run successfully, check $log" | tee -a "$LOG_DIR/summary.log"
    fi
}

collect_system_info

build_and_run exp1_hello "$SCRIPT_DIR/exp1/hello.s" "$LIBTEST"
build_and_run exp1_sum100 "$SCRIPT_DIR/exp1/sum100.s"

build_and_run exp2_max_find "$SCRIPT_DIR/exp2/find_max.s" "$SCRIPT_DIR/exp2/max_find.c"
build_and_run exp2_strcpy "$SCRIPT_DIR/exp2/strcpy.s" "$SCRIPT_DIR/exp2/strcpy_demo.c"

build_and_run exp3_strcpy_sub "$SCRIPT_DIR/exp3/strcpy_sub.s" "$SCRIPT_DIR/exp3/strcpy_sub_demo.c"

build_and_run exp4_compare_main "$SCRIPT_DIR/exp4/main.s" "$SCRIPT_DIR/exp4/compare.c"
build_and_run exp4_c_strcpy "$SCRIPT_DIR/exp4/strcpy1.s" "$SCRIPT_DIR/exp4/main.c"
build_and_run exp4_inline_compare "$SCRIPT_DIR/exp4/inline_compare.c"

build_and_run exp5_m1 "$SCRIPT_DIR/exp5/copyfunc.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run exp5_m21 "$SCRIPT_DIR/exp5/copyfunc_v2_1.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run exp5_m22 "$SCRIPT_DIR/exp5/copyfunc_v2_2.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run exp5_m31 "$SCRIPT_DIR/exp5/copyfunc_v3_1.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run_nvcc
build_and_run exp5_m32 "$SCRIPT_DIR/exp5/copyfunc_v3_2.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run exp5_m33 "$SCRIPT_DIR/exp5/copyfunc_v3_3.s" "$SCRIPT_DIR/exp5/memorycopy.c"
build_and_run_nvcc_memcpy_bench

echo "All done. Logs are in $LOG_DIR" | tee -a "$LOG_DIR/summary.log"