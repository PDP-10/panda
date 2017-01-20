/* TTIME - Test library Time routines.
*/

#include <time.h>		/* For library */
#include <sys/time.h>		/* For system calls */
#include <sys/timeb.h>		/* For ftime syscall */
#include <stdio.h>

time_t curtim, nxttim;	/* for time() */
struct timeb tmb;	/* for ftime() */
struct timeval tv;	/* for gettimeofday() */
struct timezone tz;	/* for gettimeofday() */

int listflg = 0;	/* 1 to print time values for 10 years, 1/hour */
int listdflg = 0;	/* Ditto for 1/day */

main(argc, argv)
int argc;
char **argv;
{
	if (argc >= 2 && argv[1][0] == 'l')
		listdflg++;
	if (argc >= 2 && argv[1][0] == 'L')
		listflg++;

	if (listflg)
	  {	plist();
		return;
	  }
	else if (listdflg)
	  {	pdlist();
		return;
	  }
	curtim = time(&nxttim);
	if (curtim != nxttim)
		printf("time() retval doesn't match arg ptr retval\n");
	nxttim = time((time_t)0);	/* Just checking */
	printf("time() = %lo sec\n", curtim);

	if (ftime(&tmb) != 0)
		printf("ftime() failed.\n");
	printf("ftime()        => time %lo sec, %o ms, %o tzone, %o dstt\n",
		tmb.time, tmb.millitm, tmb.timezone, tmb.dstflag);

	if (gettimeofday(&tv, &tz) != 0)
		printf("gettimeofday() failed.\n");
	printf("gettimeofday() => time %lo sec, %o us, %o tzone, %o dstt\n",
		tv.tv_sec, tv.tv_usec, tz.tz_minuteswest, tz.tz_dsttime);

	printf("  ctime(&curtim)            => \"%s\"\n", ctime(&curtim));

	printf("asctime(localtime(&curtim)) => \"%s\"\n",
				asctime(localtime(&curtim)));

	printf("asctime(gmtime(&curtim))    => \"%s\"\n",
				asctime(gmtime(&curtim)));

}

plist()
{
	time_t tval = 0;
	struct tm *tp;
	int i;

	for (i = 24*366*10; --i > 0; tval += 60*60)
	  {	tp = localtime(&tval);
		printf("%d: %s", tp->tm_yday, ctime(&tval));
	  }
}

pdlist()
{
	time_t tval = 12*60*60;
	struct tm *tp;
	int i;

	for (i = 366*30; --i > 0; tval += 60*60*24)
	  {	tp = localtime(&tval);
		printf("%d: %s", tp->tm_yday, ctime(&tval));
	  }
}