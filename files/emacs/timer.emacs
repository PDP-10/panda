!* Library created and maintained by David Eppstein <Kronj@Sierra> !
!* Compile this file with IVORY, not PURIFY !
!* The funny name is to trick MODLIN into not loading TIME !

!~Filename~:! !Intelligent real-time clock interrupts!
KMPTIME

!& Setup KMPTIME Library:! !S Setup for using our winning macros!

 fsClkIntm.vTimer Old Clock Int   !* Save old clock interval!
 fsClkMacm.vTimer Old Clock Mac   !* And old clock mac!
 0fsClkInt			    !* No interrupts set yet!
 m.m& Run TimersfsClkMac	    !* Set macro to run timers!

 0fo..qOnly Time in Modelinef"nm.vTime Only'	    !* Placate LOTS losers!
 0fsQVectorm.vTimer Vector	    !* Make up a new timer vector!
 0uTimer Vector Locked	    !* Timer Vector has not been locked!
 m(m.m& Auto Save Timer)	    !* Auto save to schedule for later!

 0fo..qMonths"n '		    !* If we have months already, done!
 13*5fsQVectorf([5)m.vMonths	    !* Get ourselves a Q-vector	!
 :i*Jan u:5(1)			    !*  Jan!
 :i*Feb u:5(2)			    !*  Feb!
 :i*Mar u:5(3)			    !*  Mar!
 :i*Apr u:5(4)			    !*  Apr!
 :i*May u:5(5)			    !*  May!
 :i*Jun u:5(6)			    !*  Jun!
 :i*Jul u:5(7)			    !*  Jul!
 :i*Aug u:5(8)			    !*  Aug!
 :i*Sep u:5(9)			    !*  Sep!
 :i*Oct u:5(10)		    !*  Oct!
 :i*Nov u:5(11)		    !*  Nov!
 :i*Dec u:5(12)		    !*  Dec!


!& Kill KMPTIME Library:! !S Fix up so user can run without us!

 qTimer Old Clock IntfsClkInt    !* Fix clock interval!
 qTimer Old Clock MacfsClkMac    !* And macro to run when alarm goes off!
 0uTimer Vector		    !* No timer vector anymore!


!& Run Timers:! !S Macro to check list of timers for later interpretation!

 m(m.m& Declare Load-Time Defaults)
    Timer Vector Locked,Lock On Timer Interrupts: 0
    Timer Lock Timeout,How long to wait before trying lock again: 300


 qTimer Vector Locked"n	    !* Is timer locked?!
    qTimer Lock TimeoutfsClkInt  !* Yes, wait a little (5 seconds default)!
    '				    !* Before doing anything!

 qTimer Vector[0		    !* Get vector!
 fq0:"g 0fsClkIntw'		    !* If nothing, don't run interrupt!

 0[1 fq0/5[2 q:0(0)[3		    !* Get index, limit, decrement!
 <q1-q2; q:0(q1)-q3u:0(q1) q1+2u1>  !* Decrement all timeout counters!

 < fq0@; q:0(0)-1;		    !* Loop through all zeroed counts!
   m:0(1)			    !* Macro the macro!
   q0[..o 0,10k ]..o >		    !* And flush that timeout!

 fq0f"nw q:0(0)'fsClkInt	    !* Set new timeout for next interrupt!
				    !* All done with this alarm!

!& Set Timer:! !S Schedule a timer interrupt for later running.
Arg1 is interval (in 60ths of a second), Arg2 is macro to run.!

 m(m.m& Declare Load-Time Defaults)
    Timer Vector Locked,Lock On Timer Interrupts: 0


 1[Timer Vector Locked	    !* Lock timer vector from interrupt!
 qTimer Vector[..o		    !* Select vector as buffer!
 0[0 fq..o/5[1			    !* Get index and length of vector!
 <q0-q1; q:..o(q0)-; q0+2u0>	    !* Find place to put new interrupt!
 q0*5j 10,0i			    !* Make some room!
 u:..o(q0) u:..o(q0+1)	    !* Set timeout and macro!
 q0"e fsClkInt'		    !* If first in line, set up timer!
 				    !* Exit and unlock things!

!& Clear Timer:! !S Remove timer from schedule.
Arg is macro that would have been run.!

 m(m.m& Declare Load-Time Defaults)
    Timer Vector Locked,Lock On Timer Interrupts: 0


 1[Timer Vector Locked		!* Lock timer vector from interrupt!
 qTimer Vector[..o			!* Select vector as buffer!
 0[0 fq..0/5[1				!* Get index and length of vector!
 <q0-q1; q:..o(q0+1)-"e		!* Loop through.  If we found the spot!
      q0*5j 10 k'"# q0+2u0'>		!* Flush it, else go on to next!
 					!* Exit and unlock things!

!& Auto Save Timer:! !S Timer interrupt for auto save.
Schedules self for later running and runs auto save.!

 m(m.m& Declare Load-Time Defaults)
    Auto Save Timeout,Interval between auto-save interrupts: 14400


 qAuto Save Timeout,(m.m& Auto Save Timer)m(m.m& Set Timer)	    !* ...!
 :m(m.m& Real-time Interrupt)	    !* Run original auto-save macro!

!& Get Current Time:! !S Gets string form of time.
Time in 7 chars + <Space> + Date in 9 chars;
if qTime Only is nonzero, the just return time in 7 chars.!

 m(m.m& Declare Load-Time Defaults)
    Time Only,* Just time without date in fancy mode line: 0


!* q0 = String to put in mode line!
!* q1 = full time (scrap)!
!* q5 = date!

 [0[1[2[3[4[5			    !* Save some qregs for use!
 :i5				    !* Initialize q5 to null string!
 qTime Only[6			    !* Get whether to include date!

 fsDate+1"e			    !* If system doesn't know the time!
   q6"n :i*No Time'		    !* ..then say so!
     "# :i*No Time & No Date''   !* ...!

 fsDate:fsFDConvertu1		    !* Save date/time as string in q1!
 q6"n oSkipDate'		    !* If not doing date, then go on!

 3,5:g1 u2			    !* Get day in q2!
 0,2:g1 u3			    !* Get month # in q3!
 6,8:g1 u4			    !* Get year in q4!
 Q:Months(3) u3		    !* Get month string in q3!
 0:g2-48"e			    !* Leading zero in Day?!
     0:F2 '			    !* Change to a space!
 :i52 3 4		    !* Month Date!

 !SkipDate!			    !* Come here if no date wanted!

 12,14:g1 u2			    !* Save minutes in q2!
  9,11:g1 u3			    !* Save hour in q3!

 F=200"e			    !* If its on the hour ...!
    F=300"e :i*Midnite 5 '    !*  Hour = 0 means midnite!
    F=312"e :i*12 Noon 5 ''   !*  Hour = 12 means noon!

 3/12"e			    !* If before noon, ...!
    :i4am'			    !*  Then Use am!
 "# (3-12):\u3		    !*  Else put (Hour - 12) in q3!
    fq3-1"e :i3 3'		    !*   If only one digit, slide over!
    :i4pm'			    !*   Use pm!

 F=3 0"e :i312'		    !* If Hour =  0, change to 12!
 "# F=300"e :i312''		    !* (Else) If Hour = 00, change to 12!

 0:g3-48"e			    !* If Hour begins with a 0, ...!
   0:F3 '			    !*  Make it into a blank!

 q6"e :i*3:24 5 '	    !* Return the Time and Date!
   "# :i*3:24     '	    !*  or maybe just the Time!

!& Start Realtime Modeline Clock:! !S Get the realtime clock interrupts going
Postcomma arg is the number of seconds to wait between updates (Default 30).
Precomma arg is time will only f^E the mode line when that macro is in ModeMac!

 m.vModeline Safe Macro	    !* Precomma arg (default 0) is safe to f^E!
 ff&1"n*60m.vMode Line Timeout'	    !* If given a time, use it!
 :m(m.m& Insert Correct Time in Mode Line) !* Start up mode macro!

!& Insert Correct Time In Mode Line:! !S Updates modline display of time!

 m(m.m& Declare Load-Time Defaults)
    Mode Line Timeout,How long to wait between mode line updates: 1800


 qMode Line Timeout,(		    !* Set self to run again later!
    m.m& Insert Correct Time In Mode Line)m(m.m& Set Timer)	    !* ...!

 1,M.M &_Periodic_Action"n	    !* Satisfy users of MODLIN!
   M(M.M &_Periodic_Action)'	    !* who want other things done!
    
 f[InsLen			    !* Bind insert length info!
 qEditor Name[0		    !* Put Editor name in q0!

 !* Check whether can insert time without worrying about rest of modeline!
 f~..J0-1-FQ0"N oSet'	    !* If ..J is unknown, Set mode line!
 fq..J-(fq0+18)"l oSet'	    !* If ..J is short, same thing!
 qModeline Safe Macrof"n[0	    !* If a mode safe macro was named!
   q0-(]0w fsModeMacro)"n oSet''  !* ..do the f^E only if a match!

 !* Can do insertion, so do it!
 :i0..J			    !* Copy ..J into q0!
 M(M.M & Get Current Time)[1	    !* Get current time in q1!
 fqEditor Name+1:f01	    !* Replace time into mode line!
 F=0..J"e 0'		    !* Exit if no change to make!
 q0 u..J			    !* Put new mode line in ..J!
 FR				    !* Redisplay the mode line!
 0				    !* Return!

 !Set!				    !* Here when have to run full mode macro!
 fsModeMacrof"n[0 m0fr ]0'	    !* If a ModeMacro in effect, call it!
 0				    !* And return!
  