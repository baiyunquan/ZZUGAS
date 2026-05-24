/*eg0801_x86.c */
#include <stdio.h>
int main()
{
  unsigned long len;
  char msg[]="DREAM it POSSIBLE!\n";
  
  asm volatile (	/* 嵌入式汇编代码部分 */
   ".intel_syntax noprefix\n" /* 切换到Intel语法 */
    "mov rbx, 0\n" /* rbx 初值为 0，用作字符串的计数寄存器  */
    "tol1: mov al , [%0+rbx]\n" /* 载入一个字符，并指向下一个字符，%0=msg */
    "cmp al, 0\n"
    "jz tol3\n" /* al 为 0，字符串结尾，结束计数 */
      
    "cmp al, 'A'\n" /* 与大写字母 A 比较 */
    "jb tol2\n" /* 小于 'A'，不是大写字母，结束  */
    "cmp al, 'Z'\n" /* 与大写字母 Z 比较  */
    "ja tol2\n" /* 大于 'Z'，不是大写字母，结束  */
    "xor al, 0x20\n" /* 大写字母转换为小写字母  */
    "mov [%0+rbx],al\n" /* 存入原位置 */
    "tol2: add rbx, 1\n" /* 字符个数增量 */
    "jmp tol1\n" /* 继续循环  */
    "tol3: mov [ qword ptr %1], rbx\n" /* W1 为 0，字符串结尾，结束计数 ,%1=len=rbx */
    : "+m"(msg),"=m" (len)
    : 
    :  "rax","rbx"/* "memory" 破坏列表 */
  );
    printf("The message is: %sThe length is %lu\n", msg, len); 
    return 0;
}
