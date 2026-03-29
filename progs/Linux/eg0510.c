#include <stdio.h>

int mystrlen(char* str){
int n=0;
while(*str++) n++;
return n;
}

int mystrlen1(char* str){
int n=0;
while(str[n]) n++;
return n;
}


int main(){
char s[] = "China is a country with a long history.";
//printf("%d", mystrlen1(s));//yes
printf("%d", mystrlen(s));
return 0; 
}