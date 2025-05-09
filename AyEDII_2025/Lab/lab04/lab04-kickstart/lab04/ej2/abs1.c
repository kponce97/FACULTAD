#include <stdlib.h>
#include <stdio.h>
/*
proc absolute(in x : int, out y : int)
  if x >= 0 then
    y := x
  else
    y := -x
  fi
end proc
 */
void absolute(int x, int y)
{
    y = (x >= 0) ? x : -x;
}

int main(void)
{
    int a = -10, res = 0;
    absolute(a, res);
    printf("res: %d\n", res);

    return EXIT_SUCCESS;
}
/* Respuesta: El valor no coincide con el programa en el lenguaje del teorico, el rasultado es : 0  */