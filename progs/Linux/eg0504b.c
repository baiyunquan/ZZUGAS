//eg0504b.c
#include <stdio.h>


int sub_of(int x, int y, int *diff){
*diff=x-y;
return 0;
}

int main(){
int d,f;
f=sub_of(1234567890,-999999999,&d);
if(!f)
printf("x-y = %d = %u = %x",d,d,d);
else
printf("溢出");
return 0;
}