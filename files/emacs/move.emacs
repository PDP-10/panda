!* -*-TECO-*-!
!* <EMACS>MOVE.EMACS.34, 11-Feb-82 08:34:21, Edit by GERGELY!
!* <HOLMES>MOVE.EMACS.24, 30-Sep-80 17:52:11, created by HOLMES!

!~Filename~:! !Macros to move objects around to other files.!
MOVE


!& Setup MOVE Library:! !S Run "MOVE Setup Hook" if defined.!

    :m(0 FO..Q MOVE_Setup_Hook f"E W :I*')


!^R Move Macro:! !^R Move the current macro to another file.
Arguments are interpreted as follows:
   No arg    => To end of the file (but before Local  Modes)
   n (n>=0)  => After the n'th macro in the file
   -n        => Before the n'th macro from the end of the file
A pre-comma arg is interpreted as a repeat count. In addition,
if ^U is specified, the macro is deleted.!

    Fm(m.m&_Move_Object)MACRO
    

!^R Move Page:! !^R Move current page to another file.
Args the same as Move MACRO.!

    Fm(m.m&_Move_Object)PAGE
    


!^R Move Line:! !^R Move a line to another file.
Args as Move MACRO.!

    Fm(m.m&_Move_Object)N
     



!^R Move Paragraph:! !^R Move a paragraph to another file.
Args are the same as Move Macro.!

    Fm(m.m&_Move_Object)PARAGRAPH
    



!& Move Object:! !S Move an object <stringarg> to another File.!

    :I* [6			    !* Find out type of object!
    F=6N "E :I* [5'	    !* If N(ormal), read seperator!
    "# :I* [5'
       f"E W 1' [4		    !* Q4 is repeat count!
    [0[1[2[3[7[8[9		    !* Save some Q-regs!
    QBuffer_Name u9		    !* So we can find our way back!
    0fo..Q Buffer_FilenamesF"EW    !* [PJG] If no buffer name!
	:I*9.EMACS' f[D File    !* Save defaults!
    fsD FN2 u2 :I* fsD FN2	    !* Save and clear FN2!
    QPrevious_Buffer u8	    !* We'll try here first!
    QBuffer_Index u1		    !* But not here unless explicit!
    F~98 "N			    !* If last buffer was different!
	1,Q8 m(m.m&_Find_Buffer) u8	    !* Try it first!
	Q:.B(Q8+2) f"EW:I*X.ZOT' fsD File !* Get buffer filenames!
	F~(fsD FN2)2 "E Ofound''	    !* Have we found it!
    0 u8 FQ.B/5 u3		    !* No, then must search them all!
    < Q8-Q3;			    !* Quit at end!
	:I* fsD FN2 Q8-Q1 "N	    !* Skip our own buffer!
	    Q:.B(Q8+2) f"EW:I*X.ZOT' fsD File	    !* Get buffer filenames!
	    F~(fsD FN2)2 "E Ofound''   !* Have we found it!
	Q:.B(Q8)+Q8 u8 >	    !* No, try next!
    0FO..QBuffer_FilenamesF"EW	    !* [PJG] If no buffer name!
	:I*9.EMACS'fsD File   !* Not found, default to same file!
!found!
    m(m.m&_Read_Filename)Move_to_File u8  !* Where it goes!
    m(m.m^R_Set_Bounds_Full)	    !* Make sure bounds are full!
    Q4 m(m.m&_Move_6_Find)5  !* Find the current object!
    Q1,Q2 X7			    !* Put object in Q7!
    b,z m(m.m&_Save_for_Undo)MOVE !* So it's not perminent!
    1 f[NoQuit			    !* Can't stop here!
    fs^R Expt "N		    !* If delete called for!
	Q1-Q0 "N		    !* And there was a pre-seperator!
	    Q0,Q2 K'		    !* Kill them!
	"# Q1,Q3 K''		    !* Else kill with post-seperator!
    m(m.mFind_File)8	    !* Find where to put it!
    fs^R Argp # 2 & 6 "N	    !* Negative arg becomes pre-comma!
	1,' (fs^R Arg)m(m.m&_Move_6_Insert)75
    m(m.mSelect_Buffer)9	    !* Back to home buffer!
    				    !* Done!


!& Move MACRO Find:! !S Delimits the current macro.
Puts Q0 Q1 around preceeding delimiter and Q2 Q3 around
the following delimiter.!

    :S
    
     "L .u3 5R .u2'		    !* If we find the end, mark it!
    "# M(M.M &_Locate_Last_Local-Modes)U3
	Q3 u2'
    Q2 J -:S
    
     "L .u0 5C .u1'		    !* If we find the start, mark it!
    "# bJ :S:! "E		    !* Failure here is an error!
	    :I*NMF	No_Macro_Found fsERR'
	@0l .u0 .u1'		    !* All found!
    


!& Move N Find:! !S Delimits the current "Normal" object.
Reads delimeter <stringarg> and puts Q0 Q1 arround preceeding
delimiter and Q2 Q3 around the following one.!

    :I* [9			    !* Get our delimiter!
    :S9 "L .u3 FQ9 R .u2'	    !* If found, mark it!
    "# zJ z u3 z u2'		    !* Else mark EOF!
    -:S9 "L .u0 FQ9 C .u1'	    !* Mark beginning,!
    "# bJ b u0 b u1'		    !* Else BOF!
    				    !* Done!


!& Move PARAGRAPH Find:! !S Delimit the current paragraph.!

    [5[6[7[8[9 [A		    !* Save some regs!
    QPage_Delimiter u9	    !* Get some things we need!
    QParagraph_Delimiter u8
    :I* fo..QFill_Prefix u7
    :I* u6 :I* u5
    FQ8 "N @:I6|		    !* Start defining our!
	.-(S8 .(Q6 J)) "N	    !* Line sexer macro!
	    !"! 1A F.\-@' :"L -1 u6 0;'  !* which will!
	    "# 0 u6 0;''|'	    !* Live in QA!
    FQ7 "N @:I5|
	.-(S7 .) "E 0 u6 0;'|'
    @:IA|.f( u6			    !* Identify current line!
	1< .-(S9 .) "N -2 u6 0;'
	    .-(S
		 .) "N -1 u6 0;'65
	    1 u6 >
	) J |

    < .-z ;
	0@l MA Q6+2 "E C MA'
	Q6 u5 1@l		    !* Prepare to find the end!
	< .-z ;			    !* Loop till end of buffer!
	    MA Q6+2 "E 0;'	    !* or end of page!
	    Q6 :"G Q5 :"L 0;''	    !* or end of paragraph!
	    Q6 u5 1@l >>	    !* Looking at each line!
    .u2 .u3			    !* Mark the spot!
    < b-. ;
	0A-10 "E -1A-13 "E 2R'' 0@l
	MA Q6 u5 -@l		    !* Now go the other way!
	< b-. ;			    !* Loop till beginning of buffer!
	    MA Q6+2 "E
		C MA  Q6 "L R 0;''  !* or beginning of page!
	    Q6 :"L Q5 :"G 1@l 0;''  !* or beginning of paragraph!
	    Q6 u5 -@l >>	    !* Looking at each line!
    .u0 .u1 			    !* Done!



!& Move PAGE Find:! !S Delimit current page.!

    QPage_Delimiter [9
    m(m.m^R_Next_Page)	    !* Find the end!
    .u3 -S9 -S
     . u2 Q3 J		    !* Mark it!
    m(m.m^R_Previous_Page)	    !* And the beginning!
    .u1 -S9 -S
     . u0			    !* Mark that!
    				    !* Done!

!& Move MACRO Insert:! !S Insert Macro <stringarg> in buffer.
Place it after the <arg>th macro in the file. If a pre-comma
argument, then before the <arg>th macro from the end.!

    :I*[2 [0 [1	    !* save args and regs!
!back!
    Q0 "N			    !* Pre comma, means from the end!
	zJ Q1 "E		    !* If at the very end!
	    M(M.M &_Locate_Last_Local-Modes) U0
	    '				!* Else at the end!
	"# -Q1:S:! "E	    !* Back up <arg> macros!
		0 u1 Ofront'	    !* If not, then at the front!
	    @0l -:S		    !* Back over separator!
	    		    !* If there!
	    +1 "L 0 u1 Ofront'  !* Else at the front!
	    .u0'		    !* Put it here!
	Q0 J I
	
	 G2 
	0,1a-13"N 13i10i'
	'			    !* Insert it and quit!
!front!
    1 u0 b J Q1 "E		    !* At the very beginning!
	:S:! "E 0 u1 Oback'	    !* and no macros, then at Back!
	"# @0l . u0''		    !* Else here!
    "# Q1 :S			    !* Past <arg> macros!
				    !* But if not that many!
	 "E 0 u1 Oback'	    !* Then at the back!
	. u0'			    !* Else goes here!
    Q0 J G2 I
    
     			    !* Insert it and quit!


!& Move PARAGRAPH Insert:! !S Insert a paragraph.!

    :I* [4			    !* Get stuff to insert!
    [5[6[7[8[9 [A		    !* Save some regs!
    QPage_Delimiter u9	    !* Get some things we need!
    QParagraph_Delimiter u8
    :I* fo..QFill_Prefix u7
    :I* u6 :I* u5
    FQ8 "N @:I6|		    !* Start defining our!
	.-(S8 .(Q6 J)) "N	    !* Line sexer macro!
	    !"! 1A F.\-@' :"L -1 u6 0;'  !* which will!
	    "# 0 u6 0;''|'	    !* Live in QA!
    FQ7 "N @:I5|
	.-(S7 .) "E 0 u6 0;'|'
    @:IA|.f( u6			    !* Identify current line!
	1< .-(S9 .) "N -2 u6 0;'
	    .-(S
		 .) "N -1 u6 0;'65
	    1 u6 >
	) J |

     "E bJ			    !* If counting from the front!
	< .-z ;		    !* Do it arg times or till end!
	    0@l MA Q6+2 "E C MA'
	    Q6 u5 1@l		    !* Setup to find next paragraph!
	    < .-z ;		    !* Ends at end of buffer!
		MA Q6+2 "E 0;'	    !* or end of page!
		Q6 :"G Q5 :"L 0;''  !* or end of paragraph!
		Q6 u5 1@l >>'	    !* look at each line!
    "# zJ			    !* Else counting from the end!
	< b-. ;		    !* Do it arg times or till beginning!
	    MA Q6 u5 -@l	    !* Setup to find next paragraph!
	    < b-. ;		    !* Stop at beginning!
		MA Q6+2 "E
		   C MA R Q6 "L 0;''	    !* or start of page!
		Q6 :"L Q5 :"G 0;''  !* or start of paragraph!
		Q6 u5 -@l >>'	    !* look at each line!
    I4 			    !* Insert and quit!



!& Move N Insert:! !S Insert "Normal" object in buffer.
First <stringarg> is object, second is delimeter. Place it
after the <arg>th object in the file. If a pre-comma argument
then put it before the <arg>th from the end of the file.!

    :I* (:I* [3 W)[2 [0 [1    !* Save args and regs!
!back!
    Q0 "N			    !* Pre-comma, means from the end!
	zJ Q1 "E		    !* If at the very end!
	    I32 '	    !* Put it there!
	-Q1:S3 "E		    !* Back up arg delims!
	    0 u1 oFront'	    !* Not that many, then at front!
	I32 '	    !* Else Here!
!front!
    bJ Q1 "E			    !* At the very front!
	I23 '	    !* Put it at the front!
    Q1:S3 "E		    !* After this many!
	0 u1 oback'		    !* Not that many, then at back!
    I23 		    !* This must be right!


!& Move PAGE Insert:! !S Insert Page in <stringarg>.!

     "N zJ m(m.m^R_Previous_Page)'
    "# bJ m(m.m^R_Next_Page)'    !* Find our spot!
    z-. "E z "N I
	    ''
    I z-. "N I
	'			    !* Insert!
    

!& Locate Last Local-Modes:! !S Return the location of the local-modes block.!

    .[B FNQBJ				!* Return to where we started!
    z[9					!* Return the last point in the buffer!
					!* if there is no local modes!
    0FO..Q Comment_Start[A
    FQA :"G
	0 FO..Q Comment_Begin UA
	FQA :"G :IA;''
    0FO..Q Page_Delimiter[C
    FQC"G :ICC' "# :IC'
    ZJ
    Z,Z-10000 :FB			!* Find the start of the last page,!
    "E
	Z-10000"L J''
    .-Z"E Z'				!* If at the end of the buffer then!
					!* exit!
					!* If we found one or the other,!
    :SLocal_Modes:"E			!* search for the start of them local!
					!* vars.!
	Z'
    0l .U9				!* The default is now the start of!
					!* this line!
    -:SAC"L		!* Look for either text or a page!
					!* delimiter !
	fs s stringuA
	F~A"E Q9'	!* If text then back to the local line!
	.-(0l.)"N Q9'
	0l .'				!* If a page delimiter is found first!
					!* then use it as the location !
    Q9


!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)MOVEMOVE
1:<M(M.MDelete File)MOVE.COMPRS>W \
/ End: \
! 