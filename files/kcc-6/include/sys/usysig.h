/* <SYS/USYSIG.H> - definitions for KCC USYS signal support
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
*/

#ifndef _SYS_USYSIG_INCLUDED
#define _SYS_USYSIG_INCLUDED

/* USYS_BEG should be invoked at start of every USYS routine. */
#define USYS_BEG() ++USYS_VAR_REF(sigusys)

/* USYS_END should be invoked at end of every USYS routine.
**	It returns 0 if nothing happened, -1 if an interrupt went off,
**	and +1 if an interrupt happened but the handler allows restarting.
*/
#define USYS_END() ((--USYS_VAR_REF(sigusys) <= 0 && USYS_VAR_REF(sigpendmask)) ? \
			_sigtrigpend() : 0)

/* Useful auxiliaries for returning from USYS calls */
#define USYS_RET(val)      return((void)USYS_END(), val)
#define USYS_RETVOLATILE(var) if(1){ int tmpret = (var); \
		   return((void)USYS_END(), tmpret); } else /* null stmt */
#define USYS_RETERR(err)   return((void)USYS_END(), errno = err, -1)
#define USYS_RETINT()      USYS_RETERR(EINTR)

/* Routine declarations */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
#if SYS_T20+SYS_10X
extern int _sigtrigpend P_((void));
extern void __dir P_((void));
extern void __eir P_((void));
extern unsigned int _cnvmask P_((unsigned int mask));
#endif 
#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
extern int _sigtrigpend P_((void));
#endif 
#endif 

#undef P_


/* Assembler versions of macros.
** These are strings suitable for giving to the asm() construct.
*/

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
