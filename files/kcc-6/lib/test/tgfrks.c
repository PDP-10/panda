#include "jsys.h"
#include "sys/usysig.h"

#define	MAP_SIZE 100

struct fork_map {
	unsigned parap : 18;
	unsigned infp : 18;
	unsigned supp : 18;
	unsigned handle : 18;
	unsigned status;
	};

/* Having this be static is gross but no other way to work in
** extended addressing, since the GFRKS% data cannot work
** in anything but current section.  We still attempt to use the
** stack whenever possible, to allow re-entrant code.
*/

struct fork_map fmap[MAP_SIZE];

main()
{
	int cnt, ablock[5];
	struct fork_map *sup, *fmp, *count();

	ablock[1] = _FHTOP;
	ablock[2] = 0;			/* TOPS-20 */
	fmp = fmap;
	ablock[3] = (-MAP_SIZE << 18) | ((unsigned) fmp & RH);

	if (jsys(GFRKS, ablock) <= 0) {
		printf("GFRKS failed??\n");
		return;
	}


	while (fmp->supp != 0)	/* find superior */
		fmp = (struct fork_map *) fmp->supp;

	/* Print out fork map */
	cnt = 0;
	fmprt(fmp, &cnt);

	sup = fmp;		/* save ptr to superior */
	cnt = 0;		/* initialize count */
	if (count(fmp, &cnt) == sup)	/* didn't find _FHSLF */
		printf("Didn't find self\n");
	else
	    printf("Current fork # is %d\n", cnt);
}

fmprt(fp, acnt)
struct fork_map *fp;
int *acnt;
{
	printf("Fork %2d: Par %2d, Inf %2d, Sup %2d, Handle %6o\n",
		(fp ? (fp-fmap)+1 : 0),
		(fp->parap ? (((struct fork_map *)fp->parap)-fmap)+1 : 0),
		(fp->infp  ? (((struct fork_map *)fp->infp) -fmap)+1 : 0),
		(fp->supp  ? (((struct fork_map *)fp->supp) -fmap)+1 : 0),
		fp->handle);
	if (fp->infp) fmprt(fp->infp);
	if (fp->parap) fmprt(fp->parap);
}

/*
 * Count fork map in preorder
 */
static struct fork_map *
count(ptr, cnt)
struct fork_map *ptr;
int *cnt;
{
	struct fork_map *sptr = 0;

	(*cnt)++;		/* count fork */
	if (ptr->handle == _FHSLF)
		return ptr;
	else {
		if (ptr->infp != 0)	/* does inferior exist (left) */
			sptr = count(ptr->infp, cnt);
		if (sptr == 0 && ptr->parap != 0) /* check for parallel */
			sptr = count(ptr->parap, cnt);
		return sptr;
		
	}
}

