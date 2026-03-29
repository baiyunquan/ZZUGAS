#!/bin/bash

# 检查是否提供了ASM文件名
if [ $# -eq 0 ]; then
    echo "Usage: $0 <asm_file>"
    exit 1
fi

ASM_FILE=$1

# 获取文件
BASE_PATH=$(dirname "$ASM_FILE")

BASE_NAME=$(basename "$ASM_FILE".s)

B_NAME=$(basename "$ASM_FILE")
#echo "当前脚本所在目录是: $B_NAME"

# 获取当前脚本所在目录
script_dir=$(dirname "$0")

# 输出脚本所在目录
#echo "当前脚本所在目录是: $script_dir"



# 编译ASM文件
as -g --32  -a="$script_dir/$B_NAME.l" -o  "$script_dir/$B_NAME.o" "$BASE_PATH/$BASE_NAME"
if [ $? -ne 0 ]; then
    echo "NASM compilation failed"
    exit 1
fi

ld -g -e main -m elf_i386 -s  -o "$script_dir/$B_NAME" "$script_dir/$B_NAME.o"  ./lib/io_linux.a
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 1
fi

