!* -*-TECO-*- *!
!~Filename~:! !Document conditional expander!
DOCOND

!DOCOND:! !C Perform full DOCOND processing on contents of buffer.!

    m(m.m &_DOCOND_Safety)
    q:.b(qBuffer_Index)-13!*Buflcl!/2[Initial_Local_Count
    m(m.m &_DOCOND_Process_Declarations)
    1,(m.m&_DOCOND_Refill)m.l MM_Refill
    m(m.m &_DOCOND_Process_Conditionals)
    js{end} 0,.k		    !* Kill the DOCOND specs now that they're processed.!
    2 f=
"e k'
    1m(m.m&_Init_Buffer_Locals)
    

!DOCOND Set Flag:! !C Specify the value of a DOCOND flag.
The argument (from terminal or suffix) should be a "+" or "-"
followed by the name of the flag to be set.
A numeric argument says that redefining a flag
already set is illegal.!

!** With arg, we assume that FS VZ has already been bound to where the {END} is.!

    1,f Flag[1
    .[0  fn q0j		    !* Always preserve point.!
    ff"e m(m.m &_DOCOND_Safety)'
    +[2			    !* Default flag setting is "+"!
    0:g1f+-:"l		    !* If a setting was included in the arg, gobble it.!
      0:g1u2 1,fq1:g1u1'
    ff"e js{end} fsz-.f[vz'  !* Restrict attention to the DOCOND specs at the front.!
    j :s{Flag:1}"e		    !* Look for something declaring this flag.!
      :i*No_Such_Flag:_1 fs err'
    fkc 6c
    1af+-?"l
      1au2 :i*Illegal_Flag_Declaration:_{Flag:21} fs err'
    1a-q2"e 0'		    !* Flag is already set as specified => do nothing.!
    1a-?"n			    !* Already set the other way => is it ok to change?!
      ff"n :I*Conflicting_Flag_Setting:_21 fs err''
    d q2i			    !* Set the flag as desired, if it's ok.!
    

!& DOCOND Process Declarations:! !S Process all declarations (Flag, Implies, etc.).!

    js{end} fkc fsz-.f[vz	    !* Restrict attention to the DOCOND specs at the front.!
    [1 [2 [3 [..h		    !* Allow buffer redisplay when we're done.!
    [..d q..d[4			    !* Save old ..d in q4 for commands to use.!
    128*5,32:i..d
    1m(m.m&_Alter_..D) {( })	    !* Set ..D so {, } get counted by FU command.!
    :ft
    j < :s{;			    !* Find next declaration.!
	.u3 s:
	q3,.-1x1		    !* What type of declaration is this?!
	1,m.m&_DOCOND_1_Declarationu2
	q2"n m2'		    !* If it requires our processing, process it.!
	q3j ful >		    !* Skip over the declaration, look for next one.!
    

!& DOCOND Print Declaration:! !S Process a {Print:string} declaration.!

    .,(ful r .)t

!& DOCOND Implies Declaration:! !S Process {Implies:+FOO=>+BAR}.!

    .[0  fn q0j		    !* Always preserve point.!
    1au2 c
    .,(s=> 2r .)x1		    !* Get flag name in Q1, setting in Q2 for flag which implies.!
    q1m(m.m &_DOCOND_Lookup)-q2"e  !* If the flag really has that setting,!
      2c .,(s}r .)x1		    !* get what that implies,!
      1m(m.m DOCOND_Set_Flag)1' !* and do it.!
    

!& DOCOND Flag Declaration:! !S Process a {Flag:...} by asking user for setting.!

    [1 [2
    1a-?"n '		    !* If flag is already set, do nothing.!
    c .,(s}r .)x1		    !* Else, must ask for the setting.  Get name in Q1.!
    .( j :s{Default:1}"l	    !* Is a default specified?!
	       fkc 9c 1au2'	    !* If so, use it.!
       "# ft What_setting_for_the_1_flag_
          < ft (+_or_-)?	    !* Else, ask for setting.  Keep asking till get OK answer.!
	    fiu2
	    ft2

	    q2f+-;>'
       )j
    1m(m.m DOCOND_Set_Flag)21	    !* Set flag to specified setting.!
    

!& DOCOND Alternatives Declaration:! !S Process an Alternatives declaration.
Ask the user which alternative to set to "+", unless one already is.
Set all the others to "-".!

    [1 [3 m.m &_DOCOND_Lookup[L
    m.m DOCOND_Set_Flag[s
    .[2				    !* Find start of first flag of the Alternatives.!
    < .,(s,} .-1)x1		    !* Is any of the alternatives already set on?!
      q1ml-+"e !<!0;> o Chosen'  !* If so, just turn all others off.!
      0a-}@;>
  !Retry!
    ft Choose_one_of_		    !* Else ask user which one he wants.!
    q2j .,(s}r .)t  ft:_
    1,m(m.m&_Read_Line)Alternative:_u1
    q2,.:fb1"l 1af,}:"l
      fkc 0af:,:"l  o Ok'''
    o Retry
  !Ok!
    1ms+1
  !Chosen!			    !* Now that the flag in Q1 is set to "+",!
    q2j				    !* set all the other alternatives to "-".!
    < .u2 s,}
      q2,.-1f~1"n
        q2,.-1x3
	1ms-3'
      0a-}@; >
    

!& DOCOND Local Variable Declaration:! !S Process {Local Variable:varname=value}!

    .[1 s= q1,.-1x*[.2		    !* Q.2 gets name of variable.!
    fu-1x*[3			    !* Q3 gets value.!
    q3m.l.2			    !* Create local variable.!
    

!& DOCOND Safety:! !S Make sure user doesn't clobber his source with DOCOND.!

    QBuffer_Filenames"E '	    !* If this file is visiting a buffer,!
    FS MODIF"N
      @FT
Save_your_source_changes_before_DOCOND_processing
      1m(m.m&_Yes_or_No)"n
        1m(m.m ^R_Save_File)''
    0uBuffer_Filenames	    !* Say this buffer no longer visiting source file!
    0u:.b(qBuffer_Index+2)	    !* to prevent accidental saving of DOCOND output as source!
    m(m.m &_Set_Mode_Line)
    

!& DOCOND Replace Declaration:! !S Process a {Replace:...} specifications.!

    [1 [2 [3 q4[..d [4
    1au2 c
    .,(s=> 2r .)x1		    !* Q1 gets flag name, Q2 gets setting.!
    q1m(m.m &_DOCOND_Lookup)u3	    !* Look up actual setting of that flag.!
    q2-q3"n '			    !* If actual setting matches that in the {Replace},!
    2c .,(s->-->> .+fk)x2	    !* do the replacement.  Get from and to strings.!
    -1-(fs s value)u4		    !* Q4 gets 1 if it's a -->> replace.!
    .,(s}r .)x3
    .( zj
       0fsvz			    !* While replacing, consider all of buffer!
       q4,1m(m.m Replace_String)23   !* EXCEPT the DOCOND specs area.!
       fsz-.fsvz )j
    

!& Docond Char Replace Declaration:! !S Process a Char Replace declaration.
Like Replace declarations except that they use 0mmReplace instead of 1.!

    [1 [2 [3 q4[..d [4
    1au2 c
    .,(s=> 2r .)x1		    !* Q1 gets flag name, Q2 gets setting.!
    q1m(m.m &_DOCOND_Lookup)u3	    !* Look up actual setting of that flag.!
    q2-q3"n '			    !* If actual setting matches that in the {Replace},!
    2c .,(s->-->> .+fk)x2	    !* do the replacement.  Get from and to strings.!
    -1-(fs s value)u4		    !* Q4 gets 1 if it's a -->> replace.!
    .,(s}r .)x3
    .( zj
       0fsvz			    !* While replacing, consider all of buffer!
       q4,m(m.m Replace_String)23   !* EXCEPT the DOCOND specs area.!
       fsz-.fsvz )j
    

!& DOCOND Process Conditionals:! !S Process all {+FOO:text} conditionals.!

    [1 [2 [3 [4 [..d
    128*5,32:i..d
    1m(m.m&_Alter_..D) {( })	    !* Set ..D so {, } get counted by FU command.!
    m.m&_DOCOND_Lookup[l
    j s{end} .[e		    !* Remember where the {end} is for & DOCOND Lookup.!
    j < :s{; 1af*+-"l !<!>'	    !* Find next conditional.!
	1au2 -dd .,(s:r .)fx1 d    !* Get flag name in Q1, setting in Q2. Kill them, { and :.!
	q2-*"e		    !* If it's really a macro call, expand it.!
	  fu-1fx3 d		    !* Extract and kill the string arg,!
	  m(m.m1)3+0u2	    !* and call the macro.!
	  fq2"g g2 fkc' !<!>'	    !* Insert and rescan what the macro returns.!
	fsz-qe,q1mlu3		    !* Look up the flag.  Put actual setting in Q3.!
	.u4 ful -d		    !* Find and kill the } that ends this conditional.!
	q2-q3"n q4,.k'		    !* Kill the text within if the conditional fails.!
	"# q4j'			    !* Otherwise, rescan it for more conditionals.!
	>
    

!& DOCOND Lookup:! !S Return the current setting of a flag.
Specify the flag name as a string as a prefix argument.
The setting is returned as a numeric character.
A precomma numeric argument specifies the value of FS VZ
to use while looking up the flag (for efficiency.!

    [1  .[0  fn q0j  qe"n fsZ-QE f[vz'
    j s{flag:1}
    fk+7a

!& DOCOND Refill:! !S Re-fill this or the previous paragraph.!

    .-z( .:
         @m(m.m^R_Backward_Paragraph)
	 m(m.m^R_Fill_Region)
         )+zj
    
 