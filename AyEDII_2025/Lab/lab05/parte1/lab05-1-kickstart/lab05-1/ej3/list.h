#ifndef LIST_H_
#define LIST_H_

#include <stdbool.h>

typedef float list_elem;
typedef struct _node *list;

/*  crea una lista vacía. */
list empty_list();

/* agrega el elemento e al comienzo de la lista l. */
list addl(list_elem e, list l);

/*  Libera memoria en caso que sea necesario. */
list destroy(list l);

/* operations */
/*  Devuelve True si l es vacía. */
bool is_empty(list l);

/* Agrega al final de l todos los elementos de l0 en el mismo orden. */
list concat(list l, list l0);

/* Devuelve el primer elemento de la lista l */
list_elem head(list l);

/* PRE : not is_empty(l)  */
/* Devuelve el n - ésimo elemento de la lista l  */
list_elem index(list l, unsigned int n);

/* PRE : length(l) > n  */
/* Elimina el primer elemento de la lista l  */
list tail(list l);

/* PRE : not is_empty(l)   */
/* Deja en l sólo los primeros nelementos,eliminando el resto  */
void take(list l, unsigned int n);

/* Agrega el elemento e al final de la lista l. */
list addr(list l, list_elem e);

/* Elimina los primeros n elementos de l  */
list drop(list l, unsigned int n);

/* Devuelve la cantidad de elementos de la lista l  */
unsigned int length(list l);

/* Copia todos los elementos de l1 en la nueva lista l2 */
list copy_list(list l1);

#endif