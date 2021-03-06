!* -*-TECO-*- *!
!* <GERGELY.NEMACS>DIRED.EMACS.3, 11-Apr-83 10:17:55, Edit by GERGELY!
!* <EMACS>DIRED.DREA.29, 20-Nov-81 08:32:55, Edit by GERGELY!
!~FILENAME~:! !Directory Editor Subsystem!
DIRED

!<ENTRY>:! !& DIRED enter:! !& DIRED:! !C Edit a directory.
The string argument may contain the filespec (with wildcards of course)
	Enters ^R mode with the directory in the buffer with the
following commands:
	? types this cruft.
	A archives the file on the current line.
	C calls srccom on the current line file and its most recent version.
	D deletes the file which is on the current line. (also K,^D,^K)
	E edit the file in a recursive ^R.
       ^E edits the file in a recursive EMACS. ^U^E saves fork for EFORK.
	H puts D's by files that seem to need them.  ^UH does whole dir.
	I sets the file on the current line invisible.
	L lists the file on the line printer.
	N moves to the next file of which there are more than 2
	  copies. (n M.VFile Versions Kept to find more than n copies). 
	O puts D's by the intermediate files. ^U O does the whole dir.
	Q lists files to be deleted and asks for confirmation:
	  Typing YES deletes them; X aborts; N resumes DIRED. 
	R does a reverse sort.
	Rubout has the effect of U but for the previous line.
	S sorts files according to filename, size, read or write date.
	Space is like ^N - moves down a line.
	U cancels the effect of (A, D, or I) for the file on the current line.
	V views the file.  Space advances a screen and backspaces
          backs up one screenful.  Rubout stops viewing the file
	  gracefully.  Any other character does its normal action.

The A,D,I,E,Rubout,U commands repeat if given an argument, backwards
if negative.  The L command lists |arg| files with negative argument
implying an alternate output specification will be prompted for!


    0[..F			    !* Fix so cannot visit a file!
    f[ B Bindw f[ D File f[ S Stringw 1f[ Fnam Syntax
    m.m&_DIRED_^R_Enter f[^R enter	    !* Make next ^R be a DIRED-command!
					    !* loop.!
    M(M.M &_Get_Real_Filename) fsdfile   !* Buffer filenames are default!
					    !* filenames.!
    et*.* -3fs dversionw	    !* set default for reading filename!
    5,2fDirectory_[1 et1	    !* Read filenames wanted.!
    fs osteco-2"e
	g1 j <:s;u1 q1+1; c>
	'
    "# g1 j <:s.u1 q1+1; c>
	q1"n <:s.u1 q1+1; c>''
    q1"e -3fsdversionw'
    fsdfileu1 hk 001110066011.ez1
    1-fsosteco"N		    !* On ITS or TENEX do this!
	j 9i g(fs d dev)
	i:< g(fs d snam) i>
	
	'			    !* Put in name of directory!
    "#
	[1 f[bbind		    !* Get a temporary buffer!
	1,110000000001.ez1	    !* Get the files so can get the real!
				    !* directory and device names!
	J :X1 f]bbind		    !* Put in Q1 for now!
	J 9i G1 13i 10i 13i 10i	    !* Insert it in the buffer!
	]1'			    !* Pop Q1!

    M(M.M &_DIRED_Pretty_File_Display)	    !* Display the files!
    j 2@l
    ET DIRECTORY-EDIT.TMP	    !* Make sure writing it out!
				    !* doesn't clobber anything.!
    0fs modif 
    [..J :I..J DIRED
    
    f<!DIRED_outer!		    !* what a weird control structure!
	f<!DIRED_loop!
	    1f[ read only	    !* Dont allow unknown buffer munging.!
	    f[ d file		    !* Don't let user clobber!
				    !* directory name within dired!
	    0u..h 		    !* ^R mode to edit the direc!
	    f] d file f] read only	    !* Now can munge it.!
	    
	    :I*M.V Dired_Files_to_archive !* Create the variable for!
				    !* archiving!
	    
	    m(m.m&_DIRED_Request_Confirmation)DDeleting"n
				    !* find what!
		m(m.m&_DIRED_Deleting_Action)'	    !* do it, if!
				    !* anything to do!
	    m(m.m&_DIRED_Request_Confirmation)ISetting_Invisible"n
				    !* find what to do!
		m(m.m&_DIRED_Invisible_Action)'    !* do it,!
						    !* if anything to do!
	    
	    m(m.m&_DIRED_Request_Confirmation)AArchiving"n
				    !* find what!
		m(m.m&_DIRED_Archiving_Action)'    !* do it, if!
	    
	    M(M.M Kill_Variable) Dired_Files_to_archive   !* anything to do!
	    			    !* done!
	    >			    !* end DIRED_loop!
!*** Here after exiting DIRED_loop:  just edit the directory again!
	j 2@l			    !* get cursor in canonical posn!
	>			    !* end DIRED_outer!

!& DIRED Help:! !S Type our help msg.!

    m(m.mdescribe)&_DIRED 


!& DIRED Down:! !& Make ^R's below DIRED behave normally!
				    !* Created by Raymond D. Holmes!

    0 f[ ^R Enter
    -1[1 QDIRED_Saved_Commands [0
    Q:0(%1) [_ Q:0(%1) [? Q:0(%1) [.D
    Q:0(%1) [.K Q:0(%1) [ Q:0(%1) [.E
    Z fs ^R Init f([Q) f([U) f([N) !* 
!   f([D) f([K) f([E) f([H) f([R) !*
!   f([S) f([O) f([C) f([X) f([A) !*
!   f([L) f([I) [V
    0 f[ ^R Normal


!& DIRED ^R Enter:! !S FS ^R ENTER for DIRED.
Make next ^R be a DIRED command loop.!
				    !* Created by Raymond D. Holmes!
    m.m&_DIRED_Down F[ ^R ENTER   !* Don't screw any recursive ^R's (eg!
				    !* minibuffer).!
    0@fo..Q DIRED_Saved_Commands "E !* If first DIRED!
	6.*5fs Q Vector [0 -1[1    !* Must save key defs!
	Q0 m.V DIRED_Saved_Commands
	Q_ u:0(%1) Q? u:0(%1) Q.D u:0(%1)
	Q.K u:0(%1) Q u:0(%1) Q.E u:0(%1)
	]1 ]0'
     FS ^R INIT [_	    !* Space moves down a line.!
    27 FS ^R INIT [X		    !* X exits the DIRED ^R.!
    27 FS ^R INIT [Q		    !* Q exits the DIRED ^R.!
    M.M &_DIRED_Undelete [U	    !* U takes away a delete-mark.!
    M.M &_DIRED_Next_Hog [N	    !* N finds next file with >2 versions.!
    M.M &_DIRED_Help [?	    !* ? prints documentation.!
    M.M &_DIRED_Archive_File [A  !* A Archives this file!
    M.M &_DIRED_Delete_File [D   !* D deletes this file.!
    M.M &_DIRED_Invisible_File [I	    !* I set Invisible this file!
    QD [K			    !* So does K.!
    QD [.D			    !* !
    QD [.K			    !* !
    M.M &_DIRED_Examine_File [E  !* E edits!
    M.M &_DIRED_Reverse_Undelete [	    !* Rubout undeletes backwards.!
    M.M &_DIRED_Automatic_Delete [H	    !* H puts in D's appropriately!
    M.M &_DIRED_Reverse_Sort [R  !* R does reverse sorting.!
    M.M &_DIRED_Sort [S	    !* S does forward sorting.!
    M.M &_DIRED_SRCCOM_File [C   !* C calls SRCCOM!
    M.M &_DIRED_List_File [L	    !* L lists the current file on LPT:  !
    M.M &_DIRED_View_File [V	    !* V views the current file!
    M.M &_DIRED_Automatic_Intermediate_File_Delete [O    !* !
				    !* O keeps the oldest and!
				    !* the newest version of a file!
    M.M &_DIRED_Edit_File [.E    !* ^E edits the current file.!
    @:I*|WFG | f[ ^R Normal	    !* don't run any self inserts!


!& DIRED Archive File:! !S Marks the current file for ARCHIVING!

!* This section written by Peter J. Gergely, DREA 10 November 1980!

    1-fs osteco"n fg 0'	    !* not on ITS or TENEX!
    0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
    0f[ read only		    !* Allow munging the buffer.!
    
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
	
	0,1A-68F"E		    !* The file has been marked for!
				    !* deletion!
	    :I*CCannot_Archive_a_deleted_file.
	    fsechodisp0fsechoactive	    !* Send out an error message!
	    0L 0'		    !* Make sure at the beginning of!
				    !* the file!
	"#+68-73"E		    !* The file has been marked as!
				    !* invisible!
		:I*CCannot_Archive_an_invisible_file.
		fsechodisp0fsechoactive  !* Send out an error message!
		0L 0''	    !* Make sure at the beginning of!
				    !* the file!
	1a-32"e fA '		    !* Mark one file as Archived.!
	"g @l ' >
    
      -1"E
	-@l+1 (@l)'"# -@f '	    !* Mark these lines!
				    !* as changed.  This!
				    !* replaces the old type so that!
				    !* it can allow for ^J in the!
				    !* filename.!

!& DIRED Delete File:! !S Delete current file.!

				    !* Created by Peter J. Gergely!

    0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
    0f[ read only		    !* Allow munging the buffer.!
    
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
	
	0,1A-65F"E		    !* The file has been marked for archiving!
	    :I*CCannot_Delete_an_archived_file.
	    fsechodisp0fsechoactive
	    0L '
	
	"#+65-73"E		    !* The file has been marked as invisible!
		:I*CCannot_Delete_an_invisible_file.
		fsechodisp0fsechoactive
		0L ''
	
	1a-32"e fD '		    !* Mark one file as deleted.!
	"g @l ' >
      -1"EW-@l+1 (@l)' "# -@f '	    !* Mark these lines!
				    !* as changed.  This!
				    !* replaces the old type so that!
				    !* it can allow for ^J in the!
				    !* filename.!


!& DIRED Invisible File:! !S Marks the current file to be set invisible!

!* This section written by Peter J. Gergely, DREA 10 November 1981!

    1-fs osteco"n fg 0'	    !* not on ITS or TENEX!
    0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
    0f[ read only		    !* Allow munging the buffer.!
    
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
	
	0,1A-65F"E		    !* The file has been marked for!
				    !* deletion!
	    :I*CCannot_set_an_archived_file_Invisible.
	    fsechodisp0fsechoactive	    !* Send out an error message!
	    0L 0'		    !* Make sure at the beginning of!
				    !* the file!
	"#+65-68"E		    !* The file has been marked as!
				    !* deleted!
		:I*CCannot_set_a_deleted_file_Invisible.
		fsechodisp0fsechoactive  !* Send out an error message!
		0L 0''	    !* Make sure at the beginning of!
				    !* the file!
	1a-32"e fI '		    !* Mark one file as Archived.!
	"g @l ' >
    
      -1"E
	-@l+1 (@l)'"# -@f '	    !* Mark these lines!
				    !* as changed.  This!
				    !* replaces the old type so that!
				    !* it can allow for ^J in the!
				    !* filename.!

!& DIRED Undelete:! !S Undo the effect of a previous D command.!

    0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
    0f[ read only		    !* Allow buffer munging.!
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
	1a-D"'N[A		    !* If this file is marked!
				    !* deleted,!
	QA"N 1A-A"'NUA'	    !* If not deleted then check!
				    !* for archiving mark!
	QA"N 1A-I"'NUA'	    !* If neither archived or deleted!
				    !* then check for the invisible bit!
	QA"E			    !* If either mark is made!
	    di_ 18c		    !* Then remove the marks!
	    !<! 1:fb_=>_"n fkc:k'  !* and remove names of!
				    !* linked-to file to!
				    !* delete, if any.!
	    0@l'
	"g @l'>
      -1"EW-@l+1 (@l)' "# -@f '	    !* Mark these lines!
				    !* as changed.  This!
				    !* replaces the old type so that!
				    !* it can allow for ^J in the!
				    !* filename.!

!& DIRED Reverse Undelete:! !S Move up one line and undo a D.
An argument specifies how many lines to go up by.!

      < -@l 1m(m.m &_DIRED_Undelete) (-@l)>
      @F 

!& DIRED Next Hog:! !S Move to the next file of which there are more than two (or arg) copies.!

    [5[6[7[8 .[9		    !* Q7 will point after last file in grp!
    @:i*|.+2f(j2<<:s.+1;c>>),.|[1	    !* Q1 is string to get file.ext!
    0@l 1x5			    !* Skip current file and all with same!
				    !* FN1.!
    < @l .-z; 1f=5:@;>
    < 0@l .u8 .-z; 1x5 0@l	    !* FN1 to Q5, line location to Q8!
	-(ff"n ' "# 2' @fo..q File_Versions_Kept)u6
	< @l .u7 .-z;    	    !* Look at files following this one!
	    1f=5:@; %6w >	    !* Count files with matching FN1!
	q6; >			    !* Stop if saw more than 2 (QFile!
				    !* Versions Kept) copies.!
    q8-z"E q9j fg 1  '	    !* Beep and exit if nothing found!
  
!* Q8 points at first file of group, q7 at last.  Both point at beginning of!
!* file's line.!
!* Now make sure, if possible, that entire group is on screen.!

    fswindow"l :f'		    !* If window unknown, choose one!
				    !* putting point near top!
    f[^rvpos
    q7j @L 1f[reread 0@v	    !* Find out vpos of where Q7 points.!
    f]rereadw
    fs ^r vpos-(FSLINESF"EW FSHEIGHT-(FSECHOLINES)-1' "#-(FS TOPLIN)')(
	f]^r vpos
	)"G q8j 1:F'		    !* Won't fit in existing window => start!
				    !* on line 1.!
    q8j 0

!& DIRED Automatic Delete:! !S Put D's next to versions of the current file that need it. 
With an argument, the entire directory is processed, not just the current file.
Obeys File Versions Kept!

    FF"E :m( m.m &_DIRED_Automatic_One_File ) '	    !* With no!
				    !* argument, use routine below!
    J2@L < .-z;			    !* Otherwise, iterate over the!
				    !* whole directory!
	m( m.m &_DIRED_Automatic_One_File ) R >
    J2@L 			    !* Go to front of directory and!
				    !* redisplay all!

!& DIRED Automatic One File:! !S Put D's next to deletable versions of one file.!

    0@L [0 2@fo..Q File_Versions_Kept[2    !* Q2 gets number of versions to!
					    !* keep!
    @:i*|.+2,(2<<:s.+1;c>>.)|[1	    !* Q1 is string to get file.ext!
    .-z"E fg 1  '		    !* Barf if at end (no file)!
    .f[VB 1x0 1[3		    !* Set buffer boundaries around files with!
				    !* this name!
    0f[ read only		    !* Allow buffer munging.!
    < @L .-z; 1f=0:@; %3>	    !* This puts . at start of first different!
				    !* line!
    fsz-.f[VZ
    ZJ q3-q2"G			    !* If enough of this file!
	-Q2-1@L < FD b-.; -@L > '	    !* Mark all previous versions for!
					    !* deletion!
    QTemp_File_FN2_Listu0	    !* Mark all "temp" versions!
    J<.-z; <:s.+1;c>.,(<:s.+1;c>.):FB0"L 0@l FD' @L>
    J H 			    !* Exit with point at first file in group!


!& DIRED Examine File:! !S Enter recursive ^R on the current file!

    [2 f[D File 0[..F		    !* Get out of magic dired environment!
    0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
      < .-z;		    !* Iterate |arg| times, stop at end!
	"L qb-.; -@L '
	.+2,(2c <:s_	+2;c> .-1)x2 1,er2
	0fs d versw fs d fileu2
	0@L f[B Bind		    !* Get buffer!
	@y			    !* But read in file the guy said!
	:I* [DIRED_Examine_Mode:__2_][..J FR   !* Fix mode line!
				    !* Enter ^R on it!
	"G @L ' >
    "G -@L ' 		    !* Leave cursor on last file processed,!
				    !* full redisp!

!& DIRED Edit File:! !S Edits the current file with a recursive EMACS.
Sets up an inferior fork running emacs on the current file. With an
argument, does not kill the fork and saves it with the EFORK handle
of DIRED <filename> for restarting with EFORK.!

    0@FO..QEditor_Name[4	    !* Q4 gets the editor name!
    FQ4 :"G :I4EMACS'		    !* Default to EMACS!
    [1 [2 [3 f[D File		    !* Save stuff !
    0@l .-z "E fg 1  '	    !* Complain at end of buffer !
    .+2,(2c<:s_	+2;c> .-1)x2 0l	    !* Get filename !
    et2w fs D File u2 fs D FN1 u1	    !* into Q1 and Q2 !
    ff "N			    !* If arg then do EFORK stuff !
	0@FO..QffrkDIRED_1 "E   !* If fork not defined !
	    -1 M.VfrkDIRED_1
	    :I*--_Dead_-- M.VffrkDIRED_1	    !* Define it !
	    0@FO..QForklist u3 q3 "E
		:I*M.VForklist
		:i*u3 '	    !* and this !
	    :I33DIRED_1 q3 uForklist '	    !* if necessary !
	qfrkDIRED_1 f"G ,0  fz ' '  !* Kill it if alive !
    0@FO..Q Exit_to_inferior_Hook u3 q3 "N m3 '    !* Call hook if there !
    E?EMACS:4.EXE"N W:I4EMACS'  !* If exe file does not!
				    !* exist then default to EMACS!
    1:<fzEMACS:4.EXE.0_2 u3>"N	    !* Make the call !
	fzEMACS:EMACS.EXE.0_2 U3'
    ff "N q3 ufrkDIRED_1  !* If arg, do EFORK stuff !
	q2 uffrkDIRED_1 '	    !* !
    "# -q3 fz '		    !* Else kill !
    0@FO..Q Return_from_inferior_Hook u3 q3 "N m3 ' !* Call hook if there !
    0@l 			    !* and quit !


!& DIRED Reverse Sort:! !S Sort the files in the buffer in reverse.!

    -:m(m.m&_DIRED_Sort)

!& DIRED Sort:! !S Sort files in the buffer by size, read- or write-date.!

    [0 [1 [2 :i*C fs echo disp  !* Clear echo area.!
    "l @ft Reverse_' @ft Sort_by_
    2,m.i < fi:fcu0
	q0-C"e @ft Chronological_ 1;'
	q0-F"e @ft Filename :i1  :i2  1;'
	:i1 -2s-$ -@:f_ $@l  :i2 fs fdconv$
	q0-R"e @ft Read_date 1;'
	:i1 2< 1 >
	q0-W"e @ft Write_date 1;'
	:i1 1 -fw@l :i2 \ 
	q0-S"e @ft Size 1;'
	q0-?"e @ft (C_Chronologically,_F_Filename,_S_Size,_R_Read_date,_W_Write_date)

	    "l @ft Reverse_' @ft Sort_by_ !<!>'
	fg 0 >
    Q0-C"E
	2,m.i < fi:fcu0			!* Get a character!
	    q0-R"e @ft Read_date 1;'
	    q0-W"e @ft Write_date 1;'
	    q0-?"e @ft (R_Read_date,_W_Write_date)_ !<!>'
	    fg 0>
	j 2@l .f[ vb 0f[ read on
	Q0-R"E 1,' :M(M.M &_Chronologically_order_DIRED_buffer)'

    j 2@l .f[ vb 0f[ read on
    Q0-F"E			    !* Special sort for filenames!
	"L:' c:@l@l'
    "#				    !* And the others!
	"l :i2 -(2)() '
	 c :@l 1 2  @l'
    

!& DIRED SRCCOM File:! !S Call up SRCCOM on the current file.
Compare the file on this line with the latest version of the same file.!

    0l "L .-qb'"#.-z' "e fg 1 ' !* Barf at end of buffer.!
    0@fo..qSRCCOM_switchesf"ew :i*/e/y'[2  !* get switches!
    [1   < .-z;		    !* Iterate |arg| times, stop at end!
	"L qb-.; -L '
	.+2,(2c <:s_	+2;c> .-1)x1   !* Extract filename!
	et1 fs dfileu1	    !* Make a complete filename!
	:i*12fs fork jcl  !* Setup jcl!
	f+ ft -(fz SYS:SRCCOM.EXE)fz    !* Call up SRCCOM!
	"G L' >
    0

!& DIRED List File:! !S List the current file on the line printer
A negative argument ask for the output device and ...
the absolute value of any argument is used as a repetition count.  !

    .F( WJ :FB"L 1R'
	:X*[DW)J		    !* QD gets the temporary directory!
    :I*PRINT@FO..Q Print_Library[L	    !* QL gets the current library!
    F~LLIST"E 0UL'
    "# 1,QLM(M.M &_Get_Library_Pointer)"E
	    :i*CEMACS_Print_functions_unavailable.__Trying_SYS:LIST.EXE !*
	    !  fsechodisp 0fsechoactive 0UL''
    :i*LPT:<>@FO..Q Print_Device[..5 [..4 [..6
    [1 [2 1[3 0[4 f[D File 0F[DVERSION    !* Save stuff !
    ET filename
    ET..5
    ETLST
    FSDFILEU..5
    "L
	w5,1FOutput_toU..5
	ET..5
	etLST
	F~(FSDFN1)FILENAME"'EU4
	FSDFILEU..5
	'
    f]Dversion f]dfile
    F[dfile
       u3			    !* Get the absolute value!
    
    FQL"G :I*@_List[M		    !* QM gets the macro!
	F~LLPTLIB"N :IMPrint_File''
    :I..6
    Q3<  0@l .-z "E fg 0;'	    !* Complain at end of buffer !
	.+2,(2c<:s_	+2;c> .-1)x2 0l	    !* Get filename !
	etDW
	et2w
	fsdfileu..4
	Q4"N			    !* Implies to change the name each time!
	    ET..5
	    ET2
	    ETLST
	    -1f[dversion
	    FSDFILEU..5
	    f]dversion'
	FQL"G
	    Q..4FSDFILE
	    M(M.M M)..4..5'
	"#  Q..4U..6
	    "L Q..6U1
		:I..6..6,
		output_..5
		show
		'
	    :I*Cfsechodisp
	    1:< Q..6fsforkjcl
		-(@FZSYS:LIST.EXE)FZ
		30		    !* Allow a couple of seconds !
		>"N
		:I*CLIST_Program_failed.__Do_you_want_it_printedfsechodisp
		1M(M.M &_Yes_or_No)"L
		   M(M.M &_Dired_Exec_Command)PRINT_1'
		''
	1@L .-z;>
    

!& DIRED View File:! !S Views the current file.
Space advances by the screenfuls while backspace backs up by them.
Rubout exits gracefully while any other character does its normal
action!

				    !* Created by Peter J. Gergely!
    .F( WJ :FB"L 1r'
	:X*[D W)J		    !* QD gets the directory name!
    [2				    !* Q2: the filename!
    .+2,(2c <:FB_	+2; wc> .-1)x2 0l	    !* get the filename!
    M(M.M View_File)D2	    !* Does the file viewing!
    


!& DIRED Automatic Intermediate File Delete:! !S Put D's next to versions of the current file that need it. 
With an argument, the entire directory is processed, not just the current file.
Obeys File Versions Kept!

    FF"E :m( m.m &_DIRED_Automatic_Intermediate_One_File ) '   !* With no!
								    !* argument, use routine below!
    J2@L < .-z;			    !* Otherwise, iterate over the whole!
				    !* directory!
	m( m.m &_DIRED_Automatic_Intermediate_One_File ) R >
    J2@L 			    !* Go to front of directory and redisplay!
				    !* all!

!& DIRED Automatic Intermediate One File:! !S Keeps oldest and newest
version of a specific file.  With an argument, the entire directory is
processed, not just the current file.  It keeps File Version Kept of
the newer versions of the file plus the eldest one.!

    0@L [0 2@fo..Q File_Versions_Kept[2    !* Q2 gets number of versions to!
					    !* keep!
    @:i*|.+2,(2<<:s.+1;c>>.)|[1	    !* Q1 is string to get file.ext!
    .-z"E fg 1  '		    !* Barf if at end (no file)!
    .f[VB 1x0 1[3		    !* Set buffer boundaries around files with!
				    !* this name!
    0f[ read only		    !* Allow buffer munging.!
    < @L .-z; 1f=0:@; %3>	    !* This puts . at start of first different!
				    !* line!
    fsz-.f[VZ
    ZJ q3-q2"G			    !* If enough of this file!
	-Q2-1@L < FD b-.; -@L >
	0@L f_		    !*  Keep the oldest one.!
	'			    !* Mark all previous!
				    !* versions for deletion!
    QTemp_File_FN2_Listu0	    !* Mark all "temp" versions!
    J<.-z; <:s.+1;c>.,(<:s.+1;c>.):FB0"L 0@l FD' @L>
    J H 			    !* Exit with point at first file in group!

!& DIRED Request Confirmation:! !Show user marked files for confirmation.
Takes two string arguments, first one is the mark used, second one is the
name of the operation being requested, e.g. D and deleting.!

    [5 [6
    :i5			    !* Q5: the mark to look for!
    :i6			    !* Q6: the name of the operation!
    [A				    !* QA: Nonzero if archiving bit!
    [Y				    !* QY: Temporary!
    F~5A"'E UA
    J 2:@L			    !* get set at top of buffer!
    :S
    5"E 0 '		    !* if no files affected, split!
    f[bbindw g(-1fsqpslot)	    !* copy the edited dir!
    ZJ <-@L .+2-Z:; K>		    !* Flush all blank lines from end.!
    j2@l < .-z; 1a-5"e @l '"# k'>	    !* Kill lines not marked for!
					    !* operation.!
    j 0s <:s;  c>	    !* Make sure things are quoted!
    [.6 0[3 [2			    !* 3 is maximum length found so far!
    :i*[1 j2k			    !* 1 is string to check names against.!
    < .-z; 2d .u2		    !* 2 is start of this file.!
	<:s_	+2;c> r:k	    !* extract file name!
	QA"N
	    QDired_Files_to_archiveUY
	    Q2,.@XY FQY"G :IYY,'
	    QY UDired_Files_to_archive'   !* [PJG] If we are!
				    !* [PJG] archiving then put the!
				    !* filenames in Dired Files to archive!
	fsosteco-2"n 0@l2<<:s.+1;c>>r'	    !* Move past filename and!
						    !* extension!
	"# -@:f;r'		    !* ...!
	q2,.f=1"e		    !* If names the same, ...!
	    q2-2,.-1k f,	    !* Make one longer line.!
	    '"# q2,.x1'		    !* Else get new string to use.!
	:@l 0,0:fm		    !* Make sure know where we are.!
	fs ^r hpos, q3 f  u3	    !* Keep track of the longest line so far.!
	@l > j
    fs width / (q3+1) u2	    !* Get number per line.!
    fs width / q2 u3		    !* Get rounded size for them.!
    < 0u1
	q2< :@l 0,0:fm .+2-z;
	    %1-q2"n q3*q1 - (fs ^r hpos) , 40.i 2d'
	    > 2:c; >
    ]1]2]3
    z"e 0 '			    !* nothing to delete => return.!
    f<!ask! ft6_the_following_files:
	       ht ftOk?	    !* list files to deal with, ask if ok!
	:i.6			    !* answer will go here!
	< fii -1 f(t)@fc	    !* input letter, echo, and capitalize!
	    0a-?"E -d 1;'	    !* print some help, reask!
	    0a-X"E f+ 0'	    !* exit, no action!
	    0a-N"E -d		    !* N means keep working on dir!
		].6 f]bbindw	    !* prepare to re-edit!
		f;DIRED_loop'	    !* no, re-edit directory!
	    -1  @fx.6		    !* add letter to .6!
	    f=.6YES"E 1'	    !* ok, act on the files!
	    fq.6-2"G 1;'	    !* bad answer, give help!
	    >
				    !* print some help!
	f+ ft Choices_are:
	YES	go_ahead_with_6_the_files
	X	exit_immediately,_no_action
	N	go_back_to_edit_mode
	
				    !* now go back, reask!
	>			    !* end ask!
    1				    !* we can7t ever get here!

!& DIRED Deleting Action:! !S Do the work of deleting the marked files.!
    ft
    Deleting_files...
    
    0u..h			    !* Unless something goes wrong, let ^R!
				    !* redisplay immediately.! 
    [1[2 j 2@l			    !* at first file line!
    < .-z;			    !* done when all lines checked!
	1 f=D"e		    !* check for D mark!
	    2c .,(<:s_	+2;c> r .)x1   !* Q1: extract fname!
	    1:<ED1>"N	    !* now try to delete that file!
		FT_Delete_of_1_failed
		''		    !* but it failed!
	@l >			    !* no D mark, keep looking!
    ft
    w0u..h
    

!& DIRED Invisible Action:! !S Do the work of making marked files invisible.!
    
    ft
    Setting_files_invisible...
    
    0u..h			    !* Unless something goes wrong, let ^R!
				    !* redisplay immediately.!
    [1[2 j 2@l			    !* at first file line!
    < .-z;			    !* done when all lines checked!
	1 f=I"e		    !* check for I mark!
	    2c .,(<:s_	+2;c> r .)x1   !* Q1: extract fname!
	    er1		    !* wants 4,er/get handle on file!
	    1fs if fdbu2	    !* Q2: get word 1 of FDB!
	    q2000040000000.,1fs if fdb   !* set word 1 of FDB!
	    ec'			    !* close the file, not nec with 4,er!
	@l >			    !* no I mark, keep checking!
    ft
    w0u..h
    

!& DIRED Archiving Action:! !S Actually does the archiving of the files.!

    ft
    Archiving_files...
    
    [Y F[BBIND			    !* Get a temp. buffer!
    [1				    !* Q1 will hold the directory!
    G(FSDDEV) 58I 60I G(FSDSNAM) 62I 0FX1
    GDired_Files_to_archive	    !* contains the files to be!
				    !* archived!
    J<:S; -D 22I>	    !* Change ctrl-Q to!
				    !* V s!
    J G1 .(			    !* Get the directory name!
	J <:S,+1; 1c> 1R   !* Move to!
				    !* the end of the first filename!
	0XY f[bbind		    !* save the filename in QY!
				    !* and get a temporary buffer!
	E[ ETY		    !* Push the input filename!
				    !* and set the default to the!
				    !* filename in QY!
	1,er EG J4K :L .,zK	    !* Attempt to read!
				    !* it in without changing!
				    !* the access date.  Then use the!
				    !* archaic EG command to get the!
				    !* real directory!
	J <!<!:S>+1; 1c>   !* Move to!
				    !* the end of the directory name!
	0X1			    !* Q1 gets the filename!
	E] f]bbind		    !* Pop the input filename!
				    !* and the temporary buffer!
	)J 0,.K G1		    !* Kill the old directory!
				    !* name and insert the new one!
    J<
	<:S,+1; 1C>	    !* For each file!
				    !* separated by a comma!
				    !* and not quoted!
	fssvalue;		    !* Check if any more!
	.-Z"E -D 1;'		    !* If the last one then do!
	FSHPOSITION-300 "G	    !* If we have more!
				    !* than 300 characters in!
				    !* this string, then!
	    -D 0,.FXY		    !* Get rid of the command!
				    !* and valret the stuff out!
	    M(M.M &_Dired_Exec_Command)ARCHIVE_Y
	    30:'		    !* Pause for only 1 second!
	G1>			    !* Insert the directory and continue!
    HFXY ]1 F]BBIND		    !* Store the whole thing in QY!
    FQY"G			    !* If anything there then!
				    !* valret an archive request!
	M(M.M &_Dired_Exec_Command)ARCHIVE_Y
	'
				    !* seconds so that the user can!
				    !* look at it!
    90:			    !* Let them look at it for 3!
				    !* seconds!
    0U..H

!& DIRED Check Superior:! !S Checks for the superior type. 0=EXEC, 1=OTHERS
Loads the EFORK library (if necessary) if the superior type is other than 0
!
    
    1:<QSYSTEM_SUPERIOR_TYPE>"N
	0M.CSystem_Superior_Type_Nonzero_implies_an_invoke_inferior_type
				    !* Create a variable if not!
				    !* here already!
	F[bbind		    !* Get a temporary buffer!
	FSJNAMEf6 J		    !* Get the jobname that!
				    !* called EMACS!
	1+(:SMACS)USystem_Superior_type	    !* See if it is an!
				    !* EMACS variant!
	F]bbind		    !* Pop the temporary buffer!
	
	QSystem_Superior_Type"N   !* If the type is non-zero!
	    1,M.M ^R_Invoke_Inferior"E	    !* Check to see if EFORK is!
				    !* loaded, and if not !
		M(M.M Load_Library)EFORK''	    !* then load it.!
	'
    

!& DIRED Exec Command:! !S Performs the string argument as an EXEC command.
The action it takes depends on the value of System Superior Type.  It
it is 0 then a valret is performed else an inferior exec is invoked.!

    :I*[Y
    M(M.M &_DIRED_Check_Superior)
    1@FO..QSystem_Superior_Type"E
	Y
	CONT
	'
    "# M(M.M ^R_Invoke_Inferior)*Y
	POP
	'
    
    

!Clean Directory:! !C Try to reap the specified directory.  Takes the
directory name as a string argument; default is visited one.  Does
(essentially) MM Reap File on each file in the directory, which finds
the excess versions and offers to delete them.  A file whose extension
contains one of the strings contained in Temp file FN2 List us also
offered to be deleted.  A numeric arg specifies the number of versions
to keep.!

    fsuname[5			    !* Q5 will contain users!
				    !* name.!
    [0 [1 [2 [3 [6 F[B BIND F[S STRING f[ D FILE
    [7 [8 [9
    fqtemp_file_fn2_List"G
	qtemp_file_fn2_Listu7'    !* Check those files listed!
				    !* as temporary!
    "# :I7'
    qBuffer_Filenamef"n fsdfile'w	    !* Buffer filenames are default!
					    !* filenames.!
    et*.* -3fs dversionw	    !* set default for reading filename!
    5,2fDirectory_u1 et1	    !* Read filenames wanted.!
    -3fsdversionw fsdfileu0
    EZ0
     f(U3)"E 2@FO..Q File_Versions_KeptU3'	    !* Q3 has #!
						    !* versions to keep.!
    Q3:\U1			    !* Q1 has that number as a string.!
    J G(FS D DEV) I:< G(FS D SNAM) >I B,.FX6 J !<!
	[..J :I..JChecking_6_for_files_with_>1_versions... FR
    M(M.M &_DIRED_Pretty_File_Display)Wj
    fs osteco-2"n @:i2|.(2<<:s.+1;c>>r),.|'   !* Q2 is string to get!
						    !* file.ext!
    "# @:i2|.(fb	-@:f;r),.|'
    < .-Z;			    !* Loop over FN1's.!
	2X1			    !* Q1 gets this FN1.!
	< @L .-Z;		    !* Find all files with this FN1.!
	    2F=1"N 0@L 0;'>    !* Stop after the last one.!
	FSZ-.FS VZ		    !* Set bounds around files with same FN1.!
	hx8 0u9 f[bbind
	g8 j
	<.-z; <:s.+1;1c> 0k 1l>
	j :s7"L 1u9'"# 0u9'
	f]bbind
	zj q9"N q3<13i 10i>'
	1,Q3M(M.M&_Reap_File_List) !* Ask about deleting some, if!
				    !* appropriate.!
	0FS VZ >		    !* Lines were killed.  Consider next FN1.!
    0U..H 			    !* Return no value, so screen will!
				    !* redisplay!

!Reap File:! !C Delete old versions of a file.
Takes a filename as a string argument.
Offers to delete (and expunge) all but the most recent
versions of the file.
The number of versions kept is the numeric argument,
or File Versions Kept if no argument (usually 2).
If there are more than that many versions, you are told
about the excess and asked whether to delete them.!

    [1 [6 [7 [8 [9 0F[CASE
    -F[FNAM SYN F[B BIND F[S STRING
    U6 FF"E 2@FO..Q File_Versions_Kept U6
				    !* Q6 gets numeric arg, or File Versions!
				    !* Kept, or 2.!
	Q6"E @FEAOR FS ERR''	    !* Keeping 0 versions illegal unless!
				    !* explicit!
    Q6"L @FEAOR FS ERR'	    !* Negative # versions to keep is!
				    !* illegal,!
    0@FO..Q Buffer_FilenamesF"E W' F[ D File
    
    5,FFile_to_reapu7
    ET7			    !* Set default to spec'd filename.!
    FS D FN1U8 FS D FN2U9
    fsosteco-2"n EZ8.9.-3'	    !* Get file list into buffer.!
    "# ez8.9;-3'	    !* ...!
    J
    M(M.M &_DIRED_Pretty_File_Display)
    Z"E :I*No_files_named_8.9 FS ERR'
    
    Q6M(M.M &_Reap_File_List)	    !* Now process the dir listing, maybe!
				    !* delete files.!
    30:			    !* Give user a chance to read printout,!
    0U..H			    !* then flush it.!
    

!& Reap File List:! !S Delete some of the files listed in the buffer.
The buffer should contain a part of a directory listing,
containing all the versions of a given file.  The number of
versions to keep should be given as a numeric argument.
This subroutine figures out which files ought to be deleted,
asks the user about them, and then deletes them after confirmation.
The buffer contents are all killed.  The virtual boundaries
are respected. "1," as argument causes these files not to be
mentioned at all if there are no files to delete (nothing is
typed out).!

    F[D FILE [1 [2 [3
    ZJ
    "N J @L .-Z"E HK ''	    !* If have 2nd arg, and no files to!
				    !* delete,!
				    !* just return - don't mention this file.!
    fs osteco-2"e
	zj .u2 <-@l .(1f (zj)g..o)j b-.; > b,q2k'
    
!* delete last <arg> names from list.  default is 2!
    
    ZJ -@L .U2
    !Redisp!			    !* Q2 holds dividing line between deleted!
				    !* and saved files.!
    Q2J
    0FSFLUSHEDU3 Q3"N :FT'
    z-.-(*2)"N		    !* Prevents screwing up at!
				    !* the end of the directory.!
				    !* Leaving an extra line make it a!
				    !* bit more readable!
	:FT			    !* [RDH]!
	Saving_these_files:
	
	< .-Z; .,(@L). T>	    !* Type names of saved files.!
	
	Q2-B"E FT
	    ...and_no_other_files_to_delete.
	     W60:
	    ''"#FT
	'			    !* and if only deleting!
				    !* files then leave a blank line.!
    
    FT Delete_these_files?
    
    
    Q2J < B-.; .,(-@L).:  T 0@L>
    FT (Y,_N,_or_0-9)?_
    Q3"E FSFLUSHED"N FIW F+ O Redisp''    !* If flushed once, redisplay.!
				    !* Flushed twice => no use to redisplay.!
				    !* We started at screen top this time.!
    OSKIP
    !ASK!FT (Y,_N,_or_0-9)?_
    !SKIP!FIU1
    Q1-?"E
	FT
	Possible_responses_are:
	____Y____Delete_these_files.
	____N____Do_not_delete_these_files.
	____0-9__Keep_this_number_of_versions_of_the_file.
	____?____Types_this_message.
	____^L___Redisplays_and _asks_again.
	
	OASK'
    Q1"D			    !* IF a digit then we want!
				    !* to keep that many versions!
				    !* around!
	Q1-48u1			    !* Convert the response into!
				    !* a number!
	1,q1M(m.M &_Reap_File_List)
	HK '
    Q1-"E  F+ O Redisp'	    !* ^L means "ask me again".!
    FT1 FT
    
    Q2,ZK			    !* Once user answers, flush names of saved!
				    !* files.!
    
    Q1:FC-N"E			    !* Don't delete any of these files unless!
				    !* user says "Y"!
	FT Not_deleted
	
	HK '
    Q1:FC-Y"E			    !* delete the files!
	J <.-Z;
	    M(M.M ^R_Delete_Horizontal_Space)
	    .,(<:s_	+2;Wc>) .-1X1
	    1:<ED1>F"Nfserr'
	    @L>
	FT Deleted.
	
	HK '
    Oask
    
    

!& Indent Carefully:! !S Indent to specified column.
The argument should be the desired column.
Uses tabs and spaces;  deletes all tabs and spaces around
point before indenting.  Returns the range of buffer changed.!
    
    [0 [2
    @f_	k		    !* Delete all tabs/spaces after point.!
    @-f_	k		    !* Delete all tabs/spaces before point.!
    fs hpos u0
    .(  /8-(q0/8)f"g ,9i          !* If can use tabs, use them!
	    &7,32i'		    !* Followed by spaces for the rest.!
	"# -q0 :f"g w 1' ,32i'    !* No tabs =) different way to figure #!
				    !* spaces.!
	),.			    !* Return stuff good for giving to ^R.!
    

!& Get Real Filename:! !S Returns the real filename of the string arg.
No string argument implies to take the current buffer filename.  Q..6
is used as the buffer string input temporarily.!

    :I*[..6		    !* Get the string argument!
    FQ..6:"G
	FQBuffer_Filenames"G
	    QBuffer_Filenames U..6'
	"# WfsdfileU..6'	    !* Set the default!
	'
    E[ E\ fn E^ E]		    !* Push and pop the IO on the way out!
    f[dfile
    F[BBIND			    !* Get a temporary buffer!
    f[dversion
    1:<
	1,111110000001.ez..6
	J:X* fsdfile		    !* This becomes the default filename!
	>"N :I*..6'	    !* Set the default to file inputted!
				    !* on error!
    f]dversion
    fs d file		    !* Print out the default filename!
    

!& DIRED Pretty File Display:! !& S aligns the file information in the buffer.!

    [1 [2			    !* Q1: indenter, Q2: temp author string!
    [3 [4			    !* Q3 Q4 start and end of author string!
    [J				    !* QJ: Author string!
    m.m&_Indent_Carefullyu1 0s,	    !* Make things a bit faster.!
    < .-z;
	2,32i <:s+1;c> -d
	20m1w <:s+1;c> -d
	26m1w
	11 f=16-Nov-1858 "e 11 ki---.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not written!
	<:s+1;c> -d
	46m1w
	11 f=16-Nov-1858 "e 11 ki---.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not read!
	:fb"n -d fsxunameuJ	    !* Save user for compare!
	    .u3 (:l.)u4 q3J (q4-q3) X2	    !* Save author for compare!
	    (q4-q3)"E i--- -3c'"#  !* If there's no author, say so!
		f~J2"E q3J :k'' 66m1w' !* Flush author if it's us!
				    !* Align last writer!
	:l fs width - (fs h pos) f"l d'   !* Prevent continuation lines!
	@l>
    


!& Chronologically Order DIRED Buffer:! !C Reorder DIRED's list, chronologically by time.

A pre-comma argument says to use the read date instead of the write date for
the chronological time sort.

If given a negative argument then it
reorders DIRED directory listing in buffer (e.g. inside DIRED), so:
    newest files are at top (according to write date), and
    files of same first and second components are together, and
    files of same first component are together.

With a non-negative argument then the oldest files are at top of each group.!

    [0[1[2[3[4
    0f[ReadOnly			!* Let change the buffer temporarily!
    0f[VB 0f[VZ			!* Whole buffer.!
    j 1a-9"e l @f
	_l 0l .fsVBw'			!* Skip past directory label and!
					!* blankish line if any.!

    FF-1"G				!* Pre-comma arg says use read date!
	"L:'  :l -s;. 3:fwl fsFDConvertw:2FWL fsfdconvert l'
    "#					!* otherwise use write date!
	    "L:'  :l -s;. 3:fwl fsFDConvert l'
							!* write date.!

 bj   !* Now we regroup files:  first bring all files with same fn1.fn2 up.!
      !* Then bring up the next file with same fn1 and repeat for its fn1.fn2.!
      !* We must be careful about lines beginning with DIRED delete-marks,!
      !* i.e. D Space.!

 <:fb.; r .,(0l 2c).f x1	    !* 1: Handle all files with this fn1.!
				    !* The 0l2c is to ignore first 2!
				    !* characters since they may differ, e.g.!
				    !* by DIRED marking.!
				    !* (Is always some character before 1st .)!
  f<!FN1.*!			    !* Iteration for each fn2 for this fn1.!
    0l s.  .,(:l -s.; c).x2 !* 2: fn2 and . or ;.!
    0l .(1l .u0)j			!* 0: Point to bring files, before this.!
    :l .u4			    !* 4: Point to start searching from.!

    < :s
1.2; 0l fx3	    !* 3: Next file with same fn1.fn2.!
      q4-z( q0j g3 .u0		    !* Bring up file.!

	    )+zj .u4 >		    !* 4: Back to where search from.!

    :s
1."e l f;FN1.*'	    !* Done all files with this fn1.!
    0l fx3 q4j l g3 -l >	    !* 3: Still more with same fn1.!

  >				    !* Done all files.!

 bj 

!Flush Dired Lines:! !C Remove any filename's line which contains some pattern.

This command (unlike MM Flush Lines) takes an arbitrary number of
    string arguments.  If a filename line contains any of the string
    arguments, that line is removed from the Dired buffer.  End the
    string arguments with a null string argument, e.g.:
    MM Flush Dired Linesfoofah
It also differs from MM Flush Lines in that it temporarily makes the
    buffer modifiable (Dired normally has the buffer be read-only).!

    [1[2[3 :i1				!* 1: Start off flush pattern.!
    0f[ReadOnly			!* Allow modification.!
    < :i2 fq2@;			!* 2: Next pattern.!
	:i112 >		!* 1: Add into search pattern.!
    fq1"e '				!* No pattern to search for.!
    1,fq1:g1u1				!* 1: Strip off leading .!
    .u3 j2l .-q3:"G q3j'		!* Do not munge directory name!
    m(m.mDelete_Matching_Lines)1	!* Flush.!
    

!Keep Dired Lines:! !C Keep only filename lines which contain some pattern.

This command (unlike MM Keep Lines) takes an arbitrary number of
    string arguments.  If a filename line contains any of the string
    arguments, that line is kept in the Dired buffer -- all other
    lines are removed.  End the string arguments with a null string
    argument, e.g.: MM Keep Dired Linesfoofah
It also differs from MM Keep Lines in that it temporarily makes the
    buffer modifiable (Dired normally has the buffer be read-only).!

    [1[2 :i1				!* 1: Start off flush pattern.!
    0f[ReadOnly			!* Allow modification.!
    < :i2 fq2@;			!* 2: Next pattern.!
	:i112 >			!* 1: Add into search pattern.!
    fq1"e '				!* No pattern to search for.!
    1,fq1:g1u1				!* 1: Strip off leading .!
    .u3 j2l .-q3:"G q3j'		!* Do not munge directory name!
    m(m.m Delete_Non-Matching_Lines)1	!* Keep.!
    

!Directory Edit:! !C Does a Dired on all directories given as the argument
A non-zero pre-comma argument runs CLEAN DIRECTORIES
instead of DIRED.  Gets the directory names from the string argument.
If no string argument is given then the default of the currently
pointed directory is used.  Non-existant directories will not flag
errors.!

    f[bbind				!* Get a temporary buffer!
    :i*[buffer_filenames		!* Remove the buffer filename!
    :i*f[dfile 0f[dvers		!* push the filename!
    et*.* -3fsdversionw
    5,2fDirectoryua eta		!* Get the filename!
    j [b [c [d [s [t			!* Push the temporary buffers!
    GA 13i10i
    j <:S: +1;>			!* Get to the end of the structure!
    <!<!:S> +1;>			!* And the end of the directory!
    :XD					!* The rest is the file spec!
    HK
    1,110000000001.eza		!* Get any file from these directories!
    :I*UB				!* Start with nothing!
    j <.-z;				!* For the whole buffer!
	:XC				!* Get the line!
	F~BC"E 0l1k'			!* If the two lines are equal get rid!
					!* of one.!
	"#qc ub :L GD 1l'		!*  Else update the information!
	 >

    J 0ub <.-z; 1@l %bw>		!* Count the lines in the buffer!
    qb*5fsqvectoruc			!* qc gets the q-vector!
    j 0ud				!* QD is a counter for the q-vector!
    qb<:xa				!* Get each directory!
	qau:c(qd)
	1L %d>
    j <:S.-3
;			!* Get rid of wild version designator!
	fkd i.* 13i10i>		!* Replace with *!
    qb*5fsqvectorut			!* qt gets the q-vector!
    j 0ud				!* QD is a counter for the q-vector!
    qb<:xa				!* Get each directory!
	qau:t(qd)
	1L %d>
    hk					!* All done then kill the whole thing!
    :i*Cfsechodisp			!* Clear the echo area!
    0ud qb<				!* For each directory then do!
	q:c(qd)ua			!* QA gets the directory name!
	q:t(qd)us
	"E :i*AStarting_DIRED_on_sfsechodisp
	    0fsechoact			!* Tell which directory!
	    1:<M(M.M DIRED)a>"N	!* If there are errors!
		:i*AError_in_Processing_Directory_afsechodisp
		0fsechoact' '
	"#				!* If not a dired format!
	    1:<M(M.M Clean_Directory)s>"N	!* If there are errors!
		:i*AError_in_Processing_Directory_afsechodisp
		0fsechoact' '

	%d>
    

!*
/ Local Modes: \
/ MM Compile: 1:<M(M.M^R Date Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)DIREDDIRED
1:<M(M.MDelete File)DIRED.COMPRS>W \
/ End: \
!
    