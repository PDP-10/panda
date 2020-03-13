/*	This file contains most of the error messages for LOGO, along with
*	the functions that print the various messages.
*
*	Copyright (C) 1979, The Children's Museum, Boston, Mass.
*	Written by Douglas B. Klunder.
*/
#include "logo.h"
extern int yychar,errtold;
extern short yyerrflag;
extern char *ibufptr;
extern char charib;
extern int letflag;
extern struct lexstruct keywords[];

aerr2(etype,arg,op)	/* This handles an unknown second input to infix
			*  arithmetic operations.  */
register char *etype,*arg;
char op;
{
	if (!errtold) {
		nputs(etype);
		pf1(" of %l and what?\n",arg);
		putchar(op);
		puts(" must have two numbers for inputs.");
		errtold++;
	}
}
cm2er1(op)
register op;
{
	if (!errtold) {
		extra();
		nputs(keywords[op].word);
		puts(" takes only two inputs.");
		errtold++;
	}
}
cm2er2(op)
register op;
{
	if (!errtold) {
		missing();
		nputs(keywords[op].word);
		puts(" takes two inputs.");
		errtold++;
	}
}
cm1er1(op)	/* Extra stuff on line beyond input to one-input command. */
register op;
{
	if (!errtold) {
		extra();
		nputs(keywords[op].word);
		puts(" takes only one input.");
		errtold++;
	}
}
cm1er2(op)	/* No input to one-input command. */
register op;
{
	if (!errtold) {
		missing();
		nputs(keywords[op].word);
		pf1(" takes one input.\n");
		errtold++;
	}
}
goerr1()	/* Something beyond input to go. */
{
	if (!errtold) {
		extra();
		puts("go takes one input, which must be a line number.");
		errtold++;
	}
}
goerr2()	/* No input to go. */
{
	if (!errtold) {
		missing();
		puts("go takes one input, which must be a line number.");
		errtold++;
	}
}

unerr(c)	/* Unknown following unary - or +. */
register char c;
{
	if (!errtold) {
		putchar(c);
		puts(" what?");
		putchar(c);
		pf1(" must be followed by a number.\n");
		errtold++;
	}
}
inferr(arg,op)	/* Incorrect second input to infix operator. */
register char *arg;
register op;
{
	if (!errtold) {
		switch(op) {
			case '+': aerr2("sum",arg,'+');break;
			case '-': aerr2("difference",arg,'-');break;
			case '*': aerr2("product",arg,'*');break;
			case '/': aerr2("quotient",arg,'/');break;
			case '\\': aerr2("remainder",arg,'\\');break;
			case '<': aerr2("lessp",arg,'<');break;
			case '>': aerr2("greaterp",arg,'>');break;
			case '^': aerr2("pow",arg,'^');break;
			case '=':
				pf1("equalp of %l and what?\n",arg);
				puts("= takes two inputs.");
		}
		errtold++;
	}
}
op2er1(op,arg)	/* No second input to two-input operation. */
register op;
register char *arg;
{
	if (!errtold) {
		nputs(keywords[op].word);
		pf1(" of %l and what?\n",arg);
		nputs(keywords[op].word);
		puts(" takes two inputs.");
		errtold++;
	}
}
op2er2(op)	/* No inputs to two-input operation. */
register op;
{
	if (!errtold) {
		missing();
		nputs(keywords[op].word);
		puts(" takes two inputs.");
		errtold++;
	}
}
op1err(op)	/* No input to one-input operation. */
register op;
{
	if (!errtold) {
		missing();
		nputs(keywords[op].word);
		puts(" takes one input.");
		errtold++;
	}
}
terr()	/* Incorrect title. */
{
	puts("That doesn't look like a title to me.");
	errclear();
}
yyerror(str)
register char *str;
{
	if ( *str == 'y') {
		puts("Too many levels of recursion.");
		errtold++;
	}
/* yacc has two messages.  We ignore "syntax error" which has been dealt with
downlevel already, and on "yacc stack overflow" we must clear out the tables.
 */
}

logoyerror()	/* General unknown command. */
{
	if (yychar==1) return;
	puts("I don't understand that.");
	puts("Please submit a Logo bug report, telling what you typed,");
	puts(" and asking for a more specific error message.");
}
extra()	/* newline expected, not found. */
{
	puts("There's something extra on the line.");
}
missing()	/* something expected, not found. */
{
	puts("There's something missing on the line.");
}
errclear()	/* clear error status in editor. */
{
	ibufptr=NULL;
	yychar= -1;
	yyerrflag=0;
	letflag=0;
}
ungood(name,val)
register char *name,*val;
{
	nputs(name);
	pf1(" doesn't like %l as input.\n",val);
	errhand();
}
