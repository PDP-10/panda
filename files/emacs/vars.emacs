!* Varlist File -*-TECO-*-!

!&& Variable Name List:! !Q List of strings containing all built-in variables' names.!
!** The start-up process looks down the symbol table and replaces each
variable name with the corresponding one from here if there is one.
This makes all E's share the string names, reducing impure storage,,
and speeds up GC.!

!** You will see that variable comments are also included herein.
Variable comments must follow the corresponding names.
They become pure strings just like the variable names do.
The start-up process, when it replaces an impure variable name with
a pure one, also sees whether the following pure string matches the
variables's comment, and if so replaces that too.

However, since no string can span more than one line,
variable comments which include macros to be run are not included.!


 *F_Hook*
 Abort_Resumption_Message
 Atom_Word_Mode
 Auto_Directory_Display
   *_1_=>_display_dir_after_writes,_-1_=>_reads_too
 Auto_Fill_Mode
 Auto_Push_Point_Notification
   *_Searches_setting_mark_type_this
 Auto_Push_Point_Option
   *_Searches_moving_this_far_set_mark_at_old_point
 Auto_Save_All_Buffers
   *_non-0_=>_auto_save_all_buffers,_not_just_selected_one
 Auto_Save_Count
 Auto_Save_Default
 Auto_Save_Filenames
   *_Filename_for_Auto_Save_files
 Auto_Save_Interval
 Auto_Save_Max
   *_#_of_saves_to_keep
 Auto_Save_Mode
 Auto_Save_Visited_File
 Autoarg_Mode
 Backtrace_Temp
 Bottom_Display_Margin
 Buffer_Filenames
 Buffer_Index
 Buffer_Name
 Case_Replace
   *_1_=>_Replace_commands_preserve_case
 Case_Search
 Comment_Begin
   *_String_for_beginning_new_comments
 Comment_Column
   *_Column_to_start_comments_in
 Comment_End
   *_String_that_ends_comments
 Comment_Rounding
   *_Hairy_-_see_code_for_^R_Indent_for_Comment
 Comment_Start
   *_String_that_indicates_the_start_of_a_comment
 CRL_Help
 CRL_List
 CRL_Name_Lister
 CRL_Name_Type
 CRL_Prefix
 Cursor_Centering_Point
 Default_Major_Mode
   *_Major_Mode_for_newly_created_buffers
 Directory_Lister
   Macro_to_use_to_list_directories
 Display_Matching_Paren
 Display_Mode_Line_Inverse
 Display_Overprinting
 Echo_Area_Height
 Editor_Name
 Editor_Type
 End_of_Buffer_Display_Margin
 Error_Messages_in_Echo_Area
 Fill_Column
 Fill_Extra_Space_List
   *_punctuations_that_need_2_spaces
 Fill_Prefix
   *_String_to_put_before_each_line_when_filling
 Indent_Tabs_Mode
 Initial_Local_Count
 Lisp_*CATCH_Indent
 Lisp_*THROW_Indent
 Lisp_CASE_Indent
 Lisp_CASEQ_Indent
 Lisp_COMPILER-LET_Indent
 Lisp_DO_Indent
 Lisp_DOLIST_Indent
 Lisp_DOTIMES_Indent
 Lisp_EVAL-WHEN_Indent
 Lisp_Indent_DEFanything
 Lisp_Indent_Language
 Lisp_Indent_Offset
   *_See_^R_Indent_for_Lisp
 Lisp_Indentation_Hook
 Lisp_IOTA_Indent
 Lisp_LAMBDA_Indent
 Lisp_LET_Indent
 Lisp_LET*_Indent
 Lisp_LET-CLOSED_Indent
 Lisp_LET-GLOBALLY_Indent
 Lisp_MULTIPLE-VALUE-BIND_Indent
 Lisp_PROG_Indent
 Lisp_PROG1_Indent
 Lisp_PROG2_Indent
 Lisp_PROGN_Indent
 Lisp_SELECT_Indent
 Lisp_SELECTQ_Indent
 Lisp_UNWIND-PROTECT_Indent
 Lisp_WITHOUT-INTERRUPTS_Indent
 MM_&_Check_Top_Level
 MM_&_Indent
 MM_&_Find_Buffer
 MM_&_Find_File
 MM_&_Get_Library_Pointer
 MM_&_Kill_Text
 MM_&_Matching_Paren
 MM_&_Maybe_Push_Point
 MM_&_Maybe_Display_Directory
 MM_&_Process_File_Options
 MM_&_Read_Line
 MM_&_Set_Mode_Line
 MM_&_Xindent
 MM_Load_Library
 Mode
   Do_MM_FOO_to_enter_FOO_mode
 Next_Bfr_Number
 Overwrite_Mode
 Page_Delimiter
   *_Search_string_for_finding_page_boundaries
 Paragraph_Delimiter
   *_Lines_starting_with_these_chars_start_paragraphs
 Permit_Unmatched_Paren
   *_1_=>_allow_unmatched_),_-1_=>_only_in_Lispish_modes
 Prefix_Char_List
 Previous_Buffer
 Read_Line_Delay
   Pausing_this_many_1/30_sec_causes_echoing
 Region_Query_Size
   *_Some_commands_need_confirmation_if_region_this_big
 SAIL_Character_Mode
 Search_Default_Ring
 Search_Exit_Char
 Set_Mode_Line_Hook
 Space_Indent_Flag
   *_If_nonzero,_Auto_Fill_indents_new_lines
 Submode
   !! 1FS MODE CH
 Tab_Stop_Definitions
   *_Tab_stops_for_^R_Tab_to_Tab_Stop
 Temp_File_FN2_List
   *_Reap_File_deletes_these_FN2s
 Top_Display_Margin
