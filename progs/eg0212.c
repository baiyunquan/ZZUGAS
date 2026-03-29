//eg0212.c
#include <stdio.h>
int x = -1;
unsigned int u = 2147483648 ;
long l =-1;
unsigned long ul = -1;
short s =-1;
unsigned short us = -1;
char c='A';
unsigned char uc=200;
char str[]="Hello Assembly!";
char str1[]={'C','h','i','n','a','\0'};
char *ps=str;

int main(){
  printf(" x = %x = %d = %u \n", x, x,x);
  printf(" u = %x = %d = %u \n", u, u,u);
  printf(" l = %x = %ld = %lu \n", l, l,l);
  printf(" s = %x = %d = %u \n", s, s, s);
  printf(" us = %x = %d = %u \n", us, us, us);

  printf(" c = %x = %d = %u = %c \n", c, c, c, c);
  printf(" uc = %x = %d = %u = %c \n", uc , uc, uc, uc);
  printf(" str = %s\n ", str);
  printf(" str1 = %s\n ", str1);

  printf(" ps = %x = %ld ", ps);
  return 0;
}
