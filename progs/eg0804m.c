#include "stdio.h"
extern void strcpya(char *, char *); // 声明函数来自外部模块 
int main() { 
char srcmsg[]="Dream it Possible!\n"; 
char dstmsg[100]; 
strcpya(dstmsg,srcmsg); 
printf("%s\n%s\n",srcmsg,dstmsg); 
return 0; }

