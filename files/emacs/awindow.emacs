!~Filename~:! !Editor & System windows on ambassador!
AWINDOW

!Ambassador Window Mode:! !C Enters two window (editor, system) mode
Without explicit argument just refreshes the screen.  Otherwise, NUMARG is
mode: 0 means clear window mode, 1 is the only defined mode right now, it gives
you two windows, both continuously displayed.  qAmbassador editing window and
qAmbassador system window are the window sizes; if these are not present they
will be set up to split the screen.  This macro sets up Return From Superior
and Exit hooks, if you want to have your own hooks executed put them in
Ambassador Old Return Hook and Ambassador Old Exit Hook. Also, don't change
your terminal size while window mode is enabled.!


    [0[1[2
    FF&1"e				!* Explicit arg?!
	qAmbassador Window ModeF"nu1	!* No, was it enabled?!
	    m(m.m& Refresh Window 1)''	!* Yes, just refresh window !
					!* according to mode!
    "#"e				!* Turn it off?!
	qAmbassador Window Mode"n	!* Yes, only if turned on!
	    m(m.m& Ambassador No Windows)''	!* Do it!
    "#"'l(-2"'g)"n:i*Illegal Ambassador Modefserr'
					!* If <0 or >maximum, give error!
    :\u0				!* arg as decimal digits!
    qAmbassador Window Mode"n		!* is it enabled now?!
    	m(m.m& Ambassador No Windows)'	!* turn it off to switch to new mode!
    fsheightm.vAmbassador Old Screen Size	!* remember current height!
    Fm(m.m& Ambassador Mode 0)	!* Enable the mode!
    m.m& Ambassador Return Hook 0m.vReturn From Superior Hook
    m.m& Ambassador Exit Hook 0m.vExit Hook
    	!* Make Hooks for the mode !
    m.vAmbassador Window Mode	!* Say in new mode!
    '

!& Ambassador No Windows:! !S Turn off window mode.!
    [0[1
    0fo..qAmbassador Old Return Hookm.vReturn from Superior Hook
    0fo..qAmbassador Old Exit Hookm.vExit Hook
    qAmbassador Old Screen SizeF(u0):\u1
!* Total screen size, number to 0 decimal digits, to 1!
    q0m(m.m& Set Terminal Height)
    fs tty init		!* Restore height, get teco to see it!
    @:i*/[1;;;1p/fsimage out	!* Restore screen!
    -1fs pjaty			!* Screen needs redisplay!
    0uAmbassador Window mode''	!* Say turned off!

!& Ambassador variable defaulting:! !S checks that the variables
ambassador editing window and ambassador system window are defined, and
defaults them to ^X,^Y if they are not.  BOTH variables must be defined
and non-zero or both will be defaulted!
    0[0					!* count!
    0fo..qAmbassador Editing Window"n %0'	!* Count it if specified!
    0fo..qAmbassador System Window"n %0'	!* this one too!
    q0-2"n				!* Not both there?!
    	m.vAmbassador Editing Window	!* not there, set them!
	m.vAmbassador System Window'


!& Set Two Terminal Heights:! !S sets teco's idea of terminal height
to precomma arg, system's idea to postcomma.!
    m(m.m& Set terminal height)	!* Set height to top window!
    fs tty init			!* Get TECO to see new height!
    m(m.m& Set terminal height)	!* Set height for system!

!& Ambassador Mode 1:! !S Enable mode 1!
    [0[1
    fsheight/2F(,)-1m(m.m& Ambassador Variable Defaulting)
					!* Default to split screen!
    qAmbassador Editing Windowu0
    qAmbassador System Windowu1
    q0,q1m(m.m& set two terminal heights)	!* Set heights!
    m(m.m& Refresh Windows 1)		!* Configure the terminal!
    

!& Ambassador Return Hook 1:! !S Code to configure mode 1 on return from exec!
    qAmbassador System Window[1	!* Lower size to 1!
    q1+1:\[2				!* +1, as decimal digits to 2!
    q1+qAmbassador Editing Window+1:\[3	!* Total size, decimal, to 3!
    @:i*/[3;;2;3p/fsimage out
!* Configure screen with memory and page set to total size, lower host
area to system window size plus 1 for dashed line !
    0fs PJATY				!* Screen does not need updating!
    0fs old mode			!* except for mode line!
    0fo..qAmbassador Old Return Hook[0	!* See if user has a hook for us!
    q0"n m0'

!& Ambassador Exit Hook 1:! !S Code to configure tty for exec !
    qAmbassador Editing Window[1	!* Upper size to 1!
    q1+1:\[2				!* +1, as decimal digits to 2!
    q1+qAmbassador System Window+1:\[3	!* Total size, decimal, to 3!
    @:i*/[3;2;;3p/fsimage out
!* Configure screen with memory and page set to total size, upper host
area to editing window size plus 1 for dashed line !
    0fo..qAmbassador Old Exit Hook[0	!* See if user has a hook for us!
    q0"n m0'				!* If so do it, if not, return!

!& Refresh Windows 1:! !S Draw dashed line, put us in upper window!
    qAmbassador System Window[1	!* Lower size to 1!
    q1+1:\[2				!* +1, as decimal digits to 2!
    qAmbassador Editing Window[3	!* Upper size to 3!
    q1+q3+1:\[4				!* Total size, decimal to 4!
    q3+1:\[5				!* Upper + 1, decimal, to 5!
    @:i*/[4;;;4p[2J[5;H----------------------------------------------------------------[4;;2;4p/fsimage out
!* Configure with whole screen addressible, clear, address to end of upper
   area, draw line of dashes, configure with dashes and system window in lower
   host area !
   -1fs PJATY				!* Say screen needs update!

!& Ambassador Mode 2:! !S Enable mode 2, screen-switching mode.
In this mode, there are two logical screens, only one of which is displayed at 
once.  The two screen sizes are controlled by variables Ambassador Editing
Window and Ambassador System Window, which should both be sizes which the
ambassador can display and should not sum to more than 60. NOTE: I am so
convinced that you want two 30-line windows, that it will give you that unless
you specify a precomma arg.!
   [0[1[2
   "n30,30m(m.m& Ambassador Variable Defaulting)'
!* If precomma arg, look at variables, otherwise just use 30,30 !
   "#30m.vAmbassador Editing Windowm.vAmbassador System Window'

   qAmbassador Editing Windowu0 qAmbassador System Windowu1
   q0,q1m(m.m& Set Two Terminal Heights)	!* Set heights!
   m(m.m& Refresh Windows 2)		!* configure terminal!
   

!& Refresh Windows 2:! !S Configure screen for mode 2!
   qAmbassador Editing Window:\[0	!* desired screen size, decimal!
   @:i*/[60;;;60p[2J[0;;;0p/fsimage out
!* Clean entire display memory, configure screen using only number of
   lines in editing window !
   -1fs PJATY				!* Screen needs update!
   

!& Ambassador Return Hook 2:! !S Code to configure mode 2 on return from exec!
   qAmbassador Editing Window:\[0
   qAmbassador System Window:\[1
   @:i*/[60;;;0p[1s[0;;;0p/fsimage out
!* Use whole screen memory, push system window lines from top to bottom,
   narrow to use only editing window lines at top of memory !
   0fs PJATY				!* No update anything!
   0fo..qAmbassador Old Return Hook[0	!* Look for a hook to run!
   q0"n m0'

!& Ambassador Exit Hook 2:! !S Code to return to system in mode 2!
   qAmbassador Editing Window:\[0
   qAmbassador System Window:\[1
   @:i*/[60;;;1p[0s[1;;;1p/fsimage out
!* Use whole screen memory, push editing window to bottom, narrow to using
   system window at top of screen !
   0fo..qAmbassador Old Exit Hook[0	!* See if user has a hook!
   q0"n m0'

!& Ambassador Mode 3:! !S Enable mode 3, text-saving window mode.
This mode is controlled by several variables,  which must be set up in advance,
or else the default is used.  The variables are:

Ambassador System Window:  how many lines you want to use for non-emacs stuff
Ambassador Editing Window: how many lines you want to use for all of EMACS
 (buffer, mode line, echo area).  Normally these two variables will add
 to 60.
Ambassador System Screen: the number of lines to be on the SCREEN while
not in emacs.  These consist of the last part of the .... !
:i*Mode 3 is not availablefs err
   

!& Set Terminal Height:! !S Do a MTOPR to set terminal height.!
   [0[1[2
!*   0fo..q& Terminal Height code"e!	!* If code not there, make it!
	11*5fs q vectorM.V& Terminal Height code
	q& Terminal Height codeu0		!* Get q-vector in q0!
	!* skip !		330000000000.u:0(0)
	!* push p,2 !		261740000002.u:0(1)
	!* push p,3 !		261740000003.u:0(2)
	!* movei 1,.priou !	201040000101.u:0(3)
	!* movei 2,.MOSLL !	201100000033.u:0(4)
	!* MTOPR !		104000000077.u:0(5)
	!* pop p,3 !		262740000003.u:0(6)
	!* pop p,2 !		262740000002.u:0(7)
	!* aos (p) !		350017000000.u:0(8)
	!* ret !		263740000000.u:0(9)
' !* end of code not created conditional !
    q& Terminal Height code[..O	!* select code as buffer!
    fs real address/5u0		!* get address!
    ]..O				!* get old buffer back!
    m0				!* Do the code, pass the arg, return!

!& Setup AWINDOW library:! !S Make variable!
0m.vAmbassador Window Mode		!* Say no modes enabled!
