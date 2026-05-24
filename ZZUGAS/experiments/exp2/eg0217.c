
//eg0217.c
#include <stdio.h>
typedef unsigned char *byte_pointer;
void show_bytes(byte_pointer start, size_t len) {
    size_t i;
    for (i = 0; i < len; i++)
	printf(" %.2x", start[i]);   
    printf("\n");
}
struct X{
    int a;
    char c;
    int b;
};
struct X x={-100,'a',-200};
int main(){
    printf("sizeof X = %d \n", sizeof(x));
    show_bytes((byte_pointer)&x,sizeof(x));
    return 0;
}
