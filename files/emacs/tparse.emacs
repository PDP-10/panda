!* -*- Teco -*- *!

!*

   TPARSE: A library for parsing dates and times.

	   Created and maintained by KMP@MIT-MC.

   Although this library was written to help out KMP's ZBabyl library,
   it functions completely independently and may be suitable for other
   applications.

Modification History:

04/14/85 137	KMP	Installed as a standard Emacs library.
01/26/85 136	KMP	Made parser ignore text between parens since people
			 were starting to put real junk there.
12/05/83 135	KMP	Fixed 10 Dec 11pm to not think 11 was the year.
			 Does some reasonableness (>24) checking on the
			 second number before assuming it's a year.
			Added abbreviations "Thurs" and "Tues".
11/29/83 134	KMP	Fixed some minor bugs in defaulting mechanism.
10/28/83 133	KMP	Added this modification history by perusing
			 backup copies of sources that were still
			 online. Functionally same as version 132.
09/03/83 132	KMP	Added support for A, AN, HENCE, FROM.
			Fixed TWENTIETH, THIRTIETH, FORTIETH, and
			 FIFTIETH to work as they should have before.
09/03/83 128	KMP	Added support for AFTER, BEFORE, AGO, ON.
09/03/83 123	KMP	Introduced basic support for parsing relative
			 offsets from an absolute time. Also added support
			 for spelled-out numbers.
09/03/83 114	KMP	Beginning of prehistory...

 *!

!~Filename~:! !Time parser macros !
TPARSE

!& Setup TPARSE Library:! !S Setup TPARSE runtime environment !

 !* How does one check for daylight time? This is otherwise wrong !
 !* half of the year						  !

-4fo..Q Timezone_GMT_Offset m.v Timezone_GMT_Offset

 0fo..Q Timezone_EDT_Offsetm.v Timezone_EDT_Offset
 0fo..Q Timezone_EST_Offsetm.v Timezone_EST_Offset

 1fo..Q Timezone_CDT_Offsetm.v Timezone_CDT_Offset
 1fo..Q Timezone_CST_Offsetm.v Timezone_CST_Offset

 2fo..Q Timezone_MDT_Offsetm.v Timezone_MDT_Offset
 2fo..Q Timezone_MST_Offsetm.v Timezone_MST_Offset

 3fo..Q Timezone_PDT_Offsetm.v Timezone_PDT_Offset
 3fo..Q Timezone_PST_Offsetm.v Timezone_PST_Offset


:i*Monday   m.vDay_Monday_Value
:i*Monday   m.vDay_Mon_Value

:i*Tuesday  m.vDay_Tuesday_Value
:i*Tuesday  m.vDay_Tue_Value
:i*Tuesday  m.vDay_Tues_Value

:i*Wednesdaym.vDay_Wednesday_Value
:i*Wednesdaym.vDay_Wed_Value

:i*Thursday m.vDay_Thursday_Value
:i*Thursday m.vDay_Thu_Value
:i*Thursday m.vDay_Thurs_Value

:i*Friday   m.vDay_Friday_Value
:i*Friday   m.vDay_Fri_Value

:i*Saturday m.vDay_Saturday_Value
:i*Saturday m.vDay_Sat_Value

:i*Sunday   m.vDay_Sunday_Value
:i*Sunday   m.vDay_Sun_Value

1 m.vMonth_January_Value
1 m.vMonth_Jan_Value
:i*January m.vMonth_1_Name

2 m.vMonth_February_Value
2 m.vMonth_Feb_Value
:i*February m.vMonth_2_Name

3 m.vMonth_March_Value
3 m.vMonth_Mar_Value
:i*March m.vMonth_3_Name

4 m.vMonth_April_Value
4 m.vMonth_Apr_Value
:i*April m.vMonth_4_Name

5 m.vMonth_May_Value
:i*May m.vMonth_5_Name

6 m.vMonth_June_Value
6 m.vMonth_Jun_Value
:i*June m.vMonth_6_Name

7 m.vMonth_July_Value
7 m.vMonth_Jul_Value
:i*July m.vMonth_7_Name

8 m.vMonth_August_Value
8 m.vMonth_Aug_Value
:i*August m.vMonth_8_Name

9 m.vMonth_September_Value
9 m.vMonth_Sep_Value
9 m.vMonth_Sept_Value
:i*September m.vMonth_9_Name

10 m.vMonth_October_Value
10 m.vMonth_Oct_Value
:i*October m.vMonth_10_Name

11 m.vMonth_November_Value
11 m.vMonth_Nov_Value
:i*November m.vMonth_11_Name

12 m.vMonth_December_Value
12 m.vMonth_Dec_Value
:i*December m.vMonth_12_Name


!& Parse Date:! !S Parses a date/time string
With no precomma arg, uses current point to end of buffer.
With a precomma arg, uses that string.

Returns a string which is a parse of the given time.
An additional value (precomma) is returned which is 0 or a day of week string
if possible to determine!

 ff"n f[bbindw g() j '	    !* Maybe bind temp buffer	!

 [0[1[2[3 [S[M[H [D[O[Y [Q [W [P[N[X [R  !* Temp qregs			!

 -1uS -1uM -1uH			    !* Initialize Sec, Min, Hrs		!
 -1uD -1uO -1uY			    !*		  Day, Mon, Yrs		!
 -1uN				    !*	An unassigned number		!
 0uX 0uQ 0uR 0uW		    !* State (1 Time, 2 Date, 4 Dow)	!
 
 !Main!

 @f-_	
l
 .-z"e oRet '

 1a-("e fll oMain'

 1a-,"e c qO:"l qN:"l qD"l 
   qNuD -1uN''' oMain'		    !* Watch for MONTH DAY, YR		!

 .uP \u1 .-qP"n			    !* q1: a number (maybe)		!
   qN:"l oSyn'			    !*  Don't lose data			!
   q1uN oNum '			    !*  If so, update qN		!

 fwx0 fwl			    !* q0: Next word			!
  0fo..Q Month_0_Valueu1	    !* Look for Month name		!
   q1"n qN:"l qNuD -1uN'
        qX2uX			    !* Acknowledge part of date seen	!
        q1uO oMain'		    !*  Hack month			!
  0fo..Q Day_0_Valueu1	    !* Look for Day of Week name	!
   q1"n q1uW oMain'		    !*  Hack day of week		!
  f~0PM"e !Eve!
   qH"l qN"l oSyn' qN-12"g oSyn '
        qNuH -1uN'
     "# qN:"l oSyn ' '		    !* This might have meaning?		!
   qH-12"e 0uH '
   qH+12uH oMain '
  f~0AM"e !Morn!
   qH"l qN"l oSyn' qN-12"g oSyn '
        qNuH -1uN'
     "# qN:"l oSyn ' '		    !* Ditto				!
   qH-12"e 0uH '
   oMain'    
 f~0the"e oMain'
 1000 fo..Q Timezone_0_Offsetu1 q1-1000"n q1+qQuQ oMain '
 f~0at"e oMain'
 f~0in"e oMain'
 f~0on"e oMain'

 f~0st"e oDate-End '
 f~0nd"e oDate-End '
 f~0rd"e oDate-End '
 f~0th"e oDate-End '

 f~0o"e qN:"l !"! fwf~'clock"e fwl qNuH qX1uX -1uN oMain '''
 f~0a"e oMain '


 f~0noon"e      qX&1"n oSyn ' 12uH 0uM 0uS qX1uX oMain '

 f~0now"e	  qX1uX oMain '
 f~0today"e		  oMain '
 f~0tomorrow"e   qQ+24uQ oMain '
 f~0yesterday"e  qQ-24uQ oMain '

 f~0hence"e qX1uX :i0after '    !* Simulate the effect of AFTER NOW !

 (f~0after"'e)(f~0from"'e)"n qN:"l oSyn '  qR+qQuQ 0uR oMain '
 (f~0ago"'e)(f~0before"'e)"n qN:"l oSyn ' -qR+qQuQ 0uR oMain '

 f~0of"e qR:"g oMain ' qR/24*24-qR"n oSyn '
   qR-24+qQuQ 0uR oMain '

 (f~0wk"'e)(f~0wks"'e)(f~0week"'e)(f~0weeks"'e)"n 
   qNf"lw1'*168+qRuR -1uN oMain'
 (f~0dy"'e)(f~0dys"'e)(f~0day "'e)(f~0days "'e)"n
   qNf"lw1'* 24+qRuR -1uN oMain'
 (f~0hr"'e)(f~0hrs"'e)(f~0hour"'e)(f~0hours"'e)"n
   qNf"lw1'    +qRuR -1uN oMain'

 (f~0afternoon"'e)(f~0evening"'e)(f~0night"'e)(f~0late"'e)"n oEve '
 (f~0morning"'e)(f~0early"'e)"n oMorn '

 !* This stuff comes last since it is slowest... !

 qN"l
  (f~0 fifty   "'e)(f~0 fiftieth "'e)"n 50uN o CK units'
  (f~0 forty   "'e)(f~0 fortieth "'e)"n 40uN o CK units'
  (f~0 thirty  "'e)(f~0 thirtieth"'e)"n 30uN o CK units'
  (f~0 twenty  "'e)(f~0 twentieth"'e)"n 20uN o CK units'
  oNoTens
  !CKunits!
  0,1a--"e c 0,1a"a .,(fwl.)x0 oUnits '' oNum 
  !NoTens!
  (f~0 nineteen  "'e)(f~0 nineteenth  "'e)"n 19uN '
  (f~0 eighteen  "'e)(f~0 eighteenth  "'e)"n 18uN '
  (f~0 seventeen "'e)(f~0 seventeenth "'e)"n 17uN '
  (f~0 sixteen   "'e)(f~0 sixteenth   "'e)"n 16uN '
  (f~0 fifteen   "'e)(f~0 fifteenth   "'e)"n 15uN '
  (f~0 fourteen  "'e)(f~0 fourteenth  "'e)"n 14uN '
  (f~0 thirteen  "'e)(f~0 thirteenth  "'e)"n 13uN '
  (f~0 twelve    "'e)(f~0 twelfth     "'e)"n 12uN '
  (f~0 eleven    "'e)(f~0 eleventh    "'e)"n 11uN '
  (f~0 ten       "'e)(f~0 tenth       "'e)"n 10uN '
  !Units!
  (f~0 nine      "'e)(f~0 ninth       "'e)"n qN"l 0uN ' qN+9uN '
  (f~0 eight     "'e)(f~0 eighth      "'e)"n qN"l 0uN ' qN+8uN '
  (f~0 seven     "'e)(f~0 seventh     "'e)"n qN"l 0uN ' qN+7uN '
  (f~0 six       "'e)(f~0 sixth       "'e)"n qN"l 0uN ' qN+6uN '
  (f~0 five      "'e)(f~0 fifth       "'e)"n qN"l 0uN ' qN+5uN '
  (f~0 four      "'e)(f~0 fourth      "'e)"n qN"l 0uN ' qN+4uN '
  (f~0 three     "'e)(f~0 third       "'e)"n qN"l 0uN ' qN+3uN '
  (f~0 two       "'e)(f~0 second      "'e)"n qN"l 0uN ' qN+2uN '
  (f~0an)(f~0a)(
   f~0 one       "'e)(f~0 first       "'e)"n qN"l 0uN ' qN+1uN '
  qN:"l oNum ''

 !Syn!

 :i*SYN	Syntax_error_in_time_specfserr

 !Date-End!

 qN"g qN-32"l qNuD -1uN qX2uX oMain''
 oSyn 

 !Num!				    !* qN must have a number in it	!
				    !*  if a go is done to this tag.	!

 qN-1899"g qY"l qN-1900uY -1uN qX2uX oMain''

 .-qP-3"l
  0,1a-:"e 
   qX&1"n oSyn ' qX1uX 
   qN-24"g oSyn '
   qNuH -1uN c \uM 
   0,1a-:"e c \uS '"# 0uS '
   oMain'
  (0,1a-/)*(0,1a--)"e
   qX&2"n oSyn ' qX2uX
   c .uP \u0 .-qP"e oNotDate '
   qN-12"g oSyn '
   qNuO -1uN q0uD
   (0,1a-/)*(0,1a--)"e c \uY '"# 0uY '
   oMain''

 !NotDate!
 qD:"l qO:"l qY"l qN-24"g qNuY qX2uX -1uN oMain''''

 qY:"l qO:"l qD:"l
  qX&1"e .-qP-2:"g qN-25"l oMain ''
         qN/100uH qN-(qH*100)uM 0uS qX2uX -1uN oMain ''''

 qO:"l qD"l (qX&1"'n)*((qH:"'l)*(qM:"'l)*(qS:"'l)"'e)"e 
    qNuD qX2uX -1uN oMain '''
 

 oMain

 !Ret!

 qN:"l
  qD"l         qNuD -1uN qX2uX oDefaults '
  qY"l qY-24"g qNuY -1uN qX2uX oDefaults ''
  qH"l         qNuH -1uN qX1uX oDefaults '
  :i*NOP	Number_out_of_placefserr '

 !Defaults!

 f[bbind			    !* Bind fresh buffer		!
 fsdatefsfdconv		    !* Get current date in buffer	!
 qX&1"n qH"l qM"l qS"l		    !* If time marked but not given,...	!
  9j \uH c \uM c \uS''''
 qS"l 0uS' qM"l 0uM' qH"l 0uH'	    !* Default time			!
 qY"l qO"l qD"l qX&2"n oToday''''  !* Force today default in some cases!
 qX&2"e				    !* If date not given		!
  !Today! j \uO c \uD c \uY'	    !*  use today			!
 qY"l 6j\uY '			    !* Default year is current		!
 qO"l qD:"l j\uO '		    !* If date given, default this month!
	 "# 1uO ''		    !*  else use January		!
 qD"l 1uD '			    !* Default date is the 1st		!

 hk				    !* Empty buffer			!

 qQ"n
  1+(2*(qQ"'g))u0		    !* q0: 1 or -1			!
  qH+qQuH			    !* Affect hours			!
  < 1,m(m.m &_Normalize_Date)
    qH:"l qH-24"l 0; ''		    !* Check date out of bounds		!
    24*q0+qHuH			    !* Normalize hours			!
    qD-q0uD 0uW >'		    !* and affect date			!

     qO-10"l i0 ' gO i/ qD-10"l i0 ' gD i/ qY-10"l i0 ' gY 
 i_ qH-10"l i0 ' gH i: qM-10"l i0 ' gM i: qS-10"l i0 ' gS

 m(m.m&_Date_to_DOW)[X		    !* Get DOW in qX		!
 qW"e qXuW '			    !* Maybe just use that DOW	!
   "# 0,3:gW[0 f~X0"n
      hx*[1 
      !"!
      :i*DDM	Day/Date_Mismatch:__Isn't_it_X,_1_rather_than_0fserr ''

 qW,(hx*)			    !* Return !


!& Normalize Date:! !& Correct for date underflow/overflow. 
Expects date in qY,qO,qD and day of week (if any) in qW !

 qD"g qD-29"l 0  ''		    !* If qD is in safe range, just return  !
 m(m.m &_Date_to_DOW)[TuT	    !* T: Target Day of week		    !
 [X				    !* Temp qreg			    !
 qD:"g				    !* If qD is smaller than 1,...	    !
  qO-1uO 28uD			    !* O: Previous month		    !
  qO"e 12uO qY-1uY '		    !* Hack qO,qY if crossing year bound    !
  m(m.m &_Date_to_DOW)uXuX	    !* X: New day of week number	    !
  qT-qX"l qT+7uT '		    !* Make sure qT is greater than qX	    !
  qD+qT-qXuD'			    !* D: Normalized date		    !
 "# [Y[O[D			    !* Else,... Bind temps		    !
  1uD qO+1uO qO-13"e 1uO qY+1uY '   !* Select day 1 of subsequent month	    !
  m(m.m &_Date_to_DOW)uXuX	    !* X: Day of week for that day	    !
  qX-qT"e ]*]*]* ''		    !* If same day of week, keep D,O,Y	    !
 				    !* Return				    !


!& Compare Dates:! !S Compares two date strings as numeric arg1 and arg2.
Returns 0 if the dates are the same, 1 if in the right order, and -1 if
they are in reverse order!

 f[bbind			    !* Temp buffer		!
 [1[2
 hk g() j			    !* Get into buffer		!
 m(m.m &_Parse_Date)u1		    !* Parse date 1		!
 hk g1 j fsfdconvu1		    !*  and convert format	!
 hk g() j			    !* Get into buffer		!
 m(m.m &_Parse_Date)u2		    !* Parse date 2		!
 hk g2 j fsfdconvu2		    !*  and convert format	!
 q2-q1"e 0 '			    !*  0 = Same		!
 q2-q1"g 1 '			    !*  1 = in order		!
 -1 				    !* -1 = reversed		!


!& Date to DOW:! !& Returns a day index and day of week string for a date
Expects its arguments to be set up in qY (Year), qO (Month), and qD (Date)!


qO-14/12+(1900+qY)[A		    !* qA: Magic temp	!
qO+10/(-13)*12+10+qO*13-1/5+qD+77[B !* qB: Temp		!
qA-(qA/100*100)*5/4[C		    !* qC: Temp		!
qA/(-2000)+(qA/400)+(qA/(-100)*2)+qC+qBuB
qB-(qB/7*7)uB
qB,( qB*3uB qB,(qB+3):g(:i*SunMonTueWedThuFriSat) )

