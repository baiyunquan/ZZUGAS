//eg0215.c
#include <stdio.h>
typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len)
{
    size_t i;
    for (i = 0; i < len; i++)
        printf(" %.2x", start[i]);
    printf("\n");
}

float f = -100.5;
double d = -100.5;

int main()
{
    printf("f= %f,d= %lf\n", f, d);
    show_bytes((byte_pointer)&f, sizeof(f));
    show_bytes((byte_pointer)&d, sizeof(d));
    return 0;
}
