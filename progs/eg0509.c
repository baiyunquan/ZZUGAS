#include <stdio.h>

int fac(int n)
{
    int result = 1;
    for(int i=1;i<=n;i++)
	result = result * i;
    return result;
}

int main(){
    int n=10;
    printf("%d",fac(n));
    return 0;
}