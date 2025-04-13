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
    b = (fstring_length(s1) != fstring_length(s2)) ? false : true;
    while (s1[i] != '\0' && s2[i] != '\0' && b)
    {
        b = s1[i] != s2[i] ? false : true;
        i++;
    }
    return b;
}

bool fstring_less_eq(fixstring s1, fixstring s2)
{
    bool result;
    unsigned int min_length = fstring_length(s1) < fstring_length(s2) ? fstring_length(s1) : fstring_length(s2);
    unsigned int i = 0;
    while (i < min_length && s1[i] == s2[i])
    {
        i = i + 1;
    }
    result = (i == min_length) ? fstring_length(s1) <= fstring_length(s2) : s1[i] <= s2[i];

    return result;

}

void fstring_set(fixstring s1, const fixstring s2)
{
    int i = 0;
    while (i < FIXSTRING_MAX && s2[i] != '\0')
    {
        s1[i] = s2[i];
        i++;
    }
    s1[i] = '\0';
}

void fstring_swap(fixstring s1, fixstring s2)
{
    fixstring aux;
    fstring_set(aux, )
}
