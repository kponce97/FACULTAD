/* proc swap(in/out a : int, in/out b : int)
var aux : int
aux := a
	a := b
	b := aux
	end proc*/
/*
fun main() ret r : int
  var x, y : int
  x := 6
  y := 4
  print(x, y)
  swap(x, y)
  print(x, y)
  r := 0
end fun
 */
#include <stdio.h>
#include <stdlib.h>
void swap(int *a, int *b)
{
	int temp = *a; // Guarda el valor de la dirección apuntada por a (es decir, el valor original de la primera variable)
				   // Ejemplo: si a apunta a x (x = 10), entonces temp = 10

	*a = *b; // Copia el valor de la dirección apuntada por b en la dirección apuntada por a
			 // Si b apunta a y (y = 20), entonces ahora x = 20

	*b = temp; // Copia el valor original de x (guardado en temp) en la dirección apuntada por b
			   // Ahora y = 10 → se completa el intercambio
}

int main()
{
	int x = 6, y = 4;
	printf("x: %d \t y:%d\n", x, y);
	swap(&x, &y);
	printf("Swap\t-->\tx: %d \t y:%d\n", x, y);

	return EXIT_SUCCESS;
}
