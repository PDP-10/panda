!* -*-TECO-*- *! !* Written and maintained by CTaylor@USC-ISIF *!

!* Scribe Bibliography Library *!

!~FILENAME~:! !Macros to facilitate entering a bibliography!
BIBLIO


!& Setup BIBLIO library:! !S Assign keys and load WORDAB library for BIBLIO.!

23*6 FSQVectorm.cBIBLIO_defsQ_Vector_containing_old_BIBLIO_key_definitions.
0m.cBIBLIO_modeSet_to_1_if_BIBLIO_keys_defined,_otherwise_0.
0m.cBIBLIO_windowSet_if_second_window_is_displayed

1M(m.mBIBLIO)			    !* Turn on BIBLIO keys!

:I* Available_bibliographic_entries:__Article;___Book,__Booklet;__InBook,
    __InColl(ection),__InProc(eedings);___Master(sThesis),__Manual,__Misc;
    __Phd(Thesis),__Proc(eedings);_Tech(Report);___Unpub(lished).m.vBIBLIO_window_entries

:I*Entry_names_are:
_
___Article
___Book,__Booklet
___InBook,__InColl(ection),__InProc(eedings)
___Master(sThesis),__Manual,__Misc
___PhD(Thesis),__Proc(eedings)
___Tech(Report)
___Unpub(lished)
_
Command_characters_are:
_
___M-n_=_Next_field;________________M-p_=_Previous_field;
___M-[_=_Start_of_entry;____________M-]_=_End_of_entry;
___M-._=_Remove_all_blank_fields;___M-/_=_Reinsert_blank_fields;
___C-M-n_=_Next_blank_field;________C-M-p_=_Previous_blank_field;
___M-s_=_Skip_to_end_of_field;______C-M-m_=_Mark_entry;
___C-M-u_=_Unexpand_entry;__________M-u_=_Unexpand_word;
___C-M-c_=_Copy_codeword;___________C-M-f_=_Create_Nofield;
__________________M-?_=_BIBLIO_Summary.
_
_____________________OTHER_USEFUL_COMMANDS
_
*_Convert_a_BIB_file_to_BIBLIO_format,_"M-X_Convert_to_BIBLIO_format$".
*_Permanently_displays_the_entry_names_at_the_top_of_the_page,
_____"M-X_Show_BIBLIO_entries_in_window$".
*_Turn_off_the_expansion_mode_type,_"M-X_BIBLIO$"._(Toggles)
*_View_a_entry's_fields_type,_"M-X_List_Word_Abbrevs$entry-name".
*_Change_any_or_all_entry_fields_type,_"M-X_Edit_Word_Abbrevs$".
*_Save_your_definitions_of_entry_names_and_other_words,
_____"M-X_Write_Word_Abbrevs$".
_
This_library_is_based_on_the_word_abbrev_library,__in_fact_it's_loaded
automatically_underneath_the_BIBLIO_library.__This_means_all_of_the_word
abbrev_capablities_are_also_available_with_this_library.
_
This_is_a_trial_version,_please_sent_your_comments(complains)_to_CTaylor@ISIF.
_
------------------------------------------------------------------------------
m.vBiblio_entries
[1 9:I1				    !* Insert a tab the hard way!
:I*_1	
M.vBIBLIO_blanks		    !* Tab, space, cr and lf!

:I*!~#;$%^&*-_=+[]()\|:`"'{},<.>/? 
m.vWORDAB_Ins_Chars		    !* Standard list minus @!

1M(m.mWord_Abbrev_mode)	    !* Turn on word abbrev mode!

E?BIBLIO_DEFNS"E		                    !* Load defns file!
 MMRead_Word_Abbrev_FileBIBLIO_DEFNS'             !* from user first!
 "#MMRead_Word_Abbrev_FileEMACS;_BIBLIO_DEFNS'    !* else from <emacs>!

0


!^R Next blank biblio field:! !^R Skip to the next blank bibliographic field.
 Initially all of the field values for a entry are empty and 'M-n' and 'C-M-n'
work the same.  As you fill in values, you may want to skip over the fields
with values, 'C-M-n' does this.  'C-M-n' skips forward to the next blank
field.!

"L-:M(m.m^R_Previous_blank_biblio_field)'	    !* Negative arg.!

.[1				    !* Save the point in case of error!
!* Search for "=<> or end of entry";  If "=<>" found position point and loop!

<:S=<>]+1"N
           -1"N Q1j		    !* ]: error!
	       :I*Hit_end_of_bibliographic_entry FS Err
	       ''
	   R .u1>		    !* =<>: position and remember point in!
				    !* case of error!
0



!^R Next biblio field:! !^R Skip to the next bibliographic field.
 Skips to the start of the next field, positioning the typing cursor at the
beginning of the field's value.!

"L-:M(m.m^R_Previous_biblio_field)'    !* Negative arg.!

.[1				    !* Save the point in case of error!
!* Search for "=< or end of entry";  If "=<" found position point and loop!

<:S=<]+1"N!>!
           Q1j :I*Hit_end_of_bibliographic_entry FS Err'  !* ]: error!
	   .u1>			    !* =<>: position and remember point in!
				    !* case of error!
0



!^R Previous blank biblio field:! !^R Skip to prev. blank bibliographic field.
 Similar to 'C-M-n', but skips backwards to a blank field value.!

"L-:M(m.m^R_Next_blank_biblio_field)'

.[1				    !* Save the point in case of error!
!* Search for "=<> or end of entry";  If "=<>" found position point and loop!

<-:S=<>[+1"N
           Q1J :I*Hit_start_of_bibliographic_entry FS Err'  !* [: error!
	   2C .u1>		    !* =<>: position and remember point in!
				    !* case of error!
0



!^R Previous biblio field:! !^R Skip to the previous bibliographic field.
 Skips to the previous field, also positions the cursor at the value.!

"L-:M(m.m^R_Next_biblio_field)'

.[1				 !* Save the point in case of error ! 
!* Search for "=<> or end of entry"; If "=<>" found position point and loop!

< 1:<.-2,.F==<"E!>! 1R'>	 !* skip over "=<" when point is just!
				 !* to the right !  -:S=<[+1"N!>!
        Q1J :I*Hit_start_of_bibliographic_entry FS Err' !* [: error!
	2C .u1>			 !* position and remember point!
				 !* in case of error!
0



!^R Skip over Field:! !^R Skip to the end of a bibliographic field.!

.[2
"L				    !* If negative!
 -<-:S[=<+1 ; .+2u2>'

"#
 [1				    !* Number of fields to skip!
 .,.+1F=>"E %1'		    !* Skip to the next end if at an end!
 q1<:S]=<+1; .u2>'		    !* Skip over n fields!

-:S[>+2"G Q2j'		    !* Find end of last entry!
0				    !* Done!



!^R Create Nofield:! !^R Create a field with NoField as its value.
 Creates a value by combining the word 'no' with the current 'field name'
and inserts the combination in the field's value.  Helpful when you don't know
what to enter but want something to show up in the bibliography.!

[1
0L :FWL FWX1			    !* Get the field name!
1M(m.m^R_next_biblio_field)	    !* Skip to field's value!
.,.+1F=>"N :I*This_field_has_a_valueFS Err'	    !* Must be empty!
INo1				    !* Insert Nofield!
-FW				    !* Changed one word!



!Sort entries by codeword:! !C Sort by codeword.
 Sorts the bibliographic entries by codeword.  This function will be
automatically invoked by 'M-.' if the variable 'automatic codeword sort' is
set non-zero.!

Zj .-1,.F=]"E I
'				    !* Put CRLF at the end of buffer if needed!

Bj
1M(m.m^R_End_of_biblio_entry)	    !* Skip to first entry!
3,1M(m.m^R_Start_of_biblio_entry)
-FWL 0L
.F[V B				    !* and set buffer!

 FWL :FWLFWL1M(m.m^R_End_of_biblio_entry$)w

H


!^R Cleanup biblio entry:! !^R Delete all @? and empty fields.
 When a entry is expanded all possible fields for that entry are displayed.
You probably don't want to enter information for all of the fields displayed.
After the entry is completed to suit your needs, type 'M-.', to delete empty
optional and empty satisfied alternative entries.  If you have forgotten one
of the required fields, you will be warned and the cursor left at the required
field needing information.  Enter the missing information and retype 'M-.'.
When the entire entry is acceptable, no message will be displayed and the
cursor will be after the closing ']'.!

.[1 [3 [4			    !* Save in case of error!

6,1M(m.m^R_Start_of_biblio_entry)"L '     !* Jump to start exit on error!

.u1
.,.+1F=,"E FG @FT		    !* Do we have a codeword, find nonblank!
Missing_codeword_for_this_field.  !* Is it a ","!
           0FSEcho Act 0'	    !* Yes missing codeword; exit!

!* Loop through entry until all "=<>" and "@?" have been deleted. If we find a!
!* "=<>" then the following cases are checked: !
!* 1) Is it required?  Force an field!
!* 2) Is it optional(@? opt)?  Delete if empty!
!* 3) Is it conditional(@? or)? Search for other fields.  If one is filled in!
!*    delete this field, otherwise force field!
!* Assume Q1 points to the top of the entry. Note: iteration "<>" is dangerous!
!* because of the =<> hang around!

!LCleanup!
	  :S]@?=<>+2u3	    !* Look for special fields!
!* Case 1!
	  q3"G
	    0u4	Q1j		    !* ] or EOF:  Exit loop after!
	    <!<!		    !* replacing commas!
	     :S]>+2"N 1;'
	      .,.+1F=,"N %4	    !* Count number of missing commas!
	      I, '		    !* Insert comma!
	    >
	    -:S,>[+1"E D'	    !* deleting trailing comma!

	    q4-1F"G :\u4 	    !* Print msg!
	    FG @FT
Replaced_4_commas_after_">"'s. !'!
	      0FSEcho Act'

	    :S]"E		    !* Missing closing ]?!
	        :I*Missing_closing_"]" FS Err !''!'
	           
	    0fo..Q Automatic_codeword_sort"N	    !* Exit after sorting!
              7,1M(m.m^R_Start_of_biblio_entry)    !* Save first line!
	      -FWL 1X4		    !* of this entry for the return!
	      M(m.m Sort_entries_by_codeword)	    !* Do the sort!
	      S4		    !* Return to position!
	      H'		    !* Exit with sort done!
	    "# Q1,.'		                    !* Normal Exit!
	  '
!* Case 2!
	  q3"E-:S>,		    !* @?:  Find end of this field!
	  C :K	oLCleanup		    !* Delete to end of line!
	  '
!* Case 3!
	  q3"L .-1u4 :L	.u2	    !* =<>:  Check for required fields!
	    q4,q2:FB@?u3	    !* Search for "opt", "or", ""!
	    :FWL		    !* Move to either "opt" or "or"!
!* case 3a!
	    q3"E		    !* Req'D line:  Print req'd error!
!EError!      @FT
Missing_the_required_or_one_of_the_alt._bibliographic_fields.
	      @FG 0FSEchoAct	    !* Ring bell, show the msg,!
	      .u8 Q4j Q1,.'	    !* reposition point and exit!
!* case 3b!
	    FWF=Optional"E	    !* @? Opt:  delete line!
!DLine!	        Q4j 0LK oLCleanup' !* Field for successful or cause!

!* case 3c!
	    FWF=or"E FWL	    !* @ or :  Skip to alternate name!
	      .u2 :L .u3 q2j	    !* Save end of line in Q3!
	      <FWL -FW@X2 q3-.:"G 1;'	    !* Find alt names!
	       :I22=>
	      Q1j		    !* Start at begin of entry!

!Next_name!   :S]2=+2u3	    !* search for alt. name!
	        q3"G oEError'	    !* missing name!

	        .,.+2F=<>"N 0q3 oDLine'   !* found something here, so ok!
	        C oNext_name	    !* try another name!
	      '
!* case 3d!
	    FWX2		    !* Stuff the unknown keyword in Q2!
            :I*Unknown_keyword_"2"_after_"@?" FS Err  !''''!
	    0			    !* Let'm fix keyword!

            '			    !* End of "=<>" check!
				    !* Exit from subr is in loop above!


!^R Incremental biblio expand:! !^R Fill out any missing fields.
 After typing 'M-.', all of the empty fields will have been deleted.  To
reinstate these fields use 'M-/'.  Typing 'M-/' will redisplay all of the
blank fields at the end of the entry and place the cursor at the first blank
field.!

[1[2 .[3 [4			    !* Save working q-regs!
7,1M(m.m^R_Start_of_biblio_entry)  !* Find entry name!
-FWL FWX1			    !* Place it in Q1!

1M(m.m^R_Mark_biblio_entry)	    !* Mark entry and copy!
M(m.m^R_Copy_region)		    !* into a buffer!

1M(m.m^R_Un-kill)		    !* Dump entry in buffer!
M(m.m^R_Set_bounds_region)	    !* Narrow the buffer!

-:S> .+1,ZK			    !* Delete trailing ]!
Bj :S,				    !* Find end of codeword!
:FWL B,.K			    !* Delete "entry name[" etc.!

<.u4				    !* End of previous field!
:S=<
+1u2				    !* Leave only field name!
  q2"E -FWL q4,.K FWL C I 1K' !* Field name!
    "# q2"L q4,.K'		    !* No field name on this line!
    "# q2"G 1;'''		    !* Search failed!
>

B,Z-2X2 HK			    !* Save search list and clear buffer!
G1				    !* Place entry name in buffer!
1F<!BIBLIO_increment! M:.e(0)>	    !* Expand virgin entry!
				    !* Trap is from Start biblio entry!

:S,				    !* Delete head!
:FWL B,.K
Zj -:S> 
1L .,ZK				    !* and tail!

<-:S2; 0LK>			    !* Delete similar fields!

B-Z"E HK M(m.m^R_Set_bounds_full)  !* No new fields!
 Q3j :I*No_additional_fieldsFS Err'

HX2 HK				    !* Save increment fields!
M(m.m^R_Set_bounds_full)	    !* Restore original buffer!

1,1M(m.m^R_End_of_biblio_entry)    !* Find end of field!
0L .u1 G2			    !* Insert additions!
Q1j -:S>,+1"E C I,'		    !* Add missing comma!
:S] .u2			    !* Display to the end!
Q1j 1,1M(m.m^R_Next_blank_biblio_field) !* Point to first new field!
Q1,q2



!^R Start of biblio entry:! !^R Jump to keyword pos. in bibliographic entry.
 Moves the typing cursor to the beginning of the codeword for the current
entry.!

!* Pre-comma arg (interpreted as binary)(?) does the following:
   ^X = 0 - Normal allow errors, skip to codeword.
   ^X = 1 - Don't move to codeword, remain at [.
   ^X = 2 - No codeword message.
   ^X = 4 - Don't skip to previous field if at codeword.
!

"L-:M(m.m^R_End_of_biblio_entry)'	    !* Negative arg!

.[1 QBIBLIO_blanks[2 [3

:L .u3 Q1j			    !* Pickup entry if we're close!
q1,q3:FB[@]+1"E :L'	    !* If this is the first line, stay here!

<&4"E			    !* Don't skip to previous field!
    1:<-@F2: j		    !* jump over blanks!
				    !* Are we at the beginning of a entry?!
      .-1,.F=["E 2R'>'		    !* If so, move to its left!

   -:S[+1"N Q1J		    !* BOF: return to original position!
           -1"E :I*Not_inside_bibliographic_entry FS Err'
                "# -1''	    !* Return -1 as an error flag!
          "#&1"E C @F2j'	    !* Move point to codeword!
        	 "#C'
	        .U1'
  >
!* Check for a codeword, if it is missing print msg.!
!* Pre-comma arg = 2 no msg, if BIBLIO increment is defined exit to it!

1:<.,.+1F=,"E&2"E 1:<F;BIBLIO_increment>  !* Throw for incremental fields!
   @:FT
Please_enter_the_bibliographic_codeword.
   0FS EchoAct''>
0



!^R End of biblio entry:! !^R Jump to end of bibliographic entry.
 Moves the cursor to the end of the current entry (just before the next '@').!

!* ^X = 1 - Remain after ].!

"L-:M(m.m^R_Start_of_biblio_entry)'	    !* Negative arg!

.[1				    !* Save in case of error!
<:S]+1"N			    !* Look for end of entry!
          Q1J -1"E:I*Not_inside_bibliographic_entry FS Err'
          -1'			    !* Signal an error!
         "# "E :S@"E ' "# 0l'' !* Move to the end of the entry!
	    .u1'		    !* Save point at the end!
  >
0



!^R Copy codeword:! !^R Copies the codeword at the point.
 Makes a copy of the codeword for this entry after the typing cursor.  This is
useful for copying the codeword into the key and author's fields, when the
fields all use the author's last name.!

.[1 [2
4,1M(m.m^R_Start_of_biblio_entry)"L 0'
@:F,X2			    !* Pick up codeword!
Q1j G2				    !* Return to point and insert!
q1,.



!Show BIBLIO entries in window:! !C Permanently displays entry names.
 Creates a second window at the top of the screen and displays the
bibliographic entry names in it for quick reference.!

 [0
 ff&1"N "'Gu0'		    !* Set Q0 to -1 if arg positive else 0!
         "# qBIBLIO_Window"'Eu0'
 q0,0f  u0			    !* 1 = on; 0 = off!
 q0-qBIBLIO_Window"E 0'	    !* Already set!
 q0M(m.m&_Show_biblio_entries)	    !* Invert window display!
 q0uBIBLIO_Window		    !* Remember the window status!
 0


!& Show biblio entries:! !& Subr for entry names in window.!

"E 1M(m.m^R_One_window)'	    !* Return to 1 window!

"#
1,2M(m.m^R_Two_windows)	    !* start two windows!
-qWindow_1_size+3M(m.m^R_Grow_window)
				    !* Create 3 line window!
1:<M(m.mKill_buffer)BIBLIOW>	    !* Make sure its empty!
M(m.mSelect_buffer)BIBLIOW	    !* Use BIBLIOW in first window!
:I*No_entry_names_available	    !* default response!
fo..Q Biblio_window_entries[1
G1				    !* dump in buffer!
Bj H@V				    !* display buffer!
M(m.m^R_Other_window)'		    !* Return to user's window!
0



!^R Print biblio summary:! !^R Print summary of BIBLIO functions.
 Displays a short summary.  The summary is two pages long; if you want to see
the second page type a space, otherwise type '^G'.!

:I*No_entry_names_available	    !* default response!
fo..Q Biblio_entries[1
:FT1				    !* Display entries!
0FS EchoAct




!^R Unexpand biblio entry:! !^R Similar to C-X U but for biblio entries.
 If you expanded an entry template by accident, this function will restore the
entry name as it was before the expansion.  This function is only valid
immediately after the template has been expanded.!

[1[2
1:<.-2,.-1F=["E		    !* At the codeword?!
  .-1,.X1 -1D			    !* Delete expander character and save!
  1M(m.m^R_End_of_biblio_entry)   !* Jump to the entry end!
  M(m.m^R_Unexpand_Last_Word)u2    !* Use word abbrev unexpand!
  G1				    !* Restore expander!
  q2'				    !* Return buffer changes!

  "#:I*Not_at_the_codeword_position_for_this_unexpand_command FS Err'
  >
0



!^R Mark biblio entry:! !^R Place point at beginning and mark at the end.
 Places the mark at the end of the entry and the point at the beginning.  This
is useful for deleting or moving an entire bibliographic entry.  With an
argument, n entries from the cursor are marked.!

[1 .[2
M(m.m^R_End_of_biblio_entry)"L oMarkErr'	!* Find end of entry!
.u1				    !* Q1 = end of entry!
				    !* Find start of entry!

3,M(m.m^R_Start_of_biblio_entry)"L oMarkErr'
-FWL 0L				    !* Start of entry including @entry!

.,q1F u1j q1:		    !* Put point at front, mark at end!
0				    !* Exit!

!MarkErr! -1"N u1 q1:\u1	    !* Print error msg!
!""!      Q2j :I*Couldn't_mark_1_entries,_so_mark_wasn't_set FS Err'
	  -1			    !* Reset point and exit!



!Convert to BIBLIO format:! !C Convert BIB file to BIBLIO format.
 BIBLIO provides a conversion function to rewrite any bibliographic file into
the form expected by BIBLIO.  This conversion is not guaranteed to be
complete, so you may have to hand translate a small portion.  Try it and see.!

[1 [3				    !* Temporary working space!
qBIBLIO_blanks[2 :I*()[]{}<>""[4 !* Blanks and delimiters!

bj				    !* Start at the beginning!

!NEntry!			    !* Loop on entries!
 :S@"e H'			    !* Exit if there are no more entries!
 FWL @F2j			    !* Skip to entry delimiter!
 1AF4u1			    !* Get delimiter and its inverse!
 q1+1,q1+2:G4u1			    !* Inverse is left in Q1!
 D I[				    !* Replace w/biblio start delimiter!
 S,				    !* End of codeword!
 
!NField!
 FWL .u3 @F2=j		    !* Start of field!
 q3,.K				    !* Delete extra spaces and =!
 1A"c I=<
      :S1,w R		    !* Bracket a number (Scribe has a strange!
      -@F2: j I>'	    !* idea of a number)!
    "# 1AF4u3		    !* Get delimiter and its inverse!
       q3+1,q3+2:G4u3		    !* Inverse is left in Q3!
       D I=<			    !* Replace w/field start!
       S3 -1D I>'		    !* Replace w/field end!

 :S1,u3
   q3+2"e oNField'		    !* End of field!
   q3+1"e -1D I] oNEntry'	    !* End of entry!
   q3"e oNEntry'		    !* Missing delimiter or EOF!



!BIBLIO:! !C Turns BIBLIO key definitions on and off ('M-?' for summary).
 Toggles between the standard character definitions and those specially
defined for BIBLIO.  By toggling BIBLIO off the library remains loaded but
inactive.!

 [0
 ff&1"N "'Gu0'		    !* Set Q0 to -1 if arg positive else 0!
         "# qBIBLIO_Mode"'Eu0'
 q0,0f  u0			    !* 1 = on; 0 = off!
 q0-qBIBLIO_Mode"E 0'	    !* Already set, so exit!
 q0uBIBLIO_Mode		    !* Set new the state!

 qBIBLIO_defsu0
 qBIBLIO_mode"G				    !* Turn on BIBLIO!

 qBIBLIO_window"G 1M(m.m&_Show_biblio_entries)'

 :I*bibliouSubmode		    !* Indicate biblio on mode line!
 1M(m.mWord_Abbrev_mode)	    !* Turn on word abbrev mode!
 0M(m.m&_Alter_..D)@A		    !* Allow @ in abbrevs!

  q..?  u:BIBLIO_defs(0)	    !* Save current defs!
 q...N  u:BIBLIO_defs(1)
 q...n  u:BIBLIO_defs(12)
  q..N  u:BIBLIO_defs(2)
  q..n  u:BIBLIO_defs(13)
 q...P  u:BIBLIO_defs(3)
 q...p  u:BIBLIO_defs(14)
  q..P  u:BIBLIO_defs(4)
  q..p  u:BIBLIO_defs(15)
  q..S  u:BIBLIO_defs(21)
  q..s  u:BIBLIO_defs(22)
  q...  u:BIBLIO_defs(5)
  q../  u:BIBLIO_defs(6)
  q..[  u:BIBLIO_defs(7)
  q..]  u:BIBLIO_defs(8)
 q...C  u:BIBLIO_defs(9)
 q...c  u:BIBLIO_defs(16)
 q...F  u:BIBLIO_defs(19)
 q...f  u:BIBLIO_defs(20)
 q...M  u:BIBLIO_defs(10)
 q...m  u:BIBLIO_defs(17)
 q...U  u:BIBLIO_defs(11)
 q...u  u:BIBLIO_defs(18)
 
 m.m^R_Print_biblio_summaryu..?	    !* Assign new functions!
 m.m^R_Next_blank_biblio_fieldu...N
 m.m^R_Next_blank_biblio_fieldu...n
 m.m^R_Next_biblio_fieldu..N
 m.m^R_Next_biblio_fieldu..n
 m.m^R_Previous_blank_biblio_fieldu...P
 m.m^R_Previous_blank_biblio_fieldu...p
 m.m^R_Previous_biblio_fieldu..P
 m.m^R_Previous_biblio_fieldu..p
 m.m^R_Skip_over_fieldu..S
 m.m^R_Skip_over_fieldu..s
 m.m^R_Cleanup_biblio_entryu...
 m.m^R_Incremental_biblio_expandu../
 m.m^R_Start_of_biblio_entryu..[
 m.m^R_End_of_biblio_entryu..]
 m.m^R_Copy_codewordu...C
 m.m^R_Copy_codewordu...c
 m.m^R_Create_Nofieldu...F
 m.m^R_Create_Nofieldu...f
 m.m^R_Mark_biblio_entryu...m
 m.m^R_Unexpand_biblio_entryu...U
 m.m^R_Unexpand_biblio_entryu...u
'				    !* BIBLIO turned on!

"#				    !* Turn BIBLIO off!

 qBIBLIO_window"G 0M(m.m&_Show_biblio_entries)'

 :I*uSubmode			    !* Clear mode line!
 0M(m.mWord_Abbrev_mode)	    !* Turn off word abbrev mode!
 0M(m.m&_Alter_..D)@_		    !* Disallow @ in abbrevs!

 q:BIBLIO_defs(0)u..?	    !* Restore current defs!
 q:BIBLIO_defs(1)u...N
 q:BIBLIO_defs(12)u...n
 q:BIBLIO_defs(2)u..N
 q:BIBLIO_defs(13)u..n
 q:BIBLIO_defs(3)u...P
 q:BIBLIO_defs(14)u...p
 q:BIBLIO_defs(4)u..P
 q:BIBLIO_defs(15)u..p
 q:BIBLIO_defs(21)u..S
 q:BIBLIO_defs(22)u..s
 q:BIBLIO_defs(5)u...
 q:BIBLIO_defs(6)u../
 q:BIBLIO_defs(7)u..[
 q:BIBLIO_defs(8)u..]
 q:BIBLIO_defs(9)u...C
 q:BIBLIO_defs(16)u...c
 q:BIBLIO_defs(16)u...F
 q:BIBLIO_defs(16)u...f
 q:BIBLIO_defs(10)u...M
 q:BIBLIO_defs(17)u...m
 q:BIBLIO_defs(11)u...U
 q:BIBLIO_defs(18)u...u
'				    !* BIBLIO turned off!
 0


!* Following should be kept as (only) long comments so will be compressed out:
 * Local Modes:
 * Fill Column:78
 * Compile Command:m(m.mGenerate Library)BiblioBiblio
 * End:
 * *!
    