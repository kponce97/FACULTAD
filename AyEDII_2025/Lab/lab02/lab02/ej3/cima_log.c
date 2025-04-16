#include <stdio.h>
#include <stdbool.h>
#include "cima_log.h"

/* Funcion que devuelve la cima posicion de un arreglo con cima (asumiendo que tiene cima) */
static int pos_cima(int a[], int lft, int rgt)
{
    int res;
    int mid = (lft + (rgt - 1)) / 2;
    res = (lft == rgt) ? lft : a[mid] < a[mid + 1] ? pos_cima(a, mid + 1, rgt)
                                                   : pos_cima(a, lft, mid);
    return res;
}
/**
 * @brief Dado un arreglo que tiene cima, devuelve la posición de la cima
 * usando la estrategia divide y venceras.
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
int cima_log(int a[], int length)
{
    int cima = pos_cima(a, 0, length);
    return cima;
}