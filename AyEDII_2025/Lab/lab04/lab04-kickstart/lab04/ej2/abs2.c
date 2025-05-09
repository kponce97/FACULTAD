#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

/*
proc absolute(in x : int, out y : int)
  if x >= 0 then
    y := x
  else
    y := -x
  fi
end proc
 */
// Guarda el valor absoluto de x en la dirección de memoria apuntada por y.
void absolute(int x, int *y)
{
    *y = (x >= 0) ? x : -x;
}

int main(void)
{
    int a = -10, res = 0; // No modificar esta declaración
    // --- No se deben declarar variables nuevas ---
    absolute(a, &res);
    printf("res: %i\n", res);

    assert(res >= 0 && (res == a || res == -a));
    return EXIT_SUCCESS;
}

/*
    Respuesta: Es de tipo out. La función no lee el valor apuntado por y, solo escribe en esa dirección.
               y sirve para devolver un resultado, no para recibir datos.
*/