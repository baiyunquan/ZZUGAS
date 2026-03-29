#include <stdio.h>

void del_char1(char *s, char t){
      int i = 0, j = 0;
    while (s[i] != '\0') {  
        if (s[i] != t) {     
            s[j++] = s[i];   
        }
        i++;
    }
    s[j] = '\0';  
}

void del_char(char *s, char t){
    char *p1 = s, *p2=s;
    while (*p1!= '\0') {  
        if (*p1 != t) {     
            *p2++ = *p1;   
        }
        p1++;
    }
    *p2= '\0';  
}


int main(){
char s[]="This is   a string";
printf("%s\n",s);  
del_char(s,' '); 
printf("%s",s);  
}