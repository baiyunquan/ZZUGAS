#include <stdio.h>
short CtoF(short C){
short F;
F=9*C/5+32;
return F;
}

short C=26;
int main(){
printf("%d",CtoF(C));
return 0;
}