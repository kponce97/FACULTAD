#include <stdbool.h>
#include <stdio.h>
#include "list.h"

#define MAX_LENGTH 10
#define N_TESTCASES_TAIL 3
#define N_TESTCASES_ADDR 4
#define N_TESTCASES_TAKE 5
#define N_TESTCASES_DROP 4
#define N_TESTCASES_CONCAT 4

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

// chequea si dos listas son iguales
// (usa las funciones de listas length e index)
bool is_equal_to(list l1, list l2)
{
    int len1 = length(l1);
    int len2 = length(l2);
    int i = 0;
    while (i < len1 && i < len2 && index(l1, i) == index(l2, i))
    {
        i++;
    }
    return i == len1 && len1 == len2;
}

// Testeo de la función tail()
void test_tail()
{
    // representación de un solo caso de test
    struct tail_testcase
    {
        int a[MAX_LENGTH];      // elementos de la lista de entrada
        int length;             // largo de la lista de entrada
        int result[MAX_LENGTH]; // elementos esperados de la lista resultado
        int result_length;      // largo esperado de la lista resultado
    };

    // casos de test (uno por línea)
    struct tail_testcase tests[N_TESTCASES_TAIL] = {
        {{-2}, 1, {}, 0},            // testea: tail([-2]) == []
        {{1, -2}, 2, {-2}, 1},       // testea: tail([1, -2]) == [-2]
        {{8, 1, -2}, 3, {1, -2}, 2}, // testea: tail([8, 1, -2]) == [1, -2]
    };

    list input;
    list result, expected_result;

    printf("TESTING tail\n");

    for (int i = 0; i < N_TESTCASES_TAIL; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = tail(input);

        // creamos la lista resultado esperada
        expected_result = array_to_list(tests[i].result, tests[i].result_length);

        // comparamos resultado obtenido con resultado esperado
        if (is_equal_to(result, expected_result))
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED\n");
        }
    }
}

// Testeo de la función addr()
void test_addr()
{
    // representación de un solo caso de test
    struct addr_testcase
    {
        int a[MAX_LENGTH];      // elementos de la lista de entrada
        int length;             // largo de la lista de entrada
        elem e;                 // elemento a agregar
        int result[MAX_LENGTH]; // elementos esperados de la lista resultado
        int result_length;      // largo esperado de la lista resultado
    };

    // casos de test (uno por línea)
    struct addr_testcase tests[N_TESTCASES_ADDR] = {
        {{8, 1, -2}, 3, 44, {8, 1, -2, 44}, 4}, // testea: addr([8, 1, -2], 44) == [8, 1, -2, 44]
        {{1, -2}, 2, 44, {1, -2, 44}, 3},       // testea: addr([1, -2], 44) == [1, -2, 44]
        {{-2}, 1, 44, {-2, 44}, 2},             // testea: addr([-2], 44) == [-2, 44]
        {{}, 0, 44, {44}, 1},                   // testea: addr([], 44) == [44]
    };

    list input;
    list result, expected_result;

    printf("TESTING addr\n");

    for (int i = 0; i < N_TESTCASES_ADDR; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = addr(input, tests[i].e);

        // creamos la lista resultado esperada
        expected_result = array_to_list(tests[i].result, tests[i].result_length);

        // comparamos resultado obtenido con resultado esperado
        if (is_equal_to(result, expected_result))
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED\n");
        }
    }
}

// Testeo de la función take()
void test_take()
{
    // representación de un solo caso de test
    struct addr_testcase
    {
        int a[MAX_LENGTH];      // elementos de la lista de entrada
        int length;             // largo de la lista de entrada
        int n;                  // cantidad de elementos a tomar
        int result[MAX_LENGTH]; // elementos esperados de la lista resultado
        int result_length;      // largo esperado de la lista resultado
    };

    // casos de test (uno por línea)
    struct addr_testcase tests[N_TESTCASES_TAKE] = {
        {{8, 1, -2}, 3, 0, {}, 0},         // testea: take([8, 1, -2], 0) == []
        {{8, 1, -2}, 3, 1, {8}, 1},        // testea: take([8, 1, -2], 1) == [8]
        {{8, 1, -2}, 3, 2, {8, 1}, 2},     // testea: take([8, 1, -2], 2) == [8, 1]
        {{8, 1, -2}, 3, 3, {8, 1, -2}, 3}, // testea: take([8, 1, -2], 3) == [8, 1, -2]
        {{8, 1, -2}, 3, 4, {8, 1, -2}, 3}, // testea: take([8, 1, -2], 4) == [8, 1, -2]
    };

    list input;
    list result, expected_result;

    printf("TESTING take\n");

    for (int i = 0; i < N_TESTCASES_TAKE; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = take(input, tests[i].n);

        // creamos la lista resultado esperada
        expected_result = array_to_list(tests[i].result, tests[i].result_length);

        // comparamos resultado obtenido con resultado esperado
        if (is_equal_to(result, expected_result))
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED\n");
        }
    }
}
void test_drop()
{
    struct drop_testcase
    {
        int a[MAX_LENGTH];      // elementos de la lista de entrada
        int length;             // largo de la lista de entrada
        int n;                  // cantidad de elementos a tomar
        int result[MAX_LENGTH]; // elementos esperados de la lista resultado
        int result_length;      // largo esperado de la lista resultado
    };

    struct drop_testcase tests[N_TESTCASES_DROP] = {
        {{4, 9, 7, 33}, 4, 2, {7, 33}, 2},
        {{-4, -9, -7, -33}, 4, 2, {-7, -33}, 2},
        {{100, 99, 88, 77, 66, 55}, 6, 5, {55}, 1},
        {{1, 2, 3, 4, 5}, 5, 1, {2, 3, 4, 5}, 4},
    };
    list input;
    list result, expected_result;

    printf("TESTING drop\n");
    for (int i = 0; i < N_TESTCASES_DROP; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input = array_to_list(tests[i].a, tests[i].length);

        // TEST! llamamos la función a testear
        result = drop(input, tests[i].n);

        // creamos la lista resultado esperada
        expected_result = array_to_list(tests[i].result, tests[i].result_length);

        // comparamos resultado obtenido con resultado esperado
        if (is_equal_to(result, expected_result))
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED\n");
        }
    }
}
void test_concat()
{
    struct concat_testcase
    {
        int a1[MAX_LENGTH]; // elementos de la lista de entrada
        int length_a1;      // largo de la lista de entrada
        int a2[MAX_LENGTH]; // elementos de la lista de entrada
        int length_a2;      // largo de la lista de entrada

        int result[MAX_LENGTH]; // elementos esperados de la lista resultado
        int result_length;      // largo esperado de la lista resultado
    };

    struct concat_testcase tests[N_TESTCASES_CONCAT] =
        {
            {{1, 2}, 2, {3, 4}, 2, {1, 2, 3, 4}, 4},         // concat([1,2],[3,4]) = [1,2,3,4]
            {{-1, -2}, 2, {-3, -4}, 2, {-1, -2, -3, -4}, 4}, // concat([-1,-2],[-3,-4]) = [-1,-2,-3,-4]
            {{1}, 1, {3, 4}, 2, {1, 3, 4}, 3},               // concat([1],[3,4]) = [1,3,4]
            {{1, 2, 3, 4}, 4, {5}, 1, {1, 2, 3, 4, 5}, 5},   // concat([1,2,3,4],[5]) = [1,2,3,4,5]
        };
    list input_1, input_2;
    list result, expected_result;

    printf("TESTING concat\n");
    for (int i = 0; i < N_TESTCASES_CONCAT; i++)
    {
        printf("Test case %i: ", i + 1);

        // creamos la lista de entrada
        input_1 = array_to_list(tests[i].a1, tests[i].length_a1);
        input_2 = array_to_list(tests[i].a2, tests[i].length_a2);
        // imp_list(input_1);
        // imp_list(input_2);
        //  creamos la lista resultado esperada
        expected_result = array_to_list(tests[i].result, tests[i].result_length);

        // TEST! llamamos la función a testear
        result = concat(input_1, input_2);

        // comparamos resultado obtenido con resultado esperado
        if (is_equal_to(result, expected_result))
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED\n");
        }
    }
}
int main()
{
    test_tail();
    test_addr();
    test_take();
    test_drop();
    test_concat();
    return 0;
}
