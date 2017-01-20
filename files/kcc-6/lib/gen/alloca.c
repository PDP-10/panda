#include <stdio.h>
#include <stdlib.h>
#include <alloca.h>

#ifdef __STDC__
typedef void	*pointer;		/* generic pointer type */
#else
typedef char	*pointer;		/* generic pointer type */
#endif

#define	NULL	0			/* null pointer constant */

/*
	An "alloca header" is used to:
	(a) chain together all alloca()ed blocks;
	(b) keep track of stack depth.

	It is very important that sizeof(header) agree with malloc()
	alignment chunk size.  The following default should work okay.
*/

#define	ALIGN_SIZE	sizeof(int)

typedef union hdr
{
  char	align[ALIGN_SIZE];	/* to force sizeof(header) */
  struct
    {
      union hdr *next;		/* for chaining headers */
      char *deep;		/* for stack depth measure */
    } h;
} header;

/*
	alloca( size ) returns a pointer to at least `size' bytes of
	storage which will be automatically reclaimed upon exit from
	the procedure that called alloca().  Originally, this space
	was supposed to be taken from the current stack frame of the
	caller, but that method cannot be made to work for some
	implementations of C, for example under Gould's UTX/32.
*/

static header *last_alloca_header = NULL; /* -> last alloca header */

pointer
alloca (size)			/* returns pointer to storage */
     unsigned size;		/* # bytes to allocate */
{
  auto char probe;		/* probes stack depth: */
  register char	*depth = &probe;

				/* Reclaim garbage, defined as all */
				/* alloca()ed storage that was */
				/* allocated from deeper in the stack */
				/* than currently. */

  {
    register header *hp;	/* traverses linked list */

    for (hp = last_alloca_header; hp != NULL;)
      if (hp->h.deep > depth)
	{
	  register header *np = hp->h.next;

	  free ((pointer) hp);	/* collect garbage */

	  hp = np;		/* -> next header */
	}
      else
	break;			/* rest are not deeper */

    last_alloca_header = hp;	/* -> last valid storage */
  }

  if (size == 0)
    return NULL;		/* no allocation required */

  /* Allocate combined header + user data storage. */

  {
    register pointer new = (pointer) malloc (sizeof (header) + size);
    /* address of header */
    if (new == NULL) {
      perror("Failed to allocate memory");
      exit(2);
    }

    ((header *)new)->h.next = last_alloca_header;
    ((header *)new)->h.deep = depth;

    last_alloca_header = (header *)new;

    /* User storage begins just after header. */

    return (pointer)((char *)new + sizeof(header));
  }
}
