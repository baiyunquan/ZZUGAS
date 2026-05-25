#include <stdio.h>

extern char *strcpy_sub(char *dst, const char *src);

int main(void)
{
    char src[] = "Stack-aware strcpy subroutine";
    char dst[64];

    strcpy_sub(dst, src);
    printf("dst = %s\n", dst);
    return 0;
}