/* <SYS/USYSIG.H> - definitions for KCC USYS signal support
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
*/

#ifndef _SYS_USYSIG_INCLUDED
#define _SYS_USYSIG_INCLUDED

/* USYS_BEG should be invoked at start of every USYS routine. */
#define USYS_BEG() ++_sigusys

/* USYS_END should be invoked at end of every USYS routine.
**	It returns 0 if nothing happened, -1 if an interrupt went off,
**	and +1 if an interrupt happened but the handler allows restarting.
*/
#define USYS_END() ((--_sigusys <= 0 && _sigpendmask) ? \
			_sigtrigpend() : 0)

/* Useful auxiliaries for returning from USYS calls */
#define USYS_RET(val)      return((void)USYS_END(), val)
#define USYS_RETVOLATILE(var) if(1){ int tmpret = (var); \
		   return((void)USYS_END(), tmpret); } else /* null stmt */
#define USYS_RETERR(err)   return((void)USYS_END(), errno = err, -1)
#define USYS_RETINT()      USYS_RETERR(EINTR)

/* Routine declarations */
extern int _sigusys;
extern unsigned _sigpendmask, _sigblockmask;
extern struct sigstack _sigstk;
extern struct sigcontext *_sigframe;
extern int _sigtrigpend();
extern int _intlev;		/* Nonzero if at interrupt level */

/* Assembler versions of macros.
** These are strings suitable for giving to the asm() construct.
*/
#define USYS_BEG_ASM "	aos .sigusys\n"
#define USYS_END_ASM "\
	sosg .sigusys\n\
	 skipn .sigpendmask\n\
	  caia\n\
	   pushj 17,.sigtrigpend\n"

/* Assembler offsets into sigcontext structure. */
#define SIGCONTEXT_ASM "\
	sc.pc==0	\n\
	sc.pcflgs==1	\n\
	sc.osinf==2	\n\
	sc.sig==3	\n\
	sc.prev==4	\n\
	sc.stkflg==5	\n\
	sc.mask==6	\n\
	sc.acs==7	\n\
	scsiz==027	\n"


#endif /* ifndef _SYS_USYSIG_INCLUDED */
