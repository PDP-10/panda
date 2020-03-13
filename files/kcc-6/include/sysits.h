/* <SYSITS.H> - ITS system definitions
**
**	Includes system call interface and system-dependent
**	constant definitions.
*/

/* To make a system call:
 *
 *	SYSCALL4("name",SC_IMC(0100),&arg1,&arg2,SC_VAL(&val))
 *
 * If x is of type int:
 *
 *	SC_CTL(&x) or SC_IMC(x) specify control bits.
 *	SC_ARG(&x) or &x or SC_IMM(x) specify arguments.
 *	SC_VAL(&x) gets a return value.
 *	SC_SIX("foo") spcifies a sixbit argument.
 *
 * It will -not- work to specify SC_ERR(&x)
 *
 * This returns an int: 0 or the ITS error code.
 *
 * The SYSCALLn_LOSE macros are the same, except they return void and
 * do a .LOSE if the call fails.
 * It seems better to use this in situations where the only possible
 * errors are in the logic of the program.  It should not be used if
 * there is the slightest possibility that someone could make use of an error
 * return.  Use your judgement.
 */

/* 4/1/88 Alan - Changed the name to SYSCALL (was SYSCAL) since I was
 * changing everything else incompatibly at the same time.  Its clear
 * that this currently won't inconvenience any working code, but it may
 * well be my last chance.
 */

#define SC_ARG(a) (a)			/* 0 - argument (for completeness) */
#define SC_SIX(name) ((int *) ((_KCCtype_char6 *) name)) /* sixbit arg */
#define SC_IMM(a) (((int)a)|(1<<27))	/* 1 - immediate argument */
#define SC_VAL(a) (((int)a)|(2<<27))	/* 2 - value */
#define SC_ERR(a) (((int)a)|(3<<27))	/* 3 - error return code */
#define SC_CTL(a) (((int)a)|(4<<27))	/* 4 - control */
#define SC_IMC(a) (((int)a)|(5<<27))	/* 5 - immediate control */
#define SC_LAST(a) (((int)a)|(1<<35))	/* Turns on SETZ bit */
#define SC_LERR(a) (SC_LAST(SC_ERR(a)))		/* Common combo */

#define SYSCALL0(name) _scall(3,SC_LERR(1),\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL1(name,a) _scall(4,SC_LERR(1),a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL2(name,a,b) _scall(5,SC_LERR(1),b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL3(name,a,b,c) _scall(6,SC_LERR(1),c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL4(name,a,b,c,d) _scall(7,SC_LERR(1),d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL5(name,a,b,c,d,e) _scall(8,SC_LERR(1),e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL6(name,a,b,c,d,e,f) _scall(9,SC_LERR(1),f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL7(name,a,b,c,d,e,f,g) _scall(10,SC_LERR(1),g,f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL8(name,a,b,c,d,e,f,g,h) _scall(11,SC_LERR(1),h,g,f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))

#define SYSCALL0_LOSE(name) _scalz(3,SC_LERR(1),\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL1_LOSE(name,a) _scalz(4,SC_LERR(1),a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL2_LOSE(name,a,b) _scalz(5,SC_LERR(1),b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL3_LOSE(name,a,b,c) _scalz(6,SC_LERR(1),c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL4_LOSE(name,a,b,c,d) _scalz(7,SC_LERR(1),d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL5_LOSE(name,a,b,c,d,e) _scalz(8,SC_LERR(1),e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL6_LOSE(name,a,b,c,d,e,f) _scalz(9,SC_LERR(1),f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL7_LOSE(name,a,b,c,d,e,f,g) _scalz(10,SC_LERR(1),g,f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))
#define SYSCALL8_LOSE(name,a,b,c,d,e,f,g,h) _scalz(11,SC_LERR(1),\
			h,g,f,e,d,c,b,a,\
			*SC_SIX(name),SC_LAST(0))


/* Bytes.
 * I/O is a lot faster if the system is moving compatible size bytes.
 */

/* Creates a byte pointer of the given size that points to the first
 * byte in the word addressed by the given pointer.  This might not be
 * what you want, if you don't really know where the given pointer really
 * points.  But then, usually you really do...
 */
#define ALIGNED_BYTE_PTR(size, ptr)\
    (1 + ((char *) (((int) ((int *) (ptr))) | ((size) << 24) | 0440000000000)))

/* Creates a byte pointer of the given size that points to the bits
 * starting at the same place as those addressed by the given pointer.
 * Note that this only works for certain byte sizes because funny things
 * happen if you back up over the beginning of a word and then move forward
 * by a much smaller size.  It does work for converting between sizes 6, 7,
 * 8, 9, 18, and 36.
 */
#define BYTE_PTR_OF_SIZE(size, ptr)\
    (1 + ((char *) ((((int) ((ptr) - 1)) & 0770077777777) | ((size) << 24))))


/* Handy ITS constants.
 */

/* ITS_BIT(2,3) is bit 2.3 */
#define ITS_BIT(n,m) (1 << (((n) * 9) + (m) - 10))

#define FILENAME_SIZE 200		/* Enough for most purposes... */

/* Device types as determined by _dvtype() from .STATUS word: */
#define _DVDSK 0		/* non-blocking (default) */
#define _DVTTY 1		/* TTY */
#define _DVUSR 2		/* USR */

/* Open */

#define _DOOUT 1
#define _DOBLK 2
#define _DOIMG 4

#define _UAI 0
#define _UAO 1
#define _BAI 2
#define _BAO 3
#define _UII 4
#define _UIO 5
#define _BII 6
#define _BIO 7

/* Error codes */

#define _ENSDV	001	/* NO SUCH DEVICE */
#define _ENSIO	002	/* WRONG DIRECTION */
#define _ETMTR	003	/* TOO MANY TRANSLATIONS */
#define _ENSFL	004	/* FILE NOT FOUND */
#define _EFLDR	005	/* DIRECTORY FULL */
#define _EFLDV	006	/* DEVICE FULL */
#define _ENRDV	007	/* DEVICE NOT READY */
#define _ENADV	010	/* DEVICE NOT AVAILABLE */
#define _EBDFN	011	/* ILLEGAL FILE NAME */
#define _ENSMD	012	/* MODE NOT AVAILABLE */
#define _EEXFL	013	/* FILE ALREADY EXISTS */
#define _EBDCH	014	/* BAD CHANNEL NUMBER */
#define _ETMRG	015	/* TOO MANY ARGUMENTS */
#define _ENAPK	016	/* PACK NOT MOUNTED */
#define _ENADR	017	/* DIRECTORY NOT AVAIL */
#define _ENSDR	020	/* NON-EXISTENT DIRECTORY */
#define _ELCDV	021	/* LOCAL DEVICE ONLY */
#define _ESCO	022	/* SELF-CONTRADICTORY OPEN */
#define _ENAFL	023	/* FILE LOCKED */
#define _ETMDR	024	/* M.F.D. FULL */
#define _EMCHN	025	/* DEVICE NOT ASSIGNABLE TO THIS PROCESSOR */
#define _ERODV	026	/* DEVICE WRITE-LOCKED */
#define _ETMLK	027	/* LINK DEPTH EXCEEDED */
#define _ETFRG	030	/* TOO FEW ARGUMENTS */
#define _EROJB	031	/* CAN'T MODIFY JOB */
#define _EROPG	032	/* CAN'T GET THAT ACCESS TO PAGE */
#define _EBDRG	033	/* MEANINGLESS ARGS */
#define _EBDDV	034	/* WRONG TYPE DEVICE */
#define _ENSJB	035	/* NO SUCH JOB */
#define _EBOJ	036	/* VALID CLEAR OR STORED SET */
#define _ENACR	037	/* NO CORE AVAILABLE */
#define _ETOP	040	/* NOT TOP LEVEL */
#define _ENAPP	041	/* OTHER END OF PIPELINE GONE OR NOT OPEN */
#define _ENAJB	042	/* JOB GONE OR GOING AWAY */
#define _ENSCL	043	/* ILLEGAL SYSTEM CALL NAME */
#define _ENSCH	044	/* CHANNEL NOT OPEN */
#define _ENRBF	045	/* INPUT BUFFER EMPTY OR OUTPUT BUFFER FULL */
#define _EBDFL	046	/* UNRECOGNIZABLE FILE */
#define _EBDLK	047	/* LINK TO NON-EXISTENT FILE */

/* CORBLK */

#define _CBWRT	0400000		/* TRY FOR WRITE ACCESS, OK IF CAN'T GET IT */
#define _CBRED	0200000		/* TRY FOR READ ACCESS, OK IF CAN'T GET IT */
#define _CBNDW	0100000		/* NEED WRITE ACCESS, FAIL IF CAN'T GET IT */
#define _CBPUB	0040000		/* MAKE PAGE PUBLIC, REQUIRES WRITE ACCESS */
#define _CBPRV	0020000		/* MAKE PAGE PRIVATE, REQUIRES WRITE ACCESS */
#define _CBNDR	0010000		/* NEED READ ACCESS, FAIL IF CAN'T GET IT */
#define _CBCPY	0004000		/* MAKE A COPY (DISK FILES ONLY) */
#define _CBLOK	0002000		/* LOCK PAGE IN CORE.  */
#define _CBULK	0001000		/* UNLOCK PAGE (ALLOW SWAP-OUT) */
#define _CBSLO	0000400		/* MAY ONLY RESIDE IN SLOWEST MEMORY */
#define _CBUSL	0000200		/* ALLOWS USE OF ANY MEMORY.  */

/* Job specs */

#define _JSELF	0777777		/* SELF (ALL <JOB> SPECS) */
#define _JSTVB	0777776		/* 11TV BUFFER (CORBLK) */
#define _JSNUL	0777775		/* NULL JOB (KLPERF) */
#define _JSALL	0777774		/* ALL JOBS (KLPERF) */
#define _JSNEW	0777773		/* FRESH PAGE (CORBLK) */
#define _JSABS	0777772		/* ABSOLUTE CORE (CORBLK) */
#define _JSNUM	0400000		/* THIS + JOB # => THAT JOB (ALL <JOB> */
				/* SPECS) */
#define _JSSIX	0400376		/* PDP6 IS USER NUMBER 376 */
#define _JSSUP	0400377		/* SUPERIOR (ALL <JOB> SPECS) */
