/* <STRUNG.H> - declarations for uppercase string functions (KCC invention)
**
**	(c) Copyright Ken Harrenstien 1989
**
** PDP-10 systems have always done the right thing by handling strings
** in a case-independent way.  These KCC-invented facilities help to
** perpetuate this winnage.  They are not found elsewhere, but
** can readily be ported.
*/

#ifndef _STRUNG_INCLUDED
#define _STRUNG_INCLUDED

/* External name disambiguation */

/* uppercase means case InSeNsItIvE */
#pragma private define strCMP	str000
#pragma private define strnCMP	str001
#pragma private define strCHR	str002
#pragma private define strSTR	str003

#pragma private define memCMP	mem000

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cgen:strung.c */
extern int strCMP P_((char *s1,char *s2));
extern int strnCMP P_((char *s1,char *s2,int n));
extern char *strCHR P_((char *s,int c));
extern char *strSTR P_((char *s1,char *s2));
extern int memCMP P_((char *s1,char *s2,int len));

#undef P_

#endif /* ifndef _STRUNG_INCLUDED */
