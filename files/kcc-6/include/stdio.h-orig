/* <STDIO.H> - Standard I/O definitions
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ian Macky, SRI International 1986
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
*/

#ifndef _STDIO_INCLUDED
#define _STDIO_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

/* Implementation-dependent constants and parameters */

#include <c-env.h>	/* For OS-dependent numbers */

#ifndef _SIO_NPBC	/* # of push-back characters that ungetc can handle */
#define _SIO_NPBC 2	/* 2 required in order for scanf to meet dpANS reqs */
#endif

#if SYS_ITS+SYS_T10+SYS_CSI+SYS_WTS
#define FOPEN_MAX	16	/* Max # files guaranteed can fopen at once */
#define FILENAME_MAX	10*7	/* Max size of filename string */
#define TMP_MAX		0777	/* # guaranteed unique tmpnam() filenames */
#define L_tmpnam	20	/* Size needed for tmpnam() result */
#else
#define FOPEN_MAX	32
#define FILENAME_MAX	(40*5)
#define TMP_MAX		0777777
#define L_tmpnam	FILENAME_MAX
#endif

/****************** Type Definitions ****************/

#ifndef _SIZE_T_DEFINED		/* Avoid conflict with other headers */
#define _SIZE_T_DEFINED
typedef unsigned size_t;	/* Type of sizeof() (must be unsigned, ugh) */
#endif

typedef struct _siostream FILE;	/* Structure declared farther on */

typedef long fpos_t;		/* For holding I/O pointer info */

/****************** Macro Definitions ****************/

#define NULL		0	/* Benign redefinition */
#define EOF		(-1)	/* EOF value */

/* Values for 3rd arg to setvbuf() */
#define _IOFBF		0	/* full buffering */
#define _IOLBF		1	/* line buffering */
#define _IONBF		2	/* no buffering */

/* Values for 3rd arg to fseek() */
#define SEEK_SET	0	/* starting point is start-of-file */
#define SEEK_CUR	1	/* ...current position */
#define SEEK_END	2	/* ...or end-of-file */

/* Standard I/O streams */
#define stdin  (&_sios[0])
#define stdout (&_sios[1])
#define stderr (&_sios[2])

/* Sizes and parameters */
#define BUFSIZ		512	/* Buffer size in chars (may change later) */
/* FOPEN_MAX	*/		/* Max guaranteed # of files open */
/* FILENAME_MAX	*/		/* Max size of filename string */
/* L_tmpnam	*/		/* Size needed for tmpnam() string */
/* TMP_MAX	*/		/* Min # of unique filenames from tmpnam() */

/* KCC-supported extensions (as per H&S) */
#define L_ctermid	FILENAME_MAX	/* Terminal id could be big filespec */
#define L_cuserid	40		/* Max size of username */

/*
 *	Declarations
 */

extern FILE _sios[];		/* FILE structure array */

#if __STDC__
/* Operations on files */
int remove(const char*);			/* filename */
int rename(const char*, const char*);		/* old, new */
FILE *tmpfile(void);
char *tmpnam(char*);			/* s */

/* File access */
int fclose(FILE*);
int fflush(FILE*);
FILE *fopen(const char*, const char*);		/* filename, mode */
FILE *freopen(const char*, const char*, FILE*);	/* filename, mode, stream */
void setbuf(FILE*, char*);			/* stream, buf */
int setvbuf(FILE*, char*, int, size_t);		/* stream, buf, mode, size */

/* Formatted I/O */
int fprintf(FILE*, const char*, ...);		/* stream, format, ... */
int fscanf(FILE*, const char*, ...);		/* stream, format, ... */
int printf(const char*, ...);			/* format, ... */
int scanf(const char*, ...);			/* format, ... */
int sprintf(char *, const char*, ...);		/* s, format, ... */
int sscanf(const char*, const char*, ...);	/* s, format, ... */
int vfprintf(FILE*, const char*, int*);		/* stream, format, va_list */
int vprintf(const char *, int*);		/* format, va_list */
int vsprintf(char*, const char*, int*);		/* s, format, va_list */

/* Character I/O */
int fgetc(FILE*);
char *fgets(char*, int, FILE*);
int fputc(int, FILE*);
int fputs(const char*, FILE*);
int getc(FILE*);
int getchar(void);
char *gets(char*);
int putc(int, FILE*);
int putchar(int);
int puts(const char*);
int ungetc(int, FILE*);

/* Direct I/O */
size_t fread(void*, size_t, size_t, FILE*);	/* ptr, size, nmemb, stream */
size_t fwrite(const void*, size_t, size_t, FILE*); /* ptr, size, nmemb, strm */

/* File positioning */
int fgetpos(FILE*, fpos_t*);		/* stream, pos */
int fseek(FILE*, long, int);		/* stream, offset, whence */
int fsetpos(FILE*, const fpos_t*);	/* stream, pos */
long ftell(FILE*);
void rewind(FILE*);

/* Error Handling */
void clearerr(FILE *);
int feof(FILE*);
int ferror(FILE*);
void perror(const char*);

#else

FILE *fopen(), *freopen();
void setbuf();
int fclose(), fflush(), setvbuf(),
	fprintf(), fscanf(), printf(), scanf(), sprintf(), sscanf(),
	fgetc(), fputc(), fputs(), getc(), getchar(),
	putc(), putchar(), puts(), ungetc();
char *fgets(), *gets();
size_t fread(), fwrite();
int fseek();
long ftell();
void rewind();
void clearerr(), perror();
int feof(), ferror();

FILE *tmpfile();			/* ANSI stuff */
char *tmpnam();
int remove(), rename(), vfprintf(), vprintf(), vsprintf(),
	fgetpos(), fsetpos();
#endif


/* Extensions from BSD and SYSV */
#define setbuffer _setbuf	/* Disambiguate external name */
#if __STDC__
FILE *fdopen(int, const char*);			/* fd, mode */
FILE *sopen(const char*, const char*, size_t);	/* ptr, mode, size */
void setbuffer(FILE*, char*, size_t);		/* stream, buf, size */
void setlinebuf(FILE*);
char *mktemp(char*);
int getw(FILE*);
int putw(int, FILE*);
int fileno(FILE*);
#else
FILE *fdopen(), *sopen();
void setbuffer(), setlinebuf();
char *mktemp();
int getw(), putw(), fileno();
#endif

/* KCC-supported extensions (as per H&S) */
extern char *ctermid();	/* Get terminal filespec */
extern char *cuserid();	/* Get user ID string */


/* Internal STDIO declarations, not for user consumption.
** Probably move these out to a "sio.h" file someday.
*/
extern FILE *_FILE_head, *_makeFILE();
extern int _filbuf(), _readable(), _writeable(), _prime(), _sioflags();
extern void _cleanup(), _freeFILE(), _setFILE();

/*
 *	Standard I/O Stream structure
 */

struct _siostream {
    int siocheck;		/* 0 if inactive, else magic values */
    int siocnt;			/* # chars left in buffer */
    char *siocp;		/* Char pointer into buffer */
    char *siopbuf;		/* Pointer to start of buffer */
    int siolbuf;		/* Length of buffer */
    int sioflgs;		/* Various flags */
    int siofd;			/* FD for stream, if any */
    long siofdoff;		/* FD's offset into file b4 last r/w syscall */
    int sioocnt;		/* original buffer count after filbuf */
    int sioerr;			/* If nonzero, error # for stream */
    int sio2cnt;		/* Saved siocnt and */
    char *sio2cp;		/* siocp (during pushback) */
    char siopbc[_SIO_NPBC];	/* Pushed-back characters */
    FILE *sionFILE;		/* pointer to next and... */
    FILE *siopFILE;		/* ...previous FILE blocks in chain */
    int siospare[4];		/* spare words for hassleless expansion */
};

/*
 *	sio2cnt, sio2cp are used only for input streams (for push-back);
 *	we're reusing the sio2cnt word for output streams, to keep an
 *	alternate buffer-count.  for linebuffering, the primary count is
 *	kept <= 0 so that fputc is always called; fputc knows about line-
 *	buffering, and uses the alternate count word, siolcnt.
 */

#define siolcnt	sio2cnt		/* Flush this def eventually */

/*
 *	Internal flags - contents of sioflgs
 *	Some of these are used while parsing the flag chars for
 *	fopen/freopen/sopen.  These are indicated by '<char>' in the comment.
 */

#define _SIOF_READ	01		/* 'r' stream is open for reading */
#define _SIOF_WRITE	02		/* 'w' ...writing */
#define _SIOF_APPEND	04		/* 'a' ...appending */
#define _SIOF_UPDATE	010		/* '+' ...updating */
#define _SIOF_MODIFIED	020		/* buffer has been modified */
#define _SIOF_BINARY	040		/* 'b' binary data stream (not text) */
#define _SIOF_PBC	0100		/* Using push-back count and pointer */
#define _SIOF_EOF	0200		/* Stream has hit EOF */
#define _SIOF_STR	0400		/* Stream is a string, siofd unused */
#define _SIOF_BUF	01000		/* Stream is buffered */
#define _SIOF_LASTBUF	02000		/* Current buffer is last one */
#define _SIOF_LINEBUF	04000		/* Flush output buffer on EOL */
#define _SIOF_AUTOBUF	010000		/* Dynamically allocate buffer, pls */
#define _SIOF_GROWBUF	020000		/* String-buf automatically expands */
#define _SIOF_DYNAMFILE	040000		/* FILE block was stdio-allocated */
#define _SIOF_DYNAMBUF	0100000		/* I/O buffer was stdio-allocated */
#define _SIOF_CONVERTED	0200000		/* 'C' CRLF-EOL conversion forced */
#define _SIOF_UNCONVERTED 0400000	/* 'C-' forced NO CRLF conversion */
#define _SIOF_THAWED	01000000	/* 'T' Thawed access */
#define _SIOF_IMAGE	02000000	/* 'I' forced image mode open (ITS) */
#define _SIOF_NO_IMAGE	04000000	/* 'I-' forced ascii mode open (ITS) */

/*
 *	a valid FILE block returned by _makeFILE() has its siocheck word
 *	set to _SIOF_FILE.  after the stream has been opened, the check
 *	word is changed to _SIOF_OPEN.
 */
#define _SIOF_OPEN	(((-'O' * 'P' * 'E' * 'N') << 16) + 'S' + 'I' + 'O')
#define _SIOF_FILE	(((-'F' * 'I' * 'L' * 'E') << 16) + 'S' + 'I' + 'O')

/* STDIO macros.
**	All of these must also exist as real functions.
*/
#define clearerr(f)	(void)((f)->sioflgs &= ~_SIOF_EOF, (f)->sioerr = 0)
#define feof(f)		((f)->sioflgs & _SIOF_EOF)
#define ferror(f)	((f)->sioerr)
#define getc(f)		((--(f)->siocnt >= 0) ? (*++(f)->siocp) : fgetc(f))
#define getchar()	getc(stdin)
#define putc(c, f) \
		(--(f)->siocnt >= 0 ? (*++(f)->siocp = (c)) : fputc((c), (f)))
#define putchar(c)	putc((c), stdout)

/* Extensions - BSD and H&S */
#define fileno(f)	((f)->siofd)	/* Find system FD for stream */

#if 1	/* Stuff for new ftell/fseek scheme */
	/* Note new STDIO code is only compiled if _SIOP_BITS is defined. */
#define _SIOP_MAXBITS 10		/* Use constant size for now */

#ifdef _SIOP_MAXBITS
#define _SIOP_BITS(f)	_SIOP_MAXBITS		/* # bits for buffer size */
#define _SIOP_MASK(f) ((1<<_SIOP_MAXBITS)-1)	/* Mask for buffer size */
#else
#define _SIOP_BITS(f)	(f)->siopbits		/* # bits for buffer size */
#define _SIOP_MASK(f)	(f)->siopmask		/* Mask for buffer size */
#endif

#else	/* Old fseek/ftell scheme, uses _bufpos() routine from USYS.
	** In order for _bufpos() to work, the UIO buffer must be at least
	** twice the size of the STDIO buffer.  Rather than muck with the UIO
	** buffer size (which is set to something OS-efficient), we just change
	** the size of the STDIO buffer.
	*/
#undef BUFSIZ			/* Flush previous def of STDIO buffer size */
#include <sys/usysio.h>		/* Find UIO buffer size.  Lots of defs, ugh. */
#define BUFSIZ (UIO_BUFSIZ/2)	/* Define new size */

#endif

#endif /* ifndef _STDIO_INCLUDED */
