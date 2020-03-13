!* -*-TECO-*- *!
!* This file requires EMACS;IVORY -- not EMACS;PURIFY.!

!*
 * This library contains functions for aiding the writing, editing, and
 * debugging of EMACS functions, generally assuming the use of the IVORY (not
 * PURIFY) library for library generation.  Note that this library is
 * basically UNSUPPORTED -- it is primarily used by ECC, EAK, FJW.  We do not
 * have time to make this a maintained package, but anyone can use it at
 * their own risk.
 * Unless someone objects strenuously, this library will assume TMACS is
 * loaded.
 *!

!* Recent modifications:
 * 9-Sep-82 ECC	  208	Add Remove (TEST) Suffix.  Extend EMACS Function
			Occur to filter on names too.  Add Goto Function and
			Bound variable.  Fix yanker to change excls to ^^s.
 !
!~FILENAME~:! !Functions for examining/patching EMACS functions.!
FIXLIB

!& Setup FIXLIB Library:! !S Make a few variables.!

 m(m.mKill Variable)MM Backtrace	!* Install our own Backtrace.!
 m.mBacktracem.vMM Backtrace		!* ...!
 

!Remove (TEST) Suffix:! !C Trims an MM-variable to proper name part.
String argument is command name.  If null, reads it with completion.
After a Test Load has left a (TEST) suffix, completion will be ambiguous.
    Using this command will change the MM-variable from, say, MM Foo (TEST)
    to just MM Foo.
Note that this means that various commands won't be able to recognize this
    MM-variable as a test function any more.!

 8,fTest Command: [1			!* 1: Command name or null.!
 fq1"e @:m(m.mRemove (TEST) Suffix)'	!* If null, call with @M so will read!
					!* name with completion.!
 f~(fq1-7,fq1:g1) (TEST)"e 0,fq1-7:g1u1'	!* Strip any (TEST) from name.!
 @:fo..qMM 1 (TEST)"l :i*No MM 1 (TEST) variablefsErrw'
 qMM 1 (TEST)(			!* Keep same value: function object.!
    m(m.mKill Variable)MM 1 (TEST)w	!* Kill old suffix-form.!
    )m.vMM 1w			!* Make new plain-form.!
 @:fo..qMM ~DOC~ 1 (TEST)"g		!* See if any doc to convert too.!
    qMM ~DOC~ 1 (TEST)(		!* Keep same value: documentation.!
      m(m.mKill Variable)MM ~DOC~ 1 (TEST)w	!* Kill old.!
      )m.vMM ~DOC~ 1w'		!* Make new.!
 

!^R Insert Variable Name:! !^R Reads variable name with completion.
Surrounds variable name with Altmodes for convenience unless given a NUMARG.
Leaves MARK at beginning of name.!

 m(m.m& Declare Load-Time Defaults)
    CRL List, Symbol table argument to & Read Command Name: 0
    CRL Prefix, Prefix string argument to & Read Command Name: 0

 [1
 :i*[CRL Prefix q..q[CRL List	!* Arguments to completing reader,!
					!* telling it to use ..Q so we get a!
					!* variable name, and to consider!
					!* all names, in their entirety.!
 8+2,fVariable name: u1		!* 1: Variable name.!
 .:w					!* Set MARK before name.!
 .,(ff&1"e 33.i g1 33.i'		!* Insert Altmode, name, Altmode if!
					!* no NUMARG.!
    "# g1'				!* Insert just name if NUMARG.!
    ).

!^R Insert EMACS Function Name:! !C Uses completion.  Leaves MARK before name.
Adds an Altmode at end unless given a NUMARG.
If name ends in parenthesized expression, e.g. (TEST), we strip it
    off if Strip (TEST) Suffix etc. is non-0.!

 m(m.m& Declare Load-Time Defaults)
    Strip (TEST) Suffix,: 1


 8,fFunction Name: [1		!* 1: Name.!
 .					!* Leave MARK.!
 .,( g1					!* Insert the full name.!
     0,0a-)"e				!* Need to check for suffix-stripping.!
       :f[VB fsZ-.f[VZ		!* Bound to just the full name.!
       :< -flfx1			!* 1: Suffix.!
	  0fo..qStrip 1 Suffix"e .(g1)j'
					!* If keeping suffix, get it back.!
	  >w				!* Continue for all suffixes.!
       zj f]VZ f]VB			!* Restore point, bounds.!
       -@f 	k'		!* Remove leftover whitespace.!
     ff&1"e 33.i').		!* Finish with altmode unless NUMARG.!

!& Read Q-Reg Name:! !S Read name of qreg, return as string.
Given a numeric argument, uses it as the first character of the q-reg name.
^K is short for ..K(0) (last killed text),
=  is short for the last q-reg name read,
^M is short for .N(0) (last mini-buffer contents),
 will read a variable name with completion,
; also but selects the variable's comment,
 will read a function name with completion,
 reads an FS-flag name with & Read FS-Flag Name or & Read Line,
( reads a line, a macro yielding a string (e.g. q:.x(3) for qvectors).
?  gets help.!

 m(m.m& Declare Load-Time Defaults)
    CRL List, Symbol table argument to & Read Command Name: 0
    CRL Prefix, Prefix string argument to & Read Command Name: 0


 0[1 [2[3				!* 1: 0 or qreg name.!
 ff"n u2'				!* 2: Qreg name first letter.!
 "#   < m.i fiu2			!* 2: First letter.!
	q2-?:@; m(m.mDescribe)& Read Q-Reg Name >'
 q2-="E 0fo..qLast QReg Typedu1'	!* If = we do out stuff.!
 (q2-;"'e)(q2-"'e)"n		!* If either  or ;, then...!
	:i*[CRL Prefix		!* Arguments for completing reader!
	q..q[CRL List			!* to read variable name.!
	2,m(m.m& Read Command Name)Variable: u3	!* 3: variable name.!
	q2-"e			!* We want the value.!
	  :i13'		!* 1: qreg name form to return.!
	"#				!* We want the comment.!
	  :i1:..q(:fo..q3+2)''	!* 1: qreg name form to return.!
 q2-!"e 8,m(m.m& Read Command Name)Function name: f"e'u1 !* 1: function name.!
	  :i1(m.m1)'
 q2-"e 1,m.m& Read FS-Flag Namef"nu3 m3u3'	!* 3: Fs-flag name.!
	   "# 1,m(m.m& Read Line)FS-Flag: u3'	!* ...!
	   fq3:"g 0'			!* Abort if 0 or null.!
	   :i1(fs3)'		!* 1: qreg name form to return.!
 q1"E q2m(0,(m(m.m& Get Library Pointer)EMACS)m.m & Read Q-Reg Name)u1'
 q1m.vLast QReg Typedw
 q1 

!^R Teco End Conditional:! !^R Inserts ', then shows matching ".
Does show-match only in TECO mode, and if the variable Display Matching TECO
    Conditional is non-0.
If Display Matching TECO Conditional is negative, only show if on-screen.
Absolute value of Display Matching TECO Conditional is number of seconds to
    stay at ".!

 m(m.m& Declare Load-Time Defaults)
    Display Matching TECO Conditional,
      * 0 disables, + show, - show if onscreen. Absval is time: 1


 [0[1[2
 !"! .,(f,'i).f		    !* Insert first.!
 qMODEu0			    !* 0: Mode name.!
 f~0TECO"n 1'		    !* Not TECO mode, just return.!
 z-.u0 fnz-q0j			    !* 0: Auto-restoring point.!
 fsrgetty"e 1'		    !* If printing terminal, return.!
 !"! 0fo..qDisplay Matching TECO Conditionalu1	!* 1: Flag.!
 q1"e 1'			    !* Flag off, just return.!
				    !* ..1,2: Prepare for f dispatch: !
 1u..1 :i2 @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    A(   @    @    @    @    ?)   @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @    @   
				    !* Count " 's!

 b,. @f2			    !* Back to matching double-quote.!
 q..1-1"L FG w 1 '		    !* No matching double-quote.!
 fsWindow+b-."g q1"l 1''	    !* Flag negative, offscreens dont show.!
 1@v				    !* On-screen or flag positive, show.!
 q1f"lw-q1'*30: 1		    !* Wait there for |flag| seconds.!

!^R Forward Teco Iteration:! !^R Move over next iteration(s).
Numeric argument is number of iterations to go forward.  Negative
    means go backward, same as ^R Backward Teco Iteration.
Ignores any <s or >s in comments and will not move out of the current
    source function.!

 "l -@:m(m.m^R Backward Teco Iteration)'
 0[1 .[3 fnq3j				!* 3: Point to restore.!
					!* 1: Iteration count.!
 f[VB f[VZ @m(m.m^R Ivory-Bound This Page)w	!* Just this function.!

 <					!* Move over n iterations.!
    1f<!Balanced!			!* This exits after a balanced!
					!* iteration.!
      <	:s<>!*;		!* Find next < or > or comment.!
	0a-<!>!"e %1w'		!* 1: If an iteration, bump count so!
					!* will skip over it.!
	0a-!<!>"e q1-1u1		!* 1: If end of iteration, slump!
					!* count.  If 0 we are done.!
	  q1"l .u3			!* 3: Keep point here.!
	       @ft(up) 0fsEchoActivew 0'	!* Up a level, so quit.!
	  q1"e .u3 f;Balanced''	!* 3: Will keep point here.!
	0a-*"e s!' >			!* If at comment, skip past it.!
      q1"e @ft(no more) 0fsEchoActivew 0'	!* ...!
      @ft(no end) 0fsEchoActivew 0 >	!* ...!
    >					!* Done n iteration moves.!
 0

!^R Backward Teco Iteration:! !^R Move over previous iteration(s).
Numeric argument is number of iterations to go backward.  Negative
    means go forward, same as ^R Forward Teco Iteration.
Ignores any <s or >s in comments and will not move out of the current
    source function.!

 "l -@:m(m.m^R Forward Teco Iteration)'
 0[1 .[3 fnq3j				!* 3: Point to restore.!
					!* 1: Iteration count.!
 f[Window				!* Will try to restore.!
 f[VB f[VZ @m(m.m^R Ivory-Bound This Page)w	!* Just this function.!

 <					!* Move over n iterations.!
    1f<!Balanced!			!* This exits after a balanced!
					!* iteration.!
      <	-:s<>!
;					!* Find previous < or > or comment.!
	1a-!<!>"e %1w'		!* 1: If an iteration end, bump count!
					!* so will skip over it.!
	1a-<!>!"e q1-1u1		!* 1: If iteration, slump count.  If 0!
					!* we are done.!
	  q1"l .u3			!* 3: Keep point here.!
	       @ft(up) 0fsEchoActivew 0'	!* Up a level, so quit.!
	  q1"e .u3 f;Balanced''	!* 3: Will keep point here.!
	1a-!"e -s!' >		!* If at comment, skip past it.!
      q1"e @ft(no more) 0fsEchoActivew 0'	!* ...!
      @ft(no start) 0fsEchoActivew 0 >	!* ...!
    >					!* Done n iteration moves.!
 0

!^R Goto Teco Function:! !^R Function name taken from left of point.
Picks up teco function name to left of point, using ^R Goto Previous M.M.
But NUMARG tells it to just grab function name from point forward to altmode.
Calls Goto Teco Function to do the move, which may leave MARK behind.
The option variable Goto Function and Bound controls whether the
    bounds are set.!

 [1
 ff"e -3 f~m.m"n			!* If not at function name,!
    @m(m.m^R Goto Previous M.M)w''	!* move to it.!
 @f	 l				!* Past leading whitespace.!
 .,(s r -@f	 l).x1		!* 1: Function name.!
 m(m.mGoto Teco Function)!1:!	!* Go, using full name.!

!Goto Teco Function:! !C Go to definition of STRARG.
STRARG may be a partial name, a search string to use within each
    function name.  Force full name search by using Foo:.
Argument means find another function matching the name.
The option variable Goto Function and Bound controls whether the
    bounds are set.
Calls & Maybe Push Point to leave MARK before jumping to function
    definition.!

 m(m.m& Declare Load-Time Defaults)
    Goto Function and Bound,
    * If non-0 the Goto ... Function commands set bounds around function: 0

 1,fGoto Teco Function: [1		!* 1: Function name search string.!
 .[0[1[2[3 0fsVB[4 0fsVZ[5		!* 0,4,5: point, old bounds.!
 @fn| q0j q4fsVBw q5fsVZw fg|		!* Restore, beep if cannot find.!
 ff&1"e j'				!* From top if no NUMARG.!
 0u3					!* 3: 0 if not found.!
 < :s:!; 1u3 .u2 -2s! .,q2:fb1:; 0u3 q2j >	!* Find.!
 q3"n 0u..n				!* Stay here.!
      0l .fsWindoww			!* Make definition be at window top.!
      q0 m(m.m& Maybe Push Point)'	!* Maybe leave MARK behind.!
 qGoto Function and Bound"n @m(m.m^R Ivory-Bound This Page)f'
 0

!Who Uses:! !C Print names of all functions in pure space containing STRARG.
Matches inside function names or documentation strings are ignored.
Giving a NUMARG will do an Occur in the matching functions found.  (Give a
    0 if you only want the match lines listed.)!

 [0[1[2[3[4			    !* save regs!
 1,fWho Uses: u3		    !* 3: string arg!
 0s3 f[BBind		    !* save regs, set search default to!
				    !* string argument, get temporary buffer!
 fs:EJPage*5120+400000000000.u0    !* 0: pointer to first library!
 m.m& Maybe Flush Output[A	    !* A: check for typeahead.!
 0[I				    !* I: will hold ~Invert~ function.!
 < -fq0; @ftA g0 j @ftB	    !* get whole library into buffer!

   1,q0m.m~Filename~u2		    !* 2: filename!
   q2"e :i2((Anonymous))'	    !* anonymous if none!

   1,q0m.m~Invert~uI		    !* Fetch librs ~Invert~ function.!
   qI"E :@iI|[1<q1-1u1q1fp-100@;>q1| '  !* If none, make a wild guess.!

   < ma			    !* return if output flushed!
     :s; @ft.			    !* find next occurance of string arg!
     .+4+fk+q0u1		    !* 1: address of string in pure space!
     <q1-1u1 q1fp-100@;>	    !* back up to macro start!

     q1,q0mIu4			    !* Try to turn function into name.!
     q4"E !<!>'			    !* If no luck, lose.!

     0:g4-~"e !<!>'		    !* if name begins with ~ then ignore it!
     1:<q0m.m4>"n !<!>'	    !* if macro name not in FO table skip!
				    !* this occurance - its probably in a!
				    !* macro name!
     q2"n ftIn file 2:

	  0u2'			    !* if first macro found in this file,!
				    !* then print filename!
     ff&1"n ft4:

   '"# ft4
   '					!* print macro name!
     @ft+
     ff&1"n				!* NUMARG, so do Occur in macro.!
	q1-q0,(q1+fq1+4-q0)fsBoundariesw	!* Bounds around just macro.!
	j m(m.mOccur)3		!* Show matches in the macro.!
	ft================

					!* Show end of that macros matches.!
	0,(fsZ)fsBoundariesw'		!* Back to wide bounds.!
     q1+fq1+4-q0j		    !* skip to end of function in buffer!
     >
   q2"e ft
'				    !* print CRLF if typed anything in this!
				    !* file!
   hk q0+fq0+4u0		    !* 0: pointer to next library!
   >
 ftDone.

 

!EMACS Function Occur:! !C List functions in source file containing a string.
Buffer should be an EMACS source file.
The first string argument is a search string:  the functions whose source
    contains that string are listed.  Null string means don't show lines,
    just the function names.
The second string argument is a search string that further filters those
    matching functions:  only those functions whose names match this string
    are listed.
No NUMARG means do over whole file from top.
NUMARG means do over file from point.!

 [0[1[2[3[4[5
 1,fList functions containing: (
  1,fName filter: u4 )u0		!* 0,4: 1st, 2nd string args.!
 fq0"e 0u0'				!* 0: Null becomes 0.!
 fq4"e 0u4'				!* 4: ...!
 q..o(f[BBind q..ou5 [..o)u..o		!* 5: Temp buffer for name searches.!
 .:\u1 fn1j				!* Restore original point.!
 0f[VB 0f[VZ				!* Wide bounds.!
 ff"e bj'				!* No NUMARG means to top first.!
 -1u3					!* 3: Init last-label point.!

 <  q0"n :s0;'			!* Find next occurrence.!
    "# :s:!;'			!* ...!
    l fsZ-.fsVZw			!* Will look for name above here.!
    -:s
					!* Back to start of function.!
    :s:!"e :i2(unnamed section)'	!* 2: Get name of function.!
    "# 2r .,(-s!c).f x2'		!* ...!
    q4"n q5[..o hkg2j :s4(]..o)"e oNext''	!* Filter on function name.!
    .-q3"n q0"n ft

'	   ft2 q0"n ft:
'	   ft
	   '				!* Type function name if any found.!
					!* And if we havent before.!
    .u3					!* 3: Save this point so we dont type!
					!* this label again.!
    zj q0"n -t'				!* Maybe print the occur line.!
    !Next! zj 0fsVZw >			!* Wide bounds below!
 ftDone.
 

!& Maybe Backtrace:! !S Traces macro unless $Trace <stringarg>$ is 0.
If typeout on screen, will await a character before calling Backtrace.
    But if $Backtrace Should Smash Screen$ is non-0...
If no NUMARG, backtrace will show caller.
If any NUMARG present, then show NUMARG levels above caller:
   0 is show caller, 1 is show caller's caller...
Saves .1-.0 in $.1$-$.0$, calls MM Bactrace$.  Restores them after.
Saves ..0, ..1, ..2 in $..0$ etc.!
 :i*[1			    !* 1: stringarg.!
 1fo..qTrace 1"E '		    !* $Trace <stringarg>$ is 0, no trace.!
 ]1				    !* 1: Back to original.!
 q..h"N				    !* Typeout on screen.!
    0fo..qBacktrace Should Smash Screen"E  !* And dont smash.!
      FG @ftType character for backtrace fiw	!* Await user response.!
       fsEchoDisplay	    !* Clear echo area.!
      C  fsEchoDisplay''	    !* ...!
 0u..h
 1:<[.1[.2[.3[.4[.5[.6[.7[.8[.9[.0	    !* Save in case!
    [..0[..1[..2>		    !* this is a recursive call.!
 q.1m.v.1w			    !* Save dot-qregs where user can get.!
 q.2m.v.2w
 q.3m.v.3w
 q.4m.v.4w
 q.5m.v.5w
 q.6m.v.6w
 q.7m.v.7w
 q.8m.v.8w
 q.9m.v.9w
 q.0m.v.0w
 q..0m.v..0w
 q..1m.v..1w
 q..2m.v..2w

 [.1[.2[.3[.4[.5[.6[.7[.8[.9[.0	    !* So get restored after backtrace done.!
 [..0[..1[..2

 ff"E			    !* No NUMARG, backtrace shows caller.!
    2m(m.m Backtrace) '	    !* Backtrace, showing caller.!

 ff"N			    !* NUMARG, backtrace shows callers caller.!
    +2m(m.m Backtrace) '	    !* Backtrace, showing NUMARG levels!
				    !* above our caller.!

!Backtrace:! !C View the frames on the macro-pdl.  Indents compressed code.
Displays one invoked macro, copied into a buffer,
with point at the PC.  Then reads a command character:

 Linefeed or D goes down the stack (to earlier invocations),
 ^ or U goes up to more recent invocations,
 ^R calls ^R on what you see,  ^L clears the screen,
 B calls ^R on the buffer that was being edited,
 A shows the macros's arguments,
 I indents the code (binding Indent Teco Object),
 V displays a q-register's contents,
  runs a minibuffer, X runs MM command, Q exits.
 . sets the PC of the frame being examined, e.g. so you can back up and
   retry something that erred before,
 C continues erring function.!

 m(m.m& Declare Load-Time Defaults)
    Indent Teco Object, * If 0, Indent Teco Object is a no-op: 1


!* We take some care that our variables exist, without using the default
 * mechanism, just so that Backtrace (and other debugging aids) may be used
 * while EMACS is starting up, and may not have had time to create the
 * default variables.!


 :fo..qBacktrace Orig Buffer"l 0m.vBacktrace Orig Bufferw'
 :fo..qBacktrace Empty Unwind"l 0m.vBacktrace Empty Unwindw'
 :fo..qBacktrace Temp"l 0m.vBacktrace Tempw'


 1f[CtlMta 0f[HelpMac [..J
 [BackTrace Temp
 q..o[BackTrace Orig Buffer f[BBind	    !* Temp buffer for trace.!
 [BackTrace Empty Unwind
 !* Above this point, no user qregs should be pushed.!

 2[0				    !* 0: Temporarily push.!
  1:<-2fsBackTrace>"e
    -7 f~M:.N(0)"e %0w''
  ff"n u0'		    !* 0: Depth.!
  fsBackDepth-q0uBacktrace Temp
  ]0				    !* Pop back to no qregs pushed.!

 !NEW DEPTH, EMPTY FRAME!
				    !* Nothing on stack here.!
 fsQPPtr uBackTrace Empty Unwind
 [0[1 f[SString hk
 qBacktrace Temp:\u0 fsBackDepth-1:\u1
 :i..jBacktrace, depth 0/1
 1:< qBacktrace Tempf"lw 99999999'f(fsBackTrace  !* Insert trace.!
        )fsBackStringm(m.m& Macro Name)u0 !* 0: Name!
     :i..j..j, 0  
     >"n :i..j..j  '
 fr				    !* Set the mode line.!
 z"e iDepth gBacktrace Tempi out of range.'

 1,m(m.mIndent Teco Object)w		!* Indent if compressed.!

 fsRGetTy"e f+'
 qBackTrace Empty Unwind fsQPUnwind	    !* Empty frame.!

 !EMPTY FRAME!				!* Jump here whenever you have just!
					!* done an unwind.!

 [1

 !READ!					!* Can jump here when have NOT unwound.!

 0u..h @v 0u..h
 :fi:fcu1			    !* 1: character.!
 q1-4110."e ?u1 fiw'		    !* Turn HELP into ?.!
 "# @fi@fs^RCMac-(33.fs^RInit)"e Qu1''  !* And altmode into Q.!

 q1-D"e12.u1'q1-U"e^u1'
 q1-12."e qBacktrace temp-1uBacktrace temp	    !* Changing depth.!
	  !TO NEXT FRAME!
	  qBackTrace Empty Unwind fsQPUnwind    !* Empty frame.!
	  oNEW DEPTH, EMPTY FRAME' !* Go find next trace frame!
 q1-^"e %Backtrace tempw oTO NEXT FRAME'	    !* Changing depth.!

 q1-A"e qBackTrace Temp fsBackArgsf(f"e ftNo arguments.
					       :fiw oREAD'
	    )f-1"e oOneArg'	    !* See if 1 or 2 arguments.!
	  qBackTrace Temp fsBackArgsu0u1 !* 1,0: arguments.!
	  ftArg1:  q1m(m.m& Describe Value) ft
Arg2: 	  q0m(m.m& Describe Value) :fiw oREAD
	  !OneArg! ftArg: 
	  qBackTrace Temp fsBackArgs m(m.m& Describe Value)
	  :fiw oREAD'

 q1-."e :i*Set PC[..j	    !* Set modeline.!
	  hk qBacktrace tempfsBacktracew	    !* Get unindented!
	  			    !* Let user choose point for PC!
	  ]..j fr		    !* Reset modeline.!
	  .,qBackTrace TempfsBackPCw	    !* Set the PC.!
	  @ft(PC Set) 0fsEchoActivew	    !* Remind.!
	  oREAD'

 q1-"e f+ @v oREAD'		!* Redisplay!
 q1-I"e 1[Indent Teco Object	!* Indent the code.!
	      m(m.mIndent Teco Object)w	!* ...!
	      ]Indent Teco Object oREAD'	!* ...!
 q1-"e qBackTrace Empty Unwind fsQPUnwindw   !* Empty frame.!
	   !^R, NO HACK!
	   0[..f 		    !* ..F:  with empty frame and!
				    !* no buffer hacking allowed.!
	   qBackTrace Empty Unwind fsQPUnwindw   !* Empty frame.!
	   oEMPTY FRAME'

q1-"e m(m.m^R Execute Mini)@V oREAD'
q1-B"e qBackTrace Empty Unwind fsQPUnwindw	    !* Empty frame.!
	 qBackTrace Orig Buffer[..o	    !* ..O: Orig buffer.!
	 o^R, NO HACK'

q1-V"e qBacktrace Empty UnwindfsQPUnwind
	 :i..0View QR: m(m.m^R View Q-reg) :fiw oEMPTY FRAME'
q1-?"e FTYou are inside a break loop, running 
	 m(m.mDescribe)Backtrace @V oREAD'
q1- "e oREAD'
q1-C"e 1'			    !* Continue erring function.!
q1-X"e m(m.m^R Extended Command) oREAD'
q1-Q"n fg oREAD'		    !* Q quits the backtrace.!


!& Describe Value:! !S Tell type and value of NUMARG.
Caller may pass & Macro Name as a pre-comma value for efficiency.!

 fp+4"e := '			!* Number.!
 fp+3"e ftInvalid pure string pointer, =  := '
 fp+2"e ftInvalid impure string pointer, =  := '
 fp+1"e ftDead buffer, =  := '
 fp-0"e ftBuffer,  oPRINT'
 fp-1"e ftQ-Vector,  fq()/5:= ft words long '
 fp-100"e m(f"ew m.m& Macro Name')[1	!* Pure string.!
	    q1"n ft1 '		!* Has a name, just that.!
	    ftPure string,  oPRINT'	!* No name.!
 fp-101"e '				!* Impure string, fall through.!

 !PRINT!
 fq():= ft long: "
 0,30:g()[1 ft1" !''!
 

!Trace Function Call:! !C Trace when function STRARG1 called, returns.
MM Trace Function Call$Foo$ will print message when Foo is called and when it
    returns.
MM & Maybe Backtrace$Foo$ is called before the call.
STRARG2 is teco commands to call when tracing occurs.  Commands are
    passed an argument: 1 for call, 0 for return.
ARG initializes $Trace Foo$.!

 8,fTrace Function: (
     1,fTeco commands: [.2	    !* .2: Teco commands.!
	)[.1w			    !* .1: Function name.!
 1, m(m.m Untrace Function Call).1	    !* No complaint if not tracing.!
 q.2 m.v&& Trace Commands For .1w	    !* Called on call/return.!
 m.m.1m.v&& Real .1w	    !* Rename real one.!
 m.vTrace .1w		    !* ARG says whether initially backtrace.!
 @:i*|!&& .1 Tracer:! !S Prints when .1 called, returns.!
      fnm(m.m& Maybe Backtrace).1w  !* Initially wont backtrace.!
      @ft(.1 returned.)  0fs echo activew
      0m&& Trace Commands For .1	    !* Execute commands upon!
				    !* return.!
				    !* Need FN since will use :M to!
				    !* call so any stringargs passed.!
      m(m.m& Maybe Backtrace).1w	    !* Initially wont bactrace.!
      @ft(.1 called.) 0fs echo activew
      1m&& Trace Commands For .1	    !* Execute commands upon call.!
      f:m&& Real .1	    !* Xfer to real one.!
      | m.vMM .1w		    !* Put tracer in with real name.!
 

!Untrace Function Call:! !C Cancel a Trace Function Call for stringarg.
No STRARG means cancel all traced function calls.
ARG, means dont complain if not being traced.!

 8,fUntrace Function: [.1	    !* .1: Function name.!
 f[BBind			    !* Temp buffer.!
 m(m.m& Insert Prefixed Variable Names)&& Real .1	    !* Insert!
				    !* appropriate variables.!
 z"E ff-2"E '		    !* Dont complain if ARG,.!
     :i*Function .1 not being tracedfsErr'

 bj
 < :s&& Real ;			    !* Find next traced variable name.!
   :x.1				    !* .1: Function call part of name.!
   q&& Real .1m.vMM .1w	    !* Put back into MM-variable.!
   m(m.m Kill Variable)&& Real .1	    !* Cleanup.!
   m(m.m Kill Variable)&& Trace Commands For .1 !* ...!
   >
 

!List Traced Function Calls:! !C List MM Trace Function Call actions.
Tells whether each is set to call Backtrace
and lists any trace commands called upon entry or return.!
 f[BBind			    !* Temp buffer.!
 :i*&& Real [.1		    !* .1: Prefix for traced functions.!
 m(m.m& Insert Prefixed Variable Names).1	    !* Insert appropriate!
				    !* variables.!
 bj [.2 i
bj
 < :s.1; 0k 			    !* Just keep traced function call !
				    !* name part of varname.!
   :x.2 :l			    !* .2: Function call name part.!
   0fo..qTrace .2"N		    !* If set to call Backtrace,!
      32m(m.m& Indent)w	    !* ...!
      i(Backtrace)'		    !* ...then say so.!
   fo..q&& Trace Commands For .2u.2	    !* .2: Trace commands.!
   fq.2"G   fshpos-32"G 15.i 12.i' !* CRLF if have printed (Backtrace)!
	    32m(m.m& Indent)w i.2'    !* If any, get them.!
   >
 ht ft
Done. 

!Libfun:! !Get Library Function:! !C Return ptr to function str2 in str1.
1st Stringarg is library name.  Can be unloaded.
2nd Stringarg is function name.  If library unloaded, the function will be
    read in and put in $MM <function name> (<libname>)$.
    (Unless a variable of that name exists already;  then that variable's
    value is returned.  That is checked before looking if library loaded.
ARG,: copy into impure, MM-variable even if library was loaded.
ARG: means don't ask if conflict, just smash.!
 1,fLibrary: (
    1,fFunction name: [.2)[.1
				    !* .1: library name, with maybe sname.!
				    !* .2: function name.!
 f[DFile et.1 :EJ fsDFN1:f6[.5	    !* .5: Libname part, no sname.!
 [.3[.4
 f[:EJPage			    !* In case have to load library,!
				    !* will only be temporary.  DONT!
				    !* PUSH ANYTHING AFTER THIS.!
 0fo..qMM .2 (.1)f"N 'w	    !* MM-variable exists.!
 1,q.5m(m.m& Get Library Pointer)u.3	    !* .3: 0 or library ptr.!
 q.3"N				    !* Library is loaded already.!
    ff&2"E			    !* And no pre-comma argument.!
       0,q.3 m.m.2 ''	    !* So get function ptr and return.!
 "#				    !* Library is not loaded.!
    1 m(m.m Load Library).1u.3' !* .3: library ptr.!
				    !* Argument means dont call setup.!
 0,q.3 m.m~DOC~ .2u.4	    !* .4: Documentation string (pure).!
 !f.4+1"G		    !* EXCL occurs in ~DOC~ string.!
    f[BBind			    !* Grab temp buffer.!
    g.4 j<:s!;<EXCL>>	    !* Replace them with name.!
    hx.4			    !* .4: Documentation string.!
    f]BBind'			    !* Pop buffer so F[:EJ on top.!
 0,q.3 m.m.2u.3		    !* .3: function ptr (pure).!
 :i.3!.2 (.1):! !.4
From .1 library.!
.3				    !* .3: function string (impure).!
 f]:EJPage			    !* THROW OUT THE LOADED LIBRARY!
				    !* IF IT WAS JUST LOADED.!
 ff&1"E			    !* If no ARG check for conflict.!
  1,0m.m.2fp"G		    !* Libfun MM-var will conflict.!
    :fo..qMM .2"L		    !* But not with MM-variable.!
       :i*$MM .2 (.1)$ conflicts, but not with an MM-var.
Make it anyway? ,0 m(m.m& Yes or No)"E w ''
    "#				    !* Conflicts with MM-v.!
       :i*$MM .2 (.1)$ conflicts with an MM-var.
Kill old variable? ,0 m(m.m& Yes or No)"E w '
       m(m.m Kill Variable)MM .2'''	    !* Kill conflict.!
 q.3 m.vMM .2 (.1)w'	    !* Make libfun variable.!
 q.3 				    !* Return libfun string.!

!^R Examine Key:! !C Call Examine Function on a key.
If NUMARG then q-reg instead of key.!
 [1				    !* save q-reg!
 ff"e :i..0^R character to examine:    !* set prompt string!
	  m(m.m& Read Q-reg Name)u1'   !* 1: q-reg name!
       "# :i..0Q-register to examine: 	    !* set prompt string!
	  m(m.m& Read Q-reg Name)u1'	    !* 1: q-reg name!
 q1,q1:m(m.mExamine Function)    !* examine it, passing both the name (in!
				    !* case there is no real pure name) and!
				    !* the object.!

!Examine Function:! !C Look at function STRARG in recursive .
If NUMARG then use that as a function object to examine, like Describe.
Pre-comma NUMARG is an optional name for impure strings.
Sets modeline to indicate path of recursions of Examining -- i.e. a function
    call path.
Keys are rebound for convenience in ExFun mode.  Type HELP.!

 m(m.m& Declare Load-Time Defaults)
    Examined Function Name,: 0


 [0[1[..J[ w			    !* **** Push Space, as a hack, since!
				    !* ExFun makes it local and it may end up!
				    !* not having word abbrev one...!
 fp"l				    !* NUMARG is not a string object.!
    8,fExamine: u1w		    !* 1: Function name, maybe not full one!
    fq1"e m(m.m& Read Command Name)Examine: f"e'u1w'    !* If null!
				    !* STRARG, ask for name with completion!
    m.m1u0'			    !* 0: Function object to examine.!
 "# u0'			    !* 0: Use NUMARG string object.!

				    !* 0: The object to examine.!

 !* See if we need to push to examine buffer.!

 f~Buffer Name*Examine Function*"n	    !* Not in the buffer now.!
    [Previous Buffer
    qBuffer Nameu1 @fn| m(m.mSelect Buffer)1 |
				    !* Select back when done the examine.!
    m(m.mSelect Buffer)*Examine Function*'	    !* Get own buffer.!

 !* Get a temporary buffer for this recursive examine level, and ensure that!
 !* buffer and window switching will restore the temporary buffer, rather!
 !* than the primary buffer: !

 f[BBind [..o				!* Temporary buffer.!
 q:.b(qBuffer Index+4!*bufbuf!)[2	!* 2: .B buffer to restore when done.!
 @fn| q2u:.b(:i**Examine Function*m(m.m& Find Buffer)+4!*bufbuf!) |
 [2					!* Protect the saved buffer object.!
 q..ou:.b(qBuffer Index+4!*bufbuf!)	!* In this recursive level, pretend!
					!* that the temporary buffer is the!
					!* official EMACS one.!

 f~ModeExFun"n m(m.mExFun Mode)'	    !* Turn on examine mode if need,!
				    !* binding keys.!

 q0m(m.m& Macro Name)u1	    !* 1: Get full name if can.!
 q1"e				    !* Cant get a real (pure) name!
    "n u1			    !* 1: Get name from caller.!
	 fsOSTeco"n g1		    !* TNX outputs escapes etc in modeline!
		     j m(m.mUncontrolify) !* No controls are exempt.!
		     hfx1'	    !* 1: Presentable now.!
	 :i1(q1)'"# :i1(nameless impure string)''
				    !* 1: So make a name if not given one!
				    !* 0,1: Object, name.!

 qExamined Function Name"e	    !* Top level, no higher examined one.!
    !<! :i..J>1'		    !* ..J: Top level, no higher examined one!
 "# 1,fq..j-2:g..ju..j		    !* ..J: Not top, strip off [ ].!
    !<! :i..J..J>1'	    !* ..J: Mode line will show call path.!

 fq..j+12-(fsWidth)"g		    !* Mode line is too wide for screen.!
    (fq..j-(fsWidth)+12),(fq..j):g..ju..j  !* Trim it.!
    :i..j.....j'		    !* And indicate that.!

 g0 bj				    !* Get object to examine.!
 1,m(m.m Indent Teco Object)	    !* Indent it if compressed.  Do not!
				    !* complain about unmatches.!

 q1(qExamined Function Nameu1	    !* 1: Old name or 0 if top.!
    )[Examined Function Name	    !* Bind it to the new name.!

 q1"n bj  1'		    !* Not top level.  View and exit.!
 1f<!Top-Level-Examine!  bj >	    !* Top level, provide catch.!
 1

!ExFun Mode:! !C Go into Examine Function mode.  Bind keys.!

 m(m.m& Init Buffer Locals)	    !* .Q: Make local qreg.!

 1,(m.m& ExFun Help)m.qfsHelpMacro

 1,(0fs^RInit)m.qfs^RNormal	    !* Normal characters beep by default!
 1,(m.m^R Examine Next M.M)m.q 		    !* Space.!
 1,(m.m^R Quit Examining Function)m.qQ	    !* Q.!
 1,(m.m^R Goto Next M.M)m.qN		    !* N.!
 1,(m.m^R Goto Previous M.M)m.qP		    !* P.!
 1,(m.m^R Print Next M.M Call Paths)m.qC	    !* C.!
 1,(m.m^R Indent Examined Function)m.qI	    !* I.!
 1,(m.m^R Yank For Patching)m.qY		    !* Y.!
 1,(m.m^R Describe Previous M.M)m.q/	    !* /.!
 1,(m.m^R Describe Examined Function)m.q?	    !* ?.!
 1,(m.mExamine Function)m.qE		    !* E.!

 1m(m.m& Set Mode Line)ExFun	    !* Show ourselves.!
 

!^R Indent Examined Function:! !^R Indent this teco code.
Does not affect other examined code.!
 m(m.m& Declare Load-Time Defaults)
    Indent Teco Object, * If 0, Indent Teco Object is a no-op: 1


 1[Indent Teco Object			!* Bind it for now.!
 :m(m.mIndent Teco Object)		!* Indent us.!

!& ExFun Help:! !S ...!
 ftYou are examining a function.  Certain keys are rebound, in
particular Q (which will quit this) and Space (examine next).  Here is an
appropriate Apropos:

 m(m.mApropos)ExamineM.MPatching	    !* Hmmm.....!
 

!^R Yank For Patching:! !^R Into , Teco Mode.  Exit => Test Load, ExFun Mode.
Only for use inside Examine Function.  Uses *Patch* buffer.
If function is compressed, yank in the unindented, real stuff.  (If
    you want to keep the unreal, indented version, supply a NUMARG.)
    A header is put on it at the top.
Into  mode to let user patch it.
Then does -1 MM Test Load.!

 [1 .[2 [3 [..j				!* 2: Original point.!

 [..o					!* Must return to the right!
					!* (recursive) teco buffer.!
 qBuffer Nameu3 @fn| m(m.mSelect Buffer)3 |	!* Return to!
					!* this EMACS buffer.!

 qExamined Function Nameu1		!* 1: Name of function.!
 ff&1"e m.m1u3'"# hx3'		!* 3: Function, real or unreal.!

 m(m.mSelect Buffer)*Patch*w		!* To patch buffer.!
 f~ModeTECO"n m(m.mTECO Mode)'	!* Put it in teco mode.!

 hk g3 bj :s:!"e			!* Doesnt have a name, thus is some!
					!* compressed code.!
    j i!1:! !			!* Put on macro name part of header!
    .f[VB fsZ-.f[VZ			!* Temp bounds around doc.!
      1:< g(m.m~DOC~ 1)		!* Put on documentation string.!
	  j <:s!; > >w		!* Replace excls with C-^s.!
      zj f]VZ f]VB			!* Back to former bounds.!
    i
...patched...
!
   -:l'				!* Back up to add comment on why!
					!* patched.!

 qEditor Nameu..j :i..j..j 	!* Make up a standard mode line!
 :i*Patch 1[Editor Type		!* that tells the function patched.!
	!* Note that by being a standard mode line, & Set Mode Line will do!
	!* its work -- in particular call Set Mode Line Hook which will!
	!* process any word abbrev keys needed.!
 1fsModeChange				!* Make sure it computes modeline.!
 					!* Let user patch it.!

 m(m.mKill Variable)MM 1		!* Kill any (especially without!
					!* (TEST) suffix).!
 -1m(m.mTest Load)			!* Make uncompressed, without!
					!* checking if it is different.!
 hk 0fsXModifiedw 0fsModifiedw	!* Clean up for good looks.!
 

!^R Quit Examining Function:! !^R  Exit top level of Examine Function.
This works no matter how many levels of Examine Function recursion down
    you are -- you exit back through the top one.  (I.e. a throw.)!
 f;Top-Level-Examine		    !* Throw to top level quit.!

!^R Examine Next M.M:! !^R Examine this or next function M.M'ed.
If point is between M.M and function name, then examine that function.
Otherwise, move forward to next M.M and examine that function.
(Given NUMARG, takes name from point to altmode.)
Leaves point after name, so successive calls get successive M.Ms when
    examining some function.
Feeps if no next M.M.!

 [1
 ff"n			    !* NUMARG.!
    .,(sr).x1'		    !* 1: So take . to altmode.!
 "# 1:< 0,1m(m.m& Next M.M)f(x1    !* No NUMARG, 1: Function name.!
			      )jw   !* Move to end of name.!
	>"n fg ''		    !* No next function.!
 m(m.mExamine Function)1 

!^R Goto Next M.M:! !^R Move forward to next function call.
Negative NUMARG means go backwards.
Goes to the next NUMARGth M.M with function name not containing
    Control-]s.
Leaves point between M.M and function name.
Feeps if can't find another M.M.  If it can find one, but not NUMARG number
    of them, it does as many as it can, quietly.!

 [1
 1:< 1,m(m.m& Next M.M)u1j	    !* Goto between M.M and function name.!
     >"n fg'			    !* Cant.!
 1

!^R Goto Previous M.M:! !^R Move backward to previous function call.
Goes to previous NUMARGth M.M with function name not containing
    Control-]s.
Leaves point between M.M and function name.
Feeps if cant move.!

 [1
 1:< 1,(-)m(m.m& Next M.M)u1j    !* Got between M.M and function name.!
     >"n fg'			    !* Cant.!
 1

!& Next M.M:! !S Find next M.M with function name of no ^]s.
Returns bounds around that name.
Pre-comma NUMARG is flag saying whether to move past the current M.M.
    0,:  if already between M.M and function name, take that.
    1,:  if already between M.M and function name, move past first.
Post-comma NUMARG is number of M.Ms to go forward.
Negative means go backwards.
Point is not changed.
Errors if cant find any M.Ms.!

 [1[2[3[4[5 .[0 fnq0j [0	    !* Restore original point.!

 "l :i1-			    !* 1: Direction sign flag.!
      :i4fkc			    !* 4: Backup macro.!
      :i5 q2j 3r'		    !* 5: Backup macro for search start.!
 "# :i1 q1u4 q1u5		    !* 1,4,5: ...!
    "e -3 f~m.m"e 3r'''	    !* Backup if 1, before first search.!
 0u0				    !* 0: Found-one flag.!
 .u2				    !* 2: Set starting backup point.!

 1f<!Done!			    !* Go forward NUMARG good M.Ms.!
      1f<!Good M.M!		    !* Throw to here when find good one.!
	 <			    !* Keep trying next M.M until then.!
	1f<!Bad M.M!		    !* Throw to here if find is bad un.!
	   m5			    !* Maybe backup over M.M.!
	   1:sm.m"e fg f;Done'	    !* Couldnt find enough M.Ms.!
	   m4 .u2		    !* 2: Start of function name.!
	   :fb"e f;Bad M.M'    !* If  not on line, then fake M.M.!
	   r q2,.x3		    !* 3: Function name.!
	   fq3"e f;Bad M.M'	    !* No function name is bad.!
	   f3"l 1u0    !* 0: Found one.!
			     f;Good M.M'   !* No ^] is good ^].!
	   >>>>
 q0"e :i*No next M.M fsErr'	    !* Didnt find any M.Ms.!
 q2j				    !* To last found M.M.!
 .,(fb r -@f 	l).	    !* Return bounds around name.!

!^R Describe Previous M.M:! !^R Describe previous (or this) one M.M'ed.
If not at M.M, picks previous one, convenient when editing Teco code.!

 .[0[1 fnq0j			    !* 0: Auto-restoring point.!
 -3 f~m.m"n -1m(m.m& Next M.M)u1j'	    !* Back to one if need.!
 0,1m(m.m& Next M.M)x1		    !* 1: Function name.!
 m(m.mDescribe)1
 1

!^R Describe Examined Function:! !^R Describe one in buffer.!

 0fo..qExamined Function Name[1    !* 1: Name.!
 q1"e :i*Not examining any function fsErr'
 m(m.mDescribe)1
 1

!^R Print Next M.M Call Paths:! !^R On next M.M, or examined function.
If NUMARG, works on examined function in buffer.!
 [1
 ff"e 0,1m(m.m& Next M.M)x1'   !* 1: Next function.!
 "# 0fo..qExamined Function Nameu1 !* 1: Name of buffer function.!
    q1"e :i*Not examining any function fsErr''    !* None.!
 m(m.mPrint Call Paths)1	    !* Print away.!
 1

!^R Print Key Call Paths:! !^R Read a key, then do Print Call Paths.!
 [1
 :i..0Key to Print Call Paths on:  !* Prompt.!
  m(m.m& Read Q-Reg Name)u1    !* Get name of key qreg.!
 q1 m(m.m& Macro Name)u1	    !* Get its function name.!
 m(m.mPrint Call Paths)1 

!^R Insert Key Call Paths:! !C Read a key, do Insert Call Paths.!
 [1
 :i..0Key to Insert Call Paths on:  !* Prompt.!
  m(m.m& Read Q-Reg Name)u1    !* Get name of key qreg.!
 q1 m(m.m& Macro Name)u1	    !* Get its function name.!
 .,( 0m(m.mInsert Call Paths)1	    !* Get em.!
     ).

!Print Call Paths:! !C For function STRARG.  Saved in Call Paths.
NUMARG is temporary binding for depth limit.!

 [1
 8,fCall paths from: u1	    !* 1: Function name.!
 f[BBind			    !* Temp buffer.!
 ff&1"n ,'1m(m.mInsert Call Paths)1	!* Pass depth NUMARG as a!
					!* pre-comma depth NUMARG.  We give!
					!* it a NUMARG of 1 to tell it to!
					!* print as it goes along.!

 ftDone.			    !* Since incremental printing, is!
				    !* sometimes hard to tell.!
 hx* m.vCall Paths 		    !* Exit, saving this path list.!

!Insert Call Paths:! !S For function STRARG.
Non-0 NUMARG means print each line as it is inserted.
Pre-comma NUMARG is temporary finding for depth limit.!

!* Expects & Insert Call Paths to create Kill Call Path Flags.!

 [0[1[a[i[p[k[d
 8,fInsert call paths from: u0   !* 0: STRARG.!
 m.m0 m(m.m& Get Containing Library)m.vCall Path Libraryw
 m.mKill Variableuk		    !* K: Killer for cleanup.!
 0fo..qKill Call Path Flagsu1 fq1"g m1'    !* Cleanup old stuff.!

 :i* m.vKill Call Path Flagsw		!* Init subroutine.!
 m.m& Maybe Flush Outputua		!* ...A: Flusher.!
 m.m& Indentui				!* ...I: Indenter.!
 m.m& Insert Call Pathsup		!* ...P: Call pather.!
 0ud					!* D: 0 depth so far.!
 ff&2"n [Examine Function Maximum Depth'	!* ...!
 ,0mp0				!* Insert call paths.!
 0fo..qKill Call Path Flagsu1 fq1"g m1'	!* Cleanup new stuff.!
 mkKill Call Path Flagsw	    !* Kill it now that it is done.!
 

!& Insert Call Paths:! !S For function STRARG, indenting NUMARG.
Pre-comma NUMARG means print each line as it is inserted.
Checks Call Path <strarg> Flag for already done nodes, indicating by
    function name in parentheses, e.g. (Get Foo...).
Leaves Kill Call Path Flags as a macro to clean up.
    Assumes K will be bound to Kill Variable then.
Assumes following q-regs:
    A: & Maybe Flush Output
    I: & Indent
    P: & Insert Call Paths
Aborts via & Maybe Flush Output.
Each call deptch increases column by 4.
If NUMARG column is greater than Max Call Path Column (default 50), quit.
See options that control printing: Examine Function ....!

 m(m.m& Declare Load-Time Defaults)
    Examine Function Prints External Calls,
	* 0 means do not show, 1 means list, 2 means follow: 1
    Examine Function Prints Redundant calls,
	* 0 means do show only one call, 1 means (& Foo...): 1
    Examine Function Maximum Depth,
	* 0 means no limit: 0

 [0[1[2[3[d
 :i0				!* 0: Function name.!
 miw					!* Indent for next function.!
 f0:"l '			!* Ignore m.m^]... stuff.!
 1,m.m0u3				!* 3: 0 or function object.!
 q3"e i<0 ???>
					!* Indicate not found or whatever!
      "n -t' '			!* if couldnt do the m.m.!

 -(50fo..qMax Call Path Column)"g	    !* Too far down...!
    i...
   "n -t' '			!* ...So indicate and quit.!
 0fo..qCall Path 0 Flag"n		!* Cycle or listed before.!
    qExamine Function Prints Redundant calls"n	!* Show it,!
      i(0...)
     "n -t''				!* if user wants to see it.!
    '					!* Then done.!

 qExamine Function Maximum Depthu1
 q1"n %d-q1"g i0...
					!* List this one but no more deeper.!
	      "n -t'			!* Maybe type.!
	      ''			!* D: Depth, we stop if too deep.!

 qKill Call Path Flagsu2	    !* 2: Update killer.!
 @:iKill Call Path Flags|2
    mKCall Path 0 Flag|	    !* ...!
 1m.vCall Path 0 Flagw	    !* Note for later cycle-checks.!

 qExamine Function Prints External Calls-2"n	!* Dont follow externals.!
    q3m(m.m& Get Containing Library)u4	!* 4: 0 (impure) or library pointer.!
    q4"n				!* We will follow impure ones, since!
					!* they are likely of interest.!
      0fo..qCall Path Library-q4"n	!* Oops -- out of library.!
	qExamine Function Prints External Calls-1"e	!* List externals.!
	  1,q4m.m~FILENAME~u4		!* 4: 0 or Library name.!
	  q4"e :i4(anonymous)'		!* ...!
	  i[4: 0...]
					!* Tell use call is outside.!
	  "n -t''			!* Type it or just insert.!
	'''				!* Done if was external call.!

 g0 i
 "n -t ma'		    !* Else insert function name and maybe!
				    !* type it.!

 q..ou2				    !* 2: Buffer to insert into.!
 f[BBind [..o q..ou1		    !* 1: Temp buffer for function code.!
 g3 bj				    !* Get the code.!

 < q1u..o			    !* Select function buffer.!
   ma1;			    !* Maybe flush.!
   :sm.m; @f	 l		    !* Next M.M.!
   1< .,(:fb; r).x0		    !* 0: That function name.!
      q2u..o			    !* Select buffer to insert into.!
      ,+4mp0 > >	    !* Recurse -- insert paths.!
 

!& Get Containing Library:! !S Returns library pointer for NUMARG function.
NUMARG is function object.
Returns 0 if function object is not a pure string.!

 [0[1
 fp-100"n 0'			!* Not pure, return 0.!
 0u0					!* 0: Previous library.!
 fs:ejpage*5120+400000000000.u1	!* 1: 1st library.!
 <  fq1:"g q0'			!* End of libraries, return last.!
    -q1"l q0'			!* Past it, return last.!
    q1u0				!* 0: Previous update.!
    q1+fq1+4u1>				!* 1: Move to next library.!
 

!Indent Teco Object:! !C Indent approximately, by counting " ' < > ( ).
If buffer contains an uncompressed function, leaves it alone.
We restore point to the position it was in originally in the text.
If option Indent Teco Object is 0, this is a no-op.
1, argument means don't complain about unmatches.!

 m(m.m& Declare Load-Time Defaults)
    Indent Teco Object, * If 0, Indent Teco Object is a no-op: 1


 qIndent Teco Object"e '	    !* We might be a no-op.!
 .[9 bj :fb:!"l q9j'	    !* Uncompressed, just exit.!
 0[1				    !* 1: Level count.!
 q9j iPOINT		    !* Mark where point is.!
				    !* Superquote is there so we wont get!
				    !* fooled by ourselves!
 m.m& XIndent with Tabs[I	    !* I: Fast indenter.!

 :i*<[2 :i*([3 :i*)[4	    !* 234567: <()>"'.!
 :i*>[5 :i*"[6 :i*'[7	    !* ...!

 bj < l.-z; @f 	k >	    !* Remove leading whitespace that wasnt!
				    !* compressed out, so it doesnt screw up!
				    !* our own indentation.!
 bj 0s23				!* Set search default out of loop.!
 <:s; r i6 c>			!* Left parens/brackets get double-qs.!
 bj 0s45				!* Set search default out of loop.!
 <:s; r i76 c i7>		!* Rights get stuff....!

 bj 0s"'				!* set search default out of loop.!
 < fsHPositionu9			!* 9: Current column.!
   q1*4-q9"g q9,q1*4mi'			!* Indent if not past there.!
   "# i '				!* Just a space if past.!
   <:fbu9 q9;				!* 9: 0, -1, or -2 for not/"/' found.!
    q9*2+3+q1u1>			!* 1: Update level count.!
   q1"l 0u1'				!* 1: Min is 0, in case unmatched apos.!
   l.-z;>				!* Next line.!

 bj 0s6263			!* Set search default out of loop.!
 <:s; r -d c>				!* Back to lefts.!
 bj 0s76477657	!* Set search default out of loop.!
 <:s; -d r -2d c>			!* Back to rights.!
 bj 0s6				!* Set search default out of loop.!
 <:s; c1af 	"l i '>		!* Space after conditions for clarity.!

 ff&2"e			    !* No complaining if 1, NUMARG.!
    q1"n FG ftFinal level count non-0:  q1=   !* Bad final level count.!
	 q1"G ftSome <s, (s, and/or "s were unmatched. !')>!' !* ...!
	 "# !"(<! ftSome >s, )s, and/or 's were unmatched.'   !* ...!
	 ft

	 0fsechoactivew''				       !* ...!

 bj sPOINT fkd		    !* Reset point, remove mark.!
 

!^R Re-execute Minibuffer:! !^R Redo the last minibuffered command.
NUMARG means do NOT ask for confirmation.!

 0,30:G:.N(0)[1			    !* 1: Last command, trimmed.!
 ff"e @FTRe-execute command 1 !* Confirm unless NUMARG.!
    1m(m.m& Yes or No)"e 0''	    !* ...!
 M:.N(0)			    !* Do it.!

!* Following should be kept as (only) long comments, so will compress out:
 * Local Modes:
 * Fill Column:77
 * End:
 *!
