#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct Node
{
    int data;
    struct Node *next;
} Node;

typedef Node *List;

/**
 * @brief Construye y devuelve una lista de ejemplo de 3 elementos
 */
List setup_example()
{
    int length = 3;
    length--;
    List lista = NULL;
    lista = malloc(sizeof(List) * length);
    if (lista == NULL)
    {
        printf("Error invalid reserved");
        exit(EXIT_FAILURE);
    }
    Node *p = NULL;
    p = lista;
    while (length > 0)
    {

        p->data = length * 10;
        p->next = malloc(sizeof(struct Node));
        p = p->next;
        length--;
    }
    p->data = 0;
    p->next = NULL;

    return lista;
}

/**
 * @brief Agrega un elemento de ejemplo al final de la lista
 *
 * Precondicion: la lista xs no debe ser vacía
 */
void append_example(List xs)
{
    // Me aseguro de que no sea vacia la lista.
    assert(xs != NULL);
    // Creo y reservo memoria para el nuevo nodo y lo cargo con su datos.
    Node *new_nodo = malloc(sizeof(struct Node));
    new_nodo->data = 88;
    new_nodo->next = NULL;

    Node *p = NULL; // Uso para recorrer la lista
    p = xs;
    while (p->next != NULL) // Recorro hasta el ultimo elemento
    {
        p = p->next;
    }
    // El ultimo nodo de la lista ahora es 'new_node' (new_node->next = NULL)
    p->next = new_nodo;
}

void show_list(List xs)
{
    printf("[ ");
    while (xs != NULL)
    {
        printf("%i, ", xs->data);
        xs = xs->next;
    }
    printf("]\n");
}

int main(void)
{
    List my_list;

    my_list = setup_example();

    printf("Lista antes del append: ");

    show_list(my_list);

    append_example(my_list);

    printf("Lista después del append: ");

    show_list(my_list);

    return 0;
}
