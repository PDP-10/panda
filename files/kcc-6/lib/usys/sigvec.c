/*
**	Sigvec - Simulate 4.3BSD signal mechanism
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.169, 25-Nov-1988
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
** For TOPS-20/TENEX, signals are translated into PSI channels and vice versa.
**	As a convention for clarity, similar symbols use the string "sig" for
**	signals, and "chn" for channels.
** See the files CODSIG.DOC and SIGNAL.DOC for more background information
** on this code.
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI	/* Systems supported for */
				/* (T10+CSI not really in place yet) */

#include <stddef.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <string.h>		/* memcpy() etc */
#include <stdlib.h>		/* abort() */
#include <sys/usydat.h>		/* System data */
#include <sys/urtint.h>
#include <urtsud.h>		/* For reference to _urtsud.su_signal_type */

#if SYS_T20+SYS_10X		/* Only T20 and 10X from here until kill() */

#include <sys/c-debug.h>
#include <monsym.h>
#include <macsym.h>
#include <jsys.h>			/* Get JSYS defs */
#define NPSI 36				/* # of PSI channels */
#define chnmask(a) (1<<(35-(a)))	/* T20 PSI bit from chan # */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

static int xgetvec P_((int sig,struct sigvec *s));
static int xsetvec P_((int sig,struct sigvec *s));
static void xsigv P_((int chn,int cha));
static int doatis P_((int sigio));
static int setati P_((int chn,int chr,int defer));
static int settic P_((int chn,int ticode,int defer));
static void chn_dic P_((int cmask));
static void chn_aic P_((int cmask));
static int chvinstr P_((int chn));
static int jsr P_((int *addr));
static int jrst_psisg2 P_((void));
static int jrst_psier2 P_((void));
static int jrst_psyer2 P_((void));
static void psiinit P_((void));
static void hndhlt P_((int sig));
static void hndign P_((int sig));
static hndlr_t `gethnd` P_((int sig,int chn));
static void psiili P_((void));
static void psimsc P_((void));
static void psich0 P_((void));
static void errdummy P_((void));
static int ffoclr P_((unsigned *amask));
static void addmask P_((int sigbit,int chnbit));

#undef P_


/* Global variables
**	The following are declared by sig/usydat.h and
**	defined in urt.c:
** sigusys	- Positive if in USYS code (not user code)
** sigpendmask	- Pending signal mask
** sigblockmask - Signal block mask
** sigstk	- Signal stack state
** sigframe	- Pointer to current signal stack frame (for debugging)
*/

#define SNOCATCH (sigmask(SIGKILL)|sigmask(SIGSTOP))
				/* Signals that cannot be caught (handled) */
#define SNOIGNORE (sigmask(SIGKILL)|sigmask(SIGSTOP)|sigmask(SIGCONT))
				/* Signals that cannot be ignored */
#define SNOBLOCK (sigmask(SIGKILL)|sigmask(SIGSTOP)|sigmask(SIGCONT))
				/* Signals that cannot be blocked */

#if 0
		UNIX signal definitions

	This page defines all of the known UNIX signals.  This list
is derived from 4.2BSD and may be updated in the future.  For more
details see:
	The include file <signal.h>.
	The 4.2BSD UPM section for sigvec(2) as well as associated calls.
	H&S V2 Chap 21.
	The current ANSI C draft standard; library section on <signal.h>.

	Note that the current ANSI draft defines the following:
		SIGABRT - abnormal termination as for abort()
		SIGFPE - erroneous arithmetic operation (0-div or overflow)
		SIGILL - invalid function image (illegal instr)
		SIGINT - interactive attention signal
		SIGSEGV - invalid access to storage
		SIGTERM - termination request sent to program

There are three possible "actions" that the user can specify be taken for
each signal; these are:
	SIG_DFL (default)
	SIG_IGN (ignore)
	<addr>  (handle)

However, these settings have a variety of effects, depending on the
specific signal.  It is clearer to think in terms of exactly what
effects are possible when a signal is triggered, and on Unix there are
five of these as described by the SA_xxx constants.

#endif
	/* Unix Signal Actions */
#define SA_IGN 0		/* ignore */
#define SA_TRM 1		/* terminate */
#define SA_DMP 2		/* terminate with core dump */
#define SA_STP 3		/* stop (suspend) */
#define SA_HND 4		/* handle */
#define SA_N 5		/* # of actions */


/* Internal signal flags.  These must be defined here so we can be sure
** that we know where in a word they occur, and can refer to them with
** assembler code.  Those corresponding to SV_ flags should have the same
** values, but we still need to use the SF_ versions for safety.  If the
** SV_ values ever change, the SF_ ones will need to track them.
** DO NOT define SF_ flags in terms of SV_ ones, otherwise the assembler
** code may break!
*/
#define SF_SIGSTK 01	/* SV_ONSTACK   - Use signal stack */
#define SF_SYSINT 02	/* SV_INTERRUPT - OK to interrupt system call */
#define SF_HNDRST 04000	 /* SV_HNDLR_RESET - Reset to SIG_DFL when caught */
#define SF_OS	  010000 /* SV_XOS	- OS-dep sigvec ext significant */
#define SF_INTLEV 020000 /* SV_XINTLEV	- Handler should run at OS int lev */
#define SF_ASMHAN 040000 /* SV_XASMHAN	- Handler is special asm routine */

#define SF_ALLEXT (SF_SIGSTK|SF_SYSINT|SF_HNDRST|SF_OS|SF_INTLEV|SF_ASMHAN)
				/* Mask of all externally visible flags */
#if  (SF_SIGSTK != SV_ONSTACK) || (SF_SYSINT != SV_INTERRUPT) \
 || (SF_HNDRST != SV_HNDLR_RESET) \
 || (SF_OS != SV_XOS) || (SF_INTLEV != SV_XINTLEV) || (SF_ASMHAN != SV_XASMHAN)
#error SF_ flags don't match SV_ flags, fix definitions!
#endif
#if (SF_ALLEXT&0777777)==0
#error SF_ flags must all be in RH!
#endif

#if 0
	sigdef(sig,dfl,ign,han)	/* A/S Description */
		sig - SIGxxx signal name
		dfl/ign/han - one of the "sigact" signal action values
		A/S - Asynchronous or Synchronous
#endif

#define sigdefs \
sigdef(SIGHUP,	SA_TRM, SA_IGN, SA_HND)	/* A Hangup */\
sigdef(SIGINT,	SA_TRM, SA_IGN, SA_HND)	/* A Interrupt (TTY) */\
sigdef(SIGQUIT,	SA_DMP, SA_IGN, SA_HND)	/* A Quit      (TTY) */\
sigdef(SIGILL,	SA_DMP, SA_IGN, SA_HND)	/* S Illegal Instruction */\
sigdef(SIGTRAP,	SA_DMP, SA_IGN, SA_HND)	/* A/S Trace Trap */\
sigdef(SIGABRT,	SA_DMP, SA_IGN, SA_HND)	/* S "abort" (was SIGIOT) */\
sigdef(SIGEMT,	SA_DMP, SA_IGN, SA_HND)	/* S EMT instruction */\
sigdef(SIGFPE,	SA_DMP, SA_IGN, SA_HND)	/* S Floating Point Exception */\
sigdef(SIGKILL,	SA_TRM, SA_TRM, SA_TRM)	/* A Kill */\
sigdef(SIGBUS,	SA_DMP, SA_IGN, SA_HND)	/* S Bus Error */\
sigdef(SIGSEGV,	SA_DMP, SA_IGN, SA_HND)	/* S Segmentation Violation */\
sigdef(SIGSYS,	SA_DMP, SA_IGN, SA_HND)	/* S Bad argument to system call */\
sigdef(SIGPIPE,	SA_TRM, SA_IGN, SA_HND)	/* S Write on no-reader pipe */\
sigdef(SIGALRM,	SA_TRM, SA_IGN, SA_HND)	/* A Alarm Clock */\
sigdef(SIGTERM,	SA_TRM, SA_IGN, SA_HND)	/* A Software termination signal */\
sigdef(SIGURG,	SA_IGN, SA_IGN, SA_HND)	/* A Urgent condition on socket */\
sigdef(SIGSTOP,	SA_STP, SA_STP, SA_STP)	/* A Stop process */\
sigdef(SIGTSTP,	SA_STP, SA_IGN, SA_HND)	/* A Stop      (TTY) */\
sigdef(SIGCONT,	SA_IGN, SA_IGN, SA_HND)	/* A Continue after stop */\
sigdef(SIGCHLD,	SA_IGN, SA_IGN, SA_HND)	/* A Child status changed */\
sigdef(SIGTTIN,	SA_STP, SA_IGN, SA_HND)	/* A Background read attempt (TTY) */\
sigdef(SIGTTOU,	SA_STP, SA_IGN, SA_HND)	/* A Background write attempt (TTY) */\
sigdef(SIGIO,	SA_IGN, SA_IGN, SA_HND)	/* A I/O is possible on a FD */\
sigdef(SIGXCPU,	SA_TRM, SA_IGN, SA_HND)	/* A CPU time limit exceeded */\
sigdef(SIGXFSZ,	SA_TRM, SA_IGN, SA_HND)	/* S File size limit exceeded */\
sigdef(SIGVTALRM,SA_TRM,SA_IGN, SA_HND)	/* A Virtual time alarm */\
sigdef(SIGPROF,	SA_TRM, SA_IGN, SA_HND)	/* A Profiling time alarm */\
sigdef(SIGWINCH,SA_IGN, SA_IGN, SA_HND)	/* A Window size change */\
sigdef(SIGUSR1,	SA_TRM, SA_IGN, SA_HND)	/* A/S User-defined signal 1 */\
sigdef(SIGUSR2,	SA_TRM, SA_IGN, SA_HND)	/* A/S User-defined signal 2 */\
sigdef(SIGT20EOF,SA_IGN,SA_IGN, SA_HND)	/* S T20/10X: .ICEOF */\
sigdef(SIGT20NXP,SA_IGN,SA_IGN, SA_HND)	/* S T20/10X: .ICNXP */\
sigdef(SIGT20DAE,SA_DMP,SA_IGN, SA_HND)	/* S T20/10X: .ICDAE */

/* Put signal definitions into an array.
** At initialization time this table is sorted and re-written so it can
** be indexed by signal number (minus one).  This takes care
** of any problems with ordering of the signal definitions.
** Also, a compile time error will be generated if more signals are defined
** than _NSIG tells us should exist.
*/
static struct sigdat {
	unsigned char sd_sig, sd_dfl, sd_ign, sd_hnd;
} sigdat[_NSIGS] = {		/* Establish size of array */
#define sigdef(sig,dfl,ign,hnd) {sig,dfl,ign,hnd},
	sigdefs			/* Initialize the array elements */
#undef sigdef
};

#if 0
		TOPS-20/TENEX PSI Channels

	For detailed information about PSI channels, see the TOPS-20
Monitor Calls Reference Manual, section 2.5, "Software Interrupt
System".  The Monitor Calls User's Guide is also mildly helpful.
	There are many subtleties which are undocumented, however.
Chief among them is what the interrupt PC and flags really mean,
specifically the setting of the user-mode PC flag bit.  This is
supposed to be off only if the PC is a "monitor" PC, indicating that
execution was interrupted from a JSYS; the PC points to the location
immediately following the JSYS (always +1 regardless of whether ERJMP
exists or not).
	However, .ICILI interrupts also claim to have a monitor PC!

	For asynchronous interrupts the PC has no special meaning and
merely points to the next instruction to execute.  If this was a
JSYS-mode PC then you cannot continue properly unless a DEBRK% is done
without modifying the saved PC.
	For synchronous interrupts, the interrupt PC almost always
points to the location AFTER the one which caused the interrupt; continuation
will proceed normally from that point.
	However, there is a significant exception.  When a page fault
interrupt happens while in user mode (.ICNXP, .ICIWR, .ICIRD are the
most common of these), then the PC points DIRECTLY at the offending
instruction.  Continuation is normally impossible unless the interrupt
was .ICNXP; either the page access or the PC must be changed.  It also
appears possible to get this sort of interrupt with .ICDAE, .ICMSE, and
perhaps .ICQTA.

	We're not yet done with the PSI system stupidities.  Interrupts
generated by the IIC% instruction will have a JSYS-mode PC even though
there is nothing about it that needs to be interrupted!  This needs to be
checked for so that the PC isn't backed up.

	All PSI channels, with the exception of the reserved channels,
are either asynchronous (may occur anywhere in user code or JSYS code)
or are synchronously generated by IIC%.  The reserved channels are
described as follows.
	USER-mode only, Synchronous.  PC points to next instr.
		.ICAOV
		.ICFOV
		.ICPOV - Can be JSYS-mode (any error #) if
			processing of ERCAL (in SCHED.MAC) causes a POV.
			Continuation in that case isn't possible unless
			we are doing an interruptible jsys(), and jsys()
			uses only ERJMP, not ERCAL.
	JSYS-mode only, synchronous.  PC points to 1st loc after JSYS.
		.ICEOF - IOX4 (eof in IO.MAC)
		.ICILI - this appears to always be JSYS-mode, synch, even
			though the illegal instr is executed in user mode!
			Many many places, everything that's not something else.

	EITHER mode, synchronous.  PC is funny!
		NOTE!!!  User-mode PC points to bad instruction, NOT to next!
			Cannot proceed unless PC munged or access fixed up.
			JSYS-mode PC is normal, pointing to the loc after JSYS.
		.ICNXP - ILLX04 (pagefault, ref of non-x page, in PAGEM.MAC)
			(.ICNXP is OK to continue, as page will be created)
		.ICIRD - PMAPX7 (jsys or pageflt, mapping dismounted OFN)
			 ILLX05 (pagefault, illeg section)
			 ILLX01 (pagefault, illeg read)
			 ARGX09 (pagefault, illeg OWGBP)
			(all of above refs are in PAGEM.MAC)
		.ICIWR - ILLX02 (pagefault, illeg write in PAGEM)
			 * (if ERCAL fails in SCHED.MAC)

		The following are most commonly seen in JSYS mode, but
		it is still remotely possible that they could be triggered by
		page faults during user-mode execution.

		.ICDAE - IOX5 (output err in IO.MAC)
			 IOX10 (input err in IO.MAC)
			 ILLX02 (err in IO.MAC)
			 PMAPX2 (deleting file page still shared, in PAGEM.MAC)
			 ILLX03 (pagefault parity error, in PAGEM.MAC)
			 IOX5 (swap error, in PAGEM.MAC)
			 OPNX16 (ditto)
			 (one completely unused ref in SCHED.MAC)
		.ICQTA - IOX11 (page creation in PAGEM.MAC)
			(pmap% in JSYSA.MAC (all other pmap errs are .ICILI))
			(output err in IO.MAC)
		.ICMSE - "Machine Size Exceeded"
			CFRKX3 (cfork% in FORK.MAC)
			IOX35 (plus any error besides IOX11 when 
				doing page creation, in PAGEM.MAC)

	EITHER-mode, ASYNCH.  PC is that of next instr.
		.ICIFT - this is the only asynch reserved channel!
			Triggered by fork termination in SCHED.MAC, which
			also gives a weird chan 35 PSI if top fork!?
			This is also triggered whenever a fork attempts to
			use a JFN of .SIGIO -- typically the superior sets
			the inferior's primary I/O JFNs to this in order to
			catch any requests for the TTY, etc.
			
	Not implemented: listed in MONSYM but never actually used:
		.ICTOD - Time Of Day
		.ICIEX - Illegal Memory Execute
		.ICTRU - Trap to User

	Note whereas signal numbers are 1-36 inclusive, PSI channel
numbers are 0-35 inclusive.  Channels 6-22 inclusive have fixed
meanings assigned by the TOPS-20 monitor; the others are available
for USYS or the user program.
	Some of the user-assignable PSI channels are reserved by USYS.
These are given definitions of CHNxxx where xxx is in lowercase to
distinguish them from the fixed monitor symbols of CHNXXX.  See the
next page for the complete mapping of PSIs into signals.

#endif

/*	chndef(num,name,lev,flags)
**		num - Channel #
**		name - T20 .ICxxx symbol for channel #, if any
**		lev - Priority level (1-3)
**		flags - CF_ flags as below
*/
	/* These flags are inherent attributes of reserved channels */
#define CF_SYN (1<<35)		/* Synchronous int (else asynch) - sign bit! */
#define CF_PAN (1<<34)		/* Panic channel */
#define CF_OPC (1<<33)		/* User-mode PC is Old PC (points to bad instr)
				** NOTE: This is only true if PC is user-mode;
				** for JSYS-mode, PC is that of the JSYS+1
				** as for other interrupts.
				*/
#define CF_SYS (1<<32)	/* Synch int can happen only due to JSYS */
#define CF_USR (1<<31)	/* Synch int can happen only due to user instr */
			/* (else may be either JSYS or user mode) */
#define CF_ATI (1<<30)	/* ATI'd to a terminal interrupt char.  If set, */

	/* Reserved-channel flag defs, here for ease of commenting */
#define CF_ICAOV (CF_SYN              |CF_USR)	/* Int arith ovfl */
#define CF_ICFOV (CF_SYN              |CF_USR)	/* f.p. arith ovfl */
#define CF_ICPOV (CF_SYN|CF_PAN       |CF_USR)	/* PDL ovfl */
#define CF_ICEOF (CF_SYN              |CF_SYS)	/* EOF condition */
#define CF_ICDAE (CF_SYN|CF_PAN|CF_OPC)		/* Data err on file */
#define CF_ICQTA (CF_SYN|CF_PAN|CF_OPC)		/* Quota excded */
#define CF_ICILI (CF_SYN|CF_PAN       )		/* Illeg instr */
#define CF_ICIRD (CF_SYN|CF_PAN|CF_OPC)		/* Illeg mem read */
#define CF_ICIWR (CF_SYN|CF_PAN|CF_OPC)		/* Illeg mem write */
#define CF_ICIFT (CF_PAN)			/* Inf proc trm/frz */
			/* Not really a panic, must keep channel on */
#define CF_ICMSE (CF_SYN|CF_PAN|CF_OPC)		/* Sys rsrces xhsted */
#define CF_ICNXP (CF_SYN              )		/* Non-ex page ref */


			/* "User" => "Assignable by user program" */
#define chndefs \
chndef( 0,CHN0,   2,0)	/* USYS: Reserved for special int-level code */\
chndef( 1,CHNabrt,2,0)	/* USYS: SIGABRT/SIGIOT ("abort") */\
chndef( 2,CHNalrm,2,0)	/* USYS: SIGALRM (TIMER%) */\
chndef( 3,CHNmisc,2,0)	/* USYS: SIGxxx (miscellaneous sigs) */\
chndef( 4,CHN4,   0,0)	/* USYS: reserved */\
chndef( 5,CHN5,   0,0)	/* USYS: reserved */\
chndef( 6,CHNAOV,2,CF_ICAOV)	/* .ICAOV Arith overflow (includes NODIV) */\
chndef( 7,CHNFOV,2,CF_ICFOV)	/* .ICFOV Arith f.p. overflow (includes FXU)*/\
chndef( 8,CHN8,0,0)		/*	Reserved for DEC */\
chndef( 9,CHNPOV,2,CF_ICPOV)	/* .ICPOV Pushdown list (PDL) overflow */\
chndef(10,CHNEOF,2,CF_ICEOF)	/* .ICEOF End of file condition */\
chndef(11,CHNDAE,2,CF_ICDAE)	/* .ICDAE Data error file condition */\
chndef(12,CHNQTA,2,CF_ICQTA)	/* .ICQTA Disk full or quota exceeded when\
				   creating a new page */\
chndef(13,CHN13,0,0)		/*	Reserved for DEC */\
chndef(14,CHN14,0,0)		/*	Reserved for DEC (.ICTOD unimplem) */\
chndef(15,CHNILI,2,CF_ICILI)	/* .ICILI Illegal instruction */\
chndef(16,CHNIRD,2,CF_ICIRD)	/* .ICIRD Illegal memory read */\
chndef(17,CHNIWR,2,CF_ICIWR)	/* .ICIWR Illegal memory write */\
chndef(18,CHN18,0,0)		/*	Reserved for DEC (.ICIEX unimplem) */\
chndef(19,CHNIFT,2,CF_ICIFT)	/* .ICIFT Inf proc term or forced freeze */\
chndef(20,CHNMSE,2,CF_ICMSE)	/* .ICMSE System resources exhausted */\
chndef(21,CHN21,0,0)		/*	Reserved for DEC (.ICTRU unimplem) */\
chndef(22,CHNNXP,2,CF_ICNXP)	/* .ICNXP Reference to non-existent page */\
chndef(23,CHNhup, 2,CF_ATI)	/* USYS: SIGHUP  (.TICRF, carrier off) */\
chndef(24,CHNint, 2,CF_ATI)	/* USYS: SIGINT  (.TICxx) */\
chndef(25,CHNquit,2,CF_ATI)	/* USYS: SIGQUIT (.TICxx) */\
chndef(26,CHNstop,2,CF_ATI)	/* USYS: SIGTSTP (.TICxx) */\
chndef(27,CHNdstop,2,CF_ATI)	/* USYS: SIGTSTP (.TICxx) */\
chndef(28,CHNtyi, 2,CF_ATI)	/* USYS: SIGIO   (.TICTI, TTY input) */\
chndef(29,CHNtyo, 2,CF_ATI)	/* USYS: SIGIO   (.TICTO, TTY output) */\
chndef(30,CHN30,0,0)		/* User */\
chndef(31,CHN31,0,0)		/* User */\
chndef(32,CHN32,0,0)		/* User */\
chndef(33,CHN33,0,0)		/* User */\
chndef(34,CHN34,0,0)		/* User */\
chndef(35,CHN35,0,0)		/* User */

/* Define the channel number names */
enum chns {
#define chndef(chn,nam,c,d) nam=chn,
	chndefs
#undef chndef
};

#if 0
/* Put channel definitions into an array for use in initialization */
struct chndat {
	unsigned char cd_chn, cd_lev, cd_flg;
} chndat[] = {
#define chndef(chn,nam,lev,flg) chn,lev,flg,
	chndefs
#undef chndef
};
#define nchndefs (sizeof(chndat)/sizeof(chndat[0]))
#endif /* 0 */

#if 0
			    MAPPING
		Unix signals <--> T20/10X PSI channels

	The current mapping scheme assigns T20 PSI channels to Unix
signal numbers on a many-to-one basis.  That is, several PSI channels
can trigger the same signal, but no PSI channel (with one exception)
can trigger more than one signal.  The sole exception is a special
channel, CHNmisc, which is used to handle all otherwise unassigned
signals; these can only be triggered by a user software call (kill()
or raise()).
	Thus, given a PSI channel we can normally immediately derive
the signal #, but given a signal # it is necessary to scan a list or a
bit mask to find all of the PSI channels using that signal #.
	Some Unix signals correspond to no PSI channel and these have
been lumped together under the PSI channel "CHNmisc".  This is the ONLY
channel that is not bound to one specific signal -- it may trigger any
of the miscellaneous signals.  Interrupts on this channel require special
handling.
	Some PSI channels correspond to no exact Unix equivalent and
additional, non-portable SIGT20xxx signals have been invented to
support them.  Channel 0 (CHN0) is special; it is used internally when
some code needs to be run at interrupt level.  This also ensures that
a channel # of 0 is never associated with any signal.

	It would be nice if CHNmisc's many-to-one map from sig to PSI
could be generalized, but the main problem is chnpendmask; it gets
cleared when it should stay on if other signals pending that use the
channel.


	The actions taken for a particular PSI channel are defined
by the CHA_xxx values, mapped from the UNIX SA_xxx values as follows:

Action	Unix meaning		T20/10X action
				Panic chans	Other chans
SA_IGN	Ignore			CHA_ACTIGN	CHA_NOACT	(ignore)
SA_TRM	Terminate		CHA_NOACT	CHA_ACTCLR	(frz/trm)
SA_DMP	Terminate w/ core dump	CHA_NOACT	CHA_ACTCLR	(same)
SA_STP	Stop (suspend)		CHA_ACTHALT	CHA_ACTHALT	(do HALTF%)
SA_HND	Handle			CHA_ACTHAN	CHA_ACTHAN	(handle)

	At startup time, all channels are CHA_NOACT (none activated).
There are a lot of differences between the Unix SIG_DFL state at startup
and the T20 state, which should eventually be listed here.

#endif

enum chnact {	/* T20 PSI Channel Actions */
	CHA_NOACT,	/* Don't activate at all (must be 0!) */
	CHA_ACTCLR,	/* Activate, but clear chntab entry */
	CHA_ACTIGN,	/* Activate, but ignore ints (may not be possible) */
	CHA_ACTHALT,	/* Activate, do HALTF% on int. */
	CHA_ACTHAN	/* Activate, and invoke handler on int. */
};
/* Arrays to map SA_xx actions into CHA_xx actions for panic and other chans */
		/*   SA_IGN	SA_TRM	   SA_DMP     SA_STP      SA_HND   */
static chapan[] = { CHA_ACTIGN,CHA_NOACT, CHA_NOACT, CHA_ACTHALT,CHA_ACTHAN};
static chaoth[] = { CHA_NOACT, CHA_ACTCLR,CHA_ACTCLR,CHA_ACTHALT,CHA_ACTHAN};


/* Mapping of signals into T20 PSI channels */
/*	mapdef(sig, chn)
**		sig - Unix signal name
**		chn - PSI channel name
*/
#define MAXPSIMAP 3		/* Max # of chans that can map into one sig */
				/* OK to change this if necessary */
#define mapdefs \
mapdef(SIGHUP,	CHNhup)		/* Hangup (ATI% into .TICRF) */\
mapdef(SIGINT,	CHNint)		/* TTY Int (ATI% into .TICxx) */\
mapdef(SIGQUIT,	CHNquit)	/* TTY Quit (ATI% into .TICxx) */\
mapdef(SIGTSTP,	CHNdstop)	/* TTY Quit (ATI% into .TICxx) */\
mapdef(SIGTSTP,	CHNstop)	/* TTY Quit (ATI% into .TICxx) */\
mapdef(SIGILL,	CHNILI)		/* Illegal Instruction */\
mapdef(SIGFPE,	CHNFOV)		/* Floating Point Exception */\
mapdef(SIGFPE,	CHNAOV)		/*  "  */\
mapdef(SIGBUS,	CHNIRD)		/* Bus Error */\
mapdef(SIGBUS,	CHNIWR)		/*  "  */\
mapdef(SIGSEGV,	CHNPOV)		/* Segmentation Violation */\
mapdef(SIGALRM,	CHNalrm)	/* Alarm Clock */\
mapdef(SIGCHLD,	CHNIFT)		/* Child status changed */\
mapdef(SIGIO,	CHNtyi)		/* I/O possible on FD */\
mapdef(SIGIO,	CHNtyo)		/*  "  */\
mapdef(SIGABRT,	CHNabrt)	/* "Abort" signal raised */\
mapdef(SIGT20EOF,CHNEOF)	/* T20/10X: .ICEOF - EOF condition on input */\
mapdef(SIGT20NXP,CHNNXP)	/* T20/10X: .ICNXP - Ref to non-ex page */\
mapdef(SIGT20DAE,CHNDAE)	/* T20/10X: .ICDAE - Device or data error */

/* Put map definitions into an array for use in initialization */
static unsigned char mapdat[] = {
#define mapdef(sig,chn) sig,chn,
	mapdefs
#undef mapdef
	0		/* Null char terminates */
};

#if SYS_T20+SYS_10X
		/* PSI tables and data */
static void monsymdummy() { asm("SEARCH MONSYM\n");	/* Get asm syms */
	if (0) monsymdummy(); }		/* Avoid KCC warning about no refs */

#define PSILEV 2		/* PSI level to use for all signals */

/* Used by interrupt routine to determine if PC must be adjusted */
static int `opcflg` = CF_OPC;

static int *levtab[3] = {	/* 3 words in level table of return PC locs */
	&USYS_VAR_REF(levpcs[0]), /* Level 1 PC location */
	&USYS_VAR_REF(levpcs[2]), /* Level 2 PC location */
	&USYS_VAR_REF(levpcs[4]), /* <Level 3 PC location */
};
static int `chnxct`[NPSI];	/* Most vectors point into this table */

static int *`aintflgs` = NULL;		/* Addr of int PC flags */
static int *`aintpc` = NULL;		/* Addr of int PC address */
static int chv0, chvmisc, chvili;	/* Special chntab vectors */

	/* Tables needed by interrupt handler */

static unsigned `chnflg`[NPSI]={	/* Flags for chan #.  Sign = CF_SYN (fixed) */
#	define chndef(n,na,l,flgs) flgs,
	chndefs
#	undef chndef
};
static unsigned `chnbit`[NPSI]={	/* Chan bit for chan # (fixed) */
#	define chndef(n,na,l,flgs) chnmask(n),
	chndefs
#	undef chndef
};
static unsigned `csgmsk`[NPSI];	/* Sig bits for chan # (mapped) */
static unsigned `chnsig`[NPSI];	/* Signal # for chan # (mapped) */
static unsigned `sigbit`[_NSIGS+1];	/* Signal bit for signal. */

/* External used by alarm() */
int _chnalrm = 0;		/* Chan # used for alarm (TIMER%) */

/* Place to save ACs for dump */
/* Can be overridden by a global symbol `BUGACS` */
static int `BUGACS`[16];

#endif /* T20+10X */

/* SIGVEC - system call simulation.  Main entry of this module!
*/
int
sigvec(sig, vec, ovec)
int sig;
struct sigvec *vec, *ovec;
{
    register unsigned sigbit;

    USYS_BEG();
    if (sig < 1 || _NSIGS < sig)
	USYS_RETERR(EINVAL);
    if (!USYS_VAR_REF(sigif))
	_siginit();		/* Initialize USYS signal stuff */

    if (ovec)			/* Return existing state of vector */
	xgetvec(sig, ovec);
    if (vec == NULL)		/* If no new vector */
	USYS_RET(0);		/* then that's all! */

    /* Check for UNIX-type legality */
    sigbit = sigmask(sig);
    if ( ((sigbit & SNOIGNORE) && vec->sv_handler == SIG_IGN)
      || ((sigbit & SNOCATCH) && vec->sv_handler != SIG_DFL))
	USYS_RETERR(EINVAL);

    if (xsetvec(sig, vec))	/* Do sys-dep stuff to install new sigvec */
	USYS_RETERR(EINVAL);
    USYS_RET(0);
}

/* SIGACTION - POSIX version of SIGVEC
 */
int
sigaction(signo, nsa, osa)
int signo;
const struct sigaction *nsa;
struct sigaction *osa;
{
    struct sigvec tsv = *(struct sigvec *)nsa;
    int ret;

    tsv.sv_flags ^= SV_INTERRUPT; /* Invert sense of this bit */
    ret = sigvec(signo, &tsv, (struct sigvec *)osa);
    osa->sa_flags ^= SA_RESTART; /* Invert sense of this bit */
    return ret;
}

/* BSD signal-related system calls */

/* SIGBLOCK(mask) - Add signals to current block mask
**	Returns old value of signal block mask.
*/
int
sigblock(mask)
int mask;
{
    register int omask;

    USYS_BEG();			/* Don't allow signals */
    if (!USYS_VAR_REF(sigif))
	_siginit();		/* Initialize USYS signal stuff */
    omask = USYS_VAR_REF(sigblockmask);
    USYS_VAR_REF(sigblockmask) |= (mask &~ SNOBLOCK);
    USYS_RET(omask);		/* OK to allow signals now */
}

/* SIGSETMASK(mask) - set current signal block mask.
**	Returns old value of signal block mask.
**	This differs from sigblock() in that the mask is replaced with
**	a new value, rather than having the new bits IOR'd in.
*/
int
sigsetmask(mask)
int mask;
{
    register int omask;

    USYS_BEG();				/* Don't allow signals */
    if (!USYS_VAR_REF(sigif))
	_siginit();			/* Initialize USYS signal stuff */
    omask = USYS_VAR_REF(sigblockmask);
    USYS_VAR_REF(sigblockmask) = (mask &~ SNOBLOCK);
					/* Set it (rather than IOR'ing it) */
    USYS_RET(omask);			/* OK to allow signals now */
}

/* SIGPROCMASK(how, new, old) - Manipulate blocked signals according
** to 'how' and 'new'. Returns old value of signal block mask.
** This is a hybrid of SIGBLOCK(mask), SIGSETMASK(mask), and an option
** that removes signals from the current block mask.
*/
int
sigprocmask(how, set, oset)
int how;
const sigset_t *set;
sigset_t *oset;
{
  int mask = (int)*set;

  USYS_BEG();
  switch (how) {
  case SIG_BLOCK:		/* Add to blocked signals */
    *oset = (sigset_t)sigblock(mask);
    break;
  case SIG_UNBLOCK:		/* Remove from blocked signals */
    *oset = (sigset_t)
      sigsetmask(USYS_VAR_REF(sigblockmask) & ~(mask &~ SNOBLOCK));
    break;
  case SIG_SETMASK:		/* Set blocked signals */
    *oset = (sigset_t)sigsetmask(mask);
    break;
  default:
    errno = EINVAL;
    USYS_RET(-1);
  }
  USYS_RET(0);
}

/* SIGPAUSE(mask) - Release blocked signals and wait for interrupt.
**	This call acts like sigsetmask() by setting a new signal
** block mask, but then it waits for a signal to arrive.
**	As soon as control returns to this call from any signal(s) that
** interrupted the pause, the old value of the block mask is restored and 
** the call then returns -1 with errno set to EINTR.
**	See the UPM sigpause(2) description for typical usage.
*/
int
sigpause(mask)
int mask;
{
    register int omask;
    int acs[5];

    USYS_BEG();			/* No signals */
    if (!USYS_VAR_REF(sigif))
	_siginit();		/* Initialize USYS signal stuff */
    omask = USYS_VAR_REF(sigblockmask);
    USYS_VAR_REF(sigblockmask) = (mask &~ SNOBLOCK); /* Set new mask */
#if SYS_T20+SYS_10X
    jsys(WAIT|JSYS_OKINT, acs);	/* Wait for a signal to interrupt us */
#else
    pause();			/* Try using vanilla Unix call */
#endif
    (void)USYS_END();		/* Go handle unblocked signal(s) */
    USYS_VAR_REF(sigblockmask) = omask; /* Then reset signal block mask */
    errno = EINTR;
    return -1;
}

/* SIGSTACK - specify alternate signal stack.
**	The doc for this call is a bit confusing.
** Mis-use of this call can be vastly more confusing for the program!
*/
int
sigstack(ss, oss)
struct sigstack *ss, *oss;
{
    USYS_BEG();
    if (!USYS_VAR_REF(sigif))
	_siginit();		/* Initialize USYS signal stuff */
    if (oss)
	*oss = USYS_VAR_REF(sigstk); /* Return current state of signal stack */
    if (ss)
	USYS_VAR_REF(sigstk) = *ss;
    USYS_RET(0);
}
#if 0
	More on signal stack usage:

	Within the "kernel" (USYS) there is a sigstack structure which contains
(1) a pointer to the start of a signal stack, and
(2) a flag saying whether execution is currently on this stack.

	The pointer is changed ONLY by a sigstack() call.  It does not
change as things are pushed on the stack.  The pointer is used by the
signal code only when about to change the state from non-sig stack to
sig stack; otherwise it is ignored.
	The flag determines the state.  The signal code changes this
state in only two situations: (1) if about to call a signal handler that
wants the signal stack, and we are not currently on the stack; (2) when
returning from a signal handler that used the sig stack, and the previous
state was non-sig stack.  In all other cases, signal handlers use whichever
stack is in use.  In particular, if a signal handler didn't request that it
use the signal stack, it will still do so anyway if that happens to be
the current stack.
	Note that the previous stack pointer is always restored regardless
of whether it belonged to the normal or signal stack; the code doesn't care.
All it restores is the state flag.
	Thus, it is quite possible to confuse the USYS code (and UNIX too)
by using sigstack() to lie about the actual stack state.  It is always OK
to change the sig stack pointer, although this will not have any effect until
such time as control is switched from non-sig to sig stack.  It is NOT OK
to change the state flag unless you are very clever (so as to make it work)
and very stupid (to expect anyone to maintain such tricky code).

#endif

/* _SIGINIT - Initialize USYS signal stuff
*/

static int *`sigssp`;
static int *`sigons`;

void
_siginit()
{
    register int i;
    register int sig, chn, flags;
    register char *cp;
    struct sigdat tmparr[_NSIGS];	/* Temporary while sorting */

    /* These 2 are too complex for compiler */
    `sigssp` = (int *)&USYS_VAR_REF(sigstk.ss_sp);
    `sigons` = (int *)&USYS_VAR_REF(sigstk.ss_onstack);

    USYS_VAR_REF(sigpendmask) = USYS_VAR_REF(sigblockmask) = 0;
					/* Make sure these are clear */

    /* Now ensure the sigdat table can be indexed by signal number! */
    memcpy((char *)tmparr, (char *)sigdat, sizeof(sigdat));	/* Copy it */
    memset((char *)sigdat, 0, sizeof(sigdat));			/* Clear it */
    for (i = 0; i < _NSIGS; ++i)		/* Copy back in right order */
	if (tmparr[i].sd_sig > 0)
	    sigdat[tmparr[i].sd_sig - 1] = tmparr[i];

#if SYS_T20+SYS_10X
    USYS_VAR_REF(chnpendmask) = 0; /* Parallel to sigpendmask */
    _chnalrm = CHNalrm;		/* Initialize channel # for alarm() */
    USYS_VAR_REF(intlev) = 0;	/* Say not at interrupt level */

    /* Initialize the various tables that the interrupt system needs to have
    ** on hand.  We use the sigdat and mapdat tables for
    ** the initialization.
    */
    for (i = 0; i < NPSI; ++i)		/* Clear chan-indexed tables */
	`csgmsk`[i] = `chnsig`[i] = USYS_VAR_REF(chnact[i]) = 0;

    switch (_urtsud.su_signal_type) {	/* Determine default initial flags */
	case _URTSUD_BSD43_SIGS: flags = 0;		break;
	case _URTSUD_BSD42_SIGS: flags = SV_INTERRUPT;	break;
	case _URTSUD_SYSV_SIGS:
	default:
	  	flags = SV_INTERRUPT|SV_HNDLR_RESET;
		break;
    }
    for (i = 0; i < _NSIGS+1; ++i) {	/* Clear sig-indexed tables */
	USYS_VAR_REF(sigcmask[i]) = USYS_VAR_REF(sigmsk[i])
	  = USYS_VAR_REF(sigact[i]) = 0;
	USYS_VAR_REF(sigflg[i]) = flags;
	USYS_VAR_REF(sighnd[i]) = SIG_DFL;
    }
    for (i = 1; i < _NSIGS+1; ++i) {	/* Set up default SA_xxx actions */
	USYS_VAR_REF(sigact[i]) = sigdat[i-1].sd_dfl;
	`sigbit`[i] = sigmask(i);
    }

    /* Now apply the mappings! */
    for (cp = mapdat-1; sig = *++cp;) {	/* Signal # is 1st byte */
	chn = *++cp;			/* Channel # is second */
	if (`chnsig`[chn])
	    abort();		/* Map error if two sigs for a normal chan! */
	`chnsig`[chn] = sig;
	`csgmsk`[chn] = sigmask(sig);
	USYS_VAR_REF(sigcmask[sig]) |= `chnbit`[chn];
    }
    /* Any signals that haven't been mapped are now all mapped into the
    ** special CHNmisc PSI channel.  This is a catch-all.
    */
    for (sig = 1; sig <= _NSIGS; ++sig)
	if (USYS_VAR_REF(sigcmask[sig]) == 0) {
				/* If not already mapped to a chan */
	    `csgmsk`[CHNmisc] |= sigmask(sig);	/* Add this sig to CHNmisc */
	    USYS_VAR_REF(sigcmask[sig]) |= chnmask(CHNmisc);
	}

    /* Now set dispatch vector in SIGDAT so ioctl() can update TTY psi stuff,
    ** and set up interrupt chars if anything's already there.
    */
    USYS_VAR_REF(atirtn) = doatis;
    doatis(0);			/* Setup default interrupt characters */

    /* Finally, initialize some assembler stuff and turn on PSI system! */
    psiinit();		/* Ready, set, go! */
#endif /* T20+10X */

    USYS_VAR_REF(sigif) = 1;	/* Say all initialized now */
}

/* XGETVEC - sys-dependent routine to return the current setting of
**	a signal vector, such that providing it as an argument to
**	xsetvec() will restore the previous state.
*/
static int
xgetvec(sig, s)
int sig;
struct sigvec *s;
{
    s->sv_handler = USYS_VAR_REF(sighnd[sig]);
    s->sv_mask = USYS_VAR_REF(sigmsk[sig]);
    s->sv_flags = USYS_VAR_REF(sigflg[sig]) & SF_ALLEXT;

}

/* XSETVEC - sys-dependent routine to actually effect a handler change.
**	Although the interrupt system remains active, no signals will be
** handled as we are in the middle of a system call.  The things
** which are referenced in this mode (see the "pisys2" label) are:
**	sigpendmask, sigblockmask, chnpendmask, 
**	chnflg[] for the CF_SYN bit
**	csgmsk[] for the signal bit for this chan.
** None of which are changed by this routine, except possibly for
** flushing ignored signals from sigpendmask and chnpendmask -- if done,
** interrupts are disabled during this action.
**
**	What we have to be careful of is any changes to the monitor
** PSI system, including changes to chntab[].  The xsigv() routine takes
** care of this.
**
**	A return value of 0 is used to indicate success.
*/
static int
xsetvec(sig, s)
int sig;
struct sigvec *s;
{
    register int chn, sa, cha;
    unsigned psibits;
    unsigned newmsk, newflg;
    hndlr_t newhnd;    
    int newchn, newlev, newtic;

    /* Sanitize new block mask and flags */
    newmsk = (s->sv_mask | sigmask(sig)) /* Always block self at least */
		& ~SNOBLOCK;		/* But forbid blocking certain sigs */
    newflg = s->sv_flags & SF_ALLEXT;

    /* Check for OS-specific special flags and values.
    ** The only one supported right now is SV_XINTLEV.
    */
    if (newflg & SV_XASMHAN) return -1;	/* Cannot hack yet */
    if (newflg & SV_XOS) {		/* Special values there? */
	if (newchn = s->sv_os.t20.psichn)
	    return -1;			/* Cannot hack PSI channel yet */
	if ((newlev = s->sv_os.t20.psilev) && newlev != PSILEV)
	    return -1;			/* Cannot hack PSI level yet */
	if (newtic = s->sv_os.t20.tic)
	    return -1;			/* Cannot hack .TICxx code yet */
    }

    /* Find mask of PSI channels affected by this signal */
    psibits = USYS_VAR_REF(sigcmask[sig]);
				/* Get mask of PSI chans for this signal */
    if (psibits == 0)		/* If not implemented, */
	return -1;		/* error somewhere. */


    /* OK to set new mask and flag stuff at this point. */
    USYS_VAR_REF(sigmsk[sig]) = newmsk;	/* Replace mask completely */
    USYS_VAR_REF(sigflg[sig])
      = (USYS_VAR_REF(sigflg[sig]) & ~SF_ALLEXT) | newflg;
				/* Put in new flags */

    /* Now check handler - must figure out new SA_xxx action. */
    newhnd = s->sv_handler;
    if      (newhnd == SIG_DFL) sa = sigdat[sig-1].sd_dfl;
    else if (newhnd == SIG_IGN)	sa = sigdat[sig-1].sd_ign;
    else    /* anything else */	sa = sigdat[sig-1].sd_hnd;

    /* Possible that new action is the same as old one... */
    if (sa == USYS_VAR_REF(sigact[sig])) { /* If so, also just return. */
	USYS_VAR_REF(sighnd[sig]) = newhnd;
				/* Set new handler in case SA_HND */
	return 0;
    }
    USYS_VAR_REF(sigact[sig]) = sa; /* Set new action value */

    /* Check each channel to see if its action must be changed. */
    while ((chn = ffoclr(&psibits)) >= 0) {
	if (chn == CHNmisc) continue;	/* Ignore the misc channel */
	cha = (`chnflg`[chn]&CF_PAN) ? chapan[sa] : chaoth[sa];
	if (cha != USYS_VAR_REF(chnact[chn]))
	    xsigv(chn, cha);		/* Bash the channel */
    }

    USYS_VAR_REF(sighnd[sig]) = newhnd;	/* Finally set new handler value! */

    /* If we're trying to ignore the signal, then flush any pending ints. */
    if (sa == SA_IGN && (USYS_VAR_REF(sigpendmask) & sigmask(sig))) {
	/* Critical code; must turn off interrupts while updating flags,
	** since the new value of chnpendmask will depend on what bits are
	** set in the new sigpendmask.
	*/
	__dir();			/* Disable ints */
	USYS_VAR_REF(sigpendmask) &= ~sigmask(sig); /* Flush signal bit */
	USYS_VAR_REF(chnpendmask) &= _cnvmask(USYS_VAR_REF(sigpendmask));
					/* and now-unused chan bits */
	__eir();			/* Enable ints */
    }
    return 0;
}

/* XSIGV - Actually make change to PSI channel vector.
**	This is never called for either CHN0 or CHNmisc, which are always
** kept activated for special handling.
*/

static void
xsigv(chn, cha)
int chn, cha;
{
    int oldcha = USYS_VAR_REF(chnact[chn]); /* Get old CHA_xxx action */

    /* Normal channel, mapped into specific signal. */
    switch (cha) {
	case CHA_NOACT:		/* Don't activate at all (must be 0!) */
	    if (oldcha != CHA_NOACT)	/* Was previously activated? */
		chn_dic(chnmask(chn));	/* Yeah, must turn it off now */
	    USYS_VAR_REF(chntab[chn]) = 0; /* Then OK to clear entry */
	    goto noact;			/* Bypass activation check */

	case CHA_ACTCLR:	/* Activate, but clear chntab entry */
	    USYS_VAR_REF(chntab[chn]) = 0;
				/* Clear entry then break to activate */
	    break;

	case CHA_ACTIGN:	/* Activate, but ignore ints (if possible) */
	case CHA_ACTHALT:	/* Activate, do HALTF% on int. */
	case CHA_ACTHAN:	/* Activate, and invoke handler on int. */
	    USYS_VAR_REF(chntab[chn])
	      = (chn == CHNILI) ? chvili : chvinstr(chn);
	    break;
	default:
	    abort();		/* Urgh!!! */
    }
    if (oldcha == CHA_NOACT)	/* If channel was not previously active, */
	chn_aic(chnmask(chn));	/* activate the channel! */
  noact:
    USYS_VAR_REF(chnact[chn]) = cha;
    if ((oldcha != CHA_NOACT) && (`chnflg`[chn] & CF_ATI))
	doatis(0);		/* Update interrupt characters */
}

/* DOATIS - invoked by ioctl() via usydat's atirtn function pointer
**	whenever the t_intrc, t_quitc, t_stopch, or t_dstopch characters
**	are changed. A -1 value indicates no character.
** Returns 0 if successful, else failed.
*/

#define _TICCC monsym(".TICCC")
#define _TICTI monsym(".TICTI")
#define _TICTO monsym(".TICTO")
#define TI_ACT 0400		/* Character is assigned flag */
				/* 0200 & 0100 available */
#define TI_COD 0077		/* Character code mask */

static int
doatis(sigio)
int sigio;			/* 0: No SIGIO change */
				/* 1: Set SIGIO */
				/* -1: Clear SIGIO */
{
    if (sigio)  {		/* Changing SIGIO state? */
      if ((sigio > 0)
	  ? setati(CHNtyi, _TICTI, 0) | setati(CHNtyo, _TICTO, 0)
	  : setati(CHNtyi, -1, 0) | setati(CHNtyo, -1, 0))
	return -1;
    }
    else {			/* Else update interrupt chars */
      if (setati(CHNdstop, _cntrl_tty->lt.t_dsuspc, 1)
	  | setati(CHNstop, _cntrl_tty->lt.t_suspc, 0)
	  | setati(CHNquit, _cntrl_tty->tc.t_quitc, 0)
	  | setati(CHNint, _cntrl_tty->tc.t_intrc, 0))
	return -1;	/* One of the calls failed */
    }
    return 0;		/* Won */
}

static int
setati(chn, chr, defer)
int chn, chr, defer;
{
    int ticode;		/* .TICxx terminal interrupt code */

    if (chr == (char)-1) chr = -1;	/* Normalize */
    if ((0 <= chr && chr <= 033)	/* Between NULL and ESC inclusive? */
	|| (chr == _TICTI) || (chr == _TICTO)) /* Or Input/Output? */
	ticode = chr;			/* Then .TICxx code is just char! */
    else switch (chr) {
	case 0177:	ticode = 28; break;	/* .TICRB (delete) */
	case 040:	ticode = 29; break;	/* .TICSP (space) */
	case -1:	ticode = -1; break;	/* Turning it off */
	default:	return -1;		/* Bad char, fail! */
    }
    return settic(chn, ticode, defer);	/* Assign the new code! */
}

static int
settic(chn, ticode, defer)
int chn, ticode, defer;
{
    int acs[5], oldcode = USYS_VAR_REF(chnchr[chn]);

    if ((ticode == (oldcode & TI_COD)) && (oldcode & TI_ACT))
	return 0;		/* Same and active, no change needed */
	
    /* Must make a change! */

    /* Must we deassign old terminal-interrupt code? */
    if (oldcode & TI_ACT) {
	acs[1] = (oldcode & TI_COD) - 1;
	jsys(DTI, acs);
	if (_cntrl_tty->sg.sg_flags & RAW) { /* Terminal in raw mode? */
	    acs[1] = -5 & RH;		/* Get TIW for job */
	    jsys(RTIW, acs);
	    if (acs[2] & (1<<(36-(oldcode & TI_COD)))) {
	        acs[2] &= ~(1<<(36-(oldcode & TI_COD)));
		jsys(STIW, acs);	/* Disable code from job */
	    }
	}
    }

    USYS_VAR_REF(chnchr[chn]) = ticode+1; /* Set new code */

    /* Assign new code? */
    if ((USYS_VAR_REF(chnact[chn]) == CHA_ACTHAN) && (ticode >= 0)) {
	if (ticode == _TICCC) {		/* If code is ^C, do special stuff */
	    acs[1] = _FHSLF;		/* Set up for RPCAP% */
	    jsys(RPCAP, acs);
	    if ((acs[3]&SC_CTC)==0) {	/* ctl-C cap not enabled? */
		acs[3] |= SC_CTC;	/* attempt to enable it */
		jsys(EPCAP, acs);
	    }
	}
	acs[1] = -5 & RH;		/* Get TIW for job */
	jsys(RTIW, acs);
	if (!(acs[2] & (1<<(35-ticode)))) {
	    acs[2] |= (1<<(35-ticode));
	    jsys(STIW, acs);		/* Enable code for job */
	}
	acs[1] = (ticode << 18) | chn;
	if (jsys(ATI, acs) <= 0)
	    return -1;			/* Failure is improbable, but... */
	acs[1] = ST_DIM | _FHSLF;	/* Read deferred TIW for proc */
	if (!defer && (jsys(RTIW, acs) > 0) && (acs[3] & (1<<(35-ticode)))) {
	    acs[3] &= ~(1<<(35-ticode)); /* Clear deferred bit for our code */
	    jsys(STIW, acs);		/* Ignore failure */
	}
	USYS_VAR_REF(chnchr[chn]) |= TI_ACT; /* Flag as active */
    }
    return 0;				/* Won! */
}

static void
chn_dic(cmask)
int cmask;
{
#asm
	movei 1,.fhslf
	move 2,-1(17)	/* Get arg: channel bit mask */
	dic%		/* Deactivate those chans */
#endasm
}

static void
chn_aic(cmask)
int cmask;
{
#asm
	movei 1,.fhslf
	move 2,-1(17)	/* Get arg: channel bit mask */
	aic%		/* Activate those chans */
#endasm
}
static int
chvinstr(chn)
int chn;
{
#asm
	move 2,-1(17)		/* Get channel # to make chntab dispatch for */
	xmovei 1,chnxct(2)	/* Get addr to dispatch to */
	cail 17,		/* Skip if single-section */
	 tloa 1,<PSILEV>*010000	/* Extended, level # goes in high 6 bits */
	  hrli 1,<PSILEV>	/* Not extended, level # goes in LH */
	popj 17,
#endasm
}

/* Initialize T20 PSI system */

/* Build 'JSR addr' instruction */
static int jsr(addr)
int *addr;
{
#asm
	move 1,-1(17)		/* Get address */
	hrli 1,(<jsr>)		/* Add JSR instruction code */
#endasm
}

/* Assemble return JRSTs from JSR blocks */
static int jrst_psisg2(){asm("JRST PSISG2\n");}
static int jrst_psier2(){asm("JRST PSIER2\n");}
static int jrst_psyer2(){asm("JRST PSYER2\n");}

/* Cells to point to "system" data from assembler code */
USYS_VAR_TO_ASM(psisg[0],`psisg`);
USYS_VAR_TO_ASM(psier[0],`psierr`);
USYS_VAR_TO_ASM(psyer[0],`psyerr`);
USYS_VAR_TO_ASM(psiesv[0],`psiesv`);
USYS_VAR_TO_ASM(psi17,`psia17`);
USYS_VAR_TO_ASM(psisv[0],`psisv`);
USYS_VAR_TO_ASM(psichn,`psichn`);
USYS_VAR_TO_ASM(psihnd,`psihnd`);
USYS_VAR_TO_ASM(psistk,`psistk`);
USYS_VAR_TO_ASM(sigframe,`sigframe`);
USYS_VAR_TO_ASM(sigusys,`sigusys`);
USYS_VAR_TO_ASM(intlev,`intlev`);
USYS_VAR_TO_ASM(frktrm,`frktrm`);
USYS_VAR_TO_ASM(sigpendmask,`sigpnm`);
USYS_VAR_TO_ASM(sigblockmask,`sigbkm`);
USYS_VAR_TO_ASM(chnpendmask,`chnpendmask`);
USYS_VAR_TO_ASM(sighnd[0],`sighnd`);
USYS_VAR_TO_ASM(sigmsk[0],`sigmsk`);
USYS_VAR_TO_ASM(sigflg[0],`sigflg`);
USYS_VAR_TO_ASM(sigact[0],`actsig`);
USYS_VAR_TO_ASM(sigcmask[0],`sigcmask`);

static void
psiinit()
{
    register int i, *ip;
    int extflg;
    int lev, chn, cha, sa;
    int acs[5];
    unsigned chnfin = chnmask(CHNmisc)|chnmask(CHN0); /* Skip 0 and misc */
    unsigned chnbits;

    __dir();		/* Ensure int system disabled */
    jsys(CIS, acs);	/* Clear it to be completely safe */

    ip = levtab[PSILEV-1];	/* Find address of interrupt PC and flags */
    extflg = ((unsigned)ip)>>18; /* Set "extended" flag to section # */
    `aintflgs` = ip;		/* Remember addr of PC flags */
    USYS_VAR_REF(intpca) = ip;	/* And PC */
    if (extflg) USYS_VAR_REF(intpca)++;
				/* If extended, PC is actually in next wd */
    `aintpc` = USYS_VAR_REF(intpca); /* Copy for asm code */

    USYS_VAR_REF(psisg[1]) = *(int *)jrst_psisg2;
				/* Install jump back to code from JSR */
    USYS_VAR_REF(psier[1]) = *(int *)jrst_psier2;
				/* Install jump back to code from JSR */
    USYS_VAR_REF(psyer[1]) = *(int *)jrst_psyer2;
				/* Install jump back to code from JSR */
    for (i = 0; i < NPSI; ++i) {	/* Set all channels to */
	`chnxct`[i] = jsr(&USYS_VAR_REF(psisg[0])); /* a JSR .PSISG dispatch */
	USYS_VAR_REF(chntab[i]) = 0;
    }

    /* Build chntab vector dispatch words */
    lev = extflg ? PSILEV<<30 : PSILEV<<18;	/* Get PSI lev in right bits */
    chv0   = lev | (int)psich0;	/* Set up special dispatch for CHN0 */
    chvmisc= lev | (int)psimsc;	/* Set up special dispatch for CHNmisc */
    chvili = lev | (int)psiili;	/* Set up special dispatch for .ICILI handler*/

    if (extflg) {
	/* Initialize for multi-section (extended) */
	static struct {int c, **lv, *chn;} argblk
	  = {3, levtab, USYS_VAR_REF(chntab)};
	acs[1] = monsym(".FHSLF");	/* arg 1: fork handle */
	acs[2] = (int)&argblk;		/* arg 2: addr of arg blk */
	jsys(XSIR, acs);		/* Extended SIR% */
    } else {
	/* Initialize for single-section */
	acs[1] = monsym(".FHSLF");	/* arg 1: fork handle */
	acs[2] = XWD((int)levtab,(int)USYS_VAR_REF(chntab));
					/* arg 2: levtab,,chntab */
	jsys(SIR, acs);			/* Normal SIR% */
    }

    /* Now setup each channel corresponding to signals */
    for (i = 1; i < _NSIGS; i++)
	if (chnbits = USYS_VAR_REF(sigcmask[i]) & ~chnfin) {
	    chnbits &= ~chnfin;
	    chnfin |= chnbits;
	    while ((chn = ffoclr(&chnbits)) >= 0) {
		sa = USYS_VAR_REF(sigact[i]);
		cha = (`chnflg`[chn]&CF_PAN) ? chapan[sa] : chaoth[sa];
		xsigv(chn, cha);
	    }
	}

    USYS_VAR_REF(chntab[CHN0]) = chv0; /* Set up special PSI dispatches */
    USYS_VAR_REF(chntab[CHNmisc]) = chvmisc;
    chn_aic(chnmask(CHN0));		/* Activate the special channels */
    chn_aic(chnmask(CHNmisc));

    __eir();			/* All done, enable interrupt system! */
}

static void
hndhlt(int sig)
{
    if (0) (sig++);
#asm
	move 1,-1(17)		/* Get signal */
	lsh 1,010		/* Position as termination status */
	tro 1,0177		/* Set _WSTOPPED */
	haltf%			/* Halt; return if continued */
#endasm
}

static void
hndign(int sig)
{
    if (0) (sig++, `opcflg`++);
}

static hndlr_t
`gethnd`(sig, chn)
int sig, chn;
{
    int sa, cha;

    if (0) `gethnd`(sig, chn);	/* Make KCC think its referenced */

    /* Special handling if signal is really blocked */
    if (sigmask(sig) & USYS_VAR_REF(sigblockmask)) {
      USYS_VAR_REF(sigpendmask) |= sigmask(sig); /* Make signal pend */
      USYS_VAR_REF(chnpendmask) |= `chnbit`[chn]; /* and channel */
      return hndign;		/* No-op handler */
    }

    sa = USYS_VAR_REF(sigact[sig]);
    cha = (`chnflg`[chn]&CF_PAN) ? chapan[sa] : chaoth[sa];
    switch (cha) {
    case CHA_ACTIGN:		/* Ignore interrupt */
	return hndign;
	break;
    case CHA_ACTHALT:		/* Halt on interrupt */
	return hndhlt;
	break;
    case CHA_ACTHAN:		/* Call handler on interrupt */
	return USYS_VAR_REF(sighnd[sig]);
	break;
    }
    /* Should never get here */
    return SIG_ERR;
}

/* PSI interrupt channel handlers
**	There are 5 possible settings of the chntab PSI dispatch table
** words:
**	0	- 
**	psiili  -
**	psich0	-
**	psimsc	-
**	and (via chnxct) psisg.
*/

static void
psiili()
{
	/* Generate references to symbols used in assembler code */
	if (0) `psisg`++;
	if (0) `psierr`++;
	if (0) `psyerr`++;
	if (0) `psiesv`++;
	if (0) `psia17`++;
	if (0) `psisv`++;
	if (0) `psichn`++;
	if (0) `psihnd`++;
	if (0) `psistk`++;
	if (0) `sigframe`++;
	if (0) `sigusys`++;
	if (0) `intlev`++;
	if (0) `frktrm`++;
	if (0) `sigpnm`++;
	if (0) `sigbkm`++;
	if (0) `chnpendmask`++;
	if (0) `sighnd`++;
	if (0) `sigmsk`++;
	if (0) `sigflg`++;
	if (0) `actsig`++;
	if (0) `sigcmask`++;
	if (0) `sigssp`++;
	if (0) `sigons`++;
	asm(SIGCONTEXT_ASM);	/* Define asm offsets into sigcontext struct */
#asm
	extern .sigtx		/* External label from SIGDAT */
	extern .iobclean	/* External function from UIODAT */

	pc%usr==<010000,,0>	/* Bit 5 - User-mode PC flag */

	CHNmisc==<03>		/* CHNmisc # - must match C def! */
	cf%pan==<200000,,0>	/* CF_PAN bit - must match C def! */

	extern .jsbeg, .jsend, .jsabt, .jsint, .jscct


	dmovem 1,USYS_VAR_ASM_REF(psisv)
				/* Special handler to fix up .ICILI PC flag */
	movei 1,.icili		/* Set channel # in AC1 for normal code */
	caile 17,0
	 skipa 2,@aintpc	/* Get extended PC */
	  hrrz 2,@aintpc	/* Get single-section PC */
	ldb 2,[331100,,-1(2)]	/* Get opcode (9 bits) of bad instr at PC-1 */
	cain 2,104		/* Is it a JSYS? */
	 jrst psisg3		/* Yes, jsys-mode is OK, enter normal code */
	movsi 2,(pc%usr)	/* Ugh, was user-mode illeg instr!  Set */
	iorm 2,@aintflgs	/* the user-mode PC flag... */
	jrst psisg3		/* Now all's well, enter normal code! */

psisg2:	dmovem 1,USYS_VAR_ASM_REF(psisv)
				/* Save two ACs */
	hrrz 1,USYS_VAR_ASM_REF(psisg)
				/* Get PC the JSR left */
	subi 1,chnxct+1		/* Find channel number */
	/* Check for interrupts where PC points to offending instruction. */
	/* The PC must be incremented in case the user continues. */
	cain 1,.ICIFT		/* Inferior fork termination? */
	 aos USYS_VAR_ASM_REF(frktrm) /* Yes, count it */
	move 2,chnflg(1)	/* Get channel flags */
	tdnn 2,opcflg		/* CF_OPC on? */
	 jrst psisg3		/* No, continue */
	move 2,@aintflgs	/* Get PC flags */
	tlne 2,(pc%usr)		/* In user mode? */
	 aos @aintpc		/* Yes, PC is that of bad instr, increment! */
	/* Entry point for .ICILI ints, see psiili */
psisg3:	skipg USYS_VAR_ASM_REF(sigusys)
				/* Interrupted from USYS (system-call) code? */
	 jrst piuser		/* No, go handle interrupt from user code */

	/* Handle interrupt from USYS code.  Since we never invoke a
	** signal handler but just check flags, this is set up for speed.
	*/
	/* First check whether int is synchronous.  This is potentially fatal
	** within USYS code, as we cannot continue and we may have nowhere else
	** to go.  It is probably not a good ideal to call a signal handler
	** on the off chance that it could fix up things.
	**	If int is .ICAOV or .ICFOV, we can just ignore it.
	**	Else, if PC is JSYS-mode and within jsys(), handle it normally.
	**	Otherwise, fail with error message.
	*/
	skipl chnflg(1)		/* Synchronous channel? */
	 jrst pisys2		/* Not synch, we're OK */
	caie 1,.icaov		/* Is it either .ICAOV or .ICFOV? */
	 cain 1,.icfov
	  jrst pisret		/* If either, ignore interrupt completely */
	cain 1,.icnxp		/* Is it a Non-ex page create trap? */
	  jrst pisret		/* Yes, best we can do now is ignore it. */
	move 2,@aintflgs	/* Get PC flags */
	tlne 2,(pc%usr)		/* In user mode? */
	 jsr USYS_VAR_ASM_REF(psyerr) /* Yes, fail with error msg! */
	cail 17,0		/* Get PC for checking */
	 skipa 2,@aintpc	/* (extended PC) */
	  hrrz 2,@aintpc	/* (single-sect PC) */
	caml 2,[$$SECT,,.jsbeg]	/* See whether it's within jsys() call */
	 camle 2,[$$SECT,,.jsend]
	  jsr USYS_VAR_ASM_REF(psyerr) /* Ugh, no!  Fail with error message. */
	jrst pisys3		/* Yes, go abort the jsys() call!! */


	/* Now do normal signal mask check */
pisys2:	move 2,chnbit(1)	/* Get channel mask bit */
	iorm 2,USYS_VAR_ASM_REF(chnpendmask)
				/* Set it in channel pending mask */
	skipn 2,csgmsk(1)	/* Get signal mask for this channel */
	 jsr USYS_VAR_ASM_REF(psierr) /* Ugh!  No mapping set??? */
	tdne 2,USYS_VAR_ASM_REF(sigpnm) /* Is bit already set? */
	 skipe USYS_VAR_ASM_REF(frktrm)	/* And no pending fork termination? */
	  caia			/* No, proceed */
	   jrst pisret		/* Yeah, just return. */
	iorm 2,USYS_VAR_ASM_REF(sigpnm)
				/* Set bit in signal pending mask */
	tdne 2,USYS_VAR_ASM_REF(sigbkm) /* Is signal currently blocked? */
	 skipe USYS_VAR_ASM_REF(frktrm)	/* And no pending fork termination? */
	  caia			/* No, proceed */
	   jrst pisret		/* Yes, do immediate return */

	/* Signal is not blocked -- if this was not within USYS code we would
	** now go handle the signal.  But USYS code is never interrupted from;
	** the most we do is check for whether we should abort a jsys() call
	** being made by the USYS code.
	** We no longer need AC1 so that can be re-used now.
	*/
	/* Check whether PC is within the critical code range of an
	** interruptible jsys() call.  If so, we abort the JSYS (or don't
	** even attempt to perform it).
	*/

pisys4:	cail 17,0		/* Skip if single-section */
	 skipa 2,@aintpc	/* Extended, get extended PC */
	  hrrz 2,@aintpc	/* Get single-section PC */
	caml 2,[$$SECT,,.jsbeg]
	 camle 2,[$$SECT,,.jsend]
	  jrst pisret		/* Not within jsys(), just return. */

	/* Within jsys(), see if this is an interruptible call */
	tlnn 15,(<JSYS_OKINT>)	/* Check flag in AC15 */
	 jrst pisret		/* Not interruptable, just continue it! */

	/* Within jsys(), abort if monitor PC or at critical instr locs. */
	move 1,@aintflgs	/* Get PC flags */
	tlnn 1,(pc%usr)		/* In user mode? */
	 jrst pisys3		/* No, is within JSYS, must abort! */
	move 1,.jscct		/* Get AOBJN to critical code table */
	came 2,(1)		/* Compare PC with critical code addr */
	 aobjn 1,.-1		/* Check all until find match or run out */
	jumpge 1,pisret		/* If no match, just return normally */

	/* Ugh, must abort jsys(). */
	skipa 2,[$$SECT,,.jsabt]	/* Aborted before JSYS executed */
pisys3:	 move 2,[$$SECT,,.jsint]	/* Aborted during JSYS execution */
	movem 2,@aintpc		/* Store new PC */
	movsi 2,(pc%usr)
	iorm 2,@aintflgs	/* Set user-mode bit just in case */
				/* Now drop thru to return */
pisret:	dmove 1,USYS_VAR_ASM_REF(psisv) /* Restore the 2 ACs we used */
	debrk%			/* Now return from interrupt! */

	/* Handle interrupt from user (not USYS) code. */
piuser:	skipn 2,csgmsk(1)	/* Get signal mask bit for that channel */
	 jsr USYS_VAR_ASM_REF(psierr) /* Ugh, no signal equiv?? */
	
	/* Do normal signal mask check */
	skipn USYS_VAR_ASM_REF(frktrm) /* Ignore block if pending frktrm */
	 tdnn 2,USYS_VAR_ASM_REF(sigbkm) /* Is signal currently blocked? */
	  jrst piusr1		/* No, go check pending mask... */
	iorm 2,USYS_VAR_ASM_REF(sigpnm)
				/* Blocked, set bit in signal pending mask */
	skipl 2,chnflg(1)	/* Blocking... is this a synch chan? */
	 jrst piurt2		/* No, all's well */
	/* Blocking a synch int!  Ignore it unless this is a panic channel. */
	tlne 2,(cf%pan)		/* Skip if OK to ignore it */
	 jsr USYS_VAR_ASM_REF(psierr)
				/* Ugh, trying to block a panic channel! */
	move 2,csgmsk(1)	/* Ignore the signal.  Get mask bit again */
	andcam 2,USYS_VAR_ASM_REF(sigpnm)
				/* and flush from pending ints */
	jrst piurt3		/* and return. */

	/* Signal not blocked.  Check pending mask;
	** if it isn't already pending, we always handle the signal.
	** but if it IS already pending, then we DON'T handle it, unless
	** we can determine that _sigtrigpend() is responsible for the int.
	** The rationale behind this is that if the signal is pending,
	** _sigtrigpend() either is triggering or will trigger it; if it
	** hasn't yet, we have to wait until it does otherwise we will
	** probably invoke the handler twice instead of once.
	**
	** Note comments in PSICH0 where _sigtrigpend() is called
	** to re-trigger interrupts; the code there must do special
	** hackery to bypass this check.
	*/
piusr1:	tdnn 2,USYS_VAR_ASM_REF(sigpnm)
				/* Bit already set in signal pending mask? */
	 jrst piusr2		/* No, go invoke handler! */
	cail 17,0		/* Ugh, must examine PC!  Get right form */
	 skipa 2,@aintpc	/* Extended, get extended PC */
	  hrrz 2,@aintpc	/* Get single-section PC */
	camn 2,[$$SECT,,.sigtx]	/* Was this the IIC% in _sigtrigpend()?? */
	 jrst piusr2		/* Yes, OK to go invoke handler! */
				/* Nope -- drop thru to keep it suspended. */

piurt2:	move 2,chnbit(1)	/* Get mask bit for channel */
	iorm 2,USYS_VAR_ASM_REF(chnpendmask)
				/* to also set bit in channel pending mask. */
piurt3:	dmove 1,USYS_VAR_ASM_REF(psisv) /* Restore 2 ACs */
	debrk%			/* and return. */

	/* We're going to take the signal!
	** Now set up new sigpendmask and chnpendmask; sigblockmask is
	** taken care of farther along.
	** Since the chn-sig map here is many-to-one, we can always flush the
	** channel bit from chnpendmask, but we can't clear the signal bit
	** from sigpendmask without checking to make sure there are no
	** other pending channels mapped into that signal.
	*/
piusr2:	move 2,chnbit(1)	/* Get channel bit */
	andcab 2,USYS_VAR_ASM_REF(chnpendmask)
				/* Flush this from mask of pending chans */
	movem 1,USYS_VAR_ASM_REF(psichn)
				/* Remember channel # interrupt was on */
	move 1,chnsig(1)	/* AC1 now contains signal # */
	move 2,sigcmask		/* Get pointer to signal->channel mask table */
	addi 2,(1)		/* Add signal offset */
	move 2,(2)		/* Get channel mask for signal */
	tdne 2,USYS_VAR_ASM_REF(chnpendmask)
				/* Test pending chns vs chnbits for this sig */
	 jrst piusr3		/* Signal still pending */
	move 2,sigbit(1)	/* Get signal bit, */
	andcam 2,USYS_VAR_ASM_REF(sigpnm) /* and clear it from mask. */

	/* Entry point for CHNmisc (miscellaneous) signals, common code
	** from here on.  sigpendmask and chnpendmask must have been
	** updated.
	**    AC1/ signal #
	** psichn/ channel #
	**
	** First thing we want to do is save all ACs (so we have more to
	** work with), but before that we have to find out whether we can
	** use the current stack or need to switch to the signal stack.
	*/
piusr3:	movem 17,USYS_VAR_ASM_REF(psia17) /* Save stack ptr for later */
	skipe USYS_VAR_ASM_REF(sigssp) /* No signal stack? */
	 skipe USYS_VAR_ASM_REF(sigons) /* Or already on signal stack? */
	  jrst piusr4		/* Yep to either, skip context switch */

	/* Signal stack exists but we're not currently on it. */
	move 2,sigflg		/* Get pointer to flag table */
	addi 2,(1)		/* Add signal offset */
	move 2,(2)		/* Get flags */
	trnn 2,<SF_SIGSTK>	/* Is this channel a candidate for sigstk? */
	 jrst piusr4		/* Nope */

	/* Switch to use signal stack! */
	movem 17,USYS_VAR_ASM_REF(psistk)
				/* Save old stack pointer for debugging */
	move 17,USYS_VAR_ASM_REF(sigssp) /* Set new pointer! */
	setom USYS_VAR_ASM_REF(sigons) /* Say currently on the signal stack! */
	/* Drop through to save context after stack change */
	
	/* Save vector of information on stack */
	tdza 2,2		/* Stack change -- remember old state was 0 */
piusr4:	 move 2,USYS_VAR_ASM_REF(sigons)
				/* No stack change -- use current state */
	push 17,@aintpc		/* #0 sc.pc	Return address (int PC) */
	push 17,@aintflgs	/* #1 sc.pcflgs	PC flags */
	push 17,USYS_VAR_ASM_REF(psichn)
				/* #2 sc.osinf	Channel # (OS dependent) */
	push 17,1		/* #3 sc.sig	Signal # */
	push 17,USYS_VAR_ASM_REF(sigframe)
				/* #4 sc.prev	Old signal frame pointer */
	push 17,2		/* #5 sc.stkflg	Old signal stack state */
	push 17,USYS_VAR_ASM_REF(sigbkm)
				/* #6 sc.mask	Old signal block mask */
	adjsp 17,017		/*    sc.acs	Make room for ACs 0-16 */
	push 17,USYS_VAR_ASM_REF(psia17)
				/* Plus saved 17; frame is now full-sized! */

	/* In following code, note that start of frame is at -<scsiz-1>(17) */
	jumpge 17,piusr5	/* Jump if must handle extended version */

	/* Single-section frame push */
	hrrzs sc.pc-<scsiz-1>(17)	/* Flush flag trash from PC */
	movei 2,sc.acs-<scsiz-1>(17)	/* <src>,,<dst> */
	blt 2,<sc.acs+16>-<scsiz-1>(17)	/* Copy all ACs except 17 */
	jrst piusr6

	/* Multi-section frame push */
piusr5:	movem  0, <sc.acs+0>-<scsiz-1>(17)
	dmovem 3, <sc.acs+3>-<scsiz-1>(17)	/* Skip 1-2, go on with 3-16 */
	dmovem 5, <sc.acs+5>-<scsiz-1>(17)
	dmovem 7, <sc.acs+7>-<scsiz-1>(17)
	dmovem 11,<sc.acs+11>-<scsiz-1>(17)
	dmovem 13,<sc.acs+13>-<scsiz-1>(17)
	dmovem 15,<sc.acs+15>-<scsiz-1>(17)
piusr6:	dmove 5,USYS_VAR_ASM_REF(psisv) /* Set right values for 1-2 */
	dmovem 5,<sc.acs+1>-<scsiz-1>(17)
	xmovei 16,-<scsiz-1>(17)	/* Get pointer to this context frame */
	movem 16,USYS_VAR_ASM_REF(sigframe) /* Set new signal frame! */
	/* Done with frame pushing.
	** AC1/ <signal #>
	*/

	/* Get handler routine dispatch */
	push 17,16			/* Arg 3: pointer to context */
	push 17,USYS_VAR_ASM_REF(psichn) /* Arg 2: PSI channel # */
	push 17,1			/* Arg 1: signal # */
	pushj 17,gethnd			/* Get handler address */
	caig 1,17			/* Valid handler address? */
	 jsr USYS_VAR_ASM_REF(psierr) /* Bad handler address */
	movem 1,USYS_VAR_ASM_REF(psihnd) /* Save handler address */

	/* Now set new block mask */
	move 6,sigmsk			/* Get pointer to mask table */
	add 6,(17)			/* Add signal offset */
	move 6,(6)			/* Get new block mask for handler */
	tdne 6,USYS_VAR_ASM_REF(sigbkm)	/* Signal already blocked? */
	 jrst piusr7			/* Yes, call at interrupt level */
	movem 6,USYS_VAR_ASM_REF(sigbkm) /* Set new signal block mask! */

	/* Now invoke the handler routine! */
	move 1,(17)			/* Get signal number back */
	move 2,sigflg			/* Get pointer to flag table */
	addi 2,(1)			/* Add signal offset */
	move 2,(2)			/* Get flags for signal */
	trne 2,<SF_HNDRST>		/* Must we reset if caught? */
	 jrst [	push 17,[0]		/* UGH!! Push SIG_DFL as 2nd arg */
		push 17,1		/* Signal # as 1st arg */
		aos USYS_VAR_ASM_REF(sigusys) /* Ensure no triggering */
		extern signal
		pushj 17,signal
		sos USYS_VAR_ASM_REF(sigusys)
		move 1,(17)		/* Restore signal # */
		adjsp 17,-2		/* Flush stacked stuff */
		move 2,sigflg		/* Get pointer to flag table */
		addi 2,(1)		/* Add signal offset */
		move 2,(2)		/* Restore signal flags */
		jrst .+1]		/* Now can continue normal stuff. */
	trne 2,<SF_INTLEV>		/* If handler should run at int lev, */
	 jrst piusr7			/* Go invoke differently. */
	movsi 5,(pc%usr)		/* Set user-mode bit just in case */
	iorm 5,@aintflgs
	push 17,[$$SECT,,sigrt]		/* Return address from sig handler */
	move 3,USYS_VAR_ASM_REF(psihnd) /* Get handler address */
	move 1,USYS_VAR_ASM_REF(psichn) /* Get channel number */
	skipn USYS_VAR_ASM_REF(frktrm)	/* Inferior fork termination? */
	 jrst piusr8			/* No, proceed */
	push 17,3			/* Yes, stack handler address */
	xmovei 3,.iobclean		/* And call _iobclean() */
piusr8:	movem 3,@aintpc			/* Save for debrk% */
	debrk%				/* Now "return" to new location! */

	/* Invoke handler at interrupt level! */
piusr7:	movei 1,<PSILEV>		/* Indicate interrupt in progress */
	movem 1,USYS_VAR_ASM_REF(intlev)
	move 1,USYS_VAR_ASM_REF(psichn) /* Get channel number */
	skipe USYS_VAR_ASM_REF(frktrm)	/* Inferior fork termination? */
	 pushj 17,.iobclean		/* Yes, call _iobclean() */
	move 1,USYS_VAR_ASM_REF(psihnd) /* Get handler address */
	pushj 17,(1)			/* Call the handler normally! */
	setzm USYS_VAR_ASM_REF(intlev) /* Int no longer in progress. */
	xmovei 16,-<scsiz+3-1>(17)	/* Get ptr to sigcontext on stack */
					/* Drop through to restore context */

	/* Restore context and return from signal handler at
	** interrupt level.  This is also the entry point for returning
	** from certain kinds of channel 0 interrupts.
	** AC2/ <PC fixup flag>		; non-zero to fix up user's return PC
	** AC16/ <frame pointer>
	*/
	tdza 2,2		/* Int-level handler - don't fix up PC. */
piret:	 seto 2,		/* Chan 0 entry point - fix up user PC. */
	move 1,sc.prev(16)	/* Restore old frame ptr */
	movem 1,USYS_VAR_ASM_REF(sigframe)
	move 1,sc.stkflg(16)	/* And previous stack state */
	movem 1,USYS_VAR_ASM_REF(sigons)
				/* (Stack ptr restored from saved AC17) */
	jumpge 17,piret4	/* Jump if extended */

	/* Restore ACs for single section */
	jumpe 2,piret3		/* Jump if don't need to set int PC */
	jsp 15,pclsr		/* Fix up return PC if necessary */
	move 1,sc.pcflgs(16)	/* Set up PC flags */
	hrr 1,sc.pc(16)		/* and PC */
	movem 1,@aintpc		/* for debrk% */
piret3:	move 1,sc.acs+017(16)	/* Get saved stack ptr */
	movem 1,USYS_VAR_ASM_REF(psia17) /* Hold in temporary non-AC place */
	movsi 16,sc.acs(16)
	blt 16,16		/* Restore ACs 0-16 */
	move 17,USYS_VAR_ASM_REF(psia17) /* Restore AC 17 */
	debrk%			/* Return! */

	/* Restore ACs for multi section */
piret4:	jumpe 2,piret5		/* Jump if don't need to set int PC */
	jsp 15,pclsr		/* Fix up return PC if necessary */
	move 1,sc.pcflgs(16)
	movem 1,@aintflgs	/* Set up PC flags */
	move 1,sc.pc(16)
	movem 1,@aintpc		/* and PC, for debrk% */
piret5:	movei 14,014		/* ac 1: count (12 acs) */
	xmovei 15,sc.acs(16)	/* ac 2: source */
	setz 16,		/* ac 3: dest */
	extend 14,[xblt]	/* Restore ACs 0-13 inclusive */

	/* Note that XBLT leaves AC15 pointing to the remaining saved ACs!! */
	dmove 16,2(15)		/* Restore 16-17 */
	dmove 14,(15)		/* Restore 14-15 */
	debrk%			/* Return! */
#endasm
}

/* PSIMSC - Handle CHNmisc PSI for unassigned signals.
**	The affected signal is assumed to be the leftmost bit in sigpendmask
** which isn't blocked by sigblockmask and is one of the signals mapped
** into this PSI channel.
**	We have to check the handler action specially because all of these
** signals must come here regardless of the actual action; for the other
** signals (mapped into specific chans) the PSI system has already taken
** care of the action.
*/
static void
psimsc()
{
	if (0) `BUGACS`[0]++;
#asm
	skiple USYS_VAR_ASM_REF(sigusys) /* Are we in USYS code? */
	 jsr USYS_VAR_ASM_REF(psierr) /* Should never happen! */
	dmovem 1,USYS_VAR_ASM_REF(psisv)
	movei 1,CHNmisc
	movem 1,USYS_VAR_ASM_REF(psichn) /* Set the current channel # */

	move 1,USYS_VAR_ASM_REF(sigpnm)
				/* Find which signals are pending */
	andcm 1,USYS_VAR_ASM_REF(sigbkm)
				/* and which of these might have happened */
	and 1,csgmsk+CHNmisc	/* and which of these map into this channel */
	jffo 1,pimsc2		/* Pick leftmost 1 as signal we'll handle! */
	jsr USYS_VAR_ASM_REF(psierr)
				/* No valid signal??? Something's wrong! */

	/* Re-entry point to check for further signals on this channel */
pimsc1:	move 1,USYS_VAR_ASM_REF(sigpnm)
				/* Find which signals are still pending */
	andcm 1,USYS_VAR_ASM_REF(sigbkm)
				/* and which of these might have happened */
	and 1,csgmsk+CHNmisc	/* and which of these map into this channel */
	jffo 1,pimsc2		/* Pick leftmost 1 as signal we'll handle! */
	dmove 1,USYS_VAR_ASM_REF(psisv) /* None left, just restore ACs */
	debrk%			/* and return. */

	/* Signal bit selected for processing! */
pimsc2:	movei 1,44
	subi 1,(2)		/* Set the signal # */
	move 2,sigbit(1)	/* Get bit for this signal only */
	andcab 2,USYS_VAR_ASM_REF(sigpnm)
				/* Flush it out of pending mask! */
	tdne 2,csgmsk+CHNmisc	/* Of remaining sigs, do any map to CHNmisc? */
	 jrst pimsc3		/* Yes, so leave chan bit alone */
	move 2,chnbit+CHNmisc
	andcam 2,USYS_VAR_ASM_REF(chnpendmask)
				/* No, must flush this channel pending bit! */

	/* Now check action specified for signal. */
pimsc3:	move 2,actsig		/* Get pointer to action table */
	addi 2,(1)		/* Add signal offset */
	skipl 2,(2)		/* Find SA_ action for this signal */
	 cail 2,<SA_N>
	  jsr USYS_VAR_ASM_REF(psierr) /* Bad SA_ action value! */
	cain 2,<SA_HND>		/* Call signal handler? */
	 jrst piusr3		/* Yes, join common signal code */
	cain 2,<SA_IGN>		/* Ignore signal? */
	 jrst pimsc1		/* Yes, go look for another signal to handle */
	cain 2,<SA_STP>		/* Stop process? */
	 jrst pimsc4		/* Yeah, handle stop specially. */

	/* SA_TRM and SA_DMP come here. Signal already in 1. */
	
	caie 2,<SA_DMP>		/* Core dump requested? */
	 jrst pimsc5		/* No */
	tro 1,0200		/* Set dump bit */
	skipl $DEBUG##		/* Dumps allowed? */
	 jrst pimsc5		/* No */
	move 4,1		/* Save status */
	movem 1,BUGACS+1	/* Save register 1 */
	jsp 1,cdump
	move 1,4		/* Restore status */
pimsc5:	haltf%			/* For now, just halt */
	jrst pimsc1		/* If continued, handle next signal if any */

	/* Handle SA_STP.  This stops process, and (hack) generates a
	** SIGCONT signal if proceeded.
	*/
pimsc4:	lsh 1,010		/* Move signal into position */
	tro 1,0177		/* Set _WSTOPPED */
	haltf%			/* Stop process */
	move 1,sigbit+<023>	/* 023 = 19. = SIGCONT */
	iorm 1,USYS_VAR_ASM_REF(sigpnm) /* Add to signal mask */
	jrst pimsc1		/* Go handle it. */

/* SIGRT - Control returns here from a signal handler.
**	Note that this does not run at interrupt level, normally.
** But there is one special case where a channel-0 interrupt is generated in
** order to handle things at interrupt level - if the stack state needs to be
** changed back.  There seems to be no real way of restoring an alternate stack
** pointer without doing an IIC% so that the DEBRK% can restore things and
** return properly.  We do this only if the current and previous
** stack are different.
**	In addition, there is another special consideration.  Because the
** signal block mask is being changed, we need to re-check for additional
** pending interrupts.  However, it is not a good idea to simply trigger
** those right away, since continuous interrupts could then
** pile up infinite signal frames on the stack.  We need to
** either restore the frame and re-interrupt, or re-use the frame.
**	It would be possible to re-use the current frame by using a channel 0
** interrupt to get into interrupt level, and some code exists for this
** purpose, but it is commented out.  It mainly simulates the actions of
** the other PSI code, and I judged it too prone to bugs.
**	So, the approach used is to simple-mindedly get into interrupt
** level, restore the frame, and re-trigger the new interrupts.  The problem
** with this (in T20, there are always problems) is that you cannot
** regenerate a panic-channel interrupt (with IIC%) while at interrupt level,
** or the system will halt the process!  This is not expected to happen
** however as the code at "piurt2" prevents such interrupts from being
** blocked -- thus we should never be trying to unblock and re-trigger
** such interrupts.
**
**	Last word of context structure is at offset -3 from the top of
** stack (we pushed 3 args when calling handler).
*/
	/* Entry point when signal handler does normal return */
sigrt:	xmovei 16,-<scsiz+3-1>(17) /* Get pointer to sigcontext on stack */

	/* AC16 contains a pointer to the sigcontext to restore. */
	setcm 2,sc.mask(16)	/* Get complement of old signal block mask */
	tdne 2,USYS_VAR_ASM_REF(sigpnm)
				/* Check new mask vs pending signals */
	 jrst sigrti		/* Pending signals will be unblocked! */
	move 1,sc.stkflg(16)	/* Get old stack state */
	came 1,USYS_VAR_ASM_REF(sigons) /* Same as current state? */
	 jrst sigrti		/* No, must switch context at int level */
	
	setcam 2,USYS_VAR_ASM_REF(sigbkm) /* Restore signal block mask! */

	/* New mask has been restored, and there were no pending ints we
	** had to trigger, so we can now proceed with normal restoration
	** of previous context!
	** Tricky part is proper setting of PDL ptr so it points to the
	** return address for our POPJ!
	*/
	move 1,sc.prev(16)	/* Get previous sigframe ptr */
	movem 1,USYS_VAR_ASM_REF(sigframe) /* Restore it */
	jsp 15,pclsr		/* Fix up return PC if necessary */
	move 1,sc.acs+017(16)	/* Get saved AC17, should point just before */
	adjsp 1,scsiz		/* Ensure this frame is safe on stack */
	move 17,1		/* Set new stack ptr! */
	jumpge 17,sigrt5	/* Handle extended if extended */

	movsi 16,sc.acs(16)	/* Get <acaddr>,,0 */
	blt 16,16		/* Restore ACs 0-16 */
	jrst sigrt9

sigrt5:	movei 14,014		/* Move only 12 ACs */
	xmovei 15,sc.acs(16)	/* Source is start of saved ACs */
	setz 16,		/* Dest is AC 0 */
	extend 14,[xblt]	/* Restore ACs 0-13 inclusive */
	/* Note that XBLT leaves AC15 pointing to the remaining saved ACs!! */
	move 16,2(15)		/* Restore 16 (but not 17) */
	dmove 14,(15)		/* Restore 14-15 */

	/* Return.  The POPJ works because the interrupt PC is
	** the first thing on the stack frame, and the saved 17 is assumed
	** to point just before the stack frame.  So we flush all of the
	** frame except the 1st word, and the POPJ uses that as the new
	** PC while simultaneously flushing the last part of the frame
	** and restoring the old stack pointer.
	*/
sigrt9:	adjsp 17,-<scsiz-1>	/* Flush all but return addr off stack */
	popj 17,		/* Return! */

	/* Either must switch stack, or new signals must be triggered.
	** Do the job the hard way.
	*/
sigrti:	push 17,16		/* Argument to sigreturn() */
	pushj 17,sigreturn	/* Invoke hairy stuff! */
	pushj 17,abort		/* Should never come here */

/* PCLSR - PC the Luser.  Auxiliary routine to adjust PC before returning
**	to interrupted code.
** Called by JSP 15,PCLSR (must avoid touching stack)
**	16/ pointer to signal frame being restored
** Clobbers 5,6 (and 15 of course)
*/

pclsr:	move 5,sc.pcflgs(16)	/* Get PC flags from frame */
	tloe 5,(pc%usr)		/* Were we interrupted from a JSYS? */
	 jrst (15)		/* No, no need to hack PC! */

	/* Old PC was JSYS-mode, ugh!  Must do complicated testing. */
	movem 5,sc.pcflgs(16)	/* Yes, restore new flags (user-mode bit on) */
	sos 5,sc.pc(16)		/* Get old PC, provisionally back it up */
	hrrz 6,sc.osinf(16)	/* Get PSI channel that int was for */
	skipge chnflg(6)	/* Synchronous interrupt? */
	 jrst pclsr5		/* Yes, must handle differently. */

	/* JSYS was asynchronously interrupted, so restart it unless
	** it was within an interruptible jsys() call, or if it was
	** an IIC% (which undoubtedly interrupted itself, barf!)
	*/
	caml 5,[$$SECT,,.jsbeg]	/* Are we inside jsys()? */
	 camle 5,[$$SECT,,.jsend]
	  jrst pclsr7		/* No, was in-line JSYS, try to restart. */
	move 6,sc.acs+015(16)	/* Get AC15 at time of interrupt from jsys() */
	tlne 6,(<JSYS_OKINT>)	/* Is flag set permitting ints? */
	 jrst pclsr8		/* Yes, so make jsys() fail due to int */
	jrst pclsr7		/* No, do restart. */

	/* JSYS was synchronously interrupted!
	** The only case for which this should be possible is that of an
	** in-line JSYS without an ERJMP.  Nevertheless, just in case,
	** we test for being inside jsys() and abort if so; we also
	** check for an in-line ERJMP.
	** If JSYS was in-line without an ERJMP we just restart it, sigh.
	*/
pclsr5:	caml 5,[$$SECT,,.jsbeg]	/* Are we inside jsys()? */
	 camle 5,[$$SECT,,.jsend]
	  caia			/* No, was in-line JSYS */
	   jrst pclsr8		/* Yes, so make jsys() take int return! */
	hlrz 6,1(5)		/* Get LH of instruction following the JSYS */
	caie 6,(<erjmp>)	/* Is this a simple ERJMP? */
	 jrst pclsr7		/* No, do a restart (will probably re-fail) */
	hrr 5,1(5)		/* Plug in E field of ERJMP */
	movem 5,sc.pc(16)	/* Store new PC (works for extended too!) */
	jrst (15)		/* Return */

	/* Do a restart with the backed-up PC (in AC5) */
pclsr7:	move 5,(5)		/* Get contents of instruction there */
	came 5,[eir%]		/* Is it an EIR%? */
	 camn 5,[iic%]		/* or IIC%? */
	  aosa 5,sc.pc(16)	/* Yes, un-do the backup and skip */
	   jrst (15)		/* No, just return with PC set for a re-try. */
	came 5,[$$SECT,,.sigtx]	/* Was this the EIR% in _sigtrigpend()?? */
	 jrst (15)		/* Nope */
	/* We are restarting at _sigtrigpend().  See if the handler permits
	** syscall restarts or not, and pass this info on to the caller of
	** _sigtrigpend() by bumping the PC again if so.
	*/
	move 5,sc.sig(16)	/* Get signal # */
	add 5,sigflg		/* Add pointer to flag table */
	move 5,(5)		/* Get flags for this signal */
	trnn 5,<SF_SYSINT>	/* Should syscall be interrupted? */
	 aos sc.pc(16)		/* No, so make _sigtrigpend() return +1 */
	jrst (15)		/* Yes, let it return -1 */

	/* Make jsys() take interrupt return.
	** Change the return address to ensure that jsys() returns the
	** appropriate value saying "interrupted".
	*/
pclsr8:	move 5,[$$SECT,,.jsint]	/* Make control return to new location! */
	movem 5,sc.pc(16)
	jrst (15)		/* OK, all done! */
#endasm
}

/* SIGRETURN - Restore sigcontext frame.
**	Generates a channel-0 PSI to do job at interrupt level.
*/

int
sigreturn(scp)
struct sigcontext *scp;
{
#asm
	skipn 16,-1(17)		/* Get pointer to context in AC16 */
	 jrst sigrt1
	movei 1,.fhslf
	movsi 2,400000		/* Channel 0 */
	iic%
sigrtx:	jsr USYS_VAR_ASM_REF(psierr) /* Die horribly if we ever get here! */
sigrt1:				/* If bad pointer, make syscall fail */
#endasm
    errno = EINVAL;		/* by dropping thru to this code. */
    return -1;
}

/* PSICH0 - Come here for channel 0 interrupt, for interrupt-level
**	processing of a signal handler return.  Either the stack must be
** switched from signal stack to normal stack, or the new block mask has
** uncovered some signals that need to be invoked and handled.
**	This is invoked ONLY from SIGRETURN (the PC should be "sigrtx").
** See comments there for additional info.
**	AC 16 will point to the signal context struct to restore.
*/
static void
psich0()
{
#asm
	movem 1,USYS_VAR_ASM_REF(psisv) /* Save AC just in case we die here. */
	hrrz 1,@aintpc		/* Check return PC */
	caie 1,sigrtx		/* If it isn't what we expect, */
	 jsr USYS_VAR_ASM_REF(psierr) /* die horribly. */

	/* OK to clobber any ACs now, except for 16 which points to the
	** sigcontext we want to restore, and 17 which must be last thing.
	*/
	move 1,sc.mask(16)	/* Get signal block mask to restore */
	movem 1,USYS_VAR_ASM_REF(sigbkm)
	andca 1,USYS_VAR_ASM_REF(sigpnm)
				/* Are there any pending signals now active? */
	jumpe 1,piret		/* If none, jump to restore context normally */

	/* There are pending signals that should now be triggered! */

#if 0
	/* Instead of going through a needless cycle of restore
	** and re-interrupt, we can just re-use the current signal frame!
	** This should be OK unless frame is not really on stack...
	** We check this by comparing AC16 with USYS_VAR_ASM_REF(sigframe) .
	*/
	camn 16,USYS_VAR_ASM_REF(sigframe) /* Same? */
	 jrst ch0ha5		/* Yes, go do special re-use stuff! */
	/* Trying to restore a sigcontext frame that doesn't seem to be
	** coming from the stack, therefore we can't re-use it.
	** Drop through to do safe slow thing.
	*/
#endif

	/* Do safe slow thing by using IIC% to trigger new interrupts,
	** which will be suspended by PSI system until the DEBRK, and doing a
	** complete restoration of the frame we have.
	** This will fail if any of the pending interrupts were on panic
	** channels.  It's not clear what we could do about them anyway.
	**
	** Note: see code at PIUSR1 where the PSI handler checks the
	** sigpendmask bits.  Due to this check, we have to turn off
	** the triggered signal bits here, otherwise the PSI interrupts
	** will be ignored.  The code here assumes that _sigtrigpend()
	** has triggered all unblocked signals; we leave CHNmisc signals
	** alone since PSIMSC has to examine sigpendmask in order to find
	** out which signal was intended.  What a mess.
	*/
	push 17,16
	pushj 17,.sigtrigpend	/* Trigger new interrupts with IIC% */
	pop 17,16		/* Restore frame pointer */
	move 1,USYS_VAR_ASM_REF(sigbkm) /* Find signals that are blocked */
	ior 1,csgmsk+CHNmisc	/* Combine with signals that use CHNmisc */
	andm 1,USYS_VAR_ASM_REF(sigpnm)
				/* Turn off all other sigs in pending mask! */
	jrst piret		/* Then go restore context normally */

#if 0
	/* Hairy stuff to efficiently re-use the current signal context frame!
	** The main difficulty is deciding which PSI channel to pretend
	** we are handling.  Once that is done, behavior is similar to
	** that of a real channel interrupt, but most of the sigcontext
	** frame can stay as it is.
	** - The frame may need to be moved to a signal stack if the handler
	** wants to execute there and we're not already there.
	** - The various masks need to be updated as if this were a real
	** interrupt.
	** - The handler args can be moved (rather than pushed) onto stack.
	**
	** AC1 has the signal bits for the signals that want activation.
	*/
ch0ha5:	jffo 1,.+2		/* Find leftmost signal bit */
	 jsr USYS_VAR_ASM_REF(psierr) /* Ugh, should have been at least one! */
	movei 1,44
	subi 1,(2)		/* Get signal # in AC1 */

	/* Have selected signal # (in AC1) to simulate interrupt on. */
	skipe USYS_VAR_ASM_REF(sigssp) /* No signal stack? */
	 skipe USYS_VAR_ASM_REF(sigons) /* Or already on signal stack? */
	  jrst ch0ha8		/* Just use current stack */
	move 2,sigflg		/* Get pointer to flag table */
	addi 2,(1)		/* Add signal offset */
	move 2,(2)		/* Get flags */
	trnn 2,<SF_SIGSTK>	/* Is this channel a candidate for sigstk? */
	 jrst ch0ha8		/* Nope */

	/* Switch to use signal stack!  Ugh! */
	move 5,sc.acs+17(16)
	movem 5,USYS_VAR_ASM_REF(psistk) /* Save old stack ptr for debugging */
	move 17,USYS_VAR_ASM_REF(sigssp) /* Get new pointer */
	setom USYS_VAR_ASM_REF(sigons) /* Say currently on signal stack */
	xmovei 15,1(17)		/* Set up pointer to new loc */
	adjsp 17,scsiz+3	/* Make room for sigcontext and args */

	/* Copy sigcontext to new stack */
	jumpge 17,ch0ha6
	hrli 15,(16)		/* Single-section, get <src>,,<dst> */
	blt 15,-3(17)		/* Copy sigcontext to new stack */
	jrst ch0ha7
ch0ha6:	xmovei 14,(16)		/* Set up source addr */
	movei 13,scsiz		/* XBLT args <cnt> ? <src> ? <dst> */
	extend 13,[xblt]	/* Copy sigcontext to new stack */

	/* Finalize the frame in its new location */
ch0ha7:	xmovei 16,-<scsiz+3-1>(17)	/* Set up pointer to new sigcontext */
	movem 16,USYS_VAR_ASM_REF(sigframe)

	/* Now fix up new sigpendmask and chnpendmask.
	** AC1/ signal #
	*/
ch0ha8:	move 2,sigcmask		/* Get pointer to signal->channel mask table */
	addi 2,(1)		/* Add signal offset */
	move 2,(2)		/* Get chan bits for this signal */
	andcm 2,USYS_VAR_ASM_REF(chnpendmask)
				/* Only allow those chans still pending */
	jffo 2,.+2		/* Find leftmost chan bit */
	 jsr USYS_VAR_ASM_REF(psierr) /* Should always be one!!! */

	/* Channel # now in AC3. */
	cain 3,CHNmisc		/* Is this the special misc channel? */
	 jrst ch0ha9		/* Yeah, must handle differently. */
	move 2,chnbit(3)	/* Get channel bit alone */
	andcab 2,USYS_VAR_ASM_REF(chnpendmask)
				/* Flush chn from mask of pending chans */
	move 4,sigcmask		/* Get pointer to action table */
	addi 4,(1)		/* Add signal offset */
	tdne 2,(4)		/* Test pending chns vs chnbits for this sig */
	 jrst ch0h10		/* Some left, so don't clear bit */
	move 2,sigbit(1)	/* None left, so can clear signal bit!  Get */
	andcam 2,USYS_VAR_ASM_REF(sigpnm)
				/* bit, and clear it from mask. */
	jrst ch0h10

	/* Handle CHNmisc bit cleanup.
	** This is somewhat deficient as it should check to see what the
	** SA_ signal action value is for the specific signal involved.
	** It may need to ignore the signal, or halt, rather than call a
	** handler as the code currently implies.  Sigh!
	*/
ch0ha9:	move 2,sigbit(1)	/* Get bit for this signal only */
	andcab 2,USYS_VAR_ASM_REF(sigpnm)
				/* Flush it out of pending mask! */
	tdne 2,csgmsk+CHNmisc	/* Of remaining sigs, do any map to CHNmisc? */
	 jrst ch0h10		/* Yes, so leave chan bit alone */
	move 2,chnbit+CHNmisc
	andcam 2,USYS_VAR_ASM_REF(chnpendmask)
				/* No, must flush this channel pending bit! */

	/* Final fix-ups. */
	/* Note old block mask is still valid and need not be re-saved. */
ch0h10:	movem 1,sc.sig(16)	/* Set signal # that interrupt is for */
	hrrzm 3,sc.osinf(16)	/* Set channel # */
	move 2,sighnd		/* Get pointer to handler table */
	addi 2,(1)		/* Add channel offset */
	move 2,(2)		/* Get handler for channel */
	movem 2,@aintpc	/* Store for debrk */
	move 2,sigmsk		/* Get pointer to mask table */
	addi 2,(1)		/* Add channel offset */
	move 2,(2)		/* Get new block mask for this handler */
	movem 2,USYS_VAR_ASM_REF(sigbkm) /* Set new signal block mask! */

	movem 16,-2(17)			/* Arg 3: ptr to sigcontext frame */
	movem 3,-1(17)			/* Arg 2: PSI channel # */
	movem 1,(17)			/* Arg 1: signal # */
	push 17,[$$SECT,,sigrt]		/* Set return address for handler */
	debrk%				/* Go to handler! */
#endif /* Commented out */
#endasm
}

/* Error handlers for errors detected within PSI code.
*/
static void
errdummy()
{
    if (0) errdummy();	/* Avoid KCC warning of non-ref */
#asm
psyer2:	dmovem 1,USYS_VAR_ASM_REF(psiesv)
	xmovei 1,USYS_VAR_ASM_REF(psiesv)
	dmovem 3,2(1)
	movei 1,.cttrm
	hrroi 2,[asciz "
?Fatal PSI interrupt in USYS code at PC = "]
	setz 3,
	sout%
	move 2,@aintpc
	jrst psier7

psier2:	dmovem 1,USYS_VAR_ASM_REF(psiesv)
	xmovei 1,USYS_VAR_ASM_REF(psiesv)
	dmovem 3,2(1)
	movei 1,.cttrm
	hrroi 2,[asciz "
?Fatal error in sigvec() PSI interrupt handler at PC = "]
	setz 3,
	sout%
	move 2,USYS_VAR_ASM_REF(psierr)

psier7:	move 3,[no%mag+8]
	nout%
	 jfcl
psier8:	hrroi 2,[asciz /
 Last error = /]
	setz 3,
	sout%
	movei 1,.fhslf
	geter%
	movei 1,.cttrm
	hrrz 2,2
	movei 3,10
	nout%
	 jfcl
	hrroi 2,[asciz /
/]
	setz 3,
	sout%

	skipge $DEBUG##		/* Want dump? */
	 jrst psier9		/* No */
	movem 1,BUGACS+1	/* Save register 1 */
	jsp 1,cdump		/* Try to make CORE.EXE */

psier9:	movei 1,0212		/* Core dump and SIGSYS */
	haltf%			/* Halt with status in 1 */

	movei 1,.cttrm
	hrroi 2,[asciz /
?Cannot continue from this error/]
	setz 3,
	sout%
	jrst psier8

cdump:	movem 1,USYS_VAR_ASM_REF(psierr) /* Save return here */
	movem 0,BUGACS
	move 1,[2,,BUGACS+2]
	blt 1,BUGACS+17		/* Save remaining ACs */
	movsi 1,(gj%fou!gj%sht)
	hrroi 2,[asciz /UNIX-DUMPS:CORE.EXE/]
	gtjfn%
	 erjmp cdumpe
	hrli 1,.fhslf
	move 2,[-4000,,ss%uca!ss%cpy!ss%rd!ss%wr!ss%exe]
				/* Save first 4 sections only */
	ssave%
	 erjmp cdumpe
	movei 1,.cttrm
	hrroi 2,[asciz /
%Core dumped to UNIX-DUMPS:CORE.EXE
/]
	setz 3,
	sout%
cdumpx:	move 1,USYS_VAR_ASM_REF(psierr)
	jrst (1)		/* Return to caller */

cdumpe:	movei 1,.cttrm
	hrroi 2,[asciz /
?Failed to write CORE dump, last error = /]
	setz 3,
	sout%
	movei 1,.fhslf
	geter%
	movei 1,.cttrm
	hrrz 2,2
	movei 3,10
	nout%
	 jfcl
	hrroi 2,[asciz /
/]
	setz 3,
	sout%
	jrst cdumpx
#endasm
}

/* FFOCLR - Find First One and Clear
**	Takes address of a bit mask and clears the leftmost bit in mask,
** returning as its value the bit position (# bits from high bit).
** If no bits are set, returns -1.
**	Takes advantage of the PDP-10 JFFO instruction.
*/
static int
ffoclr(amask)
unsigned *amask;
{
#asm
	move 1,@-1(17)		/* Get mask bits */
	jffo 1,gotbit		/* Jump if Find First One */ 
	seto 1,			/* Found no bits, return -1 */
	popj 17,
gotbit:	movsi 3,400000		/* Get bit for clear */
	movn 1,2		/* Get negative bit number */
	lsh 3,(1)		/* Shift bit to proper position */
	andcam 3,@-1(17)	/* Turn that bit off in mask */
	move 1,2		/* Return bit position */
#endasm
}

#endif /* T20+10X */

/* KILL - Simulation of Unix kill(2)
*/
int
kill(pid, sig)
pid_t pid;
int sig;
{

    if (pid < 0) pid = -pid;	/* Hope that process group id is root pid */

    USYS_BEG();
    if ((sig < 0) || (_NSIGS < sig) || pid == -1)
	USYS_RETERR(EINVAL);		/* Failure, bad pid or  signal # */

    if ((pid == 0) || (pid == getpid())) {
	_raise(sig);
	USYS_RET(0);
    }
#if SYS_T20+SYS_10X
    {
	int frkh, acs[5];

	/* See whether PID refers to parent. */
	if (pid == USYS_VAR_REF(pidpar))
	    acs[1] = _FHSUP;
	else if ((pid & ~0777777) == 0) {
	    /* Handle signal for inferior child fork. */
	    acs[1] = 0400000 + ((pid >> 9) & 0777);	/* Get fork handle */
	    switch (sig) {		/* Do special stuff */
		case SIGKILL:
		    if (jsys(HFORK, acs) <= 0)	/* Halt inferior fork */
			USYS_RETERR(EACCES);
		    USYS_RET(0);

		case SIGSTOP:
		case SIGTSTP:
		    if (jsys(FFORK, acs) <= 0)	/* Freeze (suspend) child */
			USYS_RETERR(EACCES);
		    USYS_RET(0);

		case SIGCONT:
		    /* See what kind of continuation to use.
		    ** a HALTF by inferior requires SFORK;
		    ** a FFORK by superior requires RFORK.
		    */
		    frkh = acs[1];		/* Remember fork handle */
		    if (jsys(RFSTS, acs) <= 0)	/* Get fork status */
			USYS_RETERR(EACCES);
		    if (FLDGET(acs[1],monsym("RF%STS")) == monsym(".RFHLT")) {
			/* Continue fork after halt */
			acs[1] = monsym("SF%CON") | frkh;
			if (jsys(SFORK, acs) <= 0)
			    USYS_RETERR(EACCES);
		    } else {
			/* Resume fork after freeze */
			acs[1] = frkh;
			if (jsys(RFORK, acs) <= 0)
			    USYS_RETERR(EACCES);
		    }
		    USYS_RET(0);
		case 0:		/* Signal 0 verifies PID */
		    if (jsys(RFSTS, acs) <= 0)
			USYS_RETERR(ESRCH);
		    break;
	    }
	} else USYS_RETERR(EINVAL);		/* Bad PID */

	if (sig) {
	  acs[2] = USYS_VAR_REF(sigcmask[sig]) & (-USYS_VAR_REF(sigcmask[sig]));
						/* One chan only */
	  if (jsys(IIC, acs) <= 0)		/* Do it! */
	    USYS_RETERR(EACCES);		/* Failed? */
	}
	USYS_RET(0);
    }
#endif

    USYS_RETERR(EINVAL);	/* Bad PID */
}

/* KILLPG - Send signal to process group
**	No process groups, assume 'process group' == 'process id'
*/
int
killpg(pgrp, sig)
pid_t pgrp;
int sig;
{
  kill(-pgrp, sig);		/* Just call kill with minus process group */
}

/* RAISE - ANSI function, similar to Unix kill()
**	Note this is not a USYS call.
*/
int
raise(sig)
{
    if (sig < 0 || _NSIGS < sig)
	return -1;		/* Failure */
    _raise(sig);		/* Seems OK, do it */
    return 0;			/* Assume won */
}

/* _RAISE(sig) - auxiliary for raise() and kill().
**	Assumes signal is valid.
*/

void
_raise(sig)
int sig;
{
#if SYS_T20+SYS_10X
    int acs[5];
    int chnbit;
    int sbit = sigmask(sig);

    if (sig == 0) return;	/* Signal 0 is no-op */
    USYS_BEG();		/* Prevent interrupt system from messing around */
    if (!USYS_VAR_REF(sigif))
	_siginit();		/* Initialize USYS signal stuff */
    if (sbit & SNOCATCH) {	/* Is this one of the uncatchable signals? */
	jsys(HALTF, acs);	/* Yes, handle it by halting immediately */
	if (sig == SIGKILL)	/* Die badly if attempt to continue this one */
	    abort();
	(void)USYS_END();	/* Otherwise OK to continue, just return. */
	return;
    }
    if (sbit & `csgmsk`[CHNmisc]) /* Is this one of the misc signals? */
	chnbit = chnmask(CHNmisc); /* Yep, use the misc channel bit */
    else	/* Signal with an assigned chan, find the chan bit to trigger*/
	chnbit = USYS_VAR_REF(sigcmask[sig]) & (-USYS_VAR_REF(sigcmask[sig]));
				/* Find high chn bit */
    if (chnbit == 0)
	abort();		/* Should always have a bit! */

    /* Critical code.  The bits must be added to the masks atomically
    ** since the masks may change during an interrupt.
    ** However, the two masks do not have to be updated as a single
    ** atomic unit since they will not be examined until we are out
    ** of USYS mode, so we don't have to turn interrupts off and on.
    ** It suffices to add the bits with IORM instructions; to ensure
    ** these are used regardless of what the compiler thinks,
    ** we invoke an assembler routine.
    */
    if (USYS_VAR_REF(sigact[sig]) != SA_IGN)
				/* Skip SA_IGN, else signal may pend forever */
      addmask(sbit, chnbit);	/* Add to pending sig/chn masks */

    /* Now can get out of USYS mode.  It is necessary to trigger the
    ** interrupt afterwards, while in "user" mode, because we want to be
    ** able to trigger any kind of interrupt, and it is an error for some of
    ** them to be encountered while in USYS code.
    */
    (void)USYS_END();		/* Leave USYS mode and trigger interrupt! */

#endif /* T20+10X */
}
#if SYS_T20+SYS_10X
static void
addmask(sigbit, chnbit)
int sigbit, chnbit;
{
#asm
	move 1,-2(17)		/* Get channel bit */
	iorm 1,USYS_VAR_ASM_REF(chnpendmask)
				/* Add to pending channel bits */
	move 1,-1(17)		/* Get signal bit */
	iorm 1,USYS_VAR_ASM_REF(sigpnm)
				/* Add to pending signal bits */
#endasm
}
#endif /* T20+10X */

/** ALL OF THE FOLLOWING CODE IS OLD OBSOLETE JUNK RETAINED FOR
***			REFERENCE ONLY
**/
#if 0	/* Commented-out block */

static void
dummyinthandlers()
{
#asm
#if SYS_10X
	movei	1,.fhslf
	move	2,[1B<.ICILI>+1B<.ICEOF>+1B<.ICDAE>]
	aic%			; Always keep these on for 10X
;---------------------

; This code lifted from MIDAS --KLH
A=1
B=2
INTPC1==LEV1PC

; Handle Illegal Instruction (normally a failing JSYS, bletch!)
; 10X ERJMP-handling interrupt routine.
;ERJMPA==:<JUMPA 16,>	; For use instead of ERJMP where JSYS normally skips.
;IFNDEF ERJMP,ERJMP==:<JUMP 16,>
;IFNDEF ERCAL,ERCAL==:<JUMP 17,>

ERXJMP==:<ERJMP_-27>	; For easier code writing
ERXCAL==:<ERCAL_-27>
ERXJPA==:<ERJMPA_-27>

INT.IL:	PUSH 17,A
	PUSH 17,B
	MOVE A,INTPC1		; Get PC we got interrupted from
	LDB B,[271500,,(A)]	; Get op-code and AC field of instr
	CAIN B,ERXJPA
	 JRST ERJFAK
	CAIE B,ERXJMP		; Is it a magic cookie?
	 CAIN B,ERXCAL
	  JRST ERJFAK
	AOJ A,
	LDB B,[271500,,(A)]	; Try next instr
	CAIE B,ERXJMP		; Any better luck?
	 CAIN B,ERXCAL
	  JRST ERJFAK
;	ETF [ASCIZ "Fatal interrupt encountered"]
	pop 17,b
	pop 17,a
	movei 5,4		; No ERJMPA/ERJMP/ERCAL so take real interrupt
	jrst runint

ERJFAK:	CAIN B,ERXCAL		; See which action to hack
	 JRST ERJFK2		; Go handle ERCAL, messy.
	MOVEI A,@(A)		; ERJMP, get the jump address desired
	MOVEM A,INTPC1		; Make it the new PC
	POP 17,B
	POP 17,A
	DEBRK%
ERJFK2:	MOVEI B,@(A)		; Get jump address
	MOVEM B,INTPC1		; Make it the new PC
	POP P,B
	AOJ A,			; old PC needs to be bumped for return
	EXCH A,(17)		; Restore old A, and save PC+1 on stack
	DEBRK%

; (Actually, since ERCAL is not special except after a JSYS, it would
; still work if the ERCAL-simulation didnt bump the PC; control would
; just drop through to the next instruction on return.  Might confuse
; people looking through the stack frames, though.)
#endif /* 10X */
#endasm
}	/* End of dummyinthandlers() */

#endif	/* End of commented-out block */

#endif /* SYS_T20+SYS_10X+SYS_T10+SYS_CSI */
