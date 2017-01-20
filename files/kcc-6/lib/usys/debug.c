/* Debugging output routines */

#include <jsys.h>
#include <sys/c-debug.h>

/* All output goes to controlling terminal, regardless of where */
/* primary I/O is going. */

/* Output string */
void _dbgs(str)
const char *str;
{
  int acs[5];

  acs[1] = _CTTRM;
  acs[2] = (int)(str - 1);
  acs[3] = 0;
  jsys(SOUT, acs);
}

/* Output decimal number */
void _dbgd(num)
long num;
{
  int acs[5];

  acs[1] = _CTTRM;
  acs[2] = num;
  acs[3] = 10;
  jsys(NOUT, acs);
}

/* Output octal number */
void _dbgo(num)
unsigned long num;
{
  int acs[5];

  acs[1] = _CTTRM;
  acs[2] = num;
  acs[3] = 010 | monsym("NO%MAG");
  jsys(NOUT, acs);
}

/* Output directory number */
void _dbgdn(dirno)
unsigned long dirno;
{
  int acs[5];
  acs[1] = _CTTRM;
  acs[2] = dirno;
  _dbgs("\"");
  jsys(DIRST, acs);
  _dbgs("\"");
}

/* Output JFN info */
void _dbgj(jfn)
unsigned long jfn;
{
  int acs[5];

  if (jfn & (0777777770000)) {
    switch(jfn) {
    case _CTTRM:
      _dbgs("\"TTY:\""); break;
    case monsym(".NULIO"):
      _dbgs("\"NUL:\""); break;
    default:
      _dbgo(jfn);  break;
    }
  }
  else {
    _dbgo(jfn);
    _dbgs(" \"");
    acs[1] = _CTTRM;
    acs[2] = jfn;
    acs[3] = 0;
    jsys(JFNS, acs);
    _dbgs("\"");
    }
  acs[1] = jfn;
  if (jsys(RFPTR, acs) && acs[2]) {
    _dbgs("(");
    _dbgd(acs[2]);
    _dbgs(")");
  }
}

/* Debug line prefix and label */
void _dbgl(label)
const char *label;
{
  int acs[5];

  acs[1] = _CTTRM;
  jsys(DOBE, acs);		/* Wait till empty to try to sync messages */
  _dbgs(`$HERIT`);
  _dbgs(": ");
  _dbgs(label);
}
