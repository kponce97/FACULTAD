#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define ARRAY_SIZE 4

struct bound_data
{
    bool is_upperbound;
    bool is_lowerbound;
    bool exists;
    unsigned int where;
};

struct bound_data check_bound(int value, int arr[], unsigned int length)
{
    struct bound_data res;
    unsigned int i = 0;
    res.is_upperbound = true;
    for (i = 0; i < length; i++)
    {
        if (arr[i] > value)
        {
            res.is_upperbound = false;
        }
        if (arr[i] == value)
        {
            res.exists = true;
            res.where = i;
        }
    }
    for (i = 0; i < length; i++)
    {
        if (arr[i] < value)
        {
            res.is_lowerbound = false;
        }
    }

    return res;
}

int main(void)
{
    int a[ARRAY_SIZE]; // 0, -1, 9, 4
    int value;
    printf("\n------------------------\n");
    printf("Value: ");
    scanf("%d", &value);
    for (unsigned int i = 0; i < ARRAY_SIZE; i++)
    {
        printf("Ingrese elemento: ");
        scanf("%d", &a[i]);
    }

    struct bound_data result = check_bound(value, a, ARRAY_SIZE);
    printf("\n------------------------\n");
    // TODO: REEMPLAZAR LO SIGUIENTE LUEGO POR LA SALIDA QUE PIDE EL ENUNCIADO
    if(result.is_upperbound){
        printf("El valor %d es Cota Superior\n",value);
        if(result.exists){
            printf("Y es Maximo\n");
        }
    }
    else if(result.is_lowerbound){
        printf("El valor %d es Cota Inferior\n",value);
        if(result.exists){
            printf("Y es Minimo\n");
        }
    }

/* 
    printf("%d \n", result.is_upperbound); // Imprime 1
    printf("%d \n", result.is_lowerbound); // Imprime 0
    printf("%u \n", result.exists);        // Imprime 1
    printf("%u \n", result.where);         // Imprime 2
 */
    return EXIT_SUCCESS;
}
