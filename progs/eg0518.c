#include <stdio.h>
int mult2(int x, int y){
 int t = x*y;
 return t;
}
void multstore(int x, int y, int *dest) {
    int t = mult2(x, y);
    *dest = t;
}
int main(){
int m;
multstore(3,5,&m);
printf("3 * 5 =%d",m);
return 0;
}
