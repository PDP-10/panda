/* Causes infinite loop in COS routine which ends in PDL overflow.
*/
#include "math.h"
int argw1 = 0576155700452;
int argw2 = 0356751347563;
union {
	int wd[2];
	double dbl;
} argd;

double cos();

main()
{
	double test;

	test = -HALFPI;
	printf("Result of cos(%g) = %g\n", test, cos(test));

	argd.wd[0] = argw1;
	argd.wd[1] = argw2;
	printf("Result of cos(%g) = %g\n",
		argd.dbl, cos(argd.dbl));
}
