#include <stdio.h>

static int inline_compare(int a, int b)
{
    int result;

    asm volatile(
        "cmp %w1, %w2\n\t"
        "csel %w0, %w1, %w2, ge\n\t"
        : "=r"(result)
        : "r"(a), "r"(b)
        : "cc");

    return result;
}

int main(void)
{
    printf("inline compare result = %d\n", inline_compare(73, 42));
    return 0;
}