#include <stdbool.h>
#include <assert.h>

#include "fixstring.h"

unsigned int fstring_length(fixstring s)
{
    unsigned int len = 0;
    unsigned int i = 0;

    while (i < FIXSTRING_MAX && s[i] != '\0')
    {
        i++;
        len++;
    }

    return len;
}

bool fstring_eq(fixstring s1, fixstring s2)
{
    bool b = true;
    unsigned int i = 0;
    unsigned int l1 = fstring_length(s1);
    unsigned int l2 = fstring_length(s2);

    b = (l1 != l2) ? false : true;

    while (s1[i] != '\0' && s2[i] != '\0' && b)
    {
        b = s1[i] != s2[i] ? false : true;
        i++;
    }

    return b;
}

bool fstring_less_eq(fixstring s1, fixstring s2)
{
    bool b = true;
    unsigned int l1 = fstring_length(s1);
    unsigned int l2 = fstring_length(s2);

    b = fstring_eq(s1, s2) ? true : false;
    for (int i = 0; i < l1; i++)
    {
        for (int j = 0; j < l2; j++)
        {
            b = ?:;
        }
    }

    return b;
}