#include <subprogram.h>

void printEAX() {
    int eax;
    __asm__ volatile (
        "movl %%eax, %0"
        : "=r" (eax)
    );
    printf("EAX: %d\n", eax);
}