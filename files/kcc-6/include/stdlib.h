/* <STDLIB.H> - General Utility decls and defs (draft proposed ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
*/

#ifndef _STDLIB_INCLUDED
#define _STDLIB_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

/****************** Type Definitions ****************/

#ifndef _WCHAR_T_DEFINED	/* Avoid conflict with other headers */
#define _WCHAR_T_DEFINED
typedef char wchar_t;		/* Type of "wide" chars */
#endif

#ifndef _SIZE_T_DEFINED		/* Avoid conflict with other headers */
#define _SIZE_T_DEFINED
typedef unsigned size_t;	/* Type of sizeof() (must be unsigned, ugh) */
#endif

typedef struct { int quot; int rem; } div_t;
typedef struct { long quot; long rem; } ldiv_t;


/****************** Macro Definitions ****************/

#define NULL 0			/* Benign redefinition */

#define EXIT_FAILURE 1		/* Args to exit() */
#define EXIT_SUCCESS 0

#define RAND_MAX 32767		/* 2^15-1 Max value from rand() */

#define MB_CUR_MAX 1		/* Current max size of multibyte char */

#if __STDC__			/* ANSI prototype decls */

/* String Conversion functions */
double	atof(const char *);
int	atoi(const char *);
long	atol(const char *);
double	strtod(const char *, char **);
long	strtol(const char *, char **, int);
unsigned long strtoul(const char *, char **, int);

/* Pseudo-random sequence generation functions */
int rand(void);
void srand(unsigned int);

/* For BSD compatibility */
long random(void);
int srandom(int);
char *setstate(char *);
char *initstate(unsigned, char *, int);

/* Memory management functions */
void *calloc(size_t, size_t);		/* (nmemb, size) */
void free(void *);			/* (ptr) */
void *malloc(size_t);			/* (size) */
void *realloc(void *, size_t);		/* (ptr, size) */

/* Environment functions */
void abort(void);
int atexit(void (*)(void));		/* (func) */
void exit(int);				/* (status) */
char *getenv(const char *);		/* (name) */
int system(const char *);		/* (string) */

/* Searching and Sorting functions */
void *bsearch(const void *, const void *,	/* (key, base, nmemb, size */
	size_t, size_t,				/*	compar) */
	int (*)(const void *, const void *));
void qsort(void *, size_t, size_t,	/* (base,nmemb,size,compar) */
	int (*)(const void *, const void *));

/* Integer Arithmetic functions */
int abs(int);
div_t div(int, int);			/* (numer, denom) */
long labs(long);
ldiv_t ldiv(long, long);		/* (numer, denom) */

/* Multibyte Character functions */
int mblen(const char *, size_t);	/* (s, n) */
int mbtowc(wchar_t *, const char *, size_t);	/* (pwc, s, n) */
int wctomb(char *, wchar_t);		/* (s, wchar) */

/* Multibyte String functions */
size_t mbstowcs(wchar_t *, const char *, size_t);	/* (pwcs, s, n) */
size_t wcstombs(char *, const wchar_t *, size_t);	/* (s, pwcs, n) */

#ifndef _ANSI_SOURCE
void     cfree (void *);
int      putenv (const char *);
int      setenv (const char *, const char *, int);
#endif /* not ANSI */

/* KCC Internal implementation declarations */
extern int _n_exit_func;		/* # of registered exit functions */
extern void (*_exit_func[])(void);	/* registered exit functions ptrs */

/* Public getopt */
extern	 char *optarg;			/* getopt(3) external variables */
extern	 int optind;
extern	 int opterr;
int	 getopt (int, char * const *, const char *);

#else					/* Next page is old-style stuff */

/*
 *	 Old-style declarations
 */

/* Conversions */
double atof();
int atoi();
long atol();
double strtod();
long strtol();
unsigned long strtoul();

/* Pseudo-random functions */
int rand();
void srand();
char *setstate();
char *initstate();

/* Memory management */
char *calloc();
void free();
char *malloc();
char *realloc();
void cfree();					/* CARM and BSD function */
char *clalloc(), *mlalloc(), *relalloc();	/* CARM functions */

/* Environment */
void abort();
int atexit();
void exit();
char *getenv();
int system();

/* Searching and sorting */
char *bsearch();
void qsort();

/* Arith functions */
int abs();
div_t div();
long labs();
ldiv_t ldiv();

int mblen(), mbtowc(), wctomb();	/* Multibyte Character functions */
size_t mbstowcs(), wcstombs();		/* Multibyte String functions */

#ifndef _ANSI_SOURCE
void     cfree ();
int      putenv ();
int      setenv ();
#endif /* not ANSI */

extern int _n_exit_func;		/* # of registered exit functions */
extern void (*_exit_func[])();		/* registered exit functions ptrs */

/* Public getopt */
extern	 char *optarg;			/* getopt(3) external variables */
extern	 int optind;
extern	 int opterr;
int	 getopt ();

#endif

#endif /* ifndef _STDLIB_INCLUDED */
