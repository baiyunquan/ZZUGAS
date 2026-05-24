#!/bin/bash

# 1. Ask for the base filename (e.g., eg0102)
echo "Enter the source filename (without .c extension):"
read -p "> " BASE

# Check if the .c source file exists
if [ ! -f "${BASE}.c" ]; then
    echo "Error: ${BASE}.c not found!"
    exit 1
fi

echo "--- Starting Build Process for ${BASE} ---"

# 3. Compile to Object File (.o)
echo "[Step 3] Generating ${BASE}.o from ${BASE}.c..."
gcc -O0 -c -o "${BASE}.o" "${BASE}.c"

# 4. Compile to Assembly File (.s) using Intel syntax
echo "[Step 4] Generating ${BASE}.s (Intel syntax)..."
gcc -O0 -S -masm=intel -o "${BASE}.s" "${BASE}.c"

# 5. Assemble from .s using gcc and as
echo "[Step 5] Creating object files from assembly..."
gcc -c -o "${BASE}cc.o" "${BASE}.s"
as -o "${BASE}as.o" "${BASE}.s"

# 6. Generate Executable Files
echo "[Step 6] Creating executables..."
# Method 1: Direct from .c
gcc -O0 -o "${BASE}" "${BASE}.c"
# Method 2: From .s
gcc -o "${BASE}_1" "${BASE}.s"
# Method 3: From .o
gcc -o "${BASE}_2" "${BASE}.o"

echo "--- Process Complete ---"
# List the generated files
ls -l ${BASE}*