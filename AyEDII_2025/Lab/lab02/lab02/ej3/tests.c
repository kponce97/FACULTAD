#include <stdbool.h>
#include <stdio.h>
#include "cima_log.h"

#define MAX_LENGTH 10
#define N_TESTCASES_CIMA 10

int main()
{
    struct testcase
    {
        int a[MAX_LENGTH];
        int length;
        int result;
    };

    struct testcase tests[N_TESTCASES_CIMA] =
        {
            {{8}, 1, 0},                // 1
            {{8, 2}, 2, 0},             // 2
            {{8, 80, 90, 89}, 4, 2},    // 3
            {{8, 9, 10, 11, 12}, 5, 4}, // 4
            {{8, 7, 6, 5, 4}, 5, 0},    // 5
            {{1, 8}, 2, 1},             // 6
            {{-2, 8, 9, 5, 0}, 5, 2}    // 7
        };
    int result;

    printf("TESTING cima\n");

    for (int i = 0; i < N_TESTCASES_CIMA; i++)
    {
        printf("Test case %i: ", i + 1);

        result = cima_log(tests[i].a, tests[i].length);

        if (result == tests[i].result)
        {
            printf("OK\n");
        }
        else
        {
            printf("FAILED. got %d expected %d\n", result, tests[i].result);
        }
    }

    return 0;
}
