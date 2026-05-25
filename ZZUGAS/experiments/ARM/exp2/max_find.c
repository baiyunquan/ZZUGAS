#include <stdio.h>
#include <stddef.h>

extern int find_max(const int *values, size_t count);

int main(void)
{
    const int values[] = { -12, 7, 3, 99, 18, 42, -5, 60 };
    int max_value = find_max(values, sizeof(values) / sizeof(values[0]));

    printf("max value = %d\n", max_value);
    return 0;
}