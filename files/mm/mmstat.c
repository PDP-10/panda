 /* * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
 /* this is a program to compile statistics from mmailr... */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * *  */

#include <stdio.h>
#include <ctype.h>

int lclwakeups = 0;
int lclusefull = 0;
int rtmwakeups = 0;
int rtmusefull = 0;
int ntwwakeups = 0;
int ntwusefull = 0;
int mmcnt =0;
int babcnt =0;
int chacnt = 0;
int reqcnt = 0;
int defcnt =0;
int rcvcnt =0;
int bbcnt =0;
int actcnt =0;
int dmpcnt =0;
int sndcnt =0;
int sdfcnt =0;
int rtncnt =0;
int bdycnt =0;
int inqcnt =0;
int cafcnt =0;
int maicnt =0;

void do1log(void);
void do2log(void);
void do3log(void);
void outstats(void);


main(argc,argv)
int argc;
char *argv[];
{
    do1log();
    do2log();
    do3log();
    outstats();
}

 /* * * * * * * * * * * * * * * * * * * * * *  */
 /* prefixed says if str2 is prefixed by str1  */
 /* * * * * * * * * * * * * * * * * * * * * *  */

prefixed(str1,str2)
char *str1,*str2;
{
    int test;
    test = 0;
    while ((*str1) && (test = (*str1++ == toupper(*str2++))));
    return(test);
}

 /* * * * * * * * * * * * * * * * * * * * * * * *  */
 /* substring says if str1 is a substring of str2  */
 /* * * * * * * * * * * * * * * * * * * * * * * *  */

substring(str1,str2)
char *str1,*str2;
{
    int result;
    result = 0;
    while ((*str2) && !(result = prefixed(str1,str2++)));
    return(result);
}

 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
 /* do1log handles the file mail:1-mmailr.log checking it for local mail */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */

void do1log()
{
    FILE *logfile;
    char buffer[512];
    int num;
    char datebuffer[20];

    if ((logfile = fopen("mail:1-mmailr.log","r")) == NULL)
	{
	    printf("\ncould not open mail:1-mmailr.log for reading\n");
	    return;
	}
    num = fscanf(logfile,"%s",datebuffer);
    printf("\n*************");
    printf("\n* %9s *\n",datebuffer);
    printf("*************\n\n");
    while (!feof(logfile))
      {
	  num = fscanf(logfile,"%*s%*s%*[ \t):]%[^\n]%*c",buffer);
	  if (prefixed("DAEMON WAKEUP",buffer))
	     {
	     lclwakeups++;
	     continue;
	     }
	 if (prefixed("PROCESSING OF RECIPIENTS DEFERRED UNTIL",buffer))
	     {
	     defcnt++;
	     continue;
	     }
	 if (prefixed("DONE, REQUEUED",buffer))
	     {
	     reqcnt++;
	     continue;
	     }
	  if (substring(": OK",buffer))
	      {
	      rcvcnt++;
	      if (prefixed("PS:<BBOARD>",buffer))
		  bbcnt++;
	      continue;
	      }
	  if (prefixed("FILE ",buffer))
	     {
	     lclusefull++;
	     if (substring("-MM-",buffer))
		 {
		 mmcnt++;
		 continue;
		 }
	     if (substring("-BABYL.",buffer))
		 {
		 babcnt++;
		 continue;
		 }
	     if (substring("-MAISER-",buffer))
		{
		maicnt++;
		continue;
		}
	     if (substring("-CHAOS-MAIL-",buffer))
		{
		chacnt++;
		continue;
		}
	     if (substring("-CAFARD-",buffer))
		{
		cafcnt++;
		continue;
		}
	     if (substring(".NEW-FILE-NOTIFICATION.",buffer))
		 {
		 dmpcnt++;
		 continue;
		 }
	     if (substring("--RETURNED-MAIL--",buffer))
		 {
		 rtncnt++;
		 continue;
		 }
	     if (substring("-ACCOUNT-",buffer))
		 {
		 actcnt++;
		 continue;
		 }
	     if (substring("-INQUIRE-",buffer))
		 {
		 inqcnt++;
		 continue;
		 }
	     if (substring("-SEND-",buffer))
		 {
		 sndcnt++;
		 continue;
		 }
	     if (substring("-SNDFIL-",buffer))
		 {
		 sdfcnt++;
		 continue;
		 }
	     if (substring("-HB-NOTICE-",buffer) ||
		 substring("-HAPPY-BIRTHDAY-",buffer))
		 {
		 bdycnt++;
		 continue;
		 }
	     printf("\nunknown sender : %s\n",buffer);
	     }
      }
}

 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
 /* do2log handles statistics for 2-mmailr.log to find network mail  */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */

void do2log()
{
    FILE *logfile;
    char buffer[512];
    int num;
    if ((logfile = fopen("mail:2-mmailr.log","r")) == NULL)
	{
	    printf("\ncould not open mail:2-mmailr.log for reading\n");
	    return;
	}
    while (!feof(logfile))
      {
	  num = fscanf(logfile,"%*s%*s%*[ \t):]%[^\n]%*c",buffer);
	  if (prefixed("DAEMON WAKEUP",buffer))
	     ntwwakeups++;
	  if (prefixed("FILE ",buffer))
	     ntwusefull++;
	 if (prefixed("PROCESSING OF RECIPIENTS DEFERRED UNTIL",buffer))
	     {
	     defcnt++;
	     }
	 if (prefixed("DONE, REQUEUED",buffer))
	     {
	     reqcnt++;
	     }
      }
}

 /* * * * * * * * * * * * * * * * * * * * * * * * * *  */
 /* do3log handles 3-mmailr.log to get retransmit data */
 /* * * * * * * * * * * * * * * * * * * * * * * * * *  */

void do3log()
{
    FILE *logfile;
    char buffer[512];
    int num;
    if ((logfile = fopen("mail:3-mmailr.log","r")) == NULL)
	{
	    printf("\ncould not open mail:3-mmailr.log for reading\n");
	    return;
	}
    while (!feof(logfile))
      {
	  num = fscanf(logfile,"%*s%*s%*[ \t):]%[^\n]%*c",buffer);
	  if (prefixed("DAEMON WAKEUP",buffer))
	     {
	      rtmwakeups++;
	     }
	  if (prefixed("FILE ",buffer))
	     {
	      rtmusefull++;
	     }
	 if (prefixed("PROCESSING OF RECIPIENTS DEFERRED UNTIL",buffer))
	     {
	     defcnt++;
	     }
	 if (prefixed("DONE, REQUEUED",buffer))
	     {
	     reqcnt++;
	     }
      }
}


 /* * * * * * * * * * * * * * * * * * * * * * * * * *  */
 /* outsats prints out the statistics that we found... */
 /* * * * * * * * * * * * * * * * * * * * * * * * * *  */

void outstats()
{
    printf("local wakeups :   %5d useful local wakeups :   %5d\n",
	   lclwakeups,lclusefull);
    printf("network wakeups : %5d useful network wakeups : %5d\n",
	   ntwwakeups,ntwusefull);
    printf("retrans wakeups : %5d useful retrans wakeups : %5d\n",
	   rtmwakeups,rtmusefull);
    printf("\nthere were %5d messages sent via MM\n",mmcnt);
    printf("there were %5d messages sent via Babyl\n",babcnt);
    printf("there were %5d messages sent via Internet SMTP\n",maicnt);
    printf("there were %5d messages sent via ChaosMail\n",chacnt);
    printf("there were %5d messages sent via Cafard\n",cafcnt);
    printf("there were %5d messages from Dumper\n",dmpcnt);
    printf("there were %5d messages from Mmailr (failed messages)\n",rtncnt);
    printf("there were %5d messages from Bday Daemon\n",bdycnt);
    printf("there were %5d messages from Watson\n",inqcnt);
    printf("there were %5d messages from Send\n",sndcnt);
    printf("there were %5d messages from Sndfil\n",sdfcnt);
    printf("there were %5d messages from Accounts\n",actcnt);
    printf("\n%d messages were requeued, of which %d were deferred\n",
	   reqcnt,defcnt);
    printf("\n%d local recipients, of which %d were bboards\n",rcvcnt,bbcnt);
}
