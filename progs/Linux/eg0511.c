#include <stdio.h>

void fib1(int fibs[],int n){
int *endfibs=fibs+n;
*fibs++=1;
*fibs++=1;
for(;fibs<endfibs; fibs++)
   *fibs = *(fibs-1) +*(fibs -2);
}

void fib2(int fibs[],int n){
fibs[0]=1;
fibs[1]=1;
for(int i=3;i<n; i++)
   fibs[i] = fibs[i-1] + fibs[i-2];
}

#define N 10
int main(){
int fibs[N];

fib1(fibs,N);
for(int i=0;i<N;i++)
printf("%d ",fibs[i]);

fib2(fibs,N);
for(int i=0;i<N;i++)
printf("\n%d ",fibs[i]);
}



