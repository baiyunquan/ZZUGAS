//eg0216.c
#include <stdio.h>
typedef unsigned char *byte_pointer;
void show_bytes(byte_pointer start, size_t len) {
    size_t i;
    for (i = 0; i < len; i++)
	         printf(" %.2x", start[i]);    
    printf("\n");
}

int i=-12345;
long l = -1;
char c = -1;
float f = -1.0f;
double d = -1.0;
int main(){
    l=i;
    f=i;
    d=f;
    c=(char)i;
   show_bytes((byte_pointer) &i,sizeof(i));
   show_bytes((byte_pointer) &l,sizeof(l));
   show_bytes((byte_pointer) &c,sizeof(c));
   show_bytes((byte_pointer) &f,sizeof(f));
   show_bytes((byte_pointer) &d,sizeof(d));
   return 0;
}
