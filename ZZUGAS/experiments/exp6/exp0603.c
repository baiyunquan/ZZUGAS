#include <stdio.h>

void insertSort(int list[] , int size) {
    for(int i = 1; i < size; i++) {
        int temp = list[i];
        int j = i - 1;
        for(; j >= 0 && list[j] > temp; j--) {
            list[j + 1] = list[j];
        }
        list[j + 1] = temp;
    }
}

void printList(int list[] , int size) {
    for (int i = 0; i < size; i++) {
        printf("%d\n" , list[i]);
    }
}

int main() {
    int list[] = {587,-632,777,234,-34};
    printList(list , 5);
    insertSort(list , 5);
    printList(list , 5);
    return 0;
}