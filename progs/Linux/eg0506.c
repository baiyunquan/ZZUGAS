#include <stdio.h>

int caculator(char n, int x, int y){
int result;
switch(n){
case '+':
   result=x+y;
   break;
case '-':
   result = x-y;
   break;
case '*':
   result = x *y;
   break;
case '/':
   result =x/y;
   break;
case '<':
   result = x<<1;
   break;
case '>':
   result = y>>2;
   break;
default:
  result= 0;
  break;
}
return result;
}

int main(){
char n;

scanf("%c",&n);
printf("%d",caculator(n,200,-300));
return 0;
}


