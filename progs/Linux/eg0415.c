#include <stdio.h>
unsigned long  sum(unsigned long N){
return (1+N)*N/2;
}
unsigned long N=3456;
int main(){
printf("%lu",sum(N));
return 0;
}