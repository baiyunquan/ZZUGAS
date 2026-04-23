#include <stdio.h>


void not() {
    printf("Error! Next One！\n");
}

void yes() {
    printf("Great！\n");
}

int main() {
    //printf("N\nError! Next One！\na\nError! Next One！\n8\nGreat！");


    
    char ch1 = 'N', ch2 = 'a', ch3 = '8';

    printf("N\n");
    if (ch1 <= '9' && ch1 >= '0') {
        yes();
    } else {
        not();
    }

    printf("a\n");
    if (ch2 <= '9' && ch2 >= '0') {
        yes();
    } else {
        not();
    }
    printf("8\n");
    if (ch2 <= '9' && ch2 >= '0') {
        yes();
    } else {
        not();
    }
    return 0;
}
