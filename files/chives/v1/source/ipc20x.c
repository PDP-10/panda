/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Twenex IPCF code.  Large portions taken verbatim from VAF's Bliss code.
 *
 * Caller must define functions bughlt(), bugchk(), and buginf().
 * This is so that we don't have to make assumptions about where
 * we should write error messages (no, stderr isn't the obvious place).
 */

#include <stdio.h>
#include <macsym.h>
#include <monsym.h>
#include <jsys.h>
#include <string.h>

/* ipc20x.c */
int ipc_init(char *,int);
int ipc_fini(int);
int ipc_send(int,int ,int *);
int ipc_recv(int,int *,int );
char *ipc_user(int,char *);
int ipc_lookup(int,char *);

/* Compile extended code by default, since it can run either way. */
#ifndef	EXTENDED_ADDRESSING
#define	EXTENDED_ADDRESSING 1
#endif

/* Page size, just to keep code pretty. */
/* Assume is a power of 2 (God help the microcode if it isn't!). */
#define PAGE_SIZE 01000

/* Maximum size of a short IPCF message (see jsys documentation). */
#define SHORT_IPCF_SIZE 50

/* Size of strings.  Only named PID code cares, hence odd default. */
#ifndef STRSIZ
#define STRSIZ ((SHORT_IPCF_SIZE-2)*5)
#endif

/* Size of IPCF packet descriptor.  Also used for MUTIL% requests. */
#define PACKET_SIZE 4

/* Size of block used to talk to [SYSTEM]INFO. */
#define	INFBLK_SIZE (3+STRSIZ/5)

/* Minimum size for a short IPCF packet from [SYSTEM]INFO. */
#define	INFBLK_MIN  4

#if EXTENDED_ADDRESSING
/* Backup object for talking to [SYSTEM]INFO. */
struct infblk_backup {
    int dummy[INFBLK_SIZE];
};

/* Backup object for message packets. */
struct packet_backup {
    int dummy[PACKET_SIZE];
};

/* Object type for buffering generic short IPCF message. */
struct short_ipcf_buffer {
    int dummy[SHORT_IPCF_SIZE];
};
#endif

/* PID of [SYSTEM]INFO. */
#define INFO_PID    0

/* More readable name. */
#define CHAR7 _KCCtype_char7

/* Bug reporting functions. */
extern void buginf(char *module, char *format, ...);
extern void bugchk(char *module, char *format, ...);
extern void bughlt(char *module, char *format, ...);

/* ipc_init(pidnam,pididx)
 *  Initialize IPCF.
 *
 *  PIDNAM is the name you want this pid to have.  If NULL, this
 *  pid will have no name (this is the normal case for user pids).
 *
 *  PIDIDX is an index in the system pid table, or -1 if no index.
 *  If specifed, we try to put the newly created pid into that table
 *  slot.  -1 is the normal case for user pids, of course.
 *
 *  Some combinations require WHEEL, OPERATOR, or IPCF privs (don't need
 *  to be enabled, we do that for you).  It seems the monitor calls manual
 *  lies about some of this, so we always enable and put the bits back
 *  when done.
 *
 *  Returns 0 on lossage, otherwise a pid.
 *
 *  At present we don't use PSI.  It would probably interact strangely
 *  the uio signal simulation code, for one thing.  See ipc_recv() if
 *  ever decide to do this, though.
 */

#define punt(msg) { bugchk("ipc_init",msg); goto cleanup; }

#if STRSIZ < 5
#error String length constant is much too small, ipc_init() will lose!
#endif

ipc_init(pidnam,pididx)
    char *pidnam;
    int pididx;
{
    int ac[5], mypid, priv1 = 0, priv2 = 0, won = 0;

#if EXTENDED_ADDRESSING
    static int packet[PACKET_SIZE];
    struct packet_backup backet;
    backet = *(struct packet_backup *) packet;
#else
    int packet[PACKET_SIZE];
#endif

    ac[1] = monsym(".FHSLF");		/* See what priv bits we have */
    if(!jsys(RPCAP,ac))
	punt("unexpected RPCAP%% failure");
    priv1 = ac[2];			/* Save our privs for later */
    priv2 = ac[3];
    ac[3] |= monsym("SC%WHL")|monsym("SC%OPR")|monsym("SC%IPC");
    jsys(EPCAP,ac);			/* Try to enable all useful bits */

    if(pidnam == NULL) {		/* Do we want a named PID? */
	packet[0] = monsym(".MUCRE");	/* No, just create vanilla PID */
	packet[1] = monsym(".FHSLF");	/* For self */
	ac[1] = PACKET_SIZE;		/* Length of request packet */
	ac[2] = (int) packet;		/* Address of packet */
	if(!jsys(MUTIL,ac))
	    punt("unable to allocate PID");
	mypid = packet[2];		/* Got it */
    }
    else {				/* Did want a named PID */
	CHAR7 *s;
	char *t;
#if EXTENDED_ADDRESSING
	static int infblk[INFBLK_SIZE];
	struct infblk_backup _backup;
	_backup = *(struct infblk_backup *)infblk;
#else
	int infblk[INFBLK_SIZE];
#endif

	infblk[0] = monsym(".IPCII");	/* Tell [SYSTEM]INFO what we want */
	infblk[1] = 0;			/* Don't CC the response to anybody */
	for (s = (CHAR7 *) (infblk+2),t = pidnam; *t; *s++ = *t++);
					/* Copy PID name in 7bit ascii */
	packet[monsym(".IPCFL")] = monsym("IP%CPD"); /* Create PID for me */
	packet[monsym(".IPCFS")] = 0;	/* No sender pid yet */
	packet[monsym(".IPCFR")] = INFO_PID;	/* Receiver is [SYSTEM]INFO */
	packet[monsym(".IPCFP")] = XWD(3+strlen(pidnam)/5, (int)infblk);
					/* Data pointer (ick) */
	ac[1] = PACKET_SIZE;		/* Send this off to the daemon */
	ac[2] = (int) packet;
	if(!jsys(MSEND,ac))
	    punt("couldn't send request to [SYSTEM]INFO");

	mypid = packet[monsym(".IPCFS")]; /* Save the PID we were allocated */

	packet[monsym(".IPCFL")] = 0;	/* No flags */
	packet[monsym(".IPCFS")] = 0;	/* Shouldn't matter */
	packet[monsym(".IPCFR")] = mypid; /* We are listening */
	packet[monsym(".IPCFP")] = XWD(INFBLK_MIN, (int)infblk);

	ac[1] = PACKET_SIZE;		/* Wait for a response */
	ac[2] = (int) packet;
	if(!jsys(MRECV,ac))
	    punt("couldn't get response from [SYSTEM]INFO");

	/* Check status returned by [SYSTEM]INFO */
	switch(FLDGET(packet[monsym(".IPCFL")],monsym("IP%CFE"))) {
	    case 0:			/* No error */
		break;
	    case monsym(".IPCDN"):
		punt("somebody else is using my PID");
	    default:			/* Something else */
		bugchk("ipc_init","[SYSTEM]INFO returned unknown error 0%o",
			FLDGET(packet[monsym(".IPCFL")],monsym("IP%CFE")));
		punt("I don't know what to do with that error, giving up");
	}
#if EXTENDED_ADDRESSING
	*(struct infblk_backup *)infblk = _backup;
#endif
    }

    if(pididx != -1) {			/* Put this PID in system table? */
					/* Yes... */
	packet[0] = monsym(".MUSSP");	/* Add an entry to system table */
	packet[1] = pididx;		/* Slot user wants to have */
	packet[2] = mypid;		/* This is my PID */

	ac[1] = PACKET_SIZE;
	ac[2] = (int) packet;
	if(!jsys(MUTIL,ac))
	    punt("couldn't put self in system PID table");
    }

    won = 1;				/* Made it through the gauntlet */

cleanup:				/* C doesn't have UNWIND-PROTECT */

    if((priv1|priv2) != 0) {		/* Attempt to put privs back */
	ac[1] = monsym(".FHSLF");
	ac[2] = priv1;
	ac[3] = priv2;
	jsys(EPCAP,ac);
    }

#if EXTENDED_ADDRESSING
    *(struct packet_backup *) packet = backet;
#endif

    return(won ? mypid : 0);		/* Done, return the PID we got. */
}

#undef punt

/* Close down IPCF for this process. */

int ipc_fini(mypid)
    int mypid;
{
    int ac[5], packet[PACKET_SIZE];

    packet[0] = monsym(".MUDES");
    packet[1] = mypid;

    ac[1] = PACKET_SIZE;
    ac[2] = (int) packet;
    return(jsys(MUTIL,ac));
}

/* Send a message.
 *
 * Always use paged mode.  Note odd return conventions: returns zero if won,
 * else returns jsys error code (like _jsys() in NMT C library).  There are
 * just too many things that could happen and we have no way of knowing what
 * the user wants to do about it.
 */

#define punt(msg) { bugchk("ipc_send",msg); goto cleanup; }

int ipc_send(mypid,pid,data)
    int mypid, pid, *data;
{
    int ac[5], value = -1;

#if EXTENDED_ADDRESSING
    static int packet[PACKET_SIZE];
    struct packet_backup backet;
    backet = *(struct packet_backup *) packet;
#else
    int packet[PACKET_SIZE];
#endif

    if(mypid == 0 || pid == 0)
	punt("zero is not a valid pid");

    if(((int)data)&(PAGE_SIZE-1))
	punt("data is not page aligned");

    packet[monsym(".IPCFL")] = monsym("IP%CFV")|monsym("IP%EPN");
					/* Paged mode, extended addressing */
    packet[monsym(".IPCFR")] = pid;	/* Receipient */
    packet[monsym(".IPCFS")] = mypid;	/* I'm the sender */
    packet[monsym(".IPCFP")] = XWD(PAGE_SIZE, ((int) data)/PAGE_SIZE);

    ac[1] = PACKET_SIZE;
    ac[2] = (int) packet;		/* Try to send the message */
    if(jsys(MSEND,ac))			/* If we succeeded, give good return */
	value = 0;			/* NB: zero means no error! */
    else				/* Return the error code to caller. */
	value = ac[0];

cleanup:				/* UNWIND-PROTECT */

#if EXTENDED_ADDRESSING
    *(struct packet_backup *) packet = backet;
#endif

    return(value);
}
#undef punt

/* ipc_recv()
 *
 *  Receive next packet of data from mypid.  Data is probably one
 *  page, if that doesn't work we try the maximum length short message
 *  (in which case caller will get a new page with zeros after the
 *  short message).
 *
 *  Returns pid received from on win, 0 if lost or no data in queue.
 */

int ipc_recv(mypid,data,waitp)
    int mypid, *data, waitp;
{
    int ac[5], result = 0;

#if EXTENDED_ADDRESSING
    static int packet[PACKET_SIZE];
    struct packet_backup backet;
    backet = * (struct packet_backup *) packet;
#else
    int packet[PACKET_SIZE];
#endif

    if(((int) data)&(PAGE_SIZE-1)) {	/* check page alignment */
	bugchk("ipc_recv","data pointer not page aligned");
	return(0);
    }
    ac[1] = -1;				/* unmap page if present */
    ac[2] = XWD(monsym(".FHSLF"), ((int) data)/PAGE_SIZE);
    ac[3] = 0;				/* (otherwise, MRECV% fails) */
    jsys(PMAP,ac);			/* let MRECV% flame if this lost */

    packet[monsym(".IPCFL")] = waitp ? monsym("IP%CFV")|monsym("IP%EPN")
				     : monsym("IP%CFV")|monsym("IP%EPN")
						       |monsym("IP%CFB");
    packet[monsym(".IPCFR")] = mypid;
    packet[monsym(".IPCFS")] = 0;
    packet[monsym(".IPCFP")] = XWD(PAGE_SIZE, ((int) data)/PAGE_SIZE);
    ac[1] = PACKET_SIZE;		/* Get paged mode data */
    ac[2] = (int) packet;
    if(jsys(MRECV,ac))			/* Win? */
	result = packet[monsym(".IPCFS")]; /* Yeah, remember her PID */
    else if(ac[0] == monsym("IPCF16")) {
#if EXTENDED_ADDRESSING			/* Mode mismatch, try short IPCF */
	static struct short_ipcf_buffer short_ipcf_block;
	struct short_ipcf_buffer short_ipcf_backup;
	short_ipcf_backup = short_ipcf_block;
	packet[monsym(".IPCFP")] = XWD(SHORT_IPCF_SIZE,(int)&short_ipcf_block);
#else
	packet[monsym(".IPCFP")] = XWD(SHORT_IPCF_SIZE,(int)data);
#endif
	packet[monsym(".IPCFL")] = waitp ? 0 : monsym("IP%CFB");
	packet[monsym(".IPCFR")] = mypid;
	packet[monsym(".IPCFS")] = 0;
	ac[1] = PACKET_SIZE;		/* Short mode this time */
	ac[2] = (int) packet;
	if(jsys(MRECV,ac)) {		/* If we win */
	    if(packet[monsym(".IPCFL")]&monsym("IP%CFZ")) /* Empty packet? */
		*data = 0;		/* Yeah, just make a clean page */
#if EXTENDED_ADDRESSING
	    else			/* No, copy data if needed */
		*((struct short_ipcf_buffer *) data) = short_ipcf_block;
#endif
	    result = packet[monsym(".IPCFS")]; /* Won, so return PID */
	}
#if EXTENDED_ADDRESSING			/* Restore static buffer */
	short_ipcf_block = short_ipcf_backup;
#endif
    }

#if EXTENDED_ADDRESSING			/* Restore static buffer */
    *(struct packet_backup *) packet = backet;
#endif
    if(result == 0 && (waitp || ac[0] != monsym("IPCFX2")))
	bugchk("ipc_recv","unexpected jsys error %06o",ac[2]&_RHALF);

    return(result);			/* Return whatever we got */
}


/*
 * ipc_user(pid,string)
 *  Get username string associated with pid.
 */

char *ipc_user(pid,user)
    int pid;
    char *user;
{
    int ac[5], packet[PACKET_SIZE], when, job;
    jsys(GTAD,ac);			/* Get current time */
    when = ac[1];			/* Remember it for check */
    packet[0] = monsym(".MUFOJ");	/* Translate PID to job number */
    packet[1] = pid;
    ac[1] = PACKET_SIZE;
    ac[2] = (int) packet;
    if(!jsys(MUTIL,ac))
	return(NULL);
    job = ac[1] = packet[2];		/* Translate job to user number */
    ac[2] = XWD(-1,4);
    ac[3] = monsym(".JIUNO");
    if(!jsys(GETJI,ac))
	return(NULL);
    ac[1] = (int) (user-1);		/* Write username */
    ac[2] = ac[4];
    if(!jsys(DIRST,ac))
	return(NULL);
    ac[1] = job;			/* Get job creation time */
    ac[2] = XWD(-1,4);
    ac[3] = monsym(".JISTM");
    if(!jsys(GETJI,ac))
	return(NULL);
    if(when < ac[4])			/* Timing screw? */
	return(NULL);
    return(user);			/* Won, return username */
}

/*
 * ipc_lookup(mypid,name)
 *  Find pid associated with name.
 */

#define punt(msg) { bugchk("ipc_lookup",msg); goto cleanup; }

int ipc_lookup(mypid,name)
    int mypid;
    char *name;
{
    int ac[5], result = 0;
    CHAR7 *s;
    char *t;

#if EXTENDED_ADDRESSING
    static int infblk[INFBLK_SIZE];
    struct infblk_backup _backup;
    static int packet[PACKET_SIZE];
    struct packet_backup backet;
    _backup = *(struct infblk_backup *) infblk;
    backet = *(struct packet_backup *) packet;
#else
    int infblk[INFBLK_SIZE];
    int packet[PACKET_SIZE];
#endif

    infblk[0] = monsym(".IPCIW");	/* Want to lookup a name */
    infblk[1] = 0;			/* Don't CC the response */
    for (s = (CHAR7 *) (infblk+2),t = name; *t; *s++ = *t++);

    packet[monsym(".IPCFL")] = 0;	/* No flags */
    packet[monsym(".IPCFS")] = mypid;	/* From me */
    packet[monsym(".IPCFR")] = INFO_PID; /* To [SYSTEM]INFO */
    packet[monsym(".IPCFP")] = XWD(3+strlen(name)/5, (int)infblk);

    ac[1] = PACKET_SIZE;
    ac[2] = (int) packet;
    if(!jsys(MSEND,ac))
	punt("couldn't send lookup request to [SYSTEM]INFO");

    bzero((char *)infblk, sizeof(infblk));

    packet[monsym(".IPCFL")] = 0;	/* No flags */
    packet[monsym(".IPCFR")] = mypid;	/* To me */
    packet[monsym(".IPCFS")] = 0;	/* From whoever */
    packet[monsym(".IPCFP")] = XWD(INFBLK_SIZE,(int)infblk);

    ac[1] = PACKET_SIZE;
    ac[2] = (int) packet;
    if(!jsys(MRECV,ac))
	punt("couldn't get answer from [SYSTEM]INFO");

    if(packet[monsym(".IPCFL")]&monsym("IP%CFE")) {
	bugchk("ipc_lookup","[SYSTEM]INFO returned unexpected error 0%o",
		FLDGET(packet[monsym(".IPCFL")],monsym("IP%CFE")));
	punt("I give up");
    }

    result = infblk[1];			/* This is what we return */

cleanup:				/* UNWIND-PROTECT */

#if EXTENDED_ADDRESSING
    *(struct infblk_backup *) infblk = _backup;
    *(struct packet_backup *) packet = backet;
#endif

    return(result);
}
#undef punt
