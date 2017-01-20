!*   -*-TECO-*-!
!* <GERGELY>LPTLIB.EMACS.26, 29-May-83 02:35:01, Edit by GERGELY!
!* <GERGELY.EMACS>LPTLIB..45, 29-Apr-80 19:10:59, Edit by GERGELY!

!~FILENAME~:! !Macros for use on the line-printer!
LPTLIB

!& Setup LPTLIB Library:! !S Module for preliminary setup!

    :I*FO..Q Print_Old_Library[B  !* QB gets the old print library!
    :I*FO..Q Print_Library[A	    !* QA gets the current one!
    F~ALPTLIB"N QA'"# QB' M.V Print_Old_Library    !* If already the!
				    !* same one then use the old one!
    :I*LPTLIB M.VPrint_Library    !* Create the variable to be sure!
    M.CPrint_Library*_Filename_of_the_Library_containing_the_PRINT_macros.
    ]A ]B

    80FO..Q Print_Width(
	)M.CPrint_Width*_Default_width_for_@_List_output.
    58FO..Q Print_Length(
	)M.CPrint_Length*_Default_length_for_@_List_output.
    0FO..Q Print_Format(
	)M.CPrint_Format*_Non-zero_for_paper_conservation.
    

!@ List:! !Print File:! !C Make LPT listing of a given file or of the buffer
replacing control-character by tilda-character.  The second string
argument is the alternate output device.

    The command can be in one of the following forms:

        <page size>,<page width> MM @ LIST$<filename>$<output device>
	                       via TECO in Minibuffer.
or
	<page width> MM @ LIST$<filename>$     , Otherwise

	         with following defaults:
		 <page width> -- Explicit 0 = minimum( maximum line width, 132)
		                 No argument = 80 characters wide
		 <page size>  -- 58 lines (3-heading, 55-text)
		 <filename>   -- the currently accessed buffer
                 <output device> -- LPT:    

    Two variables are referred to.  These are:
	Q$Default Listing Width$ -- The default output listing. = 80.
       Q$Default Listing Length$ -- The default page length. = 58.
	 Q$Default Listing Type$ -- Nonzero implies a special miserly
				    output listing.  Only needed if
				    you don't want a new page on every
				    occurrence of Q$Page Delimiter$ = 0.!
    1 FS ECHO FLUSH
    [A HXA			    !* STORE THE WHOLE BUFFER IN QA IN!
				    !* CASE!
				    !* NO FILENAME IS GIVEN AS AN!
				    !* ARGUMENT!
    FS RUNTIMEUB		    !* STORE THE CURRENT RUNTIME IN!
				    !* QB!
    F[ B BINDW F[ D FILEW -1F[ FNAM SYNTAX [0 [1 [2 [3 [4 [5 [6 [7 [8 [9
    [..0 [..1 [..2 0[M		    !* [PJG] QM contains the FORTRAN flag!
    [D [E [F [G [P		    !* QP will hold the page!
				    !* delimiter!
    E\ E[ FN E] E^                 !* PUSH INPUT AND OUTPUT AND!
				    !* ARRANGE TO POP! 
    f[BBIND			    !* MAKE A TEMPORARY BUFFER!
    G(QPAGE_DELIMITER)	    !* GET THE VARIABLE AND FOR EACH !
    J<:S; 13I10I>		    !* ALTERNATIVE, HAVE IT START WITH!
				    !* A CRLF!
    HFXP F]BBIND
    32< IZU..2 >                   !* MAKE AN F^A DISPATCH TO STOP ON!
				    !* CTL CHARS.!
    95*5,32I
    IZU..2                         !* RUBOUT COUNTS AS CTL CHAR.!
    15.*5F_____                  !* CR, LF, TAB, FF AND ALTMODE DO!
				    !* NOT.!
    12.*5F_____
    11.*5F_____
    14.*5F_____
    33.*5F_____
    HFX2                            !* STORE WHOLE THING IN Q2!
    
    :F"L			    !* If called from the internals!
				    !* or!
				    !* a key!
	:i*CList_the_Current_Bufferfsechodisp0fsechoactive
	1,1M(M.M &_Yes_or_No)"N 0[C oNo_File''
    5,F List_File[C		    !* QC gets the filename if any.!
!No_File!
    FQC"G			    !* CHECK TO SEE IF A FILENAME WAS!
				    !* GIVEN!
	E?C"N :I*CNon-existent_File.__Aborting_list_function.
	    fsechodisp 0fsechoactive 0ua '
	ERC			    !* RETURN THE FILENAME IN THE!
				    !* STRING BUFFER!
	HK I__ G(FS I FILE) I____	    !* GET STRING FILENAME!
	0,FS IF CDATE FS FD CONV  !* GET CREATION DATE OF FILE IN!
				    !* STRING!
				    !* BUFFER!
	HFX8			    !* Q8 GETS THE HEADER!
	0UA @Y' "#		    !* READ IN THE FILE OF MACROS!
	HK I__
	:i*FO..QBuffer_FilenamesuC	    !* [PJG] Use the current!
				    !* buffer filename!
	FQC:"G ICurrent_Buffer_Name_Unknown	    !* [PJG] If not!
						    !* known,!
	    :iCNONAME'
				    !* then say so!
	"# GC '			    !* [PJG] Otherwise use it.!
	I____
	0,FS DATE FS FD CONV	    !* GET CURRENT DATE!
	HFX8			    !* Q8 GET THE HEADER!
	GA W J 0ua'		    !* RESTORE THE BUFFER FROM QA!
    0FO..QOutput_To"E M.VOutput_To'	    !* New variable to keep!
    "# 0UOutput_To'
				    !* the filename if any!
    3,F Output_to_(Default:_LPT:)_[O
    fqo:"G :IOLPT:'		    !* QO GETS AN ALTERNATE OUTPUT!
				    !* DEVICE!
    "#  f[bbind
	go j <:s:+1;w1c>
	!<!	  <:S>+1;w1c>
	0XO			    !* [PJG] QO gets the structure!
				    !* and!
				    !* directory! 
	.,(<:S.+1;w1C>W
	    1,0a-46"E 1r'"#:l'.)XOutput_To
	f]bbind '
    FQOutput_To:"G
	f[bbind
	GC j <:s:+1;w1c>
	!<!   <:S>+1;w1c>
	0K			    !* [PJG] QO gets the structure!
				    !* and!
				    !* directory! 
	.,(<:S.+1;w1C>W
	    1,0a-46"E 1r'"#:l'.)XOutput_To
	f]bbind'

    WF~(FSDFN2)FOR"'E(	    !* [PJG] Check what extension it has!
	WF~(QMODE)FORTRAN "'E)"N !* [PJG] Check what mode he is in!
	1UM BJ			    !* [PJG] Set the Fortran Flag!
	M(M.M Strip_SOS_Line_Numbers)'    !* [PJG] In case of EDIT line!
				    !* [PJG] numbers!
	
    ZJ 13I10I			    !* MAKE SURE WE END WITH A CRLF!
                                    !* LOOP BELOW FAILS TO CONVERT CTL!
				    !* CHAR AT!
				    !* END OF THE BUFFER!
    58FO..QPrint_LengthU0
    80FO..QPrint_WidthU1	    !* Q0 IS THE PAGE LENGTH, AND Q1!
				    !* IS THE PAGE SIZE!
    FFF"N-2:"L U0' U1'	    !* Q0 CAN ONLY BE SPECIFIED BY A!
				    !* PRE-COMMA ARGUMENT!
    Q0-4"L
	58FO..QPrint_LengthU0'	    !* IF Q0 IS LESS THAN 4 RESET THE!
				    !* PAGE LENGTH!
    0FO..QPrint_Format"N
	Q0-58"E W60u0' '
    Q0-3U0                          !* HEADER TAKES 3 LINES!
    J < .,ZF2 .-Z;                !* SKIP TO NEXT CTL CHAR TO!
				    !* CONVERT!
	0A(-D I~)#100.I>	    !* CONVERT CONTROL-MUMBLE TO TILDA!
				    !* AND!
				    !* MUMBLE.!
    J 0S
 <:S; R-DI~M>      !* CONVERT STRAY CARRIAGE RETURNS!
    J 0S
 <:S; -DI~J>     !* CONVERT STRAY LINE FEEDS.!
    J <:S; -DI$>               !* CONVERT ALTMODES TO DOLLAR!
				    !* SIGNS.!
    J <:S
; -DI~L>	    !* CONVERT NON FIRST CHAR FF ON A LINE!
    Q1-1"L                          !* FIND MAX PAGE WIDTH IF Q1=0!
	J<.-Z; W:L
	    FSHPOSITION-Q1F"G+Q1U1'
	    L>
	q1-40"L 40U1'		    !* IF WIDTH TO SMALL SET TO 40!
				    !* CHARS!
	Q1-132"G @FTText_Width_Exceeds_Width_of_Physical_Device
	     0FS ECHO ACTIVE
	    132u1'
	Q1-1/10+1*10 U1'	    !* PAGE WIDTH ROUNDED UP TO!
				    !* NEAREST TEN!
    J G8 13I10I			    !* INSERT TITLE!
    -2C FQ8-Q1+15"G
	0L Q1-15C:K' "#
	Q1-15-FQ8<I_>'             !* LET THE TITLE!
    I_Page_			    !* BE THE PAGE WIDTH MINUS 15!
				    !* CHAR. LONG !
    0FX8 2D
    J <.-Z; :L			    !* WRAP LINES GREATER THAN Q1!
	FSHPOSITION U9 0L	    !* PLACE WIDTH BACK IN Q9!
	Q9-1/Q1 F"G<W<FSHPOSITION-Q1; 1C>13I10I>'
	L>
    0U2 0U4                         !* Q2 PAGE NUMBER, Q4 MAXIMUM NAME!
				    !* LENGTH!
    0U9                             !* Q9 WILL CONTAIN THE SUBPAGE IF!
				    !* NECESSARY!
    FS B CONSU3                    !* CONS UP A NEW BUFFER IN Q3!
    0U7                             !* Q7 GETS STARTING LOCATION OF!
				    !* THE!
                                    !* INFORMATION TO BE PLACED IN THE!
				    !* VIRTUAL!
                                    !* BUFFER!
    J <.-Z; %2 0U9                  !* INCREMENT THE PAGE COUNT,!
				    !* RE-INIT!
				    !* SUBPAGE!
	C :S
	P : .-FSZ"N 2C'	    !* POSITION AT NEXT FF OR END OF!
				    !* FILE!
	Q7,. FS BOUND              !* FORM THE VIRTUAL BUFFER TO BE!
				    !* USED!
	0U7                         !* RE-USE Q7 TO COUNT THE NUMBER!
				    !* OF LINES!
				    !* IN THIS BUFFER!
	J<:S
;%7>               !* LOOP TO COUNT LINES!
	J B"N 1A-12"N 12I R' C'
	G8 Q2\ W 3<I
	    >			    !* INSERT MAIN HEADER!
	q7-1-Q0"G
	    0U9 Q7-1/Q0<            !* MAKING Q7-1 /Q0 +1 SUBPAGE WITH!
				    !* TITLES!
		Q0L 0L 12I          !* GO TO SUBPAGE AND INSERT FF!
		%9                  !* INCREMENT SUBPAGES!
		G8 Q2\ W I:        !* INSERT HEADER WITH THE PAGE!
				    !* COUNT!
		Q9\ W 3<I
		   > > '	    !* INSERT THREE CRLF TO MAKE THE!
				    !* HEADER!
	QM"N OFORTRANTAG'
	J <:S:!; .(		    !* FIND NAME OF THIS PAGE!
				    !* (COLON-EXCL) !
		.-2(.-2u5 0L.UA Q5J
		   -:S!"L	    !* SEARCH FOR THE MATCHING!
				    !* EXCLAMATION!
				    !* ON THE LINE!
		      C .-QA"LQ5J '  '	    !* IF FOUND AND NOT ON THE!
					    !* LINE REPLACE!
		   .,)X5	    !* THE POINTER , OTHERWISE PUT!
				    !* LABEL INTO!
				    !* Q5 !
		FQ5"G		    !* IF THERE IS A LABEL THEN DO...!
		   [..O Q3U..O	    !* SELECT TABLE OF CONTENTS!
				    !* BUFFER.!
		   FQ5-Q4"G FQ5U4 ' !* REMEMBER THE LENGTH OF THE!
				    !* LONGEST NAME.!
		   Q2\ 40.I G5 13I 10I	    !* PUT PAGE NUMBER SPACE!
					    !* NAME CRLF.!
		   ]..O '	    !* ... END THE LABEL LOOP!
		)J >
	O END-OF-TAGS
	
	!FORTRANTAG!		    !* Start of FORTRAN tags!
				    !* which are:               !
				    !* PROGRAM  SUBROUTINE  FUNCTION!
				    !* REAL FUNCTION, INTEGER!
				    !* FUNCTION!
				    !* LOGICAL FUNCTION, COMPLEX!
				    !* FUNCTION!
				    !* OVERLAY, BLOCK DATA!
				    !* DOUBLE PRECISION FUNCTION!
	J< !AGAIN! :SPROGRAMSUBROUTINEOVERLAYBLOCKFUNCTION UF
				    !* Main Tags!
	    QF; QF+4"G 0L 1M(M.M ^R_READ_WORD)UG
		WF~GPROGRAM"E OHAVEIT'
		WF~GSUBROUTINE"E OHAVEIT'
		WF~GOVERLAY"E OHAVEIT'
		1@L OAGAIN '
	    "# 0L 1M(M.M ^R_READ_WORD)UG
		WF~GFUNCTION"E OHAVEIT'
		WF~GBLOCK"E 1M(M.M ^R_READ_WORD)UG
		   WF~GDATA"E OHAVEIT'
		   1@L OAGAIN '
		WF~GINTEGER"E 1M(M.M ^R_READ_WORD)UG
		   WF~GFUNCTION"E OHAVEIT'
		   1@L OAGAIN '
		WF~GREAL"E 1M(M.M ^R_READ_WORD)UG
		   WF~GFUNCTION"E OHAVEIT'
		   1@L OAGAIN '
		WF~GCOMPLEX"E 1M(M.M ^R_READ_WORD)UG
		   WF~GFUNCTION"E OHAVEIT'
		   1@L OAGAIN '
		WF~GLOGICAL"E 1M(M.M ^R_READ_WORD)UG
		   WF~GFUNCTION"E OHAVEIT'
		   1@L OAGAIN '
		WF~GDOUBLE"E 1M(M.M ^R_READ_WORD)UG
		   WF~GPRECISION"E 1M(M.M ^R_READ_WORD)UG
		      WF~GFUNCTION"E OHAVEIT' ' '
		1@L OAGAIN '
	    !HAVEIT!
	    0L :S; R.,(
		:S(
		    ; FKC .)X5
		FQ5"G		    !* IF THERE IS A LABEL THEN DO...!
		   [..O Q3U..O	    !* SELECT TABLE OF CONTENTS!
				    !* BUFFER.!
		   FQ5-Q4"G FQ5U4 ' !* REMEMBER THE LENGTH OF THE!
				    !* LONGEST NAME!
		   Q2\ 40.I G5 13I 10I	    !* PUT PAGE NUMBER SPACE!
					    !* NAME CRLF.!
		   ]..O '	    !* ... END THE LABEL LOOP!
		>
	    !END-OF-TAGS!
		Q0-55"G
		   0FO..QPrint_Format"E
		      J<:S
;-D19I>'
		   "# Q0-57"G J<:S
;-D19I>'''
				    !* IF PAGE SIZE > 58 MAKE!
					    !* CONT. PAGING!
	    ZJ .U7 0,FS ZFS BOUND>        !* END OF ALL CONVERSIONS!
	Q4F"G+2U4 [..O Q3U..O 0U5   !* Q4 WIDTH OF NAME FIELD IN TABLE!
				    !* OF!
				    !* CONTENTS.!
	    J<.-Z; .U7 %5	    !* LOOP OVER EACH LINE, Q5 COUNTS!
				    !* LINES.!
		\UD C0K:L	    !* EXTRACT PAGE NUMBER.!
		Q4-.+Q7,56.I QD\ L> !* AFTER NAME PUT DOTS AND PAGE!
				    !* NUMBER.!
	    J   :L  L 	    !* SORT !
	    Q4-36"L ZJ		    !* IF FITS IN 2 COLUMNS ON 80-WIDE!
				    !* PAGE...!
		Q4+6U4 Q0-1U0	    !* Q4 GETS WIDTH OF COLUMN 1.!
		Q0*2*((Q5+Q0*2-1)/(Q0*2))-Q5<15.I12.I>      !* MAKE!
				    !* [PJG] EXACT MULTIPLE OF!
				    !* PAGE SIZE.!
		J<.-Z;		    !* LOOP OVER PAGES.!
		   Q0< .U7 Q0L :X5 Q7J :L   !* LOOP OVER COL 1 LINES,!
					    !* Q5 GETS COL 2!
				    !* LINE.!
		      Q4-.+Q7,40.I G5 L>    !* PUT COL 2 LINE TO RIGHT!
					    !* OF COL 1 LINE.!
		   Q0K 14.I15.I12.I> -D '   !* DELETE ALL THE COLUMN 2!
					    !* LINES.!
	    ]..O ZJ 14.I15.I12.I
	    .-3U7		    !* SINCE WE HAVE A CRLF AFTER THE!
				    !* FF! 
	    G3			    !* INSERT CONTENTS AT END OF!
				    !* FILE.!
	    Q3 FS B KILL
	    ZJ -:S."N L.,ZK'	    !* DELETE TRAILING BLANK LINES.!
	    q7j <.-Z; %2 0U9	    !* INCREMENT THE PAGE COUNT,!
				    !* RE-INIT!
				    !* SUBPAGE!
		C :S :	    !* POSITION AT NEXT FF OR END OF!
				    !* FILE!
		Q7,. FS BOUND	    !* FORM THE VIRTUAL BUFFER TO BE!
				    !* USED!
		0U7		    !* RE-USE Q7 TO COUNT THE NUMBER!
				    !* OF LINES!
				    !* IN THIS BUFFER!
		J<:S
;%7>	    !* LOOP TO COUNT LINES!
		J B"N  C'
		G8 Q2\ W 3<I
		   >		    !* INSERT MAIN HEADER!
		q7-1-Q0"G
		   0U9 Q7-1/Q0<	    !* MAKING Q7-1 /Q0 +1 SUBPAGE WITH!
				    !* TITLES!
		      Q0L 0L 12I    !* GO TO SUBPAGE AND INSERT FF!
		      %9	    !* INCREMENT SUBPAGES!
		      G8 Q2\ W I:  !* INSERT HEADER WITH THE PAGE!
				    !* COUNT!
		      Q9\ W 3<I
			> > '	    !* INSERT THREE CRLF TO MAKE THE!
				    !* HEADER!
		Q0-55"G
		   0FO..QPrint_Format"E
		      J<:S
;-D19I>'
		   "# Q0-57"G J<:S
;-D19I>'''
				    !* IF PAGE SIZE > 58 MAKE!
					    !* CONT. PAGING!
		ZJ .U7 0,FS ZFS BOUND>    !* END OF ALL CONVERSIONS!
	    '			    !* FILE SHOULD NOW BE COMPLETE FOR!
				    !* LISTING!
	0FO..QPrint_Format"N	    !* If the user wants the!
					    !* special miserly type listing!
	    J<:S
;			    !* From the top replace all FF!
		-D q1-1,61I	    !* with a line of  equal signs!
		13i 10i		    !* Put in a CRLF!
		1l 2K		    !* Go to the next line and kill 2!
				    !* blank ones!
		q1-1,45I	    !* Put in the line of minuses!
		0,1a-13"N13I'"# 1c' !* Put in the CRLF if it is needed!
		0,1a-10"N10I'"# 1c'
		2R>
	    '


	0[2			    !* Q2 will be used for the!
				    !* filename!
	FQOutput_To:"GFSDFN1:F6'"#QOutput_to'[1
	F~OLPT:"N
	    :I2O1.LST.0'
	"# :I2lpt:;1'	    !* EITHER SECOND STRING OR LPT:  !
	]1
	EW2
	PW EF			    !* WRITE OUT TO THE DEVICE!
				    !* SPECIFIED  !
	fsofileu2
	:i*Cfsechodisp 0fsechoact
	@ftOutput_to_2_Completed_in_	    !* PUT IN THE MODE THE!
					    !* AMOUNT OF TIME IT!
	]2			    !* Pop is out again, just in case!
	@:(FS RUNTIME-QB+500)/1000=@FT_sec.	    !* TOOK TO RUN!
						    !* THIS MACRO,!
	0FS ECHO ACTIVE  	    !* FOR THE USER'S BENEFIT.   ---THE END---!

!^R Read Word:! !^R Read the following word and return.
Negative Arguments make sense.!

[A [B				    !* Push temporary registers!
FF"E 1UA' "#UA'		    !* Default argument is 1!
QA FWL W -QAFWXB 
QB


!Copies to the Line Printer:! !C Prints <arg> copies of the buffer to LPT:,
    the output device!
[A[B[C[D			    !* PUSH TEMPORARY REGISTERS!
HXA				    !* GET THE WHOLE BUFFER!
FSDFILEUC
F[BBIND			    !* PUSH THE BUFFER!
FSDFN1UD			    !* QD GETS THE FIRST NAME OF THE FILE!
Ff"NUB'"# 1UB'		    !* DEFAULT ARGUMENT IS 1!
QB"G GA
QB-1F"G<			    !* CHECK IF MORE THAN 1 COPY!
  12I GA>			    !* INSERT ONE LESS COPY!
 '
M(M.M WRITE_FILE)LPT:D'
F]BBIND
M(M.MSET_VISITED_FILENAME)C


!& Kill LPTLIB Library:! !S Kill the variables used by the PRINT Library!

    M(M.M Kill_Variable)Print_Length
    M(M.M Kill_Variable)Print_Width
    M(M.M Kill_Variable)Print_Format

    QPrint_Old_LibraryF([A) UPrint_Library
    M(M.M Kill_Variable)Print_Old_Library
    1:<M(M.M &_Setup_A_Library)W>



!*
/ Local Modes: \
/ MM Compile: 1:<M(M.M^R Date Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)LPTLIBLPTLIB
1:<M(M.MDelete File)LPTLIB.COMPRS>W \
/ End: \
!
 