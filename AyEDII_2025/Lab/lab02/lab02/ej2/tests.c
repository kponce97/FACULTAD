#include <stdbool.h>
#include <stdio.h>
#include "cima.h"

#define MAX_LENGTH 11
#define N_TESTCASES_TIENE_CIMA 10
#define N_TESTCASES_CIMA 10

void test_tiene_cima(void);
void test_cima(void);

int main()
{
    test_tiene_cima();
    test_cima();

    return 0;
}

void test_tiene_cima(void)
{
    struct testcase
    {
        int a[MAX_LENGTH];
        int length;
        bool result;
    };

    struct testcase tests[N_TESTCASES_TIENE_CIMA] = {
        // Caso 1: Arreglo con un solo elemento
        {{8}, 1, true},

        // Caso 2: Arreglo estrictamente creciente
        {{1, 2, 3, 4, 5}, 5, true},

        // Caso 3: Arreglo estrictamente decreciente
        {{5, 4, 3, 2, 1}, 5, true},

        // Caso 4: Arreglo con una cima clara
        {{1, 3, 5, 4, 2}, 5, true},

        // Caso 5: Arreglo con más de una cima
        {{1, 2, 3, 2, 1, 3, 4}, 7, false},

        // Caso 6: Arreglo con cima al final
        {{1, 2, 3, 4, 3}, 5, true},

        // Caso 7: Arreglo con una cima y un solo valor descendente
        {{1, 2, 3, 2}, 4, true},

        // Caso 8: Arreglo con una cima, seguido de una secuencia constante
        {{1, 2, 3, 3, 3}, 5, false},

        // Caso 9: Arreglo con un valor repetido en la cima
        {{1, 3, 3, 2}, 4, false},

        // Caso 10: Arreglo con un máximo en el medio y luego decae
        {{1, 5, 2}, 3, true}};
    bool result;

    printf("\n\t----------------------\n\t| TESTING tiene_cima |\n\t----------------------\n");

    for (int i = 0; i < N_TESTCASES_TIENE_CIMA; i++)
    {
        printf("Test case %i: ", i + 1);

        result = tiene_cima(tests[i].a, tests[i].length);

        if (result != tests[i].result)
        {
            printf("FAILED\n");
        }
        else
        {
            printf("OK\n");
        }
    }
}

void test_cima(void)
{
    struct testcase
    {
        int a[MAX_LENGTH];
        int length;
        int result;
    };

    struct testcase tests[N_TESTCASES_CIMA] = {
        // 1 - Arreglo de un solo elemento
        {{8}, 1, 0},

        // 2 - Arreglo creciente
        {{1, 2, 3, 4, 5}, 5, 4},

        // 3 - Arreglo decreciente
        {{5, 4, 3, 2, 1}, 5, 0},

        // 4 - Cima clara en el medio (índice 2)
        {{1, 3, 5, 4, 2}, 5, 2},

        // 5 - Pico temprano (índice 1)
        {{1, 5, 3, 2}, 4, 1},

        // 6 - Cima al final
        {{1, 2, 3, 4}, 4, 3},

        // 7 - Cima justo antes del final (índice 2)
        {{1, 2, 5, 4}, 4, 2},

        // 8 - Arreglo 
        {{8}, 1, 0},

        // 9 - Arreglo con numeros grandes
        {{100, 1000, 10000, 2000, 500}, 5, 2},

        // 10 - Cima clara con longitud más larga (índice 5)
        {{1, 2, 4, 6, 8, 10, 9, 7, 5, 3}, 10, 5}};
    int result;

    printf("\n\t----------------\n\t| TESTING cima |\n\t----------------\n");

    for (int i = 0; i < N_TESTCASES_CIMA; i++)
    {
        printf("Test case %i: ", i + 1);

        result = cima(tests[i].a, tests[i].length);

        if (result == tests[i].result)
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED. got %d expected %d\n", result, tests[i].result);
        }
    }
}
