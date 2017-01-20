/* Internal routines from cgen:urt.c */

#ifndef _SYS_URTINT_INCLUDED
#define _SYS_URTINT_INCLUDED

#include <c-env.h>
#include <stdarg.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* urt.c */
extern void _vfcpy P_((int fkhndl));
extern void _vfshr P_((int fkhndl));
extern void _runtm P_((void));
extern void _panic P_((char *msg));
extern long _nfbsz P_((int ourbsz, int filbsz,long fillen));
#if SYS_T20+SYS_10X			
extern int _acces P_((int dirno));
extern char *_fncon P_((char *dst,const char *src,int abs,int defgen));
#if SYS_T20
extern int _file7 P_((char *path));
extern int _tfile P_((char *suffix));
extern int _rljfn P_((int jfn));
extern int _gtfdb P_((int jfn,int word));
extern int _jfndir P_((int jfn,int dir));
extern char *_dirst P_((int dirno,char *buf));
extern int _prdir P_((char *dir, int flags, va_list ap));
extern int _rcdir P_((char *dir));
extern int _chkac P_((int facc,int dacc,int jfn));
extern int _getdir P_((void));
extern int _chdir P_((int dirno));
extern void _wfork P_((int pid));
extern int _jchmod P_((int jfn,int mode));
#endif 
#endif	

/* cusys:sigvec.c */
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI	
#if SYS_T20+SYS_10X		
extern void _siginit P_((void));
#endif 
extern void _raise P_((int sig));
#endif 

/* cusys:dir.c */
extern int _crdir P_((char *dir,int pflags,va_list ap));

#undef P_

#endif /* ifndef _SYS_URTINT_INCLUDED */
