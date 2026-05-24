//eg0418.c
#include <stdio.h>
short num=0xabcd;
unsigned char n=4, m=8;
int main(){
  printf("%x",(num >> n)&(~ ( ~0 << m )));
}