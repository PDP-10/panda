/* cafdir.c - directory lookup procs for cafard	-*-C-*- */

#include <stdio.h>
#include <iodef.h>
#include <ctype.h>
#include <descrip.h>
#include <dvidef.h>
#include <rms.h>
#include <errno.h>
#include "igdef.h"

/*
 *  fparse(name)  - perform dcl style f$parse to find wildcarded list of files
 *  fnext(name)   - perform f$search equiv to find next file in fparse list
 */

#define MSGMAX 100		/* Maximum message files we expect */

static int nummsgs;		/* number of message files found */

static char *msgs[MSGMAX],	/* array of names of messages */
     **msgptr;			/* pointer to current message */

int fparse(name)		/* return number of files found */
  char *name;
 {
#if debugsw
printf("[looking for %s]\n",name);
#endif
  nummsgs = fsearch(name);	/* find those messages */
#if debugsw
printf("[done]\n");
#endif
  if (nummsgs > 0)		/* any messages? */
    msgptr = msgs;		/* save start of list */
  return(nummsgs);
 }

int fnext(name)
  char **name;
 {
  if (nummsgs-- > 0)
    *name = *msgptr++;
  return(nummsgs+1);
 }

int fsearch(name)
  char *name;
 {
  struct dsc$descriptor_s name_desc, result, msg_def;
  long context;
  int count, slen, st, plen;
  char *nstart, *rp, resultstr[256], *strchr();

  name_desc.dsc$b_dtype   = DSC$K_DTYPE_T;
  name_desc.dsc$b_class   = DSC$K_CLASS_S;
  name_desc.dsc$w_length  = strlen(name);
  name_desc.dsc$a_pointer = name;

  result.dsc$w_length  = sizeof resultstr;
  result.dsc$b_dtype   = DSC$K_DTYPE_T;
  result.dsc$b_class   = DSC$K_CLASS_S;
  result.dsc$a_pointer = resultstr;

  msg_def.dsc$b_dtype   = DSC$K_DTYPE_T;
  msg_def.dsc$b_class   = DSC$K_CLASS_S;
  msg_def.dsc$w_length  = 5;
  msg_def.dsc$a_pointer = "*.MES";

  count = 0;
  context = 0;
  nstart = strchr(name, ']');
  if (nstart == 0) nstart = strchr(name, ':');
  if (nstart == 0) plen = 0;
  else plen = nstart - name + 1;
  while (count < MSGMAX
    && (st = LIB$FIND_FILE(&name_desc, &result, &context, &msg_def))
	== RMS$_NORMAL) 
   {
    rp = strchr(resultstr, ']') + 1;
    slen = strchr(rp, ' ') - rp;
/*    if (msgs[count])
     free(msgs[count]);		* get rid of any old storage */
    msgs[count] = malloc(slen + plen + 1);
    if (plen != 0)
      strncpy(msgs[count], name, plen);
    strncpy(msgs[count] + plen, rp, slen);
    msgs[count][slen + plen] = '\0';
    ++count;
    }
#ifdef DVI$_ALT_HOST_TYPE	/* V4+? */
  lib$find_file_end(&context);
#endif
  if (st == RMS$_FNF) return(0);
  if (st == RMS$_NMF) return(count);
  return(-1);
 }
