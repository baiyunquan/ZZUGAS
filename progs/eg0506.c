#include <stdio.h>

int caculator(char n, int x, int y , int *result){
int f=0;
switch(n){
case '+':
   *result = x+y;
   break;
case '-':
   *result = x-y;
   break;
case '*':
   *result = x *y;
   break;
case '/':
   *result =x/y;
   break;
case '<':
   *result = x<<1;
   break;
case '>':
   *result = y>>2;
   break;
default:
   f=1;
   break;
}
return f;
}

int main(){
char n;
int f, result;
scanf("%c",&n);
f = caculator(n,200,-300, &result);
if(!f)
printf("%d", result);
else 
printf("input error");
return 0;
}


