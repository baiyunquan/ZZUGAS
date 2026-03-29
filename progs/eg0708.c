#include <stdio.h>

int sum_for(int n){
    int s=0;
    for(int i=1;i<=n;i++)
      s=s+i;
    return s;
}

int sum_while(int n){
    int i=1, s=0;
    while(i<=n)
      {
          s=s+i;
          i++;
      }

    return s;
}


int sum_until(int n){
    int i=1, s=0;
    do{
      s=s+i;
      i++;
    }while(i<=n);
    return s;
}

int main(){
    printf("%d",sum_for(100));
    printf("%d",sum_while(100));
    printf("%d",sum_until(100));
    return 0;
}