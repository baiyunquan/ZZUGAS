
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

int main() {
    int list[] = {5 , 4,  3 , 2 , 1};
    insertSort(list , 5);

    return 0;
}