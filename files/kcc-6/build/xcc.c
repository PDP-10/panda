/* XCC - Hack to provide cross-compiler on T20 */

#ifndef TGSYS
#define TGSYS syst10
#endif

#include <stdio.h>

struct tgsys {
	char *ccname;
	char *sws[20];
};

struct tgsys syst10 = {
	"XCCT10",
    {	"XCCT10",		/* Fake program name */
	"-x=ks+kl0+tops10",	/* Compile for KS, KL (0-sect) and TOPS-10 */
	"-DCPU_KL0=1",		/* C-ENV def: KL-10 single-sect CPU */
	"-DSYS_T10=1",		/* C-ENV def: TOPS-10 */
	"-HCT10:",		/* #include <> primary location */
	"-LCT10:LIB+.REL",	/* Library locations: CT10:LIBc.REL */
	0
    }
};

struct tgsys syswaits = {
	"XCCWTS",
    {	"XCCWTS",		/* Fake program name */
	"-x=kl0+waits",		/* Compile for KL (0-sect) and WAITS */
	"-DCPU_KL0=1",		/* C-ENV def: KL-10 single-sect CPU */
	"-DSYS_WAITS=1",	/* C-ENV def: WAITS (obsolete) */
	"-DSYS_WTS=1",		/* C-ENV def: WAITS */
	"-HCWTS:",		/* #include <> primary location */
	"-LCWTS:LIB+.REL",	/* Library locations; CWTS:LIBC.REL */
	0
    }
};

struct tgsys sys10x = {
	"XCC10X",
    {	"XCC10X",		/* Fake program name */
	"-x=ka+tenex",		/* Compile for KA-10 and TENEX */
	"-DCPU_KA=1",		/* C-ENV def: KA-10 CPU */
	"-DSYS_10X=1",		/* C-ENV def: TENEX */
	"-HC10X:",		/* #include <> location */
	"-LC10X:LIB+.REL",	/* Library locations; C10X:LIBC.REL */
	0
    }
};

struct tgsys *sys = &TGSYS;

main(argc,argv)
int argc;
char **argv;
{	char **newv, **nv;
	char **sws;
	int pid;

	if(argc < 2)
	  {	fprintf(stderr,"%s: Use like CC.  See C:CC.DOC for info.\n",
			sys->ccname);
		exit(0);
	  }
	nv = newv = (char **)calloc(argc+6, sizeof(char *));
	if(!newv)
	  {	fprintf(stderr, "%s: cannot allocate arg space.\n", sys->ccname);
		exit(0);
	  }
	for (sws = sys->sws; *sws != NULL;)
	    *nv++ = *sws++;		/* Start with special sys switches */
	while(--argc > 0)		/* Add user's args */
		*nv++ = *++argv;
	*nv = 0;

#ifdef COMMENT
	if(!setlnm("C","PS:<KCC.TENEX>,C:"))
	  {	perror("TCC: Could not set C: logical name");
		exit(0);
	  }
	if((pid = fork())==0)
	  {
#endif /* COMMENT */
		execv("SYS:CC.EXE", newv);	/* Invoke it! */
		perror("Could not invoke CC");
#ifdef COMMENT
		exit(0);
	  }
	wait(0);		/* Wait for compilation to terminate */
	if(!setlnm("C", (char *)0))
	  {	perror("TCC: Could not reset C: logical name");
		exit(0);
	  }
#endif /* COMMENT */
}

#ifdef COMMENT
/* Set job-wide logical name */
setlnm(name, def)
char *name,*def;
{	int acs[5], ret;
	if(def)
	  {	acs[1] = 4;	/* .CLNJB */
		acs[2] = (int)(name-1);
		acs[3] = (int)(def-1);
		ret = jsys(0502, acs);	/* CRLNM */
		return(ret > 0 ? 1 : 0);
	  }
	acs[1] = 0;	/* .CLNJ1 */
	acs[2] = (int)(name-1);
	ret = jsys(0502, acs);	/* CRLNM */
	return(ret > 0 ? 1 : 0);
}
#endif /* COMMENT */

#ifdef COMMENT
/* Save current definition of C: for restoring later */
char *dirnam = "C";
char dirdef[200];
int dirflg = 0;
savecdir()
{	int acs[5];
	int ret;
	acs[1] = 0;	/* .LNSJB */
	acs[2] = (int)(dirnam-1);
	acs[3] = (int)(dirdef-1);
	ret = jsys(0504,acs);	/* LNMST */
	if(ret > 0) dirflg++;
}

/* Restore old definition of C: */
restcdir()
{	int acs[5];
	if(!dirflg) return;
	acs[1] = 0;
}
#endif /* COMMENT */
