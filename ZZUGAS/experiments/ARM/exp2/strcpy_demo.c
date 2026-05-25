#include <stdio.h>

extern char *strcpy_asm(char *dst, const char *src);

int main(void)
{
    char src[] = "AArch64 strcpy demo";
    char dst[64];

    strcpy_asm(dst, src);
    printf("dst = %s\n", dst);
    return 0;
}