#include <stdio.h>

void bubble_sort(int a[],int n){

  for(int i=1;i<=n-1;i++)
   for(int j=0; j<n-i;j++)
     if(a[j]>a[j+1]) {
     int t =a[j];
     a[j]=a[j+1];
     a[j+i]=t;
     }
}

int main(){
int a[]={587,-632,777,234,-34};
int n = sizeof(a)/4;

printf("≈≈–Ú«∞:\n");
for(int i=0;i<n;i++)
  printf("%d ",a[i]);

bubble_sort(a,n);

printf("\n≈≈–Ú∫Û:\n");
for(int i=0;i<n;i++)
  printf("%d ",a[i]);
  
}