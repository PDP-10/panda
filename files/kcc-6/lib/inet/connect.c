/* 
 * connect.c - connect(2) initiate a connection on a socket
 *
 * Bill Palmer / Cisco Systems / May 1988
 * Ian Macky / cisco Systems / September 1990
 */

#include <c-env.h>
#include <errno.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/file.h>
#include <sys/usydat.h>
#include <sys/usysio.h>
#include <netinet/in.h>
#include <jsys.h>
#include <sys/c-debug.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

static int con_jfn P_((char *hostname));

#undef P_

#define I(byte, position)\
  (((unsigned)(byte) & 0377) << ((position) * 8))

int connect(fd, name, namelen)
int fd;
const struct sockaddr *name;
int namelen;
{
    char namebuf[128];
    const struct sockaddr_in *sin = (struct sockaddr_in *) name;
    struct _ufile *uf;
    int jfn;
    char *p = (char *)&sin->sin_addr.S_un.S_addr;
    unsigned long addr = I(p[0],3) | I(p[1],2) | I(p[2],1) | I(p[3],0);

    USYS_BEG();

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("CONNECT&connect(fd=");
	_dbgd(fd);
	_dbgs(", name=");
	_dbgo((int)name);
	_dbgs("(S_addr=");
	_dbgo(addr);
	_dbgs(", sin_port=");
	_dbgd(sin->sin_port);
	_dbgs("), namelen=");
	_dbgd(namelen);
	_dbgs(")\r\n");
    }
#endif

    sprintf(namebuf, "TCP:.%lo-%d;PERSIST:60;CONNECTION:ACTIVE",
	    addr , sin->sin_port);

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("CONNECT&connect(fd=");
	_dbgd(fd);
	_dbgs(") namebuf=|");
	_dbgs(namebuf);
	_dbgs("|\r\n");
    }
#endif

    if (!(uf = USYS_VAR_REF(uffd[fd])))
	USYS_RETERR(ENOTSOCK);		/* err... */

    if ((jfn = con_jfn(namebuf)) < 0)
	USYS_RETERR(EADDRNOTAVAIL);	/* well.. */

    uf->uf_ch = jfn;
    _openuf(fd, uf, O_RDWR | O_BINARY | O_BSIZE_8);

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("CONNECT&connect(fd=");
	_dbgd(fd);
	_dbgs(") ==> jfn=");
	_dbgj(jfn);
	_dbgs("\r\n");
    }
#endif
    USYS_RET(0);
}

/*
 |	Open a connection, return the JFN
 */

static int con_jfn(hostname)
char *hostname;
{
    int acs[5], jfn;

    acs[1] = GJ_SHT | GJ_NEW;
    acs[2] = (int) (hostname - 1);
    if (!jsys(GTJFN, acs))
	return -1;
    jfn = acs[1];
    acs[2] = FLD(8,OF_BSZ) | FLD(monsym(".TCMWH"),OF_MOD) | OF_RD | OF_WR;
				/* 8 bit bytes, high throughput, read/write */
    if (!jsys(OPENF, acs)) {
	acs[1] = jfn;
        jsys(RLJFN, acs);	/* Release JFN on error */
	return -1;
    }
    return jfn;
}
