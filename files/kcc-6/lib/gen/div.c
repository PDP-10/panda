/*
 *	DIV - compute quotient & remainder simultaneously
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.2, 28-Aug-1987
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <c-env.h>
#include <stdlib.h>

div_t div(n, d)
int n, d;
{
#if CPU_PDP10
    asm("move 1,-1(17)\n");	/* Get n */
    asm("idiv 1,-2(17)\n");	/* Divide by d. Quot in AC1, rem in AC2 */
#else
    div_t result;

    result.quot = n / d;
    result.rem  = n % d;
    return result;
#endif
}

ldiv_t ldiv(n, d)
long n, d;
{
#if CPU_PDP10
    asm("move 1,-1(17)\n");	/* Get n */
    asm("idiv 1,-2(17)\n");	/* Divide by d. Quot in AC1, rem in AC2 */
#else
    ldiv_t result;

    result.quot = n / d;
    result.rem  = n % d;
    return result;
#endif
}
