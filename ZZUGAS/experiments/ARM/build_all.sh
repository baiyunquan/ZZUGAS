#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIBTEST="$ROOT_DIR/../../lib/libtest.a"

build_and_run() {
    local output="$1"
    shift
    echo "==> building ${output}"
    gcc -g -O0 -o "$ROOT_DIR/$output" "$@"
    echo "==> running ${output}"
    "$ROOT_DIR/$output"
    echo
}

build_and_run exp1_hello "$ROOT_DIR/exp1/hello.s" "$LIBTEST"
build_and_run exp1_sum100 "$ROOT_DIR/exp1/sum100.s"

build_and_run exp2_max_find "$ROOT_DIR/exp2/find_max.s" "$ROOT_DIR/exp2/max_find.c"
build_and_run exp2_strcpy "$ROOT_DIR/exp2/strcpy.s" "$ROOT_DIR/exp2/strcpy_demo.c"

build_and_run exp3_strcpy_sub "$ROOT_DIR/exp3/strcpy_sub.s" "$ROOT_DIR/exp3/strcpy_sub_demo.c"

build_and_run exp4_compare_main "$ROOT_DIR/exp4/main.s" "$ROOT_DIR/exp4/compare.c"
build_and_run exp4_c_strcpy "$ROOT_DIR/exp4/strcpy1.s" "$ROOT_DIR/exp4/main.c"
build_and_run exp4_inline_compare "$ROOT_DIR/exp4/inline_compare.c"

build_and_run exp5_m1 "$ROOT_DIR/exp5/copyfunc.s" "$ROOT_DIR/exp5/memorycopy.c"
build_and_run exp5_m21 "$ROOT_DIR/exp5/copyfunc_v2_1.s" "$ROOT_DIR/exp5/memorycopy.c"
build_and_run exp5_m22 "$ROOT_DIR/exp5/copyfunc_v2_2.s" "$ROOT_DIR/exp5/memorycopy.c"
build_and_run exp5_m31 "$ROOT_DIR/exp5/copyfunc_v3_1.s" "$ROOT_DIR/exp5/memorycopy.c"
build_and_run exp5_m32 "$ROOT_DIR/exp5/copyfunc_v3_2.s" "$ROOT_DIR/exp5/memorycopy.c"
build_and_run exp5_m33 "$ROOT_DIR/exp5/copyfunc_v3_3.s" "$ROOT_DIR/exp5/memorycopy.c"