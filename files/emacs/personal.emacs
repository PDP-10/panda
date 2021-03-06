!* -*-TECO-*-!
!* <EMACS>PERSONAL.EMACS.48, 14-Apr-82 12:08:47, Edit by GERGELY!
!~FILENAME~:! !Macros to run personal items!
PERSONAL

!& Setup PERSONAL Library:! !S Makes certain library wide definitions.!

                       !* Default File Names *!

				    !* Each File that is used has its!
				    !* filename in the option variable!
				    !* between the M.C and the escape.!
				    !* The macro first checks to see!
				    !* if the variable is already!
				    !* defined and if so then does not!
				    !* modify it in any way!

    FSHSNAME[A			    !* Home directory goes into QA.!
    0FO..QPersonal_Telephone_Directory_File[B
    FQB"L :I*ATEL.X.0(
	)M.CPersonal_Telephone_Directory_File*_File_containing_personal_telephone_index'

    0FO..Q Company_Telephone_Directory_FileUB
    FQB"L :I*SYS:COMPANY.DIR.0(
	)M.C Company_Telephone_Directory_File*_File_containing_telephone_index_for_the_company'

    2FO..Q Company_Directory_Occur(
	) M.C Company_Directory_Occur*_Number_of_Lines_to_print_for_a_match_in_the_directory

    0FO..QTelephone_Call_FileUB
    FQB"L :I*ATelephone.Calls.0(	!* Place to keep account of telephone!
					!* calls!
	)M.CTelephone_Call_File*_Telephone_Call_Summary_file'

    0FO..QProjects_FileUB
    FQB"L :I*APROJECTS-ONGOING.TXT.0(	    !* Default to!
				    !* Projects-Ongoing.TXT!
	)M.CProjects_File*_File_where_ongoing_projects_are_recorded'

    0FO..QHelp_Given_FileuB
    FQB"L :I*AHELP-GIVEN.TXT.0(    !* Default to Help-Given.TXT!
	)M.CHelp_Given_File*_File_containing_miscellaneous_services'

    0FO..QMemo_FileuB
    FQB"L :I*AMEMO-FILE.TXT.0(	    !* Default to MEMO-FILE.TXT!
	)M.CMemo_File*_File_containing_assorted_memos'

    0FO..QPersonal_help_FileuB
    FQB"L :I*APERSONAL-HELP.TXT.0(    !* Default to Personal_help.TXT!
	)M.CPersonal_Help_File*_Personal_HELP_file'

				    !* Other options *!
    
    -1FO..QMemo_Watch(
	)M.CMemo_Watch*_Flag_indicating_auto_Memo_output_(-1,0,1).
    <0_=_New_Memos,_0_=_No_checking,_>0_=_All_Messages
    5FO..QMemo_Alert(
	)M.CMemo_Alert*_Number_of_Minutes_before_due_time_to_ring_bell.
    20FO..QMemo_Begin(
	)M.CMemo_Begin*_Start_displaying_Memo_<val>_Minutes_before_due_time
    10FO..QMemo_Quit(
	)M.CMemo_Quit*_Quit_displaying_Memo_<val>_Minutes_after_due_time

    F[BBIND			    !* Get a temporary file!
    G..F WJ			    !* FIX ..F!
    :S^R_Memo"E
	@I|@M(M.M ^R_Memo)
	|
	HFX..F Q..F U.F'
    f]bbind
				    !* Key Redefinitions *!

    0FO..QPERSONAL_Setup_HookF([0)"N :M0' ]0

    M.M ^R_Telephone_Number,776.@FS^RCMAC !* on C-M-~ !
    M.M ^R_Started_Project,642.@FS^RCMAC  !* on C-M-" !
    M.M ^R_Finished_Project,647.@FS^RCMAC !* on C-M-' !
    M.M ^R_Telephone_Call,446.@FS^RCMAC   !* on M-& !
    M.M ^R_Help_Given,646.@FS^RCMAC	    !* on C-M-& !
    M.M ^R_Personal_Help,653.@FS^RCMAC    !* on C-M-+ !
    M.M ^R_Memo,452.@FS^RCMAC	    !* on M-* !
    M.M ^R_Add_Memo,652.@FS^RCMAC !* on C-M-*!

    

!& Sort With Date Key:! !S Sorts the buffer according to date by line basis.
The date and time fields at the beginning of each line form the sort
    keys.  These fields are written in any format suitable for the
    system date and time.  Please refer to the description of ^R Memo
    for more detail on that subject.!

    J :FSFDCONVERT$1l
    

!Set Clock Interval:! !C Sets the clock interval for the Secretary Macro.
The input argument should be in minutes.!

    *3600 FSCLKINTERVAL	    !* Set it in minutes!
    


!^R Add Memo:! !^R Adds a memo to the currently defined memo file.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
    fshsname[Z
    :I*ZMEMO.FILE.0FO..QMemo_FileUZ  !* QZ contains the filename of the!
    1,F Date_and_Time:_[A	    !* QA gets the date and time!
    FQA"E '			    !* If no date and time then abort!
    F[BBIND			    !* Get a temporary buffer!
    GA FKC			    !* Get the users date !
    WFSFDconvertF(UA):"G		    !* Check to see if in good format!
	:I*CIllegal_Date_and/or_Time_Entry.__Aborting_Line(
	    )fsechodisp 0fsechoactive ' !* Else error message and abort!
				    !* without saying anything!
    HK 0,QAfsfdconvert		    !* Put it in a nice format!
    1,F Message:_[B		    !* QB gets the message!
    fqB"G
	:L 32I GB 13i 10i	    !* Add a space between the date!
				    !* and the message!
	j <:S	; -d 32I>  !* Replace tabs be spaces!
	J <:S__; -D -1:C;>	'   !* Replace two spaces be one!
    J :S"E '		    !* Make sure there is some text at least!
    0,Z M(M.M Append_to_File)Z  !* Append new message to the right file!
    

!^R Finished Project:! !Writes a finished prompt to the Projects File.
    Given an argument it will state the project was interrupted instead.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    fshsname[Z
    :I*ZPROJECTS.TXT.0FO..QProjects_FileUZ    !* QZ gets the file name!
    1,FProject:_[A		    !* QA gets the project name!
    FF [C			    !* QC indicates status change from!
				    !* finished to interrupted!
    [B :IBFinished		    !* QB contains the keyword!
    QC"N :IBInterrupted'
    F[bbind			    !* Make a temp buffer!
    I
    Project:_A		    !* Put in the project and the date!
				    !* of this transaction!
    B_on_
    M(M.M Insert_Date)
    :L 46I 13I 10I
    0,ZM(M.M Append_to_File)Z   !* And append it to the other one!
    				    !* Quit!

!^R Help Given:! !^R Appends another entry to Q$Help Given File$.
The numeric argument is taken as minutes if it is positive or integral
hours if negative with the default being 15 minutes.  This value is
assumed to be the time taken.  Two string arguments are requested and
these are: The name of the person the help was given to, and the type
of help given.  The user is then placed in a ^R sublevel to edit the
rest of the fields.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    0[..F			    !* Do not allow munging of other stuff!
    fshsname[Z
    :I*ZHELP.GIVEN.0FO..QHelp_Given_FileUZ	    !* QZ gets the file name!
    QZUBuffer_Filenames
    1,FHelp_given_to:_[A	    !* QA gets the name of the customer!
    FQA:"G '			    !* If nobody then quit!
    1,FType_of_help_given:_[B    !* QB gets the type of help!
    0[0 0[1 :I*[2 [D 
    FF"N '"#15'U0		    !* Q0 get the amount of time taken!
    Q0"G			    !* If positive then minutes and!
				    !* convert into a convenient form!
	Q0/60 U1		    !* Q1 Gets the number of hours!
	Q0-(Q1*60) U0		    !* Q0 Gets the number of minutes!
				    !* remaining!
	'
    "# Q0  U1 0U0'		    !* Put the hours in Q1 and zero!
				    !* the minutes!
    Q1F"G:\U2			    !* If there are any hours then put!
				    !* in the word hours after it!
	:I22_Hour
	Q1-1"G :I22s'	    !* If more than one make the word plural!
	:I22_		    !* Add a space behind for the!
				    !* minutes to follow!
	'
    Q0F"G:\U1			    !* If more than one minute then!
	:I221_Minute	    !* Insert the value with minutes!
				    !* after it!
	Q0-1"G :I22s'	    !* If more than one make it plural!
	:I22_		    !* Add a space behind it for the!
				    !* next step!
	'
    FQ2"G 0,FQ2-1 :G2 U2
	:I22.'		    !* Add the period at the end of!
				    !* the line!
    F[bbind			    !* Get the temporary buffer!
    QModeUD			    !* Get the mode and then reset to!
				    !* text mode!
    0FO..QMM_COMPILE"N [MM_COMPILE'	    !* Keep The Compile Command!
    M(M.M Text_Mode)
    9:I*[Fill_Prefix		    !* push the fill variables!
    70[Fill_Column
    1[Auto_Fill_Mode
    IHelp_requested_by:__A 13I10I
    FQB"G IType_of_help_given:__B 13I10I'
    IEntry_Date:__
    M(M.M Insert_Date)W :L 13I 10I 13i 10i
    IProblem:
    		
    .(  13I10I 13I 10I
	ISolution:
		
	
	Time_Taken:__2
	)J

    				    !* Enter the ^R level!
    1:<M(M.M D_Mode)>W	    !* When we return reset the mode!
    J 12i 13i 10i		    !* Make sure the project is on a!
				    !* separate page!
    zj 13i 10I			    !* and that it ends in a CRLF!
    0,Z M(M.M Append_To_File)Z  !* Then append the file!
    


!^R Memo:! !C Checks for pending memos.
Any argument sets acknowledge mode where each pertinent memo is
flagged with a (Y or N) for deletion.  Two variables control the
typeout and checking of memos. They are:

	Q$Memo Begin$ = 20
		The memo will be displayed if the current time is
		within this many minutes of the memo time.
	Q$Memo Quit$ = 10
		The memo will no longer be displayed if the current
		time is greater than the memo time by this many
		minutes.
	Q$Memo Watch$ = 1
		Flag indicating the type of memo checking or messages
		to be output.
		<0, Output a memo message only if one exists. That is,
			do not output any error messages.
		=0, Omit all memo checking.
		>0, Output any messages.
	Q$Memo Alert$ =5
		Number of minutes before due time of message to alert
		the user with a bell and a pointer to the message.

The memos are stored in the variable Q$Memo_File$, which can be
changed by MM Edit Options.  The format of the file should be as
follows:
	For each line the date and time and the message should be
used.  The date and time field must be in one of the system date and
time formats.  For example, each line of the file should contain:

	dd-mmm-yy#hh:mm:ss#Message to be output		mmm=Jan, Feb, etc
  or	dd/mm/yy#hh:mm:ss#Message to be output		mm=01,02, etc

	with # symbolizing a space
!

!*    Note: text having exclamation point and 6 stars following are
      debug statements to the next exclamation points !

    :F"G 1[W'			    !* If called via MM then default!
				    !* message output to all!
    "# 0FO..QMemo_Watch F"N [W'"# ''	    !* Do the macro only if!
				    !* the variable Memo Watch is!
				    !* nonzero!
    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    F[bbind			    !* Make a temporary buffer!
    [A [B [C [D 0[E 0[F [G [H [I [T !* Push the temporary q-regs!
    fshsname[Z
    :I*ZMEMO.FILE.0FO..QMemo_FileUZ  !* QZ contains the filename of the!
				    !* memo file!
    FFUA			    !* QA gets whether any arguments!
				    !* were given!
    1:<ERZ>"N		    !* Check to see if the memo file!
				    !* actually exists and output an!
				    !* error message if Q$memo watch$!
				    !* is set greater than 0!
	QW"G
	    :I*CNo_Memo_File_FoundFSechodisp
	    0fsechoactive  '  '
    @Y				    !* Haul the whole file in!
    M(M.M &_Sort_With_Date_Key)    !* Sort the file by date!

    20 FO..QMemo_Begin *182   UB !* QB is  the time of lower limit!
    10 FO..QMemo_Quit  *182   UC !* QC is the upper limit!
    5  FO..QMemo_Alert *182   UH !* QH is the critical warning!
				    !* period!

				    !******  :FT ******!
    J <.-z;W			    !* For the whole buffer!
	0l 0ud WFSFDCONVERTUdW 1:C;
	WFSDATEUT		    !* QT gets the current time and date!
!******	FTCurrent_Time=QT:=
	FT__Memo_Time=QD=
	FTBegin_Int.=QB:=
	ft__End_Int.=QC:=
	ft__Alert_Int.=QH=
	FTIf_Lower=
	QD-QT-QB F(:=
	    ft_) "'L F(:= ft___If_Upper=) & (
	    WQD+QC-QT F(:= ft_)"'G F(:= ft___&=)) =
	FT

*******!
	W QD-QT-QB"'L & (WQD+QC-QT"'G) "L    !* We have one!
	    %FW			    !* Increment the memo counter!
	    400300000000.,QD:FSfdconvertUIW	    !* Convert the!
				    !* time into a more useable format!
	    :XG			    !* The rest of line is the message!
	    :IGI_G	    !* Put in the due  time of the message!
	    qa"E
		QD-QT-QH"'L & (QD-QT"'G) "L !* Notify with bells and whistles!	
				    !* when within the span of Memo!
				    !* Alert and not greater then the!
				    !* memo time!
		   !<<! W:IG>>G'
		"# W:IG__G' '  !* If the due time!
				    !* has not gone past then put in!
				    !* two angle brackets as prompts!
	    "# W:IG__G'	    !* else just two spaces!
	    QF-1-((QF-1)/3*3)"G qf-1"N :IGAG'
		30'		    !* A!
				    !* little bit of formatting in the!
				    !* echo area!
	    "# qf-1"N75'	    !* Pause for 2.5 seconds if there!
				    !* are more then three messages!
		:IGCG'	    !* Clear Echo area!
	    0L QG FSEchodisp 0fsechoactive	    !* Display the memo!
	    QA"N 1M(M.M &_Yes_or_No)"L 1K 1UE'"# 1l''

				    !* If we should acknowledge then!
				    !* print message (Y or N).  If the!
				    !* user responds with a Y then the!
				    !* message is deleted!
	    "# 1l' '		    !* Skip otherwise!
	"# 1l'
	>			    !* End of iteration!
    QF"E QW"G			    !* If there were memos and QW=1!
				    !* then output the message.!
	    :I*CNo_MemosFSEchodisp
	    0fsechoactive  ''    !* Quit when done!
    QE"N
	1:<EDZ>		    !* Delete it if we can!
	0,Z M(M.M Write_Region)Z '	    !* If anything was changed!
				    !* then output the file!
    				    !* Quit!

!^R Personal Help:! !^R Displays everyline containing string
It looks at the file stored in Q$Personal_Help_File$.  A numeric
argument shows that many lines after and including the string!
    F[dfile
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    1,FEvery_occurrence_of:_[A   !* Qa gets the string argument.!
    FQA:"G 0'
    0[0 [1 0[Y Q1F"N -1 "'NUY' Q1:"G q1-1U1'
    fshsname[B
    (:I*BPERSONAL-HELP.TXT.0)FO..QPersonal_Help_FileUB
    :I*[C
    F[BBIND			    !* Make a temporary buffer!
    1:<ERB>"N		    !* Check for the filename!
	'
    "# @Y			    !* Grab the file!
	J <.-z; :SA;		    !* Look for the name!
	    0l  WQ1F(:"G 1L'
		)@XC %0W	    !* Pick it up in QC!
	    QY"L :ICC---
		'
	    Q1:"L 1l'>			    !* skip a line!
	'
    :I*Cfsechodisp		    !* Clear the echo area!
    FQC "G			    !* If we found any entries, then!
	:IC
	
	C
	Done.
	FTC'
    "# @FTNo_Match. 0fsechoactive'
   0				    !* Return.!


!^R Started Project:! !^R Insert start of project info into the file.
    Given an argument it states that the project was continued instead of
    started.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    0[..F			    !* Do not allow munging of other stuff!
    fshsname[Z
    :I*ZProjects.TXT.0FO..QProjects_FileUZ    !* QZ gets the file name!
    QZUBuffer_Filenames
    1,FProject:_[A		    !* QA gets the project descriptor!
    FF [C			    !* QC is non-zero if an argument!
				    !* was given.  This will place the!
				    !* word continued in place of started!
    [B :IBStarted		    !* QB gets the word!
    QC"N :IBContinued'
    F[bbind			    !* Get the temporary buffer!
    IProject:_A		    !* Put in the project name!
    B_on_			    !* Keyword and the date!
    M(M.M Insert_Date)
    :L 46I 13I 10I		    !* Prepare for going down a ^R level!
    QC"E			    !* We do that only if no argument!
	13i 10i			    !* add a crlf!
	I	Description:	    !* The word description!
	
	QMode[D		    !* Get the mode and then reset to!
				    !* text mode!
	0FO..QMM_COMPILE"N [MM_COMPILE'  !* Keep The Compile Command!
	M(M.M Text_Mode)
	9:I*[Fill_Prefix	    !* push the fill variables!
	70[Fill_Column
	1[Auto_Fill_Mode
	2,9i 13i 10i -2C	    !* Start the paragraph with two!
				    !* tabs instead of just one!
				    !* Enter the ^R level!
	1:<M(M.M D_Mode)>W'	    !* When we return reset the mode!
	J 12i 13i 10i		    !* Make sure the project is on a!
				    !* separate page!
	zj 13i 10I		    !* and that it ends in a CRLF!
	0,Z M(M.M Append_To_File)Z	    !* Then append the file!
	

!^R Telephone Call:! !^R Appends another entry to Q$Telephone Call File$.
The numeric argument is taken as minutes if it is positive or integral
hours if negative with the default being 15 minutes.  This value is
assumed to be the time taken.  Three string arguments are requested and
these are: The name of the person, his telephone number, and the topic
of conversation.  The user is then placed in a ^R sublevel to edit the
rest of the fields.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
				    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    0[..F			    !* Do not allow munging of other stuff!
    FSHSNAME[Z
    :I*ZTELEPHONE.CALLS.0FO..QTelephone_Call_FileUZ
				    !* QZ gets the file name!
    QZUBuffer_Filenames
    1,FName:_[A		    !* QA gets the name of the customer!
    FQA:"G '			    !* If nobody then quit!
    1,FTelephone:_[C		    !* QC gets the type of help!
    1,FTopic:_[B		    !* QB gets the type of help!
    0[0 0[1 :I*[2 [D 
    FF"N '"#15'U0		    !* Q0 get the amount of time taken!
    Q0"G			    !* If positive then minutes and!
				    !* convert into a convenient form!
	Q0/60 U1		    !* Q1 Gets the number of hours!
	Q0-(Q1*60) U0		    !* Q0 Gets the number of minutes!
				    !* remaining!
	'
    "# Q0  U1 0U0'		    !* Put the hours in Q1 and zero!
				    !* the minutes!
    Q1F"G:\U2			    !* If there are any hours then put!
				    !* in the word hours after it!
	:I22_Hour
	Q1-1"G :I22s'	    !* If more than one make the word plural!
	:I22_		    !* Add a space behind for the!
				    !* minutes to follow!
	'
    Q0F"G:\U1			    !* If more than one minute then!
	:I221_Minute	    !* Insert the value with minutes!
				    !* after it!
	Q0-1"G :I22s'	    !* If more than one make it plural!
	:I22_		    !* Add a space behind it for the!
				    !* next step!
	'
    FQ2"G 0,FQ2-1 :G2 U2
	:I22.'		    !* Add the period at the end of!
				    !* the line!
    F[bbind			    !* Get the temporary buffer!
    QModeUD			    !* Get the mode and then reset to!
				    !* text mode!
    0FO..QMM_COMPILE"N [MM_COMPILE'	    !* Keep The Compile Command!
    M(M.M Text_Mode)
    9:I*[Fill_Prefix		    !* push the fill variables!
    70[Fill_Column
    1[Auto_Fill_Mode
    IName:__A 13I 10I
    FQC"G ITelephone_Number:__C 13I10I'
    FQB"G ITopic:__B 13I10I'
    
    IEntry_Date:__
    M(M.M Insert_Date)W :L 13I 10I 13i 10i
    INotes:
    		
    .( 13i10i 13i10i
	ITime_Taken:__2
	)J

    				    !* Enter the ^R level!
    1:<M(M.M D_Mode)>W	    !* When we return reset the mode!
    J 12i 13i 10i		    !* Make sure the project is on a!
				    !* separate page!
    zj 13i 10I			    !* and that it ends in a CRLF!
    0,Z M(M.M Append_To_File)Z  !* Then append the file!
    

!^R Telephone Number:! !^R Retrieves a telephone number.  The macro
takes a look at the file Company Telephone Directory File, and the
file in the variable Personal Telephone Directory File is not defined,
for any names containing the string argument and displays the contents
on that line.  An argument specifies the number of lines to display!
    F[dfile
    E[ E\ FN E^ E]		 !* Push input channel and prepare!
				 !* to pop it at the end!
    1,FName:_[A		 !* Qa gets the string argument.!
    FQA:"G 0'
    0[0
    fshsname[B
    (:I*BTEL.X.0)FO..QPersonal_Telephone_Directory_FileUB
    (:I*HLP:COMPANY.TEL.0)FO..Q Company_Telephone_Directory_File[D
    2FO..Q Company_Telephone_Occur[E
    :I*[C

    F[BBIND			 !* Make a temporary buffer!
    1:<ERB @Y>"E		 !* Check for the filename!
	J <.-z; :SA;		 !* Look for the name!
	    0l W@XC %0W		 !* Pick it up in QC!
	    1l>			 !* skip a line!
	Q0"N :ICC		 !* If any personal entries then!
				 !* delimit them with 2 crlf!
	 
	 ''

    1:<erD @Y>"E
    J <.-z; :SA;		 !* Look for the name!
	0l W qE@XC		 !* Pick it up in QC!
	1l>'			 !* skip a line!
    :I*Cfsechodisp		 !* Clear the echo area!
    FQC "G			 !* If we found any entries, then!
	:IC
	
	C
	Done.
	FTC'
    "# @FTNo_Match. 0fsechoactive'
   0				 !* Return.!

!^R Note Project:! !^R Insert project info into the file.!

    F[Dfile W[Buffer_Filenames   !* Push the filename and the!
    0f[dversion		    !* buffer filename!
    E[ E\ FN E^ E]		    !* Push input channel and prepare!
				    !* to pop it at the end!
    0[..F			    !* Do not allow munging of other stuff!
    fshsname[Z
    :I*ZProjects.TXT.0FO..QProjects_FileUZ    !* QZ gets the file name!
    QZUBuffer_Filenames
    1,FProject:_[A		    !* QA gets the project descriptor!
    1,FTime_Taken:_[B	    !* QB gets the time taken!
    F[bbind			    !* Get the temporary buffer!
    IProject:_A		    !* Put in the project name!
    Entry_Date:_
    M(M.M Insert_Date)		    !* Insert the date!
    :L 46I 13I 10I		    !* Prepare for going down a ^R level!
    13i 10i			    !* add a crlf!
    I	Description:	    !* The word description!
    
    QMode[D			    !* Get the mode and then reset to!
				    !* text mode!
    0FO..QMM_COMPILE"N [MM_COMPILE'	    !* Keep The Compile Command!
    M(M.M Text_Mode)
    9:I*[Fill_Prefix		    !* push the fill variables!
    70[Fill_Column
    1[Auto_Fill_Mode
    2,9i 13i 10i -2C		    !* Start the paragraph with two!
				    !* tabs instead of just one!
    .(zj 13i 10i
	ITime_Taken:__
	FQB "G GB I.'
	13i 10i)J

    				    !* Enter the ^R level!
    1:<M(M.M D_Mode)>W	    !* When we return reset the mode!
    J 12i 13i 10i		    !* Make sure the project is on a!
				    !* separate page!
    zj 13i 10I			    !* and that it ends in a CRLF!
    0,Z M(M.M Append_To_File)Z  !* Then append the file!
	

!*
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)PERSONALPERSONAL
1:<M(M.MDelete File)PERSONAL.COMPRS>W \
/ End: \
!
