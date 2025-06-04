#include <stdbool.h>
#include <stdio.h>
#include "list.h"

#define MAX_LENGTH 10
#define N_TESTCASES_HEAD 5
#define N_TESTCASES_INDEX 5
#define N_TESTCASES_LENGTH 6

// construye una lista a partir de un arreglo
// (usa los constructores de lista empty y addl)
list array_to_list(int array[], int length)
{
    list result;
    result = empty();

    // agregamos al revés ya que usamos addl
    for (int i = length; i > 0; i--)
    {
        result = addl(array[i - 1], result);
    }

    return result;
}

// Testeo de la función head()
void test_head()
{
    // representación de un solo caso de test
    struct head_testcase
    {
        int a[MAX_LENGTH]; // elementos de la lista de entrada
        int length;        // largo de la lista de entrada
        elem result;       // resultado esperado
    };

    // casos de test (uno por línea)
    struct head_testcase tests[N_TESTCASES_HEAD] = {
        {{-2}, 1, -2},         // testea: head([-2]) == -2
        {{1, -2}, 2, 1},       // testea: head([1, -2]) == 1
        {{8, 1, -2}, 3, 8},    // testea: head([8, 1, -2]) == 8
        {{99, 5, 8}, 3, 99},   // testea: head([99,5,8]) == 99    NUEVO
        {{-1, -2, -3}, 3, -1}, // testea: head([99,5,8]) == -1  NUEVO
    };

    list input;
    elem result;

    printf("TESTING head\n");

    for (int i = 0; i < N_TESTCASES_HEAD; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = head(input);

        // comparamos resultado obtenido con resultado esperado
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

// Testeo de la función index()
void test_index()
{
    // representación de un solo caso de test
    struct index_testcase
    {
        int a[MAX_LENGTH]; // elementos de la lista de entrada
        int length;        // largo de la lista de entrada
        int index;         // indice de entrada
        elem result;       // resultado esperado
    };

    // casos de test (uno por línea)
    struct index_testcase tests[N_TESTCASES_INDEX] = {
        {{8, 1, -2}, 3, 0, 8},                 // testea: index([8, 1, -2], 0) == 8
        {{8, 1, -2}, 3, 1, 1},                 // testea: index([8, 1, -2], 1) == 1
        {{8, 1, -2}, 3, 2, -2},                // testea: index([8, 1, -2], 2) == -2
        {{8, 1, -2, -4}, 4, 3, -4},            // testea: index([8, 1, -2,-4], 3) == -4   NUEVO
        {{10, 11, -12, 15, 19, 20}, 6, 5, 20}, // testea: index([10, 11, -12,15,19,20], 5) == 20   NUEVO
    };

    list input;
    elem result;

    printf("TESTING index\n");

    for (int i = 0; i < N_TESTCASES_INDEX; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = index(input, tests[i].index);

        // comparamos resultado obtenido con resultado esperado
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

// Testeo de la función length()
void test_length()
{
    // representación de un solo caso de test
    struct length_testcase
    {
        int a[MAX_LENGTH]; // elementos de la lista de entrada
        int length;        // largo de la lista de entrada
        // no hace falta campo resultado porque length es el resultado esperado
    };

    // casos de test (uno por línea)
    struct length_testcase tests[N_TESTCASES_LENGTH] = {
        {{}, 0},                       // testea: length([]) == 0
        {{-2}, 1},                     // testea: length([-2]) == 1
        {{1, -2}, 2},                  // testea: length([1, -2]) == 2
        {{8, 1, -2}, 3},               // testea: length([8, 1, -2]) == 3
        {{8, 1, -2, 2, 5, 77, 89}, 6}, // testea: length([8, 1, -2,2,5,77,89]) == 6 NUEVO
        {{4, 22, -22, 33}, 4},         // testea: length([4, 22, -22,33]) == 4 NUEVO
    };

    list input;
    elem result;

    printf("TESTING length\n");

    for (int i = 0; i < N_TESTCASES_LENGTH; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = length(input);

        // comparamos resultado obtenido con resultado esperado
        if (result == tests[i].length)
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED. got %d expected %d\n", result, tests[i].length);
        }
    }
}

int main()
{
    test_head();
    test_index();
    test_length();

    return 0;
}
