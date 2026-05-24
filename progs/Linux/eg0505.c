#include <stdio.h>

char* msgs[]={"Chapter 1: Fundamentals\n",
               "Chapter 2: Data Representation\n",
               "Chapter 3: x86 Intruction Set Architecture\n",
               "Chapter 4: Basic Instructions\n",
               "Chapter 5: Program Structure\n",
               "Chapter 6: ARM Intruction Set Architecture\n",
               "Chapter 7: ARM Assembly Language Programming\n",
               "Chapter 8: Assembly Language Applications\n"};

char* print(char* msgs[], int i){
 if(i>8 || i<1)
 return 0;
 else
 return msgs[i-1];
}
int main(){
  int input;
  char* pc;
  scanf("%d",&input);
  pc=print(msgs,input);
  if(pc) printf("%s",pc);
  else printf("input error");
  return 0;
}