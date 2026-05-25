#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define LEN 60000000UL

static char src[LEN];
static char dst[LEN];

extern void memorycopy(char *dst, char *src, long len1);

static long long elapsed_ns(struct timespec start, struct timespec end)
{
    return (end.tv_sec - start.tv_sec) * 1000000000LL + (end.tv_nsec - start.tv_nsec);
}

static void prepare_source(void)
{
    for (size_t i = 0; i < LEN - 1; ++i) {
        src[i] = 'a';
    }
    src[LEN - 1] = '\0';
}

int main(void)
{
    struct timespec t1, t2;

    prepare_source();

    clock_gettime(CLOCK_MONOTONIC, &t1);
    memorycopy(dst, src, (long)LEN);
    clock_gettime(CLOCK_MONOTONIC, &t2);

    printf("memorycopy time is %lld ns\n", elapsed_ns(t1, t2));
    printf("verify = %s\n", memcmp(dst, src, LEN) == 0 ? "ok" : "mismatch");
    return 0;
}