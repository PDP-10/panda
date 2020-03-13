!* -*-TECO-*-!
!* <GERGELY.USERS>LIST.EMACS.11, 23-Nov-81 09:03:29, Edit by GERGELY!

!~Filename~:! !Macros for Listing Files and Buffers!
LIST

!& Setup LIST Library:! !<entry>:! !S Default setups!

    0FO..Q LIST_Setup_Hook[0 fq0"G :M0' ]0	    !* In case someone!
				    !* wants to something different!

    :I*FO..Q Print_Old_Library[B  !* QB gets the old print library!
    :I*FO..Q Print_Library[A	    !* QA gets the current one!
    F~A LIST"N QA'"# QB' M.V Print_Old_Library    !* If already the!
				    !* same one then use the old one!
    :I*LIST M.VPrint_Library	    !* Create the variable to be sure!
    M.CPrint_Library*_Filename_of_the_Library_containing_the_PRINT_macros.
    

!& Kill LIST Library:! !S Kill the variables used by the LIST Library!


    QPrint_Old_LibraryF([A) UPrint_Library
    M(M.M Kill_Variable)Print_Old_Library
    1:<M(M.M &_Setup_A_Library)W>

    

!^R Print Something:! !^R Prompt the user for which LIST macro to use.
A numeric argument says to enter subcommand mode in the program.  The
calling sequence is

	MM Print Object<file>

If the length of the string <file> is 0, then the current buffer
is used.   !

    :F"L			    !* If called from a key!
	:I*CList_the_current_bufferFSECHODISP
	1 M(M.M &_Yes_or_No)"N	    !* Reply with yes or no in the!
				    !* echo area!
	    F@:M(M.M Print_Buffer)'
	"#  F@:M(M.M Print_File)'	    !* Else the File !
	'
    "# F:M(M.M Print_File)'	    !* Not from a key then standard call!
    

!Print Buffer:! !C Lists the current buffer using the program LIST.
A numeric argument says to enter subcommand mode in the program
The calling format is

    MM & List Buffer$ !

    FSQPPTR[0			    !* Q0 gets the pushdown level!
    0F[DVERSION		    !* Zero is the default version number!
    F[DFile E[ E\ FNE^ E]	    !* Push the input and output!
    FSHSname[A			    !* QA gets the login directory!
    QBuffer_Filenames[B	    !* QB gets the buffer name if it!
				    !* exists!
    [Buffer_Filenames		    !* Push the buffer filenames!
    FQB "G
	Q..f-Q.f"E QBfsdfile'
	"# fsdfileub'
	'
    "#	Q..f-Q.f"E		    !* If there is no filename then!
	    f[bbind		    !* Get a temporary buffer!
	    GBuffer_Name WH@FC WJ	    !* Get the buffer name!
	    <.-z; -1,1AUB QB:;	    !* If at end then quit!
		QB:"D		    !* If not a digit!
		   QB-65"L W1D'
		   "# QB-90"G W1D' "# W1:CW''
		   ' "# W1:CW' >    !* Replace all non letters or numbers!
	    HFXBW 	f]bbind	    !* Pop the temporary buffer!
	    QBFSDFILE	    !* Set the default name!
	    ETB
	    '
	"# fsdfileUB''
				    !* for long!
    [c [d			    !* Push the temporary registers!

    FQB "G			    !* If we have a buffer filename!
	F[BBIND			    !* Get a temporary buffer!
	1:<1,111110000001.ezB>"E WJ :XB'
	F]BBIND
	QBFSDFILE
	FSDFN1UB		    !* QD gets just the filename!
	FSDFN2UD
	:I*A(B.D).TMPUC
				    !* The file is <home dir.><fsdfn1>.TMP!
	0FSDVERSION		    !* Zero the version number!
	FSDFILEUD		    !* QD gets the default filename!
	'			    !* and will be used as temporary!
    "#
	FQBuffer_Name"G	    !* If we only have the buffer with!
				    !* no filename!
	    QBuffer_Name:FCUD'    !* Use the buffer name to form a file!
	"# :IDUNKNOWN'		    !* Else UNKNOWN is used!
	:I*A(D)-BUFFER.TMPUC
	:IDBuffer:_D,_No_Buffer_Filename	    !* QD is the header!
	'
    B,Z M(M.M Write_Region)C  !* Write out the current buffer!
    :IDC
    FF"N :IDD,'
    FM(M.M &_List_Subroutine)DW  !* Call the listing subroutine!
    M(M.M Delete_File)C	    !* Delete the temporary file!
    

!Print File:! !C Lists the current file using the LIST program.
A numeric argument says to enter subcommand mode in the program
The calling format is

    MM & List File$<File>$ !

    FSQPPTR[0			    !* Q0 gets the pushdown level!
    0F[DVERSION		    !* Push it to get out of the way!
    F[DFile E[ E\ FNE^ E]	    !* Push the input and output!
    QBuffer_FilenamesF"E
	:I*'FSDFILE		    !* QB gets the buffer filename!
    [Buffer_Filenames		    !* Push the buffer filenames!
    5,F List_File[..4	    !* Q..4 will temporarily get the!
				    !* file to list!
    FQ..4:"G			    !* If no input file then want to!
				    !* list the buffer!
	FQ(FSDFILE):"G
	    -(WFSQPPTR-Q0) FSQPUNWIND !* Unwind the stack!
	    :F"L @' F:M(M.M Print_Buffer)'
	"# FSDFILEU..4''

    F[BBIND			    !* Get a temporary buffer!
    1:<1,111110000001.ez..4>"E WJ :X..4'
    F]BBIND
    FF"N :I..4..4,'
    WFM(M.M &_List_Subroutine)..4W  !* Call the listing subroutine!
    

!& List Subroutine:! !S Interfaces with the List program.
The string argument is interpreted as the JCL to pass to the program.
A numeric argument says to enter subcommand mode in the program!

    :I*[..6
    FQ..6 :"G
	:I*C?_Listing_subroutine_failure.__Processing_terminated. !*
	! fsechodisp 0fsechoactive '
    Q..6 m.v Print_Source_File

    FF"'E [A		    !* QA: Nonzero if we have arguments!
    1:< Q..6fsforkjcl
	-(QA"N
		:I*Cfsechodisp
		@'FZSYS:LIST.EXE)FZ
	60:		    !* Allow a couple of seconds !
	>"N
	:I*CLIST_Program_failed.__Do_you_want_it_printedfsechodisp
	1M(M.M &_Yes_or_No)"L
	    QPrint_Source_FileU1
	    M(M.M &_List_Exec_Command)PRINT_1'
	    '
    1:<M(m.m Kill_Variable) Print_Source_File>W	!* Kill the printed!
							!* file name!
    

!& List Check Superior:! !S Checks for the superior type. 0=EXEC, 1=OTHERS
Loads the EFORK library (if necessary) if the superior type is other than 0
!
    
    1:<QSYSTEM_SUPERIOR_TYPE>"N
	0M.CSystem_Superior_Type_Nonzero_implies_an_invoke_inferior_type
				    !* Create a variable if not!
				    !* here already!
	F[bbind		    !* Get a temporary buffer!
	FSXJNAMEf6 J		    !* Get the jobname that!
				    !* called EMACS!
	1+(:SMACS)USystem_Superior_type	    !* See if it is an!
				    !* EMACS variant!
	F]bbind		    !* Pop the temporary buffer!

	QSystem_Superior_Type"N   !* If the type is non-zero!
	    1,M.M ^R_Invoke_Inferior"E	    !* Check to see if EFORK is!
				    !* loaded, and if not !
		M(M.M Load_Library)EFORK''	    !* then load it.!
	'


!& List Exec Command:! !S Performs the string argument as an EXEC command.
The action it takes depends on the value of System Superior Type.  It
it is 0 then a valret is performed else an inferior exec is invoked.!

    :I*[Y
    M(M.M &_List_Check_Superior)
    1FO..QSystem_Superior_Type"E
	Y
	CONT
	'
    "# M(M.M ^R_Invoke_Inferior)*Y
	POP
	'



!*
/ Local Modes: \
/ MM Compile: 1:<M(M.M^R Date Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)LISTLIST
1:<M(M.MDelete File)LIST.COMPRS>W \
/ End: \
!
