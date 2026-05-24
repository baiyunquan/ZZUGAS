#include <stdio.h>

int isletter(char c){
    return (c>='a' && c<='z')?1:-1;
}

int main(){
    if(isletter('x')==1)
       printf("Y");
    else
       printf("N");
    return 0;
}