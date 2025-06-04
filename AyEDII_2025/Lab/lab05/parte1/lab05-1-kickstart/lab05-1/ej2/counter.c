#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>

#include "counter.h"

struct _counter
{
    unsigned int count;
};

counter counter_init(void)
{
    counter c = malloc(sizeof(counter));
    c->count = 0;
    assert(counter_is_init(c));
    return c;
}

void counter_inc(counter c)
{
    c->count++;
}

bool counter_is_init(counter c)
{
    return (c->count == 0);
}

void counter_dec(counter c)
{
    if (!counter_is_init(c))
    {
        c->count--;
    }
}

counter counter_copy(counter c)
{
    counter c1 = malloc(sizeof(counter));
    c1->count = c->count;
    return c1;
}

void counter_destroy(counter c)
{
    free(c);
    c = NULL;
}
