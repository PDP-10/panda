
!~FILENAME~:! !Library to load when called by HERMES.  !
HERMES				    !* This must be compressed with IVORY.!

!& Setup HERMES Library:! !S Special help for use with HERMES.
Structural problem:  The setup function has to do those things which are done
only once for setting up to use EMACS under Hermes.  Some other things have to
be done each time EMACS is started by Hermes.  (Note:  Hermes always starts
the fork, never continues it.)  Things done each time include visiting the
file that holds the message draft.  Since the startup actions can include
redisplay, we have to ensure that they happen AFTER ^R mode has been entered
(otherwise the redisplay screws up).  Hence this arranges for ..L to bind the
startup action (and code to restore the original fs^R Enter) to fs ^R Enter.
In summary, this is necessary because on Setup it does ^R mode, then ..L and
on Startup it does ..L, then ^R mode.  Clear?  !

 [1				    !* Save a register.!
 fsLispT"E '			    !* Only if actually called by HERMES.!
 fsJName:f6u1 f~1HERMES"N '	    !* ...!

 q..9 m.vPrimordial ..Lw	    !* Debuggery.!
 fs^REnter m.vPrimordial fs^REnterw	!* ...!

 q..L m.vOriginal ..Lw		    !* Save normal ..L here.!
 fsRefreshm.vOriginal Refreshw    !* Save regular screen refresh !
 @:i..L|  fs^R Enterm.vOriginal fs^REnter
   @:i*/			!* arrange for & Edit to happen when!
   qOriginal fs^REnterfs^R Enter	!* ^R mode is first entered each time!
   m(fs^R Enter)w		!* restore ^R Enter value and execute it!
   m(m.m& Edit Hermes Text)	!* then execute the Hermes startup!
   /fs^R Enter			!* put all that into fs ^R Enter!
   mOriginal ..L|		!* and prepend it to ..L so it runs each time!

 m.m& Exit EMACS m.vMM & Original Exit EMACSw	!* Save normal exiter here.!
 m.m& Exit to HERMES m.vMM & Exit EMACSw  !* Do our own first -- it will!
					    !* ..call into the normal one.!

 :iEditor Type[Hermes]	    !* Tell luser what is going on.!

		       !* Add some customizing for message handling !
                       !* but not too much or people get surprised.!
 1,:i*NOVICEm(m.m& Get Library Pointer)"e   !* if NOVICE not yet loaded !
   fs:ej page[1	   !*  save this in case we want to throw it away!
   1:< m(m.mLoad Library)NOVICE  >"n	!* set up for NOVICE handling!
     q1fs:ej page' ]1	   !* if load fails (from a throw), flush NOVICE!
   w'
 qParagraph Delimiteru1
 :iParagraph Delimiter1-   !* Add hyphen to para delim list.!
 :i*fo..qNovice Reminderu1	!* 1: Reminder printer, if any!
 @:i*|1@ft
Save and exit with C-X C-Z; Abort with M-X HERMES Abort<cr>.
0fsechoactivew|m.vNovice Reminder	!* extend reminder!

 m(m.m& Edit HERMES Text)	!* However, this time we must call this!
				!* manually, since ..L has already been!
				!* nabbed by the init file and we are!
				!* already in ^R mode.!

 				    !* Done with setup.!

!& Edit HERMES Text:! !S Setup on entry from superior HERMES.
Runs every time Hermes starts EMACS.  Hermes always starts the fork, never
continues it.  Calls into standard ..L when this finishes.  This means it
shouldn't be doing any redisplay.  !
 [1[2[3[4[5[6[7			    !* Save a register.!
 fsLispT"E '			    !* Only if actually called by HERMES.!
 fsJName:f6u1 f~1HERMES"N '	    !* ...!

 0fsRefreshw			    !* elimintate special refresh call !
 :i*wfo..qNovice Reminderm.vOriginal Novice Reminderw   !* save!
 :i*wm.vNovice Reminder	    !* and zero, before we select bufs !
 @fsCCLFNameu1 		    !* pick up name of input file !
 q1f[DFile			    !* convert it !
 fsDFn2:f6u3 f]DFilew		    !* save away the extension !
 (f~3COMM)"e	 		    !* if ext. equals COMM, then !
   0fo..qHermes Reply Mode Hookf"n u2 :m2 '
   				    !* if defined, run it and return !
   m(m.mSelect Buffer)*Comm*      !* get buffer Comm !
   m(m.mVisit File)1	    !* and put command file in it !
   zj0u7           		    !* now scan the Comm buffer !
   <.@; -l.u3   		    !* backwards, line by line !
     :s:"e!<!>'		    !* loop if line has no : !
     q3,.x4     		    !* pick up word with : !
     :s w .-1u3:s,w-c q3,.x5c   !* get next arg sans ldng space !
     :s w .-1u3:l q3,.x6	    !*  and similarly final arg !
     [6[5[4%7w0l		    !* push words in rev order & count !
    >
   q7<]1			    !* now retrieve commands,!
				    !* dispatching on comand word !
     f~1BUFFER:"e		    !* if it's BUFFER, !
       ]1
       m(m.mSelect Buffer)1w    !* use first arg as buffer name !
       f~1*HERMES*"e               !* if HERMES buffer, set autosave !
	 0fsModifiedw 0fsXModifiedw  !* Just in case it is being reused.!
	 1m.lAuto Save Default	    !* cant use std autosave for this buffer!
	 1m.lAuto Save Max         !* one copy per customer!
	 :i*DSK:$HERMES-EMACS-BACKUP.HRMf[DFilew  !* main part of name!
	 fsHSnamefsDSnamew		    !* adjust to get login structure !
	 fsDFilem.lAuto Save Filenames    !* set the name for saving!
	 f]DFile
	 w'
       ]1
       m(m.mVisit File)1w	    !*  and second arg as file name !
       !<!>'			    !*  then loop!
     f~1TWO WINDOWS:"e		    !* if TWO WINDOWS, !
       0fo..qMulti-Window Divider"e  !* if divider string not loaded, !
         :i*==================m.vMulti-Window Divider'w
                                    !* line of = for divider !
       0fo..qWindow 2 Size"n	    !* if already in 2-window !
         fsTop Line"n		    !*  if not in upper window,!
	   ]1]3[1[3w'		    !*  reverse order of args !
         ]1(f~Buffer Name1)"n  !*  if first arg bufname not already !
           m(m.mSelect Buffer)1w' !*  selected, do so !
         m(m.m^R Other Window)w    !* then go to other window !
         ]1(f~Buffer Name1)"n  !*  if second arg bufname not yet!
           m(m.mSelect Buffer)1w' !*  selected, do it!
         fsTop Line"e		    !* now if not in lower window,!
           m(m.m^R Other Window)w' !*  go there !
         w'
       "#			    !* if not already in 2-window !
         ]1(f~Buffer Name1)"n  !*  if first arg bufname not already !
           m(m.mSelect Buffer)1w' !*  selected, do so !
         m(m.m^R Two Windows)w     !* then open other window !
         ]1(f~Buffer Name1)"n  !*  if second arg bufname not yet!
           m(m.mSelect Buffer)1w' !*  selected, do it!
         w'
       0m.vWindow 1 Pointw	    !* make upper window be at head of buf!
       @:i*|m(m.m& Multi-Window Refresh)|fsRefreshw
				    !* set so whole screen is refreshed !
			            !* if lwr wndw not an even split !
       -1fo..qDefault Window 2 Sizeu1
       q1"l (fsHeight-(fsecholines)-2)/2u1
         q1m.vDefault Window 2 Size 'w
       q1,2m(m.m& Ensure Window Size)w !* make it so !
       w!<!>'			    !* then loop !

     ]1]1w>			    !* flush any other directive & loop !

   m(m.mKill Buffer)*Comm*	    !* now get rid of command buffer !
   w'                               !* (end COMM file case) !

 "#
   0fo..qWindow 2 Size"n	    !* if in 2-window mode!
     f~Buffer Name*HERMES*"n	    !* then if not in HERMES buffer, !
       m(m.m^R Other Window)w'	    !* switch windows (could be better)!
     fsTop Linem(m.m^R One Window)	!* then whole screen on!
     w'					!*  whatever window we are in !
   m(m.mSelect Buffer)*Hermes*	    !* Select special buffer.!

   0fsModifiedw 0fsXModifiedw	    !* Just in case it is being reused.!
   1m.lAuto Save Default	    !* cant use std autosave for this buffer!
   1m.lAuto Save Max             !* one copy per customer!
    :i*DSK:$HERMES-EMACS-BACKUP.HRMf[DFilew	    !* main part of name!
   fsHSnamefsDSnamew		    !* adjust to get login structure !
   fsDFilem.lAuto Save Filenames    !* set the name for saving!
   f]DFile

   @fsCCLFNameu1			    !* Pick up name of temp file,!
   m(m.mVisit File)1		    !* and visit it.!
   w'
 :i*fo..qOriginal Novice Reminderu1  !* restore reminder !
 q1m.vNovice Reminder"n m1 w'   !* and execute it !
 m(m.mFind Starting Place)w	    !* try to be clever about the cursor!
 f~ModeText"N m(m.mText Mode)'  !* Set Text mode.!
 (-1fo..qWindow 2 Size)"g	    !* Terrible kludge: if in 2-window, !
   m(m.m& Multi-Window Refresh)w'  !*  make sure both are displayed !

 				    !* All done.!

!Find Starting Place:! !C Position cursor to probably right spot.
Try to be clever about placing cursor, depending on whether there are any empty
header fields or other good candidates.  Positions after TO: or after any other
empty header field if To: is full or missing.  In the case of a Reply, it goes
to the beginning of the Text field if no headers are available.  In all other 
cases, it sits tight at the top of the buffer.  !
 [0
 1<bj 0,1a--"e 0;'		!* ignore this if buffer starts with -!
   :s
-----;				!* bound search to header fields!
   0l .u0			!* 0: end of headers!
   bj				!* default ending up point!
				!* NOTE: preserve invisible trailing space!
   b,q0:fbTo: 
"l 0:l'			!* move cursor to possible start of input!
				!* NOTE: preserve invisible trailing space!
   "# b,q0:fb : 
"l 0:l'			!* either To: or first apparent emptyfield!
   "#				!* no empty fields so look for other poss!
      b,q0:fbIn-Reply-To: "l	!* if reply, go after separator!
        :s-----
; '				!* reply but no separator, stay at top!
''				!* still at top if nothing reasonable!
  >
 .( q0,z:fbBegin forwarded message"l	!* looks like forward!
    q0j	l			!* position at first line of text!
    32,1a-9"e			!* if 1st character is TAB, insert line!
    i
'')j				!* back to desired position!
 .

!& Kill HERMES Library:! !S Make library unkillable.!

 [1				    !* Save a register.!
 fsLispT"E '			    !* Only if not called by HERMES.!
 fsJName:f6u1 f~1HERMES"N '	    !* ...!

 :i*You cannot kill the HERMES library fsErrw	!* Beep if attempt to kill.!

!& Exit to HERMES:! !S Save the HERMES buffer.!

 ff"E			!* save only if no argument.!
    1,(:i**Hermes*)m(m.m& Find Buffer)"l :m(m.mHermes Abort)'
				!* no message buffer, just abort!
    :i*wfo..qNovice Reminderm.vOriginal Novice Reminderw   !* save!
    :i*wm.vNovice Reminder	    !* and zero, before we select bufs !
    1,(:i**Reply-Msg*)m(m.m& Find Buffer)"g  !* if a reply buffer exists, !
      m(m.mSelect Buffer)*Reply-Msg*  !* then select it!
      0fsModifiedw 0fsXModifiedw	!* and set it so it wont be saved !
      m(m.mSelect Buffer)*Hermes*'  !* then select message buffer !
    (f~Buffer Name*Hermes*)"n  !* if not in msg draft buffer, !
      fsTop Line"n             !* if in window two, !
        m(m.m^R Other Window)'	!* ensure W1!
      m(m.mSelect Buffer)*Hermes*'  !* then select message buffer !
    :i*fo..qOriginal Novice Reminderu1  !* restore reminder !
    q1m.vNovice Reminderw
    1fsModifiedw 1fsXModified	!* buffer is always different from CDraft!
    1m(m.m^R Save File)	!* force autosaving for safety!
    1fsModififedw 1fsXModifiedw'	!* now mark again as unmodified!
    m(m.m^R Save File)		!* and always save the Hermes file!

 f:m(m.m& Original Exit EMACS)   !* Call into normal exiter.!

!HERMES Abort:! !C Call to abandon HERMES edit.
Intended as a clean ^C replacement.  !

 0fsExit                       !* Exit with magic number.!

                              !* This will execute if fork continued!
 :i*HERMES interface is broken fsErr	!* This will never be executed.!

!& Multi-Window Refresh:! !S Special HERMES 2-window repaint.
Uses variable-length string in Q$Multi-Window Divider$ to form dividing 
line betweens windows instead of wiring in a line of hyphens.  !

 QWindow 1 RefreshF"N [1M(Q1(]1))'
 FSQPPTR[P
 0F[REFRESH
 .[1FNq1j[1[2
 FSTOPLINE"N 
    QWindow 1 SizeF[LINES0F[TOPLINE
    :I21'
 "# QWindow 2 SizeF[LINESQWindow 1 Size+1F[TOPLINE
    :I22'
 QWindow 2 WindowF[WINDOW
 QWindow 2 Point:J
 QOther Window Buffer[..O
 -1F[DFORCE
 0U..H@V
 0FSLINES
 QWindow 1 SizeFSTOPLIN
 :i2----------
 q2fo..qMulti-Window Divideru2
 :FTFSWIDTH/FQ2<FT2>
 -FSTYPEOUTW0U..H
 QPFSQPUNWINDW

!^R Two Windows:! !C Special HERMES 2-window screen entry.
A copy of the standard ^R Two Windows routine, except that it
uses variable-length string in Q$Multi-Window Divider$ to form dividing 
line betweens windows instead of wiring in a line of hyphens.  !

 0FO..QWindow 2 Size"N 
    :I*A2W	Already Two WindowsFSERR'
 fsrgetty"e 
    :I*TTY	You are on a printing terminalFSERR'
 MMM & Check Top Levelwindows
 [Previous Buffer
 QBuffer NameM.VWindow 1 Buffer
 Q..OM.VOther Window Buffer
 FSWINDOWM.VWindow 1 Window
 .M.VWindow 1 Pointer
 FSLINESM.VDefault Size
 FSLINESF"E 
    FSHEIGHT-(FSECHOLINES)-1'M.VTotal Size
 0FO..QWindow 2 Buffer"E 
    QTotal Size/2M.VWindow 1 Size
    0FO..QTags Find File"N oSame'
    -1"N oSame'
    "N :I*W2m(m.m& Create Buffer)'
    :I*W2M.VWindow 2 BufferoW2'
 -1"N 
    !Same!
    QBuffer NameM.VWindow 2 Buffer
    !W2!
    .M.VWindow 2 Pointer
    FSWindowM.VWindow 2 Window'
 QWindow 1 Size[0
 QTotal Size-1-Q0:"G 
    QTotal Size/2U0Q0UWindow 1 Size'
 1F[NOQUIT
 QTotal Size-1-Q0M.VWindow 2 Size
 FSREFRESHM.VWindow 1 Refresh
 M.M& Multi-window RefreshFSREFRESH
 "N Q0FSLINESW
    Q:.B(QWindow 2 BufferM(M.M& Find Buffer)+4)M.VOther Window Buffer
    F]NOQUIT
    M(FSREFRESH)W'
 Q0FSTOPLINE
 :i2----------
 q2fo..qMulti-Window Divideru2
 :FTFSWIDTH/FQ2<FT2>0U..H
 -1FSTYPEOUT
 0FSTOPLINE
 F]NOQUIT
 :M(M.M^R Other Window)

!& Ensure Window Size:! !S Force a window to a certain target size.
NUMARG says which window is being specified.  Precomma arg holds the target
size for the window.  0 means that the window will end up disappearing;
anything too large means that the window takes over the screen.  !
 [0[1[2[3
 0fo..qWindow 2 Size"e		!* only one window now!
   -1"e "e ''		!* quit if W2 target size is 0!
   m(m.m^R Two Windows)	!* if W2 needed, make it!
   fm(m.m& Ensure Window Size)	!* call self to ensure size!
   :m(m.m^R Other Window)'	!* return to where we started!
 u2				!* 2: target size for window!
 :\u0				!* 0: window name as string!
 qWindow 0 Sizeu1		!* 1: current size of relevant window!
 q2-q1"e '			!* already there!
 q2"n				!* target size not zero!
   (fsheight-(fsecholines)-1)-q2"g	!* and target size within reason!
     fstop linef"n w 1'#(-1)"n -'(q2-q1):m(m.m^R Grow Window)'
				!* if current is target OK, owise minus adjust!
   "#				!* target size exceeds max!
     -1"e :m(m.m^R One Window)'	!* W1 takes over!
     1:m(m.m^R One Window)''	!* or W2 takes over!
 "#				!* target size is zero!
   -1"e 1:m(m.m^R One Window)'	!* W1 must disappear!
   :m(m.m^R One Window)'	!* or W2 must disappear!

