//#include <subprogram.h>

int add(int a, int b , int *result) {
    *result = a + b;
    return *result;
}

int main() {
    int result;
    add(3, 4, &result);
    return 0;
}