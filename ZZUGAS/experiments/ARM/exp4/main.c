#include <stdio.h>

extern char *strcpy1(char *dst, const char *src);

int main(void)
{
    char src[] = "C calls an ARM64 subroutine";
    char dst[64];

    strcpy1(dst, src);
    printf("dst = %s\n", dst);
    return 0;
}