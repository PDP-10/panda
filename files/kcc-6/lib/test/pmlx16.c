#include <stdio.h>

int power = 16;

union dbl { int i[2]; double d; }
	x, tot;
int bit;
double saved;

void normalize(ad)
double *ad;
{
	asm(	"SETZB 1,2\n"
		"DFAD 1,@-1(17)\n"
		"DMOVEM 1,@-1(17)\n" );
}

main()
{
	int i;

	x.d = 1.0;
	bit = 26+35;

	while (bit >= 0) {
		/* Apply current bit downwards */
		saved = x.d;
		if (bit > 35)
			x.i[0] -= (1 << (bit-35));
		else {
			x.i[1] -= (1 << bit);
			if (x.i[1] < 0) {
				x.i[1] &= (~0U)>>1;
				x.i[0] -= 1;
			}
		}
		normalize(&x.d);

		/* See if new X is bad, back up if so */
		if (x.d <= 0) {
			x.d = saved;
			--bit;		/* Try smaller bit next time */
			continue;
		}
		/* Now test X */
		tot.d = x.d;
		for (i = power; --i > 0; ) {
			tot.d *= x.d;
			if (tot.d <= 0 || tot.d > x.d)
				break;		/* Over/underflowed, stop */
		}
		printf("Bit %d, X=%g, Res=%g %s\n", 
			bit, x.d, tot.d, (i ? "BARF" : "OK"));
		if (i) {	/* If prematurely stopped, */
			x.d = saved;	/* Restore previous value */
			--bit;		/* and use smaller increment */
		}
	}
	printf("Power %d done, X=%.20g  { %#o, %#o } \n",
			power, x.d, x.i[0], x.i[1]);
}
