/*	This file contains a miscellany of functions for LOGO, both
 * primary implementation of LOGO operations and commands, and also various
 * other functions for maintaining the overhead of the interpreter (variable
 * storage, function calls, etc.)
 *
 *	Copyright (C) 1979, The Children's Museum, Boston, Mass.
 *	Written by Douglas B. Klunder
 */

#include "logo.h"
#include <sgtty.h>
#include <setjmp.h>
extern jmp_buf yerrbuf;
int tvec[2] ={0,0};
extern int yychar,yylval,yyline;
extern int topf,errtold,flagquit;
extern FILE *ofile;
extern char *ostring;
extern char *getbpt;
extern char charib;
extern int pflag,letflag;
extern int currtest;
struct runblock *thisrun = NULL;
extern struct plist *pcell;	/* for PAUSE */
extern struct stkframe *fbr;
extern t20save();
extern t20restore();
#ifdef PAUSE
extern int pauselev,psigflag;
#endif

tyobj(text)
register struct object *text;
{
	register struct object *temp;
	char str[30];

	if (text==0) return;
	switch (text->obtype) {
		case CONS:
			for (temp = text; temp; temp = temp->obcdr) {
				fty1(temp->obcar);
				if(temp->obcdr) putc1(' ');
			}
			break;
		case STRING:
			sputs(text->obstr);
			break;
		case INT:
			sprintf(str,FIXFMT,text->obint);
			sputs(str);
			break;
		case DUB:
			sprintf(str,"%g",text->obdub);
			if (!index(str,'.')) strcat(str,".0");
			sputs(str);
			break;
	}
}

fty1(text)
register struct object *text;
{
	if (listp(text)) {
		putc1('[');
		tyobj(text);
		putc1(']');
	} else tyobj(text);
}

fillbuf(text)	/* Logo TYPE */
register struct object *text;
{
	tyobj(text);
	mfree(text);
}

struct object *cmprint(arg)
struct object *arg;
{
	fillbuf(arg);
	putchar('\n');
	return ((struct object *)(-1));
}

struct object *cmtype(arg)
struct object *arg;
{
	fillbuf(arg);
	return ((struct object *)(-1));
}

struct object *cmfprint(arg)
struct object *arg;
{
	fty1(arg);
	putchar('\n');
	mfree(arg);
	return ((struct object *)(-1));
}

struct object *cmftype(arg)
struct object *arg;
{
	fty1(arg);
	mfree(arg);
	return ((struct object *)(-1));
}

setfile(file)
register struct object *file;
{
	file = numconv(file,"File command");
	if (!intp(file)) ungood("File command",file);
	ofile = (FILE *)((int)(file->obint));
	mfree(file);
}

fileprint(file,text)
register struct object *file,*text;
{
	setfile(file);
	fillbuf(text);
	fputc('\n',ofile);
	ofile = NULL;
}

filefprint(file,text)
register struct object *file,*text;
{
	setfile(file);
	fty1(text);
	mfree(text);
	fputc('\n',ofile);
	ofile = NULL;
}

filetype(file,text)
register struct object *file,*text;
{
	setfile(file);
	fillbuf(text);
	ofile = NULL;
}

fileftype(file,text)
struct object *file,*text;
{
	setfile(file);
	fty1(text);
	mfree(text);
	ofile = NULL;
}

struct object *openfile(name,type)
register struct object *name;
register char *type;
{
	FILE *fildes;

	if (!stringp(name)) ungood("Open file",name);
	fildes = fopen(name->obstr,type);
	if (!fildes) {
		pf1("Can't open file %l.\n",name);
		errhand();
	}
	mfree(name);
	return(localize(objint((FIXNUM)((int)fildes))));
}

struct object *loread(arg)
struct object *arg;
{
	return(openfile(arg,"r"));
}

struct object *lowrite(arg)
struct object *arg;
{
	return(openfile(arg,"w"));
}

struct object *callunix(cmd)
register struct object *cmd;
{
	register struct object *str;

	str = stringform(cmd);
	t20save();
	system(str->obstr);
	t20restore();
	mfree(str);
	mfree(cmd);
	return ((struct object *)(-1));
}

struct object *fileclose(file)
register struct object *file;
{
	setfile(file);
	fclose(ofile);
	ofile = NULL;
	return ((struct object *)(-1));
}

struct object *fileread(file,how)
register struct object *file;
int how; /* 0 for fileread (returns list), 1 for fileword (returns str) */
{
	char str[200];
	register struct object *x;
	char *svgbpt;
	char c;
	int i;	/* losing twenex pcc */

	setfile(file);
	fgets(str,200,ofile);
	if (feof(ofile)) {
		ofile = NULL;
		if (how) return((struct object *)0);
		return(localize(objcpstr("")));
	}
	ofile = NULL;
	i = strlen(str)-1;
	if (how) {
		str[i] = '\0';
		return(localize(objcpstr(str)));
	}
	str[i] = ']';
	c = charib;
	charib = 0;
	svgbpt = getbpt;
	getbpt = str;
	x = makelist();
	getbpt = svgbpt;
	charib = c;
	return(x);
}

struct object *lfread(arg)
struct object *arg;
{
	return(fileread(arg,0));
}

struct object *lfword(arg)
struct object *arg;
{
	return(fileread(arg,1));
}

struct object *lsleep(tim)	/* wait */
register struct object *tim;
{
	int itim;

	tim = numconv(tim,"Wait");
	if (intp(tim)) itim = tim->obint;
	else itim = tim->obdub;
	mfree(tim);
	sleep(itim);
	return ((struct object *)(-1));
}

struct object *input(flag)
int flag;	/* 0 for readlist, 1 for request */
{
	int len;
	char s[512];
	register struct object *x;
	char *svgbpt;
	char c;

	if (flag) putchar('?');
	fflush(stdout);
	len = read(0,s,512);
	if (len <= 0) len = 1;
	s[len-1]=']';
	c = charib;
	charib = 0;
	svgbpt = getbpt;
	getbpt = s;
	x = makelist();
	getbpt = svgbpt;
	charib = c;
	return (x);
}

struct object *readlist() {
	return(input(0));
}

struct object *request() {
	return(input(1));
}

struct object *ltime()		/* LOGO time */
{
	char ctim[50];
	register struct object *x;
	char *svgbpt;
	char c;
	int i;	/* losing twenex pcc */

	time(tvec);
	strcpy(ctim,ctime(tvec));
	i = strlen(ctim)-1;
	ctim[i]=']';
	c = charib;
	charib = 0;
	svgbpt = getbpt;
	getbpt = ctim;
	x = makelist();
	getbpt = svgbpt;
	charib = c;
	return(x);
}

dorun(arg,num)
struct object *arg;
FIXNUM num;
{
	register struct object *str;
	register struct runblock *rtemp;

	rtemp = (struct runblock *)ckmalloc(sizeof(struct runblock));
	if (num != 0) {
		rtemp->rcount = num;
		rtemp->rupcount = 0;
	} else {
		rtemp->rcount = 1;	/* run or if, not repeat */
 		if (thisrun)
 			rtemp->rupcount = thisrun->rupcount - 1;
 		else
 			rtemp->rupcount = 0;
	}
	rtemp->roldyyc = yychar;
	rtemp->roldyyl = yylval;
	rtemp->roldline = yyline;
	rtemp->svbpt = getbpt;
	rtemp->svpflag = pflag;
	rtemp->svletflag = letflag;
	rtemp->svch = charib;
	if (arg == (struct object *)(-1)) {	/* PAUSE */
		rtemp->str = (struct object *)(-1);
	} else {
		str = stringform(arg);
		mfree(arg);
		strcat(str->obstr,"\n");
		rtemp->str = globcopy(str);
		mfree(str);
	}
	rtemp->rprev = thisrun;
	thisrun = rtemp;
	rerun();
}

rerun() {
	yychar = -1;
	pflag = 0;
	letflag = 0;
	charib = '\0';
	thisrun->rupcount++;
	if (thisrun->str == (struct object *)(-1))	/* PAUSE */
		getbpt = 0;
	else
		getbpt = thisrun->str->obstr;
}

unrun() {
	register struct runblock *rtemp;

	yychar = thisrun->roldyyc;
	yylval = thisrun->roldyyl;
	yyline = thisrun->roldline;
	getbpt = thisrun->svbpt;
	pflag = thisrun->svpflag;
	letflag = thisrun->svletflag;
	charib = thisrun->svch;
	if (thisrun->str != (struct object *)(-1))	/* PAUSE */
		lfree(thisrun->str);
	rtemp = thisrun;
	thisrun = thisrun->rprev;
	JFREE(rtemp);
}

dorep(count,cmd)
struct object *count,*cmd;
{
	FIXNUM icount;

	count = numconv(count,"Repeat");
	if (intp(count)) icount = count->obint;
	else icount = count->obdub;
	if (icount < (FIXNUM)0) ungood("Repeat",count);
	if (icount == (FIXNUM)0) {
		mfree(cmd);
		cmd = 0;
		icount++;
	}
	dorun(cmd,icount);
	mfree(count);
}

struct object *repcount() {
	if (!thisrun) {
		puts("Repcount outside repeat.");
		errhand();
	}
	return(localize(objint(thisrun->rupcount)));
}

#ifdef PAUSE
dopause() {
	register struct plist *opc;

	if (pflag || getbpt) {
		printf("Pausing");
		opc = pcell;
		if (fbr && fbr->oldline==-1) {
			opc=fbr->prevpcell;
		}
		if (opc&&!topf) printf(" at line %d in procedure %s",yyline,
				opc->procname->obstr);
		printf("\n");
		pauselev++;
	}
	if (psigflag) {
		psigflag = 0;
#ifdef EUNICE
		yyprompt();
#endif
	}
	if (pflag || getbpt)
		dorun((struct object *)(-1),(FIXNUM)0);
}

unpause() {
	if (pauselev > 0) {
		pauselev--;
		unrun();
	}
}
#endif

errhand()	/* do error recovery, then pop out to outer level */
{
	errtold++;
	flagquit = 0;
	onintr(errrec,1);
#ifdef PAUSE
	longjmp(yerrbuf,9);
#else
	ltopl();
#endif
}

nullfn()
{
}

makeup(str)
register char *str;
{
	register char ch;

	while (ch = *str) {
		if (ch >= 'a' && ch <= 'z') *str = ch-040;
		str++;
	}
}

struct object *cbreak(ostr)
register struct object *ostr;
{
#ifdef CBREAK
	struct sgttyb sgt;
	register char *str;

	if (!stringp(ostr)) ungood("Cbreak",ostr);
	str = ostr->obstr;
	makeup(str);
	if (strcmp(str,"ON") && strcmp(str,"OFF")) {
		puts("cbreak input must be \"on or \"off");
		errhand();
	}
	gtty(0,&sgt);
	if (!strcmp(str,"ON")) {
		sgt.sg_flags |= CBREAK;
		sgt.sg_flags &= ~ECHO;
	} else {
		sgt.sg_flags &= ~CBREAK;
		sgt.sg_flags |= ECHO;
	}
	stty(0,&sgt);
	mfree(ostr);
	return ((struct object *)(-1));
#else
	printf("No CBREAK on this system.\n");
	errhand();	/* Such as V6 or Idris */
#endif
}

cboff()
{
#ifdef CBREAK
	struct sgttyb sgt;

	gtty(0,&sgt);
	sgt.sg_flags &= ~CBREAK;
	sgt.sg_flags |= ECHO;
	stty(0,&sgt);
#endif
}

struct object *readchar()
{
	char s[2];

	read(0,s,1);
	s[1] = '\0';
	return(localize(objcpstr(s)));
}

struct object *keyp()
{
#ifdef TIOCEMPTY
	int i;

	ioctl(0,TIOCEMPTY,&i);
	if (i)
		return(true());
	else
#else 
#ifdef FIONREAD
	long i;

	ioctl(0,FIONREAD,&i);
	if (i)
		return(true());
	else
#endif
#endif
		return(false());
}

struct object *settest(val)
struct object *val;
{
	if (obstrcmp(val,"true") && obstrcmp(val,"false")) ungood("Test",val);
	currtest = !obstrcmp(val,"true");
	mfree(val);
	return ((struct object *)(-1));
}

loflush() {
	fflush(stdout);
}

struct object *cmoutput(arg)
struct object *arg;
{
	extern int endflag;

#ifdef PAUSE
	if (!pflag && thisrun && thisrun->str==(struct object *)(-1))
		unpause();
#endif
	endflag = 1;
	return(arg);
}
