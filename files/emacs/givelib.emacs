!* -*-TECO-*-!
!* <GERGELY.EMACS>GIVELIB.EMACS.16, 27-Mar-83 16:23:19, Edit by GERGELY!

!~FILENAME~:! !This library belongs to Peter J. Gergely!
PJG-lib

!& Setup PJG-LIB Library:! !S Sets up all the initial parameters needed!

    0FO..QPJG-LIB_Setup_Hook[0 fq0"G :M0'
    


!& Get Real Filename:! !S Returns the real filename of the string arg.
No string argument implies to take the current buffer filename.  Q..6
is used as the buffer string input temporarily.  A numeric argument implies
that the real version number is to be used !
    Wf[dversion Wf[dfile
    4,FFile[..6			    !* Get the string argument!
    FSHSNAME[B
    :IBBFOO..0
    FQ..6:"G
	FQBuffer_Filenames"G
	    QBuffer_Filenames U..6'
	"# W:I*B '		    !* Set the default to <home>Foo!
	'
    F[BBIND		    !* Get a temporary buffer!
    E[
    1:<1,111110000001.ez..6>"E J:X*fsdfile'
    E]			    !* Pop the input file!
    F]BBind		    !* and the temporary buffer!
    FF"E 0 fs d version'	    !* Set the version number!
    fs d file		    !* Print out the default filename!


!& Read Q-reg Name:! !S Read name of qreg, return as string.
Given a numeric argument, uses it as the first character
of the q-reg name.  ^K is short for ..K(0) (last killed text), and
^M is short for .N(0) (last mini-buffer contents).  $ and ( will call &
Read Line; $ is followed by a variable name, ( by a function yielding a
string (e.g. q:.x(3) for qvectors).  ? or  [HELP] gets help.  Colon
begins a q-vector spec, and ^B begins a buffer specification.
If given a non-zero pre-comma argument, undefined symbols return it.!

    [0 [1 :I1                      !* q0 has last char, q1 accumulates name.!
    :@I*/ M(M.M Describe) &_Read_Q-reg_Name / F[ HELPMAC
    [2			    !* Q2 gets arg, or 0 if none!
    < Q2"G Q2U0 0U2'		    !* If have arg, gobble it as 1st char!
	"# M.I FIU0'		    !* else read a char!

	Q0-"E :I*:..K(0) '   !* ^K is short for ..K!

	Q0-"E M.I FI&37.U0	    !* ^^ type spec. !
	    :I*  0  '

	Q0-"E :I*:.N(0) '    !* Short for mini-buffer contents. !

	Q0-"E !RS!		    !* read a variable name!
	    1, M(M.M &_READ_LINE) Variable_Name:__ F"E O RS' U2
					!* read a string!
	    FQ2 "E 0 FS ERR'		!* quit if null string!
	    :I1  2  
	    :FO..Q 2  "L	    !* See if name is defined!
		FF&2"N ' 
		@FT Define_Variable_"2"  !''!
		1M(M.M &_Yes_or_No)"E	    !* Not defined => should we!
					    !* create!
					    !* it?!
		   :I*C FS ECHO DIS	    !* No => cause error, to abort!
					    !* command.!
		   0 FS ERR'
		M.V 2 '	    !* yes => define it, and let command!
				    !* continue.!
	    Q1'
	
	Q0-"E !RB!		    !* buffer spec.!
	    1, M(M.M &_READ_LINE) Buffer:_ F"E O RB ' :FC U2	    !* read!
								    !* name!
	    FQ2 "E 0 FS ERR'	    !* quit if null string!
	    1, Q2 M(M.M &_Find_Buffer) F"L !* find the buffer index!
		FF&2"N '
		:I*BNF	Buffer_Not_Found FS ERR' :\U2
	    :I* (Q:.B(2+4)) '
	
	Q0-("E  1, M(M.M &_READ_LINE) Macro_String: F"E :I*' U0
		:I* ( 0 ) ' !)!
	    
	Q0-:"E 1, M(M.M &_READ_LINE) Q-Vector:_ F"E :I*' U0
	    :I* : 0   '
	    
	Q0-?"E		    !* Describe this subroutine.!
	    M(M.M DESCRIBE)&_READ_Q-REG_NAME
	    :I*CType_Q-Reg_Name:__ fsechodisp
	    F:M(M.M &_READ_Q-REG_NAME) '	    !* Then read q-reg name.!

	Q0-"E		    !* After ^R, read command name.!
	    1,M.I @FI+(
		200.*FQ1) FS ^R INDIRU0    !* 1, => Handle metizer chars.!
	    Q0/200.,.:I2	    !* Q2 gets a dot for each meta-bit.!
	    Q0&177.U0
	    :I0 2  0   !* Follow by a ^R and the basic!
				    !* character.!
	    FQ1"N Q0'		    !* If there was a dot, return this.!
	    Q0U1		    !* Otherwise, if a prefix char was!
				    !* specified,!
	    Q1 FP-101"E	    !* ask which element of it to use.!
		F=1 !PREFIX!-9"E	    !* Prefix char?!
		   f[b bind g1 !* Get name of q-vector!
		   J S @:M(Q 	    !* Decypher the function!
		      .,(SM.P 3R.)X1
		      f] b bind    !* Unbind now, or M.I will display the!
				    !* bound buffer!
		      M.I FI U0	    !* Get dispatch char!
		      [2 :I2Q:1(0)
		      2"E q0:FCu0' ]2
		      :I1 : 1 ( 0 ) ''
		Q1'
	    :I110	    !* Char not ^R =) accumulate it.!
	    Q0-.:@; >		    !* After ".', need another character.!
	Q1'

!& Set Special Mode Line:! !S Set the Mode line hook for the library!
qSet_Mode_line_hook[1
[2 1,FOption:u2
f[ b bind
fq1"L :i1'
g1 j
"E :@S/I_2/"NFKD' '
"#:@S/I_2/"E @I/I_2/' '
HXSET_MODE_LINE_HOOK
1FSMODECHANGE

!Bughunter Mode:! !C Turns on the special bughunting text in comments!

    M(M.M Load_Library)Bughunt
    m(m.m Bughunter_Mode)
    

!^R Print Object:! !^R Prints either the buffer or a file using LIST
g(M.ALIST~DOC~ ^R Print Something)jk!

    F:M(M.A LIST^R_Print_Something)


!Clean Personal Directories:! !C Does a Dired on all directories
listed in the macro.  A NUMERIC argument runs CLEAN DIRECTORIES
instead of DIRED.  Gets the directory names from the string argument.
If no string argument is given then the default name is
<home-directory>CLEAN.DIR.0 The format of this file should be one
directory name per line.  Non-existant directories will not flag
errors.!

    f[bbind			    !* Get a temporary buffer!
    :i*[buffer_filenames	    !* Remove the buffer filename!
    :i*f[dfile 0f[dvers	    !* push the filename!
    fshsname[a qa[e		    !* Get the login directory!
    etaCLEAN.DIR.0		    !* The default name is CLEAN.DIR!
    5,4fDirectory_Fileua	    !* Get the filename!
    e?a"N			    !* Does the file actually exist!
	:i*CFile_of_Directories_is_nonexistent.__Defaulting_to_e
	fsechodisp 0fsechoactiv  !* Error message!
	ec hk ie 13i 10i'	    !* Close the input and insert the!
				    !* filename in the buffer!
    "#era @y'		    !* Otherwise get the file!

    j [b [c [d			    !* Push the temporary buffers!
    0ub <.-z; 1@l %bw>		    !* Count the lines in the buffer!
    qb*5fsqvectoruc		    !* qc gets the q-vector!
    j 0ud			    !* QD is a counter for the q-vector!
    qb<:xa			    !* Get each directory!
	qau:c(qd)
	1L %d>
    hk				    !* All done then kill the whole thing!
    :i*Cfsechodisp		    !* Clear the echo area!
    0ud qb<			    !* For each directory then do!
	q:c(qd)ua		    !* QA gets the directory name!
	"E:i*AStarting_DIRED_on_afsechodisp
	    0fsechoact		    !* Tell which directory!
	    1:<M(M.M DIRED)a>"N !* If there are errors!
		:i*AError_in_Processing_Directory_afsechodisp
		0fsechoact' '
	"#			    !* If not a dired format!
	    1:<M(M.M Clean_Directory)a>"N !* If there are errors!
		:i*AError_in_Processing_Directory_afsechodisp
		0fsechoact' '

	%d>
    



!Display Variable:! !C Display a named variable with value, comment & varmac.!

    [0[1[2[3[4			    !* Save some regs !
    3,FVariable:__u4
    :FO..Q4 U0		    !* Get Slot number !
    Q:..Q(Q0) U1		    !* Full name in Q1 !
    Q:..Q(1+Q0) U2		    !* Value in Q2 !
    Q:..Q(2+Q0) U3		    !* Comment or Varmac in Q3 !
    FQ2 "L Q2 :\ U2'		    !* Make shure it is a string !
    FQ3 "L Q3 :\ U3'		    !*  ... !
    :FTName:
1
Value:
2
				    !* Type name and value !
    0:G3-! "E			    !* Is it a Varmac? !
    FTVarmac:
3
'				    !* Yes, Type it. !
    "# FTComment:
3
'				    !* Else, say it is a comment. !
    0				    !* And return !

!Get CREF Variables:! !C Makes a listing of the variables in a CREF listing.
The file should be of the type made with the /S option in CREF.  An argument 
implies that the library function will also be given.!
   
    [a [b :I*Variables_[c 0[d	    !* Push temporary variables, QC!
				    !* keeps the keyword type.!
    FF"N :ICKeywords_ 1ud'	    !* Given an argument, change values!
    j<:S; -d>		    !* Get rid of any FF!
    J -1F[^PCASE		    !* Set the case of the sort!
    L			    !* do the sort!
    J :S
AC				    !* Find the start of the list of!
				    !* variables.!
    0,.K			    !* Kill to the beginning of the file.!
    qd"E M(M.M Flush_Lines).'	    !* If no argument, then get rid of!
				    !* the library functions.!
    :IA			    !* Null argument goes to QA!
    J <.-z;			    !* For the whole buffer.!
	1M(M.M ^R_Read_Word)UB	    !* Compare variable names and if the!
	F~BA "N QBUA :K 1l	    !* same then delete that line!
	    '"# 0l 1k'
	>
    J 13i 10i			    !* Put a blank line at the!
				    !* beginning of the file!
    1ua				    !* QA will store a Page count!
    <.-z;			    !* For the whole buffer, make pages!
	50l .-z; %aw		    !* each containing 50 variables!
	12i 13i 10i>
    1,M.M Make_Columns_Chart"E	    !* Check if command exists.  If not!
	M(M.M Load_Library)Columns'	    !* load in the library.!
    QA-(FSwidth-4/8)"G		    !* Find the maximum number of colums!
	(FSwidth-4/8)UA'	    !* And if more then cut it off to that.!
    fswidth-4:\ub		    !* QB is the line width that will!
				    !* be allowed!
    qa,0 M(M.M Make_Columns_Chart)B	    !* Make the columns.!
    J :K FSDFN1uB		    !* Find the file name!
    :IBC_in_B		    !* Make a title.!
    fswidth-6-FQB/2F"G,32i'	    !* Center it!
    GB
    

!Read Teco File:! !C Reads and executes a teco file
eg. your emacs.init;  prompts for the filename.!

  M(m.m&_Read_Filename)Teco_File[1	    !* get filename!
  [..O FS BCREATE		    !* get a buffer for this!
  ER1 @Y M(HFX*)		    !* read in file, execute commands!
  fsBKill			    !* now kill the buffer we used!
0

!Reset Buffer:! !C Resets all the parameters of the current buffer.!
QBUFFER_NAME[1		    !* q1 gets the current buffers name!
QPrevious_Buffer[4		    !* q4 gets the previous buffer!
M(M.M FUNDAMENTAL_MODE)	    !* Set the modes back to normal!
0 M(M.M AUTO_SAVE_MODE)
0 M(M.M AUTO_FILL_MODE)
0 M(M.M OVERWRITE_MODE)
0FO..Qword_abbrev_mode"N
      0M(M.M Word_Abbrev_Mode)'
M(M.M SELECT_BUFFER)*GARBAGE*	    !* Select a temporary buffer to use!
M(M.M KILL_BUFFER)1		    !* Kill the old buffer!
M(M.M RENAME_BUFFER)1	    !* Rename the temporary to be what!
				    !* the old one used to be.!
q4 uPrevious_Buffer		    !* Reset the previous buffer!
f~1MAIN"E :i*GAZONKu1'	    !* If the buffer's name is MAIN then the!
fshsname[3			    !* default name is GAZONK.  Default every-!
:i*31..fsdfile		    !* thing to home dir. and version 0!
0fsdversion


!SYSDPY:! !C Calls the program SYS:SYSDPY as a subfork.  The fork is
  deleted after the program is exited.  Any string argument is used as
  subcommands to the program.!

1,FSub-commands:f([2)f[forkjcl  !* Q2 gets any string argument!
[1 :i1SYSDPY			    !* Q1 gets the program name, SYSDPY!
    fsOSTeco-1"e		    !* If TWENEX teco then do!
	-(fzSYS:1.EXE)fz
      '
    "# -(fz<SUBSYS>1.SAV)fz'    !* 10X, use losing <SUBSYS>.!
    

!Same Version:! !C Tells EMACS to overwrite file when it saves it.
I.e. this file will be saved as the SAME version as the
current version on exit.  Autosaves will go to AUTOSAVE files.
Does nothing if visited file already has an explicit extension.
With zero argument, undoes it, i.e. EMACS will write new versions.!

0[0 1[1 1[2
FF-1"E u2'		    !* put arg in 2!
QBuffer_Filenames F[D FILE	    !* Get current filename!
Q2:"G 2u1			    !* 0 or neg arg -> make version 0!
  '"# FS D VERSION"N 0'	    !* If already has version#, do!
				    !* nothing!
   1:<EREC>"N			    !* Look at latest version!
       1U0			    !* Can't find file; perhaps it is new!
       Z"G @FTNew_file?_--_Assuming_version_1
        0FS ECHO ACTIVE'	    !* If not empty buffer, state assumption!
     '"# FS IF VERSION U0''	    !* extract version number!
Q0 FS D VERSION		    !* set version of "default" file!
FS D FILE UBuffer_Filenames	    !* set the emacs variable!
1FS MODE CHANGE		    !* Mode line changed!
QAuto_Save_Mode-Q1"E		    !* If autosaving in the "wrong" mode!
  @M(M.MAuto_Save_Mode)'	    !* Adjust for current filenames!
0

!^R Add Mode Comment:! !^R Puts a comment at start to indicate mode.
Adds a comment (of the current mode) at the beginning of the buffer,
which indicates that this mode should be used on subsequent edits of
this file. Overwrites a previous mode comment if there is one.!

    1,M.M&_Setup_PAGE_Library"N
	M(m.m ^R_Widen_Bounds)W'
    "# M(m.m ^R_Set_Bounds_Full)W'
    1[1 [2
    j 1l  -2:s-*-"n		    !* If already a mode line !
        j k'			    !* then kill it. !
    qbuffer_filenames fsdfile
    J   f~(fsdfn2)FOR "E IC_______ o done '
    f~(fsdfn2)B20 "E i00001w9i iREM_ o done '
    f~(qmode)FORTRAN "E IC_______ o done '
    f~(QMODE)BASIC "E i00001w9i iREM_ o done '

    J 0FO..QComment_BeginF"E W 0FO..QComment_Start'[2
    fq2"G G2 0u1'		    !* Start a new comment!
    
    !done!
    qMode[0			    !* Get current mode !
    i-*-0-*-			    !* Insert it !
    q1"Egcomment _end'	    !* End comment !
    i
				    !* Add a <cr>!
    b,. 			    !* And quit !


!^R Adjust Line:! !^R Moves current line according to the post-comma argument.
The pre-comma argument is the repeat count
No post-comma argument or =0  --  centers the line removing preceding and
				  following whitespace.
		          <0  --  lines up the line with the left margin
				  removing the whitespace as above.
		          >0  --  lines up the line with the right margin
				  removing the whitespace as above.!

    0[c 1[d			    !* Push the temporary registers!
    FF F"N-2 F(:"L ud'	    !* Get the right arguments!
	    )"N uc''
				    !* QC is the type of operation and!
				    !* QD is the repeat count!
    QD  <
				    !* Get rid of all the whitespace!
	0l W M(M.M ^R_Delete_Horizontal_Space)
	:L W M(M.M ^R_Delete_Horizontal_Space)
				    !* If the line is too long then!
				    !* omit it.!
	Fshposition-(W0FO..QFill_Column)"G 1l !<!>'
	QC"E W @M(M.M ^R_Center_Line)'	    !* QC=0 implies center!
	QC"G W @M(M.M ^R_Right_Adjust_Line)'	    !* QC.gt.0 implies!
						    !* right margin!
	QD"L -'1@L>			    !* Next line!
    -QD @F  F		    !* Refresh only the lines changed!
    QD  -1"E			    !* If only one iteration, then stay!
	0,0A-13"E-2*QD:C'	    !* on the same line, and if left!
	QC"L 0l''		    !* justification go to the beginning.!
    0


!^R Autoargument:! !^R To put on M-digit, M--, and ^U.!

    FS Qp Ptr [.0		    !* Spot to unwind to!
    Q..0 & 127 [.7		    !* Save our caller!
    Q.7-U "E  u.7'	    !* Hack Hack!
    [.1[.2[.3[.4[.5[.6[.8	    !* Save some Q-regs!
    :I.1 0u.5 0u.8		    !* Initalize!
    0u.2 0u.3 0u.4 0u.6		    !* !
    <   Q.7- "E Q.21 u.2 %.4 oL'	    !* Count ^U's!
	Q.7-- "E Q.2#41 u.2 oL'	    !* Change sign on -!
	Q.7-, "E 0.1 u.5	    !* Save pre comma arg!
	    Q.4 "N Q.5 "E 1u.5''    !* !
	    Q.2 & 4 "N -Q.5 u.5'    !* Maybe negate!
	    Q.4< Q.5*4 u.5>	    !* Maybe some ^U's!
	    Q.2 & 1 "N 1'"# 0' u.8  !* Really something there!
	    0u.2 0u.4 :I.1 oL'    !* Reinitalize!
	:I.1.1.7		    !* Accumulate digits in Q.1!
	Q.2  3 u.2		    !* Say we saw something!
    !L! 4,m.I			    !* Loop as long as we like the chars!
	:FI F0123456789-, :;   !* We like these!
	FI u.7 >		    !* Gobble char!
    3,m.I @FI u..0		    !* Char that stopped us!
    FQ.1 "N .1 u.3'		    !* Compute the arg!
    Q.2 FS ^R Argp		    !* Set flags!
    Q.3 FS ^R Arg		    !* !
    Q.4 FS ^R Expt		    !* !
    Q.2 & 2 "E 1u.3'		    !* Default arg is 1!
    Q.2 & 4 "N -Q.3 u.3'	    !* Maybe negate!
    Q.4< Q.3*4 u.3>		    !* Maybe some ^U's!
    -1 FS^R LastW -1 FSReRead	    !* !
    Q.8 "N			    !* If pre-comma!
	Q.5,'(Q.2 & 3 "N	    !* If post-comma!
	    Q.3') @:m(		    !* Call our terminator!
	Q..0FS^RIndirect@FS^RCmacro (Q.0FSQpUnwind))



!^R Bufed:! !^R Display information about current buffers.
g(m.aBUFED~DOC~ BUFED)jk!
    F:M(M.A BUFED)

!^R Directory Edit:! !^R Allows a wildcard directory DIRED.
g(m.aDIRED~DOC~ Directory_Edit)jk!
    F:M(M.A DIREDDirectory_Edit)


!^R Find Unmatched Objects:! !^R Find improper nesting of objects.
Numeric argument is the starting level.  The first string argument is
the starting object and the second one is the end of the object.
Comments are ignored and are defined via the variables $Comment Start$
and $Comment End$.!

    1,FStart_of_Object:_[S	    !* QS gets starting string!
    FQS:"G '			    !* If NULL then return!
    1,FEnd_of_Object:_[E	    !* QE gets ending string!
    FQE:"G '			    !* If NULL then return!
    FF"N 0-(  )' "#0'[L [A  !* QL gets the current level to!
				    !* start at.  QA is temporary!
    0FO..Q Comment_Start[C	    !* QC gets comment start!
    0FO..Q Comment_End[D	    !* QD gets comment end!
    FQC:"G :IC'		    !* If no start then set for no match!
    FQD:"G 10:ID '		    !* If no end then assume linefeed!
    1[0				    !* Q0 gets number of CTRL-O is!
				    !* comment start!
    f[bbind			    !* Push a buffer!
    gc J <:S; %0W>	    !* Count the CTRL-Os!
    f]bbind			    !* Pop the buffer!
    q0+1[1			    !* Q1 gets the accumulated CTRL-Os!
				    !* including those in QS!
    f[bbind			    !* Push a buffer!
    gs J <:S; %1W>	    !* Count the CTRL-Os!
    f]bbind			    !* Pop the buffer!

    :IACSE		    !* QA gets the complete search string!
    <!LOOP! .-z; :SA;	    !* Loop here to search!
	fs svalue+q0 :"L	    !* If in the comment start area!
	    :SD"E :I*C Unmatched_Comment.fsechodisp  !* Notify!
							    !* if no match!
		0fsechoactive W' OLOOP' !* Else just continue!
	fs svalue+Q1 :"L	    !* If in string start!
	    .F(Wfs inslenR .)J	    !* Put mark before comment start!
	    QL-1UL'		    !* Decrement level count!
	"# %LW'			    !* Increment Level count!
	QL "'G :;>		    !* Quit if positive!
    QL F(:\UL			    !* Convert level to string!
	:I*C Nesting_Level_=_L.fsechodisp !* Output the nesting level!
	0fsechoactive
	)


!What Page:! !^R Indicate Page/line:! !^R Types out page and line number of cursor!

    0f[VB			    !* [PJG] Open the top bound!
    0[1 .[2 fnq2j		    !* To restore point on exit!
    1l.[3			    !* q3 = address of start of next line!
    0[4 0[5 0[7			    !* q4,5 = address of current, next page!
    QPAGE_DELIMITER[8
    0j <%1 			    !* increment page counter!
	:s
8; .u5			    !* Search for page delim, throw ifn found!
	.-1-Q2;			    !* if past point then we're there!
	.u4>			    !* Record address of ^L and iterate!
    :i*C fs Echo dis	    !* Clear echo area!
    @ft_Page_ q1@:=		    !* Give page number!
    @ft,_Line_			    !* ", Line " ...!
    m.m&_Count_Lines[6		    !* get line counting routine!
    q4,q3 m6 f(u7) @:=		    !* Count lines this far and print result!
    @ft_of_
    q5-q4:"G zu5'"# q5-1 u5'	    !* Set q5 to end of page!
    q3-q5"G -1'"# q3,q5 m6' +q7 @:= !* if q3 is past q5, we must be off!
				    !* the page; otherwise, count rest!
				    !* of lines, add up and print!
    @ft.

    0fs echo active		    !* indicate we typed something!
    1

!^R Insert Controlified:! !^R Inserts characters, controlifying
e.g. If you type ^R Insert Controlified A, it inserts ^A; DELETE is ^?.
Type ^R Insert Controlified ' to enter a number octally.!

  M.I FI & 177. [0		    !* read the character, AND out!
				    !* control bits!
  (q0-')*(q0-7) "E		    !* read octal number!
     1,M(m.m&_Read_Line)Octal:_ u0	    !* get number string in q0!
     q0"E 0' fq0"E 0'	    !* exit if none!
     f[bbind 8f[ibase g0 0j \ u0  !* convert q0 to number!
     f]ibase f]bbind'
   "# q0 & ? -? "E 177.u0'	    !* If a ? or DEL, do DEL (177)!
   "# q0 & 37. u0''		    !* otherwise controlify!
  .,(<q0 i>). 

!^R Place Pointer on Location:! !^R Moves pointer to the given location.
The following arguments are defined.
	Pre-Comma	Page No. a la Page Delimiter (Default = 0, Current)
	Post-Comma	Line Number on Page (Default = 1, Same line as FF)
	String Arg.	Character Position (Default = 0, Before first
			char.)!

    @FN| 0FO..QCurrent_Page"N
	0UCurrent_Page
	W:@M(M.M ^R_Goto_Page)'|

    0FsVB 0FsVZ		    !* Open the whole bounds!
    0FO..QPage_Delimiter"E
	:IM.CPage_Delimiter*_Search_String_For_Finding_Page_Boundaries'
    QPage_Delimiter[A		    !* Qa gets the page search string!
    0[0 1[1 0[2			    !* Temporary registers are: !
				    !* Q0 = Page Number!
				    !* Q1 = Line Number!
				    !* Q2 = Char. Pos!
    FFF"N-2:"L U0'
	WU1'W			    !* Given arguments then define!
				    !* them correctly.!
    :F"L 0[B'
    "# :I*[B		    !* QB is just a temporary register!
	f[bbind GB J \u2 f]bbind' !* Decode the string argument into!
				    !* a number!
    Q0"G 0J q0-1U0'		    !* If the page number is positive!
				    !* then got to the beginning!
    Q0M(M.M ^R_Mark_Page)	    !* Otherwise Mark the page!
    M(M.M ^R_Set_Bounds_Region)    !* Close the bounds!
    J Q1-1@L			    !* Count only CRLF!
    :@L fsShpos-q2"G 0@L q2:C'	    !* Check to see if we are not!
				    !* exceeding the line and then!
				    !* count those characters!
    0,fszFsboundaries		    !* Open bounds in full!
    


!^R Query Replace:! !^R Query Replace using the minibuffer. 
Calls the Query Replace command. !
    :I*[1 :I*[2
    FFF"N (			    !* Check for any numeric arguments!
	) -2:"L			    !* If we have two or more, then!
	    :\U1 FS^RARG"N:\U2'	    !* Put ^X, into q1 and!
					    !* then followed by ^Y if!
					    !* explicitely non-zero!
	    :I11,2'
	"#			    !* Otherwise!
	    :\U1 ' '		    !* Only the post-comma into Q1!
    M( M.M &_MINI_INIT ) 1_MM_Query_Replace    Query_Replace 



!^R SYSDPY:! !^R Runs the sysdpy program!
    M(M.M SYSDPY)SYSDPY


!^R Toggle Overwrite Mode:! !^R Inverts state of overwrite/insert.
If inserting (normal), then goes into overwrite mode; if in overwrite
mode, reverts to normal insert mode.!

QOverwrite_Mode"E -1'"# 0' uOverwrite_Mode


!^R Mc Uppercase Initial:! !^R Uppercase just the initial or a Mc word!

 m.m^R_Forward_Word[0
 "L m0 '"# 1m0w -1m0 '	    !* Position to start of first word to do!
 .,(   f"e w 1 ' <		    !* Iterate abs of arg times, but at least once!
	fw@fc			    !* Uppercase this word!
	.( <fw:fbMc; -1 fc 1c fwfc> )j   !* Fix Mc!
	.( <fw:fbMac; -2 fc 1c fwfc> )j  !* Fix Mac!
	fwr > ). 		    !* Return range of buffer modified!


!^R Mc Uppercase Word:! !^R Capitalize Mc word!

 m.m^R_Forward_Word[0
 "L m0 '"# 1m0w -1m0 '	    !* Position to start of first word to do!
 .,(   f"e w 1 ' <		    !* Iterate abs of arg times, but at least once!
	fw@fc			    !* Uppercase this word!
	.( <fw:fbMc; -1 fc > )j   !* Fix Mc!
	.( <fw:fbMac; -2 fc > )j  !* Fix Mac!
	fwr > ). 		    !* Return range of buffer modified!



!& MOR Mode:!!Mortran Mode:! !S Set up for Mortran editting
Makes Rubout the Tab-hacking Rubout.  Tab does ^R Indent Nested.!
M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
M(M.M Make_Local_Q-Register)..D
1,1M.L Space_Indent_Flag
1,16 M.L Comment_Column
1,(:I*"!'!) M.L Comment_Begin
1,(:I*"!'!) M.L Comment_Start
1,(:I*"!'!) M.L Comment_End
1,(:I*) M.L Paragraph_Delimiter
1,(M.M ^R_Indent_Nested)  M.Q I
    1,(W377.@FS^RINIT)M.Q
    1,(W177.@FS^RINIT)M.Q.
1,(:i*SUBROUTINEPROCEDUREINTEGER_FUNCTIONREAL_FUNCTION) M.L Page_Delimiter
1M(M.M&_Set_Mode_Line) Mortran 



!^R Auto Fill Comments:! !^R Refill the comment and its continuations.
To handle comment starts (or parts of them) that are repeated, e.g.
";;; " in Lisp, or perhaps "/*** " in Pl1, it will treat a duplicated
last character of the comment start or begin as part of the comment
beginning when merging comment lines.  A numeric argument is the repeat count.!

    [1[2[3[4[5[6[A
    qComment_Startu1			!* 1: Real, minimal start string.!
    qComment_Endu2			!* 2: End string or 0.!
    fq2"e 0u2'				!* Either 0 or non-null.!
    qComment_Beginu3			!* 3: Desired pretty-start string.!
    fq3:"g q1u3'			!* 3: If no begin, then use the start!
					!* string for convenience.!
    fq1-1:g1u5				!* 5: Last character in start string.!
    qFill_Extra_Space_Listu6		!* 6: Characters that take 2 spaces.!

    :"G FG 0'
    0l .uA
    <
	0l :fb1"N			!* Beep and exit if no comment.!

!* Merge this comment and its continuations into one comment line: !

	    <  q2"e :l'"# :fb2'	!* To end of comment.!
		.u4			!* 4: Point at comment end.!
		l @f	_l	!* After next lines indentation.!
		fq1 f~1:@;		!* Exit if not comment start.!
		q4,.k			!* Remove the whitespace between!
					!* comment and continuation comment.!
		q2"n -fq2d'		!* Delete the comment end.!
		fq3 f~3"e fq3d'"# fq1d'	!* Remove any comment begin or!
						!* start.!
		@f5k		!* And iterated last character.!
		-@f	_l @f	_k	!* Kill surrounding!
							!* whitespace.!
		0af6:"l 32i' 32i	!* Insert space to separate.  Or 2!
					!* spaces for some.!
		>			!* Keep merging.!

!* Now repeatedly auto-fill this line until it fits.  Calling ^R Auto-Fill!
!* Space with an argument of 0 tells it to insert no spaces but fill once if!
!* necessary.  We limit the number of iterations to a reasonable maximum (each!
!* auto-fill should rip off at least one space + one char (word).  This is so!
!* some buggy auto-filler or tab wont infinitely keep causing us to fill.!
	    
	    q4j 0l			!* Back to comment line.!
	    m.m ^R_Auto-Fill_Space[1	!* 1: Space.!
	    :l 0f  /2< .-(0m1f	!* Auto-fill maybe, tell ^R mode.!
		   ).@; >		!* Repeat until point doesnt change.!
	    ]1 :l'
	WL>
    -1l :L
    QA,.


!^R Change Case Letter:! !^R Next <argument> letters, moving past.
Numeric argument negative means move left.
Fast, does not move gap.!
 [1
 "g				    !* Positive NUMARG, move right. *!
    .,( :< 1af"a#40.:i1	    !* 1: Changed case if letter. *!
		  f1'w	    !* Change to that letter. *!
	     c >w ).'
 				    !* Negative NUMARG, move left. *!
 .,( -:< r 1af"a#40.:i1	    !* 1: Changed case if letter. *!
		  f1'w	    !* Change to that letter. *!
	   >w ).



!Flush Variables:! !C Kill some variables specified by search string.
Kill variables whose name contains the string argument.
String argument actually is a TECO search string, and so you can flush
    variables containing "foo" OR "bar" by using the string argument
    "foobar".
The list to be flushed is typed, asking Y, N, or ^R?
    N means abort, ^R allows editing of the list.!

    :i* [.1			!* .1: Stringarg to match killees. *!
    f[BBind				!* Temp buffer. *!
    q..o m(m.m List_Variables).1	!* Insert list of all vars. *!
    1f<!DONE!
	f<!KILL!
	    :ft Killing_the_following_variables:

	       ht
	    ft
	    Ok?_(Y,_N,_^R)_
	    fi :fc [.2			!* .2: Response. *!
	    1< q.2 fYN"L ftAnswer_must_be_Y,_N,_or_^R.
		   
		   1;'			!* Go type list etc again. *!
		q.2-Y"E f;KILL'	!* Y, go kill these vars. *!
		q.2-N"E f;DONE'	!* N, dont kill, just quit. *!
		q.2-"E		!* ^R Edit, then reask. *!
		   0u..h  1;'		!* ... *!
		>			!* End YN^R check. *!
	    >				!* After this, can kill. *!

	bj				!* Start killing at top. *!
	m.m Kill_Variable[K		!* K: Killer. *!
	< 1:< 0,25fm			!* Go to probable end of varname. *!
		-:fwl			!* Back to end of last word. *!

!* Now have to figure enough of variable name to be unambiguous:
 * The buffer has a list made by List Variables which includes a description
 * of the value, and we cant really tell where a long variable name ends and
 * the value description begins.  We will find out by trying the first 25
 * letters, which is definitely part of the name, and checking if that is
 * ambiguous.  If so, we append the next word of the line, which must be
 * another part of the variable name, and again check for ambiguity.  The
 * variable name will eventually be unambiguous.
 *!

		< 0x.2			!* .2: Up to first 25 lets of name. *!
		   1:<fo..q.2w>-(@feAVN)@:;	!* See if .2 is unambig. *!
		   fwl >		!* If not, include next word. *!
		
		mK.2			!* Kill the variable. *!
		>			!* Error in fm means blank line. *!
	    l .-z; >			!* Next line if any. *!
	>				!* End of done catch. *!
    0u..h 				!* Exit, refreshing screen. *!


!^R Break Line:! !^R Fill if too long, even out of Auto Fill mode.
Cursor may be anywhere within line.
Line will be broken (space inserted at margin) repeatedly until it
    fits within the margins.
Uses ^R Auto-Fill Space.!

!* Ugly on printing terminal.  Dont know how to fix that.  ^R Auto-Fill!
!* Space does its own redisplay that fouls us up.!

 .[0					!* 0: Original point.!
 0l .[1					!* 1: Start of line.!
 1[Auto_Fill_Mode			!* Temporarily in fill mode.!
 m.m^R_Auto-Fill_Space[S		!* S: Filler.!
 :l <.-(0msf).@;>			!* Fill as much as can.!
 q0:j"e :l'				!* Restore point, or end of line.!
 fsRGETTY"e 0t'			!* Printing tty.!
 1

!Make Structures Directory:! !C Creates an index to the directories on alternate structures.
Creates an indented structures directory using the files given as the string
argument.  The default filespec is PS:<STRUCTURES>*.DLUSER.  The final result
is placed in the buffer *STRUCTURES*.  The precomma-argument specifies the
number of columns to use, and the post-comma is the page width.  The defaults
are 3 columns on 80 characters wide pages.  A negative or zero page width
prevents the columnar chart from being performed.!
 
    M(M.M Select_Buffer)*STRUCTURES*	    !* Select this buffer!
    :i*[buffer_filenames	    !* Remove the buffer filename!
    :I*F[DFile 0F[DVERSION	    !* Zero is the default version number!
    E[ E\ FNE^ E]		    !* Push the input and output!
    etPS:<STRUCTURES>*.DLUSER	    !* The default name is!
    5,2F Directory_ [..6	    !* Read in a directory file name!
    FQ..6 :"G :I..6 PS:<STRUCTURES>*.DLUSER'	    !* If nothing given then!
						    !* set default!
    3[0 80[1			    !* q0: Columns, Q1: Page width!
    FF F"N-2 F(:"L   u0'    !* Get the right arguments!
	    )"N u1''
    0,fsz fsboundaries WHK	    !* Open all bounds and kill page!
    1,111110000001.ez..6	    !* Insert the file directory!
    JM(M.M Keep_Lines).DLUSER.    !* Retain only these!
    J <.-z;
	0l @I\M(M.M Insert_File)\ W:L 27i 1l>	    !* Create a macro!
    [A HFXA 0[B 0[C 0[D		    !* Save some registers!
    MA				    !* Inserts the files!
    JM(M.M Keep_Lines)&	    !* Lines with & are directory names!
    JM(M.M Replace_String)&<>	    !* Get rid of these characters!
    J0l:L1l		    !* Sort the whole file!
    J :IA			    !* Separate the different structures!
    <.-z; W.,(S:w.)XB 0l	    !* into pages!
	F~AB"E FQAD' "# qbua 12i fqac 13i 10i'   !* When first words!
	1l>			    !* are different!
    J 1d zj 12i			    !* Kill the first formfeed and insert one!
				    !* at the end!
    J 1l			    !* To the second line in the file!
    <.UC :S
;			    !* For each page, do!
	QC,.-1 fsboundaries	    !* Narrow for what we are working with!
	J :IA______ 1UC -1UD	    !* Starting storage!
	< QD; WJ 0UD		    !* Find subdirectories of directories!
	    <.-z;		    !* For the whole file!
		:L.-(0l.)UB	    !* Find the length of the line!
		FQA-QB"G QB' "# fqa'  XB   !* Use it instead of the key!
					    !* length if smaller!
		F~AB"E	    !* Check the two keys!
		   FQAC 0,1a-."E  !* If the same and next character a .!
		      -1ud 0K QC*2F"G,32i'  !* Then a subdirectory and indent!
					    !* accordingly!
		      '"# 0l :XA''  !* No then just take the new name!
		"# 0l :XA'
		1l>
	    QD"N %C'>		    !* Increment indenting if found a!
				    !* subdirectory!
	ZJ .,fsz fsboundaries	    !* Open the bounds!
	1l>			    !* do it again!

    0,fsz fsboundaries	    !* Open the bounds!
    zj -1d  WJ			    !* Get rid of last ff!
    etstructures.info.0	    !* Set default filenames!
    fsdfileF(UBuffer_Filenames)U:.B(QBuffer_Index+2!*bufvis!)

    Q1F"G:\[9			    !* Need to make columns?!
	1,M.M Make_Column_Chart"E  !* Try to load column generating!
				    !* functions!
	    1:<1,M(M.M Load_Library)NCOLUMNS>"N W''	    !* If not already!
							    !* done!
	q0,0 M(M.M Make_Columns_Chart)9'	    !* Make the columns if so!
						    !* desired.!
	    
    

!Insert Directory:! !C Inserts a list of a file directory into the buffer.
With no argument, inserts that directory.
With an argument of 1, inserts only the versions of the file in the buffer.
With an argument of 4, asks for input, only versions of that file are
    inserted.
A pre-comma argument says to insert the author for each file.
The first string argument is the directory to scan.
The second string argument is the octal flags used in the JFNS call.  The
default flags are 111110000001 octal, signifying to print the device,
directory, filename, extension, and version number.  Please refer to the
TOPS-20 Monitor Calls Reference Manual for more detail.!

    FS OSTECO-1 "N
	:I*CThis_function_is_only_valid_on_Tops-20. fsechodisp
	0fsechoactive W0'
    :F"G OASK'
    FF-1"G OASK'
    QBuffer_Filenamesf"n fs D File	!* If we don't have buffer file names,!
					!* assume arg of 4!
	FF"E :I*[..6 OGOTONE'	!* With no arg, pass null string.!
	"# -4"L FSDFN1[..6		!* With arg of 1 use the FN1 name!
		:I..6..6.*.*
		OGOTONE '''
!ASK!
    5,2F Directory_ [..6		!* With an arg of 4,!
					!* or no buffer file names!
!GOTONE!
    1,FOctal_Flags_(Default:_111110000001):__ [..7
    FQ..7"G
	1:<..7.[0>"N :I..7''
    "# 111110000001.[0'
					!* Q0 contains the JFNS flags!
    .:				!* Push the current location!
    FF&2"E 1,' Q0ez..6		!* If a precomma argument then insert!
					!* the author as well!
    


!*
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.M& Generate MASSIVE) \
/ End: \
!
   