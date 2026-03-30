#include <stdio.h>
typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len)
{
  size_t i;
  for (i = 0; i < len; i++)
    printf(" %.2x", start[i]);
}

float f = -100.5;
double d = -100.5;

int x = -1;
unsigned int u = 2147483648;
long l = -1;
unsigned long ul = -1;
short s = -1;
unsigned short us = -1;
char c = 'A';
unsigned char uc = 200;
char str[] = "Hello Assembly!";
char str1[] = {'C', 'h', 'i', 'n', 'a', '\0'};
char *ps = str;

int main()
{
  printf("x = %x = %d = %u ", x, x, x);
  printf("u = %x = %d = %u ", u, u, u);
  printf("l = %lx = %ld = %lu ", l, l, l);
  printf("s = %x = %d = %u ", s, s, s);
  printf("us = %x = %d = %u ", us, us, us);
  printf("c = %x = %d = %u = %c ", c, c, c, c);
  printf("uc = %x = %d = %u = %c ", uc, uc, uc, uc);
  printf("str = %s ", str);
  printf("str1 = %s ", str1);
  printf("ps = 0x601060 ");
  printf("f = %f, d = %lf", f, d);
  show_bytes((byte_pointer)&f, sizeof(f));
  show_bytes((byte_pointer)&d, sizeof(d));
  return 0;
}