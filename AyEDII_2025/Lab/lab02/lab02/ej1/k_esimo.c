#include <stdbool.h>
#include <stdio.h>
#include "k_esimo.h"

// FUNCIONES INTERNAS DEL MÓDULO:
int partition(int a[], int izq, int der);
bool goes_before(int x, int y);
void swap(int a[], int i, int j);
/*
proc posDeOrdenado(in k : nat in/out a : array[1..n] of int out res : int)
    gen_posDeOrdenado(k, 1, n, a, res)
end proc
proc gen_posDeOrdenado(in k, lft, rgt : nat in/out a : array[1..n] of int out res : int)
    var ppiv : nat
    partition(a, lft, rgt, ppiv)
    if ppiv = k →
        res ≔ a[k]
    else if k < ppiv →
            gen_posDeOrdenado(k, lft, ppiv - 1, a, res)
        else
            gen_posDeOrdenado(k, ppiv + 1, a, res)
        fi
    fi
end proc
 */

/**
 * @brief K-esimo elemento mas chico del arreglo a.
 *
 * Devuelve el elemento del arreglo `a` que quedaría en la celda `a[k]` si el
 * arreglo estuviera ordenado. La función puede modificar el arreglo.
 * Dicho de otra forma, devuelve el k-esimo elemento mas chico del arreglo a.
 *
 * @param a Arreglo.
 * @param length Largo del arreglo.
 * @param k Posicion dentro del arreglo si estuviera ordenado.
 */
int k_esimo(int a[], int length, int k)
{
    int kae;
    int ppiv = partition(a, 0, length);
    printf("PPIV = %d\n", ppiv);

    if (ppiv == k)
    {
        kae = a[k];
    }

    /* Caso k < ppiv */
    else if (goes_before(k, ppiv))
    {
        kae = k_esimo(a,ppiv-1,k);
    }

    /* Caso k > ppiv */
    else if (goes_before(ppiv, k))
    {
        kae = k_esimo(a,);
    }

    return kae;
}

int partition(int a[], int izq, int der)
{
    int i, j, ppiv;
    ppiv = izq;
    i = izq + 1;
    j = der;
    while (i <= j)
    {
        if (goes_before(a[i], a[ppiv]))
        {
            i = i + 1;
        }
        else if (goes_before(a[ppiv], a[j]))
        {
            j = j - 1;
        }
        else
        {
            swap(a, i, j);
        }
    }

    swap(a, ppiv, j);
    ppiv = j;

    return ppiv;
}

bool goes_before(int x, int y)
{
    return x <= y;
}

void swap(int a[], int i, int j)
{
    int tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
}
