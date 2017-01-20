!* -*-TECO-*- *!

!~FILENAME~:! !New version of Auto Save Mode and its associates.!
AUTO-SAVE-MODE

!& Setup AUTO-SAVE-MODE Library:! !S Install hooks, create variables.
Runs Auto-Save-Mode Setup Hook, if it is non-0, in which case it
must take care of setting keys, fsClkMacro, fsClkInterval, ..F and
.F.  We set those only when there is no hook.!

 m(m.m& Declare Load-Time Defaults)
    Auto-Save-Mode Setup Hook,
	If non-0, called when AUTO-SAVE-MODE is loaded: 0

 [1[k

 !* First make sure no previous MM-variables are going to cover our functions:!

 m.mKill Variableuk			!* K: Killer.!
 mkMM & Auto Save Setupw		!* Kill kill kill!
 mkMM & Auto Save Filew		!* ...!
 mkMM ^R Save Filew			!* ...!
 mkMM & Secretary Macrow		!* ...!
 mkMM & Auto Save All Buffersw		!* ...!
 mkMM & Real-time Interruptw		!* ...!

 !* Now do some of our own installing: !

    !* Note that we will PREpend our exit hook, so that in case there!
    !* was already some other auto-saver hook there, we go first and!
    !* theirs probably will be a no-op since the buffers wont be!
    !* modified any more.!

 0fo..qExit Hookf"ew :i*'u1		!* 1: Old hook.!
 @:i*|ff"e m(m.m& Auto Save All Buffers)'	!* Prepend our hook.!
     1|m.vExit Hookw		!* ...!

 !* Some installing is only if there is no hook: !

 qAuto-Save-Mode Setup Hookf"nu1 m1'	!* Run hook, if non-0.!
 "#w					!* No hook.  We install.!
    m.m& Secretary Macrof(u.f)u..f	!* .F, ..F: Install our one.!
    m.m& Real-time InterruptfsClkMacrow	!* Install our clock!
						!* interrupt handler.!
    fsClkInterval"e 4*60*60fsClkIntervalw'	!* set interval if none!
    m.m^R Save Fileu:.x()'		!* C-X C-S: our save file function!

 

!& Auto Save Setup:! !S Decide whether to turn on auto saving for file!
 0[1					!* 1: to save or not to save!
 qBuffer Index[2			!* 2: index into .B of current buffer!
 qBuffer Filenamesf"nf[DFile		!* if buffer filenames, examine them!
    fsDVersion"e			!* saving to >!
	q:.b(q2+12)"e			!* and not read-only!
	    1u1'''			!* then we save!
 q1u:.b(q2+10) 			!* just store the answer!

!& Auto Save File:! !S Subroutine that may write out an auto save file.
NUMARG is Buffer Index of buffer in .B to save.
We run Before Auto Save Hook and After Auto Save Hook if non-0.!

 m(m.m& Declare Load-Time Defaults)
    Before Auto Save Hook, If non-0 is run just before auto saving: 0
    After Auto Save Hook, If non-0 is run just after auto saving: 0
    Auto Save Star, * If non-0, user wants * in mode line after auto-save: 0 


 [1[2[3[4 0f[VB 0f[VZ		    !* Wide bounds.!

 -qBuffer Index"e qBuffer filenamesu1'	    !* 1: buffer filenames!
 "# q:.b(+2)u1'				    !* ...!
 q1"e @ftNo auto save filenames.  0fsEchoActivew '

 q1f[DFile			    !* set default to buffer filenames.!

				    !* Now figure what version to use.!

 fsURead"n e[fne]'		    !* maybe push input file!
 1:< 1,er fsIFileu3 fsIFVersionu4 fsIFCDateu2 ec
				    !* 3: Full filename of highest version.!
				    !* 4: Its version number.!
				    !* 2: Its creation date.!

     q2-(0fo..qASav 3 File)"e    !* Was an auto save version already.!
	q4fsDVersionw		    !* so save to that version again!
	fsDFileu1		    !* ...!
	etASAVE OUTPUT'	    !* but open ASAVE.OUTPUT on TNX to!
				    !* prevent a crash from leaving a zero!
				    !* length file!
     >w				    !* end of errset!

 qBefore Auto Save Hookf"nu2 m2'w	    !* Run before hook if non-0.!

 fsUWrite"n e\fne^'		    !* maybe push output file!
 ei fsOFCDateu2		    !* 2: Its creation date.!
 hp ef1			    !* restore filenames to force EF to!
				    !* rename, and write it out.!
 fsOFVersionf"gu:.b(+9) 1fsModeChange'w !* save actual version number!
 zu:.b(+5+6)			    !* Update size last read/saved.!
 fsOFileu1			    !* 1: Auto save files full name.!
 q2u:.b(+8)			    !* Update buffer date field.!
 q2m.vASav 1 Filew		    !* Declare it an autosave file.!
 @ftAuto saved: 1
				    !* tell user exact filename written!

 qAfter Auto Save Hookf"nu1 m1'w	    !* Run after hook if non-0.!

 0fsXModifiedw			    !* Lets not save it again.!
 qAuto Save Star"e 0fsModifiedw' !* if user wants star to go away, make it!
				    !* go away!
 0fsEchoActivew 

!^R Save File:! !^R Write out a user-save file if needs it.
A user-save file is one written by user decision, and therefore never to
    be touched by auto saving.  E.g. a high-level backup point.
Declares this version to be a user-saved file, i.e. NOT an auto saved
    one.  Thus, auto saving will not occur to this version again.
Given an explicit NUMARG, we just run & Auto Save File, to ensure that the
    file is currently safe, if not user-level consistent:  thus this will
    keep the file declared an auto save file.
A NUMARG of 16 or greater calls & Auto Save All Buffers.!

 -16:"l m(m.m& Auto Save All Buffers)w 1'
 :i*CfsEchoDis		    !* clear echo area!
 ff"g			    !* NUMARG.!
   fsXModified"e @ft(No changes need to be written)
    0fsEchoActivew 1'	    !* tell user buffer doesnt need changing!
   @ft(auto save)
				    !* or tell him auto save started!
   qBuffer Indexm(m.m& Auto Save File)   !* auto save current buffer!
   1'				    !* !

 [1[2[3[4 f[DFile		    !* Should we be saving default?!
 0f[VB 0f[VZ			    !* Wide bounds.!
 qBuffer Filenamesf"ew :i*No filenames to save underfsErr
    'u1				    !* 1: User-save filenames.!
 et1				    !* Set default!
 q1u2				    !* 2: Start with filename in case the!
				    !* input below gives an error.!
 fsURead"n e[fne]'		    !* maybe push input file!
 1:< 1,er fsIFileu2 fsIFVersionu3 fsIFCDateu4 ec
				    !* 2: Highest version filename.!
				    !* 3: Its version number.!
				    !* 4: Its creation date.!
     q4-(0fo..qASav 2 File)"e    !* That is an auto save file.!
	q3fsDVersionw		    !* So re-use that version.!
	fsDFileu1		    !* ...!
	etASAVE OUTPUT'	    !* on TNX, open different filename to!
				    !* prevent a crash from leaving a zero!
				    !* length file!


     q:.b(qBuffer Index+8)u3	    !* read or wrote the file.!
     q4"n q3"n q4-q3"n		    !* If not, warn user he may be losing.!
        ftThis file has been written on disk since you last read or wrote it.
Should I write it anyway
        m(m.m& Yes or No)(f 0u..h)"e 0''''
     >w

 fsXModified"e @ft(No changes need to be written)
'
 "# fsUWrite"n e\fne^'	    !* maybe push output file!
    ei fsOFCDateu3		    !* 3: Its creation date.!
    hp ef1			    !* restore filenames to force EF to!
				    !* rename, and write it out.!
    fsOFVersionf"gu:.b(+9) 1fsModeChange'w	    !* save actual version number!
    zu:.b(qBuffer Index+5+6)	    !* Update size last read/saved.!
    fsOFileu2			    !* 2: User save files full name.!
    q3u:.b(qBuffer Index+8)	    !* Update buffer date field.!
    @ftUser saved: 2

    0fsXModifiedw'		    !* no longer needs auto saving!
 fs^RMDlyfs^RMCntw		    !* not even in near future!
 0fsModifiedw			    !* no longer needs user saving!

 m(m.mKill Variable)ASav 2 Filew
	    !* Remove any assertion that this was an auto save file.  Note!
	    !* that this is not conditional on fsModified since the buffer!
	    !* may have just been written out due to an auto save.!
	    !* However, we must at least declare that auto saved file to!
	    !* now be a user saved file.!

 0fsEchoActivew 1 

!& Secretary Macro:! !S ..F:  Auto save for use in ^R mode editing.
The buffer is auto saved after every fs^RMDly characters.
Auto saving happens by calling & Auto Save File.!
!* I (ECC) think that Teco must be the one to reset fs^RMCnt, and it
 * does it after we are done -- and if we get an error it is not reset.
 * So if we are not careful if someone gets a write error (e.g. no
 * access) the ..F will go off again the very next character they type.
 * For now, until we have a better solution, I am having ..F reset
 * fs^RMCnt from fs^RMDly itself once it decides to call & Auto Save File.!

 qBuffer Index[1			!* 1: index of current buffer!
 q:.b(q1+4)[..o				!* Teco-select the current EMACS!
					!* buffer -- i.e. dont let any temp!
					!* teco buffers get in the way.!
 fsXModified"e 1'			!* Buffer doesnt need saving.!
 q:.b(q1+10)"e 1'			!* Not supposed to save it.!

 :i*CfsEchoDis @ft(auto save)
 0fsEchoActivew			!* tell user what we are up to.!
 fs^RMDlyfs^RMCntw			!* Reset count before chance of bad error!
 q1m(m.m& Auto Save File)		!* auto save current buffer!
 1

!& Auto Save All Buffers:! !S For each buffer that requires it.
I.e. for each that is modified and has auto saving on.
& Auto Save File is called.!

 0[1 [2 -1[3 [..o		    !* 1: .B index, 3: saved count!
 < 1f<!Test!			    !* exit this if no auto save!
     q:.b(q1+10)@;		    !* exit if saving not desired!
     q:.b(q1+4)u..o		    !* Teco select buffer!
     fsXModified@;		    !* this buffer modified?!
     %3"e :i*CfsEchoDis @ft(auto save)
    0fsEchoActivew'		    !* tell user if first buffer!
     q1m(m.m& Auto Save File)	    !* yes, save buffer!
     >				    !* end auto save test catch!
   q1+q:.b(q1)u1		    !* 1: move to next buffer slot.!
   q1-(fq.b/5); >		    !* Continue till done .B!
 

!& Real-time Interrupt:! !S Save file after 5 minutes of idle time.!
 0fsTyiCount"n 0'		    !* User has been typing in last 5 minutes!
				    !* so dont save -- this is an easy way of!
				    !* avoiding possible messup of the screen!
				    !* at funny times (like in & Read Line) or!
				    !* to avoid being obnoxious to use and!
				    !* saving the current buffer 2 characters!
				    !* after it was just saved.!
 m(m.m& Auto Save All Buffers)
 0@v 0
