#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "list.h"
struct _node
{
	list_elem elem;
	struct _node *next;
};

list empty_list()
{
	list l = NULL;
	return l;
}

list addl(list_elem e, list l)
{
	list p = malloc(sizeof(list));
	p->elem = e;
	p->next = l;
	l = p;

	return l;
}
bool is_empty(list l)
{
	return (l == NULL);
}

list_elem head(list l)
{
	return l->elem;
}
list destroy(list l)
{
	list p = l;
	while (p != NULL)
	{
		list tmp = p;
		p = p->next;
		free(tmp);
	}
	p = NULL;
	l = p;

	return l;
}
list concat(list l1, list l2)
{
	list l = NULL;
	list_elem e;
	if (l1 == NULL && l2 == NULL)
		l = l1;
	else
	{
		l = l1;
		e = head(l);
		while (l->next != NULL)
		{
			l = l->next;
		}
		l->next = l2;
	}
	l = addl(e, l);
	return l;
}
unsigned int length(list l)
{
	unsigned int length = 0;
	list p = l;
	while (p != NULL)
	{
		length++;
		p = p->next;
	}
	return length;
}
list_elem index(list l, unsigned int n)
{
	assert(length(l) > n && "The position you are looking for doesn't exist.");
	unsigned int i = 0;
	list p = l;

	while (p != NULL && i < n)
	{
		p = p->next;
		i++;
	}
	return p->elem;
}

list tail(list l)
{
	assert(l != NULL);
	l = l->next;
	return l;
}

list addr(list l, list_elem e)
{
	list p = malloc(sizeof(struct _node));
	p->elem = e;
	p->next = NULL;
	if (!is_empty(l))
	{
		list q = l;
		while (q->next != NULL)
		{
			q = q->next;
		}
		q->next = p;
	}
	else
	{
		l = p;
	}

	return l;
}

/* PRE : not is_empty(l)   */
/* Deja en l sólo los primeros n elementos,eliminando el resto  */

void take(list l, unsigned int n)
{

	// Caso n == 0: eliminar toda la lista
	if (n == 0)
	{
		while (l != NULL)
		{
			list temp = l;
			l = l->next;
			free(temp);
		}
	}

	list curr = l;
	unsigned int k = 0;

	// Avanzar hasta el nodo n-1 (posición n-1)
	while (curr != NULL && k < n)
	{
		curr = curr->next;
		k++;
	}

	// Si hay nodos después del n-ésimo, eliminarlos
	if (curr != NULL && curr->next != NULL)
	{
		list to_delete = curr->next; // Apunto al sig del curr
		curr->next = NULL;

		while (to_delete != NULL)
		{
			list temp = to_delete;
			to_delete = to_delete->next;
			free(temp);
		}
	}
}
/* Elimina los primeros n elementos de l  */
list drop(list l, unsigned int n)
{
	list p = l;
	unsigned int i = 0;
	while (p != NULL && i < n)
	{
		list tmp = p;
		p = p->next;
		free(tmp);
		i++;
	}
	l = p;
	return l;
}

list copy_list(list l1)
{
	list p = l1;
	list l0 = NULL;

	while (p != NULL)
	{
		l0 = addr(l0, p->elem);
		p = p->next;
	}

	return l0;
}