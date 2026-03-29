#include <stdio.h>

int fac(int n)
{
    int result = 1;
    do {
	result = result * n;
	n--;
    }while(n>1);
    return result;
}

int main(){
    int n=10;
    printf("%d",fac(n));
    return 0;
}