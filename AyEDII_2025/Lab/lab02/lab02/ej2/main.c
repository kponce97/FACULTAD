#include <stdio.h>
#include <stdlib.h>
#include "cima.h"

int main(void)
{
    int a[] = {3, 8, 9, 5, 0};
    int length = 5;
    int result;

    if (tiene_cima(a, length))
    {
        result = cima(a, length);
        printf ("El arreglo tiene cima, en la posicion: %d\n", result);
        //printf("Resultado: %i\n", result);
    }else{
        printf("El arreglo no tiene Cima\n");
    }

    return EXIT_SUCCESS;
}
