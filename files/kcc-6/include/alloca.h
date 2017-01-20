#ifndef _ALLOCA_H_
#define _ALLOCA_H_

#ifdef __STDC__
void *alloca (unsigned size);		/* returns pointer to storage */
#else
char *alloca ();
#endif

#endif /* _ALLOCA_H_ */
