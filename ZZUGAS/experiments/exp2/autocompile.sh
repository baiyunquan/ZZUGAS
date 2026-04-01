#!/bin/bash

# Usage:
#   ./autocompile.sh [-O <level>] [base]
# Examples:
#   ./autocompile.sh
#   ./autocompile.sh -O 2 eg0102

OPT_LEVEL="0"

while getopts ":O:" opt; do
    case "$opt" in
        O)
            OPT_LEVEL="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            echo "Usage: $0 [-O <level>] [base]"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            echo "Usage: $0 [-O <level>] [base]"
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

# 1. Ask for the base filename (e.g., eg0102)
if [ -n "$1" ]; then
    BASE="$1"
else
    echo "Enter the source filename (without .c extension):"
    read -p "> " BASE
fi

OPT_FLAG="-O${OPT_LEVEL}"

# Check if the .c source file exists
if [ ! -f "${BASE}.c" ]; then
    echo "Error: ${BASE}.c not found!"
    exit 1
fi

echo "--- Starting Build Process for ${BASE} ---"
echo "Optimization level: ${OPT_FLAG}"

# 3. Compile to Object File (.o)
echo "[Step 3] Generating ${BASE}.o from ${BASE}.c..."
gcc ${OPT_FLAG} -c -o "${BASE}.o" "${BASE}.c"

# 4. Compile to Assembly Files (.s) in Intel and AT&T syntax
echo "[Step 4] Generating ${BASE}.s (Intel syntax)..."
gcc ${OPT_FLAG} -S -masm=intel -o "${BASE}.s" "${BASE}.c"

echo "[Step 4] Generating ${BASE}_att.s (AT&T syntax)..."
gcc ${OPT_FLAG} -S -o "${BASE}_att.s" "${BASE}.c"

# 5. Assemble from .s using gcc and as
echo "[Step 5] Creating object files from assembly..."
gcc -c -o "${BASE}cc.o" "${BASE}.s"
as -o "${BASE}as.o" "${BASE}.s"

# 6. Generate Executable Files
echo "[Step 6] Creating executables..."
# Method 1: Direct from .c
gcc ${OPT_FLAG} -o "${BASE}" "${BASE}.c"
# Method 2: From .s
gcc -o "${BASE}_1" "${BASE}.s"
# Method 3: From .o
gcc -o "${BASE}_2" "${BASE}.o"

echo "--- Process Complete ---"
# List the generated files
ls -l ${BASE}*