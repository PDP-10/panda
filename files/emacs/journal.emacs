!*-*-TECO-*-!

!~Filename~:! !Write and replay journal files!
JOURNAL

!& Setup Journal Library:! !S Initialize variables and flags.!

    f[d file
    fs hsname fs dsname	    !* Set up the default journal file names.!
    fs osteco"e
      fs xuname fs d fn1
      etdsk:_JRNL'
    "# etdsk:emacs.journal'
    0fo..qJournal_Filenamef"n fs d file'  !* Any specified filename components override.!
    fs d file m.vJournal_Filename !* The result is the name we will use.!
    m.m&_Journal_Macro FS JRN MAC !* Set up macro for colons and ^G's in journal file.!
    

!Start Journal File:! !C Start writing a journal file.
With argument, writes a checkpoint (ESAVE) file first.!

    m(m.m Save_All_Files)
    f[d file
    fshsnamefs dsname
    fs osteco"e etdsk:ts_esave'   !* Set up filenames of checkpoint file.!
    "# et esave.exe'
    1:< @ed>			    !* Delete old checkpoint.!
    ff&1"n
      qEditor_Name[1		    !* Maybe dump a new one.!
      q..lm.V MM_&_Startup_1 ]1
      q..l( q..p(
      fs:ejpage(		    !* Must not use m.a because!
        f[d file
        :ejemacs;purify_:ej	    !* it loses to have a saved value of fs:ejpage!
	f]d file
        m(m.mDump_Environment)    !* on the qreg pdl.!
      )fs:ejpage
      )u..p )u..l'
    f]d file
    qJournal_Filenamef[d file
    :fs jrn open
    1:< ed >
    5,f Journal_Filenameu1
    et1
    fs d file uJournal_Filename
    fs jrn open
    1fs mode change
!* Describe current bfrs, files, libs, etc.!
    500f[ jrn interval		    !* Temp increase of buffer size!
    ff&1m(m.m&_Journal_Describe_Buffers)
    f] jrn interval
    1:< fs jrn update >	    !* Force Journal out now.!
    

!End Journal File:! !C Stop writing a journal file.!

!* Note: A journal file is likely to call this command as the last thing.
Ignore that call.!
    fs jrn in"n '

    :fs jrn open
    1fs mode change
    

!Replay Journal File:! !C Replay a journal file.
Takes filename as string argument; default is the name we would write.!

    QJournal_Filenamef[d file
    5,f Journal_Filename[1
    m(m.mSave_All_Files)	    !* Offer to save modified buffers.!
    et1 fs jrn exec
    

!& Journal Macro:! !S FS JRN MAC.!

    -"E
      [..J :I..J Clean_up_after_asynchronous_quit
      1f[jrn inhibit
       0'
    -:"N @feUJC fserr'
    [1
    m.m &_Journal_Number[2
    < fs jrn readu1
      q1-"e -1fsquit'	    !* :^G means simply quit, no recursive edit.!
      q1-."e			    !* Point means set point to following number.!
        m2j !<!>'
      q1-W"e			    !* W means set Window to following number and exit.!
        m2fswindow 0;'
      q1-B"e :m(m.m &_Journal_Verify_Buffers)'   !* B means verify buffers and exit.!
      q1-32"e 0;'		    !* Space means all done.!
      @feUJC fs err		    !* Anything else is an error.!
      >
    

!& Journal Number:! !S Read decimal number from journal file.
The terminating character should be a space or Altmode.
It is discarded.!

    0[1 [2
    < fs jrn readu2
      q2-0"l 0;'
      q2-9"g 0;'
      q1*10+q2-0u1 >
    q2-"n q2-32"n @fe UJC fs err''
    q1

!& Journal String:! !S Read string from journal file, terminated by Altmode.!

    f[b bind [1		    !* Accumulate it in a temp buffer.!
    < fs jrn readu1
      q1-@;			    !* Stop at altmode.!
      q1i >
    hx* 			    !* Turn bfr contents into a string.!

!& Journal Point:! !S Record current point and FS WINDOW in journal file.
Format is ":.digits Wdigits ".!

    :I* FS JRN WR [A
    :MA			    !* First write a colon so FS JRN MAC will read!
    .MA			    !* what follows.  Then ".digits Wdigits"!
    .:\MA			    !* Output string containing the digits of point.!
    _MA			    !* Terminate with a space.!
    WMA			    !* Window is similar but W instead of Period.!
    FS WINDOW:\MA
    _MA
    

!& Journal Describe Buffers:! !S Record current status of buffers, files, etc.
Nonzero argument means describe only the libraries.!

!*Output a string to the journal file that looks like
:Buffers
 FOORMS; FOO >6Fundamental76901065XMTECO; DEFAUL FILENM2
 BARUGH; BAR >62TECO00503  TECO;OTHER DEFAUL3
LibrariesEMACSJOURNA
VariablesFOOBAR3
Commands start on next line

The line starting with altmode instead of space marks the end.
It contains the name of the current buffer, then that of the previous buffer.
The format of each line is
 bfr namefilenamesfile versionmajor modepointbzmodifxmodifteco default filenamesbuffer number
If the version is not numeric, we write 0.
Modif is "M" if FS MODIFIED should be set, else space.
The "variables" line contains the current buffer, the previous buffer,
and Next Bfr Number.
!
    :I* FS JRN WR [A	    !* MA writes arg (char or string) to journal file.!
    :I* MA MA [B	    !* MB writes arg to journal file followed by Altmode.!
    :MA			    !* First write a colon so FS JRN MAC will read!
    :I*BuffersMB		    !* what follows.  Then Buffers indicating buffer status.!
    0[0 [2			    !* Q0 is index of buffer we are talking about.!
    FQ.B/5[1			    !* Q1 gets length of bfr table, in words.!
    < 15.MA 12.MA		    !* Separate buffers with CRLF.!
      Q0-Q1;			    !* Stop after all buffers handled.!
      :@;			    !* Don't describe any buffers if making checkpoint also.!
      32MA
      Q:.B(Q0+1!*bufnam!)MB	    !* Output bfr name, filename,!
      Q:.B(Q0+2!*bufvis!)F"N MA' MA
      0MA			    !* A zero to be the version # if there is nothing else.!
      Q:.B(Q0+2!*bufvis!)U2
      FQ2"G
        1:< ER2 EC FS IF VERSF"L *0':\MA >'    !* file version,!
      MA
      Q:.B(Q0+3!*bufmod!)MB	    !* major mode.!
      Q:.B(Q0+4!*bufbuf!)[..O
	.:\MB			    !* Then output position in buffer!
	B:\MB			    !* and virtual bounds.!
	Z:\MB
	FS MODIF"N MMB' "# _MB'
	FS XMODIF"N XMB' "# _MB'
	]..O
      Q:.B(Q0+5!*buftdf!)MB	    !* Output TECO default filenames.!
      Q:.B(Q0+7!*bufnum!):\MB	    !* Output buffer number.!
      Q:.B(Q0)+Q0U0 >		    !* Advance to next buffer.!
    F[B BIND
    :I*LibrariesMB		    !* "Libraries" at start of line!
    [8 [9			    !* means library names follow.!
    fs:ejpage*5120+400000000000.u8 !* 1st library address in q8!
    < -fq8;
      1,q8m.m~filename~u9	    !* Get next library's name!
      j g9 i		    !* Insert name followed by Altmode in buffer.!
      q8+fq8+4u8>		    !* Look at all libraries, most recently loaded first.!
    ZJ I

!* Buffer has names of libraries, in order loaded, each terminated by Altmode,
followed by another Altmode and a CRLF.!
    Q..OMA
    :I*VariablesMB		    !* Variables at start of line means!
    QBuffer_NameMB		    !* now come values of these variables.!
    QPrevious_BufferMB
    QNext_Bfr_Number:\MB
    :I*
Commands_start_on_next_line
MA
    

!& Journal Verify Buffers:! !S Set up buffers for replaying journal file.!
!* Called when the ":B" is read which was written by & Journal Describe Buffers.!

    :I* FS JRN READ [A
    M.M &_Journal_Number[N
    M.M &_Journal_String[S
    0M.VJournal_Visit_Version
    [Journal_Visit_Version
    [1 [2 [3 [4
    MS				    !* Skip "Buffers"!
    < MA MA			    !* Discard CRLF.!
      MAU1 Q1-32:@;		    !* Next line doesn't start with space => buffers finished!
      Q1-32"N @FEUJC FS ERR'	    !* Starts with space => another buffer described.!
      MSM(M.M Select_Buffer)
      MSU1			    !* Get filename!
      MNU2			    !* Get version number!
      FQ1"G
        Q2UJournal_Visit_Version
	1:<ER1>"E FS IF VERSF"L *0'-Q2U3'
	          "# 0U3'	    !* If file doesn't exist => clear flag.!
	0FS Modified		    !* Make sure this is cleared.!
	M(M.M Visit_File)
	Q3"N @FT File_1__remembered_version_not_latest_version.
 FG
	  < @FT__Proceed_anyway?   !* Get confirmation if versions!
	  1f[ jrn inhibit
	  1,1M(M.M&_Yes_or_No)U4   !*   do not match.!
	  f] jrn inhibit
	  -Q4;>
	  Q4"E :fs jrn exec 0''' !* Quit replay if answer was No.!
      "# 0uBuffer_Filenames'
      MSU1			    !* Get major mode.!
      FQ1"G F~Mode1"N	    !* If mode not already in effect, switch to it.!
        M(M.M 1_Mode)''
      MN:J			    !* read in and reset point, B and Z.!
      1:< MNFS VB>
      1:< Z-(MN)FS VZ>
      MAU1 MAW Q1-_FS MODIF	    !* Set modified flags as remembered.!
      MAU1 MAW Q1-_FS XMODIF
      QBuffer_IndexU1
      MSU:.B(Q1+5!*buftdf!)	    !* Read in TECO default filenames!
      MNU:.B(Q1+7!*bufnum!)	    !* read in buffer number.!
      >
    MSU1			    !* Skip "ibraries"!
    F~1 ibraries"N @FE UJC FS ERR'
    < MSU1 -FQ1;		    !* Read strings till we get a null string.!
      1,Q1M(M.M &_Get_Library_Pointer)"E  !* If a library isn't loaded already,!
        M(M.M Load_Library)1' > !* load it now.!
    MSU1			    !* Skip the CRLF and "Variables"!
    F~1
Variables"N @FE UJC FS ERR'
    MSM(M.M Select_Buffer)	    !* Select the right buffer.!
    MSUPrevious_Buffer
    MNUNext_Bfr_Number
    MS				    !* Skip "Commands"!
    MAW MA			    !* Skip CRLF.!
    
    