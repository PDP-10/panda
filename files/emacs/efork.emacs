!* -*-TECO-*-   Comes from DREA!
!~Filename~:! !Commands to manipulate inferior forks.!
EFORK

!& Setup EFORK Library:! !S Initialize for handling inferiors.!

  0FO..Qforklist "E
    :i* M.Vforklist
    0M.Vfrk			    !* place to keep last handle.!
    0M.Vfrk*			    !* Handle for old EXEC fork !
  '
  0FO..Q EFORK_Setup_Hook U3 Q3"N :M3'	    !* Call hook if there !
  M.M^R_Invoke_Inferior U..+	    !* Else set M-+ !
  M.M^R_Kill_Inferior U..,	    !* and M-, !

!^R Invoke Inferior:! !^R Invoke an inferior process.
	A Numeric argument before the command indicates that fz should
be called with the @ modifier.  If this macro is not called from a key
then it  requires that  all four  string arguments  be given  and  the
calling sequence is:

  M(M.M^R Invoke Inferior<esc>) {handle} <esc> {rescan string} <esc> ...
     ... {non-empty => forced read} <esc> {filename}

Otherwise, ...
	Asks for a fork  handle, which is  a local name  for
that fork.   Efork recognizes  three special  fork  handles,
which are:
	EXEC		Starts a NEW exec.
	*		Continue the old exec.
	<nothing>	Continue the last fork
			that was in operation.

CAUTION: ONLY EXPERIENCED USERS OF THE RESCAN BUFFER NEED PROCEED

	If the handle is followed by an <ESC> then a  string
(terminated by an unquoted <esc>) is read and passed to  the
fork as JCL.
	     1) If the fork is an exec fork, or the JCL
     string ends  in  <ESC><ESC>,
		  then the string is passed to the
	  fork as  terminal  input.  That  is  the
	  rescan buffer will be preset to read.
	     2) If the  fork is  not an  exec fork,
		  then the JCL string is passed to
	  the fork in the rescan buffer.

	The read  program  for the  JCL  recognizes  several
special characters:
	^Q	Quotes the next char whatever it is.
	$	Ends the JCL String.
	^M	Inserts a <CR><LF>.
	^?	Deletes last character.
	^U	Starts over from the beginning. !

  F[ D FILE 1F[ FNAM SYNTAX	    !* Set up filename defaulting !
  [0 [2 [3 0[4			    !* Save Q-regs !
  [..4 :I*[..5 1[..6 :i*[..7	    !* Five special Q register are:      !
  Q..O[..8			    !* ..8 = holds the previous buffer   !
  FF"N 64:i..7'		    !* ..4 = holds the handle name       !
				    !* ..5 = holds the rescan stuff      !
				    !* ..6 = 0 indicates forced read     !
				    !* ..7 = 0 indicates @ modifier on fz!
  F[ B BIND			    !* Get temp buffer !
  :f"L
  :I2 Handle_Name:_ 		    !* Save the prompt !
  !R Hndl! HK fs RGETTY"N	    !* Prepare for input !
    :I*Cfs ECHO DIS ' "# :FT ' !* Clear echo area !
  @FT 2  !E Hndl !		    !* Prompt for handle !
  < Q..8[..O FI u0 ]..O		    !* Read a char !
    Q0 f   "L	    !* Not a special char !
      Q0I fs ^R MODE"N -1 @T ' !<!> '	    !* accumulate and echo !
    Q0-13 "E HFX..4 O End Read  '  !* If <CR> we're finished !
    Q0-21 "E O R Hndl  '	    !* If ^U start over !
    Q0-27 "E 0; '		    !* If <Esc> then end of handle !
    Q0-17 "E Q..8[..O FI u0 ]..O    !* If ^Q read and insert !
      Q0I fs ^R MODE"N -1 @T ' !<!> '	    !* next char !
    z "E 0 '			    !* Must be Rubout, if nothing, quit !
    zJ 0A u0 -D			    !* Remove char to Q0 !
    fs RGETTY"E @FT0 '	    !* Echo it or !
      "# Q0-40. "L :I*C fs ECHO DIS	    !* erase it if we can !
          @FT2 @HT '	    !* !
	"# :I*X fs ECHO DIS ' ' !* !
    >				    !* loop !
  HFX..4 @FT$			    !* Handle into Q..4 !
  !R Rscan!			    !* Read Rescan Stuff !
  < Q..8[..O FI u0 ]..O		    !* Read a char !
    Q0 f   "L	    !* Not a special char !
      Q0I fs ^R MODE"N -1 @T ' !<!> '	    !* accumulate and echo !
    Q0-21 "E O R Hndl  '	    !* If ^U start over !
    Q0-27 "E @FT$ 0; '		    !* If <ESC> then end of string !
    Q0-13 "E Q0I 10I fs ^R MODE"N -2 @T ' !<!> '  !* <CR> needs <LF> !
    Q0-17 "E Q..8[..O FI u0 ]..O    !* If ^Q read and insert !
      Q0I fs ^R MODE"N -1 @T ' !<!> '	    !* next char !
    !Rub! z "E HK G..4		    !* Must be Rubout, if nothing !
      fs RGETTY"E :FT '	    !* Go back and !
      "# :I*C fs ECHO DIS '	    !* re-edit handle !
      @FT2 @HT O E Hndl  '    !* !
    zJ 0A u0 -D			    !* Remove char to Q0 !
    fs RGETTY"E @FT0 '	    !* Echo it or !
      "# Q0-40. "L :I*C fs ECHO DIS	    !* erase it if we can !
          @FT2..4$ @HT '   !* !
	"# :I*X fs ECHO DIS ' ' !* !
    >				    !* loop !
  FI-27 u..6 q..6-100 "E	    !* Gobble next char, note <ESC> & Rubout !
    :I*X fs ECHO DIS O R Rscan '	    !* If Rubout, back into loop !
  HFX..5				    !* RSCAN stuff to Q..5 !
  !End Read!
'
      "# :i..4W
         fq..4 :"G :i*No_Handle_Name_Given.__Taking_Previous_Fork.
fsechodispW
	   0fsechoac ..60	    !* Give the error message and wait 2!
				    !* seconds so that the user becomes!
	   :i..4W'		    !* aware of it!
	 :i..5w
	 fq..5 :"G 1u..6 w:i..5w'
	   "#			    !* The second string argument is the!
				    !* rescan buffer and only if something!
				    !* is there do we read the third one.!
	     :i..6W
	     fq..6"G 0u..6' "# 1u..6'	    !* A third string argument implies to!
				    !* set the rescan buffer to read!
	   '
      '
  :I2frk..4W		    !* Q2 = frk"handle" !
  QForklist U3		    !* List of handles !
  :FO..Q2 "L -1M.V2	    !* If handle dosen't exist !
           :I*-- dead -- M.Vf2
           :I33..4 '  !* then create it !
  Q3 UForklist		    !* and put on list !
  Q..4 :FC U..4			    !* Handle to uppercase !
  Q2 "L			    !* If fork does not exist yet !
     F=..4EXEC "E		    !*  See if EXEC fork !
	1U4 O Go '		    !*  skip the question !
     fs MSNAME U3		    !*  Try working directory !
     :I33..4.EXE
     E?3 "E O ask '		    !*  Yes it works !
     fs HSNAME U3		    !*  Try home directory !
     :I33..4.EXE
     E?3 "E O ask '		    !*  That works !
     :I3SYS:..4.EXE	    !*  Otherwise must be SYS: !
	ET<>			    !* [PJG] Get rid of the directory!
     !ask!
	ET3			    !* [PJG] Default name!
     5,FFilename U..4	    !* [PJG] Get it with recognition!
     Q..4 "E  '		    !*  Delete past end, quit !
     FQ..4 "G ET3 ET..4	    !*  If something there, use that !
        FS D FILE U3 '		    !*  with the defaults !
     E?3 "N :I*File_not_found:_3 fs ERR  ' !* No file, punt !
     Q3 Uf2			    !*  Record file name !
     '
     "# :f+1"N f*' '	    !* ignore string if second call for handle!
  !Go!
  0FO..Q Exit_to_Inferior_Hook U..4 Q..4"N M..4'  !* Call hook if there !
  Q2 F( "E 0..7FZ..5 O End ' !* Call last EXEC !
    ) "G Q..6 "N Q2 ..7FZ..5 '	    !* Old Fork !
        "# -1,(Q2) ..7FZ..5 ' !* Force read !
      O End  '			    !* End of old forks !
  Q4 "E Q..6 "E -1, ' ..7FZ3_..5 u2	    !* New non-EXEC fork !
    O End  '			    !* !
  -1,0..7FZ..5			    !* New EXEC fork !
  ! End !
  Q2 F"L W 0 ' Ufrk	    !* Save for defaulting !
  0FO..Q Return_From_Inferior_Hook U..4 Q..4"N M..4'	    !* Call hook if there !
  w				    !* And quit !

!^R Kill Inferior:! !^R Kill an inferior fork.
Reads the string arg. as the handle name and kills the associated fork.
You cannot default the handle name nor kill the EXEC fork
though you can define a new EXEC fork which kills the old.!

  [1 [2 [3
  1,(:i*)FHandle_name:_ U2	    !* Get handle name !
  :I1Can't_default_Kill_Handle
  Q2 "E  ' FQ2 "E Q1 :FG  '    !* don't do it if null or deleted !
  :I1Can't_Kill_EXEC_Fork
  F~2EXEC"E Q1 :FG  '	    !* Don't Kill EXEC Fork !
  :I12__Illegal_or_Unknown_Fork_Handle
  0FO..Qfrk2 U3 Q3"E Q1 :FG  ' !* Don't kill * or nonexistant Fork !
  Q3 "L  '			    !* Already Killed !
  -Q3 FZ			    !* Kill it !
  m(m.m Kill_Variable)ffrk2
  m(m.m Kill_Variable)frk2
  f[b bind gforklist		    !* Remove the handle from list of handles!
  j :s2"l fk+1d' hxforklist
  Qfrk-Q3 "E 0 Ufrk '	    !* If last, set last back to EXEC !
  				    !* Done !

!List Handles:! !C List names of handles used to invoke inferiors.!

  Qforklist [1		    !* Get list of handles !
  FQ1 [2 1[3 1[4 [5 :I*[6 [7 [8    !* Save working Q-regs !
  < Q3-Q2 ;			    !* End of forklist !
     Q3 :G1 - 27 "E		    !* Is it end of handle? !
        Q4,Q3 :G1 U5		    !* Yes, handle to Q5 !
	20 - FQ5 F"LW4',. :I7	    !* [RDH] Spacing in Q7 !
	Qffrk5 U8		    !* File in Q8 !
	:I66578
				    !* Add a new line to output !
        %3 U4 '			    !* And update pointers !
     %3 >			    !* Loop !
  :FTHandle_names:
_
6				    !* Type it !
  :FI				    !* Wait !
  				    !* and exit !

!& Read Forkname:! !S read a fork name and return string.!

    :i*sys:-.exe.0f[ d file	    !* set defaults.!
    23.f[:etmode		    !* default sys:, .exe and .0 !
    @:ft			    !* maybe prompt.!
    -1fs echo active		    !* be nice.!
    160200.:et			    !* interact.!
    fs d file 		    !* and return resulting string.!

!Execute Ephemeron:! !C Runs a program (.exe file) below EMACS.  The program
is run "ephemerally" and is gone once it exits or is ^G'd out of.  Program
name is read twenex style in bottom window.!

    m(m.m&_Read_Forkname)Ephemeron:_[0	    !* get arg string!
    :i*Z fs echodis		    !* cursor to bottom!
    -(fz0)fz		    !* call the program, and kill it.!
    0u..h ]0 0			    !* redisplay right away!

!Display Ephemeron:! !C Like Execute Ephemeron, but holds the display
briefly  (until something is typed) after the program returns.!

    m(m.m&_Read_Forkname)Display:_[0		    !* get arg string!
    f+:ft			    !* clear screen!
    -(fz0)fz		    !* call the program, and kill.!
    ]0 0			    !* no buffer changes!
  