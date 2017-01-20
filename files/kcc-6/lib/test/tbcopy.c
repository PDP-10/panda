/* Program to verify correctness of BCOPY, BZERO */

#define NPW (sizeof(int))	/* # bytes per word */
#define TSTLEN 50		/* # chars to test around */
#define BUFLEN 200
char *strini, *strbf2, *strbf3, *malloc();
int nerrs;
main(argc,argv)
int argc;
char *argv[];
{	register char *cp;
	register int i;
	register int soff, doff, loff;

	/* Set up initial strings */
	strbf2 = malloc(BUFLEN);
	strbf3 = malloc(BUFLEN);
	cp = strini = malloc(BUFLEN);
	for(i = 0; i < BUFLEN; ++i)
		*cp++ = '0' + i%10;

	nerrs = 0;
	printf("Checking out BZERO...\n");
	for(doff = 0; doff < NPW+1; ++doff)
	  for(loff = 0; loff < TSTLEN; ++loff)
		doztest(strbf2, strbf3, doff, loff);
	if(nerrs==0) printf("OK!\n");
	else printf("%d errors.\n", nerrs);

	nerrs = 0;
	printf("Checking out BCOPY...\n");
	for(soff = 0; soff < NPW+1; ++soff)
	  for(doff = 0; doff < NPW+1; ++doff)
	    for(loff = 0; loff < TSTLEN; ++loff)
		dotest(strini, strbf2, strbf3, soff, doff, loff);
	if(nerrs==0) printf("OK!\n");
	else printf("%d errors.\n", nerrs);

	nerrs = 0;
	printf("Checking out BCOPY overlap...\n");
	for(soff = 0; soff < NPW+1; ++soff)
	  for(doff = 0; doff < NPW+1; ++doff)
	    for(loff = 0; loff < TSTLEN; ++loff)
		dovtest(strini, strbf2, strbf3, soff, doff, loff);
	if(nerrs==0) printf("OK!\n");
	else printf("%d errors.\n", nerrs);
}

doztest(dst1, dst2, doff, len)
char *dst1, *dst2;
int doff, len;
{	register int i;
	register char *cp1, *cp2, *cps;
	
	i = BUFLEN;
	cp1 = dst1;
	cp2 = dst2;
	do {	*cp1++ = *cp2++ = 'x';
	  } while(--i);

	/* First zero canonical string */
	cp1 = dst1 + doff;
	if((i = len) > 0)
		do { *cp1++ = 0;
		  } while(--i);

	/* Now zero string using BZERO! */
	bzero(dst2+doff, len);

	/* Now compare the two strings */
	cp1 = dst1;
	cp2 = dst2;
	for(i = 0; i < BUFLEN; ++i)
		if(*cp1++ != *cp2++)
		  {	i = BUFLEN;
			cp1 = dst1;
			cp2 = dst2;
			do {
				if(*cp1==0) *cp1 = '.';
				if(*cp2==0) *cp2 = '.';
				++cp1, ++cp2;
			  } while(--i);

			printf("Bzero Err: doff %d, len %d\n",
				doff, len);
			printf("Str1: %-70.70s\n", dst1);
			printf("Str2: %-70.70s\n", dst2);
			++nerrs;
			break;
		  }
}

dotest(src, dst1, dst2, soff, doff, len)
char *src, *dst1, *dst2;
int soff, doff, len;
{	register int i;
	register char *cp1, *cp2, *cps;
	
	i = BUFLEN;
	cp1 = dst1;
	cp2 = dst2;
	do {	*cp1++ = *cp2++ = 'x';
	  } while(--i);

	/* First copy canonical string */
	cps = src + soff;
	cp1 = dst1 + doff;
	if((i = len) > 0)
		do { *cp1++ = *cps++;
		  } while(--i);

	/* Now copy string using BCOPY! */
	bcopy(src+soff, dst2+doff, len);

	/* Now compare the two strings */
	cp1 = dst1;
	cp2 = dst2;
	for(i = 0; i < BUFLEN; ++i)
		if(*cp1++ != *cp2++)
		  {	printf("Bcopy Err: soff %d, doff %d, len %d\n",
				soff, doff, len);
			printf("Str1: %-70.70s\n", dst1);
			printf("Str2: %-70.70s\n", dst2);
			++nerrs;
			break;
		  }
}

dovtest(src, dst1, dst2, soff, doff, len)
char *src, *dst1, *dst2;
int soff, doff, len;
{	register int i;
	register char *cp1, *cp2, *cps;
	
	i = BUFLEN;
	cps = src;
	cp1 = dst1;
	cp2 = dst2;
	do {	*cp1++ = (*cp2++ = *cps++);
	  } while(--i);

	/* First copy canonical string */
	cps = dst1 + soff;
	cp1 = dst1 + doff;
	if((i = len) > 0)
		do { *cp1++ = *cps++;
		  } while(--i);

	/* Now copy string using BCOPY! */
	bcopy(dst2+soff, dst2+doff, len);

	/* Now compare the two strings */
	cp1 = dst1;
	cp2 = dst2;
	for(i = 0; i < BUFLEN; ++i)
		if(*cp1++ != *cp2++)
		  {	printf("Bcopy Err: soff %d, doff %d, len %d\n",
				soff, doff, len);
			printf("Str1: %-70.70s\n", dst1);
			printf("Str2: %-70.70s\n", dst2);
			++nerrs;
			break;
		  }
}
