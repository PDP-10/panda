#include <stdio.h>
#include "logo.h"

int errrec();
int ehand2();
int ehand3();
int leave();

extern char popname[];
extern int letflag, pflag, argno, yyline, rendflag, currtest;
extern int traceflag, *stkbase, stkbi, yychar, endflag, topf;
#ifdef PAUSE
extern int pauselev, errpause, catching, flagquit;
#endif
#ifndef NOTURTLE
extern int turtdes;
#endif
extern char charib, *getbpt, *ibufptr;
extern char titlebuf[];
extern struct lexstruct keywords[];
extern struct stkframe *fbr;
extern struct plist *proclist;
extern struct object *multarg;
extern struct runblock *thisrun;
#ifndef YYSTYPE
#define YYSTYPE int
#endif
extern YYSTYPE yylval;

int doprep = 0;
int *newstk =NULL;
int newsti =0;
FILE *pbuf =0;
struct plist *pcell =NULL;
struct alist *locptr =NULL, *newloc =NULL;
struct object *allocstk[MAXALLOC] ={0};

int memb(ch,str)
register char ch,*str;
{
	register char ch1;

	while (ch1 = *str++)
		if (ch == ch1) return(1);
	return(0);
}

char *token(str)
register char *str;
{
	static char output[20];
	register char ch,*op;

	op = output;
	while((op < &output[19]) && (ch = *str++) && !memb(ch," \t\"[\r\n:")){
		if (ch >= 'A' && ch <= 'Z') ch += 'a'-'A';
		*op++ = ch;
	}
	*op = '\0';
	return(output);
}

#ifdef DEBUG
jfree(block)
char *block;
{
	if (memtrace)
		printf("Jfree loc=0%o\n",block);
	if (block==0) printf("Trying to jfree zero.\n");
	else free(block);
}
#endif

newproc(nameob)
struct object *nameob;
{
	register char *name;
	register struct stkframe *stemp;
	register struct lincell *ltemp;
	struct plist *pptr;
	int linlab;
	int itemp;
	char *temp,*tstr;
	struct object *title;
	char s[100];
	int olp;
	int oldlet;
	int olc,c;
	int pc;
	extern struct plist *proclook();

	name = nameob->obstr;
	stemp=(struct stkframe *)ckzmalloc(sizeof(*stemp));
	stemp->prevframe=fbr;
	stemp->oldyyc= -2;
	stemp->oldline= -1;
	stemp->oldnewstk=newstk;
	newstk = NULL;
	stemp->oldnloc=newloc;
	newloc=NULL;
	stemp->argtord=argno;
	stemp->prevpcell=pcell;
	pcell = NULL;
	stemp->loclist = NULL;
	fbr=stemp;
	doprep++;
	argno=0;
	if (pptr=proclook(name)) {
		mfree(nameob);
		newstk=pptr->realbase;
		(pptr->recdepth)++;
		title=pptr->ptitle;
		pcell=pptr;
	} else {
		onintr(ehand2,&pbuf);
		cpystr (s,name,EXTEN,NULL);
		if (!(pbuf=fopen(s,"r"))) {
			extern int errno;
				 /* ENOENT */
/* Unix only		if (errno != 2) */
				/* GJFX24 */
/* TOPS-20 only */	if (errno != 68)
			{
				onintr(errrec,1);
#ifdef SMALL
				printf("%s: error %d\n",s,errno);
#else
				perror(s);
#endif
				errhand();
			}
			cpystr(s,"PS:<LOGO.LIBRARY>",name,EXTEN,NULL);
			if (!(pbuf = fopen(s,"r"))) {
				onintr(errrec,1);
				printf("You haven't told me how to %s.\n",name);
				errhand();
			}
		}
		pptr=(struct plist *)ckzmalloc(sizeof(*pptr));
		pptr->plines=NULL;
		pptr->procname=globcopy(nameob);
		mfree(nameob);
		temp=s;
		while ( ((c=getc(pbuf)) != EOF) && (c!='\n') ) *temp++=c;
		if (c==EOF) {
			printf("Bad format in %s title line.\n",
				pptr->procname->obstr);
			errhand();
		}
		*temp++='\n';
		*temp='\0';
		title=globcopy(objcpstr(s));
		pptr->after=proclist;
		pptr->recdepth=1;
		pptr->ptitle=title;
		pptr->before=NULL;
		if (proclist) proclist->before = pptr;
		proclist=pptr;
		pcell=pptr;
	}
	tstr = title->obstr;
nextarg: while((c= *tstr++)!=':' && c!='\n')
		;
	if (c==':') {
		temp=s;
		while ((c= *tstr++)!=' ' && c!='\n') *temp++=c;
		*temp='\0';
		tstr--;
		loccreate(globcopy(objcpstr(s)),&newloc);
		argno++;
		goto nextarg;
	}
	if (pptr->recdepth!=1) return;
	olp=pflag;
	pflag=1;
	oldlet=letflag;
	letflag=0;
	olc=charib;
	charib=0;
	newstk=(int *)ckmalloc(PSTKSIZ*sizeof(int));
	*newstk=0;
	newsti=1;
	*(newstk+newsti) = -1;	/* BH 6/25/82 in case yylex blows up */
	itemp = '\n';
	while ((pc = yylex()) != -1) {
		if (pc==1) return;
		if ((itemp == '\n') && isuint(pc)) {
			linlab=((struct object *)yylval)->obint;
			ltemp=(struct lincell *)ckmalloc(sizeof(*ltemp));
			ltemp->linenum=linlab;
			ltemp->base=newstk;
			ltemp->index=newsti;
			ltemp->nextline=pptr->plines;
			pptr->plines=ltemp;
		}
		*(newstk+newsti++)=pc;
		if (newsti==PSTKSIZ-1) newfr();
		*(newstk+newsti++)=yylval;
		if (isstored(pc)) {
			yylval = (YYSTYPE)globcopy(yylval);
			mfree(yylval);
		}
		if (newsti==PSTKSIZ-1) newfr();
		*(newstk+newsti) = -1;
		itemp = pc;
	}
	*(newstk+newsti)= -1;
	*(newstk+PSTKSIZ-1)=0;
	pflag=olp;
	letflag=oldlet;
	charib=olc;
	fclose(pbuf);
	onintr(errrec,1);
	while (*newstk!=0) newstk= (int *)*newstk;
	pptr->realbase=newstk;
}

procprep()
{
	doprep=0;
	fbr->oldline=yyline;
	fbr->oldbpt=getbpt;
	getbpt=0;
	fbr->loclist=locptr;
	locptr=newloc;
	newloc=NULL;
	fbr->stk=stkbase;
	stkbase=newstk;
	newstk=NULL;
	fbr->ind=stkbi;
	stkbi=1;
	newsti=0;
	argno= -1;
	fbr->oldpfg = pflag;
	pflag=2;
	fbr->iftest = currtest;
	if (traceflag) intrace();
}

frmpop(val)
register struct object *val;
{
	struct alist *atemp0,*atemp1,*atemp2;
	register struct stkframe *ftemp;
	struct lincell *ltemp,*ltemp2;
	register i;
	int *stemp;
	int stval;

	if (traceflag) outtrace(val);
	if (!pcell) goto nopcell;
	strcpy(popname,pcell->procname->obstr);
	(pcell->recdepth)--;
	if (pcell->recdepth==0) {
		lfree(pcell->procname);
		lfree(pcell->ptitle);
		if (pcell->before) (pcell->before)->after=pcell->after;
		else proclist=pcell->after;
		if (pcell->after) (pcell->after)->before=pcell->before;
		for(ltemp=pcell->plines;ltemp;ltemp=ltemp2) {
			ltemp2=ltemp->nextline;
			JFREE(ltemp);
		}
		if ((stemp=stkbase) == 0) goto nostack;
		while (*stemp!=0) stemp= (int *)*stemp;
		for (i=1;;i++) {
			stval= *(stemp+i);
			if (isstored(stval))
			{
				if (i==PSTKSIZ-2) {
					stkbase= (int *)*(stemp+PSTKSIZ-1);
					JFREE(stemp);
					stemp=stkbase;
					i=0;
				}
				lfree(*(stemp+ (++i)));
			} else if (stval== -1) {
				JFREE(stemp);
				break;
			} else {
				if (i==PSTKSIZ-2) {
					stkbase= (int *)*(stemp+PSTKSIZ-1);
					JFREE(stemp);
					stemp=stkbase;
					i=1;
				} else i++;
			}
			if (i==PSTKSIZ-2) {
				stkbase= (int *)*(stemp+PSTKSIZ-1);
				JFREE(stemp);
				stemp=stkbase;
				i=0;
			}
		}
	nostack:
		JFREE(pcell);
	}
nopcell:
	ftemp=fbr;
	stkbase=ftemp->stk;
	stkbi=ftemp->ind;
	newstk=ftemp->oldnewstk;
	atemp0=newloc;	/* BH 6/20/82 maybe never did procprep */
	newloc=ftemp->oldnloc;
	pflag = fbr->oldpfg;
	atemp1=locptr;
	locptr=ftemp->loclist;
	argno=ftemp->argtord;
	pcell=ftemp->prevpcell;
	yychar=ftemp->oldyyc;
	yylval=ftemp->oldyyl;
	yyline=ftemp->oldline;
	getbpt=ftemp->oldbpt;
	currtest=ftemp->iftest;
	fbr=ftemp->prevframe;
	JFREE(ftemp);
	while (atemp1) {
		atemp2=atemp1->next;
		if (atemp1->name) lfree(atemp1->name);
		if (atemp1->val!=(struct object *)-1)	/* BH 2/28/80 was NULL instead of -1 */
			lfree(atemp1->val);
		JFREE(atemp1);
		atemp1=atemp2;
	}
	while (atemp0) {
		atemp2=atemp0->next;
		if (atemp0->name) lfree(atemp0->name);
		if (atemp0->val!=(struct object *)-1)
			lfree(atemp0->val);
		JFREE(atemp0);
		atemp0=atemp2;
	}
}

proccreate(nameob)
register struct object *nameob;
{
	register char *name;
	char temp[16];
	register FILDES edfd;
	int pid;

#ifndef NOTURTLE
	if (turtdes<0) textscreen();
#endif
	name = token(nameob->obstr);
	if (strlen(name)>NAMELEN) {
		pf1("Procedure name must be no more than %d letters.",NAMELEN);
		errhand();
	}
	cpystr(temp,name,EXTEN,NULL);
	if ((edfd=open(temp,READ,0))>=0) {
		close(edfd);
		nputs(name);
		puts(" is already defined.");
		errhand();
	}
	if ((edfd = creat(temp,0666)) < 0) {
		printf("Can't write %s.\n",name);
		errhand();
	}
	onintr(ehand3,edfd);
	mfree(nameob);
	write(edfd,titlebuf,strlen(titlebuf));
	addlines(edfd);
	onintr(errrec,1);
}

help()
{
	FILE *sbuf;

	sbuf=fopen("PS:<LOGO.HELP>HELPFILE","r");
	if (sbuf == NULL) {
		printf("? Help file missing, sorry.\n");
		return;
	}
	onintr(ehand2,sbuf);
	while(putch(getc(sbuf))!=EOF)
		;
	fclose(sbuf);
	onintr(errrec,1);
}

struct object *describe(arg)
struct object *arg;
{
	register char *argstr;
	register struct lexstruct *lexp;
	FILE *sbuf;
	char fname[30];

	if (!stringp(arg)) ungood("Describe",arg);
	argstr = token(arg->obstr);
	for (lexp = keywords; lexp->word; lexp++)
 		if (!strcmp(argstr,lexp->word) || 
 			(lexp->abbr && !strcmp(argstr,lexp->abbr)))
			break;

	if (!lexp->word) {
		pf1("%p isn't a primitive.\n",arg);
		errhand();
	}
	if (strlen(lexp->word) > 9)	/* kludge for Eunice */
		cpystr(fname,"PS:<LOGO.HELP>",lexp->abbr,NULL);
	else
		cpystr(fname,"PS:<LOGO.HELP>",lexp->word,NULL);
	if (!(sbuf=fopen(fname,"r"))) {
		printf("Sorry, I have no information about %s\n",lexp->word);
		errhand();
	} else {
		onintr(ehand2,sbuf);
		while (putch(getc(sbuf))!=EOF)
			;
		fclose(sbuf);
	}
	onintr(errrec,1);
	mfree(arg);
	return ((struct object *)(-1));
}

errwhere()
{
	register i =0;
	register struct object **astk;
	register struct plist *opc;

	cboff();	/* BH 12/13/81 */
	ibufptr=NULL;
	if (doprep) {
		procprep();
		frmpop(-1);
	}

	for (astk=allocstk;i<MAXALLOC;i++)
		if (astk[i]!=0)
			mfree(astk[i]);

	if (multarg) {
		lfree(multarg);
		multarg = 0;
	}	/* BH 10/31/81 multarg isn't on astk, isn't mfreed. */

#ifdef PAUSE
	if ((errpause||pauselev) && fbr && !topf) {
		/* I hope this pauses on error */
		if (!pflag && !getbpt) charib=0;
		dopause();
	}
	else
#endif
	{
		opc = pcell;
		if (fbr && fbr->oldline==-1) {
			opc=fbr->prevpcell;
		}
		if (opc&&!topf)
			printf("You were at line %d in procedure %s\n",
				yyline,opc->procname->obstr);
	}
}

errzap() {
	while (thisrun)
		unrun();

	while (fbr)
		frmpop(-1);

	charib=0;
	if(traceflag)traceflag=1;
	topf=0;
	yyline=0;
	letflag=0;
	pflag=0;
	endflag=0;
	rendflag=0;
	argno= -1;
	newstk=NULL;
	newsti=0;
	stkbase=NULL;
	stkbi=0;
	fbr=NULL;
	locptr=NULL;
	newloc=NULL;
	proclist=NULL;
	pcell=NULL;
#ifdef PAUSE
	pauselev = 0;
#endif
}

errrec()
{
	/* Here on SIGQUIT */
#ifdef PAUSE
	if (catching)
#endif
		errhand();
#ifdef PAUSE
	flagquit++;	/* We'll catch this later */
#endif
}

ehand2(fle)
register FILE *fle;
{
	fclose(fle);
	errhand();
}

ehand3(fle)
register FILDES fle;
{
	close(fle);
	errhand();
}

intrace()
{
	register struct alist *aptr;

	if (!pcell) return;
	indent(traceflag-1);
	nputs(pcell->procname->obstr);
	if (locptr && (locptr->val != (struct object *)-1)) {
		pf1(" of %l",locptr->val);	/* BH locptr->val was inval */
		for (aptr=locptr->next;aptr;aptr=aptr->next) {
			if (aptr->val == (struct object *)-1) break;
			pf1(" and %l",aptr->val);	/* was inval */
		}
		putchar('\n');
	}
	else puts(" called.");
	fflush(stdout);
	traceflag++;
}

outtrace(retval)
register struct object *retval;
{
	if (!pcell) return;
	if (traceflag>1) traceflag--;
	indent(traceflag-1);
	nputs(pcell->procname->obstr);
	if (retval != (struct object *)-1) pf1(" outputs %l\n",retval);
	else puts(" stops.");
	fflush(stdout);
}

indent(no)
register int no;
{
	while (no--)putchar(' ');
}
  