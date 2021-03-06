!* Hey Emacs, this file contains -*-TECO-*- code!
!~FILENAME~:! !HENRY's Emacs Init File!
.EMACS

!& Setup .EMACS Library:! !S Initialization macro for Emacs library.!

-1 FS _ Disable 		    !* Disable back arrow. Safer to do F_ to get it. !
1U Auto_Directory_Display 	    !* Display directory after each write file command. !
85U Fill_Column 		    !* Fill text to column 85 [pub width].!
1U Auto_Save_Default 
M(M.M &_Make_Variable ) Auto_Save_Filenames 

[0 FS H SNAME  :F6 U0
:i Auto_Save_Filenames 0;_SAVE__> 
]0
                                    !* Protect against system crash, or user crash. !
M(M.M &_Make_Variable)File_Versions_Kept
1uFile_Versions_Kept              !* Keep only 1 version of a file.!
M(M.M &_Make_Variable)Text_Mode_Hook        
                                    !* Always go into fill mode when in Text mode !
                                    !* Change TAB [& LF] to do Indent Relative !
                                    !* [to previous line] !
:IText_Mode_Hook 1,1M.LAuto_Fill_Modew
                   M.M ^R_Indent_Relative U	 

0M(M.M Indent_Tabs_Mode )          !* Use spaces always for indenting. Tabs violate !
                                    !* the What You See is What You Get principle. !
M(M.M &_Make_Variable ) Lisp_Indentation_Hook 
:I Lisp_Indentation_Hook          !* Disable crufty function-dependent indenting!

M(M.M &_Make_Variable ) Underline_Begin 
:i Underline_Begin ~             !* Underline surrounded by ~squiggles~ !

M(M.M &_Make_Variable ) Underline_End 
:i Underline_End ~

M(M.M &_Make_Variable ) Tags_Find_File      !* Tags uses Find File for moving between files!
1u Tags_Find_File 

M(M.M &_Make_Variable ) WORDAB_All_Caps     !* Word abbrev uses case you type!
1u WORDAB_All_Caps 

M(M.M &_Make_Variable ) Dired_Long_Format     
1u  Dired_Long_Format             !* Dired displays whole file names before deleting !

M(M.M &_Make_Variable ) Emphasis_Font_Begin         !* Inserted by meta-squiggle!
M(M.M &_Make_Variable ) Emphasis_Font_End     
:i  Emphasis_Font_Begin ~
:i  Emphasis_Font_End ~



:iTemp_File_FN2_ListOLRECTEMPCOMPRSUNFASL_FASL__UNFA_PUIPUZPUGTEMPOUTPUTPRESS
                                    !* add to reapable FN2's COMPRS [EMACS], _FASL_, _UNFA_!
                                    !* [NCOMPLR], PUI, PUG, PUZ [PUB], TEMP, OUTPUT, PRESS.!

-1 FS ^H PRINT 		    !* Printing of  as back space.!
-1 FS ^M PRINT 
				    !* Printing of  as carriage return !

!* Character syntax for Reader macros.!

[*5+1:F..D(		    !* Treat [ like (!
]*5+1:F..D)		    !* Treat ] like )!
{*5+1:F..D(		    !* Treat { like (!
}*5+1:F..D)		    !* Treat } like )!
"*5+1:F..D|		    !* Treat " like |!
`*5+1:F..D'		    !* Treat ` like '!
,*5+1:F..D'		    !* Treat , like '!

!* Character syntax for special characters found in identifiers!

-*5+1:F..DA		    !* Treat - like A!
:*5+1:F..DA		    !* Treat : like A!
**5+1:F..DA		    !* Treat * like A!
#*5+1:F..DA		    !* Treat # like A!
_*5+1:F..DA		    !* Treat _ like A!



!* Real time editing character redefinitions.!

! seems to have disappeared ... !
!(M.M ^R_MM_Via_Minibuffer )u...X ! !* C-M-X gets minibuffer with MM !
(M.M ^R_Make_[])U..[ 
(M.M ^R_Move_Over_])U..]
(M.M ^R_Make_{})U..{
(M.M ^R_Move_Over_})U..}
(M.M ^R_Forward_Paragraph )U..N    !* Paragraph commands displaced by matched brackets!
(M.M ^R_Backward_Paragraph )U..P   !* They displace useless Lisp comment commands!
(M.M ^R_End_Sentence)U..         
(M.M ^R_End_Exclamation)U.!  
(M.M ^R_End_Question)U.?
(M.M ^R_Directory_Display)U...D
(M.M ^R_Indent_Miser)U..
(M.M ^R_String_Search )U.S       !* String search the default on Control-S.!
(M.M ^R_Incremental_Search )U...S        !* Meta-Control-S gets Excremental Search.!
(M.M ^R_Reverse_String_Search )U.R
(M.M ^R_View_File )U:.X(V)       !* Control-x V does View File. !
(M.M ^R_Double_Quotes )U.."      !* Type matching sets of double quotes, vertical bars.!
(M.M ^R_Vertical_Bars )U..|
(M.M ^R_Squiggles )U..~
(M.M ^R_Stack_List_Vertically U..O)

!* M(M.M &_Make_Variable ) Word_Abbrev_Hook   ! !* Make extra characters expand abbreviations!
!* ^:I Word_Abbrev_Hook `                   !
!*   M.M ^R_Expand_And_Call_Old_Char U..)  !
!*  M.M ^R_Expand_And_Call_Old_Char U..    !
!*   M.M ^R_Expand_And_Call_Old_Char U.!  
!*   M.M ^R_Expand_And_Call_Old_Char U.?   !
!* `                                          !

FS XJNAME :F6 [0  !* get the real job name and put in in q-register 0 !
F~0ACT1T"E M(M.M Actor ) ' !* If we're working on actor, set things up for it !

EREMACS;*_EMACS ^Y [0 HFX0 M0 ]0 



!^R Enclose List:! !^R Encloses a list in parentheses!

1M(M.M ^R_Make_() ) 


!^R Make []:! !^R Insert [] putting point between them.
Also make a space before them if appropriate.
With argument, put the ] after the specified number
of already existing s-expressions.  Thus, with argument 1,
puts extra parens around the following s-expression.!

    .[0
    I[ FF"N ^ FLL' I] .[1
    Q0J C Q0,Q1


!^R Move Over ]:! !^R Move over a ], updating indentation.
Any indentation before the ] is deleted.
LISP-style indentation is inserted after the ].!
    F[S STRING
    S] R
    @-F
_	K			    !* Delete any indentation or CRLFs before the ].!
    .[0
    C -1F"G S]'
    MM			    !* The ] should be right after the last other text.!
    @M(M.M ^R_Indent_for_LISP)	    !* Then indent after the ].!
    Q0,.


!^R Make {}:! !^R Insert {} putting point between them.
Also make a space before them if appropriate.
With argument, put the } after the specified number
of already existing s-expressions.  Thus, with argument 1,
puts extra parens around the following s-expression.!

    .[0
    I{ FF"N ^ FLL' I} .[1
    Q0J C Q0,Q1


!^R Move Over }:! !^R Move over a }, updating indentation.
Any indentation before the } is deleted.
LISP-style indentation is inserted after the }.!
    F[S STRING
    S} R
    @-F
_	K			    !* Delete any indentation or CRLFs before the }.!
    .[0
    C -1F"G S}'
    MM			    !* The } should be right after the last other text.!
    @M(M.M ^R_Indent_for_LISP)	    !* Then indent after the }.!
    Q0,.


!^R End Sentence:! !^R Inserts ".", new line, capitalizes first word of sentence.!

I.
 .(1M(M.M ^R_Backward_Sentence ) 
    1 ^FC)J
 -3F  


!^R End Exclamation:! !^R Inserts Excl, new line, capitalizes first word of sentence.!

I!
 .(1M(M.M ^R_Backward_Sentence ) 
    1 ^FC)J
 -3F  


!^R End Question:! !^R Inserts "?", new line, capitalizes first word of sentence.!

I?
 .(1M(M.M ^R_Backward_Sentence ) 
    1 ^FC)J
 -3F  


!^R Indent Miser:! !^R Indents for Lisp, but in Miser mode, aligned with CAR of form.!

W .,(
[5
 .(
   1:<-FUL FDL>"N 1 ' 
   FS H POSITION U5
  )J I
 Q5<I_>
 )Z 


!^R Directory Display:! !^R Displays Directory. Arg gives most-recent-first listing.!

F[D FILE 
-4"E M(M.M View_File )DIR: CDATE_DOWN 
   '"# EY ' 


!Actor:! !C Setup for working on Actors. Sets modes, loads tags.!

      "*5+1:F..D'		    !* Treat " like '!
      M(M.M Auto_Save_Mode )
      M(M.M Lisp_Mode )
      M(M.M Abbrev )
      M(M.M Load_Library ) LISPT        !* Load Lisp-Teco interface.!
!      M(M.M Read_Word_Abbrev_File) ACTOR;ACTOR_ABBREV !
      M(M.M Quick_Read_Word_Abbrev_File) ACTOR;ACTOR_ABBREV 
      1 M(M.M Visit_Tag_Table) ACTOR;ACTOR_TAGS  


!Abbrev:! !C Loads Word Abbreviation library and sets mode.!
      M(M.M Load_Library ) WordAb  
      M(M.M Word_Abbrev_Mode) 



!Space Comment:! !C Converts to new format comment.!

 M(M.M Replace_String);;;###
 M(M.M Replace_String);;*PAGE~~~
 M(M.M Replace_String);;;;_
 M(M.M Replace_String)###;;;
 M(M.M Replace_String)~~~;;*PAGE


!Comment Region:! !C Comments out code within region.!
[0 [1
FS H POSITION U0                   !* Commenting occurs at horizontal position of cursor!
:,. F  M(M.M Count_Lines )U1    !* Do it for the number of lines in the region.!
Q1 < I;;;_                         !* Insert Comment string, set horiontal position.!
     1:< 1,Q0 FM >
   > 
 


!Paginate Lisp:! !C Puts page boundaries in Lisp code so that don't break S-expressions.!

J                                   !* Take it from the Top.!
M(M.M Replace_String)
                                  !* Remove previous pagination.!
[0 [1 [2 [3 0U1                     !* Q1 counts lines on current page. !
F[S STRING 
"N '"# 60' U2                   !* Argument is Page Size maximum.!
< .( .,(:S
(; R .U3 .)M(M.M Count_Lines) U0   !* Count the number of lines in the next sexp.!
   )J
  Q2-Q0"L  I
                                   !* If its greater than the desired page size,!
           Q3J                      !* put it on a separate page.!
           I
 
           0U1 '"#
  Q2-(Q1+Q0)"L I
                                   !* If adding this list to the current page causes!
             Q3J                    !* overflow, !
             Q0U1 '"#               !* Break page before this s-exp, move past it.!
    (Q1+Q0) U1                      !* Otherwise, add this to current page. !
    Q3J '
>
J 

!^R View File:! !^R Looks at a file without reading it in and creating a buffer.!
    F[ D_FILE                      !* Viewing a file doesn't set file defaults.!
    5,M(M.M &_Read_Line) View_File[1	    !* Read arg.!
    FQ1"L '			    !* He rubbed past start => give up.!
    M(M.M View_File)1	    !* Read file, using user's arg on top of that default.!
    


!^R Reverse String Search:! !^R String Search in the reverse direction.!
   - :M (M.M ^R_String_Search )

!New Lisp File:! !C Start editing a new file containing Lisp code.!

   M(M.M Lisp_Mode )
   JI;;;_Hey,_Emacs,_this_file_contains_-*-_Mode:_Lisp;_Package:_User;_Base: 10.;_-*-_code!
;;;_(c)_1981_Henry_Lieberman,_Massachusetts_Institute_of_Technology


!New Text File:! !C Start editing a new file containing Pub source!

   M(M.M Text_Mode )
   JI. << _Hey,_Emacs,_this_file_contains_-*-_Mode:_Text;_Package:_User;_Base: 10.;_-*-_code >>
._<<_(c)_1981_Henry_Lieberman,_Massachusetts_Institute_of_Technology_>>
._require_"Henry;Pubmac"_source_file
.


!^R Double Quotes:! !^R Insert a pair of double quotes, leaves you inside them.!
   I"" R 
   .-1,.+1 

!^R Vertical Bars:! !^R Insert a pair of vertical bars, leaves you inside them.!
   I|| R 
   .-1,.+1 

!^R Squiggles:! !^R Insert a pair of squiggles, leaves you inside them.!
   .(GEmphasis_Font_Begin
      .(GEmphasis_Font_End [1 .U1 )J
     ),Q1 


!RMAIL:! !C Read mail -- Alaias for obsolete name!
 MM_Read_Mail

!Make Variable:! !C Makes a variable -- Alaias for obsolete name!
 MM_&_Make_Variable

!^R Stack List Vertically:! !^R Grind the list following . vertically.
The list following . is ground into standard grind format.
If ^U is given as an argument, miser format is used.!

    m.m ^R_Forward_Sexp[1
    m.m ^R_Indent_New_Line[2
    m.m ^R_Indent_for_LISP[3
    .[6				    !* Q6 saves . so can restore . later!
    [4 [5
    :flr c			    !* Move up to next list, beyond the open paren!
    1a-)"e q6j .'		    !* Nasty case of () exits immediately!
    -4"N 1m1f @:flr 1a-)"e q6j .''	    !* If not miser format, move over first sexp!
    <1m1f			    !* Move forward over a sexp!
        .u4 @:flr .u5		    !* Q4 saves ., then move to next sexp, then Q5 saves .!
        1a-)"e 0;'		    !* If ) seen, then we have reached end of list - exit!
	q4,q5:fb
(q5j)"L			    !* If we crossed a line boundary,!
	    m3f'"#		    !*  then just tab!
	    m2f'>		    !* Otherwise move to a new line and tab!
    q6j .			    !* Restore . and exit!

!XGP Hard Copy:! !C Makes an XGP'able @ listing. String arg for language, usually Lisp.!

[1 [2 :I1 :I2
FQ2"E :I2LISP '
[0
^_:@_ /L[2]/3F[20FGI,20FG,20FGI]/%/S/120W/C/$/1"_1
!* Formerly: :@_1_/L[2]/3F[25FRI1,HENRY;MYFONT,25FGI1]/#/^/%/S/96W !
:VP_ 1 




!Dover Hard Copy:! !C Makes a Doverable @ listing. String arg for language, usually Lisp.!

[1 [2 :I1 :I2
FQ2"E :I2LISP ' 
[3 FS H SNAME  :F6 U3
[0
^_:@_ /O[3;THIRD:PRESS@_>]/D[DOVER]/3F[GACHA 6I, GACHA 7, GACHA 6I] /L[2]/%/S/120W/Q/C/$/1"/65V_1
:COPY_AI:3;PRESS@_>,MC:.DOVR.;PRESS@_>
:DELETE_AI:3;PRESS@_>
:VP_ 1 


!Hard Copy:! !C Makes a Doverable @ listing. String arg for language, usually Lisp.!
:M(M.M Dover_Hard_Copy )

