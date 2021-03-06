!* -*-TECO-*- !
!* [MIT-OZ]PS:<EMACS>PCL.EMACS.8, 12-Feb-83 23:44:10, Edit by KLOTZ!
!~FILENAME~:! !Library for editing PCL functions!
PCL

!PCL Mode:! !C Set things up for editing PCL code.
Sets up:
	C-M-A,C-M-E		^R Backward/Forward Block
	C-M-S			^R Forward Statement
	C-M-U			^R Make BEGIN-END
        C-M-+			^R Plus increment
        <tab>			^R Indent Nested
	<Rub>			^R Backward Delete Hacking Tabs!

    M(M.M&_Init_Buffer_Locals)
    1,q(1,q. m.Qw)m.Q.    !* Exchange rubout flavors. *!
    1,(M.M ^R_Indent_Nested)  M.Q I
    1,(:I*!_)M.LComment_Start
    1,(:I*;)M.LComment_End
    1,1M.LSpace_Indent_Flag
    1,8M.LComment_Column
    1,0M.LPCL_CapKEY

    0@fo..qAutomatic_Capitalization"N   !* This might be in init file *!
 	m(m.mCapitalize_PCL_Keywords)'
    
    m.m^R_Forward_StatementM.Q...S
    m.m^R_Forward_BlockM.Q...E
    m.m^R_Backward_BlockM.Q...A
    M.M^R_Make_BEGIN-ENDM.Q...U
    M.M^R_Plus_incrementM.Q...+
				    !* Set up the delimiter table !
    0FO..Q PCL_..D"E
      0M.VPCL_..D
      :IPCL_..D________________________________________AA_____________________________________________________________________________________________A_____________________________A____A____A___AA___AA____A____A____(____)(___A____A_________A_________A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____;____A____A____A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____A____)[___A___AA____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____A____){___A________'

    QPCL_..DM.Q..D
    Q.0,1M(M.M&_Set_Mode_Line)PCL



!^R Backward Block:! !^R Move backward over one BEGIN/END pair!

	0UD 0U0 .U1 Z-."GC'
	< -:S BEGIN END"E 
	  :i*CNo_Block_BackwardsFSECHODISP
	    0FSECHOACTIVE WBJ 0;'   !* [PJG] If none then abort!
	  1A&137.-E"E QD-1UD '
	    "#QD+1UD QD; ' >
	0


!^R Forward Statement:! !^R Move forward over one PCL statement.
With positive arg, go up one or more levels in BEGIN END nest.
With negative arg, go down one or more levels.!

	!* Comments are COMMENT or exclamation point !

	(:I* ;  "  !  END !*
!		 BEGIN )[S
	FF"E 0' "#-' [D	        !* Levels to go up or down !
	[E .[A
	< :SS"E FG QAJ 0'		!* Search--error if nothing ! 
	  .UE FKC
	  1A-;"E			!* ; !
		QEJ
		QD"E 0 '		!* Quit if at level 0 !
		!<!>'			!* Repeat !
	  1A-42."E C S" !'! !<!> '	!* Quotes !
		:I*Unmatched_Quote FG 0 '	!* Error if not found !
	  ."G 0A"C QEJ R !<!> ' '	!* No preceding delimiter--false alarm!
			!* (Trailing delimiter is part of search string.) !
	  1A&137.-C"E S; !<!> '	!* COMMENT !
	  1A-41."E S; !<!> '		!* Exclamation point !
	  1A&137.-E"E			!* END !
		QD"G FG QAJ 0'	!* Too far--error !
		QD+1UD			!* Up a level !
		QD"G 0'	!* Level 1--Quit and leave cursor before END !
		QEJ R			!* Leave cursor after END !
		!<!> '			!* Repeat !
	  QD-1UD		    !* else BEGIN or START -- down a level !
	  QEJ R				!* Leave cursor after BEGIN !
	  QD"E 0'			!* Quit if at level 0 !
	  >

!^R Forward Block:! !^R Move forward over one BEGIN END pair.
With positive arg, go up one or more levels in BEGIN END nest.
With negative arg, go down one or more levels.!

	!* Comments are COMMENT or exclamation point !

	(:I* "   !  END !*
!	        BEGIN )[S
	FF[X			!* Any arg specified? !
	QX"E 0' "#-' [D	        !* Levels to go up or down !
	[E .[A
	< :SS"E FG QAJ 0'		!* Search--error if nothing ! 
	  .UE FKC
	  1A-42."E C S" !'! !<!> '	!* Quotes !
	  ."G 0A"C QEJ R !<!> ' '	!* No preceding delimiter--false alarm!
			!* (Trailing delimiter is part of search string.) !
	  1A&137.-C"E S; !<!> '	!* COMMENT !
	  1A-41."E S; !<!> '		!* Exclamation point !
	  1A&137.-E"E		!* END !
		QD+1UD			!* Up a level !
		QX*QD"G FG QAJ 0'	!* Too far--error !
		QEJ R			!* Leave cursor after END !
		QD"L !<!> '		!* Repeat if more to go !
		0 ' 		    !* Else quit cause at or above level 0 !
	  QD-1UD		!* else BEGIN or START -- down a level !
	  QEJ R				!* Leave cursor after BEGIN !
	  QD"E 0'			!* Quit if at level 0 !
	  >


!^R Make BEGIN-END:! !^R Create a BEGIN END pair.
Cursor position defines indentation level for this block.
Leave cursor ready to type first statement of the block.!

    .[A				    !* Remember for return !
    0L :FB"L :L 13i10i W-4MI' "# QAJ'
    IBEGIN' 13i10i
    W-4@MI			    !* [PJG] Add in the begin block!
    .(				    !* Come back to here later !
	13i 10i W2MI
	IEND; 13i 10i
	.[Z)J			    !* For return !
	QA,QZ			    !* Return changed region!




!Capitalize PCL Keywords:! !C Turn on capitalization of keywords.
With no argument, the mode is toggled.  Otherwise, a positive argument
turns on the mode and a zero shuts it off.  Uses the WORDAB library and
a file of pre-defined abbreviations which are the keywords.!

    [.1
    QPCL_CapKEY"'E[0		    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0UPCL_CapKEY
    QPCL_CapKEY"E
	1:< 0m(m.mWord_Abbrev_Mode) >    !* Turn off wordab library *!
	'
    
    1m(m.mWord_Abbrev_Mode)	    !* start it *!
    0FO..QLast_Word_Abbrev_File"E
	m(m.mRead_Word_Abbrev_File)EMACS:PCL.DEFNS'	    !* get abbrevs *!
    "# f[bbind
	GLast_Word_Abbrev_File J
	:FBPCL.DEFNSU.1 f]bbind
	Q.1"E 	m(m.mRead_Word_Abbrev_File)EMACS;PCL_DEFNS'
	'
    				    !* Done *!





!Expand Abbrevs in Region:! !C Expand all WORDAB abbreviations in region.
Assumes WORDAB already loaded.
Comments and strings are skipped, but assumes that it's not started in one.!
 f[vb f[vz :,.f fsBoundw j    !* narrow bounds to region *!
 [..d :g..du..d ^*5:f..D	    !* Make "^" not alphabetic. *!
 [a

    <  f[vz 0ua
	.(:s!_COMMENT"n fsz-.fsvzw :ia;')j
	.(:s""N fsz-.fsvzw 34:ia'!'!)j
	< 1:<fwl>@:;		    !* is there a next word *!
	    m(m.m^R_Abbrev_Expand_Only)  !* ok, go expand it *!
	    >
	zj f]vzW
	qa@; W:sa;
	>
    b zj				    !* set point and mark *!



!^R Plus Increment:! !^R Make PCL stmt to increment the word before the point.
Leaves region around inserted text so it can be killed easily!
    59,0A-59"E '			    !* out if a semi-colon!
    [a WM(M.M^R_Delete_Horizontal_Space)
    <.-B"E' 65,0A"'B; w1R>
    .[2 
    <-FWL .@;			    !* Go back over words until out of full !
	(0A-$ "'E) + (0A-# "'E) + (0A - [ "'E) + (0A-] "'E) ;>  !* variable !
    .,Q2Xa				    !* Put it in reg A !
    Q2J				    !* Jump back to end *! 
    .				    !* Set region around insert!
    I___A
    F"G WI_+_W \ WI;'
    "# "L WI_-_W   \ WI;'
	"#WI_+_; 1R''
    	    !* Fill out the rest of the stmt!
  