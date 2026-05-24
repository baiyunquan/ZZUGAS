#include <stdio.h>
#include <stdbool.h>

int main() {
    _Bool nums[100001] = {false};
    int i = 2;
    while (i < 100001) {
        if (!nums[i]) {
            for(int j = i * 2; j < 100001; j += i) {
                nums[j] = true;
            }
        }
            
        i += 1;
    }
    int count = 0;
    for(i = 2; i < 100001; i++) {
        count += nums[i] ? 0 : 1;
    }
    printf("%d" , count);
    return 0;
}