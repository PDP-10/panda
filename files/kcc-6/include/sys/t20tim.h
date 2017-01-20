/* <SYS/T20TIM.H> - definitions for TOPS-20/TENEX date/time jsys calls.
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _SYS_T20TIM_INCLUDED
#define _SYS_T20TIM_INCLUDED

/* TOPS-20/TENEX broken-down time value - 3 words used by the
**	IDCNV%, ODCNV%, IDTNC%, ODTNC% calls.
*/
struct _t20_tm {
	unsigned dt_year : 18;	/* AC2 LH: year */
	unsigned dt_mon : 18;	/*     RH: month (0 = Jan) */
	unsigned dt_day : 18;	/* AC3 LH: day of month (0 = 1st day) */
	unsigned dt_dow : 18;	/*     RH: day of week (0 = Monday) */
				/* AC4    */
	unsigned dt_icdsa : 1;	/*  B0	IC%DSA - Apply DST as per IC%ADS */
	unsigned dt_icads : 1;	/*  B1	IC%ADS - on if DST was applied */
	unsigned dt_icutz : 1;	/*  B2	IC%UTZ - Use timezone in IC%UTZ	*/
	unsigned dt_icjud : 1;	/*  B3	IC%JUD - on if Julian day fmt used */
	unsigned          : 8;	/*  B4-B11	*/
	int      dt_ictmz : 6;	/*  B12-B17 IC%TMZ - Zone (hrs west of GMT) */
	unsigned dt_ictim : 18;	/*  RH:	IC%TIM - local time in sec since mid */
};

#endif /* ifndef _SYS_T20TIM_INCLUDED */
