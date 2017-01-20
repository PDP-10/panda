
#include <stdio.h>
int
main(argc,argv)
int argc;
char* argv[];
{
    FILE* fp;
    long k;
    long p;
    int c;
    char *fnam;

    if (argc >= 2)
	fnam = argv[1];
    else fnam = "SEEK.DAT";

    if((fp = fopen("SEEK.DAT","rb8")) == NULL) {
	fprintf(stderr,"Cannot open %s for binary 8-bit read\n", fnam);
	exit(1);
    }
    
    for (k = 0; k < 256; k += 15)
    {
	fseek(fp,k,0);
	c = getc(fp);
	ungetc(c,fp);
	p = ftell(fp);
	if (p != k)
		printf("ungetc() failure: fseek to %ld, ftell says %ld, byte = 0%o\n",
			k,p,c);
    }
    fclose(fp);
    return (0);
}
