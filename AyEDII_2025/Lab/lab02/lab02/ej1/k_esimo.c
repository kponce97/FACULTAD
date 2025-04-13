#include <stdbool.h>
#include <stdio.h>
#include "k_esimo.h"

// FUNCIONES INTERNAS DEL MÓDULO:
int partition(int a[], int izq, int der);
bool goes_before(int x, int y);
void swap(int a[], int i, int j);

void imp_arreglo(int a[], int length)
{
    printf("\n\tArreglo: [");
    for (int i = 0; i < length; i++)
    {
        printf("%d ", a[i]);
    }
    printf("]");
}
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
    int kae, lft = 0, rgt = length - 1, ppiv = partition(a, lft, rgt);
    bool b = false;
    while (lft <= rgt && !b)
    {
        if (ppiv == k)
        {
            kae = a[ppiv];
            b = true;
        }
        else if (ppiv < k)
        {
            ppiv = partition(a, ppiv + 1, rgt);
        }
        else
        {
            ppiv = partition(a, lft, rgt - 1);
        }
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
        if (goes_before(a[ppiv], a[i]) && goes_before(a[j], a[ppiv]))
        {
            swap(a, i, j);
            i++;
            j--;
        }
        else
        {
            if (goes_before(a[i], a[ppiv]))
            {
                i++;
            }
            else if (goes_before(a[ppiv], a[j]))
            {
                j--;
            }
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
