#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "data.h"

void print_data(data_t d)
{
    printf("NOMBRE: %s\n"
           "EDAD  : %d años\n"
           "ALTURA: %d cm\n\n",
           d.name, d.age, d.height);
}

int main(void)
{

    data_t *messi = malloc(sizeof(struct _s_data));
    messi->name = "Leo Messi";
    messi->age = 36;
    messi->height = 169;
    print_data(*messi);

    printf("name-size  : %lu bytes\n"
           "age-size   : %lu bytes\n"
           "height-size: %lu bytes\n"
           "data_t-size: %lu bytes\n\n",
           sizeof(messi->name),
           sizeof(messi->age),
           sizeof(messi->height),
           sizeof(messi->name) + sizeof(messi->age) + sizeof(messi->height));

    unsigned int *p = NULL;
    char * c = NULL;
    data_t *q = NULL;

    printf("Memory directions: \n");
    p = &messi->age;
    printf("name memory address  : %p\n", (void *)p);
    c = messi->name;
    printf("age memory address   : %p\n", (void *)c);
    p = &messi->height;
    printf("height memory address: %p\n", (void *)p);
    q = messi;
    printf("data_t memory address: %p\n\n", (void *)q);

    printf("Memory indexes: \n");
    p = &messi->age;
    printf("name memory address  : %lu\n", (uintptr_t)p);
    c = messi->name;
    printf("age memory address   : %lu\n", (uintptr_t)c);
    p = &messi->height;
    printf("height memory address: %lu\n", (uintptr_t)p);
    printf("data_t memory address: %lu\n", (uintptr_t)q);

    free(messi);
    return EXIT_SUCCESS;
}
