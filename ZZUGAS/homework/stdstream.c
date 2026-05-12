#include <stdio.h>

int main() {
    // Write to standard output
    printf("This is stdin: %p\n", (void*)stdin);
    printf("This is stdout: %p\n", (void*)stdout);
    printf("This is stderr: %p\n", (void*)stderr);

    return 0;
}