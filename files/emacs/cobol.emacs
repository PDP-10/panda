!* Hey EMACS, this is a -*-TECO-*- file. *!

!* v2 11-Mar-81 *!

!~FILENAME~:! !C EMACS macros for COBOL (version 2).
Do a Meta-X COBOL Library Description for more information.!

COBOL


!COBOL Library Description:! !C Miscellaneous information about this Library.
The documentation for this entire library can be obtained by loading the
ABSTR Library, and doing:

	Meta-X Alphabetical AbstractCOBOL

The above command will leave the abstract in your buffer.  It is the same
documentation that is available on line with EMACS.

	Comments and suggestions to:

	STAPLETON at DORA
		or
	John T. Stapleton  PK3-2/F29
	Digital Equipment Corp.
	129 Parker St.
	Maynard, Mass.  01754

	(617) 493-9172	  DTN: 223-9172

Update History:

Ver 1	Original version - not much to say about it.
Ver 2	Removed all keypad stuff, so that people may use their favorite
	keypad library instead.  The keypad stuff went to a new library
	called, appropriately enough, KEYPAD.!

  M(M.MDescribe)COBOL_Library_Description



!COBOL Mode:! !C Commands to edit COBOL programs
Puts:                   on:

 ^R COBOL Comment       Meta-;
 ^R COBOL Level Number  C-M-L
 ^R COBOL OCCURS        C-M-O
 ^R COBOL PIC           C-M-P
 ^R COBOL VALUE         C-M-V
 ^R COBOL VALUE SPACE   C-M-S
 ^R COBOL VALUE ZERO    Meta-Z!

  M(M.M&_Init_Buffer_Locals)

  1,(M.M^R_Tab_to_Tab_Stop)M.QI
!*  M.M&_Indent_Without_TabsM.LMM_&_Indent!
!*  M.M&_Xindent_Without_TabsM.LMM_&_Xindent!
  -1UIndent_Tabs_Mode
  QCOBOL_Tab_Stop_DefinitionsM.LTab_Stop_Definitions
  1,(M.M^R_COBOL_Comment)M.Q..;

  1M.VCOBOL_Level_Number_Increment
  1,(M.M^R_COBOL_Level_Number)M.Q...L

  45M.V COBOL_OCCURS_Column
  1M.V COBOL_OCCURS_New_Line
  1,(M.M^R_COBOL_OCCURS)M.Q...O

  29M.VCOBOL_PIC_Column
  1M.VCOBOL_PIC_New_Line
  1,(M.M^R_COBOL_PIC)M.Q..P
  1,(M.M^R_COBOL_PIC)M.Q...P

  10M.VCOBOL_VALUE_Offset
  1,(M.M^R_COBOL_VALUE)M.Q...V
  1,(M.M^R_COBOL_VALUE_SPACE)M.Q...S
  1,(M.M^R_COBOL_VALUE_ZERO)M.Q..Z

  Q.0,1M(M.M&_Set_Mode_Line)COBOL



!^R COBOL Comment:! !^R Create or go to COBOL Comment!

  0L				    !* This is really!
  5 F=*____ "E		    !*   bletcherous!
    5C '			    !* but, I haven't thought!
  3 F=*			    !*   of a way to!
     "E			    !* improve it!
      C I____ '
  I*____
  


!^R COBOL Level Number:! !^R Set COBOL Level Number Increment.
The COBOL Level Number Increment is for use by other
commands, but is set with this command.

With no arg    -  Set to 1 (default).
With one ^U    -  Add 1 to it.
With two ^U's  -  Subtract 1 from it.
With arg >0    -  Set to <arg>.
With arg <1    -  Set to 1 (default).!

  FS ^R EXPT "N			!* Any Control-U's!
    FS ^R EXPT-1 "E			!* One Control-U!
      %COBOL_Level_Number_Increment '

    FS ^R EXPT-2 "E			!* Two Control-U's!
      QCOBOL_Level_Number_Increment-1UCOBOL_Level_Number_Increment '

    O Display '

  FF "N				!* Argument present!
    UCOBOL_Level_Number_Increment '	!*  set to <arg>!
  "#					!* No argument!
    1UCOBOL_Level_Number_Increment '	!*  set to 1!

!Display!
  QCOBOL_Level_Number_Increment-1 "L	!* If less than 1!
    1UCOBOL_Level_Number_Increment '	!*  set to 1!
  QCOBOL_Level_Number_Increment:\[0	!* Push onto q0 for disp!
  :I*CFS ECHO DISPLAY
  @FT COBOL_Level_Number_Increment_=_0
  0FS ECHO ACTIVE
0


!^R COBOL OCCURS:! !^R Make OCCURS clause for COBOL.
Inserts "OCCURS " clause at COBOL column 52 (default),
but can be changed to new column.  Will guarnatee
that preceding character is space or tab.  Inserts
"OCCURS " on new line (default) if already past spec-
ified column, but tries to back up first.  New line
option can be changed.

With no arg    -  Inserts "OCCURS "
With one ^U    -  Sets COBOL OCCURS Column to current column
With two ^U's  -  Complements the new line option
With >2  ^U's  -  Shows status of COBOL OCCURS Column and
                        COBOL OCCURS New Line
With arg>0     -  Inserts "OCCURS arg."
With arg<1     -  Same as no arg.!

  FS ^R EXPT "N			!* If any Control-U's!
    FS ^R EXPT-1 "E			!* One Control-U!
      FS H POSITIONUCOBOL_OCCURS_Column '
    FS ^R EXPT-2 "E			!* 2 Control-U's!
      QCOBOL_OCCURS_New_Line*(-1)UCOBOL_OCCURS_New_Line '
    QCOBOL_OCCURS_Column+7:\[C
    QCOBOL_OCCURS_New_Line "G
      :I*Yes[N '
    "#
      :I*No[N '
    :I*CFS ECHO DISPLAY
    @FT COBOL_OCCURS_Column_=_C_____
    FS ECHO LINES-1 "N @FT
     '
    @FT COBOL_OCCURS_New_Line_=_N
    0FS ECHO ACTIVE
    0'

  FF "N
    [A '
  "#
    0[A '

  FS H POSITION-QCOBOL_OCCURS_Column "G
    -@F_	K '
  .[F
  QCOBOL_OCCURS_New_Line,QCOBOL_OCCURS_ColumnM(M.M&_Goto_COBOL_Column)
  IOCCURS_
  QA "G
    GA I. '
  QF,. 


!^R COBOL PIC:! !^R Make PIC clause for COBOL.
Inserts "PIC " clause at COBOL column 36 (default),
but can be changed to new column.  Will guarnatee
that preceding character is space or tab.  Inserts
"PIC " on new line (default) if already past spec-
ified column, but tries to back up first.  New line
option can be changed.

With no arg   -  Inserts "PIC "
With 1  ^U    -  Sets COBOL PIC Column to current column
With 2  ^U's  -  Complements the new line option
With >2 ^U's  -  Shows status of COBOL PIC Column and
                       COBOL PIC New Line
With arg>1    -  Inserts "PIC X(arg)"
With arg=1    -  Inserts "PIC X"
With arg=0    -  Same as no arg
With arg=-1   -  Inserts "PIC S9"
With arg<-1   -  Inserts "PIC S9(arg)"!

  FS ^R EXPT "N			!* If any Control-U's!
    FS ^R EXPT-1 "E			!* One Control-U!
      FS H POSITION UCOBOL_PIC_Column '	!* Set column!
    FS ^R EXPT-2 "E			!* 2 Control-U's!
      QCOBOL_PIC_New_Line*(-1)UCOBOL_PIC_New_Line '	!* Complement!
    QCOBOL_PIC_Column+7:\[C
    QCOBOL_PIC_New_Line "G
      :I*Yes[N '
    "#
      :I*No[N '
    :I*CFS ECHO DISPLAY
    @FT COBOL_PIC_Column_=_C_____
    FS ECHO LINES-1 "N @FT
     '
    @FT COBOL_PIC_New_Line_=_N
    0FS ECHO ACTIVE
    0'

  F:M(M.M&_COBOL_PIC)


!^R COBOL VALUE:! !^R Make VALUE for COBOL.
Inserts "VALUE " at COBOL PIC column + 10 (default).  Will
guarantee that preceeding character is space or tab.

With no arg    - Inserts "VALUE "
With any ^U's  - Does nothing
With arg>0     - Inserts "PIC X(arg) VALUE "
With arg=0     - Same as no arg
With arg<0     - Inserts "PIC S9(arg) VALUE "

Note: If anyone can think of what to do with ^U args,
I am willing to listen.!

  FS ^R EXPT "N 0 '			!* Control-U's are no-ops!
  .[F					!* Save 'from' point!
  [T					!* Temporary work!
  FF&1 "N
    QF,M(M.M&_COBOL_PIC)UTUT QF,QTF UFUF '
  QF,M(M.M&_COBOL_VALUE)UTUT QF,QTF UFUF
QF,.


!^R COBOL VALUE SPACE:! !^R Make VALUE SPACE for COBOL.
Inserts "VALUE SPACE." at COBOL PIC Column + 10 (default).
Will guarantee that preceding character is space or tab.

With no arg    - Inserts "VALUE SPACE."
With any ^U's  - Does nothing
With arg>0     - Inserts "PIC X(arg) VALUE SPACE."
With arg=0     - Same as no arg
With arg<0     - Inserts "PIC S9(arg) VALUE SPACE." (certainly useless)

Note: If anyone can think of what to do with ^U args,
I am willing to listen.!

  FS ^R EXPT "N 0 '			!* Control-U's are no-ops!
  .[F					!* Save 'from' point!
  [T					!* Temporary work!
  FF&1 "N
    QF,M(M.M&_COBOL_PIC)UTUT QF,QTF UFUF '
  QF,M(M.M&_COBOL_VALUE)UTUT QF,QTF UFUF
  ISPACE.
QF,.


!^R COBOL VALUE ZERO:! !^R Make VALUE ZERO for COBOL.
Inserts "VALUE ZERO." at COBOL PIC Column + 10 (default).
Will guarantee that preceeding character is space or tab.

With no arg    - Inserts "VALUE ZERO."
With any ^U's  - Does nothing
With arg>0     - Inserts "PIC X(arg) VALUE ZERO."
With arg=0     - Same as no arg
With arg<0     - Inserts "PIC S9(arg) VALUE ZERO."

Note: If anyone can think of what to do with ^U args,
I am willing to listen.!

  .[F
  [T
  FF&1 "N
    QF,M(M.M&_COBOL_PIC)UTUT QF,QTF UFUF '
  QF,M(M.M&_COBOL_VALUE)UTUT QF,QTF UFUF
  IZERO.
QF,. 


!& CBL Mode:! !& COB Mode:! !S Set-up for COBOL on FN2!
  :M(M.MCOBOL_Mode)


!& COBOL PIC:! !S Inserts "PIC" clause.
This is the routine that actually does the insertion.

Called by:

 ^R COBOL FILLER (not implemented yet)
 ^R COBOL PIC
 ^R COBOL REDEFINES (not implemented yet)
 ^R COBOL VALUE
 ^R COBOL VALUE SPACE
 ^R COBOL VALUE ZERO

Returns <m>,<n> as part of buffer changed.!

  FF&3 "N			    !* Argument present!
    [A '			    !*  Save it in q-reg A!
  "#				    !* No argument!
    0[A '			    !*  Store zero instead!
  FS H POSITION-QCOBOL_PIC_Column "G	    !* Past column!
    -@F_	K '		    !*  kill spaces to left!
  FF&2 "E
    .[F '
  "#
    [F '
  QF,.F UFUF
  QCOBOL_PIC_New_Line,QCOBOL_PIC_ColumnM(M.M&_Goto_COBOL_Column)
  IPIC_
  QA "N				    !* Argument present!
    QA "G
      IX '			    !*  it is now "PIC X"!
    "#
      IS9 '			    !*  it is now "PIC S9"!
    QA  UA
    QA-1 "G			    !*   greater than 1!
      I( GA I) ''		    !*    put it in parens!

  QF,. 


!& COBOL VALUE:! !S Inserts "VALUE".
This is the routine that actually does the insertion of "VALUE ".

Called by:

 ^R COBOL VALUE
 ^R COBOL VALUE SPACE
 ^R COBOL VALUE ZERO

Returns <m>,<n> as part of buffer changed.!

  FF&2 "E
    .[F '
  "#
    [F '
  QF,.F UFUF
  QCOBOL_PIC_Column+QCOBOL_VALUE_Offset-FS H POSITION[S
    QS F"G,40.I ''
  0A-40. "N
    0A-11. "N
      40.I ''
  IVALUE_
QF,.


!& Goto COBOL Column:! !S Internal routine used for alignment.!

  [O [C			    !* Save option and column!
  FS H POSITION[H		    !* Save current column!
  QH-QC "L			    !* Haven't reached column yet!
    QH,QCM(M.M&_XINDENT)  '	    !*   so; get to it!

  QH-QC "E			    !* At column, and preceeding!
    (0A-32)*(0A-9) "E  ''	    !*   is space or tab!

  QO "G				    !* New line option?!
    M(M.M^R_CRLF)		    !*   Yes!
    0,QC-1M(M.M&_XINDENT) '	    !*   Get to column - 1!

  32I 			    !* Put in a space and return!


!& Setup COBOL Library:! !S Sets up the COBOL Library
Defines variables:            to be:

COBOL Level Number Increment  1
COBOL OCCURS Column           52
COBOL OCCURS New Line         1
COBOL PIC Column              36
COBOL PIC New Line            1
COBOL Tab Stop Definitions    at COBOL columns 12,16,36,40,48,52,56,60
      Note: Because there are no sequence numbers, the first 6
            columns are not on the screen; therefore the tabs
            will stop at columns 6,10,30 etc.  You can define
            your own tab stops (see Edit Tab Stops) by defining
            this variable (string, not buffer) in your Init file.
COBOL VALUE Offset            10!

  1  M.CCOBOL_Level_Number_Increment Add_this_number_for_new_Level_Number.
  45 M.CCOBOL_OCCURS_Column COBOL_Column_for_OCCURS_clause_(default_52).
  1  M.CCOBOL_OCCURS_New_Line =pos_New_Line_if_past_column;_else,_same_line.
  29 M.CCOBOL_PIC_Column COBOL_Column_for_PIC_clause_(default_36).
  1  M.CCOBOL_PIC_New_Line =pos_New_Line_if_past_column;_else,_same_line.
  10 M.CCOBOL_VALUE_Offset Number_of_columns_away_from_PIC_to_aim_for.
  :FO..QCOBOL_Tab_Stop_Definitions "L
    [T
    :IT_____:___:___________________:___:_______:___:___:___:
    QTM.VCOBOL_Tab_Stop_Definitions '

