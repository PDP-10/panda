!* -*- Teco -*-		Library created/maintained by KMP@MC *!

!~Filename~:! !Macros for hacking text sketches!
SKETCH

!& Setup Sketch Library:! !S Set up this library after load !

0 fo..QLast_Sketch_Namem.vLast_Sketch_Name
0 fo..QLast_Sketch_Library_Namem.vLast_Sketch_Library_Name
m(@:i*|m.m^R_Sketch_Insert_or_Dispatchu...S|fo..QSketch_Setup_Hook)

:i* .[0 [1			    !* q0: Point, q1: Text to insert	!
    g1 +q0j			    !* Get text and set cursor		!
    q0,fq1			    !* Return changed region		!
    fo..QSketch_Insert_Hookm.vSketch_Insert_Hook


!Insert Sketch:! !C Insert a named text sketch!

 ff&2"e			    !* If no precomma arg		!
  fn q..H"n 0u..H @v'  '	    !* Set up to flush typeout		!

m.m&_Insert_Sketch,(:i*Insert) :m(m.m&_Sketch_Prompt)


!& Insert Sketch:! !S Insert a sketch with a given name (numeric arg)!

1,m(m.m &_Find_Sketch)mSketch_Insert_Hook	    !* Insert text	!


!Edit Sketch:! !C Edit a named text sketch!

fn q..H"n 0u..H @v' 		    !* Set up to flush typeout		!

m.m&_Edit_Sketch,(:i*Edit) :m(m.m&_Sketch_Prompt)


!& Edit Sketch:! !S Edit a sketch with a given name (numeric arg)!

[0[1				    !* Temp qregs		!
[..J				    !* Bind Mode line		!
0[..F				    !* Disalbe autosave		!
u0				    !* q0: Sketch name		!
!Retry!
qLast_Sketch_Library_Nameu1	    !* q1: Library name		!
q1"e
 @m(m.mVisit_Sketch_Library)
 oRetry'			    !* Force user to visit lib	!
e[fne]				    !* Bind input stream	!
e\fne^				    !* Bind output stream	!
f[dfile			    !* Bind Teco file defaults	!
f[bbind			    !* Bind a temp buffer	!
er1@y j			    !* Yank input file		!
0f[modifiedw 0f[xmodifiedw	    !* Bind modified flags	!
:s0 
"l		    !* Find sketch		!
 :i..J(Editing_Sketch_"0")!''!
 .,( s r .)fsbound'	    !* Set bounds		!
"# :s:"l zj i '
   g0 i 
 r
   :i..J(Creating_Sketch_"0")!''!
   .,(i~.)fsbound'		    !* Maybe make a place	!
 [C fsosteco"e :iCC ' "# :iCZ '
:i..J..J__"~"_marks_point,_c-m-C_exits,_c-]_aborts!''!
q..H"n 0u..H @v'		    !* Maybe redisplay		!
				    !* Allow user editing	!
et1				    !* Assure file defaults	!
0,(fsz)fsbound		    !* Set bounds back wide	!
ew hp ef			    !* Write out changes	!
fsofile[O
:i*CSketch_Library_"O"_Written
!''!fsechodisw 0fsechoactive	    !* Say we won		!
0				    !* Return no changes	!


!View Sketch:! !C View a named text sketch!

fn q..H"n 0u..H @v' 		    !* Set up to flush typeout		!

m.m&_View_Sketch,(:i*View) :m(m.m&_Sketch_Prompt)


!& View Sketch:! !S View a sketch with a given name (numeric arg)!

[0[1				    !* q0: Temp			!
0f[^RStar			    !* Kill star in mode line	!
u0 :i*(Sketch_"0")!''![..J fr!* Set mode line		!
q0m(m.m &_Find_Sketch)u1	    !* q1: Sketch		!
ft1			    !* Display sketch 		!
:fiw				    !* Pause			!
0				    !* Return no change		!


!& Sketch Prompt:! !S Prompt for name and call continuation 
Continuation (a macro) is arg1; prompt type (a string) is arg2. 
Returns -1 on failure (over-rubout to prompt)	!

[L[P[N				    !* Temp qregs		!
:f"l				    !* If interactive, ...	!
 uP				    !* P: prompt substring	!
 qLast_Sketch_NameuL		    !* L: Last sketch		!
 :iP P_Sketch		    !* Build base prompt string !
 fqL:"l :iP P_(L)'		    !* Set up to show default	!
 1,m(m.m&_Read_Line)P:_uN'	    !* N: New input 		!
"# :iN'			    !* Non-interactive case	!
fqN"l -1'			    !* Abort if over-rubout	!
fqN"e qLast_Sketch_Name uN '	    !* If crlf, use default     !
   "# qN uLast_Sketch_Name'	    !*    else remember input	!
qN m()			    !* Call continuation	!


!& Find Sketch:! !S Return a sketch with a given name !

[0[1				    !* Bind temp qregs		!
u0				    !* q0: Sketch name		!
qLast_Sketch_Library_Nameu1	    !* q1: Library name		!
q1 m(m.m &_Prepare_Sketch_Library_Visit)
<m(m.m&_Find_Next_Sketch)
 z@; 1:f~0"e			    !* If the right name	!
   ,m(m.m&_Process_Sketch)	    !*  process it		!
   .,(hfx*) '			    !*  and return pos,text	!
>				    !* Loop			!
:i*NST	No_such_sketch_"0"_in_"F" fserr !''''! 


!& Sketch Library Prompt:! !S Prompt for library name and call continuation
Continuation (a macro) is arg1; prompt type (a string) is arg2. !

[L[P[N				    !* Temp qregs		!
m(m.m&_Sketch_Set_File_Defaults)   !* Set defaults		!
qLast_Sketch_Library_NameuL	    !* L: Last sketch		!
qL"n qL fsdfile '		    !* Merge with file defaults	!
:f"l				    !* If interactive, ...	!
 uP				    !* P: prompt substring	!
 5,m(m.m&_Read_Line)P_Sketch_LibraryuN    !* N: New input	!
 fqN"l -1' '			    !* Return -1 for over-rubout!
"# :iN'			    !* Non-interactive case	!
fqN"g etN '			    !* Merge file defaults	!
fsdfile f( uN ) uLast_Sketch_Library_Name !* Pick up default !
qN m()			    !* Call continuation	!


!List Sketch Library:! !C List the contents of the sketch library!

[Last_Sketch_Library_Name
fn q..H"n 0u..H @v' 		    !* Set up to flush typeout		!
m.m&_List_Sketch_Library,(:i*List):m(m.m&_Sketch_Library_Prompt)


!& List Sketch Library:! !S List a library's contents (name is numeric arg2) !

 m(m.m &_Prepare_Sketch_Library_Visit)  !* Set up buffer for library visit	!
 ftSketches_in_file_"F"...
 !''!
 < m(m.m&_Find_Next_Sketch)	    !* Iterate across sketches		!
   z@; 				    !* Exit if empty			!
   ft_ t>			    !* Type name of each sketch		!
 ft----------
 
 :fiw				    !* Pause				!
 0 				    !* Return no change to buffer	!


!& Prepare Sketch Library Visit:! !S Set up for sketch library perusal
Gets a fresh (temp) buffer and opens the library. Calls to
& Find Next Sketch will visit successive entries in the library.!

 f[bbind			    !* Get temp buffer			!
 f[dfile			    !* Bind default filename		!
 e[ fn e] 			    !* Bind input channels		!
 [F				    !* Get arg as qF			!
 <qF@:;
  @m(m.mVisit_Sketch_Library)
  qLast_Sketch_Library_NameuF>
 erF a			    !* Yank header area			!
				    !* Do NOT pop anything upon return	!


!& Find Next Sketch:! !S Visit the next sketch in an open library.
The library must have been opened by & Prepare Sketch Library Visit.
If no next sketch is found, the buffer is left empty; a sketch will
always have at least one char, so this isn't ambiguous.!

 hk				    !* Kill existing text		!
 < a zj 0,0a-"n hk 0; '	    !* Empty and exit if no c-L		!
   0,-1a-:@; > 		    !* Yank next entry			!
 j				    !* Jump to top of entry		!


!& Process Sketch:! !S Scan the current sketch removing syntactic markers.
Kill the sketch's name, the trailing c-L, hack c-Q's and maybe variables.
With a precomma arg, also processes <varname>'s, prompting for values in the
echo area.!

 [Last_Sketch_Name
 [0[1				    !* Temp Qregs			    !
 -1u0				    !* q0: Impossible buffer position	    !
 j k				    !* Kill header line			    !
 zj 0a-"n oFormatErr '	    !* Assure C-L just in case		    !
 -d j				    !* Delete it			    !
 <:s~<!>!;		    !* Search for c-Q, ~, or angle bracket  !
  0a-"e -d c '		    !* If c-Q, delete and pass quoted char  !
  "# 0a-~"e			    !* If ~,				    !
    q0:"l oFormatErr '		    !*  If one already seen, err	    !
       "# -d .u0 ''		    !*     else remember pos		    !
    "# 0a-<!>!"e "n -d .,(	    !* If angle bracket, maybe...	    !
      !<! s> -d		    !*  find and kill its match		    !
      .)fx* m(m.m&_Hack_Sketch_Var)''''> !* and insert named text	    !
 q0"l zj ' "# q0j' 		    !* Jump to marked pos or end	    !

!FormatErr!			    !* Come here to handle format errors    !
:i*FMT	Bad_format_in_sketch_entry fserr


!& Sketch Var Help:! !S Give help with sketch var prompt
qV must be set up with the var name and qI with default info (either a null
string or something preceded by a space)!

  ftYou_are_being_asked_for_a_filler_for_the_"V"_field
    of_a_sketch...
    _
    Type_text_to_be_used_in_this_sketch_field_(ended_by_Return),
    !''!

 ff"n
  ft_or_type_Control-R_to_be_able_to_type_this_text_into_an_editor_buffer,
    _or_type_Altmode_to_use_a_sketch_to_fill_this_field,
    '

  ft_or_type_Return_to_use_the_defaultI,
    _or_type_Rubout_to_ignore_this_field_for_now.
    ----------
    


!& Hack Sketch Var:! !S Hack sketch meta-quantity!

[0				    !* q0: meta-quantity name		!
 0:g0-@"e 1,fq0:g0u0 g(:i*fo..QSketch_0_Var) '
 0:g0-:"e .[1 z[Z z-.[2	    !* Save offset from end of buffer	!
            1,fq0:g0u0 m(:i*mm0)
            .-q1"e z-qZ"n z-q2j '' '	    !* Some macros do not move point !
					    !* We do this to avoid processing!
					    !* their contents		     !
 q0:m(m.m &_Interactive_Hack_Sketch_Var)



!& Interactive Hack Sketch Var:! !S Prompt for and insert named text (numeric arg2)
Uses sticky defaulting on names!

[V[1[I[3[C			    !* Temp qregs			!
uV				    !* qV: Name				!
0fo..QSketch_V_Varu1		    !* q1: Default			!
fq1"l :iI ' "# :iI_(1)'	    !* qI: Default info for prompt	!
!Prompt!
:i*CVI?_fsEchoDis	    !* Fake prompt			!
fi uC				    !* Get char in qC			!
qC-"e !Ignore!
 .( i<V> ),.'		    !* Get raw name in buffer		!
qC-"e			    !* If c-R				!
 f[bbind			    !*  Get temp buffer			!
 [C fsosteco"e :iCC ' "# :iCZ '
 :i*(Filler_for_"V")_End_with_c-m-C__!''![..J
 q..H"n 0u..H @v'		    !*  Rediplay			!
  ]..J ]C w g(hfx*(f]bbindw)) '!*  Edit, yank text			!
qC-"e			    !* If Altmode,			!
 1,@m(m.m Insert_Sketch):"l '    !*  Recurse into Insert Sketch	!
 oPrompt'			    !*  Reprompt if sketch aborted	!
(qC-?)*(qC-)*(qC-4110.)"e	    !* Help char?			!
 1m(m.m &_Sketch_Var_Help)
 oPrompt'
qc-"e oPrompt'		    !* Hack c-L for redisplay		!
qC-_"e -1uC'			    !* Leading space is no-op		!
qC fsreread			    !* Untyi the char			!
m.m&_Sketch_Var_Helpf[Helpmac	    !* Set up to offer help		!
1,m(m.m&_Read_Line)VI:_u3	    !* q3: New value			!
fq3"l oIgnore '		    !* Handle over-rubout		!
!Default!
fq3"g q3u1 '			    !* Maybe update default		!
q1"n q1m.vSketch_V_Var	    !* Maybe make default permanent	!
     g1'			    !* and get value in buffer		!
				    !* Return				!

!Visit Sketch Library:! !C Makes a sketch library current !

fn q..H"n 0u..H @v' 		    !* Set up to flush typeout		!
f[dfile			    !* Bind default file		!
m(m.m&_Sketch_Set_File_Defaults)   !* Set defaults			!
5,fVisit_Sketch_Library[L	    !* Prompt for library name		!
etL				    !* Set file defaults		!
fsdfileuL			    !* Get fully qualified name		!
e?"n				    !* If file doesnt exist		!
 @ft Sketch_library_"L"_doesn't_exist.__Create? !'!
 1m(m.m &_Yes_or_No)"n m(m.mCreate_Sketch_Library)L ''
fsdfile uLast_Sketch_Library_Name!* Update defaults			!
0				    !* Return no change			!


!Create Sketch Library:! !C Makes a new sketch library!

fn q..H"n 0u..H @v' 		    !* Set up to flush typeout		!
e\fne^				    !* Bind output channel		!
f[Dfile			    !* Bind default filenames		!
m(m.m&_Sketch_Set_File_Defaults)   !* Set defaults			!
5,fCreate_Sketch_Library[L	    !* Read library name		!
qLfsdfile			    !* Use the library name we saw	!
f[bbind			    !* Get temp buffer			!
i -*-_Text_-*-__This_is_an_Emacs_SKETCH_library.
  Created_
m(m.m Insert_Date)
zj i_by_ g(fsuname:f6) i. 
   !* Get username, date, etc		!
ew hp ef			    !* Write file			!
fsofileuL			    !* Get name written to		!
@ftSketch_Library_"L"_created.
    !''! 0fsechoactive	    !* Display success			!
0				    !* Return				!


!^R Sketch Insert or Dispatch:! !^R Insert sketch, or (with arg) menu of commands!

ff"n @:m(m.m^R_Sketch_Dispatch)'
      "# @:m(m.mInsert_Sketch)'


!^R Sketch Dispatch:! !^R Dispatch to appropriate sketch command!

[0[1				    !* Temps				!
60:"e				    !* Pause awaiting input		!
 !Prompt!
 :i*CSketch_Command:_ fsEchoDisplay'
!Retry!
fi :fc u0			    !* q0: Dispatch character		!
q0-E"e			    !* If E,				!
 f@:m(m.mEdit_Sketch)'	    !*  Edit Sketch			!
q0-I"e			    !* If I,				!
 f@:m(m.mInsert_Sketch)'	    !*  Insert Sketch			!
q0-V"e			    !* If V,				!
 f@:m(m.mView_Sketch)'	    !*  View Sketch			!
q0-"e			    !* If c-L,				!
 f@:m(m.mList_Sketch_Library)'   !*  List Sketch Library		!
q0-"e			    !* If c-V,				!
 f@:m(m.mVisit_Sketch_Library)'  !*  Visit Sketch Library		!

q0-Q"e 0'			    !* If Q, return			!

q0-H"e
   [L ftTo_use_a_sketch,_you_must_visit_a_sketch_library.
        Currently,_you_are_
      qLast_Sketch_Library_NameuL 
      qL"n ft visiting_the_sketch_library_"L".!''! '
        "# ft not_visiting_any_sketch_library. '
      ft  
You_can_visit_ qL"n ft another_ ' "# ft a_ ' 
      ft sketch_library_by_typing_c-V_now.
         You_can_list_the_contents_of_a_library_by_typing_c-L_now.
         _
         
      qL"n ft Since_ ' "# ft Once_ '
      ft you_have_visited_a_library,_you_can_insert_a_sketch_from
         that_library_by_typing_I 
      qL"n ft_now '
      ft .__To_create_a_new_sketch_or_modify
	 an_existing_one,_you_can_type_E
      qL"n ft_now '
      ft .__Or,_if_you_just_want
	 to_see_an_existing_sketch_without_inserting_it,_you_can_type_V
      qL"n ft_now '
      ft .
         ----------
         
    ]L oPrompt'

(q0-?)*(q0-)"e
 ftSketch_commands:
   ___E__Edit_(or_create)_Sketch
   ___I__Insert_Sketch
   ___V__View_Sketch
   _
   Sketch_Library_Commands:
   _c-L__List_Sketch_Library
   _c-V__Visit_Sketch_Library
   _
   Type_H_for_more_info.__Type_Q_to_exit_this_mode.
   ----------
   
 oPrompt '			    !* Return no change			!
fg				    !* Beep				!
:i*CSketch_Command_(E,_I,_V,_c-L,_c-V,_or_?):_fsEchoDisplay
oRetry				    !* Retry				!


!& Sketch Set File Defaults:! !S Set file defaults for a Sketch library!

 qLast_Sketch_Library_Namef"n fsdfile ' !* Sticky defaults		!
 "#w fshsname  fs dsname	    !* Default dir is homedir		!
     fsxuname  fs dfn1	    !* Default fn1 is username		!
     0          fs version	    !* Default version is highest	!
     f6SKETCH  fs dfn2'	    !* Default fn2 is SKETCH		!


  