/* MLIST.C by Frank J. Wancho (WANCHO@SIMTEL20.ARPA) 02/14/87

MLIST normally takes no arguments.  However, if OEXEC is not defined
and an argument is given, the SUBMIT command will not be issued so
that the program may conveniently debugged.

MLIST was designed as one consolidated solution to two problems with
mailing list processing:

1. The first problem is that mailing lists tend to generate long
queues which interfere with the timely processing of "normal" mail
embedded in the same queue.  MLIST puts mailing list mail in its own
queue to be processed by a slightly modified version of MMAILR.  The
modified version of MMAILR simply contains "REDIST-" substituted for
all occurances of "QUEUED-" in a copy of the MMAILR source renamed to
RMAILR.MAC.

2. The second problem is that normally there is no way to specify that
notices and failures are to be sent to the mailing list maintainer.
MLIST specifies of the RETURN-PATH: to be listname-REQUEST@OHN when it
creates the new queued mail file.

MLIST takes advantage of the Special Network feature of MMAILR,
documented elsewhere, and the format of the message file files created
in the Special Network message file directory.  In particular, the
second line of the message file contains the username portion of the
redirected address, which is expected to be the name of the mailing
list.  MLIST also expects the actual mailing list address to be named
listname-MLIST.  The set of example entries for a hypothetical list
named INFO-TEST in MAIL:MAILING-LISTS.TXT for Special Network host
named MLIST is:

INFO-TEST= INFO-TEST-QUEUE
INFO-TEST-QUEUE= INFO-TEST@MLIST
INFO-TEST-MLIST= @PS:<list-maintainer-directory>listfilename
INFO-TEST-REQUEST= list-maintainer-address

MLIST is written to be compiled with KCC.  Edit the values for
QUEUENAME and OHN (the Official Host Name for you host), and compile
with -DOEXEC if your EXEC has not been modified to accept input from
its RSCAN buffer.  Copy the resulting MLIST.EXE file into the Special
Network directory for this "host".  Create a self-perpetuating batch
job in that directory and start it running under OPERATOR.  Finally,
create a version of MMAILR as RMAILR as described above and run it
under SYSJOB.

*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define LINESIZE    1026		/* max line input size from msg */
#define FNSIZE	    100			/* max file name size */
#define OHN	    "PANDA.COM"		/* Official Host Name of local host */
#define	QUEUENAME   "REDIST"		/* part of RMAILR queue filenames */

FILE	*inmsg;				/* input message file descriptor */
FILE	*outmsg;			/* output message file descriptor */

char    line[LINESIZE];			/* input line from message file */
char	infile[FNSIZE];			/* input filename */
char	outfile[FNSIZE];		/* output filename */
char	tmp[FNSIZE];			/* temporary string */
int	debug;				/* runtime debug flag */

char   *dir(char *,int);
long    getad(void);
int	domsg(int);
int	strip(char *);

main (num, arg)
int	num;
char	*arg[];
{
    char   *d;			       /* pointer to string returned by dir() */
    char   *name[500];		       /* pointer to pointers to names */
    int     nfiles;		       /* count of number of files found */
    int	    n;			       /* loop counter */

    debug = 0;
    if (num > 1) {		       /* if any args */
	debug = 1;		       /* set flag */
    }

    /* First rename any left over files from some previous run */

    for (d = dir ("-MESSAGE.*.*", 1); *d; d = dir (NULL, 1)) {
	sprintf (infile, "-MAIL.0%lo-%d", getad(), ++nfiles);
	if (rename (d, infile)) {      /* if rename fails */
	    exit (1);		       /* exit */
	}
    }
    nfiles = 0;			       /* initialize count */

    /* Find and save the names of all message files */

    for (d = dir ("-MAIL.*", 1); *d; d = dir (NULL, 1)) {
	name[nfiles] = malloc (strlen (d) + 1); /* allocate space */
	strcpy (name[nfiles], d);	/* save the name */
	if (nfiles++ > 200) {	       /* found one - bump count */
	    break;
	}
    }
    if (nfiles) {		       /* if any file found */
	/* Rename each file, one at a time, process and delete it */
	for (n = 0; n < nfiles; n++) {
	    sprintf (infile, "-MESSAGE.%lo-%d", getad(), n+1);
	    if (rename (name[n], infile)) { /* if rename failed */
		exit (1);	       /* exit */
	    }
	    if ((inmsg = fopen (infile, "r")) == NULL) { /* open the file */
		exit (1);	       /* exit if failed to open */
	    }
	    domsg (n);		       /* process the file */
	    fclose (inmsg);	       /* close it */
	    unlink (infile);	       /* delete and expunge it */
	}
    }
#ifndef OEXEC			       /* if EXEC modified, compile this */
    if (!debug) {		       /* if debug off */
system ("EXEC SUBMIT MLIST.CTL/OUTPUT:NOLOG/UNI:NO/BAT:SUPER/TIM:60/AFTER:+1:00/RESTART:YES"); /* self-perpetuate */
    }
#endif
    exit (0);			       /* done for now */
}

/* domsg() takes one arg - the current loop counter value for creating
a unique queue filename, creates the new queue file from the message file. */

int
domsg (n)
int	n;
{
    long    getad();

    sprintf (outfile, "\026[--%s-MAIL--\026].NEW-%lo-MLIST-%d",
	     QUEUENAME, getad(), n);    /* create the unique queue filename */
    if ((outmsg = fopen (outfile, "w")) == NULL) { /* open it for write */
	exit (1);		       /* exit on failure */
    }
    fgets (line, LINESIZE, inmsg);     /* read the first line from message */
    fgets (line, LINESIZE, inmsg);     /* read the second line */
    strip (line);		       /* remove any useless chars */
    fprintf(outmsg, "\f=RETURN-PATH:%s-REQUEST@%s\n", line, OHN);
    fprintf(outmsg, "\f_%s\n%s-REQUEST\n", OHN, line);
    fprintf(outmsg, "\f%s\n%s-MLIST\n", OHN, line); /* write envelope */
    while (fgets (line, LINESIZE, inmsg) != NULL) { /* copy rest of file */
	fputs (line, outmsg);	       /* to new queue file */
    }
    fclose (outmsg);		       /* close queue file */
    sprintf(tmp, "MAILQ:%s", outfile); /* form target name in MAILQ: */
    rename (outfile, tmp);	       /* rename it and ignore failures */
    return (0);
}

#include <jsys.h>

static char result[FNSIZE];

char *
dir(fname, flg)	/* expands wildcard filename, returning the next  */
char *fname;	/* available filename on each successive call. */
		/* Returns NULL when list exhausted */
int flg;	/* If flag is 1, only the fn.typ is returned. */
{
    int     ablock[5];
    int     njfn;
    char    buf[FNSIZE];
    static int  first = 1;	/* true only on first call */
    static int  jfn;

    if (fname) {		/* if filename is given, use it */
	ablock[1] = GJ_SHT | GJ_OLD | GJ_IFG | T20_BIT (13);
	ablock[2] = (int) (fname - 1);
	if (!(jsys (GTJFN, ablock))) {
	    return NULL;
	}
	jfn = ablock[1];
	njfn = ablock[1];
    } else {
	if (first) {		/* if no name and first call */
	    return NULL;	/* then not much we can do */
	} else {		/* else search for next */
	    ablock[1] = jfn;
	    if (!(jsys (GNJFN, ablock))) {
		first = 1;
		return NULL;
	    }
	    njfn = ablock[1];
	}
    }
    first = 0;			/* no longer first time */

    ablock[1] = (int) (buf - 1);
    ablock[2] = njfn & 0777777;
    if (flg) {
	ablock[3] = T20_BIT (8) | T20_BIT (11) | T20_BIT (35);
    } else {
	ablock[3] = 0;
    }
    if (!(jsys (JFNS, ablock))) {
	first = 1;
	return NULL;
    }
    strcpy (result, buf);	/* save name of file */
    return result;
}

long
getad()		/* Calls GTAD and returns the value in AC1, the */
		/* current system date. */
{
    int	ac[5];

    jsys (GTAD, ac);
    return (ac[1]);
}

int
strip(s)	/* Returns s stripped of any leading or trailing */
char *s;	/* blanks and trailing CRs */
{
    int i;
    char *p;

    if (strlen (s) == 0) {
	return (1);
    }
    p = s;
    while (*p == ' ')		/* strip leading blanks */
	for (i = 0; *(p+i); i++)
	    *(p+i) = *(p+i+1);
    while (*p) p++;
    --p;
    while ((*p == ' ') || (*p == '\n')) {/* strip trailing blanks an cr */
	*p = 0;
	p--;
    }
}
