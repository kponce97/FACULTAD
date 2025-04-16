#include <stdio.h>
#include <stdbool.h>
#include "cima.h"

/**
 * @brief Indica si el arreglo tiene cima.
 *
 * Un arreglo tiene cima si existe una posición k tal que el arreglo es
 * estrictamente creciente hasta la posición k y estrictamente decreciente
 * desde la posición k.
 *
 * @param a Arreglo.
 * @param length Largo del arreglo.
 */
bool tiene_cima(int a[], int length)
{
    bool b1 = true;
    int i = 0;
    if (length == 1)
    {
        b1 = true;
    }
    else
    {
        while (i < length && a[i] < a[i + 1])
        {
            i++;
        }
        while (i < length && b1)
        {
            b1 = a[i] > a[i + 1];
            i++;
        }
    }
    return b1;
}
static bool es_decreciente(int a[], int length)
{
    bool b = true;

    int i = 0;
    while (i < length && b)
    {
        b = a[i] > a[i + 1] ? true : false;
        i++;
    }

    return b;
}
/**
 * @brief Dado un arreglo que tiene cima, devuelve la posición de la cima.
 *
 * Un arreglo tiene cima si existe una posición k tal que el arreglo es
 * estrictamente creciente hasta la posición k y estrictamente decreciente
 * desde la posición k.
 * La cima es el elemento que se encuentra en la posición k.
 * PRECONDICION: tiene_cima(a, length)
 *
 * @param a Arreglo.
 * @param length Largo del arreglo.
 */
int cima(int a[], int length)
{
    int cima_, k = 0, pos_cima;
    bool b = true;

    if (!es_decreciente(a, length))
    {
        if (tiene_cima(a, length) && length > 1)
        {
            while (k < length && a[k] < a[k + 1] && b)
            {
                k++;
                if (a[k] > a[k + 1])
                {
                    b = false;
                    pos_cima = k;
                }
            }
            cima_ = pos_cima;
        }
        else
        {
            cima_ = k;
        }
    }
    else
    {
        cima_ = 0;
    }

    return cima_;
}
