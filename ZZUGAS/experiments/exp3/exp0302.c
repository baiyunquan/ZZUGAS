//eg0301.c

#include <stdio.h>

int array[]={12345,-12345};
int i,*pi=array;

int main(){
printf("%d\n", array[0]);
i=1;
printf("%d\n",array[i]);
i=2;
printf("%d\n",array[i]);
printf("%d\n",*pi);
pi++;
printf("%d\n",*pi);
pi++;
printf("%d\n",*pi);
return 0;
}

