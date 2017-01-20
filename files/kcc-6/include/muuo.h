/* <MUUO.H> - TOPS-10 monitor call support
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _MUUO_INCLUDED
#define _MUUO_INCLUDED

#include <c-env.h>		/* To see whether to define WTSUUO, CSIUUO */

/* Auxiliaries, not for external use */
#define MU__OP (0777<<27)	/* Opcode field of PDP-10 instr */
#define MU__AC (017<<23)	/* AC field */
#define MU__E  0777777		/* E field (RH) */
#define MU__DEFAC 2		/* AC number used by MUUOXn support routines */
#define MU__INSCH(op,ch) (((op)&(MU__OP|MU__E))|((ch&017)<<23))

/* External macros, use these for any DEC MUUO invocation.
**	op - MUUO name, a string literal (e.g. "OPEN")
**	ch - a channel number, 0-017
**	ac - an integer argument value, type (int)
**	av - return value address, type (int *)
**	e  - a word address, type (int *)
*/
#include <uuosym.h>		/* For standard DEC MUUOs and symbols */
#define MUUO(op)		_xctskip(uuosym(op))
#define MUUO_CH(op,ch)		_xctskip(MU__INSCH(uuosym(op), ch))
#define MUUO_AC(op,ac)		muuox1(MU__INSCH(uuosym(op),MU__DEFAC), ac)
#define MUUO_VAL(op,av)		muuox2(MU__INSCH(uuosym(op),MU__DEFAC), av)
#define MUUO_ACVAL(op,ac,av)	muuox3(MU__INSCH(uuosym(op),MU__DEFAC), ac, av)
#define MUUO_TTY(op,e)   _xctskip((uuosym(op)&(MU__OP|MU__AC))|((int)e&MU__E))
#define MUUO_IO(op,ch,e) _xctskip(MU__INSCH(uuosym(op)&MU__OP,ch)|((int)e&MU__E))

#if SYS_WTS
/* External macros for WAITS-specific UUO invocation */
#include <wtssym.h>		/* For WAITS symbols */
#define WTSUUO(op)		_xctskip(wtssym(op))
#define WTSUUO_CH(op,ch)	_xctskip(MU__INSCH(wtssym(op), ch))
#define WTSUUO_AC(op,ac)	muuox1(MU__INSCH(wtssym(op),MU__DEFAC), ac)
#define WTSUUO_VAL(op,av)	muuox2(MU__INSCH(wtssym(op),MU__DEFAC), av)
#define WTSUUO_ACVAL(op,ac,av)	muuox3(MU__INSCH(wtssym(op),MU__DEFAC), ac, av)
#define WTSUUO_TTY(op,e) _xctskip((wtssym(op)&(MU__OP|MU__AC))|((int)e&MU__E))
#define WTSUUO_IO(op,ch,e) _xctskip(MU__INSCH(wtssym(op)&MU__OP,ch)|((int)e&MU__E))
#endif /* SYS_WTS */

#if SYS_CSI
/* External macros for CSI-specific UUO invocation */
#include <csisym.h>		/* For CSI symbols */
#define CSIUUO(op)		_xctskip(csisym(op))
#define CSIUUO_CH(op,ch)	_xctskip(MU__INSCH(csisym(op), ch))
#define CSIUUO_AC(op,ac)	muuox1(MU__INSCH(csisym(op),MU__DEFAC), ac)
#define CSIUUO_VAL(op,av)	muuox2(MU__INSCH(csisym(op),MU__DEFAC), av)
#define CSIUUO_ACVAL(op,ac,av)	muuox3(MU__INSCH(csisym(op),MU__DEFAC), ac, av)
#define CSIUUO_TTY(op,e) _xctskip((csisym(op)&(MU__OP|MU__AC))|((int)e&MU__E))
#define CSIUUO_IO(op,ch,e) _xctskip(MU__INSCH(csisym(op)&MU__OP,ch)|((int)e&MU__E))
#endif /* SYS_CSI */

/* Support routines */
#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cgen:muuo.c */
extern int muuox1 P_((int instr,int ac));
extern int muuox2 P_((int instr,int *ra));
extern int muuox3 P_((int instr,int ac,int *ra));
extern int _xctskip P_((int instr));
extern int muuo P_((int op,int ac,int *e));

#undef P_

#endif /* ifndef _MUUO_INCLUDED */
