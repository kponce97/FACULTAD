#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"

static void insert(int a[], unsigned int i, unsigned int length)
{
    unsigned int j;
    j = i;
    while (j >= 1 && j <= length && goes_before(a[j], a[j - 1]))
    {
        array_dump_2(a, length);
        swap(a, j - 1, j);
        printf("swap(a,%d,%d)", j - 1, j);
        j--;
    }
}

void insertion_sort(int a[], unsigned int length)
{
    for (unsigned int i = 1; i < length; ++i)
    {
        insert(a, i, length);
    }
    assert(array_is_sorted(a, length));
}
