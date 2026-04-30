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

# 编译ASM文件
nasm -f elf "$BASE_PATH/$BASE_NAME"
if [ $? -ne 0 ]; then
    echo "NASM compilation failed"
    exit 1
fi

ld -m elf_i386 -s -o "$ASM_FILE" "$ASM_FILE.o"  ./lib/io_linux.a
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 1
fi

