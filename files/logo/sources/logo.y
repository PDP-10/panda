%nonassoc LOWPREC
%nonassoc '<' '>' '='
%left '+' '-'
%left '*' '/' '\\'
%left '^'
%left UNARY
%token TWOOP ONEOP NOOP ONECOM
%token CSTRING UINT
%token LTO IFCOM LEDIT LIFTF
%token LPROC LPEND LAEND LGO
%token CLIST TWOCOM NOCOM
%token RUNCOM RNEND REPCOM THREECOM
%{ 
#include "logo.h"

char popname[NAMELEN+1];
int multnum;
struct object *multarg = 0;
#include <setjmp.h>
extern jmp_buf runret;
jmp_buf yerrbuf;
int catching = 0;
int flagquit = 0;
extern struct runblock *thisrun;
#ifndef NOTURTLE
extern int turtdes;
extern struct display *mydpy;
#endif
int errtold = 0;
int yyline =0;
char ibuf[IBUFSIZ] ={0};
char *ibufptr =NULL;
char *getbpt =0;
char titlebuf[100] ={0};
char *titleptr =NULL;
extern char *cpystr();
int letflag =0;
int topf =0;
int pflag =0;
char charib =0;
int endflag =0, rendflag = 0;
int traceflag =0;
int currtest = 0;
int argno =(-1);
int *stkbase =NULL;
int stkbi =0;
struct stkframe *fbr =NULL;
struct plist *proclist =NULL;
#ifdef PAUSE
int pauselev = 0;
extern int psigflag,errpause;
#endif

struct object *add(), *sub(), *mult(), *div(), *rem(), *and(), *or();
struct object *greatp(), *lessp(), *lmax(), *lmin(), *lis();
struct object *worcat(), *sencat(), *equal(), *lemp(), *comp();
struct object *lnump(), *lsentp(), *lwordp(), *length(), *zerop();
struct object *first(), *butfir(), *last(), *butlas(), *alllk();
struct object *lnamep(), *lrandd(), *rnd(), *sq(), *lpow(), *lsin();
struct object *lcos(), *latan(), *ltime(), *request(), *readlist();
struct object *cmprint(), *cmtype(), *cmoutput(), *lsleep(), *lbreak();
struct object *cmlocal(), *assign(), *cmedit(), *lstop(), *show(), *erase();
struct object *help(), *describe(), *ltrace(), *luntrace(), *lbyecom();
#ifndef NOTURTLE
struct object *getturtle(), *forward(), *back();
struct object *left(), *right(), *penup(), *cmpendown(), *clearscreen();
struct object *fullscreen(), *splitscreen(), *showturtle();
struct object *hideturtle(), *textscreen(), *cmpenerase(), *pencolor();
struct object *wipeclean(), *penmode(), *penreverse(), *shownp(), *towardsxy();
struct object *setcolor(), *setxy(), *setheading();
struct object *xcor(), *ycor(), *heading(), *getpen();
struct object *scrunch(), *setscrunch();
#endif
struct object *ltopl(), *cmfprint(), *cmftype(), *pots(), *fput(), *lput();
struct object *list(), *loread(), *lowrite(), *fileclose(), *cbreak();
struct object *lfread(), *lfword(), *fileprint(), *filefprint();
struct object *filetype(), *fileftype(), *callunix(), *repcount();
#ifdef DEBUG
struct object *setdebquit(), *setmemtrace(), *setyaccdebug();
#endif
struct object *readchar(), *keyp(), *intpart(), *round(), *toascii();
struct object *tochar(), *loflush(), *settest(), *memberp(), *item();
#ifdef PAUSE
struct object *unpause(), *dopause(), *setipause(), *setqpause(); /* PAUSE */
struct object *seterrpause(), *clrerrpause();
#endif
#ifdef FLOOR
struct object *hitoot(), *lotoot(), *lampon(), *lampoff();
struct object *ftouch(), *btouch(), *ltouch(), *rtouch();
#endif
#ifndef SMALL
struct object *gprop(), *plist(), *pps(), *remprop();
#endif
struct lexstruct keywords[] =
{
	"sum",TWOOP,add,NULL,
	"difference",TWOOP,sub,"diff",
	"product",TWOOP,mult,NULL,
	"quotient",TWOOP,div,NULL,
	"remainder",TWOOP,rem,"mod",
	"both",TWOOP,and,"and",
	"either",TWOOP,or,"or",
	"greaterp",TWOOP,greatp,NULL,
	"lessp",TWOOP,lessp,NULL,
	"maximum",TWOOP,lmax,"max",
	"minimum",TWOOP,lmin,"min",
	"is",TWOOP,lis,NULL,
	"word",TWOOP,worcat,NULL,
	"sentence",TWOOP,sencat,"se",
	"equalp",TWOOP,equal,NULL,
	"emptyp",ONEOP,lemp,NULL,
	"not",ONEOP,comp,NULL,
	"numberp",ONEOP,lnump,NULL,
	"sentencep",ONEOP,lsentp,NULL,
	"wordp",ONEOP,lwordp,NULL,
	"count",ONEOP,length,NULL,
	"zerop",ONEOP,zerop,NULL,
	"first",ONEOP,first,"f",
	"butfirst",ONEOP,butfir,"bf",
	"last",ONEOP,last,"l",
	"butlast",ONEOP,butlas,"bl",
	"thing",ONEOP,alllk,NULL,
	"namep",ONEOP,lnamep,NULL,
	"random",NOOP,lrandd,NULL,
	"rnd",ONEOP,rnd,NULL,
	"sqrt",ONEOP,sq,NULL,
	"pow",TWOOP,lpow,NULL,
	"sin",ONEOP,lsin,NULL,
	"cos",ONEOP,lcos,NULL,
	"arctan",ONEOP,latan,"atan",
	"time",NOOP,ltime,NULL,
	"request",NOOP,request,NULL,
	"readlist",NOOP,readlist,"rl",
	"print",ONECOM,cmprint,"pr",
	"type",ONECOM,cmtype,NULL,
	"output",ONECOM,cmoutput,"op",
	"wait",ONECOM,lsleep,NULL,
	"local",ONECOM,cmlocal,NULL,
	"make",TWOCOM,assign,NULL,
	"if",IFCOM,0,NULL,
	"to",LTO,0,NULL,
	"end",LPEND,0,NULL,
	"stop",NOCOM,lstop,NULL,
	"break",NOCOM,lbreak,NULL,
	"edit",LEDIT,cmedit,"ed",
	"go",LGO,0,NULL,
	"show",ONECOM,show,"po",
	"erase",ONECOM,erase,"er",
	"help",NOCOM,help,NULL,
	"describe",ONECOM,describe,NULL,
	"trace",NOCOM,ltrace,NULL,
	"untrace",NOCOM,luntrace,NULL,
	"goodbye",NOCOM,lbyecom,"bye",
#ifndef NOTURTLE
	"turtle",ONECOM,getturtle,"tur",
	"forward",ONECOM,forward,"fd",
	"back",ONECOM,back,"bk",
	"left",ONECOM,left,"lt",
	"right",ONECOM,right,"rt",
#ifdef FLOOR
	"hitoot",ONECOM,hitoot,"hit",
	"lotoot",ONECOM,lotoot,"lot",
	"lampon",NOCOM,lampon,"lon",
	"lampoff",NOCOM,lampoff,"loff",
#endif
	"penup",NOCOM,penup,"pu",
	"pendown",NOCOM,cmpendown,"pd",
	"clearscreen",NOCOM,clearscreen,"cs",
	"fullscreen",NOCOM,fullscreen,"full",
	"splitscreen",NOCOM,splitscreen,"split",
	"showturtle",NOCOM,showturtle,"st",
	"hideturtle",NOCOM,hideturtle,"ht",
	"textscreen",NOCOM,textscreen,"text",
	"penerase",NOCOM,cmpenerase,"pe",
	"pencolor",ONECOM,pencolor,"penc",
	"setcolor",TWOCOM,setcolor,"setc",
	"setxy",TWOCOM,setxy,NULL,
	"setheading",ONECOM,setheading,"seth",
	"wipeclean",NOCOM,wipeclean,"clean",
	"penmode",NOOP,penmode,NULL,
	"penreverse",NOCOM,penreverse,"px",
	"shownp",NOOP,shownp,NULL,
	"towardsxy",TWOOP,towardsxy,NULL,
#ifdef FLOOR
	"ftouch",NOOP,ftouch,"fto",
	"btouch",NOOP,btouch,"bto",
	"ltouch",NOOP,ltouch,"lto",
	"rtouch",NOOP,rtouch,"rto",
#endif
	"xcor",NOOP,xcor,NULL,
	"ycor",NOOP,ycor,NULL,
	"heading",NOOP,heading,NULL,
	"getpen",NOOP,getpen,NULL,
	"scrunch",NOOP,scrunch,NULL,
	"setscrunch",ONECOM,setscrunch,"setscrun",
#endif
	"toplevel",NOCOM,ltopl,"top",
	"fprint",ONECOM,cmfprint,"fp",
	"ftype",ONECOM,cmftype,"fty",
	"pots",NOCOM,pots,NULL,
	"fput",TWOOP,fput,NULL,
	"lput",TWOOP,lput,NULL,
	"list",TWOOP,list,NULL,
	"openread",ONEOP,loread,"openr",
	"openwrite",ONEOP,lowrite,"openw",
	"close",ONECOM,fileclose,NULL,
	"fileread",ONEOP,lfread,"fird",
	"fileword",ONEOP,lfword,"fiwd",
	"fileprint",TWOCOM,fileprint,"fip",
	"filefprint",TWOCOM,filefprint,"fifp",
	"filetype",TWOCOM,filetype,"fity",
	"fileftype",TWOCOM,fileftype,"fifty",
	"unix",ONECOM,callunix,NULL,
	"run",RUNCOM,0,NULL,
	"repeat",REPCOM,0,NULL,
	"repcount",NOOP,repcount,NULL,
#ifdef DEBUG
	"debquit",NOCOM,setdebquit,NULL,
	"memtrace",NOCOM,setmemtrace,NULL,
	"yaccdebug",NOCOM,setyaccdebug,NULL,
#endif
	"cbreak",ONECOM,cbreak,NULL,
	"readchar",NOOP,readchar,"rc",
	"keyp",NOOP,keyp,NULL,
	"int",ONEOP,intpart,NULL,
	"round",ONEOP,round,NULL,
	"ascii",ONEOP,toascii,NULL,
	"char",ONEOP,tochar,NULL,
	"oflush",NOCOM,loflush,NULL,
#ifndef SMALL
	"gprop",TWOOP,gprop,NULL,
	"plist",ONEOP,plist,NULL,
	"pprop",THREECOM,0,NULL,
	"pps",NOCOM,pps,NULL,
	"remprop",TWOCOM,remprop,NULL,
#endif
	"test",ONECOM,settest,NULL,
	"iftrue",LIFTF,(struct object *(*)())1,"ift",
	"iffalse",LIFTF,0,"iff",
	"memberp",TWOOP,memberp,NULL,
	"item",TWOOP,item,"nth",
#ifdef PAUSE
	"continue",NOCOM,unpause,"co",
	"pause",NOCOM,dopause,NULL,
	"setipause",NOCOM,setipause,NULL,
	"setqpause",NOCOM,setqpause,NULL,
	"errpause",NOCOM,seterrpause,NULL,
	"errquit",NOCOM,clrerrpause,NULL,
#endif
	NULL,NULL,NULL,NULL,
};

#define uperror {errtold++;YYERROR;}

#ifdef PAUSE
#define catch(X) {if(!setjmp(yerrbuf)){if(flagquit)errhand();catching++;X;catching=0;}else{catching=0;uperror}}
#else
#define catch(X) {X;}
#endif
%}
%%
start_sym :  |
	 start_sym command  ={
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
#endif
		yyprompt(1);
	} |
	start_sym error ={
		popname[0] = '\0';
		if (!errtold) {
			logoyerror();
		}
		errtold = 0;
		errwhere();
#ifdef PAUSE
		if ((!errpause&&!pauselev) || !fbr)
#endif
			errzap();
		yyerrok;yyclearin;
		yyprompt(0);
	};
command :
	LEDIT newline ={
		catch(doedit(););
		$$ = -1;
	} |
	onecom valuearg newline ={
		catch($$=(int)(*keywords[$1].lexval)($2););} |
	onecom valuearg error ={cm1er1($1);uperror;} |
	onecom error ={cm1er2($1);uperror;} |
	TWOCOM valuearg valuearg newline ={
		catch((*keywords[$1].lexval)($2,$3);); $$ = -1;} |
	TWOCOM valuearg valuearg error ={cm2er1($1);uperror;} |
	TWOCOM error ={cm2er2($1);uperror;} |
	THREECOM valuearg valuearg valuearg newline ={
#ifndef SMALL
		catch(pprop($2,$3,$4););
#endif
		$$ = -1;
	} |
	THREECOM valuearg valuearg valuearg error ={
		if (!errtold) {
			extra();
			puts("Pprop takes three inputs.");
		}
		uperror;
	} |
	THREECOM error ={
		if (!errtold) {
			missing();
			puts("Pprop takes three inputs.");
		}
		uperror;
	} |
	newline ={ $$= -1; } |
	NOCOM newline ={
		catch((*keywords[$1].lexval)();); $$= -1;} |
	NOCOM error ={
		if (!errtold) {
			extra();
			pf1("%s takes no inputs.\n",keywords[$1].word);
		}
		uperror;
	} |
	LGO white3 valuearg newline ={
		catch(go($3););
		$$= -1;
		} |
	LGO white3 valuearg error ={goerr1();uperror;} |
	LGO error ={goerr2();uperror;} |
	ifcall ={
		if (($1 != -1) && !endflag) {
			if (!errtold)
				pf1("You don't say what to do with %l.\n",$1);
			uperror;
		}
		$$ = $1;
	} |
	title ={
		if ($1== -1)
			uperror
		else
			catch(proccreate($1););
			$$ = -1;
	} |
	arg newline {
		if (thisrun && !pflag) {
			$$ = $1;
		} else {
			if(($1 != -1) && !endflag) {
				if (!errtold)
					pf1("You don't say what to do with %l\n",$1);
				uperror;
			}
		}
	} |
	arg token ={
		if (!errtold) {
			if (popname[0])
				printf("Too many inputs to %s.\n",popname);
			else
				extra();
		}
		uperror;
	} ;

onecom : ONECOM | LEDIT ;

valuearg:	userarg ={
			if ($1 == -1) {
				if (!errtold) {
					printf("%s didn't output.\n",
						popname);
				}
				uperror;
			}
		} |
		sysarg ;

labint : UINT %prec UNARY ={ yyline=((struct object *)$1)->obint; mfree($1); $$ = 0;};

arg :	userarg | sysarg ;

userarg : proccall %prec UNARY |
	runcall %prec LOWPREC ;

sysarg : TWOOP valuearg valuearg %prec LOWPREC ={
		catch($$=(int)(*keywords[$1].lexval)($2,$3););
	} |
	TWOOP valuearg error %prec LOWPREC ={op2er1($1,$2);uperror;} |
	TWOOP error %prec LOWPREC ={op2er2($1);uperror;} |
	ONEOP valuearg %prec LOWPREC ={
		catch($$=(int)(*keywords[$1].lexval)($2););
	} |
	ONEOP error %prec LOWPREC ={op1err($1);uperror;} |
	NOOP %prec LOWPREC ={
		catch($$=(int)(*keywords[$1].lexval)(););
	} |
	UINT %prec LOWPREC |
	'\"' CSTRING { $$=$2; } |
	'[' CLIST ']' { $$=$2; } |
	':' CSTRING {
		catch($$=(int)alllk($2););
		} |
	valuearg '+' valuearg ={
		catch($$=(int)add($1,$3););
	} |
	valuearg '+' error ={inferr($1,$2);uperror;} |
	valuearg '-' valuearg ={
		catch($$=(int)sub($1,$3););
	} |
	valuearg '-' error ={inferr($1,$2);uperror;} |
	'-' valuearg %prec UNARY ={
		catch($$=(int)opp($2););
	} |
	'-' error %prec UNARY ={unerr('-');uperror;} |
	valuearg '^' valuearg {
		catch($$=(int)lpow($1,$3););
	} |
	valuearg '^' error { inferr($1,$2);uperror; } |
	valuearg '*' valuearg ={
		catch($$=(int)mult($1,$3););
	} |
	valuearg '*' error ={inferr($1,$2);uperror;} |
	valuearg '/' valuearg ={
		catch($$=(int)div($1,$3););
	} |
	valuearg '/' error ={inferr($1,$2);uperror;} |
	valuearg '\\' valuearg ={
		catch($$=(int)rem($1,$3););
	} |
	valuearg '\\' error ={inferr($1,$2);uperror;} |
	valuearg '=' valuearg ={
		catch($$=(int)equal($1,$3);)
	} |
	valuearg '=' error ={inferr($1,$2);uperror;} |
	valuearg '<' valuearg ={
		catch($$=(int)lessp($1,$3););
	} |
	valuearg '<' error ={inferr($1,$2);uperror;} |
	valuearg '>' valuearg ={
		catch($$=(int)greatp($1,$3););
	} |
	valuearg '>' error ={inferr($1,$2);uperror;} |
	'{' TWOOP oparglist rbrak {
		catch($$=multiop($2,globcopy(multarg)););
		lfree(multarg);
		multarg = 0;
	}|
	'(' TWOOP oparglist rbrak {
		catch($$=multiop($2,globcopy(multarg)););
		lfree(multarg);
		multarg = 0;
	}|
	'(' valuearg rbrak ={$$=$2;} ;

oparglist : valuearg ={
		catch(multarg = glbcons($1,0););
		mfree($1);
		multnum = 1;
	} |
	valuearg oparglist ={
		catch(multarg = glbcons($1,multarg););
		mfree($1);
		multnum++;
	};
title : tbegin varlist '\n' ={
		strcpy(titleptr,"\n");
		$$=$1;
	} |
	tbegin '\n' ={
		strcpy(titleptr,"\n");
		$$=$1;
	} |
	tbegin varlist error ={
		mfree($1);
		terr();
		$$= -1;
	} |
	tbegin error ={
		mfree($1);
		terr();
		$$= -1;
	};
tbegin : LTO LPROC ={
		titleptr=cpystr(titlebuf,"to ",
			((struct object *)($2))->obstr,NULL);
		$$=$2;
	} | 
	LTO primitive ={
		if (!errtold) printf("Can't redefine primitive %s\n",
			keywords[$2].word);
		uperror;
	};
primitive : NOOP | ONEOP | TWOOP | NOCOM | ONECOM | TWOCOM | THREECOM
		| IFCOM | LTO | LEDIT | LIFTF | LGO
		| RUNCOM | REPCOM | LPEND ;
token : primitive | LPROC | '(' | '{' | '\"' | '[' | ':' | UINT ;
varlist : varsyn ={titleptr=cpystr(titleptr," :",
			((struct object *)($1))->obstr,NULL);
		mfree($1);
	} |
	varlist varsyn {titleptr=cpystr(titleptr," :",
			((struct object *)($2))->obstr,NULL);
		mfree($2);
	} ;
varsyn : ':' CSTRING {$$=$2;};
proccall : procname args argend commlist procend ={
		$$=$4;
		frmpop($4);
	} |
	procname error ={
		if (!errtold) printf("Not enough inputs to %s\n",
			proclist->procname->obstr);
		uperror;
	};
args: |	arglist;
arglist : valuearg %prec LOWPREC ={
		catch(argassign($1););
	} |
	arglist valuearg %prec LOWPREC ={
		catch(argassign($2););
	} ;
argend : LAEND ={procprep();};
commlist : ={yyline=1; $$ = -1;} |
	commlist labint command ={
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		$$=$3;
	} |
	commlist command ={
		popname[0] = '\0';
		if (pflag) yyline++;
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		$$=$2;
	} |
	commlist error ={
		popname[0] = '\0';
#ifdef PAUSE
		if ((!errpause&&!pauselev) || !fbr)
#endif
			uperror;
#ifdef PAUSE
		if (!errtold) {
			logoyerror();
		}
		errtold = 0;
		errwhere();
		yyerrok;yyclearin;
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(0);
#endif
	};
procend : LPEND |
	labint LPEND ;
procname : LPROC ={
		catch(newproc($1););
	};
rcommlist : ={$$ = -1;} |
	rcommlist command ={
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		$$=$2;
	} |
	rcommlist error ={
		popname[0] = '\0';
#ifdef PAUSE
		if ((!errpause&&!pauselev) || !fbr)
#endif
			uperror;
#ifdef PAUSE
		if (!errtold) {
			logoyerror();
		}
		errtold = 0;
		errwhere();
		yyerrok;yyclearin;
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(0);
#endif
	};
runcall : realrun | reprun | ifrun ;
realrun : runstart rcommlist runend ={
		unrun();
		$$ = $2;
		strcpy(popname,"run");
	};
reprun : reprstart rcommlist runend ={
		unrun();
		$$ = $2;
		strcpy(popname,"repeat");
	};
ifrun : ifrstart rcommlist runend ={
		unrun();
		$$ = $2;
		strcpy(popname,"if");
	};
runstart : RUNCOM valuearg %prec LOWPREC ={
		catch(dorun($2,(FIXNUM)0););
	} ;
reprstart : REPCOM valuearg valuearg %prec LOWPREC ={
		catch(dorep($2,$3););
	} ;
ifrstart : IFCOM valuearg valuearg valuearg %prec LOWPREC ={
		{
			int i;

			catch(i = truth($2););
			if (i) {
				catch(dorun($3,(FIXNUM)0););
				mfree($4);
			} else {
				catch(dorun($4,(FIXNUM)0););
				mfree($3);
			}
		}
	} |
	IFCOM error ={
		if (!errtold) printf("Not enough inputs to if.\n");
		uperror;
	} ;
runend : RNEND;
ifcall : ifstart rcommlist runend ={
		unrun();
		$$ = $2;
	};
ifstart : IFCOM valuearg valuearg newline ={
		{
			int i;

			catch(i = truth($2););
			if (i) {catch(dorun($3,(FIXNUM)0););}
			else {
				catch(dorun(0,(FIXNUM)0););
				mfree($3);
			}
		}
	} |
	LIFTF valuearg newline ={
		if ((int)keywords[$1].lexval==currtest) {
			catch(dorun($2,(FIXNUM)0););
		} else {
			catch(dorun(0,(FIXNUM)0););
			mfree($2);
		}
	} ;
white3 : | LTO ;
rbrak : '}' | ')' ;
newline	: '\n' | ';' ;
%%

extern struct object *makelist();

#ifdef PAUSE
yylex1()
#else
yylex()
#endif
{
	register char *str;
	char s[100];
	char c;
	register pc;
	register i;
	NUMBER dubl;
	int floatflag;
	FIXNUM fixn;

	if (yyerrflag) return(1);
	else if (argno==0 && pflag!=1) {
		if (fbr->oldyyc==-2) fbr->oldyyc= -1;
		return(LAEND);
	} else if (endflag==1 && pflag>1) {
		endflag=0;
		return(LPEND);
	}
	else if (pflag==2) {
		pc= *(stkbase+stkbi++);
		if (stkbi==PSTKSIZ-1) {
			stkbase= (int *)(*(stkbase+PSTKSIZ-1));
			stkbi=1;
		}
		yylval= *(stkbase+stkbi++);
		if (pc==LPROC || pc==CSTRING || pc==UINT || pc==CLIST) {
			yylval=(int)localize((struct object *)yylval);
		}
		if (stkbi==PSTKSIZ-1) {
			stkbase= (int *)(*(stkbase+PSTKSIZ-1));
			stkbi=1;
		}
		if (pc== -1) return(0);
		else return(pc);
	} else if (letflag==1) {
		str=s;
		while (!index(" \t\n[](){}\";",(c = getchar()))) {
			if (c == '\\') c = getchar() /* |0200 */ ;
			else if (c == '%') c = ' ' /* |0200 */ ;
			*str++ = c;
		}
		charib=c;
		*str='\0';
		yylval=(int)localize(objcpstr(s));
		letflag=0;
		return(CSTRING);
	} else if (letflag==2) {
		str = s;
		while (( (c=getchar())>='a' && c<='z' )
				|| (c>='A' && c<='Z') || (c>='0' && c<='9')
				|| (c=='.') || (c=='_') ) {
			if (c>='A' && c<='Z') c += 040;
			*str++ = c;
		}
		charib = c;
		*str = '\0';
		letflag = 0;
		yylval = (int)localize(objcpstr(s));
		return(CSTRING);
	}
	else if (letflag==3) {
		yylval = (int)makelist();
		letflag = 4;
		return(CLIST);
	}
	else if (letflag==4) {
		letflag = 0;
		return(yylval = getchar());
	}
	while ((c=getchar())==' ' || c=='\t')
		;
	if (rendflag) {
		getbpt = 0;
		if (rendflag < 3)
			--rendflag;
		else if (!thisrun || thisrun->svpflag)
			rendflag = 0;
		return(RNEND);
	}

	if (c == '!')	/* comment feature */
		while ((c=getchar()) && (c != '\n')) ;

	if ((c<'a' || c>'z') && (c<'A' || c>'Z')
			&& (c<'0' || c>'9') && c!='.') {
		yylval=c;
		if (c=='\"') letflag=1;
		if (c==':') letflag=2;
		if (c=='[') letflag=3;
		return(c);
	}
	else if ((c>='0' && c<='9')|| c=='.') {
		floatflag = (c=='.');
		str=s;
		while ((c>='0' && c<='9')||(c=='E')||(c=='e')||(c=='.')) {
			*str++=c;
			if (c=='.') floatflag++;
			if ((c=='e')||(c=='E')) {
				floatflag++;
				c = getchar();
				if ((c=='+')||(c=='-')) {
					*str++ = c;
					c = getchar();
				}
			} else c=getchar();
		}
		charib=c;
		*str='\0';
		if (floatflag) {
			sscanf(s,EFMT,&dubl);
			yylval=(int)localize(objdub(dubl));
		} else {
			sscanf(s,FIXFMT,&fixn);
			yylval=(int)localize(objint(fixn));
		}
		return(UINT);
	} else {
		if (c < 'a') c += 040;
		yylval=(int)(str=s);
		*str++=c;
		c=getchar();
		if (c >= 'A' && c <= 'Z') c += 040;
		while ((c>='a' && c<='z') || (c>='0' && c<='9')
				|| (c=='.') || (c=='_')) {
			*str++=c;
			c=getchar();
			if (c >= 'A' && c <= 'Z') c += 040;
		}
		charib=c;
		*str='\0';
		for (i=0; keywords[i].word; i++) {
			if (!strcmp(yylval,keywords[i].word) ||
 			    (keywords[i].abbr && 
 			     !strcmp(yylval,keywords[i].abbr))) {
				yylval=i;
				return(keywords[i].lexret);
			}
		}
		yylval=(int)localize(objcpstr(s));
		return(LPROC);
	}
}

#ifdef PAUSE
yylex() {
	int x;

	if (catching) return(yylex1());
	if (!setjmp(yerrbuf)) {
		if (flagquit) errhand();
		catching++;
		x = yylex1();
		catching=0;
		return(x);
	} else {
		catching=0;
		return(12345);	/* This should cause an error up there */
	}
}
#endif

int isuint(x)
int x;
{
	return(x == UINT);
}

int isstored(x)
int x;
{
	return(x==UINT || x==LPROC || x==CSTRING || x==CLIST);
}

yyprompt(clear) {
	register int i;

	if (!ibufptr && !getbpt && !pflag) {
		flagquit = 0;
#ifdef PAUSE
		if (pauselev > 0) {
			for (i=pauselev; --i >=0; )
				putchar('-');
		}
#endif
		putchar('*');
#ifndef NOTURTLE
		if ((turtdes<0) && clear)
			(*mydpy->state)('*');
#endif
		fflush(stdout);
	}
}
