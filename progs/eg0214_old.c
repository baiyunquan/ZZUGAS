//eg0214.c
#include <stdio.h>
typedef unsigned char *byte_pointer;
void show_bytes(byte_pointer start, size_t len) {
    size_t i;
    for (i = 0; i < len; i++)
	         printf(" %.2x", start[i]);    
    printf("\n");
}

int i=-12345;
long l;
char c;
float f;
double d;
int main(){
    l=i;
    f=i;
    d=f;
    c=(char)i;
   show_bytes((byte_pointer) &i,sizeof(i));
   show_bytes((byte_pointer) &l,sizeof(l));
   show_bytes((byte_pointer) &c,sizeof(c));
   show_bytes((byte_pointer) &c,sizeof(f));
   show_bytes((byte_pointer) &c,sizeof(d));
   return 0;
}

