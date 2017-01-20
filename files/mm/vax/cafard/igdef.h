/* igdef.h - global definitions for IG programs in -*-C-*- */

/* debugsw values
        0 - disables debugging
	1 - enables some informatory debug messages
	2 - enables verbose debugging
*/

#define debugsw 1

#ifndef VMS
#define VMS 1
#endif

#define T20 0
#define SUN 0

#define max(a,b) ((a) >= (b) ? (a) : (b))
#define min(a,b) ((a) <= (b) ? (a) : (b))

#define space ' '
#define tab '\011'		/* tab char */
#define cr '\r'			/* carriage return */
#define lf '\012'		/* linefeed */
#define ff '\014'		/* formfeed */

#define S_MAX 256	        /* long string max */

#define TRUE 1
#define FALSE 0
