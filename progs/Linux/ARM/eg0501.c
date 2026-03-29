//eg0501.c
#include <stdio.h>

int diffabs(int x, int y){
int t;
if(x>=y)
 {
 t=x-y;
 goto L1;
 }
 t=y-x;
 L1:
 return t;
}

int find(int v[3], int target) {
    int i;
    for (i = 0; i < 3; i++) {
        if (v[i] == target) {
               goto found;
            }
        }
   return -1;

found:
    return i;
}

int x=3,y=5;
int main(){
    printf("%d",diffabs(x,y));
    return 0;
}