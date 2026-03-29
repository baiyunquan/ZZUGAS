int fact(int n){
if(n==0) return 1;
else return n*fact(n-1);
}

int main(){
fact(3);
return 0;
}

