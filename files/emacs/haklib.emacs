!* This is the EMACS INIT for FMF, KRONJ, and WHP4.  Compressed code generated
   from this file should be suitable for ITS, TOPS-20, and TENEX.
   Use at your own risk, but should be safe if you dont setup environ...

   A typical EMACS INIT based on this library might be:
	:i*David Eppsteinm.vBabyl Personal Name
	m(m.mLoad Library)HAKLIB
	:m(m.m& Setup HAKLIB Environment)

   Modifications:
    161 29-Sep-85 Kronj More improvements to SvM username cleanup
    160 27-Sep-85 Kronj Smarter SvM username cleanup; make c-X M work again
    159 29-Jun-85 Kronj Improve comment finder in label search redisplay
			Try using ZBabyl for mail reading
    158  6-Apr-85 Kronj Split out C Mode stuff; more flushed headers
    157 11-Oct-84 FMF   Make Overwrite Mode local in Buffer Creation Hook
    156 14-Sep-84 Kronj More headers: Loc, Also-Known-As
    155 16-Aug-84 Kronj Flush headers: Organization, Postal, Posting-Version
    154  2-Aug-84 Kronj Fix up ..D for C mode (make label search work better).
			Only allow Content Syntax chars in content.
    153 29-Jul-84 Kronj Label search for C mode
    152 16-May-84 whp4  Don't set Babyl Default File if already defined
    151 13-May-84 whp4  Add & CC File
    150 10-May-84 Kronj Ambassador doesn't invert mode line for WHP4
    149  1-May-84 Kronj Add Mail Stop: (no space) to flushed headers
    148 12-Apr-84 Kronj Add Web modes from XPAS library.
    147  1-Apr-84 Kronj Process comma in JCL.
    146 31-Mar-84 Kronj Improve survey flusher.  Ignore some more headers.
    145 11-Mar-84 Kronj Move ^R Save/Restore Point to c-\ J from c-X J
			(I want to write a PTY controller and put it on c-X J).
    144 27-Feb-84 Kronj TeX82 is now called TeX again so run that.
			Don't mung c-m-D in assembly modes.
			Label Search widens bounds if paged.
    143 28-Dec-83 Kronj Run TeX82 instead of TeX, flush ^R from PCL RSCAN.
    142 23-Dec-83 Kronj More fixes to MMail - still need to read JCL
    141 19-Dec-83 Kronj Fix :mLMMAIL$ - must use non-colon M
			Replace Text Mode Hook (lost when improved Scribe)
    140 15-Dec-83 Kronj Start this history - lotsa stuff has happened
			since this library was written and it would be nice
			to be able to keep track of any new changes.
			    Remove hack for not loading MWIND when we are
			running under MM.  MMAIL used to not work well with
			MWIND, but I have rewritten it to use MWIND instead
			of the old-style windowing.
			    Make Scribe mode use the TeX doublequote hack.
			Real doublequotes look awful in CMR and probably in
			the other available fonts.
			    Fix & Setup... to not lose if the library
			is loaded, killed, and then loaded again.  You will
			probably still lose if it is loaded twice at once.

      Everything else is prehistory... !

!~Filename~:! !EMACS macros for FMF and KRONJ!
HAKLIB

!& Setup HAKLIB Library:! !S Necessary stuff for the library to work!

 0fo..qHAKLIB_Already_Loaded_Once"e	!* If we havent already done this!
   m.l Saved_Point_Vector		!* make local variable for c-X J!
   %Initial_Local_Count		!* increment permanent local count!
   1m.vHAKLIB_Already_Loaded_Once'	!* Remember to not do it all again!

 0fo..q Buffer_Creation_Hook m.v HAKLIB_Old_Buffer_Creation_Hook
 :m(m.m &_HAKLIB_Buffer_Creation_Hook m.v Buffer_Creation_Hook)
					!* Make vars for all bufs (Main too)!

!& Kill HAKLIB Library:! !S Remove pure hooks etc.!
!* Do not kill this library if & Setup HAKLIB Environment has been run.
   Too many things are in pure space and will break.!

 qHAKLIB_Old_Buffer_Creation_Hook uBuffer_Creation_Hook

!& Setup HAKLIB Environment:! !S Do the actual initialization!

 1 fs No Quit				!* Disable ^G until we get through   !
 !"! 0fs ^R Initu..' 0u:.X()	!* Flush c-X c-R (set again on ITS)  !

!******************** Hooks needed before lib loading ***********************!
 2401 m.v SLOWLY_Maximum_Speed			!* Use slowly up to 2400 baud!
 m(m.m &_HAKLIB_TTY_Macro f(fs TTY Macw))	!* Set our fancy tty macro   !
 m.m &_HAKLIB_Set_Mode_Line_Hook uSet_Mode_Line_Hook !* and mode line hook!

!******************** Preliminary rearrangement of keys *********************!
 q...Du.../				!* c-m-/: ^R Down List		     !
 q...Ku...D				!* c-m-D: ^R Kill SexP		     !
 q.Wu...K				!* c-m-K: ^R Kill Region	     !
 m.m ^R_Copy_Regionu.W		!* c-W:   ^R Copy Region	     !

 m.m ^R_Autoargumentu..- 460.-1[0	!* Set meta-minus and meta-digits    !
 10<q..-,(%0)@fs ^R CMac>		!* So Alt 1 2 always gives arg of 12 !

!******************** Make a new prefix char or two *************************!
 m(m.m Make_Prefix_Character).UU.\	!* c-\: new prefix (orig pref meta)  !
 qPrefix_Char_List[0			!* Add to list of prefixes	     !
 :iPrefix_Char_List0 Control-\__q.U  


!******************** Load some libraries, set some keys ********************!
!* Libraries should be loaded in the order most convenient for killing them  !

 m.m Load_Library [L			!* L: Library Loader		     !
 fs O Speed-2401"l mL Slowly		!* Be nice to my slow terminal	     !
    m.m ^R_Set_Screen_SizeU:.X(S)'	!*   c-X S:   Use less of screen     !
 qEMACS_Version-161"g			!* In EMACS 162 or greater	     !
    mL Complt'				!*   Completing reader for buf names !
 mL ScrLin				!* Move by screen lines, not text    !
 fs OS Teco"e mL Sends		!* Handle tty messages nicely on ITS !
    1uSends_Doc			!*   Simpler notification	     !
    m.m ^R_Send/PrSendU:.X()'	!*   c-X c-R: Read or send tty msgs  !
 1:<mL FixLib				!* Stuff for editing EMACS code	     !
    m.m Examine_FunctionU:.X()	!*   c-X c-E: View macro def	     !
    m.m ^R_Examine_KeyU:.X()>	!*   c-X c-K: View q-reg or key	     !
 1:<mL MWind>				!* More than 2 windows on the screen !
 1:<mL XPage>				!* Winning paging macros	     !
 mL TDebug				!* Better TECO debugging system	     !

!******************** Copies of funcs from other libs ***********************!
 m.m &_Impurify[I			!* I: function copier		     !
 mI IVORY ^R_Ivory-Bound_This_Page	!* From IVORY:	Like set bounds page !
 mI TMACS ^R_Break_Line		!* From TMACS:	Break line in middle !
 mI TMACS Uncontrolify		!* 		Make ctrls printable !
 mI TMACS ^R_Uppercase_Last_Word	!*		Backwards uppercasify!
 mI TMACS ^R_Lowercase_Last_Word	!*		Backwards lowercasify!
 mI TMACS ^R_Uppercase_Last_Initial	!*		Backwards capitalize !

!******************** Miscellaneous commands ********************************!
 0uDisplay_Matching_Paren		!* Don't jump back to matching paren !
 1uError_Messages_in_Echo_Area	!* Err msgs under mode line - big win!
 1uAuto_Save_Default			!* Auto-save so crashes aren't as bad!

 1m.v Suppress_Blanking		!* Don't blank on exit at SCORE	     !
 1m.v Next_Screen_Context_Lines	!* Overlap windows by only one line  !
 1m.v Tags_Find_File			!* I like lots of buffers	     !

 m.l Overwrite_Mode			!* make overwrite mode local	     !
 %Initial_Local_Count			!* increment permanent local count   !

 m.m &_HAKLIB_WORDAB_Setup_Hookm.v WORDAB_Setup_Hook

 fs OS Teco"n				!* on TOPS-20			     !
    g (fs XUName) j<:s.;> 0,.k	!* get last field of uname in buffer !
    [U hfxU				!* save in qU			     !
    fs OS Teco-1"e			!* for T20			     !
       :i* SCR:U-SAVE..0 m.v Auto_Save_Filenames'"#	!* tenex is different!
       :i* U-SAVE..0 m.v Auto_Save_Filenames'
    0fo..qBabyl_Default_File"e		!* if not defined already!
      fs HSName u0 :i* 0U.BABYL m.v Babyl_Default_File'
    '					!* set default filenames from it     !

 :iAuto_Push_Point_Notification_(Mark_Set)	!* More informative than ^@  !

 m.m Save_All_Files m.v MM_Save_Some_Buffers	!* Rename Save All Files     !
 m.m ~DOC~_Save_All_Files m.v MM_~DOC~_Save_Some_Buffers
 m.m ^R_Save_File m.v MM_Save_All_Files	!* So Compile wont call it   !
 m.m ~DOC~_^R_Save_File m.v MM_~DOC~_Save_All_Files

 :i*Extended_Command:_ m.v Read_Command_Prompt
 :i*Instant_Command:_ m.v Instant_Command_Prompt

 1m.v Inhibit_TeX_Dollarsign		!*   No flashback to previous dollar !
 m.m &_HAKLIB_TeX_Mode_Hook m.v TeX_Mode_Hook	!* when in TeX mode	     !

 m.m &_HAKLIB_Assembly_Mode_Hook m.v MIDAS_Mode_Hook m.v MACRO_Mode_Hook !*
!  m.v FAIL_Mode_Hook			!* Various PDP-10 assembly languages !

 m.m &_HAKLIB_Pascal_Mode_Hook m.v Pascal_Mode_Hook	!* Pascal label stuff!

 @:I*/m.m ^R_Examine_Next_M.M m.q X		!* X    examines next M.M    !
      m.m ^R_Forward_Screen_or_Exit m.q _	!* <sp> goes on or exits     !
      m.m ^R_Previous_Screen m.q H		!* <bs> shows previous screen!
      :mTECO_Mode_Hook			!* set keys for TECO	     !
     /m.v ExFun_Mode_Hook		!* When examining functions	     !

 m.m &_HAKLIB_TECO_Mode_Hookm.v TECO_Mode_Hook	!* Set up for TECO   !
 m.m &_HAKLIB_Scribe_Mode_Hookm.v Scribe_Mode_Hook	!* Set up for Scribe !
 @:i*|1m.l Auto_Fill_Mode				!* Autofill to col 70!
      0m.l Space_Indent_Flag|m.vText_Mode_Hook	!* when in Text mode !

!******************** Set up for macLISP ************************************!
 m.m &_HAKLIB_LEDIT_Setup_Hook m.v LEDIT_Setup_Hook	!* Prepare for LEDIT !
 0m.v LEDIT_Save_All_Files_Query	!* Dont run Save All Files on exit   !

 @:I*/-1m.l Display_Matching_Paren	!*   Check matching if on screen     !
      40m.v Comment_Column		!*   Leave some room for comments    !
      :i*(defun m.l Label_Search_Prefix !* Set up for Label Search	     !
      :i* (m.l Label_Search_Suffix
      :i*A'm.l Label_Content_Syntax
     /m.v LISP_Mode_Hook		!* When in LISP mode		     !

!******************** Set up for mail ***************************************!
 :i*ZBabylm.v Mail_Reader_Library	!* I want to read mail with Babyl    !
 :i*BabylMm.v Mail_Sender_Library	!* BabylM is much quicker to load    !
 m.m &_HAKLIB_Babyl_Setup_Hookm.v Babyl_Setup_Hook !* Save rest for later  !

!******************** More rearrangement of keys ****************************!
 q...(u...[ q...)u...]		!* c-m-[,]: Forward, backward up list!
 q..^u..! q...^u...!		!* m-exl:   Join lines, del indent   !
 q.^u..^ 700. fs ^R Initu...^	!* m-^:     Prefix control, self-ins !
 q...Wu:.U(A)			!* c-\ A:   Append next kill	     !
 q..Su:.U(C)			!* c-\ C:   Center line		     !
 q..Ru:.U(E)			!* c-\ E:   Cursor to screen edge    !
 q..Qu:.U(F)			!* c-\ F:   Fill paragraph	     !
 q[u:.U()				!* c-\ c-\: Prefix Meta		     !

!******************** From lib EMACS ****************************************!
 m.m ^R_Character_SearchU..S		!* m-S:     Search forward for char  !
 m.m ^R_Reverse_Character_SearchU..R	!* m-R:     Search backward for char !
 m.m ^R_View_Q-regU..Q		!* m-Q:     See what's in a q-reg    !
 m.m CompileU..Z			!* m-Z:     Save file and compile it !
 m.m ^R_Just_One_SpaceU.._		!* m-sp:    Kill spaces down to one  !
 m.m ^R_Indent_Comment_RelativeU.;	!* c-;:     Start comment lined up   !
 m.m ^R_Indent_NestedU...I		!* c-m-I:   Indent under prev lines  !
 m.m ^R_Indent_RelativeU..I		!* m-I:     Line up with words above !
 m.m Revert_FileU..*			!* m-*:     Undo changes since save  !
 m.m ^R_Count_Lines_PageU...=	!* c-m-=:   Say how big the page is  !
 m.m Rename_BufferU:.U()		!* c-\ c-B: Change name of buffer    !
 m.m Set_Visited_FilenameU:.U()	!* c-\ c-F: Change filename of buf   !
 m.m ^R_Indent_to_ColumnU:.U(9)	!* c-\ tab: my winning tab macro     !
 m.m ^R_Down_Indented_LineU:.U()	!* c-\ c-N: Start of text on next lin!
 m.m ^R_Up_Indented_LineU:.U()	!* c-\ c-P: Start of text on prev lin!
 m.m View_BufferU:.U()		!* c-\ c-V: View a buffer	     !
 m.m ^R_Kill_Terminated_Wordu:.U(D)	!* c-\ D:   Kill word, following char!
 m.m Insert_FileU:.U(I)		!* c-\ I:   Insert a file	     !
 m.m ^R_Next_Several_ScreensU:.U(N)	!* c-\ N:   c-V, but arg = # screens !
 m.m ^R_Previous_Several_ScreensU:.U(P) !*  P:   m-V, but arg = # screens !
 m.m UndoU:.U(U)			!* c-\ U:   Undo last major change   !
 m.m View_FileU:.U(V)		!* c-\ V:   View a file		     !
 m.m Insert_BufferU:.U(Y)		!* c-\ Y:   Insert a buffer	     !

!******************** From lib TWENEX ***************************************!
 fs OS Teco-1"e m.m Rerun_CCLU:.X(Z)'!* c-X Z:  Save, repeat exec command!
 fs OS Teco"n m.m Push_to_EXECU:.X(@)'!* c-X @: Push to inferior EXEC    !

!******************** Impure copies and autoloaders *************************!
 m.m ^R_Break_LineU..O		!* m-O:     Middle of line autofill  !
 fs OS Teco"n m.m ^R_WhoeditU...W'	!* c-m-W:   Add to edit history	     !
    "# 0 fs ^R InitU...W'		!*          or on ITS undefined	     !
 m.m Buffer_MenuU:.X()		!* c-X c-B: ^R on list of buffers    !
 m.m ^R_Uppercase_Last_InitialU:.X(C)!* c-X C:   m-C, but backwards	     !
 m.m ^R_Lowercase_Last_WordU:.X(L)	!* c-X L:   m-L, but backwards       !
 m.m ^R_Uppercase_Last_WordU:.X(U)	!* c-X U:   m-U, but backwards       !
 m.m ^R_Sketch_Insert_or_DispatchU:.U(S)	!* c-\ S: Template prefix    !

!******************** From this file ****************************************!
 m.m ^R_New_WindowU..W		!* m-W:     Choose a better window   !
 m.m ^R_Refresh_ScreenU.L		!* c-L:     Really refresh screen    !
 m.m ^R_Swap_Chars_Before_PointU.T	!* c-T:     My winning char twiddler !
 m.m ^R_Find_Unmatched_ParenU...(	!* c-m-(:   Find ( without )	     !
 m.m ^R_Super_ParenthesisU...)	!* c-m-):   Complete defun parens    !
 m.m ^R_Connect_to_DirectoryU:.U()	!* c-\ c-D: Connect to vis file's dir!
 m.m ^R_Find_Long_LineU:.U()	!* c-\ c-E: Look for overflowing line!
 m.m ^R_Auto_SaveU:.U()		!* c-\ c-S: Run an auto-save	     !
 m.m ^R_Change_Case_LetterU:.U()	!* c-\ c-T: Twiddle capitalization   !
 m.m ^R_Run_TecoU:.U()		!* c-\ esc: Read a line and macro it !
 m.m ^R_Label_SearchU:.U(.)		!* c-\ .:   Jump to label	     !
 m.m ^R_Insert_CommentU:.U(;)	!* c-\ ;:   Make comment within text !
 m.m ^R_Move_to_Screen_BottomU:.U(B)	!* c-\ B:   Go to bottom line of scr !
 m.m ^R_Move_to_Screen_TopU:.U(T)	!* c-\ T:   Go to top line of screen !
 m.m ^R_Zap_to_CharacterU...S	!* c-m-S:   Search and destroy       !
 m.m ^R_Reverse_Zap_to_CharacterU...R!* c-m-R:   Reverse search and kill  !
 m.m ^R_Previous_BufferU:.X(\)	!* c-X \:   Go to previous buffer    !
 m.m ^R_Save/Restore_PointU:.U(J)	!* c-\ J:   Save or restore position !

!******************** Final dealer prep and handling ************************!
 1:<er EMACS;SITE_INIT @y m(hfx*)>	!* Run local init if there is one    !

 fs MSName:f6u0			!* get connected dir name	     !
 fs OS Teco"e fs XUName:f6[U		!* on ITS get username		     !
    et DSK:0;U_FOO'		!* and set filename default	     !
 "# et 0FOO.BAR'			!* on T20 don't need uname to set def!

 :iEditor_Name ModE			!* rename ModE (Modified EMACS)	     !
 :i..J ModE_ 1fsModeCh		!* set mode line (maybe reset later) !

 0fs No Quit				!* Ok to ^G out now		     !

 fs X JName:f6[J			!* J: jobname as given by SYSTAT etc !
 :m(1,m.m &_Startup_J f"e w m.m &_Read_JCL') !* go to handler for jobname!

!& Impurify:! !S Impurify a function from a given library!

 1,f Library:_( 1,f Function:_[1 )[0	!* 0,1: Library, func!
 :g(m.a 0 1) m.v MM_1			!* copy main function!
 :g(m.a 0 ~DOC~_1) m.v MM_~DOC~_1	!* copy documentation!
 					!* Pop so library gets unloaded!

!& Get JCL:! !S Get cleaned up JCL into current buffer!

 z"e fj' j @f  
 _k		!* get JCL, flush leading whitespace!
 zj ."e 0fs Modifiedw 0fs X Modified '	!* exit quietly if nothing!

 0,0a-
"e -d'			!* remove cr and lf at end if any!
 0,0a-"e -d'
 

!& Read JCL:! !S Interpret JCL as filename to visit!

 0[1 [0					!* save used q-regs!

 m(m.m &_Get_JCL)			!* get the JCL in the buffer!
 j :s"n .,z@fx1 -d'			!* 1: commands to execute if any!
 j :s,"n .(zjji),z@fx1 -d'		!* If location to go to, add it to q1!
 hfx0					!* 0: name of file to read!
 0fs Modifiedw 0fs XModified		!* flush rest of buffer!

 fq0"n m(m.m Find_File) 0'		!* if we have a file, visit it!
 fq1"g m1'				!* run JCL if any!
 					!* finished with initialization!

!& Startup BABYL:! !& Startup B:! !S Babyl subsystem!

 m(m.m &_Run_Subsys) ZBabyl		!* never returns...!

!& Startup INFO:! !S INFO subsystem!

 m(m.m &_Run_Subsys) Info		!* never returns...!

!& Run Subsys:! !S Run string arg as subsys!
!* For use by & Startup BABYL and & Startup INFO...
   Assumes macro name is same as library name is same as editor name.!

[0 :i*[1				!* 1: Subsys name.  Save 0 for later!

 "e mL 1				!* if not given arg, load lib!
    :iEditor_Name 1		!* rename EMACS!
    :i..J 1_				!* set mode line!
    @:i..L |1m(m.m &_Run_Subsys)1|	!* repeat on startup!
    '

 1,(m(m.m &_Get_Library_Pointer) 1) m.m <ENTRY>f"n u1' !* look for entry!
 "#w m.m 1u1'			!* get macro to run!
 m.m ^R_Return_to_Superior[R		!* R: macro to exit EMACS!

!again!					!* provide label for loop!
 fs TTY Macf"n uA mA'			!* maybe run TTY macro!
 f[BBind m(m.m &_Get_JCL)		!* get JCL into a scratch buffer!
 hfx0 f]BBind				!* copy it into A!
 m1 0				!* run the subsystem!
 mR o again				!* exit EMACS, then run it again!

!& Startup LEDIT:! !S Process JCL for LISP editor!

 :iEditor_Name LEDIT :i..J LEDIT_	!* set editor name and mode line!
 m(m.m LISP_Mode)			!* set LISP mode for Main buffer!
 0fs Superior				!* clear fs Superior for some reason!
 mL LEDIT				!* load library!
 :m(m.m &_Read_JCL)			!* process JCL!

!& Startup MM:! !S Process JCL for MM inferior!
!* We used to also special-case for whether jobname is MM before we loaded
   the MWIND library - it didnt mix very well with MMAILs old display support.
   Now MMAIL uses MWIND, so we might as well have loaded it ourselves...!

 :iEditor_Name MMail :i..J MMail_	!* set editor name and mode line!
 mL MMail				!* does setup, resets ..L, etc!
 :m(m.m &_Read_JCL)			!* now read first command from JCL!

!Test Load:! !C Load any modified macros into Mm-vars and ^R-keys.
g(m.aIVORY~DOC~ Test Load)jk!

!* Previous garbage is to insert actual documentation from IVORY.!

!* This is unsuitable for & Impurify because it calls too many other macros.
   It does not call itself recursively forever because this library
   will be loaded before IVORY so M.A will find the IVORY version.!

 f:m(m.a IVORY Test_Load)

!Buffer Menu:! !C Display information about all buffers.
g(m.aTMACS~DOC~ Buffer Menu)jk!

!* This is like Test Load.  It works with & Impurify, but the macro is
   about 2000 characters long, and I would rather not clog up impure space
   with a string that long.!

 f:m(m.a TMACS Buffer_Menu)

!^R Sketch Insert or Dispatch:! !^R Insert sketch, or (with arg) menu of commands.
g(m.aSKETCH~DOC~ ^R Sketch Insert or Dispatch)jk!

 m(m.m Load_Library)SKETCH		!* Load the library!
 f:m(m.m ^R_Sketch_Insert_or_Dispatch)	!* and run the function!

!Pascal Mode:! !C Set up for editing Pascal code.
g(m.aXPAS~DOC~ Pascal Mode)jk!

 m(m.m Load_Library)XPAS		!* Load the library!
 f:m(m.m Pascal_Mode)		!* and run the function!

!Web Mode:! !& WEB Mode:! !C Set up for editing Web code.
g(m.aXPAS~DOC~ Web Mode)jk!

 m(m.m Load_Library)XPAS		!* Load the library!
 f:m(m.m Web_Mode)			!* and run the function!

!Grammar Mode:! !& GRAMMAR Mode:! !C Set up for CS143 parser grammars.!

 m(m.m &_Init_Buffer_Locals)		!* Flush local vars!
 m.m ^R_Indent_Relative m.q I	!* Tab runs Indent Relative!
 1m.l Space_Indent_Flag		!* Indent with spaces only!
 40m.l Comment_Column			!* Columns at column 40!
 :i*-- m.l Comment_Start		!* With two dashes!
 :i*--_ m.l Comment_Begin		!* And an extra space for pretty!
 1m(m.m &_Set_Mode_Line) Grammar	!* Pretty mode line!

!& NOTES Mode:! !S Set up for editing notes to myself.!

 :m(m.m Text_Mode)			!* This runs Text mode!

!C Mode:! !& C Mode:! !& H Mode:! !C Set up for editing C code!

 m(m.m Load_Library) CMODE
 f:m(m.m C_Mode)

!PCL Mode:! !& PCL Mode:! !C Set up for editing PCL code!

 m(m.m &_Init_Buffer_Locals)		!* clear all local variables!
 1,(m.m ^R_Indent_Relative) m.q I	!* tab runs indent relative!

 1,(@:i*| m(m.m &_Exit_EMACS)		!* clean up screen etc.!
           declare_pcl_1	!* and load pcl-routines!
|) m.l Compile_Command		!* when compiled!

 :i* CommandProcedure m.l Label_Search_Prefix
 :i* ;(_( m.l Label_Search_Suffix
 :i* A m.l Label_Content_Syntax

 1,(:i*!)f(m.l Comment_Start) m.l Comment_Begin
					!* start comments with exclam!
 1m(m.m &_Set_Mode_Line) PCL 	!* set mode line, run hook!

!# TDebug C:! !C Exit backtrace and continue macro execution.!
!* This function, which is on C on all other backtraces, lives on X in TDebug.
   We define C here as a synonym to X so I don't have to remember that. !

 f:m(m.m #_TDebug_X)

!^R Insert Comment:! !^R Put a comment at the current point in the text.
Makes sure there is space before the comment.  If not at the end of
the line, also makes sure there is space after the comment.
Both of these space checks can be disabled by supplying an argument.!

 .[1 [2
 ff"e 0f  "n -@f_	 "e _i'''	!* Make sure space before!
 qComment_Beginu2 fq2"l qComment_Startu2'	!* Get comment start string!
 g2 qComment_Endu2 fq2"l q1,.'	!* Insert, get end string, ret if none!
 .(g2)u2				!* Insert and save point to return to!
 ff"e :f  "n @f_	 "e _i'''	!* Make sure space after!
 q1,.(q2j)				!* Return changed buffer bounds!

!^R Change Case Letter:! !^R Twiddle case of next numarg letters!

 [1 .[0					!* Save current position!
 :i*abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[2
 f"lw -'<				!* Repeat arg times!
    "l -@:f2f( -."e @fg .,q0')l -c'
    "# @:f2f(-z"e @fg q0,.')l'
    1a-Z"g 1a-z+Zu1'"# 1a-Z+zu1' f1 :"l c'>
 .,q0f 				!* All done, return range of change!

!^R Connect to Directory:! !^R Connect to directory where visited file lives.
with a numarg, merely runs Connect to Directory.!

 ff"n f:m(m.m Connect_to_Directory)'

 qBuffer_Filenamesf[DFile		!* Get filename of current buffer!
 fs DDev[1 fs DSName[2		!* From it get device and dir name!
 fs OS Teco-1"e m(m.m Connect_to_Directory) 1:<2>'"#
                 m(m.m Connect_to_Directory) 2' !* Connect to it!
 0

!^R Previous Buffer:! !^R Like c-X B Return.!

qPrevious_Buffer:m(m.m Select_Buffer)

!^R Forward Screen or Exit:! !^R View the next screenful.
If there are no more, exit recursive ^R level.!

!* This is to put on space for within Examine Function!

 :f fs Window[0 .[1			!* save verified window and point!
 zj :f				!* get new window at end of buf!
 fs Window-q0"e m( fs ^R Init)'	!* if the same, exit ^R level!
 q1j q0fs Window			!* else restore old point and window!
 @:m(m.m^R_Next_Screen)		!* and go to next screen!

!^R New Window:! !^R Find a new window for point.
If given a numarg, tries to put point on that line;
otherwise, tries to fit defun, paragraph etc. on screen.!

!* The default function doesn't understand arguments.  So if we have an
   argument we do the simple reposition, else call the default function
   which does all the work.!

 ff&1"n @:f 0'		!* check for argument!
 @:m(m.m ^R_Reposition_Window)		!* call built-in to do all the work!

!^R Refresh Screen:! !^R Tell TECO the screen should be repainted.
With no arguments, says the entire screen is dirty.  A numerical
argument refreshes that line, relative to the current line.
One c-U is like an argument of 0.  Two c-Us refresh the current window.!

!* This is a more winning refresher macro for c-L.!

 ff&1"e -fs PJATYw '		!* no args?  refresh whole screen!
 fs RGETTY"e m( fs ^R Init)'	!* printing tty?  do original c-L!
 fs ^R ArgP&6"e			!* only c-Us as arg?!
    fs ^R Expt-1"n			!* more than one c-U?!
       f[Window f+ '			!* yes, just clear window!
    "# 0''"# ' + (fs ^R VPos) f((	!* else get number of line to refresh!
       -1,)fs Tyo Hash			!* clear hash code for that line!
    )+1 f(-1,)@f 0			!* redisplay line and return!

!^R Move to Screen Top:! !^R Go to first line of screen.!

 ff&1f"n':m(m.m ^R_Move_to_Screen_Edge)

!^R Move to Screen Bottom:! !^R Go to last line of screen.!

 -:m(m.m ^R_Move_to_Screen_Edge)

!^R Swap Chars Before Point:! !^R Switch the characters before point.
Treats CRLFs as single characters.  Point is unchanged.!

 .-b-2"l b+2:j"e @fg 0''		!* move up from beginning of buffer!

 0f  [0				!* 0: position on line!
 q0"e .-b-2"e :c"e @fg' 1u0''		!* dont wanna NIB error!

 q0"e -2au0 :i0 
 0'		!* check for beginning of line!
 "# q0-1"e 0au0 :i00  
'	!* and one after the begining!
    "# -au0 0a[1 :i01 0''	!* 0: string to replace (2 or 3 long)!

 .-(fq0)f0 -(fq0) 		!* replace string and return!

!^R Save/Restore Point:! !^R Save or restore point.
Reads a char from the echo area;  if it is an altmode, reads
a long name.  If given an argument, labels point with that char
or name;  otherwise, restores from a previously saved point.!

!*******************************************************************
** Note that one must do					  **
**    2u:(5fsQVECTORm.vSaved Point Vector)(0)			  **
** for this to work.  It also helps to make qSaved Point Vector **
** local to each buffer; see my Buffer Creation Hook for details. **
*******************************************************************!

 [0[1[2[3				!* save q-regs used!

 qSaved_Point_Vectoru2		!* 2: q-vector of point names and locs!
 ff&1"'e u0				!* 0: nonzero if restoring!

 m.i fi :fc u1				!* 1: Input char, upcased!
 q1-33."n				!* If it isnt altmode ...!
     q1-177. "e :i1 Delete'			!* Special-case delete!
     "# q1-40."l q1+100.u1 :i1 Ctrl-1'	!* ^X becomes Ctrl-X!
	      "# q1:i1'''			!* other chars become string!

 "# :i*C fs Echo Dis		!* Altmode - clear the echo area!
     q0"e 3,m(m.m &_Read_Line) Named_Point:_ u1' !* Save reads a new name!
       "# :i* Name_ [CRL_Prefix	!* Restore uses completing reader!
	  q2[CRL_List			!*   on list of saved point names!
	  2,m(m.m &_Read_Command_Name) Named_Point:_ u1'
     fq1:"g 0'			!* Abort on overrubout or null name!
     :i*Name_1u1'			!* Else prepend "Name "!

 @:fo21u3				!* 0: position of name in list!

 q0"e .u0 q2[..o			!* Saving - look at list of points!
     q3"l -q3*5j 10,0i -10c q1,.fs Word 5c' !* not already there - make new!
       "# q3*5+5j'			!* else go to old one!
     q0,.fs Word'			!* save point!

 "# q3"l :i* 1_holds_no_saved_point @fg'	!* Restore - make sure exists!
    "# .u0 q:2(q3+1):j"e :i* Out_of_range @fg'	!* Jump, err if bad!
       "# q0m(m.m &_Maybe_Push_Point)'''	!* Set Mark if long jump!

 0					!* Exit and say buf wasnt modified!

!^R Indent to Column:! !^R Insert whitespace at start of line.
Arg (default 8) is number of columns.  If already within indentation,
adds to it.  A zero arg always deletes all indentation.!

 z-.[0 fn z-q0j 0l .[2			!* 0: saved point; 2: start of line!
 ff&1"e 8'"# ' [1			!* 1: amount to indent!
 @f_	L fs S HPos[3 q2,.k	!* 3: previous indent; kill indent!
 z-.-q0"g q1'"# z-.u0 q1f"n+q3''mMM_&_Xindent	!* do the indentation!
					!* maybe change saved point, add hpos!
 q2+(q3/8)-. f"g w0'  		!* exit (old point will be restored)!

!^R Zap to Character:! !^R Kill to next occurrence of character!

 0[Auto_Push_Point_Option		!* dont let char search set mark!
 .[1 [9				!* 1: current point, 9: direction!
 @m(m.m ^R_Character_Search)		!* read a character and search for it!
 q1,. f  :m(m.m &_Kill_Text)		!* make the kill and return!

!^R Reverse Zap to Character:! !^R Kill to previous occurrence of character!

 -:m(m.m ^R_Zap_to_Character)

!^R Run Teco:! !^R Read a string and macro it.!

 1,m(m.m &_Read_Line) Teco:_ [0	!* 0: string to macro!
 fq0:"g 0'				!* Don't do anything if it's empty!

 f=(q:.n(0)f"e w:i*')0"n		!* Different from last minibuf?!
   q.n[..o zj -5d			!*   remove last entry in stack!
   j 5,0i ]..o				!*   make room at the front!
   q0u:.n(0)'				!*   add our string!

 @m(q0 (]0)) w			!* Unwind, macro it, and return!

!^R Whoedit:! !^R Update edit history.
A variable VEDIT in the first 500 lines is incremented.!

 0fo..q Comment_Beginf"e 0fo..q Comment Startf"ew :i*;''[B
 0fo..q Comment_Endf"ew :i*'[E		!* B: comment begin, E: end!
 f=B;_"e :iB;'				!* Make semi space go to semi!
 z-.[Z @fn|z-qzm(m.m &_Maybe_Push_Point)|	!* make sure we save point!

 0f[VB j gB qBuffer_Filenamesf"n f[DFile'	!* Set default filenames!
 f=(fsDDevice)PS"n g(fsDDevice) :i'	!* Add device maybe!
 <i g(fsDSName) >i				!* and directory!
 g(fsDFn1) .i g(fsDFn2) .i		!* and filenames!
 fsDVersionf"ew e?"n 1'"# e[ere] fsIFVers+1''\ !* and extension!
 i,_ 0,-1fsFDConv i,_Edit_by_ g(fsXUName)	!* and time and author!
 gE i 
 gB _i .[0 fnq0j gE i 
 0,.@v	!* Start next comment line!
 
 1< 500:fbVEDIT;			!* Look for VEDIT!
    .uE -5c -@f_	L		!* Skip back over spaces!
    0f  "n qEj !<!@>'			!* If not line start, try again!
    qEj @f_	L		!* Skip over spaces!
    1,1a-="n !<!@>'			!* Make sure we have an equals!
    @:f0123456789f(-z@;)L		!* Go to start of number!
    .uB @f01234567L			!* Skip over octal digits!
    0,1a:"d 8[..E 8f[IBase'		!* If only have octal, stay that way!
    qBj .(\[0)f(,.k %0\),. >		!* Update the VEDIT!
 0

!^R Auto Save:! !^R Run an auto save to protect buffer from munging.!

 Q:.B(qBuffer_Index+4!*bufbuf!)[..O	!* in original buffer!
 f[DFile				!* save default file!
 1:<1,1m(m.m ^R_Save_File)>"l		!* run auto save carefully!
    :i* Auto_save_failed @fg'		!* if failed, say so!
 0

!^R Find Long Line:! !^R Find a line longer than the terminal width.
Starts at point.  An argument if given is used instead of tty width.!

 .[0 fnq0j				!* Save point against unfound or c-G!
 ff"n '"# fsWidth'[1		!* 1: Width to check against!
 <.-z; 2@:L fs S H Pos-q1"g .u0 0'>	!* Go to next line, check width!
 :i* No_long_lines_found @fg 0	!* Nothing found, complain!

!^R Find Unmatched Paren:! !^R Find open paren without matching close.!

 zj -ful				!* from end of buf, back up level!

!^R Super Parenthesis:! !^R Insert enough )s to finish top level DEFUN!

!* This macro was originally from ECC, but has been modified
   so much as to be barely recognizable by now!

!* For the purposes of this macro, a DEFUN is anything with a letter-like
   or parenthesis-like character in the first column.!

 .-z[0 .[1				!* 0,1: point from end,start of buf!
 -:s 
( 
A 		!* go to beginning of defun!
 fdl .-1[2				!* 2: place to match paren to!
 q0+zj					!* start back where we were!
 < -fll .-q2-1:;			!* exit loop if finished, else!
   q0+zj -ful 1a*5+2 (q0+zj) :g..D i >	!* insert matching paren and continue!
 q0+zj q1,.				!* return!

!& HAKLIB LEDIT Setup Hook:! !S Set keys for LISP editor!

 :iDefault_Major_ModeLISP		!* Assume we only want to edit LISP  !

 m.m ^R_LEDIT_Find_Functionu....	!* c-m-.: search for DEFUN    (undef)!
 m.m ^R_LEDIT_Save_DEFUNu...Y	!* c-m-Y: save DEFUN for zap  (undef)!
 m.m ^R_LEDIT_Zap_to_LISPu:.X(Z)	!* c-X Z: return to LISP   (Last CCL)!
 m.m ^R_LEDIT_Zap_DEFUN_to_LISPu..Z	!* m-Z:   zap form back     (Compile)!

!& HAKLIB WORDAB Setup Hook:! !S Set keys for word abbreviation!

 m.m ^R_Add_Global_Word_Abbrevu:.X(+)	 !* c-X +:   make new abbrev !
 m.m ^R_Inverse_Add_Global_Word_Abbrevu:.X(-) !* c-X -:   same backwards  !
 m.m ^R_Add_Mode_Word_Abbrevu:.U(+)		 !* c-\ +:   local  (c-X c-A)!
 m.m ^R_Inverse_Add_Mode_Word_Abbrevu:.U(-)	 !* c-\ -:   local  (c-X c-H)!
 m.m ^R_Word_Abbrev_Prefix_Marku:.X( )	 !* c-X c-@: region     (m-')!
 m.m ^R_Abbrev_Expand_Onlyu..._		 !* c-m-sp:  expand abbrev   !
 m.m ^R_Unexpand_Last_Wordu:.X(_)		 !* c-X sp:  unexpand (c-X U)!

!& HAKLIB Assembly Mode Hook:! !C Set up for editing PDP-10 assembly language.!

 9fs^R Initm.q I			!* tab self-inserts!
 (:i*+1)m.l Comment_Rounding		!* comments rounded to nearest column!
 :i* 
 m.l Label_Search_Prefix	!* labels start with CRLF!
 :i*:= m.l Label_Search_Suffix	!* and end with this!
 :i*A m.l Label_Content_Syntax	!* only contain alphabetics!
 :i* 
m.l Paragraph_Delimiter	!* blank lines delimit paragraphs!
 m.m ^R_Kill_SExpu...D		!* fix c-m-D (c-\ D kills label)!
 

!& HAKLIB TECO Mode Hook:! !S Set label variables for editing TECO code!

 :i* ! m.l Label_Search_Prefix		!* labels begin with excl!
 :i* :! m.l Label_Search_Suffix		!* end with colon-excl!
 :i* _A m.l Label_Content_Syntax	!* can have space or letter!
 

!& HAKLIB Scribe Mode Hook:! !S Set variables for editing Scribe files!

 1m.l Auto_Fill_Mode			!* Auto fill (to column 70)!
 0m.l Space_Indent_Flag		!* Never indent on auto-fill!

 1,m(m.m &_Get_Library_Pointer) TeX"e	!* If dont already have TeX!
    1:< m(m.m Load_Library) TeX	!* then load it in now!
	m.m ^R_TeX_"m.q " !''! >'	!* to use TeX doublequote hack!

 @:i*|m(m.m &_Exit_EMACS)		!* Compile does the right thing!
       Scribe_1			!* i.e says permanently leaving!
| m.l Compile_Command			!* and then runs Scribe on file!
 

!& HAKLIB Pascal Mode Hook:! !S Set variables and keys for Pascal!

 :i* ProcedureFunction m.l Label_Search_Prefix
 :i* ;:( m.l Label_Search_Suffix
 :i* A' m.l Label_Content_Syntax	!* Types of labels for pascal!
 :m(m.m &_Default_Init_Pascal_Mode)		!* Set keys normally!

!& Label CRLF Hack:! !S Convert ^M to a CRLF, make null string into ^X!

 f[BBind g() j		    !* set up the string!
 <:s^M"e z"e :i*"# hfx*'' -2d i 
>

!& Hack Syntax:! !S Put ^S before and ^O after each char in a string!

 f[BBind g() j
 z<i c i>			!* insert ^S and ^Os!
 hfx*

!^R Label Search:! ! Like TAGS, but works only on buffer.
Look for label starting at beginning of buffer.
If given an argument, continue search.

Needs:
    Label Search Prefix - string defining prefix
    Label Search Suffix - string defining suffix
    Label Content Syntax - string of chars (Lisp syntax) within labels!

 [L[O[P[S[C[H[0[2[7[8[9

 m.m &_PAGE_Widen_Boundsf"nu0 m0'	!* Make bounds wide for page library!

!NewLabel!				!* check for delimiters & save!
 0fo..q Label_Search_Prefix f(uP) "e o NoLabel'
 0fo..q Label_Search_Suffix f(uS) "e o NoLabel'
 0fo..q Label_Content_Syntax f(uC) "e

!NoLabel!				!* here if no such variables!
     :i*_No_Label_Definition_for_this_buffer.__Create_it @fg
     1 m(m.m &_Yes_or_No) "e 0'	!* possibly create them if not there!
     m.m &_Label_CRLF_HackuH
     1,m(m.m &_Read_Line) Label_Prefix:_ mH m.l Label_Search_Prefix
     1,m(m.m &_Read_Line) Label_Suffix:_ mH m.l Label_Search_Suffix
     1,m(m.m &_Read_Line) Label_Syntax:_ m(
	m.m &_Hack_Syntax) m.l Label_Content_Syntax
     o NewLabel'			!* go back and try again!

 .u0 fn q0j				!* current location, in case of ^G!
 m(m.m ^R_Widen_Bounds)		!* carefully widen bounds!
 ff&1u2				!* whether we have an argument!
 q2"e j 1,f Label:_ m.l Label_Search_Last' "# @l'
					!* if no args, get new search string!
					!* else start from next line!
 qLabel_Search_Last uL		!* save label to look for!

 .uO					!* save original search location!
 < :sL; .u8 fkc .u7		!* find the string!
   -:sP"e q8j !<!>'			!* search back for prefix!
   fkc @f_	l		!* find prefix before label!
   .-q7 (q8j)"n !<!>'			!* make sure it is immediately before!
   @f_	l			!* check for whitespace!
   .u7 :sS"e !<!>'			!* find suffix or stay put if none!
   fkc .-q7(q7j)"e oFound'>

 qOj < :sL; .u8 fkc .u7		!* find the string!
   -:sP"e q8j !<!>'			!* search back for prefix!
   fkc @f_	l		!* skip over whitespace!
   <.-q7@; sC fk+1@:;>		!* skip over label-like chars!
   .-q7 (q8j)"n !<!>'			!* make sure it is immediately before!
   .( :sS; fkc .u8)j			!* find next occurrence of suffix!
   <.-q8@; sC fk+1@:;>		!* skip over label-like chars!
   @f_	l			!* skip over whitespace!
   .-q8"e oFound'>
   
 q2"e :i* No_such_label:_L'"# :i* No_more_L'@fg 0

!Found!
 0@l q0 m(m.m &_Maybe_Push_Point)	!* remember old point as mark!
 .u0					!* new location to return to!
 qComment_Startu7			!* our comment delimiter!
 q7"n qComment_Endu8			!* get end delimiter!
      f=8_-1"g 1,fq8:g8u8'		!* stripping a leading space!
      < 0@:l b-.; 0@f  @:; > .u9	!* go to end of prev non-blank line!
      < fq8"g -fq8 f=8@:; -fq8c -:s7;' !* Search back for comment delim!
	"# 0@l fq7 f=7@:;'		!* Or line-at-a-time comment!
	0@f  @:; 0@:l >		!* Backing up a line at a time!
      @l .-q9"g q0j''			!* Go back to last winning line!

 -1 f[^R Inhibitw 0@v			!* Tell window mgr about moved point!
 0@:f 0				!* Reposition comment to window top!

!& HAKLIB Babyl Setup Hook:! !S Initialize hooks and variables for Babyl!

 -1m.vBabyl_N_After_D			!* Go back if nothing ahead	     !

 m.m &_HAKLIB_Babyl_G_Done_Hook m.v Babyl_G_Done_Hook	!* Do file daemons   !
 m.m &_HAKLIB_Babyl_M_Hook m.v Babyl_M_Hook	!* M prompts for To, Re,     !
 m.m &_HAKLIB_Babyl_R_Hook m.v Babyl_R_Hook'	!* sets Bcc (like R)	     !

 m.m &_HAKLIB_Babyl_Survey_FROM/TO_Control m.v Babyl_Survey_FROM/TO_Control
					!* More compact from/to, add date    !

 1,m(m.m &_Get_Library_Pointer) ZBabyl"n	!* If using ZBabyl...!
   1m.vZBabyl_Init_Loaded		!* Tell it we are loading the init   !
   [0 f[DFile				!* Bind default filename	     !
   fsHSNamefsDSName			!* Default dir is home dir	     !
   et ZBABYL_LISP			!* Default is ZBABYL.LISP	     !
   1:<erec>"e fsdfileu0		!* If that file exists...	     !
     m(m.m Read_Filter_Library)0''	!* Read it			     !

 0fo..q HAKLIB_Babyl_Label_Answered"e	!* unless want answered,	     !
 @:i*| 1,-1m(m.m &_Label_Babyl_Message) to_answer |m.v Babyl_R_Done_Hook'
					!* Dont label answered, flush to ans !

 0m.v Babyl_Strip_Local_Host		!* Don't remove the " at SITE"       !
 1m.v Babyl_Day_of_Week_Flag		!* Include day of week in dates	     !

!* Header fields to flush, in alphabetical order.  Note that what I really
   want is to keep only From:, To:, Date:, Cc:, Re:, Sender:, and Reply-to:.
   But Babyl makes you say what you don't want to see, so here I list all
   the obnoxious headers I run across.  There is no information loss, because
   if I really care I can always type 1H ... !

 :i* [Address] [Also-Known-As] [Article-I.D.] [Delivery-Notice] [DTN]
     [Full-Name] [Keywords] [In-Real-Life] [In-Reply-To] [Loc] [Location]
     [Mail_Stop] [Mail-From] [Mail-Stop] [Message-id] [Note] [Office]
     [Organization] [Phone] [Phones] [Postal] [Postal-Address]
     [Posting-Version] [Rcvd-Date] [Received] [Redistributed-To]
     [Redistributed-By] [Redistributed-Date] [References] [Regarding]
     [Remailed-Date] [Remailed-From] [Remailed-Sender] [Remailed-To] [Reply]
     [ReSent-Cc] [ReSent-Date] [ReSent-From] [ReSent-Sender] [ReSent-To]
     [Return-Path] [Snail-Mail] [Stanford-Phone] [Telephone] [USmail] [USnail]
     [Via]  m.v Babyl_Reformation_Flushes_These_Fields
 

!& HAKLIB Babyl Edit Mail Hook:! !S Set keys for editing mail!

 0,(fsZ)fsBound			!* Set bounds wide just in case!

 qParagraph_Delimiter[0		!* Get para delimiter in 0!
 fq0"g :i0 0 -' "# :i0-'	!* Add dash so header wont get filled!
 q0 (]0) [Paragraph_Delimiter		!* Save as new para delimiter!

 !* Fall off without popping, so keys stay set!

!& Cc Self:! !& HAKLIB Babyl R Hook:! !S Add self as BCC to outgoing messages!
!* I want to get a copy of most outgoing mail, so add me as a recipient!


 1fo..q HAKLIB_Babyl_CC_Self"e 	!* default to cc self!
   :m(m.m&_Cc_File)'			!* but also try file!
 .-z[P fn qP+zj j			!* go to beginning of buffer!
 fs OS Teco"e i Cc:_'"# i Bcc:_'	!* add Bcc or Cc header field!
 g(0fo..qBabyl_User_Namef"ew fs XUName:f6')	!* and username!
 i 
				!* finish with a crlf!
 fs Windowf"l w0'+.fs Window		!* hide it above the screen!
 :m(m.m &_Cc_File)			!* go try for FCC !


!& CC File:! !S Add a file as FCC to outgoing messages !
!* this code stolen from & CC Self!
!* if variable HAKLIB Babyl CC File exists, use its contents as addr for FCC !

 0fo..q HAKLIB_Babyl_CC_File"e '	!* don't do it unless they set it!
 .-z[P fn qP+zj j			!* go to beginning of buffer!
 fs OS Teco"e '"# i Fcc:_'		!* add Fcc field, but not on ITS !
					!* cuz I don't know if it works there!
 g(qHAKLIB_Babyl_CC_File)		!* and filename to FCC!
 i 
				!* finish with a crlf!
 fs Windowf"l w0'+.fs Window		!* hide it above the screen!
 

!& HAKLIB Babyl G Done Hook:! !S Process incoming messages!

 "n qBuffer_Filenames[0 0fo..QBabyl_Filter-Daemons_0f"nu0 m0w' ]0'
 					!* Run filter daemons and return!

!& HAKLIB Babyl M Hook:! !S Set up outgoing msgs!
!* Prompt for To: and Subject: headers, then add self as Cc!

 jk @m(m.m ^R_Babyl_Add_To-Recipient)	!* Add to: field!
 @m(m.m ^R_Babyl_Add_Subject:_Field)	!* Add subject: field!
 zj 0fs Window				!* Go to end of buffer!
 :m(m.m &_Cc_Self)			!* Add self as Cc!

!& HAKLIB Babyl Survey FROM/TO Control:! !S Clean up survey menus!
!* ^X is mail buffer with nice bounds,
   ^Y is survey buffer with from/to already in,
   q1 is start of from/to area in survey buffer.!

 [0[2 [..o q1-1j			!* Save q-regs, make sure in right buf!

 !* First we fix up addresses!
 !*   - UUCP bang style host names are flushed!
 !*   - RFC733/822 style  Real Name <...>  comments are flushed!
 !*   - Host names with percent or atsign are flushed!
 !*   - Usernames with dotted components are flushed on the smaller side!
 !*   - User names from the list in Flush From Survey are flushed!
 !*   - Silly arrow replaced by spaced out colon!

 @:i*| !<! :s ->  ,  fkc q1-."g q1j' |[E	!* Make address border macro!
 q1j <:s!<(!>!); .(-mE),.f k>	!* Flush uucp path, RFC-style comment!
 q1j < :s%@_at_; fkc .(1mE),.k>	!* Flush host names!
 q1j <:s.; .u0 -mE q0-.-(1mE .-q0)-1"g q0-1,.k'"# -mE .,q0k'> !* Flush at dot!
 0fo..q Flush_From_Surveyu0 q0"n q1j	!* If list of names to flush!
   < :s0; fkc 0,0a(-fkc)"a !<!>'	!* Find target string after non-alpha!
     -mE .(1mE),.k >'			!* And flush that recipient!
 q1j <:s->; fkd i_:_> q1j 0,1a-_"e d'	!* Replace arrow by colon!

 !* The other thing we do is insert a date field!
 !* This is a 7-char field, DDmonYY or Unknown, followed by two spaces!
 !* It is inserted at the start of the usual SvM address area!

 j 0,6a-S"n z-q1u1			!* Need to fix headline, hack q1!
  :k i_No._Size__Date_____From_:_To_____{Labels}_Subject_or_Text !* ...!
  z-q1u1'				!* Put address marker back in place!

 fs OS Teco"e :i0_______'"#		!* ITS doesn't know about dates!
 u..o j				!* Switch to message buffer!
 :s
Date:_"e :i0 Unknown'			!* No date, leave unknown!
 "# :x0 f[BBind g0			!* Else put in temp buffer!
    0a-)"e -flk -@f_	k'	!* Flush comment at end of line!
    -4c 1a-_"e di-'			!* Turn time zone space into dash!
    j 1a"a @:f,_l @f,_l'		!* Back to start, maybe skip weekday!
    fsFDConvertu0 q0+1"e r'		!* Try to convert into internal form!
    .+1-z"n :i0 Unknown'		!* Give 7-char string if conv failed!
    "# hk 400000000.,q0fs FD Convert	!* Else produce date in easy format!
       j 1a-_"e f0'		!* Turn leading space into zero!
       2jd 3 fc 5jd hx0'		!* Lowercase month, flush dashes!
    f]BBind''				!* Flush temporary buffer!
 u..o q1j g0 i__ .u1			!* Back to survey, insert!
 zj 1					!* Pretty, hosts already munged!

!# Babyl `:! !# Babyl ":! !C# Enter SvM on all messages!

 fs QP Ptr[P				!* Save stack pointer!
 m(m.m &_Push_Message)			!* Return later to current message!
 1m(m.m #_Babyl_J)			!* Jump to first message in file!
 2,9999m(m.m &_Babyl_Survey_Several_Messages)	!* compute survey!
 qP fs QP Unwind			!* Return to original place now!
 :m(m.m Survey_Menu)			!* Enter survey menu!

!& HAKLIB Buffer Creation Hook:! !S Set up permanent local vars!

 qHAKLIB_Old_Buffer_Creation_Hook[1	!* Get old buffer creation hook!
 fq1"g m1'				!* Macro it if a string!

 5fs Q Vecu1				!* Cons up a one-element q-vector!
 2u:1(0)				!* (will be symtab with 2 cells/sym)!
 q1uSaved_Point_Vector		!* put it in Saved Point Vector!

 m.l Overwrite_Mode			!* make overwrite mode local!
 

!& HAKLIB TeX Mode Hook:! !S Set vars for TeX mode!

 1m.l Auto_Fill_Mode			!* Auto fill (to column 70)!
 m.m ^R_TeX_"m.q " !''!		!* " inserts `` or '' as appropriate!

 @:i*|m(m.m &_Exit_EMACS)		!* Compile does the right thing!
       TeX_1			!*   i.e says permanently leaving!
| m.l Compile_Command			!*   and then runs TEX on file!

 qParagraph_Delimiter[1 1,(:i* 1\$$%)m.l Paragraph_Delimiter
		!* paragraphs delimited by macro begin, disp math, comment!


!& HAKLIB TTY Macro:! !S Set tty-dependent vars!

  fs QP Ptr[P					!* Save stack frame for later!

  m(m.a TRMTYP #_TRMTYP_Heath) - fs RGetTy"e	!* Are we on a H-19 or H-29? !
    1 fs TtyFci'				!* Yes, able to meta-ize     !

  m(m.a TRMTYP #_TRMTYP_Ambassador) - fs RGetTy"e	!* Ambassador?       !
    0'"# 1'uDisplay_Mode_Line_Inverse		!* If so, no mode inversion  !

  m(m.a TRMTYP #_TRMTYP_VT100) - fs RGetTy"e	!* VT100?  Maybe a SUN?      !
    fsHeight - 28"e 1fs O Speed''		!* If so it needs no padding !

!* We used to set fs O Speed to 2400 if it was zero here, but this caused    !
!* problems with H-19s on EtherTips running at 9600 baud.  Now we leave the  !
!* output speed alone except for SUN terminals which run at essentially      !
!* infinite baud and require no padding.				     !

!* Adjust echo area height depending on the total height of screen.	     !
!* Minimum echo area height is 2, but try to use total height divided by 12. !
!* So, 24 and 28 lines gives 2 echo lines, 60 gives 5 echo lines.	     !

  2,(fs Height/12) f  uEcho_Area_Height

!* Set SLOWLY I-Search window size depending on the terminal output speed.   !
!* Fast terminals get full screen (0 search window).			     !
!* Slow terminals get speed - 100 / 500 + 1 (300 => 1, 1200 => 3, 2400 => 5) !
!* Network terminals  are treated as if 2400 baud.			     !
!* Unpadded terminals get speed - 1 (so SUNs with ospeed=1 use full screen)  !

  fs O Speed-qSlowly_Maximum_Speed"g
    0'"# fs O Speedf"e 5'"#-100f"l+99'"#/500+1''' m.v Slow_Search_Lines_Used

!* Now unwind so TRMTYP gets unloaded.  We drop off the end with the stack   !
!* fixed up rather than exiting with ^\ so that more hooks can be consed     !
!* onto the end of this one.						     !

    qP fs QP Unwind

!& HAKLIB Set Mode Line Hook:! !S Clean up mode line!
!* When this is set no Set Mode Line Hook should already exist!

 fqEditor_Type"g :iEditor_Type'	!* Flush editor type if any!
 .-z(-:s Save(off)"n  NoSave'	!* mung NoSave!
     "# -:s_Save"n fkd'')+zj		!* mung Save!

!*
** Local Modes:
** Comment Column: 40
** PURIFY Library HAKLIB: 1
** End:
*!
