#include <stdbool.h>
#include <stdio.h>
#include "k_esimo.h"

#define MAX_LENGTH 5
#define N_TESTCASES 10

struct testcase
{
    int a[MAX_LENGTH];
    int length;
    int k;
    int result;
};

int main()
{
    struct testcase tests[N_TESTCASES] = {
        // arreglo, largo, k, resultado esperado
        // 1) arreglo de un elemento (k=0 obligatoriamente)
        {{8}, 1, 0, 8},

        // 2) arreglo de dos elementos ordenados, con k=0
        {{3, 5}, 2, 0, 3},

        // 3) arreglo de dos elementos ordenados, con k=1
        {{3, 5}, 2, 1, 5},

        // 4) arreglo de dos elementos desordenados, con k=0
        {{9, 2}, 2, 0, 9},

        // 5) arreglo de dos elementos desordenados, con k=1
        {{9, 2}, 2, 1, 2},

        // 6-10) arreglo {8, -2, 9, 0, 13} con todos los k posibles:
        {{8, -2, 9, 0, 13}, 5, 0, 8},
        {{8, -2, 9, 0, 13}, 5, 1, -2},
        {{8, -2, 9, 0, 13}, 5, 2, 9},
        {{8, -2, 9, 0, 13}, 5, 3, 0},
        {{8, -2, 9, 0, 13}, 5, 4, 13},
    };

    int result;

    printf("\t\t[---TESTING k_esimo---]\n\n");

    for (int i = 0; i < N_TESTCASES; i++)
    {
        printf("\n-----------------------------------\nTest case %i: ", i + 1);

        result = k_esimo(tests[i].a, tests[i].length, tests[i].k);
        if (result == tests[i].result)
        {
            printf("\t\t[---OK---]");
            printf("\n\t[%d ==  %d]\n\tlength = %d ", result, tests[i].result, tests[i].length);
            imp_arreglo(tests[i].a, tests[i].length);
        }
        else
        {
            printf("\t\t[---FAILED---]");
            printf("\n\t[%d !=  %d] \n\tlength = %d\n\tk = %d", result, tests[i].result, tests[i].length, tests[i].k);
            imp_arreglo(tests[i].a, tests[i].length);
            printf("\n-----------------------------------\n");
        }
        if (i == N_TESTCASES - 1)
        {
            printf("\n");
        }
    }

    return 0;
}
