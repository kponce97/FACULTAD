#include <stdlib.h> /* EXIT_SUCCESS... */
#include <stdio.h>  /* printf()...     */
#include "pair.h"   /* TAD Par         */

static void show_pair(pair_t p)
{
    // Usamos las funciones disponibles en el .h para acceder a el primer y segundo elemento del par.
    printf("(%d, %d)\n", pair_first(p), pair_second(p));
}

int main(void)
{
    pair_t p, q;
    // Nuevo par p
    p = pair_new(3, 4);
    // Se muestra el par por pantalla
    printf("p = ");
    show_pair(p);
    // Nuevo para q con elementos de p intercambiados
    q = pair_swapped(p);
    // Se muestra q
    printf("q = ");
    show_pair(q);
    // Se destruyen p y q
    p = pair_destroy(p);
    q = pair_destroy(q);
    return EXIT_SUCCESS;
}
/*
 * Ahora si logramos el encapsulamiento, ya que la estructura esta
 * en el .c y no es accecibla para el usuario, solo esta disponible
 * en el .h (que accedemos mediante un puntero) , y luego usamos en
 * main lo que el TAD nos da como funciones y procemientos.
 */