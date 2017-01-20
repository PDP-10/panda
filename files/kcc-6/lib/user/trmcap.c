/* Work-alike for termcap, plus extra features.
   Copyright (C) 1985, 1986 Free Software Foundation, Inc.

		       NO WARRANTY

  BECAUSE THIS PROGRAM IS LICENSED FREE OF CHARGE, WE PROVIDE ABSOLUTELY
NO WARRANTY, TO THE EXTENT PERMITTED BY APPLICABLE STATE LAW.  EXCEPT
WHEN OTHERWISE STATED IN WRITING, FREE SOFTWARE FOUNDATION, INC,
RICHARD M. STALLMAN AND/OR OTHER PARTIES PROVIDE THIS PROGRAM "AS IS"
WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY
AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE PROGRAM PROVE
DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR
CORRECTION.

 IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW WILL RICHARD M.
STALLMAN, THE FREE SOFTWARE FOUNDATION, INC., AND/OR ANY OTHER PARTY
WHO MAY MODIFY AND REDISTRIBUTE THIS PROGRAM AS PERMITTED BELOW, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY LOST PROFITS, LOST MONIES, OR
OTHER SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR
DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY THIRD PARTIES OR
A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS) THIS
PROGRAM, EVEN IF YOU HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES, OR FOR ANY CLAIM BY ANY OTHER PARTY.

		GENERAL PUBLIC LICENSE TO COPY

  1. You may copy and distribute verbatim copies of this source file
as you receive it, in any medium, provided that you conspicuously and
appropriately publish on each copy a valid copyright notice "Copyright
(C) 1986 Free Software Foundation, Inc."; and include following the
copyright notice a verbatim copy of the above disclaimer of warranty
and of this License.  You may charge a distribution fee for the
physical act of transferring a copy.

  2. You may modify your copy or copies of this source file or
any portion of it, and copy and distribute such modifications under
the terms of Paragraph 1 above, provided that you also do the following:

    a) cause the modified files to carry prominent notices stating
    that you changed the files and the date of any change; and

    b) cause the whole of any work that you distribute or publish,
    that in whole or in part contains or is a derivative of this
    program or any part thereof, to be licensed at no charge to all
    third parties on terms identical to those contained in this
    License Agreement (except that you may choose to grant more
    extensive warranty protection to third parties, at your option).

    c) You may charge a distribution fee for the physical act of
    transferring a copy, and you may at your option offer warranty
    protection in exchange for a fee.

  3. You may copy and distribute this program or any portion of it in
compiled, executable or object code form under the terms of Paragraphs
1 and 2 above provided that you do the following:

    a) cause each such copy to be accompanied by the
    corresponding machine-readable source code, which must
    be distributed under the terms of Paragraphs 1 and 2 above; or,

    b) cause each such copy to be accompanied by a
    written offer, with no time limit, to give any third party
    free (except for a nominal shipping charge) a machine readable
    copy of the corresponding source code, to be distributed
    under the terms of Paragraphs 1 and 2 above; or,

    c) in the case of a recipient of this program in compiled, executable
    or object code form (without the corresponding source code) you
    shall cause copies you distribute to be accompanied by a copy
    of the written offer of source code which you received along
    with the copy you received.

  4. You may not copy, sublicense, distribute or transfer this program
except as expressly provided under this License Agreement.  Any attempt
otherwise to copy, sublicense, distribute or transfer this program is void and
your rights to use the program under this License agreement shall be
automatically terminated.  However, parties who have received computer
software programs from you with this License Agreement will not have
their licenses terminated so long as such parties remain in full compliance.

  5. If you wish to incorporate parts of this program into other free
programs whose distribution conditions are different, write to the Free
Software Foundation at 1000 Mass Ave, Cambridge, MA 02138.  We have not yet
worked out a simple rule that can be stated here, but we will often permit
this.  We will be guided by the two goals of preserving the free status of
all derivatives of our free software and of promoting the sharing and reuse of
software.


In other words, you are welcome to use, share and improve this program.
You are forbidden to forbid anyone else to use, share and improve
what you give them.   Help stamp out software-hoarding!  */

/* BUFSIZE is the initial size allocated for the buffer
   for reading the termcap file.
   It is not a limit.
   Make it large normally for speed.
   Make it variable when debugging, so can exercise
   increasing the space dynamically.  */

#include <stdio.h>
#include <trmcap.h>
#include <string.h>
#include <strung.h>		/* case-insensitive string operations */

#ifndef __STDC__
#define __STDC__ 0
#endif

#if __STDC__
#include <stdlib.h>
#else
extern int exit();
extern char *malloc(), *realloc();
extern void free();
#endif
extern int write();
extern void bcopy();

#ifdef emacs
#include <config.h>
#endif

#ifndef BUFSIZE
#ifdef DEBUG
#define BUFSIZE bufsize

int bufsize = 128;
#else
#define BUFSIZE 2048
#endif
#endif

/* External variables that user should provide */
extern short ospeed;
extern char PC;
extern char *BC;
extern char *UP;

#ifndef emacs
static
memory_out ()
{
  write (2, "Virtual memory exhausted\n", 25);
  exit (1);
}

static char *
xmalloc (size)
     int size;
{
  register char *p;

  p = malloc(size);
  if (p == NULL)
    memory_out ();
  return p;
}

static char *
xrealloc (ptr, size)
     char *ptr;
     int size;
{
  register char *p;

  p = realloc(ptr, size);
  if (p == NULL)
    memory_out ();
  return p;
}
#endif /* not emacs */

/* Looking up capabilities in the entry already found */

/* The pointer to the data made by tgetent is left here
   for tgetnum, tgetflag and tgetstr to find.  */

static char *term_entry;

#define tgetst1	tgtst1		/* kowtow to ancient 6-character limits */

static char *tgetst1 ();

/* This is the main subroutine that is used to search
   an entry for a particular capability */

static char *
find_capability (bp, cap)
     register char *bp, *cap;
{
  for (; *bp; bp++)
    if (bp[0] == ':'
	&& bp[1] == cap[0]
	&& bp[2] == cap[1])
      return &bp[4];
  return 0;
}

int
tgetnum (cap)
     char *cap;
{
  register char *ptr = find_capability (term_entry, cap);
  if (!ptr || ptr[-1] != '#')
    return -1;
  return atoi (ptr);
}

int
tgetflag (cap)
     char *cap;
{
  register char *ptr = find_capability (term_entry, cap);
  return 0 != ptr && ptr[-1] == ':';
}

/* Look up a string-valued capability `cap'.
   If `area' is nonzero, it points to a pointer to a block in which
   to store the string.  That pointer is advanced over the space used.
   If `area' is zero, space is allocated with `malloc'.  */

char *
tgetstr (cap, area)
     char *cap;
     char **area;
{
  register char *ptr = find_capability (term_entry, cap);
  if (!ptr || (ptr[-1] != '=' && ptr[-1] != '~'))
    return 0;
  return tgetst1 (ptr, area);
}

/* Table, indexed by a character in range 0100 to 0140 with 0100 subtracted,
   gives meaning of character following \, or a space if no special meaning.
   Eight characters per line within the string.  */

static char esctab[]
  = " \007\010  \033\014 \
      \012 \
  \015 \011 \013 \
        ";

/* Given a pointer to a string value inside a termcap entry (`ptr'),
   copy the value and process \ and ^ abbreviations.
   Copy into block that *area points to,
   or to newly allocated storage if area is 0.  */

static char *
tgetst1 (ptr, area)
     char *ptr;
     char **area;
{
  register char *p, *r;
  register int c;
  register int size;
  char *ret;
  register int c1;

  if (!ptr)
    return 0;

  /* `ret' gets address of where to store the string */
  if (!area)
    {
      /* Compute size of block needed (may overestimate) */
      p = ptr;
      while ((c = *p++) && c != ':');
      ret = xmalloc (p - ptr + 1);
    }
  else
    ret = *area;

  /* Copy the string value, stopping at null or colon.  */
  /* Also process ^ and \ abbreviations.  */
  p = ptr;
  r = ret;
  while ((c = *p++) && c != ':')
    {
      if (c == '^')
	c = *p++ & 037;
      else if (c == '\\')
	{
	  c = *p++;
	  if (c >= '0' && c <= '7')
	    {
	      c -= '0';
	      size = 0;

	      while (++size < 3 && (c1 = *p) >= '0' && c1 <= '7')
		{
		  c *= 8;
		  c += c1 - '0';
		  p++;
		}
	    }
	  else if (c >= 0100 && c < 0200)
	    {
	      c1 = esctab[(c & ~040) - 0100];
	      if (c1 != ' ')
		c = c1;
	    }
	}
      *r++ = c;
    }
  *r = 0;
  /* Update *area */
  if (area)
    *area = r + 1;
  return ret;
}

/* Outputting a string with padding */


/* Actual baud rate if positive;
   - baud rate / 100 if negative.  */

static short speeds[] =
  {
#ifdef VMS
    0, 50, 75, 110, 134, 150, -3, -6, -12, -18,
    -20, -24, -36, -48, -72, -96, -192
#else /* not VMS */
    0, 50, 75, 110, 135, 150, -2, -3, -6, -12,
    -18, -24, -48, -96, -192, -384
#endif /* not VMS */
  };

void
tputs (string, nlines, outfun)
     register char *string;
     int nlines;
     register int (*outfun) ();
{
  register int padcount = 0;

  if (string == (char *) 0)
    return;
  while (*string >= '0' && *string <= '9')
    {
      padcount += *string++ - '0';
      padcount *= 10;
    }
  if (*string == '.')
    {
      string++;
      padcount += *string++ - '0';
    }
  if (*string == '*')
    {
      string++;
      padcount *= nlines;
    }
  while (*string)
    (*outfun) (*string++);

  /* padcount is now in units of tenths of msec.  */
  padcount *= speeds[ospeed];
  padcount += 500;
  padcount /= 1000;
  if (speeds[ospeed] < 0)
    padcount = -padcount;
  else
    {
      padcount += 50;
      padcount /= 100;
    }

  while (padcount-- > 0)
    (*outfun) (PC);
}

/* Finding the termcap entry in the termcap data base */

struct buffer
  {
    char *beg;
    int size;
    char *ptr;
    int ateof;
    int full;
  };

/* Forward declarations of static functions */

static int scan_file ();
static char *gobble_line ();
static int compare_contin ();
static int name_match ();

#ifdef VMS

#include <rmsdef.h>
#include <fab.h>
#include <nam.h>

static int
legal_filename_p (fn)
     char *fn;
{
  struct FAB fab = cc$rms_fab;
  struct NAM nam = cc$rms_nam;
  char esa[NAM$C_MAXRSS];

  fab.fab$l_fna = fn;
  fab.fab$b_fns = strlen(fn);
  fab.fab$l_nam = &nam;
  fab.fab$l_fop = FAB$M_NAM;

  nam.nam$l_esa = esa;
  nam.nam$b_ess = sizeof esa;

  return SYS$PARSE(&fab, 0, 0) == RMS$_NORMAL;
}

#endif /* VMS */

/* Find the termcap entry data for terminal type `name'
   and store it in the block that `bp' points to.
   Record its address for future use.
	Returns 1 if all goes well,
		0 if the entry could not be found,
		-1 if the termcap file could not be opened.

NON-STANDARD USE:
   If `bp' is zero, space is dynamically allocated, and a successful return
   gives the address of the buffer, which will be a (char *) converted to
   an (int).
*/

int
tgetent (bp, name)
     char *bp, *name;
{
  register char *termcap;	/* pointer to users TERMCAP entry, or NULL */
  int filep;			/* is it a filespec?  true if so. */
  char *indirect = NULL;	/* Terminal type in :tc= in TERMCAP value.  */
  char *tcenv;			/* TERMCAP value, if it contais :tc=.  */
  register char *p;		/* pointer into buf pointed to by bp */
  register char *temp;		/* temporary pointer to new expanded buf */
  register FILE *f;		/* stream for database file. */
  char *term;			/* pointer to terminal name */
  struct buffer buf;		/* buffer for slurping in db file */
  int malloc_size = 0;		/* if non-0, size of buf we alloced for user */
  register int c;		/* char for copying data around */
  char *latest_entry;		/* pointer to latest of db entries */
  extern char *getenv();

  termcap = getenv("TERMCAP");		/* get user's TERMCAP entry */
  if (termcap && *termcap == 0) termcap = NULL;	/* make sure it's there */

#ifdef VMS					/* check if its a filespec */
  filep = termcap && legal_filename_p(termcap);
#else
  filep = termcap && (*termcap == '/');
#endif /* VMS */

  /* If tem is non-null and starts with / (in the un*x case, that is),
     it is a file name to use instead of /etc/termcap.
     If it is non-null and does not start with /,
     it is the entry itself, but only if
     the name the caller requested matches the TERM variable.  */

  if (termcap && !filep && !strCMP(name, getenv ("TERM"))) {
      puts((indirect) ? "indirect" : "not indirect");
      if (!indirect) {			/* not indirect.   if no user area, */
	  if (!bp) bp = termcap;	/* then point to TERMCAP entry, else */
	  else strcpy(bp, termcap);	/* copy termcap entry to user buf. */
	  return (int) (term_entry = bp);	/* all done, return ptr */
      } else {				/* yes, indirection, so we'll have */
	  tcenv = termcap;		/* to look up what it points to in */
 	  termcap = NULL;		/* the termcap file. */
      }
  }

/* the termcap database's filename come from either the TERMCAP entry (if
   it starts with / (on un*x) or however it works for v*x), or as the
   standard place, _TERMCAPFILE, which is defined in trmcap.h */
					
  f = fopen((!termcap) ? _TERMCAPFILE : termcap, "r");
  if (f == NULL)
    return -1;

  buf.size = BUFSIZE;				/* initialize buffer struc */
  buf.beg = xmalloc(BUFSIZE);			/* create the buffer itself */
  term = indirect ? indirect : name;		/* real thing or indirected */

/* if there's no user-supplied buffer then make one.  if we're getting our
   stuff from TERMCAP, then just make it big enough (for now) to fit it, else
   make it buf.size big. */

  if (!bp) {
      malloc_size = indirect ? strlen(tcenv) + 1 : buf.size;
      bp = xmalloc(malloc_size);
  }

  p = bp;				/* p is our working pointer into the
					   end buffer where we put results */

  if (indirect) {			/* copy the data from the TERMCAP */
      strcpy(bp, tcenv);		/* to the start of the buffer, and */
      p += strlen(tcenv);		/* put other stuff after it. */
  }

  while (term) {
      if (!scan_file(term, f, &buf))	/* scan file, reading it via */
	return 0;			/* buf, til find start of entry */
      if (term != name)			/* Free old `term' if appropriate. */
	free (term);
      if (malloc_size) {		/* if we made the buf, make sure */
	  malloc_size = p - bp + buf.size;	/* it's big enough */
	  temp = xrealloc(bp, malloc_size);
	  p += temp - bp;		/* adjust to point to new buf */
	  bp = temp;			/* this is the new buffer */
      }
      latest_entry = p;			/* save pointer to this latest entry */

/* Copy the entry from buf into bp, dropping any \ continuation stuff plus
   the following whitespace */

      temp = buf.ptr;		      
      while ((*p++ = c = *temp++) && c != '\n')
	if (c == '\\' && *temp == '\n') {
	    p--;				/* backup to clobber the / */
	    while ((c = *++temp) == ' ' || c == '\t') ;
	}
      *p = 0;					/* null terminate result */

/* Does this entry refer to another terminal type's entry?
   If something is found, copy it into heap and null-terminate it */

      term = tgetst1(find_capability(latest_entry, "tc"), (char **)0);
    }

  fclose(f);
  free(buf.beg);

  if (malloc_size)			/* what's this for??? */
      bp = xrealloc (bp, p - bp + 1);	/* deallocating extra, i think. */

  term_entry = bp;			/* save pointer to buf for later */
  if (malloc_size)			/* if we made them a buffer, then */
    return (int) bp;			/* return a pointer to it, else */
  return 1;				/* 1 return means success. */
}

/* Given file open on `f' and buffer `bufp',
   scan the file from the beginning until a line is found
   that starts the entry for terminal type `string'.
   Returns 1 if successful, with that line in `bufp',
   or returns 0 if no entry found in the file.  */

static int
scan_file (string, f, bufp)
     char *string;
     FILE *f;
     register struct buffer *bufp;
{
  register char *end;

  bufp->ptr = bufp->beg;
  bufp->full = 0;
  bufp->ateof = 0;
  *bufp->ptr = 0;

  rewind(f);

  while (!bufp->ateof)
    {
      /* Read a line into the buffer */
      end = 0;
      do
	{
	  /* if it is continued, append another line to it,
	     until a non-continued line ends */
	  end = gobble_line (f, bufp, end);
	}
      while (!bufp->ateof && end[-2] == '\\');

      if (*bufp->ptr != '#'
	  && name_match (bufp->ptr, string))
	return 1;

      /* Discard the line just processed */
      bufp->ptr = end;
    }
  return 0;
}

/* Return nonzero if NAME is one of the names specified
   by termcap entry LINE.  */

static int
name_match (line, name)
     char *line, *name;
{
  register char *tem;

  if (!compare_contin (line, name))
    return 1;
  /* This line starts an entry.  Is it the right one?  */
  for (tem = line; *tem && *tem != '\n' && *tem != ':'; tem++)
    if (*tem == '|' && !compare_contin (tem + 1, name))
      return 1;

  return 0;
}

static int
compare_contin (str1, str2)
     register char *str1, *str2;
{
  register int c1, c2;
  while (1)
    {
      c1 = *str1++;
      c2 = *str2++;
      while (c1 == '\\' && *str1 == '\n')
	{
	  str1++;
	  while ((c1 = *str1++) == ' ' || c1 == '\t');
	}
      if (c2 == '\0')		/* end of type being looked up */
	{
	  if (c1 == '|' || c1 == ':') /* If end of name in data base, */
	    return 0;		/* we win. */
	  else
	    return 1;
        }
      else if (c1 != c2)
	return 1;
    }
}

/* Make sure that the buffer <- `bufp' contains a full line
   of the file open on `f', starting at the place `bufp->ptr'
   points to.  Can read more of the file, discard stuff before
   `bufp->ptr', or make the buffer bigger.

   Returns the pointer to after the newline ending the line,
   or to the end of the file, if there is no newline to end it.

   Can also merge on continuation lines.  If `append_end' is
   nonzero, it points past the newline of a line that is
   continued; we add another line onto it and regard the whole
   thing as one line.  The caller decides when a line is continued.  */

static char *
gobble_line (f, bufp, append_end)
     FILE *f;
     register struct buffer *bufp;
     char *append_end;
{
  register char *end;
  register char *buf = bufp->beg;
  register char *tem;
  int i, c;
  char *p; 

  if (append_end == 0)
    append_end = bufp->ptr;

  while (1)
    {
      end = append_end;
      while (*end && *end != '\n') end++;
      if (*end)
        break;
      if (bufp->ateof)
	return buf + bufp->full;
      if (bufp->ptr == buf)
	{
	  if (bufp->full == bufp->size)
	    {
	      bufp->size *= 2;
	      tem = xrealloc (buf, bufp->size);
	      bufp->ptr += tem - buf;
	      append_end += tem - buf;
	      bufp->beg = buf = tem;
	    }
	}
      else
	{
	  append_end -= bufp->ptr - buf;
	  bcopy (bufp->ptr, buf, bufp->full -= bufp->ptr - buf);
	  bufp->ptr = buf;
	}
      for (p = buf + bufp->full, i = bufp->size - bufp->full; i > 0; i--)
	  if ((c = getc(f)) == EOF) {
	      bufp->ateof = 1;
	      break;
	  } else *p++ = c;
      bufp->full += (bufp->size - bufp->full - i);
      if (bufp->full != bufp->size)
	buf[bufp->full] = 0;
    }
  return end + 1;
}

/* Assuming STRING is the value of a termcap string entry
   containing `%' constructs to expand parameters,
   merge in parameter values and store result in block OUTSTRING points to.
   LEN is the length of OUTSTRING.  If more space is needed,
   a block is allocated with `malloc'.

   The value returned is the address of the resulting string.
   This may be OUTSTRING or may be the address of a block got with `malloc'.
   In the latter case, the caller must free the block.

   The fourth and following args to tparam serve as the parameter values.  */

#define tparam1	tparm1		/* more 6-character limiting */

static char *tparam1 ();

/* VARARGS 2 */
char *
tparam (string, outstring, len, arg0, arg1, arg2, arg3)
     char *string;
     char *outstring;
     int len;
     int arg0, arg1, arg2, arg3;
{
#ifdef NO_ARG_ARRAY
  int arg[4];
  arg[0] = arg0;
  arg[1] = arg1;
  arg[2] = arg2;
  arg[3] = arg3;
  return tparam1 (string, outstring, len, 0, 0, arg);
#else
  return tparam1 (string, outstring, len, 0, 0, &arg0);
#endif
}

static char tgoto_buf[50];

char *
tgoto (cm, hpos, vpos)
     char *cm;
     int hpos, vpos;
{
  int args[2];
  if (!cm)
    return 0;
  args[0] = vpos;
  args[1] = hpos;
  return tparam1 (cm, tgoto_buf, 50, UP, BC, args);
}

static char *
tparam1 (string, outstring, len, up, left, argp)
     char *string;
     char *outstring;
     int len;
     char *up, *left;
     register int *argp;
{
  register int c;
  register char *p = string;
  register char *op = outstring;
  char *outend;
  int outlen = 0;

  register int tem;
  int *oargp = argp;
  char *doleft = 0;
  char *doup = 0;

  outend = outstring + len;

  while (1)
    {
      /* If the buffer might be too short, make it bigger.  */
      if (op + 5 >= outend)
	{
	  register char *new;
	  if (outlen == 0)
	    {
	      new = (char *) malloc (outlen = 40 + len);
	      outend += 40;
	    }
	  else
	    {
	      outend += outlen;
	      new = (char *) realloc (outstring, outlen *= 2);
	    }
	  op += new - outstring;
	  outend += new - outstring;
	  outstring = new;
	}
      if (!(c = *p++))
	break;
      if (c == '%')
	{
	  c = *p++;
	  tem = *argp;
	  switch (c)
	    {
	    case 'd':		/* %d means output in decimal */
	      if (tem < 10)
		goto onedigit;
	      if (tem < 100)
		goto twodigit;
	    case '3':		/* %3 means output in decimal, 3 digits. */
	      if (tem > 999)
		{
		  *op++ = tem / 1000 + '0';
		  tem %= 1000;
		}
	      *op++ = tem / 100 + '0';
	    case '2':		/* %2 means output in decimal, 2 digits. */
	    twodigit:
	      tem %= 100;
	      *op++ = tem / 10 + '0';
	    onedigit:
	      *op++ = tem % 10 + '0';
	      argp++;
	      break;

	    case 'C':
	      /* For c-100: print quotient of value by 96, if nonzero,
		 then do like %+ */
	      if (tem >= 96)
		{
		  *op++ = tem / 96;
		  tem %= 96;
		}
	    case '+':		/* %+x means add character code of char x */
	      tem += *p++;
	    case '.':		/* %. means output as character */
	      if (left)
		{
		  /* If want to forbid output of 0 and \n,
		     and this is one, increment it.  */
		  if (tem == 0 || tem == '\n')
		    {
		      tem++;
		      if (argp == oargp)
			outend -= strlen (doleft = left);
		      else
			outend -= strlen (doup = up);
		    }
		}
	      *op++ = tem | 0200;
	    case 'f':		/* %f means discard next arg */
	      argp++;
	      break;

	    case 'b':		/* %b means back up one arg (and re-use it) */
	      argp--;
	      break;

	    case 'r':		/* %r means interchange following two args */
	      argp[0] = argp[1];
	      argp[1] = tem;
	      oargp++;
	      break;

	    case '>':		/* %>xy means if arg is > char code of x, */
	      if (argp[0] > *p++) /* then add char code of y to the arg, */
		argp[0] += *p;	/* and in any case don't output. */
	      p++;		/* Leave the arg to be output later. */
	      break;

	    case 'a':		/* %a means arithmetic */
	      /* Next character says what operation.
		 Add or subtract either a constant or some other arg */
	      /* First following character is + to add or - to subtract
		 or = to assign.  */
	      /* Next following char is 'p' and an arg spec
		 (0100 plus position of that arg relative to this one)
		 or 'c' and a constant stored in a character */
	      tem = p[2] & 0177;
	      if (p[1] == 'p')
		tem = argp[tem - 0100];
	      if (p[0] == '-')
		argp[0] -= tem;
	      else if (p[0] == '+')
		argp[0] += tem;
	      else if (p[0] == '*')
		argp[0] *= tem;
	      else if (p[0] == '/')
		argp[0] /= tem;
	      else
		argp[0] = tem;

	      p += 3;
	      break;

	    case 'i':		/* %i means add one to arg, */
	      argp[0] ++;	/* and leave it to be output later. */
	      argp[1] ++;	/* Increment the following arg, too!  */
	      break;

	    case '%':		/* %% means output %; no arg. */
	      goto ordinary;

	    case 'n':		/* %n means xor each of next two args with 140 */
	      argp[0] ^= 0140;
	      argp[1] ^= 0140;
	      break;

	    case 'm':		/* %m means xor each of next two args with 177 */
	      argp[0] ^= 0177;
	      argp[1] ^= 0177;
	      break;

	    case 'B':		/* %B means express arg as BCD char code. */
	      argp[0] += 6 * (tem / 10);
	      break;

	    case 'D':		/* %D means weird Delta Data transformation */
	      argp[0] -= 2 * (tem % 16);
	      break;
	    }
	}
      else
	/* Ordinary character in the argument string.  */
      ordinary:
	*op++ = c;
    }
  *op = 0;
  if (doleft)
    strcpy (op, doleft);
  if (doup)
    strcpy (op, doup);
  return outstring;
}

#ifdef DEBUG
short ospeed;
char PC;
char *BC;
char *UP;


main (argc, argv)
     int argc;
     char **argv;
{
  char buf[50];
  int args[3];
  args[0] = atoi (argv[2]);
  args[1] = atoi (argv[3]);
  args[2] = atoi (argv[4]);
  tparam1 (argv[1], buf, "LEFT", "UP", args);
  printf ("%s\n", buf);
  return 0;
}

#endif /* DEBUG */

#ifdef TEST

#include <stdio.h>

short ospeed;
char PC;
char *BC;
char *UP;


main (argc, argv)
     int argc;
     char **argv;
{
  char *term;
  char *buf;

  term = argv[1];
  printf ("TERM: %s\n", term);

  buf = (char *) tgetent((char *)0, term);
  if ((int) buf == 0)
    {
      printf ("Entry not found.\n");
      return 0;
    }
  if ((int) buf == -1)
    {
      printf ("Cannot get termcap file.\n");
      return 0;
    }

  printf ("Entry: %s\n", buf);

  tprint ("cm");
  tprint ("AL");

  printf ("co: %d\n", tgetnum ("co"));
  printf ("am: %d\n", tgetflag ("am"));
}

tprint (cap)
     char *cap;
{
  char *x = tgetstr (cap, 0);
  register char *y;

  printf ("%s: ", cap);
  if (x)
    {
      for (y = x; *y; y++)
	if (*y <= ' ' || *y == 0177)
	  printf ("\\%0o", *y);
	else
	  putchar (*y);
      free (x);
    }
  else
    printf ("none");
  putchar ('\n');
}

#endif /* TEST */
