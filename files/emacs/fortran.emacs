!* -*- TECO -*-		Library created and maintained by KMP@MC !

!~Filename~:! !Winning macros for editing Fortran!
FORTRAN

!& Setup FORTRAN Library:! !S Define Initial Parameters for this library!

    0FO..QFortran_Indent_With_Tabs"E
	0M.CFortran_Indent_With_Tabs*_0=_Spaces,_1=_Tabs'
    041400000000.,fsdate:fsfdconvert(
	)M.CIdentification_Field_Text*_Text_to_be_insert_in_ID_field
    :FO..Q Compile_command"L		!* [PJG] Make sure we have a filename!
	0M.V Compile_command'		!* [PJG] for this mode!
    

!^R Fill Tab Field With Spaces:! !^R Look like Tab, but use spaces!
.[0				    !* Save initial point in q0!
fsshpos[1			    !* Save hpos in q1!
q1/8+1*8-q1<i_> 		    !* Fill spaces to next stop !
q0,.

!^R Show Columns:! !^R Show Current Line with column numbers above it!

    fsz"E '
    z"E '
    [s fstoplineus
    [a [b [c [d 
    :ia qaud
    .(0l :fb	"L
	z-."E :ic.....___'
	"# 1a"D 32:ia 46:id 9:ic' "# :ic.....___''
	9:ib '
    "# 6,32:ib :ic....._
	0l 5:c W 0,1a-32"N :ic_____.'')j
    :i*Ba7________________________________________________________________72[0
    :i*cd|--------------------------Program_Text--------------------------|...[1

    FSRGETTY"n
      @V FS^R VPOS-qs-3 f"g +qsfstopline
	 WFT
0
1 qsfstopline'
      "# +4+qs fstopline
	 WFT1
0
 qsfstopline ''

    "#
	 FT1
0
'
    

!Expand for Fortran:! !S Expand RLBs compressed fortran format to be readable
For use locally on MC only. ^S is a space efficiency hack. This routine will
search for Control-S, delete it and next char, using next chars ascii val
minus 32 as number of spaces to insert.!

[0[1
J < :S; rd 1a-32 f( w d ) < i_ >  >  !* Expand ^S<char> into spaces !
J < .-z;			         !* Loop truncating 72nd column !
    1f<!COMS!
      .u1 :l q1+7-."g l f;COMS' "# 0l'	 !* Exit if line obviously to short !
      < .-(q1+6);		         !* Exit at char 6 !
        1a-9"e 0;' c >		         !* Tab completes the label field !
      .u1			         !* Put current location in q1 !
      :l q1+66-."l q1+66,.k '	         !* If line is too long, kill some !
      l > >			         !* Go to next line !
J < .-z; :l 			         !* Loop going to end of each line !
    M(M.M ^R_Delete_Horizontal_Space)   !* Deleting trailing blanks!
    l > J			         !* Next line. Jump top when done. !
 

!^R Eliminate Fortran Comment Field:! !^R If on comment line, delete its text.
Comment lines have a C in column 1!
    .[0 FF"e 0l'		    !* If no arg, go to head of line !
    "# l'			    !* Else go arg lines forward !
    (-1,1a-C)*(-1,1a-c)*(-1,1a-*)"e   !* If on a comment (C,c,*)... !
      :K .-1,q0'		    !* Kill everything but the newline !
    "# q0j 0'			    !* Else go back where we started !

!^R Move to Next Fortran Comment Field:! !^R Move to next comment field
Moves to next Comment field. If there is no other comment field before
the end of buffer or the next statement, creates one on the next line.!

.-z"e iC 13i 10i 2r .-1,.+2 '
l .-z"e fsshpos"n 13i 10i iC 13i 10i 2r .-3,.+2'
                "# iC 13i 10i 2r .-1,.+1''
   "#
    (-1,1a-C)*(-1,1a-c)*(-1,1a-*)"n iC 13i 10i 2r .-1,.+2 '
    "# 1M(M.M^R_Move_to_Fortran_Comment_Field)''


!^R Move to Previous Fortran Comment Field:! !^R Move to prev comment field
Moves to previous Comment field. If there is no other comment field between
point and head of buffer or previous statement, creates one on the next line.!

0l .-b"e iC 13i 10i 2r .-1,.+2 '
-l (-1,1a-C)*(-1,1a-c)*(-1,1a-*)"n l iC 13i 10i 2r .-1,.+2 '
"# 1M(M.M^R_Move_to_Fortran_Comment_Field)'


!^R Move to Fortran Comment Field:! !^R Move to a Fortran comment line
If on a comment line, move to the head of it. If not on one, use preceding
line if it is one, else create one. !

    [9				    !* Put arg in q9 !
    0l (-1,1a-C)*(-1,1a-c)*(-1,1a-*)"e
	q9-1u9'			    !* One less if on a comment line already!
    q9:"g c 0'			    !* Exit if arg <= 0 !
    .[0				    !* Save initial point !
    0 FO..Q Comment_StartUC		!* Get comment begin!
    0 FO..Q Comment_BeginF"NUC'
    FQC :"G
	:I*CUC'
    "# F~C!"E :I*CUC' W0:GC:FC -C"N :ICCC''
    q9 < -l .-q0"e 13i10i 2r'	    !* Loop - Go back a line, then ...!
	(-1,1a-C)*(-1,1a-c)*(-1,1a-*)"n	    !* If not on a C then ...!
	    -1,1a-13"e GC r'	    !* If on a null line, insert a C !
	    "# l GC 13i 10i 3r''	>   !* Else insert C followed by CRLF !
    c .-1,q0 

!^R Fortran Continuation Line Next:! !^R Get new line, make it a continuation!
.[0 m(m.m ^R_CRLF)  
1m(m.m ^R_Indent_for_Fortran)w q0,. 

!^R Fortran Newline and Maybe Continuation:! !^R Newline plus tab.
If at end of line, tab for a new statement. Else tab for a continuation.!

.[0 @m(m.m ^R_Delete_Horizontal_Space) q0-."g .[0'
(-1,1a-13)*(-1,1a+1)"n m(m.m ^R_Fortran_Continuation_Line_Next)'
"# m(m.m ^R_CRLF)w Fm(M.M ^R_Indent_for_Fortran)'
q0,.

!^R Fortran Merge Continuation With Previous:! !^R Kill CRLF and indentation
Appends current line to previous.  Removes the conttinuation char.!
0l .-b"e 0' .+7u0		    !* Exit if first line !
-1m(m.m ^R_Indent_for_Fortran)	    !* Delete indentation !
-2d				    !* Delete CRLF !
z-q0"g .,q0' "# .,z'	    !* Return changed region !

!^R Indent for Fortran:! !^R Indent correctly for Fortran
With no arg, indent to column 7, removing contin char if found 
With positive arg, indent to column 6, putting a contin char there
With negative arg, remove indentation and contin char 

Fortran Continuation Character may be set to a fixnum corresponding
   to the ascii value of continuation character to be used.
   Default = 43 (Char. = +))

Fortran Indent With Tabs not 0 means use a tab to fill out
   the label field instead of spaces (Default = Spaces)!

FF-2"e 0'			    !* Exit if 2 args !
0fo..QFortran_Insert_Tabs_in_Text"n!* If use wants tabs ... !
 fsshpos-5"g f@m(qA) ''	    !* Maybe just self-insert !
z[9				    !* Save end of buffer in q9!
.[0				    !* Save initial position as offset!
:l .-q0u0			    !*  from end of line!
0l				    !* Go to start of line!
.[2				    !* Save head of line in q2 !
FM(M.M &_Fix_Fortran_Label_Field)!* Fix up the label field - end in col 7!
.[1				    !* Save point where changes happened!
:l .-q0-q1"l q1j' "# .-q0j'	    !* Return to where we were !
q2,q1				    !* Return changed regions!


!& Fix Fortran Label Field:! !S Arrange label field correctly 
Expects to be run at start of line and will format the next 6 chars if
on line as necessary... With an arg, this is a continuation line,
without it is not.!

   m.m ^R_Delete_Horizontal_Space[9	    !* Efficiency... !
   qFortran_Indent_With_Tabs[8    !* Space = 0, Tabs = 1 !
   +fo..q Fortran_Continuation_Character[7	!* A fixnum rep of an ascii!
						!* char !

   m9				    !* Delete all blanks right here !
   FF"n			    !* Interpret arg !
      F"l oUndent'		    !* Arg <  0 ? -> Delete indent !
	 "# oContin''		    !* 0 =< Arg ? -> Continuation Line !

   !* Skip past label if any ... !

   -1,1a-q7"e d'		    !* Delete continuation char if any !

   1[0 <-1,1a-71."g 0;'		    !* Loop, ... !
	-1,1a-60."l 0;'		    !*  exitting at a non-digit !
	c %0 >			    !*  counting columns !
   m9				    !* Delete spaces after label !
   fshposition"E
       -1,1a-67"E 2u0 1c 0,1A-13"C 1U0 1R''
       "# -1,1a-99"E 2u0 1c  0,1A-13"C 1U0 1R'''
       M9'

   !* Insert spaces or tab as appropriate ...  !
   !* If  Q$Fortran Indent With Tabs$  is set nonzero, then fill with tabs !

   q8"e < q0-7; i_ %0 >'	    !* Add spaces until past col 7 !
   "# i	'		    !* Insert a tab.!
   

   !Contin!
   0l				    !* Go to the beginning of the line!
   Q8"N				    !* Indent with tabs!
	9i			    !* Put in a tab!
	  -1,1a-q7"E 1d'	    !* Check for old continuation mark!
	  q7"D q7i'"# i9''	    !* Put in the new one if it is a!
				    !* digit, otherwise put in the!
				    !* number 9.!
   "# i_____			    !* Otherwise, if no tab!
				    !* Move to head of line - insert 5 blanks!
   -1,1a-q7"n q7i''		    !* Insert a contin char if one not there!
   

   !Undent!
   m9				    !* Delete blank spaces !
   q8"N
	  0,1a"'d"L d''
   "# -1,1a-q7"e d''		    !* Delete contin char if any !
   

!^R Fortran Read Hollerith:! !Read a hollerith string to insert from echo area!

    1,m(m.m &_Read_Line) Hollerith:_[1 
    fq1:"g 0'
    12.[..E
    .( fq1\ iH g1 ),. 

!Fortran Mode:! !S Set up for Fortran editting
An argument specifies the value of the variable Fortran Indent with Tabs.
Otherwise checks to see if any lines start with a tab and sets the
mode for working with tabs. 

Fortran Mode defines the following
Tab       does Indent for Fortran (arg>1 = continuation, arg<=0 remove indent)
M-I       does Like normal M-I but fills with spaces
Linefeed  makes a CRLF and indents correctly 
M-^       removes indentation and leading CRLF and attaches to previous line
C-M-J M-J makes a CRLF and indents for a continuation
Rubout    deletes backwards changing tabs to spaces
M-;       moves to head of comment line, making one if needed
M-N       moves to next fortran comment line, making one if needed
M-P       moves to previous fortran comment line, making one if needed
	  (If M-P is already define no key redefinition is made.
C-M-;     eliminates the comment text on a comment line 
M-=       displays a helpful column chart showing where columns 6 and 72 are
M-M	  inserts the current date in the identification field.!

    M(M.M &_Init_Buffer_Locals)
    M(M.M Make_Local_Q-Register)..D
    M.M ^R_Indent_for_FortranM.QI
    M.M ^R_Fill_Tab_Field_with_SpacesM.Q..I
    M.M ^R_Date_Line_ModifiedM.Q..M
    ff"N [0'
    "# z-b"n .(J:S
	[0 )J'
       "# 0FO..Q Fortran_Indent_With_Tabs[0''
    1,Q0M.LFortran_Indent_With_Tabs
    qFortran_Indent_with_Tabs"E
      Q(Q.M.QW )M.Q.'

    M.M ^R_Fortran_Continuation_Line_NextM.Q..J
    M.M ^R_Fortran_Continuation_Line_NextM.Q...J
    M.M ^R_Fortran_Merge_Continuation_with_PreviousM.Q..^
    M.M ^R_Fortran_Newline_and_Maybe_ContinuationM.QJ
    M.M ^R_Move_to_Fortran_comment_fieldM.Q..;
    M.M ^R_Move_to_Next_Fortran_comment_fieldM.Q..N
    M.M ^R_Up_Comment_Line U0
    (Q..P-Q0)"E M.M ^R_Move_to_Previous_Fortran_comment_fieldM.Q..P '
    M.M ^R_Eliminate_Fortran_commentM.Q...;
    M.M ^R_Show_ColumnsM.Q..=
    1,72M.LComment_Column
    1,(:I*!)M.LComment_Start
    qfortran_Indent_with_Tabs"N :i*TabsM.LSubmode'
    1,1M.LDisplay_ Matching_ ParenW	    !* Want matching )!
    1,(M.M^R_INDENT_FOR_COMMENT)M.Q..|
    1,(M.M^R_DOWN_COMMENT_LINE)M.Q...N
    1,(M.M^R_UP_COMMENT_LINE)M.Q...P
    1,32 M.L Comment_Column
    1,(:i*!) M.L Comment_Start
    FS OSTECO-1"E
	:@I*` COMPILE__14
	CONTINUE_EMACS
	W120 W`M.L Compile_Command'
    "#:@I*`@FTThe_compile_command_has_been_turned_off. 

    W0fsechoactive`M.L Compile_command'
    
    !* Set up to do auto-continuation for long lines!
    1,72M.LFill_Column
    +FO..qFortran_Continuation_Character[c
    1,(:i*_____c)M.l Fill_Prefix
    1,1M.L Auto_Fill_Mode

!* Set up Page Delimiter according to whether we are using tabs.!

    f[bbind
    [y W9:iy w qfortran_Indent_with_tabs"E 6,32:iy'
    12i
    15I Iy ISUBROUTINE
    15i Iy IFUNCTION
    15I Iy IINTEGER_FUNCTION
    15I Iy IREAL_FUNCTION
    15I Iy ILOGICAL_FUNCTION
    15I Iy ICOMPLEX_FUNCTION
    15I Iy IDOUBLE_PRECISION_FUNCTION
    HFX*M.L PAGE_DELIMITER
    ]Y F]BBIND
    Q.0,1M(M.M&_Set_Mode_Line)Fortran
    

!Fortran Tabify:! !C Places TABS at the correct places in a file.
This will replace spaces at the beginning of a line by tabs in a file,
allowed only in Fortran mode.  A string argument says to save the
original text for M-X Undo.!

    :I*[0
    fq0"G 0,fszM(m.M &_Save_For_Undo) Fortran_Tabify'
    ]0
    [0 [1 [2 [3 [4 [5 [6 [7 [8 [9   !* PUSH TEMPORARY REGISTERS!
    [..0 [..1 [..2
    F~(QMODE)FORTRAN"N 0'	    !* If not Fortran mode, do nothing.!
    J
    -1M(M.M &_PAGE_TAB_ON)	    !* SUBROUTINE TO PLACE TABS IN THE PAGE!
    M(M.M Fortran_Mode)
    J 

!Fortran Untabify:! !C Replaces TABS by SPACES in a file or the buffer.
This will replace spaces at the beginning of a line by tabs in a file
allowed only in Fortran mode.  A string argument says to save the
original text for M-X Undo.!

    :I*[0
    fq0"G 0,fszM(m.M &_Save_For_Undo) Fortran_Untabify'
    ]0
    [0 [1 [2 [3 [4 [5 [6 [7 [8 [9   !* PUSH TEMPORARY REGISTERS!
    F~(QMODE)FORTRAN"N 0'	    !* If not Fortran mode, do nothing.!
    J
    -1M(M.M &_PAGE_TAB_OFF)	    !* SUBROUTINE TO PLACE TABS IN THE PAGE!
    M(M.M Fortran_Mode)
    J 

!Insert Identification Field:! !C Creates Card Image Identification Fields.
The indentification field is made up of the file name and a sequential
card count.  Given an argument, this macro uses the first FOUR letters of the
filename to make of the id field.  A string argument says to save the
original text for M-X Undo.!

    :I*[0
    fq0"G 0,fszM(m.M &_Save_For_Undo) Inserting_Identification_Fields'
    ]0
    [0 [1 [2 [3 [4 [5 [6 [7 [8 [9   !* PUSH TEMPORARY REGISTERS!
    [..0 [..1 [..2 [E [F [G [Q [R [S -UE
    F~(QMODE)FORTRAN"N 0'	    !* If not Fortran mode, do nothing.!
    7uC				    !* INITIALIZE NO. OF !
    FF"G 4UC'		    !* CHARS TO USE IN THE FIELD.  <arg>=4!
    F[BBIND			    !* PUSH CURRENT BUFFER!
    QBuffer_Filenamesf"n fsdfile'    !* Make sure we have the right filename!
    FS D FN1 F6		    !* GET BARE FILENAME!
    .-QCF"G*(-1)D'		    !* NO. OF CHAR. > QC THEN MAKE IT QC LONG!
    7-.F"G,48I'			    !* INSERT ZEROES TO FILL OUT TO 7 CH!
    0uQ 1uR 10uS HFXQ		    !* PUSH THE REGISTERS THAT HANDLE THE!
				    !* FIELD!
				    !* QQ -- NAME, QR -- LINE COUNT!
				    !* QS -- CURRENT POWER OF TENS!
    f]bbind
    J M(M.M Fortran_Untabify)	    !* REPLACES TABS IN THE PAGE!
    J<.-Z;			    !* THIS IS WHERE THE FIELD IS DONE!
	QE"L 1:FBPROGRAMSUBROUTINEOVERLAYBLOCKFUNCTION UF
				    !* Main Tags!
	    QF"N QF+4"G 0L M(M.M &_READ_WORD)UG
		   WF~GPROGRAM"E OHAVEIT'
		   WF~GSUBROUTINE"E OHAVEIT'
		   WF~GOVERLAY"E OHAVEIT'
		   OOUT '
		"# 0L M(M.M &_READ_WORD)UG
		   WF~GFUNCTION"E OHAVEIT'
		   WF~GBLOCK"E M(M.M &_READ_WORD)UG
		      WF~GDATA"E OHAVEIT'
		      OOUT '
		   WF~GINTEGER"E M(M.M &_READ_WORD)UG
		      WF~GFUNCTION"E OHAVEIT'
		      OOUT '
		   WF~GREAL"E M(M.M &_READ_WORD)UG
		      WF~GFUNCTION"E OHAVEIT'
		      OOUT '
		   WF~GCOMPLEX"E M(M.M &_READ_WORD)UG
		      WF~GFUNCTION"E OHAVEIT'
		      OOUT '
		   WF~GLOGICAL"E M(M.M &_READ_WORD)UG
		      WF~GFUNCTION"E OHAVEIT'
		      OOUT '
		   WF~GDOUBLE"E M(M.M &_READ_WORD)UG
		      WF~GPRECISION"E M(M.M &_READ_WORD)UG
			WF~GFUNCTION"E OHAVEIT' ' '
		   OOUT '
!HAVEIT!
		1M(M.M &_READ_WORD)U6    !* GET NAME OF THE ROUTINE!
		F~(FSDFN1)6"N
		   F[BBIND	    !* PUSH CURRENT BUFFER!
		   G6.-QC F"G*(-1)D'	    !* NO. OF CHAR. > QC THEN!
					    !* MAKE IT QC LONG! 
		   7-.F"G,48I'	    !* INSERT ZEROES TO FILL OUT TO 7 CHARS!
		   0uQ 1uR 10uS HFXQ	    !* PUSH THE REGISTERS THAT!
					    !* HANDLE THE FIELD!
				    !* QQ -- NAME, QR -- LINE COUNT!
				    !* QS -- CURRENT POWER OF TENS!
		   f]bbind'	    !* POP THE BUFFER!
!OUT!''
	0L
	.U0 :L .-Q0U0		    !* Q0 GETS LENGTH OF LINE!
	72-Q0F"G,32I'		    !* PAD OUT TO COLUMN 72!
	"# W 0L 72C W :K'	    !* OTHERWISE CHOP TO COLUMN 72!
	GQ W QR\		    !* INSERT THE FIELD!
	%R-QS+1"G		    !* CHECK TO SEE IF WE CHANGE POWERS OF TEN!
	    QS*10US		    !* INCREASE QS TO HOLD NEW POWER!
	    .,(GQ -D .)FXQ'	    !* TAKE OF ANOTHER LETTER FROM END!
	L >			    !* OF NAME!
    J 


!& Page Tab ON:! !S Replaces SPACES by TABS in the current page.!
1fs echo flush
    J [E
    :S	"L@FT****Please_run_the_command_(MM_Tab_OFF)
    @FT_to_remove_the_TABS_in_the_file

    0fs echo active w '
    J <.-Z;			    !* START OF ITERATION LOOP!
        I/			    !* MAKE SURE EACH LINE HAS AT LEAST ONE!
        .U0 :L			    !* CHARACTER. Q0 GETS LINE START LOCATION!
	QE"L			    !* WE EXECUTE THIS LOOP ONLY IF A FORTRAN!
				    !* FILE!
	  .-Q0-72 F"G *(-1)D	    !* KILL REST OF LINE > 72 CHARACTERS!
	     -S_ C		    !* SEARCH BACK TO FIRST NON-SPACE CHAR!
	     0A-72"E		    !* IF FIRST NON-SPACE IS AN "H" CHECK FOR!
				    !* HOLLERITH DEFINITION!
	       -1A"D :L ' '	    !* IF A DIGIT, DON'T DELETE LINE!
	  :K ' '
	"# :L -S_ C :K '	    !* OTHERWISE, DELETE TRAILING BLANKS!
	.U1 0LC			    !* Q1 GET THE END OF LINE POINTER!
	(Q1-Q0)/8U4		    !* Q4 GETS THE NUMBER OF TAB STOPS IN THE!
				    !* LINE!
	Q4"N QE"L 1U4' '	    !* IF Q4>0 AND A FORTRAN FILE THEN Q4=1!
				    !* TAB STOP!
	8U5			    !* Q5 CONTAINS THE STARTING LOCATION AND!
				    !* DIFFERENCE BETWEEN TABS!
	Q4"G			    !* THIS LOOP FOR TABIFYING!
          QE"L			    !* THIS LOOP FOR A FORTRAN FILE!
	     6U5 1A-67"E 8U5' '	    !* IF FIRST CHARACTER A "C" THEN COMMENT!
				    !* LINE AND DO NORMAL TEXT STUFF!
	  Q4<
	     Q5C 8U5 .U2	    !* MOVE TO NEXT TAB STOP!
	     Q2-8U6 -S_ C	    !* SEARCH FOR FIRST NON-SPACE TO THE LEFT!
				    !* OF THE TAB STOP!
	     Q6-.F"G C'
	     Q2-.U3		    !* Q3 IS THE NUMBER OF SPACES!
	     Q3 F"GD 9I'	    !* INSERT THE TAB AFTER DELETING THE SPACES!
	     Q3-1 "EC' > '	    !* IF MORE THAN ONE SPACE!
    0L D L  >

    QE"L J			    !* THIS LOOP IS ONLY FOR FORTRAN FILES!
       <.-Z;
          .U0 S_		    !* SEARCH FOR FIRST NON-SPACE AT THE !
	  R W .-Q0U1		    !* BEGINNING OF THE LINE SO WE CAN FORMAT!
				    !* LABELS AND CONTINUATION CARDS!
	  Q1-5"E 0K 9I		    !* THIS ONE IS A CONTINUATION CARD!
	     1A"D ONEXT1'	    !* ALREADY HAS A NUMBER!
	     D W I9 ONEXT1 '	    !* CHANGE LETTER TO THE NUMBER "9"!
	  Q1"E ONEXT1'		    !* LABEL IS ALREADY AT BEGINNING!
	  Q1-5"L 0K		    !* OTHERWISE, PUT LABEL AT BEGINNING!
	     1A-67"E ONEXT1'	    !* COMMENT LINE!
	     \ W .U2		    !* SKIP OVER THE LABEL NUMBER!
	     :S_"E ONEXT1'	    !* SEARCH FOR SPACE FAILS, WE!
				    !* SHOULD BYPASS!
	     R W 0A-32"E -D 9I R'   !* PUT IN THE TAB AFTER THE LABEL!
	     Q2,.K '		    !* KILL THE MISCELLANEOUS CHARACTERS!
!NEXT1!
	  L > ' 

!& Page Tab OFF:! !S Replaces TABS by SPACES in the page!
    J [E
    <:S; -D>			    !* MAKE SURE THERE ARE NO FF!
    0U0 0U1 0U2			    !* INITIALIZE NECESSARY Q-REGISTERS!
    J <:S	;		    !* SEARCH FOR THE TABS!
	0L .U0			    !* Q0 GETS BEGINNING OF LINE POSITION!
	0U7 1A-67"E 1U7'	    !* Q7 IS A COMMENT FLAG, OR IS C THE FIRST!
				    !* CHARACTER !
	S			    !* GO BACK TO WHERE THE TAB WAS!
	-D .-Q0U3		    !* Q3 GETS THE NUMBER OF CHARACTERS TO THE!
				    !* TAB POINT.!
	QE"L			    !* ONLY FOR A FORTRAN FILE!
	    Q7"E		    !* COMMENT LINE? !
		Q3-5F"G -1U3' ' '   !* THE TRUE TAB POSITION IS PUT IN Q3!
	8-(Q3-((Q3/8)*8))F"G,32I'   !* INSERT THE APPROPRIATE NUMBER OF SPACES!
	QE"L			    !* FORTRAN FILE?  !
	    .-Q0-9"L		    !* AT FIRST TAB STOP?  !
		Q7"E -2D	    !* NOT COMMENT LINE THEN DELETE 2 SPACES!
		   1A"D -D ' ' ' ' >	    !* IF A DIGIT ==>!
					    !* CONTINUATION ==> -1 SPC! 
    

!Remove Identification Field:! !C Removes the identification field
number in columns 72 to 80, and any trailing blanks on the line.  The
arguments specify the Number of characters to remove (Precomma,
default=8), and the goal column (Postcomma, default=80).  A string
argument implies that the undo buffer will be used.!

    :I*[0
    fq0"G 0,fszM(m.M &_Save_For_Undo) Removing_Identification_Fields'
    ]0
    [a [b
    FF-2F"E ua ub'	 !* Pre goes to QA, post QB!
    "#+1"E 8ua uB'		 !* QA gets the number of!
				 !* characters to remove!
	"# 8ua 80ub' '
    qb-qa:"G
	:I*CGoal_Column_is_less_than_or_equal_to_number_of_chars_to_delete.
	fsechodisp
	0fsechoact '
    j<.-z;
	:l fshpos-qb"E -qad'
	0l.(:l.,):fb_"E 0l'"#1c'
	:k
	1l>
    j


!& Read Word:! !S Read the following word and return.
Negative Arguments make sense.!

[A [B				    !* Push temporary registers!
FF"E 1UA' "#UA'		    !* Default argument is 1!
QA FWL W -QAFWXB 
QB



!^R Date Line Modified:! !^R Inserts todays date in the identification field.
An argument is a repeat count.  A flag called identification field
text defines what is inserted with todays date as the default.!

    F~(QMode)FORTRAN"N	    !* If a FORTRAN file continue with the!
	F~(fsdfn2)FOR"N ''	    !* macro!
    [a [B [c			    !* Push temporary registers, QA!
				    !* gets the type of line 0 means!
				    !* no tab.!
				    !* QB is the repeat count and QC!
				    !* is the text to be inserted!
    (:I*)FO..QIdentification_Field_Textuc !* If QC is undefined then!
					    !* make it null!
    QB"L -1@l'			    !* If arg is negative back up a!
				    !* line !
    QB  <			    !* For the whole repeat count!
	FQC"G			    !* If we have some text then do!
	    0ua
	    0l :FB	"L	    !* If line contains a tab then a!
				    !* special case is done if !
		1R 6-FShposition"G 2ua''   !* the tab is before!
					    !* column 62!
	    :L 72+qa-FshpositionF"G,32i'"#D'	    !* Go to the end!
						    !* of the line!
	    gc'			    !* insert the text.!
	qB"L-'1l>		    !* Down or up a line!
    -QB@F F		    !* refresh the screen!

!Format FORTRAN Output:! !C Replaces the FORTRAN Carriage Control.
This macro changes the carriage control in first column to its
corresponding control character sequence. The single argument is the
page length desired with the default being 60 lines!

!*  Peter J. Gergely, DREA 11:32am  Monday, 22 December 1980!

    J M(M.M Strip_SOS_Line_Number) !* Get rid of the nulls first!
    0[L 60[P			    !* QL will be the current line!
				    !* count and QP the page length!
    FF&1"N			    !* If we have a postcomma argument!
	F"E 377777777777.UP'
	"#   -5F"G +5UP''W'	    !* Store the value!
    [C				    !* QC will be the ascii value of!
				    !* the first character!
    J<.-z;			    !* For each line!
	0l 1:C; 0AUC		    !* Go to the beginning and read!
				    !* the first character of each line!
	-1D			    !* Delete the character read!
	%L-QP"G 1UL 12I'	    !* Increment line count and if!
				    !* larger than the page length!
				    !* then put a page mark!
	QC-13"E 13I 1l !<!>'	    !* A CR just skips!
	QC-12"E 1UL 1l !<!>'	    !* A FF resets everything!
	QC-32"E 1l!<!>'		    !* A space!
	QC-48"E			    !* The number 0!
	    %L-QP"G 1UL 12I'
	    "# 13I 10I'
	    1l!<!>'
	QC-49"E			    !* The number 1!
	    QL"G 1UL 12I'
	    1l!<!>'
	QC-43"E			    !* The symbol +!
	    0,0A-10"E -1D'
	    0,0A-13"N 13I'
	    QL-1UL 1l!<!>'
	QC-42"E			    !* The symbol *!
	    QL-1UL
	    1l!<!>'
	QC-45"E			    !* The minus symbol!
	    %LW %L-QP"G 1UL 12I'
	    "# 13I 10I 13I 10I'
	    1l!<!>'
	QC-46"E			    !* A period!
	    %L-QP"G 1UL 12I'
	    "# 13I 10I'
	    1l!<!>'
	QC-44"E			    !* A comma!
	    %LW %L-QP"G 1UL 12I'
	    "# 13I 10I 13I 10I'
	    1l!<!>'
	QC-50"E			    !* the number 2 = 1/2 page!
	    QL+(QP+1/2)"G 1UL 12I 1l!<!>'
	    QP+1/2-QL F(+QLUL) F"G<13i10I>'
	    1l!<!>'
	QC-51"E			    !* the number 3 = 1/3 page!
	    QL+(QP+2/3)"G 1UL 12I 1l!<!>'
	    QL/3+1*(QP+2/3)-QL F(+QLUL) F"G<13i10I>'
	    1l!<!>'
	QC-47"E			    !* the symbol / = 1/6 page!
	    QL+(QP+5/6)"G 1UL 12I 1l!<!>'
	    QL/6+1*(QP+5/6)-QL F(+QLUL) F"G<13i10I>'
	    1l!<!>'
	1L>			    !* End of the iteration!
    J 

!Fortran Data Mode:! !S Set up for Data editing
Makes Rubout the Tab-hacking Rubout.
M-= runs ^R Show Data Columns.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    M(M.M Make_Local_Q-Register)..D
    1,(W377.@FS^RINIT)M.Q
    1,(W177.@FS^RINIT)M.Q.
    M.M^R_Show_Data_ColumnsM.Q..=
    1M(M.M&_Set_Mode_Line) Fortran_Data 
    

!^R Show Data Columns:! !^R Show Current Line with column numbers above it!

    fsz"E '
    z"E '

    [a [b [c [d [0 [1 fstopline[s

    f[bbind
    0ua fswidth/10F"Gua'
    0ub qa<10,32i %B\ fk(w -fwlw)d 1fwl> 0fx0
	qa<i1234567890> 0ub fswidth-(qa*10)f"G<%B\W> 0fx1
    f]bbind

    FSRGETTY"n
      @V FS^R VPOS-qs-3 f"g +qsfstopline
	 WFT
0
1 qsfstopline'
      "# +4+qs fstopline
	 WFT1
0
 qsfstopline ''

    "#
	 FT1
0
'
    

