#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    int input,count=10;

    // 初始化随机数种子（以当前时间为种子）
    srand(time(0));

    // 生成 0-100 之间的随机数
    int random_num = rand() % 101; // rand() % (max + 1)
    
    while(count){
    scanf("%d",&input);
    if(input == random_num) {
        printf("Congratulations , you only try %d times\n",11-count);
        return 0;
    }
    else{
        count--;
        if(input>random_num)
        printf("too large\n");
        else
        printf("too small\n");
    }
    }

    printf("Sorry, you have tried 10 times");
    return 0;


    return 0;
}
