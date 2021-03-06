!* -*- TECO -*-		Library created and maintained by KMP@MC !

!~Filename~:! !Fancy Mode Line handler!
MODLIN

!& Setup MODLIN Library:! !& Put winning mode line in effect!
1,m(m.m &_Get_Library_Pointer)KMPTIME"e
 m(m.m Load_Library)TIME'
m.m&_Fancy_Mode_Line fs Mode Macro
m.m&_Fancy_Mode_Line M.V MM_&_Set_Mode_Line
fsOSTeco"e
 m.m&_Check_for_Correct_Superior fs ^R Display'
m.m&_Fancy_Mode_Line(
),m(m.m&_Start_Realtime_Modeline_Clock)
1fsmodech
0fo..QInvert_Filenamesm.vInvert_Filenames

!& Kill MODLIN Library:! !& Get rid of this mode line!
1,m(m.m&_Get_Library_Pointer)EMACSm.m&_Set_Mode_Linef((
)m.v MM_&_Set_Mode_Line
)fs Mode Macro
fsOSTeco"e
 0 fs ^R Display'
1fsmodech


!& Check for Correct Superior:! !S Update Job Superior in Mode Line 
For use with LISPT if superior is changing. Checks to see if superior
has changed, and calls MM& Set Mode Line if it has. This should be put
in FS^R Display in order to win. Takes a minimal amount of overhead to
check when superior has not changed. If job is a LISPT, runs
qLISPT Autoload Hook if nonzero. !

fsOSTeco"n 0'		    !* Return if not ITS.!
				    !* Should never run off ITS anyway. !
[0[1
fsxjname-(f6MAILT)"e 0 '		  !* Ignore MAILT Superior !
2 FO..QLast_Correct_Superioru1		  !* Get last superior info in Q1 !
fs%oplspu0				  !* Put FS %OPLSP in Q0 !
q0+q1"n					  !* If superior has changed. !
   q1-2"e 2M.VLast_Correct_Superior'	  !* Make a new variable !
       "# 2uLast_Correct_Superior'	  !* Or use the old one !
   1 fs mode change			  !* Set up to change the mode line !
   0-q0uLast_Correct_Superior'	  !* Save new superior !
0 


!& Fancy Mode Line:! !S Set the ..J Mode to display options.
When setting the major mode, call this with a nonzero argument
and the major mode name as a string argument.  It will change the mode
and run the <modename> Mode Hook variable, if there is one.!

    -(fsqpptr*2)fsmodech	    !* Setup for re-call if qpdl is popped. !
				    !*					    !
    [0[1[2[3[4	[.1[.2[.3[.4	    !* Bind scratch qregs		    !
				    !*					    !
				    !* Because we are called at interrupt   !
				    !*  level, we should bind all kinds of  !
				    !*  things to be sure not to screw	    !
				    !*  interrupted code...		    !
				    !*					    !
    f[inslen			    !* Bind length of last inserted frob    !
    f[sstring			    !* Bind default search string	    !
				    !*					    !
    qEditor_Nameu0		    !* q0  = Editor Name		    !
    qModeu1			    !* q1  = Major Mode			    !
    qBuffer_Indexu3		    !* q3  = Buffer Index		    !
    0u.1			    !* q.1 = A counter (init to 0)	    !
    fsreadonlyu.2		    !* q.2 = ReadOnliness of buffer	    !
    :i*u.3			    !* q.3 = Macro to run upon return	    !
    fsvz+b u.4			    !* q.4 = nonzero if buffer narrow	    !
    fnm.3			    !* Set up to macro q.3		    !
				    !*					    !
    "n			    !* If an arg given, ...		    !
      :i1 q1uMode	    !*    Get string arg of new major mode  !
      0fo..Q 1_Mode_Hooku2	    !*    Get mode hook, if any, in q2	    !
      q2"n m2''			    !*    If a hook was found, macro it	    !
				    !*					    !
    f[BBind			    !* Bind the buffer for fast insert	    !
    f[DFile			    !* Bind default filenames		    !
				    !*					    !
    g..J j			    !* Get old mode line in buffer	    !
    :s[ w  .-1u.1		    !* Search for a non-[ to count ^R levels!
    q.1j fq0f f~0-fq0-1"n 0'  !* Exit if non-standard modeline inside !
				    !*  (Standard= begins with Editor Name) !
				    !*					    !
    hk				    !* kill text from buffer		    !
				    !*					    !
    g0 i_ 			    !* Insert Editor Name + space in buffer !
				    !*					    !
    g(M(M.M &_Get_Current_Time))   !* Get ahold of the time		    !
				    !*					    !
    fsOSTeco"n                     !* Put in load ave, but on T(w)enex only!
      fs load av[0                 !*                                      !
      i_ g0' 	                    !* Drop in load av                      !
                                    !*                                      !
    i_[			    !* Insert a a left bracket		    !
				    !*					    !
  fsOSTeco"e			    !* For ITS only..                       !
    fs%OPLSP"n			    !* If we are an inferior,		    !
      fsxjname-(f6MAILT)"n	    !*   If not a MAILT			    !
        0fo..Q LISPT_AutoLoad_Hookf"nu.3'
        iLISP:_'		    !*      then insert LISP: into modeline !
      "#			    !*   Else we are a MAILT		    !
        iMAIL:_'''		    !*      so say so			    !
   				    !* Else (not inferior)		    !
				    !*   Then DDT: is the thing to use	    !
				    !*    but no one wants to see it...	    !
				    !*					    !
    g1				    !* Insert the major mode		    !
				    !*					    !
    qSubmodeu2		    !* Get Submode, if any, in q2.	    !
      fq2"g i-2 '		    !*  and insert it as a subscript	    !
				    !*					    !
    qAuto_Fill_Mode"n i_Fill'    !* If in Auto Fill Mode, say so 	    !
				    !*					    !
    q:.B(q3+10)"n i_Save'	    !* If buffer is in autosave mode	    !
    "# qAuto_Save_Default"n	    !* Or if it is unusual to have it off   !
         i_NoSave''		    !*   mention it is off		    !
				    !*					    !
    qVisit_File_Save_Old[0	    !* Bind value			    !
         q0"l i_SaveOld'	    !* Mention if writeback forced	    !
	   "# q0"e i_NoSaveOld''   !*  Or if inhibited			    !
    ]0				    !* No mention means it will query	    !
				    !*					    !
    q:.B(q3+12)f"n[0		    !* If readonliness exists,		    !
       i _ReadOnlyFile 	    !*  mention it			    !
       q0"l i /Buf '		    !*  and what it spans		    !
       ]0'			    !*  and close this off		    !
    "# q.2"n i_ReadOnlyBuf''	    !* Or maybe Teco readonliness involved  !
				    !*					    !
    fs ^R Replace"n i_OverWrite'  !* Mention overwrite mode		    !
				    !*					    !
    fs Tyi Sink"n   i_Def'	    !* Mention KBDMAC def mode		    !
				    !*					    !
    Q.4"N I_Narrow'		    !* Mention narrow buffer bounds	    !
				    !*					    !
    MSet_Mode_Line_Hook+0 u2	    !* q2: Result of user insertion hook    !
     fq2"g g2'			    !*  If stuff was returned, insert it    !
				    !*					    !
    0fo..Q Editor_Typeu2	    !* q2: Editor Type, if any		    !
     fq2"n i_<2>' "# i_- '	    !*  Insert <type> or a dash		    !
				    !*					    !
    qBuffer_Filenamesu1	    !* q1: Buffer Filenames		    !
    qBuffer_Nameu2		    !* q2: Buffer Name			    !
				    !*					    !
    q1"N et1			    !* Set file default to buffer filenames !
      fsdfileu1		    !*  Get formatted form of q1 in q1	    !
      f~(fsdfn1:f6)2"e	    !*  If fn1 is the same as buffer name   !
      0u2''			    !*     Zero out buffer name		    !
				    !*					    !
    q2"n i_2'		    !* Insert space + buffer name if any    !
    "# 0a--"e -2d''		    !* Else look for hyphen and flush it    !
				    !*					    !
    i]_			    !* In any case, insert the right bracket!
				    !*					    !
    fq1"g g1 fq1r		    !* If a filename exists, insert it	    !
      0u4 .fsvb		    !* Remember this point		    !
      fs osteco"n		    !*   If not on an ITS, ...		    !
        .( !<! s> z-.u4 )j	    !*      Remember fn1 point		    !
        fshsname:f6u2		    !*      Back up and get HSNAME in q2    !
	fsosteco-1"e		    !*      If on a 20X, ...		    !
          fq2 f~2"e fq2d''	    !*         Leave the PS:<hsname> out.   !
	"# 4 f~DSK:"e 4d	    !*      If on a 10X, maybe delete DSK:  !
	    fq2+2 f~<2>"e	    !*         and if that worked, hsname   !
              fq2+2d'''		    !*	              if possible also	    !
	zj fs dvers"e -2d q4-2u4'' !*      And if version 0, leave it out. !
      "#			    !*   Else, on ITS...		    !
        .( s:_ z-.u4 )j	    !*      Remember fn1 point		    !
        fsmachine:f6u2		    !*      Put machine name in q2	    !
        :s;"l		    !*      Find end of dir name	    !
	  1a-_"e d'		    !*       Flush space after dir name	    !
          3 f~2:"e 4d'	    !*       Delete machine name if local   !
          :s:"l		    !*       Find end of dev name	    !
             1a-_"e d''''	    !*        Flush space after dev name    !
      qInvert_Filenames"n	    !*   If user requested it, ...	    !
       z-q4j g( :fx* ( j ) ) i_'   !*     Change filename order	    !
      0fsvb			    !*   Widen buffer bounds		    !
      zj			    !*   Jump to the end,		    !
      fsdversion"'e+(		    !*   Include actual file version number !
       fsdversion+2"'e)"l	    !*					    !
	i_= q:.b(q3+9)[0	    !* Set up for including true version    !
	q0"g q0\'		    !* Insert true version if worthwhile    !
	  "# -d q0+1"e i# '	    !* Or a # if something wierd	    !
	            "# i~ g0 ''    !* Or ~filename if a non-numeric name   !
	]0''			    !* Pop qregs			    !
				    !*					    !
    zj Q.1< I_^R] > J Q.1,[I	    !* Put back on indicators of ^R level.  !
				    !*					    !
    zj i_			    !* Kill all back into ..J		    !
				    !*					    !
    hf=..j"n hx..j'	    !* Set ..j unless no difference.If same,!
				    !* keep old one since Teco can then	    !
				    !* avoid redisplaying the mode line.    !
				    !*					    !
    0				    !* Return, saying no region got changed !
