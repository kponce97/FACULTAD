#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include "pair.h"

struct s_pair_t {
    elem fst;
    elem snd;
};

pair_t pair_new(elem x, elem y)
{
	pair_t p = malloc(sizeof(struct s_pair_t));
	p->fst = x;
	p->snd = y;

	return p;
}

elem pair_first(pair_t p)
{
	return p->fst;
}
elem pair_second(pair_t p)
{
	return p->snd;
}

pair_t pair_swapped(pair_t p)
{
	pair_t q = malloc(sizeof(struct s_pair_t));
	q->fst = p->snd;
	q->snd = p->fst;
	assert(pair_first(q) == pair_second(p) && pair_second(q) == pair_first(p));
	return q;
}

pair_t pair_copy(pair_t p)
{
	pair_t q = malloc(sizeof(struct s_pair_t));
	q->fst = p->fst;
	q->snd = p->snd;

	return q;
}

pair_t pair_destroy(pair_t p)
{
	free(p);
	p = NULL;
	return p;
}