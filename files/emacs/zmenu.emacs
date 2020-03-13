!* -*- Teco -*- *!

!*

   ZMENU: Extensions to the ZBABYL library to provide filter menus.
	  Probably not needed a lot, so initially out-of-core.
	  
	  Created and maintained by Kent M. Pitman (KMP@MIT-MC).

   Modification History:

04/14/85 20	KMP	Installed this as an Emacs library.
12/20/83 19	KMP	Allow ZMenu to cooperate with the EMOUSE library. 
12/08/83 18	KMP	Incompatible change to ZMENU's construction of 
			 unlabeled messages. (NO-LABEL) is now (NOT (LABEL))
12/08/83 17	KMP	Upward compatible change to ZMENU to support transition
			 from ZBABYL 7 to ZBABYL 8, where & Filter Call expects
			 qF to be set up on entry to a prompt string.
12/04/83 16	KMP	Renamed FMENU library to ZMENU.
			Changed calls to & Filter Call to take continuation's
			 numargs on the paren pdl.
12/04/83 15	KMP	Fix minor bug in # Filter Labeled which didn't
			 grok user abort due to over-rubout correctly.
11/29/83 14	KMP	Upcase field names typed in by user in the
			 echo area.
11/29/83 9	KMP	Add a "Some" option to the menu to seek the
			 existence of a given field in a message.
11/29/83 4	KMP	Fixed menu stuff to add c-Q to in-buffer text
			 when constructing text of filter from text
			 typed interactively in echo area.
11/11/83 3	KMP	Created the FMENU Library by factoring out
			 parts of the FILTER library which don't need
			 to be always loaded.
 *!

!~Filename~:! !Filter editor (a la ZMail) for Babyl!
ZMENU

!& Setup ZMENU Library:! !S Setup for using the Filter Menu!

 !*  The following set of variables must exist in advance since we	*!
 !*  want to bind their values prior to invoking two window mode	*!

  fs%tofci"n 
   1,m(m.m&_Get_Lib)EMOUSE"e
    m(m.m Load_Library)EMOUSE ''

  m.vMouse_Select_Hook
  m.vWindow_1_Refresh
  m.vWindow_1_Size
  m.vWindow_2_Size
  m.vWindow_1_Pointer
  m.vWindow_2_Pointer
  m.vWindow_1_Window
  m.vWindow_2_Window
  m.vWindow_1_Buffer
  m.vWindow_2_Buffer


!Edit Filter:! !S Create/edit a filter using a menu!

 :i*Edit_Filter[F		    !* F: Prompt			!
 ( m.m&_Edit_Filter,:m(m.m &_Filter_Call)


!& Setup Filter Menu:! !& ... !

 :i* *Filter-Menu* f((		    !* Choose buffer name		!
 ) m(m.m Select_Buffer)	    !* Select buffer name		!
   z"e				    !* If empty,...			!
        i   *_Boolean_relations_for_specs...
	    _AND__Begin_a_conjunction.
	    _OR___Begin_a_disjunction.
	    ______End_a_conjunction_or_disjunction.
	    _NOT__Negate_the_next_condition.
	    _
	    *_Search_for_a_message_with_a_given_string_in...
	    _From_field
	    _To/CC_field
	    _Subject_field
	    _Whole_message
	    _Header
	    _Text
	    _Any_arbitrary_field_(prompted_for)
	    _
	    *_Other_message_characteristics
	    _Dated-After_a_given_date
	    _Dated-Before_a_given_date
	    _Labeled_with_some_keyword
	    _No_labels_on_message
	    _Matches_some_other_filter
	    _After_a_given_date_in_any_header_field_(prompted_for)
	    _Before_a_given_date_in_any_header_field_(prompted_for)
            _Some_given_field_is_present_in_message_(prompted_for)
	    _
	    *_Movement_Commands
	    _Forward_sexp
	    _Backward_sexp
	    _Up_sexp
	    _Down_sexp
	    _Kill_sexp
	    _
	    *_Code_Window_Options...
	    _Edit_text_in_other_window.
	    _Revert_text_in_other_window_to_its_initial_state.
	    _
	    *_Exit_Options...
  	    _Rename____Continue_editing_this,_but_call_it_something_else.
	    _Restart___Prompt_for_another_filter_name_and_edit_that_instead.
 	    _Abort_____Ignore_any_changes_to_this_filter_and_just_exit.
	    _Exit______Update_filter_and_exit.
	 j   0fsmodified
	      1fsreadonly '	    !* Make this menu permanent		!
 ) 				    !* Return buffer name		!


!& Prepare Window 2 Insertion:! !& Set up to hack other window!

 1f[noquit			    !* Bind interrupts			!
 m(m.m^R_Other_Window)		    !* Get to other window		!
 @fn| @v m(m.m ^R_Other_Window) |  !* Come back here later		!
 0fsnoquit			    !* Enable interrupts		!
 :				    !* No return values, no pdl unwind	! 


!& Filter Any:! !& qW should have thing to filter !

 1,fString:_[0		    !* Prompt for string		!
 fq0"l 0 '			    !* Maybe abort			!
 mP 
 0,1a-)"n			    !* If not an imbedded expression	!
  -@f_	k		    !* Kill whitespace			!
  ."g 0,0a-)"e i 
 '	    !* Maybe crlf			!
      
,0a-
"e @mI '	    !* Tab if fresh line		!
                  "# i_ '''	    !*  Else space			!
 i(W_"!'! 
 .( g0 )j			    !* Yank text string			!
  fq0< 1af"!'!:"l i ' c >  !* Hack quoting if needed		!
 i")!'!			    !* Close string			!
 @f)l i 
 @mI		    !* Pass hanging close parens	!
 0				    !* Pop				!


!# Filter Whole:! !& ... !

 :i*SEARCH[W f:m(m.m &_Filter_Any)


!# Filter Labeled:! !& ... !

 3,m(m.m&_Read_Babyl_Label)Label:_[L
 fqL:"g :i*Cfsechodisw 0 '
 :i*LABEL[W 
 fm(m.m &_Filter_Any)L


!# Filter Matches:! !& ... !

 :i*Filter_to_match[F		    !* F: Prompt			!
 ( m.m&_Continue_#_Filter_Matches,:m(m.m &_Filter_Call)


!& Continue # Filter Matches:! !& ... !

 :i*FILTER-CALL[W 
 fm(m.m &_Filter_Any)F


!# Filter No:! !& ... !

 mP
 0,1a-)"n			    !* If not an imbedded expression	!
  -@f_	k		    !* Kill whitespace			!
  ."g 0,0a-)"e i 
 '	    !* Maybe crlf			!
      
,0a-
"e @mI '	    !* Tab if fresh line		!
                  "# i_ '''	    !*  Else space			!
 i(NOT_(LABEL))		    !* Insert text			!
 @f)l i 
 @mI		    !* Pass hanging close parens	!
 0				    !* Return				!
 

!# Filter Header:! !& ... !

 :i*SEARCH-HEADER[W f:m(m.m &_Filter_Any)


!# Filter Text:! !& ... !

 :i*SEARCH-TEXT[W f:m(m.m &_Filter_Any)


!# Filter From:! !& ... !

 :i*SEARCH-FIELD_FROM[W f:m(m.m &_Filter_Any)


!# Filter To/CC:! !& ...!

 1,fString:_[S		    !* Get string in qS	!
 m(m.m #_Filter_OR)		    !* Start an OR	!
 m(m.m #_Filter_To)S	    !*  To what		!
 m(m.m #_Filter_CC)S	    !*  CC what		!
 m(m.m #_Filter_End)		    !* End the OR	!


!# Filter To:! !& ... !

 :i*SEARCH-FIELD_TO[W f:m(m.m &_Filter_Any)


!# Filter CC:! !& ... !

 :i*SEARCH-FIELD_CC[W f:m(m.m &_Filter_Any)


!# Filter Subject:! !& ... !

 !* Ugh... !

 1,fString:_[S		    !* Get string to check for	!

 m(m.m #_Filter_OR)

     :i*SEARCH-FIELD_SUBJECT[W
      m(m.m &_Filter_Any)S

     :i*SEARCH-FIELD_RE[W
      m(m.m &_Filter_Any)S

 m(m.m #_Filter_End)

 0


!# Filter Any:! !& ... !

 1,fField_to_scan:_:fc[W
 :iWSEARCH-FIELD_W
 f:m(m.m &_Filter_Any)


!# Filter Dated-Before:! !& ... !

 :i*Date,:m(m.m #_Filter_Before)


!# Filter Dated-After:! !& ... !

 :i*Date,:m(m.m #_Filter_After)


!# Filter Before:! !& ... !

 ff&2"n [F'
  "# 1,fField_(or_Return_for_"Date"):_!''![F'
 fqF"e :i*DATEuF '
 1,fDate_(or_Return_for_now):_[D
 qF:fcuF :iW PRECEDES_F
 m(m.m &_Filter_Any)D


!# Filter After:! !S ...!

 ff&2"n [F'
  "# 1,fField_(or_Return_for_"Date"):_!''![F'
 fqF"e :i*DATEuF '
 1,fDate_(or_Return_for_now):_[D
 qF:fcuF :iW FOLLOWS_F
 m(m.m &_Filter_Any)D


!# Filter Some:! !S ...!

 1,fField:_:fc[F
 fqF:"g fg 0 '
 mP
 0,1a-)"n			    !* If not an imbedded expression	!
  -@f_	k		    !* Kill whitespace			!
  ."g 0,0a-)"e i 
 '	    !* Maybe crlf			!
      
,0a-
"e @mI '	    !* Tab if fresh line		!
                  "# i_ '''	    !*  Else space			!
 i(SEARCH-FIELD_F)
 @f)l i 
 @mI		    !* Pass hanging close parens	!
 0


!# Filter AND:! !& ... !

 mP i(AND_ i 
 @mI
 0




!# Filter OR:! !& ... !

 mP i(OR_ i 
 @mI
 0




!# Filter End:! !& ... !

 mP -@f
_	k i) 
 mI
 0




!# Filter NOT:! !& ... !
 
 mP i(NOT_) r
 0




!# Filter Kill:! !& ... !

 mP @m(m.m ^R_Kill_Sexp)


!# Filter Down:! !& ... !

 mP @m(m.m ^R_Down_List)


!# Filter Forward:! !& ...!

 mP @m(m.m ^R_Forward_Sexp)


!# Filter Backward:! !& ...!

 mP @m(m.m ^R_Backward_Sexp)


!# Filter Up:! !& ... !

 mP 1:< ful >"n fg ' 0 


!# Filter Rename:! !& ... !

 1,fFilter_Name_(F):_[0
 fq0"g q0uF qF uFilter_Default
       :i*(Filter_Menu)_F___Space_selects,_c-m-C_exits,_c-]_aborts__u..J '
 0


!# Filter Revert:! !& ... !

 
 m(m.m ^R_Other_Window)	    !* Go over to other window	!
 0fo..QBabyl_Filter_F[0	    !* Get text in q0		!
 hk fq0"g g0 ' 0fsmodifiedw @v	    !* Yank and show		!
 m(m.m ^R_Other_Window)	    !* Back to other window	!
 0				    !* Return			!


!# Filter Restart:! !& ... !

 @m(m.m #_Filter_Rename)	    !* Rename this filter	!
 @m(m.m #_Filter_Revert)	    !* Revert this filter, too	!


!# Filter Edit:! !& ... !

 qS[_
 m(m.m^R_Other_Window)
 :i*(Filter_Edit)_F___c-m-C_exits_______(Extended_Search_Chars)[..J
 1:<  >			    !* Abort quits come here	!
 m(m.m^R_Other_Window) 
 0


!# Filter Abort:! !& ...!

 f;Filter-Abort


!# Filter Exit:! !& ... !

 f;Filter-Exit


!& Setup Filter Display:! !& ... !

 :i* *Filter-Display* f((	    !* Choose buffer name		!
 ) m(m.m Select_Buffer)	    !* Select buffer			!
   hk				    !* Empty buffer			!
 ) 				    !* Return buffer name		!


!& Edit Filter:! !& Create/Edit a filter. Filter name is numarg !

 qBuffer_Name[0		    !* 0: This buffer name		!
 [Previous_Buffer		    !* Bind previous-buffer state	!
				    !*					!
 m(m.m &_Setup_Filter_Menu)[T	    !* T: Menu buffer			!
 m(m.m &_Setup_Filter_Display)[B   !* B: Display buffer		!
				    !*					!
 q0m(m.m Select_Buffer)	    !* Reselect original buffer		!
				    !*					!
 qT,qB m(m.m &_Push_Two_Windows)   !* Set up for two window editing	!
				    !*					!
 m(m.m &_Really_Edit_Filter)	    !* We are ready; call worker	! 

 				    !* Return, unwinding		!


!^R Filter Space:! !^R This goes on Space for Edit Filter's menu!

 qBuffer_Name[0		    !* Get buffer name in q0		!
 f~0T"n f@:mS '		    !* Win if we're losing		!
 f:m(m.m ^R_Filter_Select)	    !* Jump to filter selector		!
 


!^R Filter Select:! !^R This goes on Mouse-Left for Edit Filter's menu!

 qBuffer_Name[0		    !* Get buffer name in q0		!
 f~0T"n 0 '		    !* Do nothing if not a menu buffer	!
 .[0 fnq0j			    !* Come back here later		!
 0l ."e fg 0 '		    !* Beep if header line		!
 @f_	l 1a:"a fg 0 '   !* Beep if empty line		!
 @flx*[0			    !* Get macro name in q0		!
 f:@m(m.m #_Filter_0)	    !* Run macro and return		!


!^R Filter c-H:! !^R This does dispatch!

 :i*Control-H:_m.ifi[0
 q0-?"e
     ft Control-H_is_an_extended_search_character_escape...
	_Control-O__is_extended_search_OR,_used_to_OR_strings.
	_Control-N__is_extended_search_NOT,_negates_next_char.
	_Control-B__is_extended_search_Break,_matches_delimiters.
	_Control-X__is_extended_search_Any,_matches_any_char.
	_Control-S__is_extended_search_Syntax,_matches_a_char_whose_Lisp_syntax
	_____is_next_char.__Eg,_c-S_(_matches_things_with_paren_syntax.
       0 '
 q0f"l fg 0' "# .,( q0i .) '
 


!& Really Edit Filter:! !Edit a filter. Strict teco entry conventions...
 qF: Filter name
 Must be in two window mode
 qT: Name of buffer in top window
 qB: Name of buffer in bottom window
!

 [1
 q_[S				    !* Save old definition of space	!
 m.m^R_Indent_for_Lisp[I	    !* Handy indentation macro		!
 m.m &_Prepare_Window_2_Insertion[P
 fsosteco"e :i*C '"# :i*Z '[C    !* Hack c-m-Z/C problem		!
 0fo..QBabyl_Filter_Fu1	    !* 1: Filter text			!
 q1"n m(m.m ^R_Other_Window)
      g1 @v 0fsmodified
      m(m.m ^R_Other_Window)'
 :i*(Filter_Menu)_F___Space_selects,_c-m-C_exits,_c-]_aborts__[..J 
 qT m(m.m Select_Buffer)	    !* Select Top Window		!
 m.m^R_Filter_Space[_	    !* Bind alternate space macro	!
 m.m^R_Filter_Select[Mouse_Select_Hook
 m.m^R_Filter_c-H[.H		    !* Bind c-H				!
 m.m^R_Filter_c-H[H		    !* Bind backspace			!
 !Retry!
 1f<!Filter-Abort!
  1f<!Filter-Exit!
      >			    !* Allow user editing		!
  qBuffer_Name[0
  f~0T"n f~0B"n
     !"!:i*CYou_can't_exit_Edit_Filter_from_here.
              Try_again_or_type_c-]_to_abort. fsechodisplay 
        0fsechoactive
        oRetry''
  qB m(m.m Select_Buffer)	    !* Select Bottom Window buffer	!
  fsmodified"n
     0 m.vAll_Babyl_Filter_Names   !* Invalidate cache			!
     hx* m.v Babyl_Filter_F 	    !* Get filter in named variable	!
     :i*CFilter_"F"_updated.!''!fsechodisplay'
  "# >				    !* Come here if aborting		!
     :i*CNo_change_to_filter_"F".!''!fsechodisplay '
  0fsechoactive
 0				    !* Return				!


!& Push Two Windows:! !& Set up for two-window hacking.!

 fsrgetty"e			    !* No printing terminal beyond here	!
  !"! :i*TTY	Doesn't_work_on_a_printing_terminal'
				    !*					!
    @fn| fsrefreshf"n [0m(q0(]0)) '!* Refresh upon unwind		!
         qWindow_2_Size"n
	   m(m.m^R_Other_Window)
	   @V
	   m(m.m^R_Other_Window)
	   @V'
	 |			    !*					!
				    !*					!
    qBuffer_Name[0		    !* 0: Buffer name			!
    @fn| m(m.mSelect_Buffer)0 | !* Set up to return to this buffer	!
				    !*					!
  m(m.m Select_Buffer)	    !* Select window 2			!
 .u0				    !* 0: Point in window 2		!
				    !*					!
  m(m.m Select_Buffer)	    !* Select window 1			!
  				    !*					!
    [Window_1_Buffer		    !* Bind window 1 buffer		!
  [Window_2_Buffer		    !* Bind window 2 buffer		!
				    !*					!
				    !*					!
  0 f[Refresh			    !* Bind tty refresh hook		!
  0 f[TopLine			    !* Bind top line info		!
  0 f[Lines			    !* Bind window height info		!
    f[Window			    !* Bind window info			!
				    !*					!
  0 [Window_1_Refresh		    !* Bind window 1 refresh		!
				    !* There is no window 2 refresh	!
				    !*					!
    fsheight-(fsecholines)/2(	    !* Use half-screen per window	!
  ) [Window_1_Size		    !* Bind window 1 size		!
  0 [Window_2_Size		    !* Bind window 2 size		!
				    !*					!
  . [Window_1_Pointer		    !* Bind window 1 pointer		!
 q0 [Window_2_Pointer		    !* Bind window 2 pointer		!
				    !*					!
    [Window_1_Window		    !* Bind window 1 window		!
    [Window_2_Window		    !* Bind window 2 window		!
				    !*					!
 1,@m(m.m ^R_Two_Windows)	    !* Normal two-window call		!
				    !*					!
				    !* Do not unwind stack		!
