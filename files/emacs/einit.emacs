!* -*-TECO-*-!

!~Filename~:! !Macros for installing a new EMACS.!
EINIT

!? Generate EMACS:! !? Create EMACS :EJ file from sources.
Compresses the source files that need compression,
then concatenates the COMPRS files and purifies, writing
the result out as EMACS;[PURE] >.!

    1,m.m &_File_PURIFY_Loaded+1"G !* Load PURIFY if not loaded already.!
      m(m.m Load_Library)EMACS;PURIFY'
    fs osteco"e
      m(m.mGenerate_Library) EMACS;DSK:[PURE]_> EMACS1;DOC  USRCOM  !*
! 		 ^R BASE  WRDLST  INDENT  SEARCH  FILES  !*
!		 SUPPRT  ISEARC  WINDOW  BUFFER  CRL  VARS 
      m(m.mGenerate_Library) EMACS;DSK:[PRFY]_> EMACS1;PURIFY  CCL
      m(m.m Generate_Library) EMACS;DSK:EINIT EMACS1;EINIT '
    "#
      m(m.mGenerate_Library) EMACS;DSK:EMACS DOC  USRCOM  !*
! 		 ^R BASE  WRDLST  INDENT  SEARCH  FILES  !*
!		 SUPPRT  ISEARC  WINDOW  BUFFER  CRL  VARS 
      m(m.mGenerate_Library) EMACS;PURIFY PURIFY  CCL
      m(m.m Generate_Library) EMACS;DSK:EINIT EINIT '
    

!? Document EMACS:! !? Create EMACS DOC and EMACS CHART.!
    m(m.m Load_Lib)EMACS;ABSTR
    f[b bind f[d file
    m(m.mWall_Chart).X
    fs osteco"e
       ji;NOXGP
	 ;SKIP_1
	 '
    et EMACS;EMACS_CHART eihpef
    m(m.m Wide_Wall_Chart)
    et EMACS;EMACS_WIDE
    fs osteco"n et EMACS.WIDE-CHART'
    eihpef
    hk
    fs osteco"e
       ji;NOXGP
	 ;SKIP_1
	 '
    m(m.mAbstract_Redefinitions)
    m(m.mAbstract_Library)_CEMACS
    m(m.mAbstract_Library)_CTAGS
    m(m.mAbstract_Library)_CTMACS
    m(m.mAbstract_Library)__SLOWLY
    m(m.mAbstract_Library)_CWORDAB
    m(m.mAbstract_Library)_CPICTURE
    m(m.mAbstract_Library)_CSORT
    m(m.mAbstract_Library)__PAGE
    m(m.mAbstract_Library)__SCRLIN
    m(m.mAbstract_Library)__DELIM
    m(m.mAbstract_Library)_CMODLIN
    m(m.mAbstract_Library)_CABSTR
    m(m.mAbstract_Library)_CPURIFY
    i


    .f[vb
    m(m.m Abstract_Variables)
    f]vb

    et EMACS;EMACS_NDOC eihpef
    1:< ed EMACS_ODOC>
    1:< en EMACS_DOC EMACS_ODOC>
    en EMACS_NDOC EMACS_DOC
    

!& Load Default Environment:! !S Create the default environment.
Assuming that the pure files are already loaded
and the "essential" environment is set up, set up the standard
EMACS ^R command definitions, etc.!

    [0 [1 [2

    @:I*| FS:EJPAG-256"E '
	  QEcho_Area_HeightFS ECHO LINES
	  0F[VAR MAC
	  FS SAIL USAIL_Character_Mode
	  FS ^M PRINT UDisplay_Overprinting
	  
	| FS TTY MACRO		    !* Must not be a pure string or use M.M.!

    M.M &_Toplevel_^R U..L	    !* Put a macro to handle G in ..L!
    M.M &_Secretary_Macro U..F	    !* ..F is nonzero when we aren't in an "inner ^R mode",!
				    !* but it isn't used unless FS ^R MDLY$ is positive.!
    Q..FU.F			    !* Switching buffers, files or windows OK iff Q.F = Q..F.!
    M.M &_Real-time_Interrupt FS CLK MACRO

    M.M &_Recursive_^R_Set_Mode FS ^R ENTER

    M.M ^R_Backwards_Kill_Characters FS RUB MACRO
    -1UDisplay_Matching_Paren

    :IR :,.F 		    !* MR returns the region as two numbers.!

    201.@FS ^R InitU1  255U0
    400.+A @FS ^R InitU2
    256< %0W			    !* Make all unassigned Meta characters into errors.!
         Q0#Q2"E Q1U0'
	 >
    Q1U.T
    Q2U..I Q2U...L		    !* A few meta chars should self-insert.!
    Q2U..._

    M.M SAIL_Character_Mode U.B	    !* Control-Alpha !

    FS ^R INIT UH
    M.M ^R_Indent_According_to_Mode UI
    M.M ^R_Indent_New_Line UJ
    M.M ^R_Indent_New_Comment_Line U..J Q..J U..J    
    M.M ^R_CRLF UM

    M.M ^R_Set/Pop_Mark U.@
    341.@FS^R INIT&777777.-40000000. U._ !* C-Space indirects to C-@.!
    M.M ^R_Replace_String U.%
    M.M ^R_Query_Replace U..%
    M.M ^R_Find_Tag U...
    M.M ^R_Indent_For_Comment U.; Q.; U..;
    M.M ^R_Kill_Comment U...;
    M.M ^R_Mark_Beginning U.<
    M.M ^R_Goto_Beginning U..<
    M.M What_Cursor_Position U.=
    M.M ^R_Count_Lines_Region U..=
    M.M ^R_Mark_End U.>
    M.M ^R_Goto_End U..>

    M.M ^R_Describe U..? Q..?U../
    M.M ^R_Documentation F(U...? )FS HELPMAC
    M.M ^R_Kill_Line U.K
    M.M ^R_New_Window U.L
    M.M ^R_Down_Real_Line U.N
    M.M ^R_Down_Comment_Line U..N
    M.M ^R_Up_Real_Line U.P
    M.M ^R_Up_Comment_Line U..P
    M.M ^R_Quoted_Insert U.Q
    M.M ^R_Reverse_Search  U.R
    M.M ^R_Move_To_Screen_Edge U..R
    M.M ^R_Reposition_Window U...R
    M.M ^R_Incremental_Search U.S
    M.M ^R_Transpose_Characters U.T
    M.M ^R_Universal_Argument U.U
    M.M ^R_Next_Screen U.V
    M.M ^R_Previous_Screen U..V
    M.M ^R_Scroll_Other_Window U...V
    M.M ^R_Kill_Region U.W
    M.M ^R_Copy_Region U..W
    M.M ^R_Append_Next_Kill U...W
    M.M ^R_Extended_Command U..X
    M.M ^R_Instant_Extended_Command U...X
    M.M ^R_Un-Kill U.Y
    M.M ^R_Un-Kill_Pop U..Y
    M.M ^R_Return_To_Superior U.Z
    M.M ^R_Prefix_Meta U
    33. FS ^R INIT U. Q. U...C
    M.M ^R_Execute_Mini U..
    433.^ FS ^R INIT U...
    M.M ^R_Prefix_Meta U.\
    M.M ^R_Prefix_Control U.^
    M.M ^R_Prefix_Control-Meta U.C
    M.M Abort_Recursive_Edit U.]
    M.M ^R_Buffer_Not_Modified U..~

!* NOT EXACTLY WORD, NOT EXACTLY LIST COMMANDS!

    M.M ^R_Back_to_Indentation U..M Q..M U...M
    Q..M F( U..M ) U...M
    M.M ^R_Delete_Horizontal_Space U..\
    M.M ^R_Indent_Region U...\
    M.M ^R_Split_Line U...O

!* LOAD THE WORD COMMANDS!

    M.M ^R_Change_Font_Word U..#
    M.M ^R_Correct_Word_Spelling U..$
    M.M ^R_Upcase_Digit U..'
    M.M ^R_Mark_Word U..@
    M.M ^R_Backward_Sentence U..A
    M.M ^R_Backward_Word U..B
    M.M ^R_Uppercase_Initial U..C
    M.M ^R_Kill_Word U..D
    M.M ^R_Forward_Sentence U..E
    M.M ^R_Forward_Word U..F
    M.M ^R_Fill_Region U..G
    M.M ^R_Mark_Paragraph U..H
    M.M ^R_Tab_to_Tab_Stop U..I
    M.M ^R_Kill_Sentence U..K
    M.M ^R_Lowercase_Word U..L
    M.M ^R_Fill_Paragraph U..Q
    M.M ^R_Center_Line U..S
    M.M ^R_Transpose_Words U..T
    M.M ^R_Uppercase_Word U..U
    M.M ^R_Backward_Paragraph U..[
    M.M ^R_Forward_Paragraph U..]
    M.M ^R_Delete_Indentation U..^
    M.M ^R_Underline_Word U.._
    M.M ^R_Backward_Kill_Word U..

!* LOAD THE LIST COMMANDS!

    M.M ^R_Make_() U..(
    M.M ^R_Move_Over_) U..)
    M.M ^R_Backward_Up_List U...( Q...( U...U
    M.M ^R_Forward_Up_List U...)
    M.M ^R_Mark_Sexp U...@
    M.M ^R_Backward_Sexp U...B
    M.M ^R_Down_List U...D
    M.M ^R_Forward_Sexp U...F
    M.M ^R_Format_Code U...G
    M.M ^R_Mark_Defun U...H Q...H U...H
    M.M ^R_Indent_for_Lisp U...I Q...I U...I
    M.M ^R_Kill_Sexp U...K
    M.M ^R_Forward_List U...N
    M.M ^R_Backward_List U...P
    M.M ^R_Indent_Sexp U...Q
    M.M ^R_Transpose_Sexps U...T
    M.M ^R_Beginning_of_Defun U...[ Q...[ U...A
    M.M ^R_End_of_Defun U...] Q...] U...E
    M.M ^R_Delete_Indentation U...^
    M.M ^R_Backward_Kill_Sexp U...

    128M(M.M MAKE_PREFIX).X U.X
    :IPrefix_Char_List Control-X__Q.X


    M.M List_Buffers U:.X()
    M.M ^R_Return_to_Superior U:.X()
    M.M ^R_Directory_Display U:.X()
    M.M Find_File U:.X()
    M.M ^R_Indent_Rigidly U:.X(9)  !* ^X Tab.!
    M.M ^R_Lowercase_Region U:.X()
    M.M ^R_Set_Goal_Column U:.X()
    M.M ^R_Delete_Blank_Lines U:.X()
    M.M ^R_Mark_Page U:.X()
    M.M ^R_Set_File_Read-Only U:.X()
    M.M ^R_Visit_File U:.X()
    M.M ^R_Save_File U:.X()
    M.M ^R_Transpose_Lines U:.X()
    M.M ^R_Uppercase_Region U:.X()
    M.M ^R_Visit_File U:.X()
    M.M Write_File U:.X()
    M.M ^R_Exchange_Point_And_Mark U:.X()
    M.M ^R_Re-execute_Mini U:.X()
    M.M ^R_Change_Font_Region U:.X(#)
    M.M ^R_Start_Kbd_Macro U:.X(()
    M.M ^R_Set_Fill_Prefix U:.X(.)
    M.M ^R_One_Window U:.X(1)
    M.M ^R_Two_Windows U:.X(2)
    M.M ^R_View_Two_Windows U:.X(3)
    M.M ^R_Visit_in_Other_Window U:.X(4)
    M.M ^R_Set_Comment_Column U:.X(;)
    M.M What_Cursor_Position U:.X(=)
    M.M ^R_Append_to_Buffer U:.X(A)
    M.M Select_Buffer U:.X(B)
    M.M ^R_DIRED U:.X(D)
    M.M ^R_Set_Fill_Column U:.X(F)
    M.M ^R_Get_Q-reg U:.X(G)
    M.M ^R_Mark_Whole_Buffer U:.X(H)
    M.M ^R_Info U:.X(I)
    M.M Kill_Buffer U:.X(K)
    M.M ^R_Count_Lines_Page U:.X(L)
    M.M Send_Mail U:.X(M)
    M.M ^R_Narrow_Bounds_to_Region U:.X(N)
    M.M ^R_Other_Window U:.X(O)
    M.M ^R_Narrow_Bounds_to_Page U:.X(P)
    M.M Read_Mail U:.X(R)
    M.M ^R_Transpose_Regions U:.X(T)
    M.M ^R_Widen_Bounds U:.X(W)
    M.M ^R_Put_Q-reg U:.X(X)
    M.M ^R_Previous_Page U:.X([)
    M.M ^R_Next_Page U:.X(])
    M.M ^R_Grow_Window U:.X(^)
    M.M ^R_Underline_Region U:.X(_)
    M.M ^R_Backward_Kill_Sentence U:.X(127)

!* Make TWENEX changes!
fs osteco"n
    M.M ^R_Prefix_Control-Meta U.Z
    33. FS ^R INIT U...Z
    M.M ^R_Return_To_Superior U:.X()
    37. FS HELP CHARW
    M.M ^R_Exit_to_Exec U.C	    !* Make self-documentation!
    632. @FS ^R INIT U...C
    0U:.X()			    !* not confuse users!
    '

    1FS TTMODEW
    1FS ^R SCANW
    1FS ^R ECHOW
    1FS RUB CRLFW		    !* ^D AND RUBOUT TREAT CRLF AS ONE CHARACTER.!
    M.M ^R_Auto-fill_Space FS ^R ECSD

    :I..J EMACS_		    !* Set up ..J so that & Set Mode Line will correct it.!
    :I*EMACS M.V Editor_Name	    !* Name of this editor.  For ..J hackery!

!*** Speed up calls to certain subroutines by putting them in ..Q!
    M.M &_Find_Buffer M.V MM_&_Find_Buffer
    M.M &_Find_File M.V MM_&_Find_File
    M.M &_Get_Library_Pointer M.V MM_&_Get_Library_Pointer
    M.M &_Kill_Text M.V MM_&_Kill_Text
    M.M &_Matching_Paren M.V MM_&_Matching_Paren
    M.M &_Process_File_Options M.V MM_&_Process_File_Options
    M.M &_Read_Line M.V MM_&_Read_Line
    M.M &_Set_Mode_Line M.V MM_&_Set_Mode_Line
    M.M Load_Library M.V MM_Load_Library

!*** Now redo putting various functions in obscure places.!
!*** This duplicates what & Load Essential Environment does.!
!*** The reason is that these functions may be in the patch file,!
!*** in which case the patched versions must be installed.!

    M.M &_Autoload U.A
    M.M &_Set_Variable_Comment U.C
    M.M &_Prepare_For_Input U.I
    M.M Make_Local_Variable U.L
    M.M &_Macro_Execute UM
    M.M &_Macro_GetU.M
    M.M &_Prefix_Character_DriverU.P
    M.M &_Make_Variable U.V

    M.M &_Set_Mode_Line FS MODE MAC
    M.M &_Default_FS_Superior FS SUPERIOR

    M.M &_F^K_Hook U*F_Hook*
    M.M &_Subset_Directory_Listing UDirectory_Lister
    m.m &_Standard_Lisp_Indentation_Hook m.v Lisp_Indentation_Hook
    m.m &_Standard_Lisp_PROG_Hook m.v Lisp_PROG_Indent

!*** NOW SET UP EMACS'S ERROR HANDLER.  SAVE IT FOR LAST, SINCE IF THERE IS AN ERROR!
!*** AFTER SETTING IT UP, AND NOT ALL THE REST OF EMACS IS THERE, IT IS A SCREW.!
    M.M &_Error_Handler U..P
    

!& Load Essential Environment:! !S Does what's needed for EMACS macros to work at all.
A given environment (such as EMACS, TME, etc.) may set up
other variables, and redefine ^R characters.  That is all optional.
But code may fail to work if these variables are missing.!

    5FS Q VECTOR U..Q
    3U:..Q(0)			    !* We use 3 words per variable.!

    1FS S ERROR		    !* Searches inside iterations can still fail.!
    -1FS^I DISABLE		    !* Tab is a no-op.!
    1FS _ DISABLE		    !* Don't allow backarrow.!
    -1FSFNAM SYNTAX		    !* FN2s default to ">'!
    -1FS ECHO FLUSH
    1FS ^L INSERT		    !* @Y should not discard ^L's.!
    1FS VAR MAC

    0U.H			    !* No goal for ^P, ^N known.!
    :i.w			    !* Not in Atom Word Mode.!

    10*5 FS Q VECTOR U..K	    !* Set up ..K, the kill vector.!
    Q..K[..O J 5D ]..O
    -1U0 9< 0U:..K(%0) >

    5*5 FS Q VECTOR U..U	    !* Set up ..U, the Undo info vector.  See Undo for doc.!
    0U:..U(0) 10000000U:..U(2)	    !* Set it up so Undo will complain.!

    6*8 FS Q VECTOR U.N	    !* Set up .N as qvector 8 words long, with 1 word gap.!
    [..O Q.NU..O J 5D ]..O
    :I*[1 -1[2
    FQ.N/5< Q1 U:.N(%2)>	    !* Fill all words with null strings.!

!* If not in Lisp mode, don't do Lisp syntax hair, but do treat [,] and {,} as parens.!
    !"! 1M(M.M &_Alter_..D) [( ]) {( }) |A /A 'A
!* Set up matching openparens for closeparens!
    !"! 2M(M.M &_Alter_..D) ][ )( >< }{    !'!

!* Just for laughs, specify matching closeparens for openparens,
even though nothing in standard EMACS uses the info now.!
    !"!2m(m.m&_Alter_..D) <> () [] {} `' "' "'

    M.M &_Macro_Execute UM
    M.M &_Prepare_For_Input U.I
    M.M &_Prefix_Character_DriverU.P

    M.M &_Autoload U.A
    M.M &_Make_Variable U.V
    M.M &_Set_Variable_Comment U.C

    M.M &_F^K_Hook M.V *F_Hook*

!*** These MM variables are essential!
    M.M &_Check_Top_Level M.V MM_&_Check_Top_Level
    M.M &_Maybe_Push_Point M.V MM_&_Maybe_Push_Point
    M.M &_Maybe_Display_Directory M.V MM_&_Maybe_Display_Directory
    M.M &_Yes_or_No M.V MM_&_Yes_or_No
    M.M Make_Space M.V MM_Make_Space

!* Variables that hide FS flags.!

    500M.C Auto_Save_Interval	    ! *_number_of_characters_between_auto-saves!
				     fs^r mdlyw fs^r mcnt 
      500FS ^R MDLYW
    0M.C Bottom_Display_Margin	    ! *_Don't_let_cursor_be_in_this_percent_of_screen!
				     FS%BOTTOM 
      0FS%BOTTOM
    1M.C Case_Search		    ! *_1_=>_Searches_ignore_case!
				     FSBOTHCASE 
      1FSBOTHCASE
    40M.C Cursor_Centering_Point   ! *_Center_cursor_this_percentage_down_the_screen!
				     FS % CENTER 
      40FS %CENTER
    0M.C Display_Mode_Line_Inverse ! *_1_=>_Display_mode_line_in_standout_mode!
				     FS INVMOD 
    0M.C Display_Overprinting	    ! *_1_=>_Try_real_overprinting_on_the_screen!
				     F "'N FS^HPRINW "'N FS^MPRIN 
    3M.C Echo_Area_Height	    ! *_Number_of_lines_in_echo_area!
				     F FS ECHO LINES 
    35M.C End_of_Buffer_Display_Margin ! *_Leave_this_percent_of_screen_blank_at_EOB!
				     FS %END 
      35FS %END
    0M.C Error_Messages_in_Echo_Area ! *_1_=>_display_error_messages_in_echo_area!
				     FS ECHO ERR 
    70M.C Fill_Column		    ! *_Page_width_for_filling_and_grinding!
				      FS ADLINE 
      70FS Adline
    0M.C Overwrite_Mode	    ! *_Overwrite_Mode_status_(see_M-X_Overwrite_Mode)!
				     1FS MODE CHW FS ^R REPLACE 
    0M.C SAIL_Character_Mode	    ! *_1_=>_Display_chars_0-37_as_SAIL_graphics!
				     F FS SAIL 
    FS OSTECO"N
      0M.C System_Output_Holding   ! *_1_=>_let_system_handle_C-S_and_C-Q!
				     FS TTY PAGE '
    0M.C Top_Display_Margin	    ! *_Don't_let_cursor_be_in_this_percent_of_screen!
				     FS%TOP 
      0FS%TOP

!* Other user-interesting variables.!

    0M.V Abort_Resumption_Message
    0M.C Atom_Word_Mode	    ! *_1_=>_word_commands_deal_with_LISP_atoms!
				     :I.W "n :I.W@' 1FS MODE CH
    0M.C Auto_Directory_Display    *_1_=>_display_dir_after_writes,_-1_=>_reads_too
    0M.C Auto_Fill_Mode	    ! *_nonzero_=>_Auto_Fill_(break_long_lines_at_margin)!
				     1FS MODE CH
				     32FS ^R INIT U_ "E'
				     M.M^R_Auto-Fill_SpaceU_
    500M.C Auto_Push_Point_Option  *_Searches_moving_this_far_set_mark_at_old_point
    :I*_^@ M.C Auto_Push_Point_Notification *_Searches_setting_mark_type_this
    0M.C Auto_Save_Visited_File    *_1_=>_auto_save_under_visited_filename
    0M.C Autoarg_Mode		    ! *_1_=>_digits_and_Minus_before_control_chars_set_arg!
				     0 FS ^R INIT[2
				     "N M.M ^R_AutoargU2'
				     Q2-Q0"E ' Q2U-
				     Q2U0 Q2U1 Q2U2 Q2U3 Q2U4
				     Q2U5 Q2U6 Q2U7 Q2U8 Q2U9 
    1M.C Case_Replace		    *_1_=>_Replace_commands_preserve_case
    0M.C Comment_Begin		    *_String_for_beginning_new_comments
    32M.C Comment_Column	    *_Column_to_start_comments_in
    0M.C Comment_Start		    *_String_that_indicates_the_start_of_a_comment
    :I*  M.C Comment_End	    *_String_that_ends_comments
    :I*/8+1*8 M.C Comment_Rounding *_Hairy_-_see_code_for_^R_Indent_for_Comment
    :I*FundamentalM.C Default_Major_Mode *_Major_Mode_for_newly_created_buffers
    0M.C Display_Matching_Paren    ! *_Controls_action_of_)_in_showing_the_matching_(!
				     "N M.M &_Matching_Paren' "#0' FS ^R PAREN 
    :I*.?! M.C Fill_Extra_Space_List    *_punctuations_that_need_2_spaces
    :I* M.C Fill_Prefix	    *_String_to_put_before_each_line_when_filling
    0M.C Indent_Tabs_Mode	    ! *_-1_=>_Use_tabs_for_indentation.__0_=>_only_spaces.!
				     "E M.M&_Indent_without_TabsUMM_&_Indent
				          M.M&_Xindent_without_TabsUMM_&_Xindent'
				     M.M&_Indent_with_TabsUMM_&_Indent
				     M.M&_Xindent_with_TabsUMM_&_Xindent 
    0M.C LISP_Indent_Offset	    *_See_^R_Indent_for_LISP
    :I* M.C Page_Delimiter	    *_Search_string_for_finding_page_boundaries
    !"! :I*.	_' M.C Paragraph_Delimiter *_Lines_starting_with_these_chars_start_paragraphs
    -1M.C Permit_Unmatched_Paren   *_1_=>_allow_unmatched_),_-1_=>_only_in_Lispish_modes
    0M.C Read_Line_Delay	    Pausing_this_many_1/30_sec_causes_echoing
    5000 M.C Region_Query_Size	    *_Some_commands_need_confirmation_if_region_this_big
    M.C Search_Exit_Char	    *_Char_to_exit_I-search_and_do_nothing_else
    :I* M.V Set_Mode_Line_Hook
    0M.C Space_Indent_Flag	    *_Nonzero_=>_Auto_Fill_indents_new_lines
    :I*________:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______:_______: M.C Tab_Stop_Definitions  *_Tab_stops_for_^R_Tab_to_Tab_Stop
    :I*MEMO  XGP  PRESS  @XGP  UNFASL  OUTPUT  OLREC _ !*
!   M.C Temp_File_FN2_List	    *_Reap_File_deletes_these_FN2s
    !"! 1M.C Visit_File_Save_Old   *_-1_=>_visiting_new_file_saves_old,_0_=>_don't,_1_=>_ask_user

    0 M.V Backtrace_Temp
    0 M.V CRL_Help
    0 M.V CRL_List
    0 M.V CRL_Name_Lister
    0 M.V CRL_Name_Type
    0 M.V CRL_Prefix
    :I..G Q..H"E MDirectory_Lister'
    :I* M.V Editor_Name
    :I* M.V Editor_Type
    :I*Fundamental M.C Mode	    Do_MM_FOO_to_enter_FOO_mode
    :I* M.V Prefix_Char_List
    :I* M.C Submode		    !! 1FS MODE CH 
    M.M &_Subset_Directory_Listing M.C Directory_Lister Macro_to_use_to_list_directories
    15FS Q VECTOR[1 Q1 M.V Search_Default_Ring
      :I:1(0) :I:1(1) :I:1(2) ]1

    M.VMM_&_Indent
    M.VMM_&_XIndent
    -1UIndent_Tabs_Mode

!* Set up variables that control Lisp indentation.!
    @:i*| :i*[1 :fo..Q Lisp_1_Indent "l
	   m.v Lisp_1_Indent ' w |[D

    1 mD *CATCH
    1 mD *THROW
    1 mD CASE
    1 mD CASEQ
    1 mD COMPILER-LET
    2 mD DO
    1 mD DOLIST
    1 mD DOTIMES
    1 mD EVAL-WHEN
    1 mD IOTA
    1 mD LAMBDA
    1 mD LET
    1 mD LET*
    1 mD LET-CLOSED
    1 mD LET-GLOBALLY
    1 mD MULTIPLE-VALUE
    2 mD MULTIPLE-VALUE-BIND
    0 mD PROG1
    0 mD PROG2
    0 mD PROGN
    1 mD SELECT
    1 mD SELECTQ
    0 mD UNWIND-PROTECT
    0 mD WITHOUT-INTERRUPTS

    ]D

    :i* LISP m.v Lisp_Indent_Language 

    m.m &_Standard_Lisp_PROG_Hook m.v Lisp_PROG_Indent

    1m.v Lisp_Indent_DEFanything
    m.m &_Standard_Lisp_Indentation_Hook m.v Lisp_Indentation_Hook

!* Load up a copy of the function to process an EVARS file
so that we can run it, the first time, without loading AUX.!
    :g(m.a AUX&_Process_Init_Vars) m.v MM_&_Process_Init_Vars

!* On ITS, make the LEDEFS table autoload.!

    FS OSTECO"E
      @:I*| M(M.A LEDEFSDefine_LEDEFS)| FS LEDEFS'

!* Just for compatibility... not used for anything.!

    0M.V Inhibit_Write

!* Set up buffer table and related variables.!

    0M.V Next_Bfr_Number
    14!*buflcl!*5 FS Q VECTOR U.B
    14!*buflcl!U:.B(0)			    !* Initialize the entry for the initial buffer.!
    :I*Main U:.B(1!*bufnam!)		    !* Its name is Main.!
    0U:.B(2!*bufvis!)			    !* It contains no file.!
    :I*Fundamental U:.B(3!*bufmod!)	    !* It starts in fundamental mode!
    Q..Z U:.B(4!*bufbuf!)	    !* It is the same one that TECO gave us to start with.!
    0U:.B(5!*buftdf!)		    !* Don't need to init FS DFILE and FS WINDOW slots!
    0U:.B(6!*bufwin!)		    !* Since they are used only when buffer not selected.!
    %Next_Bfr_NumberU:.B(7!*bufnum!)
    0U:.B(8!*bufdat!)
    0U:.B(9!*bufver!)
    0U:.B(10!*bufsav!)		    !* Auto save off.!
    0U:.B(11!*bufsiz!)		    !* Size of text at last read or save = 0.!
    0U:.B(12!*bufnwr!)		    !* Not read-only.!
    128*5 FS B Cons F( FS Cng Buf !* Set up to record changes.!
    )U:.B(13!*bufcng!)

    0M.V Buffer_Filenames
    Q:.B(1) M.V Buffer_Name
    0 M.V Buffer_Index
    Q:.B(1) M.V Previous_Buffer
    Q..Z FS Top Buf		    !* This is the selected EMACS buffer.!

    M.M &_Default_FS_Superior FS SUPERIOR
    M.M Make_Local_Variable U.L
    0M.C Auto_Save_Mode	    ! *_non-0_=>_do_auto_saves!
				     "'N  M(M.MAuto_Save_Mode) 
    0M.C Auto_Save_All_Buffers	    *_non-0_=>_auto_save_all_buffers,_not_just_selected_one
    0M.C Auto_Save_Default	    ! *_non-0_=>_by_default_use_auto_save!
				     1FS MODE CH 
    FS OSTECO"E :I*DSK:__SAV00 M.C Auto_Save_Filenames   *_Filename_for_Auto_Save_files'
    "# :I*[SAVE].. M.C Auto_Save_Filenames   *_Filename_for_Auto_Save_files'
    2M.C Auto_Save_Max		    *_#_of_saves_to_keep
    M.L Auto_Save_Count
    1M.V Initial_Local_Count	    !* This is the number of M.L's above!

!* This must wait till last, because it won't work
 until the other stuff is set up.!
    M.M &_Set_Mode_Line FS MODE MAC	    !* Say what to do about updating ..J!
    1FS MODE CHANGE		    !* and ask that it be done eventually.!
    

!Purify Variables:! !C Make var names in symtab pure.
For each symbol, sees whether there is a pure string for
its name, and if so makes the sym tab point at that pure string.!

    [1 [2 [3
    m.m &&_Variable_Name_Listu2    !* Q2 has pure string before the first var name.!
    < q2+fq2+4u2 -fq2;		    !* Look at each available pure string.!
      :fo..q2u1		    !* Look for a variable with that name.!
      q1"g f~:..q(q1)2"e	    !* If it exists and is an exact match,!
	  q2u:..q(q1)		    !* stick the pure string in as the variable name.!
	  q2+fq2+4u3		    !* See if the next pure string matches that var's comment.!
	  q:..q(q1+2)"n
	    f~:..q(q1+2)3"e    !* If so, purify the comment too.!
	      q3u:..q(q1+2)'''
	  !* Now, purify anything in .B which matches this string.!
	  0u3
	  fq.b/5< fq:.b(q3)"g f~:.b(q3)2"e
				q2u:.b(q3)''
		  %3 >
	  '>
    

!& Load Patches:! !S Load patches (made since [pure] file) before dumping.
Essentially, we do TCompile on each page of the patch file,
whose name is specified as a string argument.!

    f[b bind [0 [1 [2
    f[d file et 
    1:< er @y>"l '		    !* Read in the patch file.  Exit if there is none.!
    z"e '			    !* Exit fast if it's empty.!
    @f
k			    !* Kill extra CRLF and ^L at front of file.!
    f[:ej page
    m(m.m Load_Library)PURIFY	    !* Otherwise, temporarily load PURIFY!
    < b,.k			    !* kill previous pages!
      m(m.m TCompile)		    !* and compile the next function.!
      :s

; >
    hk 
 