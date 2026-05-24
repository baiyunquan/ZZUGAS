//eg0507.c
#include <stdio.h>


int fac(int n)
{
    int result = 1;
    while (n > 1) {
	result = result * n;
	n--;
    }
    return result;
}


int main(){
    int n=10;
   
    printf("%d",fac(n));
    
    
    return 0;
}


