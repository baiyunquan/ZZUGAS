//eg0504.c
#include <stdio.h>


int sub_of(int x, int y, int *diff){
*diff=x-y;
return 0;
}

int main(){
int d,f;
sub_of(1234567890,-999999999,&d);
printf("x-y = %d = %u = %x",d,d,d);
return 0;
}