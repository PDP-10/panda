!*-*- Teco -*- !
!~filename:~! !Functions for BBNers!
BBNLIB


!BugHunter Mode:! !C Attach your name to comments!

    m(m.mLoad_Library)BUGHUNT
    :m(m.mBughunter_Mode)
    

!Auto Justify Mode:! !C Auto justify paragraphs!

    m(m.mLoad_Library)JUSTIFY
    :m(m.mAuto_Justify_Mode)
    

!Invert Mode Line:! !S Toggle inverse mode line display!

    QDisplay_Mode_Line_Inverse"'E UDisplay_Mode_Line_Inverse
    1fsModeChangew		    !* invert and update!
     

!Pressify Buffer:! !S Pressify current buffer!

  0FO..QBuffer_Filenames"E
    :I*CNo_Output_Filename_in_effect
    fsEchoDisp 0fsEchoActivew '

  mm Save_All_Files
  3,m(m.m&_Read_Line)Pressify_option:_[1
  qBuffer_Filenames[0
  -(fz sys:pressify.exe.0_0_1/nosend)fzw
  

!Doversend File:! !S Send a file to the Dover!
  f6PRESSf[DFN2
  4m(m.m&_Read_Filename)Doversend_file[1
  3,m(m.m&_Read_Line)Doversend_options:_[2
  -(fz SYS:DOVERSEND.EXE_1_2/notell)fzw
  

!Show Dover Queue:! !S Run a DVRQ!
 f+:ft
 -(fz SYS:DOVERSEND.EXE.0_/SH)fzw
 

!Finger:! !S Do FINGER command!
 3,m(m.m&_Read_Line)User:_[0
 f+:ft					!* clear screen!
 -(fz SYS:FINGER.EXE.0_0
)fzw		!* do it!
 

!Whois:! !S Do WHOIS type of FINGER!
 3,m(m.m&_Read_Line)User:_[0
 f+:ft
 -(fzSYS:FINGER.EXE.0_0_/WH
)fzw
 

!H316 Mode:! !C Set things up for editing H316 code.!
    m(m.m&_Init_Buffer_Locals)
    1,24M.LComment_Column		!* try to put comments in column 24!
    1,(:I*/) m.lComment_Start		!* slash starts comments!
    1,(:I*/_)m.lComment_Begin		!* slash space looks nicer though!
    1,(:I*)m.lParagraph_Delimiter
    0fo..qMIDAS_Vector[1
    q1"e 5*5fsqvectoru1 q1m.vMIDAS_Vector
	m.m^R_Go_to_AC_Fieldu:1(0)
	m.m^R_Kill_Terminated_Wordu:1(1)
	m.m^R_Go_to_Address_Fieldu:1(2)
	m.m^R_Go_to_Next_Labelu:1(3)
	m.m^R_Go_to_Previous_Labelu:1(4)'
    1,Q:1(0)M.Q...A			!* use MIDAS Mode stuff!
    1,Q:1(1)M.Q...D
    1,Q:1(2)M.Q...E
    1,Q:1(3)M.Q...N
    1,Q:1(4)M.Q...P
    Q.0,1M(M.M&_Set_Mode_Line)H316
    

!C Mode:! !& C Mode:! !& H Mode:! !C Set up for editing C code!

 m(m.m &_Init_Buffer_Locals)		!* clear all local variables!
 1,(m.m ^R_Tab_to_Tab_Stop) m.q I	!* tab tabs to tab stop!
 1,(:i*____:___:___:___:___:___:___:___:___:___:___:___:___:___:___:___:___:(
    )) m.l Tab_Stop_Definitions	!* tab stops every 4 columns!

 1,40 m.l Comment_Column		!* start comments at column 40!
 1,(:i* +1) m.l Comment_Rounding	!* round columns to next possible!
 1,(:i* /*) m.l Comment_Start		!* comments start with slash star!
 1,(:i* /*_) m.l Comment_Begin	!* but add a space for legibility!
 1,(:i* _*/) m.l Comment_End		!* comments end with star slash!

 1m(m.m &_Set_Mode_Line) C 		!* set mode line, run hook, exit!

!Ada Mode:! !& Ada Mode:! !C Set up for editing Ada code.!
 m(m.mLoad_Library)ADA
 :m(m.mAda_Mode)
 

!Praxis Mode:! !& PRX Mode:! !C Set up for editing Praxis code.!
 m(m.mLoad_Library)PRAXIS
 :m(m.mPraxis_Mode)
 

!& TEXT Mode:! !S TEXT as EXT enters TXT mode.!
 :m(m.mText_Mode)
 

!& LISP Mode:! !S LISP as EXT enters LISP Mode.!
 :m(m.mLISP_Mode)
 

!^R Display Load Average:! !^R Show the load average, maybe date.
If you want to see the date too, put the following line in your init:
    1m.vDisplay Load Average And Datew!
!* This should work on any release 4 (3 too?) TWENEX.
 * The load average shown is the group (class?) load average.
 * There is now no way (I think -- ECC) to get the system load average.!
!* It may work on a TENEX, showing group and system load averages.!

 [0[2 45f[BBind		    !* Temporary buffer, 45/5=9 words long, so!
				    !* we can stuff machine code in it.!
 fsOSTeco-2"e			    !* TENEX.!
    330000000000.u:..o(0)	    !* Fill buffer with some machine!
    474040000000.u:..o(1)	    !* code to get the group load!
    104000000337.u:..o(2)	    !* average.!
    263740000000.u:..o(3)
    561045000011.u:..o(4)
    201140020200.u:..o(5)
    104000000233.u:..o(6)
    263740000000.u:..o(7)
    263740000000.u:..o(8)
    zj 30,32i
    j 1f? fsRealAddress/5u0 m0		!* Execute the machine code.!
    45j s  45,.-1x0			!* 0: Group load average.!
    fsLoadAverageu2			!* 2: System load average.!
    hk
    iGroup_load_is_ .(g0)j @f_k zj	!* Only one space before l.a.!
    i,_System_load_is_ .(g2)j @f_k'	!* Buffer now has the TENEX load!
					!* average message.!
 "#					!* TWENEX.!
    fsLoadAverageu0			!* 0: load average, as a stringified!
					!* number, e.g. 12.43, with a possible!
					!* leading space.!
    hk					!* Kill initial buffer nulls put in in!
					!* case we had to do TENEX machine code!
    iLoad_average_is_ .(g0)j @f_k'	!* Get load average, remove!
					!* leading spaces.!

    !* Buffer has load average message, for TENEX or TWENEX.!

 0fo..qDisplay_Load_Average_And_Date"n	!* User wants date too.!
    j .-z( m(m.mInsert_Date)w )+zj i.__'	!* ...!

 j iC zj i
 q..o fsEchoDisplay			!* Clear the echo area and type out!
					!* the message.!
 0fsEchoActivew 1 			!* Keep it around after we exit.!

!^R Backward Kill Line:! !S Delete Line Backwards!
 0m(m.m^R_Kill_Line)w
 

!& H16 Mode:! !S Set up for editing H316 code.!

    :m(m.mH316_Mode)

!& SIM Mode:! !S Set up for editing Simula code.!
    m(m.mLoad_Library)SIMULA
    :m(m.mSimula_Mode)

!Uncontrolify:! !C Show control characters in up-arrow form!
    m(m.a TMACS Uncontrolify)w
    

!Save Trees:! !C Compress short pages onto same page!
    m(m.a TMACS Save_Trees)w
    

!Print Buffer:! !C Send current buffer to LPT:
Optional string arg is file to output to; default is LPT:
If given arg, then will prompt for output device.!

    ff&1"n
       @m(m.a PRINTPrint_Buffer)w'
"#
       m(m.aPRINTPrint_Buffer)w'
    

!Print File:! !C Prints a file on the output device.
The calling format is

    <length>,<width> MM Print File$

It will prompt for a filename and output device.!
    @m(m.a PRINTPrint_File)w
    

!Scribe Buffer:! !S Scribe current buffer.
Buffer should have a filename attached, so we know where to right to.
Upon return, we view the error file, which MAY NOT be from the current
Scribe run.!

  0FO..QBuffer_Filenames"E
    :I*CNo_Output_Filename_in_effect
    fsEchoDisp 0fsEchoActivew '

  mm Save_All_Files
  3,m(m.m &_Read_Line)Scribe_option:_[1
  qBuffer_Filenames[0
  0fo..qScribe_*Handle*f"ew
    fzSYS:SCRIBE.EXE_0_1
m.vScribe_*Handle*'
    "# ,0:  fz 0_1
'w
  f6ERRf[DFN2
  e?"n @ft(No_errors) 0fsEchoActive'
  "#
    f6ERRf[DFN2
    m(m.mView_File)'w
  

   