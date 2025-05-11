#include <stdio.h>
#include "strfuncs.h"
/* char *string_filter(const char *str, char c)
{
	const char *p = NULL;
	p = str;
	char a[100];
	for (int i = 0; p[i] != '\0'; i++)
	{
		if (p[i] != c)
		{
			a[i] = p[i];
		}
	}
	str = &a;
	return str;
}
 */
void imprimir(const char *str)
{
	const char *p = str;
	for (int i = 0; *p != '\0'; i++)
	{
		if (*p != '.')
		{

			// printf("%c", *p); // imprime un carácter
		}
		p++;
	}
	printf("\n");
}

int main(void)
{
	char *some_str = "h.o.l.a m.u.n.d.o.!";
	char *some_symmetric = "abcba";
	(string_is_symmetric(some_symmetric))
		? printf("Es simetrica\n")
		: printf("No es Simetrica\n");

	printf("Antes -->\tFiltro: %s\n", some_str);
	printf("Despues -->\tFiltro: %s\n", string_filter(some_str, '.'));

	/*
	 * - "Messi" es una cadena literal (no se debe modificar).
	 * - nombre apunta al primer carácter 'M'.
	 */
	char *nombre = "M-e-s.s.i-";
	imprimir(nombre);
	return 0;
}
