# define LOWPREC 257
# define UNARY 258
# define TWOOP 259
# define ONEOP 260
# define NOOP 261
# define ONECOM 262
# define CSTRING 263
# define UINT 264
# define LTO 265
# define IFCOM 266
# define LEDIT 267
# define LIFTF 268
# define LPROC 269
# define LPEND 270
# define LAEND 271
# define LGO 272
# define CLIST 273
# define TWOCOM 274
# define NOCOM 275
# define RUNCOM 276
# define RNEND 277
# define REPCOM 278
# define THREECOM 279

# line 13 "logo.y"
 
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
#define yyclearin yychar = -1
#define yyerrok yyerrflag = 0
extern int yychar;
extern short yyerrflag;
#ifndef YYMAXDEPTH
#define YYMAXDEPTH 150
#endif
#ifndef YYSTYPE
#define YYSTYPE int
#endif
YYSTYPE yylval, yyval;
# define YYERRCODE 256

# line 664 "logo.y"


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
short yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
-1, 19,
	60, 26,
	62, 26,
	61, 26,
	43, 26,
	45, 26,
	42, 26,
	47, 26,
	92, 26,
	94, 26,
	-2, 29,
-1, 20,
	60, 27,
	62, 27,
	61, 27,
	43, 27,
	45, 27,
	42, 27,
	47, 27,
	92, 27,
	94, 27,
	-2, 30,
-1, 160,
	60, 0,
	62, 0,
	61, 0,
	-2, 57,
-1, 162,
	60, 0,
	62, 0,
	61, 0,
	-2, 59,
-1, 164,
	60, 0,
	62, 0,
	61, 0,
	-2, 61,
-1, 183,
	42, 47,
	47, 47,
	92, 47,
	94, 47,
	262, 47,
	265, 47,
	267, 47,
	268, 47,
	270, 47,
	271, 47,
	272, 47,
	274, 47,
	275, 47,
	277, 47,
	279, 47,
	-2, 45,
-1, 184,
	262, 48,
	265, 48,
	267, 48,
	268, 48,
	270, 48,
	271, 48,
	272, 48,
	274, 48,
	275, 48,
	277, 48,
	279, 48,
	-2, 46,
-1, 202,
	60, 39,
	62, 39,
	61, 39,
	43, 39,
	42, 39,
	47, 39,
	92, 39,
	94, 39,
	-2, 28,
	};
# define YYNPROD 137
# define YYLAST 1449
short yyact[]={

  15, 103, 174,  74,  73,  72,  76, 116,  60,  80,
  79,  81,  82,  96,  86,  15,  83,  61,  77,  75,
  84,  15,  85,  78,  30, 142, 104, 102, 191, 135,
  36,   2, 170, 172,  51,  34,  20, 137, 139, 107,
 147,  91,  15,  64,  17,  30,  15,  44,  32,  16,
  43,  36,  42,  40, 108,  39,  34,  89,  38, 109,
 121, 197, 194,  15,  16, 173,  30,  97, 119,  32,
  16,  37,  36,  88,  18, 108, 105,  34, 106,  25,
 109,  31,  24, 198,  15,  63,  92,  30,  13,  12,
  32,  16,  87,  36,  11,  16,  59,   5,  34,   1,
   0,   0,  31,   0, 110,  92, 107,   0,  68,   0,
   0,  32,  16,  35,  66,   0,   0, 171,   0,  15,
   0,   0,  20,  31,   0, 110,   0, 107,   0,   0,
 141,   0,  70,  16,  35, 123, 124, 125,   0,   0,
   0,   0,   0,  30,  31, 166, 169,   0,   0,  36,
   0, 108, 105,   0, 132,  35, 109,   0,  20,  20,
  20, 176, 177, 178,   0,  69,   0,  32,  16, 112,
 111, 113,   0,   0,   0,   0,  35,   0,   0,   0,
   0,   0,   0,   0,   0,  30,   0, 108, 105,   0,
 106,  36, 109, 108, 105,   0, 132,  67, 109, 190,
  31, 110, 193, 107,   0, 112, 111, 113,   0,  32,
   0, 112, 111, 113,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0, 199,   0,   0,   0, 203,  20,
   0,   0,  35,  20,   0,   0,   0, 110,   0, 107,
   0,   0,  31, 110,   0, 107, 200,   0,   0,  26,
  27,  28,  14,   0, 202,  23,  21,   4,  22,  41,
 201,  58,  10,   0,   6,   9,  45, 136,  46,   7,
  26,  27,  28,  14,  35,  29,  23,  21,   4,  22,
  41,   0,   0,  10, 140,   6,   9,  45, 138,  46,
   7,  26,  27,  28,  14,   0,  29,  23,  21,   4,
  22,  41, 204,  90,  10,   0,   6,   9,  45,   3,
  46,   7,  26,  27,  28,  14,   0,  29,  23,  21,
   4,  22,  41,   0,   0,  10,   0,   6,   9,  45,
   0,  46,   7,  74,  73,  72,  76,   0,  71,  80,
  79,  81,  82,  65,  86,   0,  83,   0,  77,  75,
  84,   0,  85,  78,   0,   0,  30,   0,   0,   0,
   0,   0,  36,  50,   0,  19,   0,  34,  26,  27,
  28,   0,   0,  29,   0,  52,   0,   0,  41,   0,
  32,   0,   0,   0,   0,  45,   0,  46,   0,   0,
   0,   0,   0,   0,   0,  30,   0,   0,   0,   0,
   0,  36,   0, 108, 105,   0, 132, 146, 109,   0,
  26,  27,  28,  31,   0,  29,   0,  52,   0,  32,
  41, 112, 111, 113,  30,   0,   0,  45,   0,  46,
  36,   0,   0,   0,   0,  34,   0,   0,   0,   0,
   0,   0,   0,   0,   0,  35,   0,   0,  32,   0,
  30,  19,  31, 110,   0, 107,  36,   0,   0,   0,
   0,  34,   0,   0,   0,   0,   0,   0,   0,   0,
   0,  30,   0,   0,  32,   0,   0,  36,   0,   0,
   0,  31,  34,  15,  35,   0,   0,  19,  19,  19,
   0,   0,   0,   0,   0,  32,   0,   0,  30,   0,
   8,   0,   0,   0,  36,  47,   0,  31,   0,  34,
  57,   0,   0,  35,  62, 108, 105,   0, 106,  30,
 109,   0,  32,   0,   0,  36,   0,   0,  31,   0,
  34,   0,  16, 112, 111, 113,   0,   0,   0,  35,
  30,   0,   0,  32,   0,   0,  36,   0,   0, 128,
   0,  34,   0,   0,   0,  31,   0,   0,  19,   0,
  35,   0,  19,   0,  32, 110,  30, 107,   0,   0,
   0,   0,  36,   0,   0,   0,  31,  34, 184,   0,
   0,  26,  27,  28,   0,   0,  29,  35,  52,   0,
  32,  41,   0,   0,   0,  30, 144,  31,  45,   0,
  46,  36,   0,   0,   0,   0,  34,   0,  35,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,  32,
  26,  27,  28,  31,   0,  29,   0,  52,   0,  35,
  41,   0, 181,   0,   0, 186,   0,  45,   0,  46,
   0,   0,   0,   0, 189,   0,  99,  30,   0,  26,
  27,  28,  31,  36,  29,  35,  52,   0,  34,  41,
   0,   0,   0,   0,   0,   0,  45,   0,  46,   0,
   0,  32, 165,   0,   0,  26,  27,  28,   0,   0,
  29,   0,  52,   0,  35,  41, 195,   0,   0,   0,
   0,   0,  45, 163,  46,   0,  26,  27,  28,   0,
   0,  29,   0,  52,  31,   0,  41,   0,   0,   0,
   0,  30,   0,  45,   0,  46,   0,  36,   0,   0,
 161,   0,  34,  26,  27,  28,   0,   0,  29, 196,
  52,   0,   0,  41,   0,  32,  35,   0,   0,   0,
  45, 159,  46,   0,  26,  27,  28,  30,   0,  29,
   0,  52,   0,  36,  41,   0,   0,   0,  34,   0,
   0,  45, 157,  46,   0,  26,  27,  28,  31,   0,
  29,  32,  52,   0,   0,  41,   0,   0,   0,   0,
   0,   0,  45,   0,  46,   0,   0,   0, 155,   0,
   0,  26,  27,  28,   0,   0,  29,   0,  52,   0,
  35,  41,   0,   0,  31,  30,   0,   0,  45,   0,
  46,  36,   0,   0,   0,   0,  34, 153,   0,   0,
  26,  27,  28,   0,   0,  29,   0,  52,   0,  32,
  41,   0,   0,   0,   0,  30,  35,  45,   0,  46,
   0,  36,   0,   0,   0,   0,  34,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,  32,
  30,   0,  31,   0,   0,   0,  36,   0,   0, 151,
   0,  34,  26,  27,  28,   0,   0,  29,   0,  52,
   0,   0,  41,   0,  32,   0,   0,  30,   0,  45,
   0,  46,  31,  36,  35,   0,   0,   0,  34,   0,
   0, 172, 108, 105,   0, 106,   0, 109,  30,   0,
   0,  32,   0,   0,  36,   0,   0,  31,   0,  34,
 112, 111, 113,   0,  35,   0,   0,   0,   0,   0,
   0,   0,  32, 149,   0,   0,  26,  27,  28,  30,
   0,  29,   0,  52,  31,  36,  41,   0,   0,  35,
  34,   0, 110,  45, 107,  46,   0,   0,   0,   0,
   0,   0,   0,  32,  30,  31,  15,   0,   0,  94,
  36,   0,  26,  27,  28,  34,  35,  29,   0,  52,
   0,   0,  41,   0,  30, 171,   0,   0,  32,  45,
  36,  46,   0,   0,   0,  34,  31,  35, 108, 105,
   0, 106,   0, 109,   0,   0,   0,   0,  32,   0,
   0,   0,   0,   0,   0,  16, 112, 111, 113,   0,
   0,  31,   0,   0,   0,   0,   0, 120,  35,   0,
  26,  27,  28,   0,   0,  29,   0,  52,   0,   0,
  41,  31,   0,   0,   0,   0,   0,  45, 110,  46,
 107,   0,   0,  35,   0,   0,   0, 115,   0,   0,
  26,  27,  28,   0,   0,  29,   0,  52,   0,   0,
  41,   0,   0,  35,   0,   0,   0,  45,   0,  46,
   0,   0, 101,   0,   0,  26,  27,  28,   0,   0,
  29,   0,  52,   0,   0,  41,   0,   0,   0,   0,
   0,   0,  45,   0,  46,   0,   0,   0,   0,  56,
   0,   0,  26,  27,  28,   0,   0,  29,   0,  52,
   0,   0,  41,   0,   0,   0,   0,   0,   0,  45,
  54,  46,   0,  26,  27,  28,   0,   0,  29,   0,
  52,   0,   0,  41,   0,   0,   0,   0,   0,   0,
  45,   0,  46,   0,   0,   0,   0,   0,   0,   0,
   0,  49,   0,   0,  26,  27,  28,   0,   0,  29,
   0,  52,   0,   0,  41,   0,   0,   0,   0,   0,
   0,  45,   0,  46,   0,  15,   0,   0,   0,  26,
  27,  28,  15,   0,  29,   0,  52,   0,   0,  41,
   0,   0,   0,   0,   0,   0,  45,   0,  46, 117,
  27,  28, 187,   0,  29,   0,  52, 108, 105,  41,
 106,  15, 109,   0, 108, 105,  45, 106,  46, 109,
   0,   0,   0,   0,  16, 112, 111, 113,   0,   0,
   0,  16, 112, 111, 113,   0,   0,   0,   0,   0,
   0,   0,   0, 108, 105,  33, 106,   0, 109,   0,
   0,  48,  53,  55,   0,   0,   0, 110,   0, 107,
  16, 112, 111, 113, 110,   0, 107,  93,  95,   0,
   0,   0,  98, 100,   0,   0,   0,   0,   0,   0,
 114,   0, 118, 122,   0,   0,   0,   0,   0,   0,
   0, 126, 127, 110,   0, 107,   0,   0, 130, 131,
   0, 133,   0,   0,   0, 134,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0, 143,
   0,   0,   0,   0, 145,   0,   0,   0,   0,   0,
   0, 148, 150, 152, 154, 156, 158, 160, 162, 164,
   0,   0, 167, 168,   0,   0,   0, 175,   0,   0,
   0,   0,   0, 179,   0,   0, 180,   0, 183, 185,
   0,   0,   0,   0,   0,   0,   0,   0,   0, 188,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0, 167, 192,   0,   0,   0,   0,   0,
   0, 182,   0,   0,   0,   0, 188,   0, 129,   0,
   0,   0,   0,   0,   0,   0,   0,   0, 167 };
short yypact[]={

-1000,  53,-1000,-1000,  36, 905, 874, 853,-1000,   5,
-248,-1000,-1000,  74,-1000,-1000,-1000,-1000,  47,-1000,
-1000, 713, 930,-256,-1000,-1000, 390, 826,-1000,-1000,
-236,-272,-237, 145, 801,-252, 950, 771,-1000,-1000,
-1000,-1000,-1000,-1000,-1000, 930, 930,-1000,1182,-1000,
-1000,-1000, 713, 361,-1000, 361,-1000,-1000,-1000, 930,
-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,
-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,
-1000,-1000,-1000,-1000,-1000,-1000,-1000,  11,  28,-1000,
-1000,-1000,-238, 361,-1000,1211,-1000,-1000, 151,-1000,
 145,-1000,-1000, -53,-1000, 677, 613, 561, 532, 506,
 485, 464, 437, 416,-1000,-1000, 930, 390, 860,-269,
-1000, 930, 145,  11,  11,  11, 145, 361,-1000,-1000,
 361,1175, 322, 361, 956,-1000,-1000,-1000,-1000,-1000,
-1000,-1000,-1000, 109,-1000, 145,-1000,-1000,  12,-1000,
  12,-1000,-1000,-1000, -55,-1000, -55,-1000, -55,-1000,
  33,-1000,  33,-1000,  33,-1000,  -8, 361, 151,  -8,
-1000,-1000,-1000,-1000,-1000, 145,-1000,-1000,-1000, 145,
 361,-1000,-1000,-1000,-1000, 473,-1000,-1000, 145,-1000,
-1000,-1000, 361,-1000, -10,-1000,-1000,-1000,  32,-1000,
-1000,-1000,-1000,-1000,-1000 };
short yypgo[]={

   0,  99,  29, 500,  97,1255,  96,  94,  89,  88,
  85, 363,  34,  83,  82,  79,  28,  32,  74,  73,
  43,  41,  71,  68,  65,  62,  61,  60,  92,  58,
  55,  53,  52,  37,  50,  47,  44 };
short yyr1[]={

   0,   1,   1,   1,   2,   2,   2,   2,   2,   2,
   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,
   2,   2,   2,   2,   4,   4,   5,   5,  13,   9,
   9,  11,  11,  12,  12,  12,  12,  12,  12,  12,
  12,  12,  12,  12,  12,  12,  12,  12,  12,  12,
  12,  12,  12,  12,  12,  12,  12,  12,  12,  12,
  12,  12,  12,  12,  12,  12,  16,  16,   8,   8,
   8,   8,  18,  18,  20,  20,  20,  20,  20,  20,
  20,  20,  20,  20,  20,  20,  20,  20,  20,  10,
  10,  10,  10,  10,  10,  10,  10,  19,  19,  21,
  14,  14,  23,  23,  27,  27,  24,  25,  25,  25,
  25,  26,  26,  22,  28,  28,  28,  15,  15,  15,
  29,  30,  31,  32,  34,  35,  35,  33,   7,  36,
  36,   6,   6,  17,  17,   3,   3 };
short yyr2[]={

   0,   0,   2,   2,   2,   3,   3,   2,   4,   4,
   2,   5,   5,   2,   1,   2,   2,   4,   4,   2,
   1,   1,   2,   2,   1,   1,   1,   1,   1,   1,
   1,   1,   1,   3,   3,   2,   2,   2,   1,   1,
   2,   3,   2,   3,   3,   3,   3,   2,   2,   3,
   3,   3,   3,   3,   3,   3,   3,   3,   3,   3,
   3,   3,   3,   4,   4,   3,   1,   2,   3,   2,
   3,   2,   2,   2,   1,   1,   1,   1,   1,   1,
   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,
   1,   1,   1,   1,   1,   1,   1,   1,   2,   2,
   5,   2,   0,   1,   1,   2,   1,   0,   3,   2,
   2,   1,   2,   1,   0,   2,   2,   1,   1,   1,
   3,   3,   3,   2,   3,   4,   2,   1,   3,   4,
   3,   0,   1,   1,   1,   1,   1 };
short yychk[]={

-1000,  -1,  -2, 256, 267,  -4, 274, 279,  -3, 275,
 272,  -7,  -8,  -9, 262,  10,  59, -36, -18, -11,
 -12, 266, 268, 265, -14, -15, 259, 260, 261, 264,
  34,  91,  58,  -5,  45, 123,  40, -22, -29, -30,
 -31, 269, -32, -34, -35, 276, 278,  -3,  -5, 256,
 -11, -12, 266,  -5, 256,  -5, 256,  -3, 256,  -6,
 256, 265,  -3, -10, -20, 269,  40, 123,  34,  91,
  58, 264, 261, 260, 259, 275, 262, 274, 279, 266,
 265, 267, 268, 272, 276, 278, 270, -28, -19,  10,
 256, -21,  58,  -5, 256,  -5, 269, -20,  -5, 256,
  -5, 256, 263, 273, 263,  43,  45,  94,  42,  47,
  92,  61,  60,  62,  -5, 256, 259, 259,  -5, -23,
 256, -27,  -5, -28, -28, -28,  -5,  -5,  -3, 256,
  -5,  -5,  45,  -5,  -5,  -2, 256, -33, 277,  10,
 256, -21, 263,  -5,  -3,  -5, 256,  93,  -5, 256,
  -5, 256,  -5, 256,  -5, 256,  -5, 256,  -5, 256,
  -5, 256,  -5, 256,  -5, 256, -16,  -5,  -5, -16,
 -17, 125,  41, -24, 271,  -5, -33, -33, -33,  -5,
  -5,  -3, 256,  -5, 256,  -5,  -3, 256,  -5,  -3,
 -17, -16,  -5, -17, -25,  -3, 256, -26, -13,  -2,
 256, 270, 264,  -2, 270 };
short yydef[]={

   1,  -2,   2,   3,  25,   0,   0,   0,  14,   0,
 131,  20,  21,   0,  24, 135, 136, 114,   0,  -2,
  -2,   0,   0,   0,  31,  32,   0,   0,  38,  39,
   0,   0,   0,   0,   0,   0,   0, 102, 117, 118,
 119, 113, 114, 114, 114,   0,   0,   4,   0,   7,
  26,  27,   0,   0,  10,   0,  13,  15,  16,   0,
  19, 132,  22,  23,  89,  90,  91,  92,  93,  94,
  95,  96,  74,  75,  76,  77,  78,  79,  80,  81,
  82,  83,  84,  85,  86,  87,  88,   0,   0,  69,
  71,  97,   0,   0, 126,   0,  72,  73,   0,  35,
  36,  37,  40,   0,  42,   0,   0,   0,   0,   0,
   0,   0,   0,   0,  47,  48,   0,   0,   0,   0,
 101, 103, 104,   0,   0,   0, 123,   0,   5,   6,
   0,   0,   0,   0,   0, 115, 116, 128, 127,  68,
  70,  98,  99,   0, 130,  33,  34,  41,  43,  44,
  45,  46,  49,  50,  51,  52,  53,  54,  55,  56,
  -2,  58,  -2,  60,  -2,  62,   0,  66,  66,   0,
  65, 133, 134, 107, 106, 105, 120, 121, 122, 124,
   0,   8,   9,  -2,  -2,   0,  17,  18, 125, 129,
  63,  67,  33,  64,   0,  11,  12, 100,   0, 109,
 110, 111,  -2, 108, 112 };
#ifndef lint
static char yaccpar_sccsid[] = "@(#)yaccpar	4.1	(Berkeley)	2/11/83";
#endif not lint

#
# define YYFLAG -1000
# define YYERROR goto yyerrlab
# define YYACCEPT return(0)
# define YYABORT return(1)

/*	parser for yacc output	*/

#ifdef YYDEBUG
int yydebug = 0; /* 1 for debugging */
#endif
YYSTYPE yyv[YYMAXDEPTH]; /* where the values are stored */
int yychar = -1; /* current input token number */
int yynerrs = 0;  /* number of errors */
short yyerrflag = 0;  /* error recovery flag */

yyparse() {

	short yys[YYMAXDEPTH];
	short yyj, yym;
	register YYSTYPE *yypvt;
	register short yystate, *yyps, yyn;
	register YYSTYPE *yypv;
	register short *yyxi;

	yystate = 0;
	yychar = -1;
	yynerrs = 0;
	yyerrflag = 0;
	yyps= &yys[-1];
	yypv= &yyv[-1];

 yystack:    /* put a state and value onto the stack */

#ifdef YYDEBUG
	if( yydebug  ) printf( "state %d, char 0%o\n", yystate, yychar );
#endif
		if( ++yyps> &yys[YYMAXDEPTH] ) { yyerror( "yacc stack overflow" ); return(1); }
		*yyps = yystate;
		++yypv;
		*yypv = yyval;

 yynewstate:

	yyn = yypact[yystate];

	if( yyn<= YYFLAG ) goto yydefault; /* simple state */

	if( yychar<0 ) if( (yychar=yylex())<0 ) yychar=0;
	if( (yyn += yychar)<0 || yyn >= YYLAST ) goto yydefault;

	if( yychk[ yyn=yyact[ yyn ] ] == yychar ){ /* valid shift */
		yychar = -1;
		yyval = yylval;
		yystate = yyn;
		if( yyerrflag > 0 ) --yyerrflag;
		goto yystack;
		}

 yydefault:
	/* default state action */

	if( (yyn=yydef[yystate]) == -2 ) {
		if( yychar<0 ) if( (yychar=yylex())<0 ) yychar = 0;
		/* look through exception table */

		for( yyxi=yyexca; (*yyxi!= (-1)) || (yyxi[1]!=yystate) ; yyxi += 2 ) ; /* VOID */

		while( *(yyxi+=2) >= 0 ){
			if( *yyxi == yychar ) break;
			}
		if( (yyn = yyxi[1]) < 0 ) return(0);   /* accept */
		}

	if( yyn == 0 ){ /* error */
		/* error ... attempt to resume parsing */

		switch( yyerrflag ){

		case 0:   /* brand new error */

			yyerror( "syntax error" );
		yyerrlab:
			++yynerrs;

		case 1:
		case 2: /* incompletely recovered error ... try again */

			yyerrflag = 3;

			/* find a state where "error" is a legal shift action */

			while ( yyps >= yys ) {
			   yyn = yypact[*yyps] + YYERRCODE;
			   if( yyn>= 0 && yyn < YYLAST && yychk[yyact[yyn]] == YYERRCODE ){
			      yystate = yyact[yyn];  /* simulate a shift of "error" */
			      goto yystack;
			      }
			   yyn = yypact[*yyps];

			   /* the current yyps has no shift onn "error", pop stack */

#ifdef YYDEBUG
			   if( yydebug ) printf( "error recovery pops state %d, uncovers %d\n", *yyps, yyps[-1] );
#endif
			   --yyps;
			   --yypv;
			   }

			/* there is no state on the stack with an error shift ... abort */

	yyabort:
			return(1);


		case 3:  /* no shift yet; clobber input char */

#ifdef YYDEBUG
			if( yydebug ) printf( "error recovery discards char %d\n", yychar );
#endif

			if( yychar == 0 ) goto yyabort; /* don't discard EOF, quit */
			yychar = -1;
			goto yynewstate;   /* try again in the same state */

			}

		}

	/* reduction by production yyn */

#ifdef YYDEBUG
		if( yydebug ) printf("reduce %d\n",yyn);
#endif
		yyps -= yyr2[yyn];
		yypvt = yypv;
		yypv -= yyr2[yyn];
		yyval = yypv[1];
		yym=yyn;
			/* consult goto table to find next state */
		yyn = yyr1[yyn];
		yyj = yypgo[yyn] + *yyps + 1;
		if( yyj>=YYLAST || yychk[ yystate = yyact[yyj] ] != -yyn ) yystate = yyact[yypgo[yyn]];
		switch(yym){
			
case 2:
# line 263 "logo.y"
{
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
#endif
		yyprompt(1);
	} break;
case 3:
# line 270 "logo.y"
{
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
	} break;
case 4:
# line 285 "logo.y"
{
		catch(doedit(););
		yyval = -1;
	} break;
case 5:
# line 289 "logo.y"
{
		catch(yyval=(int)(*keywords[yypvt[-2]].lexval)(yypvt[-1]););} break;
case 6:
# line 291 "logo.y"
{cm1er1(yypvt[-2]);uperror;} break;
case 7:
# line 292 "logo.y"
{cm1er2(yypvt[-1]);uperror;} break;
case 8:
# line 293 "logo.y"
{
		catch((*keywords[yypvt[-3]].lexval)(yypvt[-2],yypvt[-1]);); yyval = -1;} break;
case 9:
# line 295 "logo.y"
{cm2er1(yypvt[-3]);uperror;} break;
case 10:
# line 296 "logo.y"
{cm2er2(yypvt[-1]);uperror;} break;
case 11:
# line 297 "logo.y"
{
#ifndef SMALL
		catch(pprop(yypvt[-3],yypvt[-2],yypvt[-1]););
#endif
		yyval = -1;
	} break;
case 12:
# line 303 "logo.y"
{
		if (!errtold) {
			extra();
			puts("Pprop takes three inputs.");
		}
		uperror;
	} break;
case 13:
# line 310 "logo.y"
{
		if (!errtold) {
			missing();
			puts("Pprop takes three inputs.");
		}
		uperror;
	} break;
case 14:
# line 317 "logo.y"
{ yyval= -1; } break;
case 15:
# line 318 "logo.y"
{
		catch((*keywords[yypvt[-1]].lexval)();); yyval= -1;} break;
case 16:
# line 320 "logo.y"
{
		if (!errtold) {
			extra();
			pf1("%s takes no inputs.\n",keywords[yypvt[-1]].word);
		}
		uperror;
	} break;
case 17:
# line 327 "logo.y"
{
		catch(go(yypvt[-1]););
		yyval= -1;
		} break;
case 18:
# line 331 "logo.y"
{goerr1();uperror;} break;
case 19:
# line 332 "logo.y"
{goerr2();uperror;} break;
case 20:
# line 333 "logo.y"
{
		if ((yypvt[-0] != -1) && !endflag) {
			if (!errtold)
				pf1("You don't say what to do with %l.\n",yypvt[-0]);
			uperror;
		}
		yyval = yypvt[-0];
	} break;
case 21:
# line 341 "logo.y"
{
		if (yypvt[-0]== -1)
			uperror
		else
			catch(proccreate(yypvt[-0]););
			yyval = -1;
	} break;
case 22:
# line 348 "logo.y"
{
		if (thisrun && !pflag) {
			yyval = yypvt[-1];
		} else {
			if((yypvt[-1] != -1) && !endflag) {
				if (!errtold)
					pf1("You don't say what to do with %l\n",yypvt[-1]);
				uperror;
			}
		}
	} break;
case 23:
# line 359 "logo.y"
{
		if (!errtold) {
			if (popname[0])
				printf("Too many inputs to %s.\n",popname);
			else
				extra();
		}
		uperror;
	} break;
case 26:
# line 371 "logo.y"
{
			if (yypvt[-0] == -1) {
				if (!errtold) {
					printf("%s didn't output.\n",
						popname);
				}
				uperror;
			}
		} break;
case 28:
# line 382 "logo.y"
{ yyline=((struct object *)yypvt[-0])->obint; mfree(yypvt[-0]); yyval = 0;} break;
case 33:
# line 389 "logo.y"
{
		catch(yyval=(int)(*keywords[yypvt[-2]].lexval)(yypvt[-1],yypvt[-0]););
	} break;
case 34:
# line 392 "logo.y"
{op2er1(yypvt[-2],yypvt[-1]);uperror;} break;
case 35:
# line 393 "logo.y"
{op2er2(yypvt[-1]);uperror;} break;
case 36:
# line 394 "logo.y"
{
		catch(yyval=(int)(*keywords[yypvt[-1]].lexval)(yypvt[-0]););
	} break;
case 37:
# line 397 "logo.y"
{op1err(yypvt[-1]);uperror;} break;
case 38:
# line 398 "logo.y"
{
		catch(yyval=(int)(*keywords[yypvt[-0]].lexval)(););
	} break;
case 40:
# line 402 "logo.y"
{ yyval=yypvt[-0]; } break;
case 41:
# line 403 "logo.y"
{ yyval=yypvt[-1]; } break;
case 42:
# line 404 "logo.y"
{
		catch(yyval=(int)alllk(yypvt[-0]););
		} break;
case 43:
# line 407 "logo.y"
{
		catch(yyval=(int)add(yypvt[-2],yypvt[-0]););
	} break;
case 44:
# line 410 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 45:
# line 411 "logo.y"
{
		catch(yyval=(int)sub(yypvt[-2],yypvt[-0]););
	} break;
case 46:
# line 414 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 47:
# line 415 "logo.y"
{
		catch(yyval=(int)opp(yypvt[-0]););
	} break;
case 48:
# line 418 "logo.y"
{unerr('-');uperror;} break;
case 49:
# line 419 "logo.y"
{
		catch(yyval=(int)lpow(yypvt[-2],yypvt[-0]););
	} break;
case 50:
# line 422 "logo.y"
{ inferr(yypvt[-2],yypvt[-1]);uperror; } break;
case 51:
# line 423 "logo.y"
{
		catch(yyval=(int)mult(yypvt[-2],yypvt[-0]););
	} break;
case 52:
# line 426 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 53:
# line 427 "logo.y"
{
		catch(yyval=(int)div(yypvt[-2],yypvt[-0]););
	} break;
case 54:
# line 430 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 55:
# line 431 "logo.y"
{
		catch(yyval=(int)rem(yypvt[-2],yypvt[-0]););
	} break;
case 56:
# line 434 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 57:
# line 435 "logo.y"
{
		catch(yyval=(int)equal(yypvt[-2],yypvt[-0]);)
	} break;
case 58:
# line 438 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 59:
# line 439 "logo.y"
{
		catch(yyval=(int)lessp(yypvt[-2],yypvt[-0]););
	} break;
case 60:
# line 442 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 61:
# line 443 "logo.y"
{
		catch(yyval=(int)greatp(yypvt[-2],yypvt[-0]););
	} break;
case 62:
# line 446 "logo.y"
{inferr(yypvt[-2],yypvt[-1]);uperror;} break;
case 63:
# line 447 "logo.y"
{
		catch(yyval=multiop(yypvt[-2],globcopy(multarg)););
		lfree(multarg);
		multarg = 0;
	} break;
case 64:
# line 452 "logo.y"
{
		catch(yyval=multiop(yypvt[-2],globcopy(multarg)););
		lfree(multarg);
		multarg = 0;
	} break;
case 65:
# line 457 "logo.y"
{yyval=yypvt[-1];} break;
case 66:
# line 459 "logo.y"
{
		catch(multarg = glbcons(yypvt[-0],0););
		mfree(yypvt[-0]);
		multnum = 1;
	} break;
case 67:
# line 464 "logo.y"
{
		catch(multarg = glbcons(yypvt[-1],multarg););
		mfree(yypvt[-1]);
		multnum++;
	} break;
case 68:
# line 469 "logo.y"
{
		strcpy(titleptr,"\n");
		yyval=yypvt[-2];
	} break;
case 69:
# line 473 "logo.y"
{
		strcpy(titleptr,"\n");
		yyval=yypvt[-1];
	} break;
case 70:
# line 477 "logo.y"
{
		mfree(yypvt[-2]);
		terr();
		yyval= -1;
	} break;
case 71:
# line 482 "logo.y"
{
		mfree(yypvt[-1]);
		terr();
		yyval= -1;
	} break;
case 72:
# line 487 "logo.y"
{
		titleptr=cpystr(titlebuf,"to ",
			((struct object *)(yypvt[-0]))->obstr,NULL);
		yyval=yypvt[-0];
	} break;
case 73:
# line 492 "logo.y"
{
		if (!errtold) printf("Can't redefine primitive %s\n",
			keywords[yypvt[-0]].word);
		uperror;
	} break;
case 97:
# line 501 "logo.y"
{titleptr=cpystr(titleptr," :",
			((struct object *)(yypvt[-0]))->obstr,NULL);
		mfree(yypvt[-0]);
	} break;
case 98:
# line 505 "logo.y"
{titleptr=cpystr(titleptr," :",
			((struct object *)(yypvt[-0]))->obstr,NULL);
		mfree(yypvt[-0]);
	} break;
case 99:
# line 509 "logo.y"
{yyval=yypvt[-0];} break;
case 100:
# line 510 "logo.y"
{
		yyval=yypvt[-1];
		frmpop(yypvt[-1]);
	} break;
case 101:
# line 514 "logo.y"
{
		if (!errtold) printf("Not enough inputs to %s\n",
			proclist->procname->obstr);
		uperror;
	} break;
case 104:
# line 520 "logo.y"
{
		catch(argassign(yypvt[-0]););
	} break;
case 105:
# line 523 "logo.y"
{
		catch(argassign(yypvt[-0]););
	} break;
case 106:
# line 526 "logo.y"
{procprep();} break;
case 107:
# line 527 "logo.y"
{yyline=1; yyval = -1;} break;
case 108:
# line 528 "logo.y"
{
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		yyval=yypvt[-0];
	} break;
case 109:
# line 537 "logo.y"
{
		popname[0] = '\0';
		if (pflag) yyline++;
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		yyval=yypvt[-0];
	} break;
case 110:
# line 547 "logo.y"
{
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
	} break;
case 113:
# line 566 "logo.y"
{
		catch(newproc(yypvt[-0]););
	} break;
case 114:
# line 569 "logo.y"
{yyval = -1;} break;
case 115:
# line 570 "logo.y"
{
		popname[0] = '\0';
#ifdef PAUSE
		if (psigflag) dopause();
		if (thisrun && thisrun->str == (struct object *)(-1))
			yyprompt(1);
#endif
		yyval=yypvt[-0];
	} break;
case 116:
# line 579 "logo.y"
{
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
	} break;
case 120:
# line 597 "logo.y"
{
		unrun();
		yyval = yypvt[-1];
		strcpy(popname,"run");
	} break;
case 121:
# line 602 "logo.y"
{
		unrun();
		yyval = yypvt[-1];
		strcpy(popname,"repeat");
	} break;
case 122:
# line 607 "logo.y"
{
		unrun();
		yyval = yypvt[-1];
		strcpy(popname,"if");
	} break;
case 123:
# line 612 "logo.y"
{
		catch(dorun(yypvt[-0],(FIXNUM)0););
	} break;
case 124:
# line 615 "logo.y"
{
		catch(dorep(yypvt[-1],yypvt[-0]););
	} break;
case 125:
# line 618 "logo.y"
{
		{
			int i;

			catch(i = truth(yypvt[-2]););
			if (i) {
				catch(dorun(yypvt[-1],(FIXNUM)0););
				mfree(yypvt[-0]);
			} else {
				catch(dorun(yypvt[-0],(FIXNUM)0););
				mfree(yypvt[-1]);
			}
		}
	} break;
case 126:
# line 632 "logo.y"
{
		if (!errtold) printf("Not enough inputs to if.\n");
		uperror;
	} break;
case 128:
# line 637 "logo.y"
{
		unrun();
		yyval = yypvt[-1];
	} break;
case 129:
# line 641 "logo.y"
{
		{
			int i;

			catch(i = truth(yypvt[-2]););
			if (i) {catch(dorun(yypvt[-1],(FIXNUM)0););}
			else {
				catch(dorun(0,(FIXNUM)0););
				mfree(yypvt[-1]);
			}
		}
	} break;
case 130:
# line 653 "logo.y"
{
		if ((int)keywords[yypvt[-2]].lexval==currtest) {
			catch(dorun(yypvt[-1],(FIXNUM)0););
		} else {
			catch(dorun(0,(FIXNUM)0););
			mfree(yypvt[-1]);
		}
	} break;
		}
		goto yystack;  /* stack new state and value */

	}
