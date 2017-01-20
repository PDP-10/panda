!~Filename~:! !Library for renumbering references, sections, equations, figures, and tables!
RENUM

!& Setup RENUM Library:! !S Sets up default variables for & Renumber Text and Renumber References.

If arg, load into qRenumber Text Formatter.  This is useful
if you load the RENUM library in your init.  If no arg, try to
determine the type of formatter used and load into qRenumber Text
Formatter.  TEX is assumed otherwise.

Then load the default variables depending on the formatter used 
and run qRENUM Setup Hook (if exists) for any user customization.
!

:i*TEX M.V Renumber_Text_Formatter !* default !
ff-1"e			!* was one argument given?!
   fuRenumber_Text_Formatter !* put in as formatter name!
   '"#
				!* test for other formatters.!
   '
!******************************************************************
   	FORMATTER INDEPENDENT DEFINITIONS
******************************************************************!
M.C Renumber_Draft_Mode1=>in_draft_mode
M.C Renumber_Whole_File1=>ignore_narrowing
M.C Renumber_Section_SeparatorsText_separating_indexing_levels
M.C Renumber_Section_Default_SeparatorIn_case_user_forgets_one_at
		the_end_of_his_new_section_number.
M.C Renumber_New_SectionText_for_identifying_new_section--case_is_
		significant.__Start_with_a_<NL>_if_you_require_it
		to_start_on_a_new_line.
M.C Renumber_New_ChapterText_for_identifying_new_chapter--case_is_NOT_
		significant.__Start_with_a_<NL>_if_you_require_it
		to_start_on_a_new_line.
M.C Renumber_WhitespaceText_preceding_first_significant_character
		of_a_figure_or_table_or_second_pass_equation.
M.C Reference_Output_FilenameBibliography_table_is_stored_here_when_Renumber
		References_is_given_an_arg_of_1
M.C Reference_DashText_for_replacing_consecutive_numbers_(references).
		Used_by_Reference_Sort_Macro.
M.C Reference_Bibliography_BeginText_denoting_start_of_bibliography.
M.C Reference_Bibliography_EndText_on_the_1st_line_after_the_last_reference
		in_the_bibliography.__Should_probably_start_with_<NL>.
M.C Reference_Bibliography_SeparatorText_between_references_in_the_bibliography.
		The_exact_point_records_are_broken_up_is_at_the_beginning
		of_the_line_that_a_search_for_this_text_would_leave_the_
		pointer.
M.C Reference_Auto_TextText_preceding_filename_to_yank_references_from.__
		Must_be_on_the_same_line_as_the_last_character_of_the_
		text_in_q$Reference_Bibliography_Begin$
M.C Renumber_References_Default_OptionsOptions_to_use_if_not_specified_in
		file
M.C Section_Search_Pass_1Contains_macro_to_move_pointer_to_the_start
	                  of_a_section_to_renumber_on_1st_pass
M.C Section_Search_Pass_2Contains_macro_to_move_pointer_to_the_start
	                  of_a_section_to_renumber_on_2nd_pass
M.C Section_Renumber_Pass_11=>actually_do_renumbering_on_the_1st_pass

M.C Equation_Search_Pass_1Contains_macro_to_move_pointer_to_the_start
	                  of_a_equation_to_renumber_on_1st_pass
M.C Equation_Search_Pass_2Contains_macro_to_move_pointer_to_the_start
	                  of_a_equation_to_renumber_on_2nd_pass
M.C Equation_Renumber_Pass_11=>actually_do_renumbering_on_the_1st_pass

M.C Figure_Search_Pass_1Contains_macro_to_move_pointer_to_the_start
	                  of_a_figure_to_renumber_on_1st_pass
M.C Figure_Search_Pass_2Contains_macro_to_move_pointer_to_the_start
	                  of_a_figure_to_renumber_on_2nd_pass
M.C Figure_Renumber_Pass_11=>actually_do_renumbering_on_the_1st_pass


M.C Table_Search_Pass_1Contains_macro_to_move_pointer_to_the_start
	                  of_a_table_to_renumber_on_1st_pass
M.C Table_Search_Pass_2Contains_macro_to_move_pointer_to_the_start
	                  of_a_table_to_renumber_on_2nd_pass
M.C Table_Renumber_Pass_11=>actually_do_renumbering_on_the_1st_pass

M.C Reference_Search_MacroSearch_macro_for_next_reference
M.C Reference_Sort_MacroSort_macro_to_run_when_finished_renumbering_
			  a_group_of_references._This_macro_is_run_
			  by_Reference_Search_Macro_by_doing_m0
M.C Reference_Bibliography_Sort_MacroSort_to_do_on_bibliography.

!*********** Variables used by all macros******!
0 M.V Renumber_Draft_Mode	!* default is draft mode!
				!* this is complemented below!
1 M.V Renumber_Whole_File	!* ignore narrowing is default!
:i*.- M.V Renumber_Section_Separators
:i*.    M.V Renumber_Section_Default_Separator

m(m.m Renumber_Complement_Draft_Mode)    !* Print the current mode!


!*********** Variables used by Sections **************************!

:@i*/
!* The first pass of renumber sections does the following:
    If qs#-1, this is the second time we are called so return 0.
    This is because there will only be ONE section number in each section 
        to be renumbered on the first pass.
    If qo contains the null string, set qo to qn
        and set qt to qn without the . at the end.
        This is so when narrow, the first non-null section
	won't be renumbered.  Also, sections after a null
	section won't be renumbered. Return -1.
    Count the number of dots in n and o.
    Insert the old number in scratch buffer.
    If old number has x more dots (x can be pos, neg, or zero),
       move back (x+2) periods from the end of the buffer.
    Move over dot.
    Convert number to the right of the dot to a number.
    Replace this number with 1+<this number>
    Insert in qt the whole buffer.  Add a . on the end.
    Insert in qo the whole buffer.
    qu contains the starting location of the section number;
       any asterisk flag has been skipped over. 
       Move pointer here.

    Return -1.

The net effect of all this is that sections are renumbered
the way you think they should be (on the basis of the previous
section number and the number of .'s in the new number)
and .'s at the end
are conserved since a dot at the end isn't significant and 
the table doesn't contain .'s at the end of the values.
Hence, % Section 2.1. will go to, say, Section 1.1.
and    % Section 2.1  will go to, say, Section 1.1
!

qs+1"n				!* second time called!
    0				!* so don't do table lookup!
    '
fqn"e qnuo 0'			!* if current chapt null, accept & do nothing!
				!* (don't enter in table)!

qd"e				!* does current section start with letter?!
    :io			!* set old chapter to null since can't !
				!* renumber based on a letter!
    0				!* we aren't going to change anything,!
				!* so don't bother putting in table.!
    '
fqo"e				!* does qo contain null?!
    qnuo			!* accept current chapter!
    0,fqn-1:gn ut		!* strip separator at end and put in qt!
    quj -1			!* return!
    '
0[1 0[2				!* scratch q-reg!
qRenumber_Section_Separators[3!* load in dot and dash!
qb[..o				!* get scratch buffer created!
hk				!* before & Renumber Text called!
gn				!* insert new number!
j<s3;%2>			!* count number of dots!
hk go				!* insert old number!
j<s3;%1>			!* count number of dots!
q1-q2+2u2			!* q2 is number of periods to move back!
-q2f"l :s3"e j '"#c''	!* Move back if x+2 is positive!
   				!* Moving to start if too big!

.u2
\+1u1

q2j k				!* move back to start of number!
				!* and kill all old text!
:g1 u1				!* convert to text!
g1				!* insert number!
hxt				!* new num in qt!
i.hxo				!* insert a dot and put in qo!
]..o				!* restore user buffer!
]3]2]1				!* and scratch regs!
quj -1			!* return -1 with ptr at sec num!
/M.V Section_Search_Pass_1

1 M.V  Section_Renumber_Pass_1	    !* renumber on pass 1 since!
				    !* section headings are!
				    !* chopped off (by fs boundaries)!
				    !* on 2nd pass!

:@i*/
1f[bothcase			!* ignore case !
!srchsect!
:ssection"e'			!* search for next section!
				!* don't search for appendix since!
				!* these are user re-lettered.!
s
_				!* search for first significant char!
				!* don't just search for a digit.!
r3 :fb"e			!* is a digit the 1st-3rd char?!
   o srchsect			!* no.  try again.!
   '
fkc				!* move back to the start of the num!
1 :fb*			!* move over asterisk if any!
-1				!* return that we found one!

/ M.V  Section_Search_Pass_2

!*********** Variables used by Figures **************************!
:i*
_-- M.V Renumber_Whitespace

:@i*/
qRenumber_Whitespace[1	!* allow Fig. A-1 and Fig. A-2--A-2!
				!* by searching back for whitespace!
				!* after found digit.!
qs+1"n8 :fb"l		!* is there a digit nearby?!
 	    o getnum		!* yes.  this is valid.!
	    '			   
     '
!tryagain!
:sfFig.fFigurefFigs."l   !* Figures also will generate a new fig.!
    5 :fb"e o tryagain'	!* if not a digit nearby, look again!
				!* now move to the start of this number!
!getnum!
    .				!* save end of first digit!
    -s1fkc			!* move after a delimiter!
    :-.-3"g o tryagain'	!* if had to move more than three chars!
				!* go find another likely candidate!
    '

/ M.V Figure_Search_Pass_1

1 M.V  Figure_Renumber_Pass_1

:@i*/
qRenumber_Whitespace[1	!* allow Fig. A-1 and Fig. A-2--A-2!
				!* by searching back for whitespace!
				!* after found digit.!
qs+1"n8 :fb"l		!* is there a digit nearby?!
 	    o getnum		!* yes.  this is valid.!
	    '			   
     '
!tryagain!
:sfFig.fFigurefFigs."l   !* fFigures also will generate a table srch!
    qRenumber_Draft_Mode"e	!* if final mode, !
       fkcdfkrr        		!* delete the f!
       '

    5 :fb"e o tryagain'	!* if not a digit nearby, look again!
				!* now move to the start of this number!
!getnum!
    .				!* save end of first digit!
    -s1fkc			!* move after a delimiter!
    :-.-3"g o tryagain'	!* if had to move more than three chars!
				!* go find another likely candidate!
    '

/ M.V  Figure_Search_Pass_2

!*********** Variables used by Tables **************************!
:@i*/
qRenumber_Whitespace[1	!* allow Fig. A-1 and Fig. A-2--A-2!
				!* by searching back for whitespace!
				!* after found digit.!
qs+1"n8 :fb"l		!* is there a digit nearby?!
 	    o getnum		!* yes.  this is valid.!
	    '			   
     '
!tryagain!
:sfTable"l			!* Tables also will generate a new table!
    5 :fb"e o tryagain'	!* if not a digit nearby, look again!
				!* now move to the start of this number!
!getnum!
    .				!* save end of first digit!
    -s1fkc			!* move after a delimiter!
    :-.-3"g o tryagain'	!* if had to move more than three chars!
				!* go find another likely candidate!
    '

/ M.V Table_Search_Pass_1

1 M.V  Table_Renumber_Pass_1

:@i*/
qRenumber_Whitespace[1	!* allow Fig. A-1 and Fig. A-2--A-2!
				!* by searching back for whitespace!
				!* after found digit.!
qs+1"n8 :fb"l		!* is there a digit nearby?!
 	    o getnum		!* yes.  this is valid.!
	    '			   
     '
!tryagain!
:sfTable"l			!* fTables also will generate a table srch!
    qRenumber_Draft_Mode"e	!* if final mode, !
       fkcdfkrr        		!* delete the f!
       '

    5 :fb"e o tryagain'	!* if not a digit nearby, look again!
				!* now move to the start of this number!
!getnum!
    .				!* save end of first digit!
    -s1fkc			!* move after a delimiter!
    :-.-3"g o tryagain'	!* if had to move more than three chars!
				!* go find another likely candidate!
    '

/ M.V  Table_Search_Pass_2


!*********** Variables used by References **************************!
0 M.V Renumber_References_Default_Options
				!* default is renumber in order of appearance,!
				!* and change all names to numbers!
:i*REF_TABLE M.V Reference_Output_Filename
:@i*/
[t				!* DON'T PUSH QS.  NEEDED for return!
qs+1"eofindnxt'		!* If just starting out!
.,.+1:fb]"l			!* If all refs in this group have numbers, !
  				!* run macro in q$Reference Sort Macro$  !
				!* to sort and put dash between!
				!* consecutive nums!
   .-1ut			!* save end of refs in qt!
   -s[c.us			!* save start of qs!
   qs-qt"e ofindnxt'		!* if null reference, go find next reference!
   1a"a ofindnxt'		!* if alphabetic "renumbering", don't sort!
   .,qt:fb,"l			!* is there more than 1 reference?!
	 m0			!* yes. call sort macro!
	 '
				!* no else clause.  If only 1 ref save time!
				!* and don't do anything!
!* Chapter number processing !
				!* Since was 1 or more refs, insert chapter!
   fqn"e o findnxt'		!* if no chapter number, skip this junk!
   qsj				!* move to start of group!
				!* end of group has changed (qt)!
   s]r 			!* ptr at end of group!
   f[vz			!* save vz!
   b,.fs boundaries		!* delete everything after the last ref!
   qsj				!* move to start of group!
 !inschap!
   gn				!* insert chapter number!
   .,z:fb,"l			!* is there another number? !
         sr		!* yes.  Move to the start!
	 o inschap		!* insert chapter number!
	 '
   f]vz			!* restore boundaries!

   ofindnxt			!* Look for nxt ref!
   '
.,.+1:fb,"l			!* is the next char a comma?!
   sr.us			!* save location of start of next ref in qs!
				!* note that on subsequent refs, test for!
				!* first char being a letter is not made!
!findend!
   s,]r			!* move ptr to end of name!
   				!* return!
   '
!findnxt!
:s_[
["l				!* find <sp>[ or <nl>[ !
  1a"a				!* is the next char a letter? !
     .us			!* save location of start of ref!
!* Now we must verify that before each <sp> or <nl> is a comma, 
     a <sp>, or an <nl>, i.e., that there is a comma after 
     every word (this is a rough effective meaning)              !
     f[vbwf[vz		!* save bounds !
     s]r			!* find end of refs!
     qs,.fs boundaries		!* narrow region!
     j<s_
;fkc1r				!* move to character before <sp>!
				!* or <nl>.  Explicit arg to r is!
				!* necessary .!
     1 :fb_,
"l
          c			!* skip over this char!
	  '"#			!* and continue scanning!
	  f]vzwf]vb		!* this wasn't a reference list!
	  ofindnxt
	  '
     >
     j				!* move to start of name!
     f]vzwf]vb		!* this really was a proper ref list!
     ofindend			!* find end of name and return!
     '
   ofindnxt			!* not a reference.  try again.!
   '

/ M.V Reference_Search_Macro!* Search macro for next reference!

:@i*/
!*  sort the numbers between the  [ .. ].  This sort is done before!
!*  any chapter numbers are inserted into the list.                !
[s[t[u[v
f[vbwf[vz			!* save bounds started with!
qs,qt fs boundaries		!* narrow size to just num list !
!* Now make all records identical by inserting <sp> at beginning 
   and , at the end !
ji_zji,
s$r\s,$		!* sort between the [ ]!
js				!* find first digit!
b,.-1k zjrd			!* delete excess space inserted !
				!* and any additional space sorted!
				!* to the beginning!
!* Now replace consecutive numbers with the value of q$Reference Dash$ !
				!* qs=starting number of consecutive series!
				!* qt=location of end of number in qs!
				!* qu=comma counter!
				!* qv=a number in series!
j
!newstart!			!* new starting digit found!
s				!* find next digit!
r\us				!* put a possible starting number in qs!
.ut				!* save location of end of this number!
0uu				!* zero comma counter!
!nxtnum!
:s,"l				!* search for next digit!
   sr			!* get start of next number!
   \-qs-%u"g			!* are the numbers consecutive? !
        qu-2"g			!* nope.  were there more than two commas?!
	    qt,qvkgReference_Dash	!* yes.  Replace all but 1st and last!
					!* numbers in the series.!
	    s,			!* find next digit!
	    onewstart
	    '"#
	    -s,		!* move back over this number!
	    onewstart		!* this number is a possible start of a sequence!
	    '
        '"#			!* numbers are consecutive!
	-sc			!* go back to start of this number again!
	.uv			!* save in qv!
        onxtnum
	'
'
!* when we reach this point it means we have read the last digit in the group !
%u-2"g				!* is last digit the 3rd or more in a series? !
    qt,qvkgReference_Dash	!* yes.  Replace all but 1st and last!
				!* numbers in the series.!
    '
f]vzwf]vb			!* expand boundaries !

/ M.V Reference_Sort_Macro!* Sort macro to run when finished renumbering
a group of references. This macro is run by Reference Search Macro by doing
m0!

:@i*/
[s[t[u
qReference_Bibliography_Beginus	!* Put text in qs!
qReference_Bibliography_Endut	!* string so ends up on \vfill line!
qReference_Bibliography_Separatoruu	!* separating string!
-ssfkc wsu
0l				!* start of first sort record !
.us				!* save in qreg s!
:st"e!"!FT t_missing.__Can't_preform_sort.
'				!* print error if no \vfill!
0l				!* \vfill indicates end !
f[vbwf[vz			!* save boundaries!
qs,.fs boundaries	        !* narrow sort region !

!* Now we must determine whether he wants an alphabetic sort,
   or a numeric sort.  If qo&4=1, he wants an alpha sort !
qo&4"e
  s[n$			!* sort numerically!
				!* skip over chapter number if any!
  \:su$"l 0l'"#zj'	!* search for start of record string!
				!* and move to beginning if found!
				!* otherwise, terminate sort!
  '"#
  s[$s]$r			!* alphabetic sort!
    :su$"l 0l'"#zj'	!* search for start of record string!
				!* and move to beginning if found!
				!* otherwise, terminate sort!
  '


j				!* now delete unusued refs which have!
				!* risen to the top!
qo&4"e
  s[n]0l			!* find start of first reference!
				!* [1] may be missing, but one of 1-9!
  '"#				!* should be there !
  s[]0l			!* first non [] is ref!
  '

b,.k				!* delete unreferenced references!
				!* check if any refs missing!
j 0us				!* reference counter!
qo&4"n				!* if alphabetic, just compare!
    <su;%s>		!* total # of records and ref count!
    qs+2-qc f"g			!* qs+1=qc-1=total # refs!
       ft Incomplete_deletion.__Do_:BUG_RENUM_and_give_filename.
       '"l
       ft You_are_missing_qc-qs-2:= ft_references.__Subtract_4_from_option_
          and_retry_to_list_which_are_missing.
	  
       '
     				!* return to caller!
     '
!* If we got here, we can numerically find which are missing !
<s[n;\ut			!* get reference number !
!testnum!
%s-qt"l					!* consecutive?!
    ft Missing_reference_nqs=	!* type error message !
    o testnum
    '
>

!*  We have just finished testing for consecutive.  Now see if 
    missing any references after the last one!

qc-1-qs"n
    ft Missing_qc-1-qs:= ft_references_at_the_end_of_the_bibliography.
    				!* type error message !
    '

/ M.V Reference_Bibliography_Sort_Macro!* Sort to do on bibliography near EOF!
!******************************************************************
   	FORMATTER DEPENDENT DEFINITIONS
******************************************************************!

f~Renumber_Text_Formattertex"e	!* Is formatter TEX?!

!*********** Variables used by Figures, Tables, and Equations******!
:i*%_Section_M.V   Renumber_New_Section

!*********** Variables used by Equations **************************!
:@i*/:s\eqno((/ M.V Equation_Search_Pass_1

1 M.V  Equation_Renumber_Pass_1

:@i*/
qRenumber_Whitespace[1	
[s
!loop! :s("l		   	!* Find next likely equation!
  .us				!* Save location after (!
  3 :fb"e			!* digit nearby?!
	o loop'		!* nope.!
  -s1fkcc			!* search for whitesp and move over (!
  .-qs"n qsj o loop'		!* if whitesp didn't precede equation!
				!* try again!
  1a"d '
  1a"a '			!* Make sure digit or letter after (!
  o loop			!* Didn't meet all tests.!
  '

/ M.V  Equation_Search_Pass_2

!*********** Variables used by References **************************!
:i*-- M.V Reference_Dash

:i*
\references M.V Reference_Bibliography_Begin

:i*
\vfill M.V Reference_Bibliography_End
:i*
\ M.V Reference_Bibliography_Separator

:i*from_file_ M.V Reference_Auto_Text

:i*
%_ChapterM.V   Renumber_New_Chapter

'				!* this is end of TEX conditional!
!**************** END OF TEX VARIABLES **********************!
0@fo..QRENUM_Setup_Hookf"n[1 m1 w]1'	!* run customization macro if any!
				!* note that when the library is loaded,!
				!* fs d file is pushed so we can't change!
				!* it unless we do a ..N bit!
!********************** TEMPORARY STATISTICS GATHERING ************!
fs os teco"e			!* on ITS?!
  [1[2
    
  FS XUNAME:F6 u1
  FS UNAME:F6  u2
  f~1sk"n			!* if user isn't me, send me mail!

    0[..f			!* disable auto save!
    e[  e\			!* push input and output channel!
    fn e^ e]			!* set to pop on return!
    f[dfile			!* save default file!
    [buffer_filenames		!* save current buffer name!
    f[bbind			!* get a temp buffer!
    
    
    iFROM-PROGRAM:Emacs_Renumber
    FROM-XUNAME:1
    FROM-UNAME:2
    RCPT:(SK_MC)
    SUBJECT:Automatic_Renumber_Usage_Report
    TEXT;-1
    I_used_your_Renumber_Package.
    
    ew.MAIL.;eeMAIL_>
    '
  '


!& Renumber Text:! !S Routine used to renumber sections, equations, figures, and tables.


The Renumber Text routine is a two-pass routine.  On the first pass,
all the defined equation numbers and the new numbers are stored in a
table.  On the second pass, any equation references are looked up and
given the corresponding number in the table. If Renumber <type> Pass 1
is 1, renumbering is also done on the first pass.!

!*
This routine was orginally written just to do equations, then generalized.  The
comments are left as they were.  Hence, "equation" can be replaced by
"figure" or "table".

The q-regs should be loaded with the right things before this
routine is called.

q0: Text identifying a new section.
q1: Commands to bring ptr to the start of the next "number" to renumber 
   (or merely store in table) on the first pass.  The pointer is either
   at the start of the section after the section number
   (iff qs=-1) or at the end of the significant
   portion of the last number processed.
   If no next number, return 0 so ; will work.  Loading this q-reg with
   0^\ will effectively nullify the pass.
q3: Contains a number.  0 means don't actually do any renumbering on the first
   pass.  Just build up the table.  1 means to renumber everything 
   found by the commands in q1.
q4: Commands to bring ptr to the start of the next "number" to renumber 
   on the SECOND pass through the buffer.  The pointer is either
   at the start of the buffer (iff qs=-1) or at the end of the significant
   portion of the last number processed.
   If no next number, return 0 so ; will work.  Loading this q-reg with
   0^\ will effectively nullify the pass.
!
qRenumber_Whole_File"g
   f[vbw f[vz			!* save user's window!
   0,fsz fs boundaries	!* ignore user narrowing!
   z,z-1000:fbLocal_Modes:"l	!* Search bkwards for local modes!
          0,.fs boundaries	!* Don't process Local modes at end!
	  '			!* or search rules might goof if he!
				!* is customizing RENUM search rules!
   '
[a[c 1[d [e[n[o[s[t[u[z	        !* push some q-regs on stack!
				!* qb is reserved for a scratch!
				!* buffer created by renumber sections!
				!* only!
				!* qc=equation counter!
				!* qd=0 if section number starts with letter!
				!* qe=1 if no asterisk preceding section!
				!*       (meaning EXPLICIT renumbering)!
				!* qn=section number !
				!* qo=old section number (used by renumber!
				!*    sections.  Note that qn and qo always!
				!*    end with a . if they are non-null and!
				!*    non-alphabetic!
				!* qz=equation table!
				!* qs,qt=misc.!
				!* qu=start of section number!
				!* qa=holds equation number to search for!
				!*    and the renumbered equation num after!
				!*    searching the table!
0[..F				!* don't do any auto-saving till done!
[..D				!* Save delim dispatch!	   
0f[s error			!* So ; inside iteration doesn't give error!
0f[bothcase			!* So misfigure doesn't create a figure!
f[vz				!* Save end of window.  This should be the!
				!* last thing pushed.!
j240,32i50,65i350,32i
j.,.+640fx..d			!* Set up ..d so ^b matches non-# !
:in				!* Default section number is null!
:io
5 fs q vectoruz		!* Make a q-vector!
3u:z(0)			!* M.C uses three words per table entry!


!* Now, for convenience, we will only work on on section at a time
    so we don't have to keep checking to see if he defined a new section.
    To do this, only work on text up to the next % section definition.
    When done, yank in the text up to the next % section definition.
!
!nxtsection!
1uc				!* initialize equation ctr!
.us				!* Save start of the current section!
				!* Ptr is now just after the section num!
:s0"l 			!* Search for the next section number!
				!* If next section number found,!
  s_r			!* Section number starts with non-blank!
  b,.fs boundaries		!* Only work on one section at a time!
				!* Note we didn't push vz since only!
				!* interested in original vz!
  qsj				!* Move back to the start of the!
				!* current section.!

'
:gc u t				!* convert number in qc to string in qt!
:i* n t ut			!* Put next <section> <counter> number in qt!
-1us				!* Flag so m1 knows an equation!
				!* hasn't been found on this pass yet!
<m1;				!* Get next equation!
.uu				!* save start of equation!

1a"a c'				!* if section begins with a letter is ok!
				!* don't want to lose on % Section A!
				!* and equ. (A.1) !

s				!* Find end of equation!
qu,.-2xa			!* Copy significant part of <num> into a!

!* Now whenever we look up a number, it must be the complete
   number of the equation.  However, we allow him not to specify
   the section number if in the current section.  If qa has
   no .'s, then it is a local reference and we need to tack on
   the section number before doing the lookup!

!* If called from Renumber Sections, never tack on a section number.
   The user must always supply the complete number.!

!* Rule is that the section number is tacked on if the number
   contains ONLY digits !

qd*(qSection_Search_Pass_1-q1)"n
   .				!* push .!
   qu,.-2:fb"e		!* If no non-digits found !
       :isna		!* tack on section number!
       '"#
       			!* restore pointer before it moved!
       qaus			!* qs contains the thing to lookup!
       '
   '"#
   qaus				!* load qs with thing to look up!
   '


!* If the <number> isn't in the table, add it.  Set qa to the
   looked up value if q3>0.  Otherwise, don't change qa.  
   If it wasn't in the table, bump the counter !

qz[..Q				!* Put table in ..Q !
qt M.C sus			!* If variable exists, return value in qs!
				!* If it doesn't, set it to <section><counter>!
]..Q				!* Restore ..q for user macro!
f=st"e			!* Was the variable in the table? !
     %c				!* No.  Bump counter.!
    :gc u t			!* convert number in qc to string in qt!
    :i* n t ut		!* Put next <section> <counter> number in qt!
     '
q3"g				!* q3>0  ? !
     qsua			!* yes.  renumber on 1st pass.!
     qe"e			!* if qe=0, strip the section number!
				!* if it is the current section!
       f=an-1-fqn"e		!* do all the characters in qn match?!
           fqn,fqa:ga ua	!* yes. strip the section number !
	   '
       '
  !* Don't make replacement unless we have to--Compare first!

     qu,.-2f=a"n
        qu,.-2k			!* delete number!
        ga			!* put number in buffer!
	'
     '
>

!* This completes the first pass through the n-th section.
  Now get next section and do the same thing again!
zj
fsvzus				!* Put the current vz value in qs!
f]vz				!* Pop saved value.  Widen window as far as it !
				!* was initially.!

fsvz-qs"l			!* end of buffer? !
  f[vz				!* Nope.  Put on stack again!
  1a-42"e			!* If asterisk, !
       c			!* skip over asterisk!
     qRenumber_Draft_Mode-1"e	!* if in draft mode!
       1ue			!* ignore asterisk flag!
       '"#
       0ue			!* if in final print, asterisk means!
				!* use implicit renumbering!
       '
     '"#1ue'			!* no asterisk.  Use explicit.!
  .uu				!* save beginning of section number!
				!* (used also by renumber sections)!
  1a"a c 0ud'"# 1ud'		!* if first char alphabetic, ok.!
				!* set flag to assume explicit input!
				!* in this section (also used by!
				!* first pass of renumber sections)!
  fb			!* two non-digits is end of section num!
  fkc
  [d				!* in case separator there, can use!
				!* this as a temporary flag!
  qRenumber_Section_Separators[1	!* scratch q-reg!
  1 :fb1"l  0ud'		!* was char after last digit a separator?!
				!* if yes, keep it.!
				!* set flag temporarily not to insert!
				!* default separator!
  ]1
  qu,.xn			!* Place section number in qn!

  qd*fqn"g
       qRenumber_Section_Default_Separator[2	!* scratch q-reg!
       :inn2 		!* Section number always has period at end!
				!* unless null or first char alphabetic!
				!* or separator was given!
       ]2
       '
  ]d
  onxtsection			!* go process this section!
'

!******************************************************************
This completes the first pass through the file.  Table of
<oldnum><newnum> is now built up.

Begin second pass.  Any string of the form in m4
will be looked up in the table in qz.  Second pass must
be by section also in order to do the explicit, implicit
numbering correctly.
******************************************************************!
fqz-5"e j w'			!* If table empty, don't do 2nd pass!
j
f[vz				!* Save end of window started with!
!nxt2section!

.us				!* Save start of the current section!
				!* Ptr is now just after the section num!
:s0"l 			!* Search for the next section number!
				!* If next section number found,!
  s_r			!* Section number starts with non-blank!
  b,.fs boundaries		!* Only work on one section at a time!
				!* Note we didn't push vz since only!
				!* interested in original vz!
  qsj				!* Move back to the start of the!
				!* current section.!

'
-1us				!* Flag so m4 knows an equation!
				!* hasn't been found on this pass yet!
<m4;				!* Find next likely equation!
.uu				!* save start of equation!

1a"a c'				!* if section begins with a letter is ok!
				!* don't want to lose on % Section A!
				!* and equ. (A.1) !

s				!* Find end of equation!
qu,.-2xa			!* Copy significant part of <num> into a!

!* Now whenever we look up a number, it must be the complete
   number of the equation.  However, we allow him not to specify
   the section number if in the current section.  If qa has
   no .'s, then it is a local reference and we need to tack on
   the section number before doing the lookup!

!* If called from Renumber Sections, never tack on a section number.
   The user must always supply the complete number.!

!* Rule is that the section number is tacked on if the number
   contains ONLY digits !

qd*(qSection_Search_Pass_1-q1)"n
   .				!* push .!
   qu,.-2:fb"e		!* If no non-digits found !
       :isna		!* tack on section number!
       '"#
       			!* restore pointer before it moved!
       qaus			!* qs contains the thing to lookup!
       '
   '"#
   qaus				!* load qs with thing to look up!
   '


!* Set qa to the looked up value if any.  Otherwise, don't change qa.  !


0@foz sus			!* If variable exists, return value in qs!
				!* If it doesn't, return 0!

qs"n				!* Did variable exist? !
  qsua				!* yes.  Renumber.!
  qe"e  			!* if qe=0, strip the section number!
			        !* if it is the current section!
    f=an-1-fqn"e		!* do all the characters in qn match?!
	fqn,fqa:ga ua	        !* yes. strip the section number !
	'
    '
  !* Don't make replacement unless we have to--Compare first!

  qu,.-2f=a"n
     qu,.-2k			!* delete number!
     ga				!* put number in buffer!
     '
  '"#				!* no. print error message.!
  ft
Lookup_on_a_failed_during_2nd_pass.__Not_changed._Line_is:
0tt			!* type line not changed !
  '


>
!* This completes the second pass through the n-th section.
  Now get next section and do the same thing again!
zj
fsvzus				!* Put the current vz value in qs!
f]vz				!* Pop saved value.  Widen window as far as it !
				!* was initially.!

fsvz-qs"l			!* end of buffer? !
  f[vz				!* Nope.  Put on stack again!
  1a-42"e			!* If asterisk, !
       c			!* skip over asterisk!
     qRenumber_Draft_Mode-1"e	!* if in draft mode!
       1ue			!* ignore asterisk flag!
       '"#
       0ue			!* if in final print, asterisk means!
				!* use implicit renumbering!
       '
     '"#1ue'			!* no asterisk.  Use explicit.!
  .uu				!* save beginning of section number!
				!* (used also by renumber sections)!

  1a"a c 0ud'"# 1ud'		!* if first char alphabetic, ok.!
  fb			!* two non-digits is end of section num!
  fkc
  [d				!* in case separator there, can use!
				!* this as a temporary flag!
  qRenumber_Section_Separators[1	!* scratch q-reg!
  1 :fb1"l 0ud'		!* was char after last digit a separator?!
				!* if yes, keep it.!
				!* set flag temporarily not to insert!
				!* default separator!
  ]1
  qu,.xn			!* Place section number in qn!

  qd*fqn"g
       qRenumber_Section_Default_Separator[2	!* scratch q-reg!
       :inn2 		!* Section number always has period at end!
				!* unless null or first char alphabetic!
				!* or separator was given!
       ]2
       '
  ]d
  onxt2section			!* go process this section!
'
j				!* end.  pointer at start.!

!Renumber All:! !C Runs the Renumber routines for references, sections, equations, figures and tables.

For details, see the RENUM node in the INFO program.

Runs:

Renumber Sections
Renumber Equations
Renumber Figures
Renumber Tables
Renumber References

Any argument is passed to Renumber References (1 means write REF TABLE file).

!
m(m.m Renumber_Sections)
m(m.m Renumber_Equations)
m(m.m Renumber_Figures)
m(m.m Renumber_Tables)
m(m.m Renumber_References)

!Renumber Complement Draft Mode:! !C Toggles the value of qRenumber Draft Mode

You will always win in draft mode and can run the all the macros
to your heart's content.

The draft mode is used to renumber the working
manuscript---bibliographic renumbering is not done, implicit section
numbering will not be processed, and text signifying forward
referencing is preserved.  The final mode can be used before printing
the final paper or before printing each draft.  The file should be
deleted after running through the text formatter as forward
referencing is lost, bibliographic referencing becomes next to
impossible, and you will no longer be able to move things without loss
of information if you have used implicit numbering.

You are initially in draft mode (qRenumber Draft Mode is 1).

For more info, see the DRAFT node of the RENUM node in the INFO
program.

!

qRenumber_Text_Formatter[1	!* put formatter name in q1!
qRenumber_Draft_Mode-1  uRenumber_Draft_Mode
qRenumber_Draft_Mode"e	!* if final print mode, do!
    QBuffer_Filenames"E o typemode'
    FS Modified"N
    @FT
    Save_your_source_changes_before_RENUM_processing
    1m(m.m&_Yes_or_No)"n
    1m(m.m^R_Save_File)''
    etFOO_>			!* set default filename!
    0uBuffer_Filenames
    0u:.b(qBuffer_Index+2)
    m(m.m&_Set_Mode_Line)
    !typemode!
    @ft
FINAL_PRINT_MODE_(1)
     '"#
     @ft
DRAFT_MODE_(1)
     '
0fs echo active		!* so new mode stays around a bit!



!Renumber Sections:! !C Renumbers sections in order of definition and references to a section.

First pass scan:       "% Section "    (case is significant)
Second pass:             "section"     (case is ignored)

Examples:
	\majorsection 2.3 Overview     % Section 2.3

        ... we saw in section 1.2 that ...

In the first example, the 2.3 before the "Overview" gets
numbered on the 2nd pass.  The result is that the two
numerical values on this line always coincide, no matter
where in the file this section is moved to.

All numbers referring to a section (NOT an equation, etc.
WITHIN a section) must be typed completely (no implicit
mode).  Sections are renumbered with attention paid to . and
- (q$Renumber Section Separators$) conservation.  In other
words, it renumbers things the way you would by hand.

Specifically, it counts the number of index separators (. or
-) in the next section and the section just renumbered (an
index separator is always assumed at the end of a number
even if not explicitly typed).  If they are the same, then
the last index of the previous number is bumped.  If the new
section contains more dots, a ".1" is suffixed to the
previous number.  If the new number contains less dots, the
macro moves back that many more indices, bumps the number
that is there, and clears the line while preserving the
default separator the user specified.

Examples:

         Old Sequence         Renumbered Sequence
	---------------      ---------------------

         1.2-			1.2-
	 3.5			1.3
	 6-2.1			1.3.1
	 3.			2.			
	 5-			3-
	 5.5			3-1

If you wish to have a particular section number accepted 
at face value, just precede it by a null section number.  This
is useful if you like to skip from say 2.6 to 3.1 instead of to 3.

Section numbers beginning with an alphabetic character will not
be re-lettered.  After the first character, two non-digits signal 
the end of the section name (number) as usual.  If a numbered
section appears after a lettered section, it will not get renumbered.
This is because sections are renumbered based on the last section
and if the last section was alphabetic, there are no guidelines.
This tends to be a useful feature if you have sections missing
and want your sections renumbered as you specify.  Simply insert
a % Section will a null section number before the % Section statement
which you want accepted as is.

If you don't have a dot or a dash after the last digit in section
definition line, a dot (q$Renumber Section Default Separator$) 
is used for separation when you run the renumber macros for
equations, figures, and tables.  To refer to something in 
another section, you must specify that section exactly:
1.2-1 is NOT the same as 1.2.1.  Of course, text after the
last digit is ignored so 1.2.1xx can refer to % Section 1.2.1-.

SUBTLE POINT: If you are a real hacker, you will wonder how renumbering
can be done on pass 1 since the scan rules of the second pass are a 
subset of the scan rules of the first pass.  The reason is that
when the file is processed section by section, it is broken off
after the word "Section" in the "% Section" statement. Hence, during
the second pass, the "Section" at the end of the current boundaries
doesn't meet the scan rules since there are no digits after the word
"section"--there is nothing

For details, see the RENUM node in the INFO program.!

[b[0[1[2[3[4			!* Push q-regs!
fsb consub			!* scratch buffer in qb!
qRenumber_New_Section@fo..QRenumber_Section_New_Sectionu0    
				!* Use default unless variable exists!
qSection_Search_Pass_1u1
qSection_Renumber_Pass_1u3
qSection_Search_Pass_2u4
m(m.m &_Renumber_Text)
qb fs b kill			!* kill buffer!


!Renumber Equations:! !C Renumbers equations in order of definition.

First pass scan:

  "\eqno(" or "("         (case is significant)

   (The "(" is provided for people who use \eqalignno).

Second pass scan:

  "(" with a digit within the next 3 characters.  The ( must
   be preceded by a <sp>, <nl> or -- (which is the contents of
   qRenumber Whitespace) and immediately followed by a letter
   or a digit.

For a little bit more info, do MM DescribeRenumber Figures

For gory details, see the RENUM node in the INFO program.
!

!*This routine works by loading q-regs 0 thru 4 with the
values of the variables Renumber Equations Arg 0 ... Arg 4,
and then calling & Renumber Text!
[0[1[2[3[4			!* Push q-regs!

qRenumber_New_Section@fo..QRenumber_Equation_New_Sectionu0    
				!* Use default unless variable exists!
qEquation_Search_Pass_1u1
qEquation_Renumber_Pass_1u3
qEquation_Search_Pass_2u4
m(m.m &_Renumber_Text)


!Renumber Figures:! !C Renumbers figures in order of definition.

How a "figure" to be renumbered is recognized.

First pass scan:

   Examples are:  
       xxxFig.  A-3
       fooFigs. 3, and 4
       Figures 3--4
       \Figure 3, 3.4-4, or C.4-5

Second pass scan:

       Is same as the first pass scan only a lowercase f must
       precede the capital F.  The lower case f is deleted in
       final print mode.

On both passes, case is significant.

Detailed description of first pass scan (the second pass
scan is analogous):

If a digit is within 8 characters of the end of the significant
portion of the last figure renumbered, go GET-DIGIT.

Otherwise, search for anything but "f" preceding
"Fig." or "Figs." or "Figure" and search the next 5
characters for a digit.

GET-DIGIT:  move back to after a delimiter (q$Renumber 
       Whitespace$ which is initially <sp><NL> and --).

The pointer is now at the start of something to be renumbered.
The end is considered to be just before two consectutive non-digits.
This text is looked up in a table and the appropriate things
done on the first or second pass:  on the first pass, the
text is added to the table if not already there; on the second
pass, if a lookup fails, that particular text is left unchanged,
the user is notified, and the scan proceeds normally.

If the text looked up contains only digits, implicit input is
assumed and the current section number is tacked on before doing
the lookup.  The current section number is determined by the text
after "<nl>% Section " (qRenumber New Section) or the
text in qRenumber Equation New Section if this variable exists
(this is true for the figures, tables, and sections renumber macros
if you use Figure, Table, Section respectively in place of Equation).

On output, if the section number of the renumbered text is the same
as the current section number, the section number is stripped only if
1) you are in final print mode 2) an asterisk precedes the current
section number in the section definition line.  If you don't have a
dot or a dash after the last digit in section definition line, a dot
(q$Renumber Section Default Separator$) is used for separation when
you run the renumber macros for equations, figures, and tables.

For more details, see the RENUM node in the INFO program.!

[0[1[2[3[4			!* Push q-regs!
qRenumber_New_Section@fo..QRenumber_Figure_New_Sectionu0    
				!* Use default unless variable exists!
qFigure_Search_Pass_1u1
qFigure_Renumber_Pass_1u3
qFigure_Search_Pass_2u4
m(m.m &_Renumber_Text)


!Renumber Tables:! !C Renumbers tables in order of definition.

See documentation for Renumber Figures.  Scan rules allow
Tables, Table, and the "f" variants of these.

!
[0[1[2[3[4			!* Push q-regs!
qRenumber_New_Section@fo..QRenumber_Table_New_Sectionu0    
				!* Use default unless variable exists!
qTable_Search_Pass_1u1
qTable_Renumber_Pass_1u3
qTable_Search_Pass_2u4
m(m.m &_Renumber_Text)





!Renumber References:! !C Renumbers references in order of definition.

Only works in final print mode (do MM DescribeRenumber Complement
Draft Mode).

Quick summary (detailed description follows):
---------------------------------
References:	      [foo68a, bar80a]   are examples. 

Bibliography start:   <nl>\references

Auto Referencing:    "from file <filename>" appearing on the same
     		      line as the Bibliography start.  In TEX, you
		      will need a % before this text so it isn't 
		      printed.

Bibliography entry:  \ <anything> [<name>] <anything> <nl>

Bibliography End:    <nl>\vfill

Chapter sectioning:  <nl>% Chapter <optional text>

Statistics file:     use 1 MM Renumber All or 1 MM Renumber References.

Options text:	     "Renumber References Options <num>" must appear
		      in the first 1000 characters to over-ride default.

Options bits:	      +1 => Alphabetic instead of order of appearance
		      +2 => Don't replace any text before bibliography
		      +4 => Don't replace any text after bibliography

		      Default setting is 0.

For more details, see the RENUM node in the INFO program.!
!*
A bibliographic reference is determined by the
search string in q$Reference Search Macro$.
which defaults to <sp or cr>[<letter>.  The exact macro should
move the pointer to the end of the name and leave the location
of the start of the name in qs.
q-regs by the macro.  Pointer is at start of file or at end of
last reference renumbered.  Pointer could also be at the
start of the bibliography section since this macro is used there too.
Return 0 if no more references found.  The macro must also
macro q-reg 0 which  performs (if the default q$Reference Sort Macro$
is used)
a sort of the references between [..., ..., ...] if this is desired
(in this case, if the pointer was just before the ] when this macro
is invoked, it means it is time to macro q0).  The sort should also
put in dashes between consecutive numbers if this feature is desired.

At some point in the file there may be a \references 
(the exact text is determined by Reference Bibliography Begin) macro followed
by references followed immediately by \vfill 
(the exact text is determined by Reference Bibliography Sort Macro).
If so, NO REFERENCES CAN BE ADDED AFTER THE \REFERENCES.
Unused references are deleted.

This macro hacks chapter numbers for you.  The asterisk flag 
is insignificant so DON'T specify it.  Either give a number after
the % Chapter statement, or just give a null.



Other variables:

q$Reference Sort Macro$ this macro is loaded into q0 and should be called
		     by the macro in q$Reference Search Macro$ when it is
		     at the end of a group of references.  Convention is
		     qs must be set to the start of the region to sort.
 		     Pointer must be at end of area to sort.  Of course,
		     if the user uses his own values of q$Reference Search
		     Macro$ and of this macro, the convention needn't be 
		     followed.
q$Reference Dash$  referred to by the default Reference Sort Macro.  It
		     contains the text representation of the dash to
		     insert when replacing [1, 2, 3] with [1-3].
q$Reference Bibliography Begin$  contains text to identify start of bibliography
                     that is, the place after which you can't add more refs.
                     This is so when you yank in your giant bibliography file,
                     it will delete any references which haven't 
		     been referenced already.
q$Reference Auto Text$ contains the text that identifies that there is a
		     file to extract the references from.  This text must
		     be on the same line as the text in Reference Bibliography
		     Begin.
q$Reference Bibliography Sort Macro$ contains a macro to perform a sort of
		     the bibliography near the end of the file.  The pointer
		     will be at the end of the last reference in the file
		     when this macro is called.  This macro normally will
		     numerically sort the references section (default is
		     \vfill denote the end of the section) and delete
		     any references with [] (these will all be sorted
		     to the beginning of the bibliography). It should
		     also check for any missing references from the 
		     bibliography.  The first reference should be 1, 
		     and the last should be the the value in qc minus 1.

!
qRenumber_Draft_Mode"g	!* if draft mode, !
		     
		     '		!* don't do anything!

QBuffer_Filenames"n		!* make sure he saves to a different place!
				!* (might have done visit AFTER mode switch!
    etFOO_>			!* set default filename!
    0uBuffer_Filenames
    0u:.b(qBuffer_Index+2)
    m(m.m&_Set_Mode_Line)
    '
qRenumber_Whole_File"g
   f[vbw f[vz
   0,fsz fs boundaries	!* ignore user narrowing!
   '
[0[1[z[c[n[o 0[p [r[s[t[a	!* qz=bibliography table!
				!* q0=reference sort macro!
				!* q1=User macro to get next reference!
				!* qc=references counter!
				!* qn=chapter number to insert!
				!* qo=options specified!
				!* qp=0 if first pass, 1 if 2nd!
				!* qr=hold info table for REF TABLE file !
				!* qs, qt=misc.!
				!* qa=hold reference to look up in table!
				!*    and has number to replace name with!
				!*    after doing the table search!
0[..F				!* don't do any auto-saving till done!
0f[s error			!* So ; inside iteration doesn't give error!
1f[^p case			!* Ignore sort case!
f[vbwf[vz			!* Save his boundaries!
qReference_Sort_Macrou0	!* Put reference sort macro in q0!
qReference_Search_Macrou1	!* Put search macro in q1!

:in				!* initialize chapter number to insert!

-1"e				!* was arg=1? !
  fs b consur			!* create a buffer and put in qr!
  '
!* If he has specified any options for this file within the
   first 1000 characters, set qo to the number.
   Else set qo to q$Renumber_References_Default_Options$.!

j1000 :fb Renumber_References_Options"l
   		s_r \uo	!* put options specified in qo!
		'"#		!* otherwise load from q-reg!
		qRenumber_References_Default_Optionsuo
		'
!* Now, for convenience, we will only work on on chapter at a time
    so we don't have to keep checking to see if he defined a new chapter.
    To do this, only work on text up to the next % Chapter definition.
    When done, change window to the next % Chapter definition.
    If branches to nxtchapter directly, ptr is at beginning of next section !

!* Initialize the bibliographic table.  The first word is the name
   of the author, the second is the number (as a string) to replace it with,
   the third is set to a reference count if arg=1 (ignored otherwise).!

j				!* move to start of buffer!
!nxtchapter!
5 fs q vectoruz		!* Make a q-vector!
3u:z(0)			!* M.C uses three words per table entry!
1uc				!* initialize reference counter!
.us				!* Save start of this section!
qRenumber_New_Chapterut
:st"l 			!* Search for the next chapter number!
				!* If next chapter number found,!
  s_r			!* Chapter number starts with non-blank!
  qs,.fs boundaries		!* Only work on one chapter at a time!
  '
zj
qReference_Bibliography_Beginus
-:ss"l fkcl'       		!* move to line after \references or end!
				!* of buffer if no references!
f[vz				!* Save end of chapter!
b,.fsboundaries		!* only operate on stuff before \references!

:gc u t				!* convert number in qc to string in qt!

!secpass!			!* jump here for second pass through chapter!
-1us				!* Signal to macro in q1 that just started!
j<m1;				!* call the user macro!
qs,.xa				!* Copy just name in qa!
[s
!* If the <reference> is in the table, bump the comment if arg was 1.
If it wasn't in the table add it (counter defaults to zero).!
0@foz aus			!* If variable exists, return value in qs!
				!* If it doesn't, return 0!

qs"n				!* Did variable exist? !
				!* Yes. !
  -1"e qp"e			!* was arg=1?  (create table)!
     [s				!* and first pass !
     :@foz aus		!* yes.  get offset in qs!
     %:z(qs+2)			!* bump # times referred counter!
				!* note: started with 0 in referred ctr!
     ]s
     ''				!* two checks!
  qsua				!*  Renumber.!
  '"#				!* not in table. add it setting comment!
				!* (reference counter) to 1 !
  qz[..Q			!* Put table in ..Q !
  qt M.V aua			!* create table entry and put qt into qa!
  ]..Q				!* Restore ..q for user macro!
  %c				!* No.  Bump counter.!
  :gc u t			!* convert number in qc to string in qt!
  '
]s				!* qs points to start of name!

!* Actually renumber only if the following conditions are met:
1.  qo&2=0   allows renumbering in the text section
2.  (qp=0 and qo&1=0)  OR  (qp=1 and qo&1=1)
    			which says renumber on pass 1 if in order of
			appearance, or on pass 2 if alphabetic.!
qo&2"e
    qp+(qo&1)"n     qp+(qo&1)-2"n o norenum''
    qs,.k ga			!* passed all tests.  Renumber.!
    '
!norenum!
>

!* If the clown wants alphabetic order on refs, we gotta go again after
   fixing up the table in qz.  Otherwise continue.!
qo&1"n qp"e fqz-5"g		!* was alpha on, 1st pass, and qz non-null? !
  %p				!* yes he wants it.  bump pass counter.!
  1uc				!* counter should last ref+1 when done.!

  fqz/5-1us			!* qs contains max offset. !
				!* must not exceed this offset!
  1ut				!* initial offset into table!
  <qt-qs;			!* if offset <= max ,!

     :gc u:z(qt+1)		!* put new text number in table!
     %c				!* bump counter!
     qt+q:z(0)ut		!* get next entry!
   >
   qo&2"e o secpass'		!* do second pass if he allows us to!
				!* change stuff!
   '''				!* there were three tests at the start!
!* We have now searched most of the buffer.  Now search stuff after the
   \references (if any) and don't add to table if it is a new reference. !
fsvzus				!* put current vz in qs!
				!* current vz is just before refs!
f]vz				!* make saved vz the current vz!
				!* we have now widened to the whole!
				!* chapter!
fsvz-qs"e			!* was there a references section? !
   onobiblio			!* no.  skip over bibliography fetch and sort.!
   '
f[vz				!* push the current vz!
				!* i.e, save end of chapter!
qsfs vz			!* set vz so ignore stuff after \references!
				!* i.e., set it back to what it was before!
zj-l				!* get to start of \references line!
qReference_Auto_Textus	!* put text identifying file to extract!
				!* refs from in qs!
:fbs"l			!* search \references line for <from file>!
				!* Yes. Automatically read in references file!
				!* for him!
   s_r			!* find beginning of filename (1st non-blank)!
   .us				!* save start of file name!
   :l				!* ptr at end of file name!
   qs,.fxs			!* put filename in q-reg s and delete !
				!* in case he tries to run the same file again!
   e[				!* push input channel!
   f[dfile			!* save default file!
   ers@a			!* read in references file he wanted!
   				!* we have effectively inserted the references!
				!* file before any references he might have!
   f]dfile			!* pop TECO default ER filename!
   e]				!* pop input channel!
   '

f]vz				!* increase window to whole current chapt!
   
!* Now we are ready to process the part after the \references
     or nothing if no \references.  Don't bump counter for
     references after the \references.
!				
-1us				!* flag indicating 1st time!
<m1;				!* search for a reference!
qs,.xa				!* Put just name in a and delete it!
!* If the <reference> isn't in the table, don't insert anything into the buffer 
      and don't print an error since it was probably a reference from
      the master reference file which isn't being used in this manuscript.
      This deletion of the reference is irregardless of the options. !

0@foz aut			!* If variable exists, return value in qt!
				!* If it doesn't, return 0!

qt"n				!* Did variable exist? !
				!* Yes. !
  qo&4"e			!* bit 2=0 means renumber!
     qs,.k gt			!* renumber!
     '

  '"#
  qs,.k				!* Not in table.  Delete the name!
  '
>


!* Now, if there is a list of references at the end, sort it 
   numerically.  At this point, the boundaries include the whole
   chapter.  The original user's vz is on the top of the stack !

mReference_Bibliography_Sort_Macro

!nobiblio!			!* if no bibliography, jump here!

!* Test the argument.  If arg=1, sort and append to reference table in qr:
select qr as buffer and narrow bounds so fs vb is set to fs vz.
Then put q-vector in qz into the buffer
(alphabetical listing). Also sort sequential name references stored in 
qreg z numerically.  Then store both lists in specified file after all chapters
have been scaned.  !

-1"e	fqz-5"g			!* was arg=1 and qz non-null? !

  qr[..o			!* select our ref table buffer!
  z,z fs boundaries		!* only insert at the end!
				!* now convert qz into the buffer!
  fqz/5-1us			!* qs contains max offset. !
				!* must not exceed this offset!
  1ut				!* initial offset into table!
  <qt-qs;			!* if offset <= max ,!
     3-fq:z(qt+1),32i		!* insert 3-<number of digits> spaces!
     g:z(qt+1)			!* insert the reference number!
     i_			!* insert a space!
     g:z(qt)			!* insert the name!
     17-(fsinslen),1f : *0:  ,32i   !* pad with spaces so 17 long or at!
				!* least one space.  This works by!
				!* extracting post-comma arg!

     q:z(qt+2)+1,46i		!* insert as many .'s as there!
				!* are refs.  This makes nice histogrm.!
				!* addition of 1 is because started with zero.!
     i
     				!* insert cr/lf!
     qt+q:z(0)ut		!* get next entry!
   >
   qo&1"e			!* if renumbered on order of appearance!
       hxt			!* copy into qt!
       s_$r\l		!* sort numerically!
       '   
   ji
   ******************__Chapter_n_****************
   

   Numerical_list_of_references
   
   qo&1"e
       zji
       Alphabetic_list_of_references
         gt			!* grab alphabetic list!
       '
   zji
   
   ]..o				!* restore buffer !
   ''				!* there were two conditionals.!


!* This completes the pass through the n-th chapter.
  Now get next chapter and do the same thing again!
zj
fsvzus				!* Put the current vz value in qs!
f]vz				!* Pop saved value.  Widen window as far as it !
				!* was initially.!

fsvz-qs"l			!* end of buffer? !
  f[vz				!* Nope.  Put on stack again!
  .us				!* save beginning of chapter number!
  fb_
				!* <sp> or <nl> terminates chapter num!
  qs,.+fk xn			!* Place chapter number in qn!
  onxtchapter			!* go process this chapter!
'

!* Now write out a REF TABLE if arg was 1. !

-1"e
    e\				!* push output channel!
    fn e^ 			!* set to pop on return!
    f[dfile			!* save default file!
    [buffer_filenames		!* save current buffer name!
    qr[..o			!* get thing to write in buffer!
    0,fszfs boundaries	!* write out whole table!
    qReference_Output_Filenameu1
    ewee 1			!* write out shit!
    FS B Kill			!* get rid of the evidence!
    '
0,zfs boundaries		!* so pointer will be at start when expand window!
				!* to orginal setting (original fsvb is still on!
				!* the stack !
j				!* pointer at start of buffer!

!*
Local Modes:
Mode:Teco
Comment Column:32
End:
!