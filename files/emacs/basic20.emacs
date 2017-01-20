!* -*-TECO-*-!
!* <EMACS>BASIC20.EMACS.10, 21-Feb-83 15:17:22, Edit by GERGELY!
!* <GERGELY.EMACS>BASIC20..71,  9-May-80 11:40:31, Edit by GERGELY!

!~FILENAME~:! !Library of macros for editing programs written in BASIC20!
BASIC20

!& Setup BASIC20 Library:! !S Sets up for Basic20 Mode!
    0FO..Q BASIC20_Setup_Hook[0 fq0"G :M0'
    10 M.C BASIC20_Line_Number_Difference*_Line_increments
    100 M.C BASIC20_Starting_Line_Number*_Starting_Line_Number
    M.CBASIC20_Upper_Line_NumberValue_of_the_next_line_number_found.
    M.CBASIC20_Lower_Line_NumberValue_of_the_previous_line_number_found.


!BASIC20 Mode:! !C This module sets up EMACS for editing BASIC20 programs.
 The following definitions are made:
	TAB -- move past the line number if ahead of it
	       otherwise insert a tab
!
    M(M.M &_INIT_BUFFER_LOCALS)
    M(m.mMake_Local_q-register)..d
    1,32 M.L Comment_Column
    1,(:i*!) M.L Comment_Start
    1,(:i*) m.l Comment_End
    1,1M.LDisplay_ Matching_ ParenW	    !* Want matching )!
    100 M.L BASIC20_Starting_Line_Number
    10 M.L BASIC20_Line_Number_Difference
    0 M.LBASIC20_Upper_Line_Number
    0 M.LBASIC20_Lower_Line_Number
    1,(M.M ^R_Basic20_Tab) M.Q I
    Q.0,1M(M.M &_SET_MODE_LINE) BASIC20 

!& BASIC20 Auto Line Numbers:! !S Subroutine that gets the next line number!

    [a [b [c [d [N			!* Push temporary registers!
					!* QN:  Next line number value!
!* BASIC line number cannot exceed 5 characters positions therefore I make the!
!* assumption that infinity is 100000!

    100000 UBASIC20_Upper_Line_Number	!* Set + infinity for upper! 
    -100000 UBASIC20_Lower_Line_Number	!* Set - infinity for lower!

    .( 0@l w<.-b @;
	    0,1A"'D:;
	    -1@L>			!* Find first line with a number on it!
	\F(F"GUBASIC20_Lower_Line_Number'
	    )ub W)J			!* QB gets current line number!
    .(1@l w<.-z;
	    0,1A"'D:;
	    1@L>			!* Find first successive line with a no.!
	\F(F"GUBASIC20_Upper_Line_Number'
	    )UC W)J			!* QC gets next line number,!
						!* if any! 

    QB"E
	QC"E				!* IF NO LINE NUMBERS, THEN ... !
	    QBASIC20_Starting_Line_Number UN'
	"#
	    QC-QBASIC20_Starting_Line_Number-(
		)QBASIC20_Line_Number_Difference"G
		QBASIC20_Starting_Line_Number UN'
	    "# QC-(QBASIC20_Line_Number_Difference/2)UN' ''

    "# QC"E
	    QBASIC20_Line_Number_DifferenceUD
	    QB/QD*QD+QD UN'
	"# QC-QB-1F"G+1/2+QB UN'
	    "#WQB UN' ' '
    QN

!^R BASIC20 Tab:! !^R The definition for tab.
A positive numeric argument will insert that value as the line number
for the line.  A numeric argument of 0 will remove any line number,
while a negative one will either insert a line number (or a tab, if the
current position on the line is greater than 6).!

    -1[A				!* QA:  The argument!
    .[0					!* Q0:  The current point!
    .(:L .-Q0[2W)J			!* Q2:  The current point wrt the end!
					!*      of then line!
    M(M.M &_BASIC20_Auto_Line_Number)[N	!* QN is the next line number!
    FF"N UA'
    QA"L FShposition-7"G .,(9i .)'
	:L FS H Position"E QN UA'
	"# 0l 0,1a"D \ W OCheck-Tab' "#  QN UA'''
    0l \ W0K
    !Line-Number!
    QAF"G :\U0
	0K 5-FQ0 :"L
	    5-FQ0 F"G,48I'W G0'		!* Insert the number with preceding!
					!* zeroes!

	"# :I*C0_is_too_big_for_a_line_number. fsechodisp
	    0fs echoactive 0''

    !Check-Tab!
    0,1a-9F"E 1C OReturn'
    "# -23"E 1D''
    9I					!* Insert a tab!
    !Return!
    QA:"L  :L q2R'

    QA F"G
	QBASIC20_Lower_Line_Number-QA:"'L+(
	    QBASIC20_Upper_Line_Number-QA:"'G)"N
	    QA :\U0
	    QBASIC20_Lower_Line_Number:\[1
	    QBASIC20_Upper_Line_Number:\[2
	    :I*CLine_number_0_is_outside_the_range_(1,2).!*
	    !fsechodisp 0fsechoactive''

    

!Set Line Increment:! !C Set the Default line number increments.
The value of Q$Basic20 Line Number Difference$, which is also an option,
gets set to 10 by default or any positive argument if any were given.!

    10UBASIC20_Line_Number_Difference

    FF"N
	F"GUBASIC20_Line_Number_Difference''
    


!Set Starting Line Number:! !C Set the Default Starting Line number.
Resets the value of Q$BASIC20 Starting Line Number$ to either the
positive given argument or 100 if none given.!

    100UBASIC20_Starting_Line_Number

    FF"N
	F"GUBASIC20_Starting_Line_Number''



!Resequence BASIC20 Program:! !C Resequences the buffer if in BASIC20 mode.

NOTE: If for more than about 300 lines, it is suggested to use the
	RESEQ command in the BASIC Subsystem.

The first line number is set by Q$BASIC20 Starting Line Number$ and uses
Q$BASIC20 Line Number Difference$ as the difference between consecutive
lines.
	Given a positive argument, the resequencing is done
from the current location to the end of the file, updating ALL
entries, even if they appear before the current location.
	Given a negative argument, the resequencing is ONLY done
in the currently defined region. !

    FSRUNTIME[E		!* QE gets starting time!
    [A [B [C [D			!* push TEMPORARY Register!
    :I*`~[0			!* Q0 String identifier for processed line!
				!* numbers!
    F=(QMODE)BASIC20"N	!* If not in BASIC mode then return!
	W :I*CWrong_Mode fsechodisp 0FS ECHO ACTIVE '

    B[F 0[G Z[H 0[Y		!* QF gets the starting point!
    FF"N 0L.UF		!* no arg, then QF=BEG, otherwise QF=.!
	UG'			!* QG GETS THE ARGUMENT!
    QG"L M(M.M ^R_SET_BOUNDS_REGION)	!* IF ARG<0 then only do region!
	BUF ZUH'		!* QH gets the last location!
    QF,QHM(M.M &_Save_for_Undo)Buffer_Resequencing
    QG"L QF,QHFSBOUNDARIES '	!* Neg. Arg ==> region is the bounds!
    "# 0,fszfsboundaries'

    [..D			!* Push the dispatch table!
    F[BBIND			!* Push for a temporary buffer!
    34*5,32I 94<IA____> 0,.FX..D	!* Create the new DISPATCH table!
    F]BBIND			!* Back to the normal buffer!
    38 *5:F..D_____		!* ONLY COMMA SPACE AND CONTROLS CHAR.!
    44 *5:F..D_____
    92 *5:F..D_____		!* EXCLAMATION, & AND \ ARE !
    127*5:F..D_____		!* DELIMETERS INCLUDING RUBOUT!
    
    0[L				!* QL gets the number of lines to do!
    .(<.-z; W\ "N %Lw'w 1l>
	)J

    QBASIC20_Starting_Line_NumberUA	!* QA has current NEW line number!

    QBASIC20_Line_Number_DifferenceUB	!* QB gets the differences between!
				!* lines!

    (QL-1)*QB+QA-99999 F"G +99999 :\[L	!* Check for early problems!
	    :I*CLine_Numbers_[L]_will_exceed_the  !*
	    !  _allowed_maximum_of_99999.(
	    )fsechodisp
	]L (99999-QA)/(QL-1):\UL
	:I*AThe_maximum_line_increment_is_L.fsechodisp
	0fsechoactive
	qfj
	0,fszfsboundaries
	0'
    ]L				!* Pop this accumulator!
    J<:SFOR;		!* PREPARE FOR ... TO SEQUENCES!
	<:FB=TOSTEP ;
	    :FB "L 1R
		1A"D G0'' >	!* the insert to be made!
	>

    J <:SMARGINPAGEDATA;
	<:FB; 1R
	    1A"D G0'
	    1FWLW> >


    QFJ<:s00001	REM_00002	REM_;
	0l G0 wl>		!* Ignore all EDIT lines, if any!

    -1uK
	
    <.-Z;
	1A"D			!* If first character is a number, then DO!
	    QA:\ UC		!* QC gets the NEW line no. in characters!
	    \:\UD		!* QD Gets the old line number!
	    0K G0		!* Insert used number separator `~ !
	    5-FQCF"G,48I' W GC	!* Kill old line number and insert new one!
	    .(			!* If LINO or OLD NUMBER DELIMITED, than!
		J<:SLINO(D)D;	!* change the number to the!
				!* new one! 
		   R -FQDD W G0 GC> )J
	    QA+QBUA		!* Update QA!
	    QA-99999"G		!* if > 100000, the line numbers are out!
				!* of range and advise user!
		J <:S`~;FKD>	!* Strip `~ which is flag !
		W :I*C?_Cannot_Continue,_LINE_NUMBERS_are_too_big!*
		!fsechodisp 0FS ECHO ACTIVE	!* ERROR message!
		0,FSZFSBOUNDARIES
		''
	1@L
	FQC"G FQD"G !<!:I*AD_=>_Cfsechodisp0fsechoactive''
	>

    J 0S0 W <:S;FKD>	!* Strip QZ which is flag !
    :I*CResequencing_Complete_in_fsechodisp	!* PUT IN THE MODE THE!
				!* AMOUNT OF TIME IT!
    @:(FS RUNTIME-QE+500)/1000=@FT_sec.
    				!* TOOK TO RUN THIS MACRO,!
    0FS ECHO ACTIVE		!* FOR THE USER'S BENEFIT.   ---THE END---!
    QFJ
    0,FSZFSBOUNDARIES
    

!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)BASIC20BASIC20
1:<M(M.MDelete File)BASIC20.COMPRS>W \
/ End: \
! 