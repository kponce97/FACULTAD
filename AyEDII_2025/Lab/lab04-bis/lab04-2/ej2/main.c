#include <stdio.h>
#include <stdlib.h>

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
    int length = 0;
    printf("Ingrese longitud: ");
    scanf("%d", &length);
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

    show_list(my_list);

    return 0;
}
