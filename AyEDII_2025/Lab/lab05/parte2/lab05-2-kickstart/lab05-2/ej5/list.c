#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "list.h"

#define MAX_LENGTH 100

struct _list
{
    elem elems[MAX_LENGTH];
    int size;
};

list empty()
{
    list l = malloc(sizeof(struct _list));
    l->size = 0; // Inicializar
    return l;
}
bool is_empty(list l)
{
    return (l->size == 0);
}

elem head(list l)
{
    assert(!is_empty(l));
    return l->elems[0];
}
list addl(elem e, list l)
{
    if (l->size < MAX_LENGTH)
    {
        for (int i = l->size; i > 0; i--)
        {
            l->elems[i] = l->elems[i - 1];
        }
        l->elems[0] = e;
        l->size++;
    }

    return l;
}

int length(list l)
{
    return l->size;
}

list tail(list l)
{
    assert(!is_empty(l));
    for (int i = 0; i < l->size; i++)
    {
        l->elems[i] = l->elems[i + 1];
    }
    l->size--;

    return l;
}
list addr(list l, elem e)
{
    if (l->size < MAX_LENGTH)
    {
        l->elems[l->size] = e;
        l->size++;
    }
    return l;
}
list concat(list l, list l0)
{
    int len = l->size + l0->size;
    if (!is_empty(l0))
    {
        for (int i = l->size, j = 0; i < len && j < l0->size; j++, i++)
        {
            l->elems[i] = l0->elems[j];
        }
    }
    l->size = len;
    return l;
}

elem index(list l, int n)
{
    if (n >= length(l))
    {
        fprintf(stderr, "Error: índice %d fuera de rango (largo = %d)\n", n, length(l));
        exit(1);
    }

    return l->elems[n];
}
list take(list l, int n)
{
    l->size = n;
    return l;
}
list drop(list l, int n)
{
    int i = 0;
    while (i < n)
    {
        l = tail(l);
        i++;
    }

    return l;
}

list copy_list(list l)
{
    list l1 = empty();
    for (int i = 0; i < length(l); i++)
    {
        l1->elems[i] = l->elems[i];
    }
    l1->size = l->size;

    return l1;
}

void destroy_list(list l)
{
    if (l != NULL)
    {
        free(l);
    }
}