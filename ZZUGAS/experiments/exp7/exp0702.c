#include <stdio.h>
#include <string.h>

void printMemArea(void * ptr , int index) {
    const unsigned char * p = (const unsigned char *) ptr;
    for(int i = 0; i < index; i++) {
        printf("%02x " , p[i]);
    }
}


int main() {
    const char* testStr = "This is a test!";
    printMemArea((void *) testStr , strlen(testStr));
    return 0;
}