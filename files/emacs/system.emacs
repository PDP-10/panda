!* -*-TECO-*-!
!~filename~:! !Commands to get system information!
SYSTEM

!& Setup SYSTEM Library:! !S Setup default macros for system!
    0FO..Q SYSTEM_Setup_Hook[0	    !* If the user has his own hook then!
    fq0"G :M0'			    !* run it instead!
    FSXJNAME:F6[1
    0M.CSystem_Superior_Type_Nonzero_implies_an_invoke_inferior_type
    F[bbind G1 J
    1+(:SMACS)USystem_Superior_type
    

!^R Valret:! !^R Valrets string arg to EXEC, pauses, then continues!
    [0 1,FCommand: u0 FF"N *30' "# 150' [1
    :I*Zfs ECHO DIS
    QSystem_Superior_Type"E
	FF-1"G
	    :I*CFSECHODISP
	    @' 0
	cont
	'
    "#
        FF-1"G @' 0FZ0
	pop
	'
    Q1:
    


!Check Output Queue:! !C Checks the output queue.
The string argument can be one of ALL,FAST,USER.!
    [a				    !* Push temporary registers.!
    1,fSwitch_(ALL,_FAST,_USER:)?_ua	    !* Prompt if called from a key.!
    FQA:"G ohaveit'		    !* Default is nothing!
    F~aALL"E ohaveit'		    !* If either of  ALL,FAST,USER: !
    F~aFAST"E ohaveit'
    F~aUSER:  -6"E ohaveit'
    w				    !* Otherwise, just exit!
!HAVEIT!
    fqa"G :ia_/a' "# :ia'
    5M(M.M ^R_Valret)inf_outputa
    w				    !* exit!

!Check Batch Queue:! !C Checks the batch queue.
The string argument can be one of ALL,FAST,USER.!
    [a				    !* Push temp. reg.!
    1,FSwitch_(ALL,_FAST,_USER:)?_ua	    !* Prompt if called from a key.!
    FQA:"G ohaveit'		    !* Default is nothing!
    F~aALL"E ohaveit'		    !* Given one of the options.!
    F~aFAST"E ohaveit'
    F~aUSER:  -6"E ohaveit'
    w				    !* Otherwise, just exit!
!HAVEIT!
    fqa"G :ia_/a' "# :ia'
    5 M(M.M ^R_Valret)inf_batcha


!SYSTAT:! !C Does a SYSTAT.
The optional string argument is a subcommand for SYSTAT, and if an error
occurs the user will be required to type a POP.!
    [a				    !* Push temp. reg.!
    1,FOptions:_ua		    !* Prompt if called from a key!
    5 M(M.M ^R_Valret)SYSTAT_a


!^R SY A N O:! !Check Users:! !^R Valrets an SY A N O!
    Fm(m.m^R_Valret)SY_A_N_O
    


!Check System Job:! !C Does an INFORMATION JOB to give your current position!
    1,5 M(M.M ^R_Valret)INF_job
    

!^R System Load Average:!!^R Display Load Average:! !^R Gives the 1-min. Load Average in the echo area!

:I*CFSECHODISPLAY		    !* Clear ECHO area!
FSLOADAV[0			    !* Get the load average!
200300000000.,FSDATE:FSFDCONVERT[1		    !* The date and time!
@ftLoad_Average_=0_____1
				    !* Print Message!
0FSECHOACTIVE			    !* Prevents immediate ECHO clear!
0

!Access to Directory:! !C Access to a directory.
The first string argument is the directory (with brackets, of course).
The second one is the Password if needed.!
    [a [b [c			    !* Push temporary registers!
    1,fDirectory:_ua		    !* Ask for the directory if called from!
				    !* a key!
    fqa"G			    !* Given one, do!
	:F"L @ftPassword:_	    !* If called form a key then!
	    :ib		    !* Read in the password silently!
	    <fiuc		    !* If a CR then end!
		qc-"E 1;'	    !* Append to the password QB!
		:ibbc>
	    '"# :ib' '	    !* Otherwise, read in string arg.!
    "#:ib'			    !* Otherwise, no password!
    1,0M(M.M ^R_Valret)access_a
b
    

!Check Disk:! !C Does an INFORMATION DISK on the given directory!
    [a				    !* Push temporary registers!
    1,FDirectory:_ua		    !* QA gets the directory!
    5 M(M.M ^R_Valret)inf_disk_a
    

!Expunge Directory:! !C Expunges the deleted files in the given directory!
    [a				    !* Push temp. reg.!
    1,fDirectory:_ua		    !* Prompt if from a key!
    fqa:"G
	f[bbind
	g(fsdfile)
	!<! j :s> :"L 0l'
	:k
	hxa
	f]bbind '
    :I*Zfs ECHO DIS
    1,5M(M.M ^R_Valret)exp_a
    

!Check Available:! !Checks available items on systems, default is DEVICES.
The other option is to check available lines!
    [a				    !* Push temporary register!
    1,fAvailable_(Devices_or_Lines)?_ua  !* Read the type of info!
    fqa"G			    !* Something there set to one of the two!
	f[bbind		    !* options, either Devices or Lines.!
	ga H@FC
	j 1a-76"N :iaDevices'
	"# :iaLines'
	f]bbind '		    !* The default is Devices!
    "# :iaDevices '
    5 M(M.M ^R_Valret)Inf_avai_a
    

!Check Job:! !C Reports the Job Number, User, and Connected Directory
if different from the user!
    fsuindex:\[0
    fshsname[1
    fsmsname[2
    [3
    f[bbind
    g(fshsname)
    j :S:< !>! "L 0k :l -d' 0l :x3
    f]bbind
    :i3Job_0,_User_3
    f~12"N :i33,_2'
    :i*C3
    fsechodisp0fsechoact
    w1

!Logout:! !C Logs off the user, offering to save files as necessary!
    FF"E
	:i*CDo_you_really_want_to_be_logged_offfsechodisp
	0fsechoactive
    1M(M.M &_Yes_or_No)"E ''
    M(M.M Save_all_Files)
    0M(M.M ^R_Valret)Logout
    


!Enable Capabilities:! !C Turns on Enabled capabilities if they exist.!
    1,0M(M.M ^R_Valret)ENAble
    

!Disable Capabilities:! !C Turns on Disabled capabilities if they exist.!
    1,0M(M.M ^R_Valret)DISAble
    

!Check Log File:! !C Checks the Log file for any changes.
The FN1 of the log file should be given as a string argument or the
default FN1 name will be used to make the filename.!

    [Previous_Buffer		    !* Push to get the right buffer reset!
    1,FFN1_of_the_Log_File:_[C   !* QC gets the fn1!
    M(M.M Select_Buffer)*LOG*	    !* Select a temporary style buffer!
				    !* name of *LOG*!
    Z[A				    !* Check to see the last point!
    fqc :"G fsdfn1uC		    !* If no string argument, then!
				    !* check the default FN1 name!
	F~(QBuffer_Name)C"E    !* If the same as the buffer name!
				    !* then we are lost!
	    :I*CImproper_Name_Given	    !* Print the error message!
	    fsechodisp0fsechoactive W Oend''    !* Go back to!
						    !* previous buffer!
    "#  0ua
	f[bbind		    !* Otherwise, get a temporary buffer!
	GC 0J			    !* bring in the string argument!
	<!<!:S:>;	    !* Hack out the directory name!
	    fssvalue+1"E 1c'>	    !* Skip if the quote character is there!
	<:s.F"E zj 32iw 0;'+1; 1c> !* Get to the FN1 name!
	1:R 0Xc			    !* Put it back in the buffer!
	F]bbind'		    !* Pop the temporary buffer!
    :ICC.log		    !* Make the full file name!
    E?C"N
	:I*CNo_such_filefsechodisp0fsechoactive
	OEND'
    -1 M(M.M Visit_File)C	    !* Get the new file!
    QA:J 0l			    !* Move to where the old one was!
    z-qa"G			    !* Check to see if different length!
	M(M.M View_Buffer)'	    !* Yes, then view the buffer from!
				    !* that point!
    "# :I*CNo_Change		    !* No, then announce it!
	fsechodisp0fsechoactive'
    !END!
    M(M.M Select_Buffer)	    !* Back to the previous buffer!
    
