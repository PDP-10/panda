#include "logo.h"
#include <setjmp.h>
#include <signal.h>

char *ostring;
FILE *ofile;
#ifdef DEBUG
int memtrace=0;
extern int yydebug;
#endif

#ifdef PAUSE

int errpause=0;

seterrpause() {
	errpause++;
}

clrerrpause() {
	errpause = 0;
}
#endif

struct object *stringform(arg)
register struct object *arg;
{
	char str[IBUFSIZ];
	struct object *bigsave();
#ifdef DEBUG
	int omemt;

	omemt = memtrace;
	memtrace = 0;
#endif
	ostring = &str[0];
	str[0] = '\0';	/* in case of empty */
	tyobj(arg);
	ostring = 0;
#ifdef DEBUG
	memtrace = omemt;
#endif
	return (bigsave(str));
}

putch(ch)
register ch;
{
	if (ch != -1) {
		putchar(ch);
	}
	return (ch);
}

/* VARARGS */
char *cpystr(to,f1,f2,f3,f4,f5,f6,f7,f8,f9,f0)
register char *to;
char *f1,*f2,*f3,*f4,*f5,*f6,*f7,*f8,*f9,*f0;
{
	char *out,**in;

	out = to;
	in = &f1;
	while (*in) {
		strcpy(out,*in);
		out += strlen(*in);
	/*	in++;	*/
		in--;	/* TOPS-20 */
	}
	return (out);
}

jmp_buf env;

extern errrec();

int floflo() {
	signal(SIGFPE,floflo);
	puts("Arithmetic overflow.");
	errhand();
}

enter()
{
	register x;

	if (x=setjmp(env)) {
		return(x);
	} else {
		onintr(errrec,1);
		signal(SIGFPE,floflo);
		return (yyparse());
	}
}

leave(val)
{
	putchar('\n');
	longjmp(env,val);
}

int sigarg;
int (*intfun)();
extern sigquit();
#ifdef PAUSE
int pausesig = PAUSESIG;
int othersig = OTHERSIG;
int psigflag = 0;

sigpaws() {	/* User signals a pause request */
	signal(pausesig,sigpaws);
	psigflag++;
}
#endif

onintr(inttf,val)
register int (*inttf)(),val;
{
	sigarg = val;
#ifdef PAUSE
	signal(othersig,sigquit);
	signal(pausesig,sigpaws);
#else
	signal(SIGINT,sigquit);
	signal(SIGQUIT,sigquit);
#endif
	intfun = inttf;
}

#ifdef DEBUG
int deb_quit=0;
#endif

sigquit()
{
#ifdef DEBUG
	if(deb_quit) abort();
#endif
	alarm(0);
#ifdef PAUSE
	signal(othersig,sigquit);
#else
	signal(SIGINT,sigquit);
	signal(SIGQUIT,sigquit);
#endif
	(*intfun)(sigarg);
}

#ifdef DEBUG
setdebquit() {
	deb_quit++;
}

setmemtrace() {
	memtrace++;
}

setyaccdebug() {
	yydebug++;
}
#endif

#ifdef PAUSE
setipause() {
	pausesig = SIGINT;
	othersig = SIGQUIT;
}

setqpause() {
	pausesig = SIGQUIT;
	othersig = SIGINT;
}
#endif

putc1(cha)
register cha;
{
	if(ostring)
	{
		*ostring++=cha;
		*ostring=0;
	}
	else if(ofile)fputc(cha,ofile);
	else putchar(cha);
}
sputs(str)
register char *str;
{
	register char c;

	if(ofile)
		while (c = *str++) fputc(c&0177,ofile);
	else if(ostring){
		while (c = *str++) *ostring++ = c /* &0177 */ ;
		*ostring = '\0';
	}
	else
		while (c = *str++) fputc(c&0177,stdout);
}
nputs(str)
register char *str;
{
	register char c;

	while (c = *str++) fputc(c,stdout);
}

/*VARARGS*/
pf1(str,a1,a2,a3,a4)
register char *str;
struct object *a1,*a2,*a3,*a4;
{
	register c;
	register struct object **arg;
#ifdef DEBUG
	int omemt;

	omemt = memtrace;
	memtrace = 0;
#endif
	arg= &a1;
	while(c= *str++){
		if(c=='%'){
			c= *str++;
			if(c=='d'){
				if(ostring){
					sprintf(ostring,"%d",(int)(*arg/*++*/--));
					ostring+=strlen(ostring);
				}else if(ofile)
					fprintf(ofile,"%d",(int)(*arg/*++*/--));
				else printf("%d",(int)(*arg/*++*/--));
			} else if(c=='o'){
				if(ostring){
					sprintf(ostring,"%o",(int)(*arg/*++*/--));
					ostring+=strlen(ostring);
				}else if(ofile)
					fprintf(ofile,"%o",(int)(*arg/*++*/--));
				else printf("%o",(int)(*arg/*++*/--));
			} else if(c=='s'){
				if(ostring){
					strcpy(ostring,(char *)(*arg/*++*/--));
					ostring += strlen(ostring);
				} else if (ofile)
					fprintf(ofile,"%s",(char *)(*arg/*++*/--));
				else printf("%s",(char *)(*arg/*++*/--));
			} else if(c=='l'){
				if(!listp(*arg)){
					if(emptyp(*arg)) sputs("empty");
					else if(stringp(*arg) && !nump(*arg))
						putc1('\"');
				}
				fty1(*arg/*++*/--);
			} else if(c=='p') {
				if(!stringp(*arg)) {
					*arg=stringform(*arg);
					sputs((*arg)->obstr);
					mfree(*arg);
				} else sputs((*arg)->obstr);
				arg/*++*/--;
			}
			else putc1(c);
		}
		else putc1(c);
	}
#ifdef DEBUG
	memtrace = omemt;
#endif
}
