!* -*- TECO -*-		Library created and maintained by KMP@MC !
!*			** The funny name comes from fact that   !
!*			** there is more than one TIME library	 !

!* [toed.xkl.com]DXX:<EMACS>TIME.EMACS.53,  3-Jan-2000 17:27:45, Edit by ALDERSON!
!* Fix the date-and-time selection code in & Get Current Time to deal with the!
!* fact that Tops-20 now uses only 4-digit years !

!~Filename~:! !Timely macros for EMACS !
KMPTIME

!& Setup KMPTIME Library:! !S Setup for using our winning macros!

m.vOnly_Time_in_Modeline	    !* Make variables for user  !
m.vTime_Only
m.vSaved_Time
0fo..QOld_FS_Clk_Macro"e	    !* Maybe remember old value !
  fsclkmacrom.vOld_FS_Clk_Macro'
13*5fs q vectorf([5) M.VMonths    !* get ourselves a Q-vector	!
:i*Jan u:5(1)			    !* Jan			!
:i*Feb u:5(2)			    !* Feb			!
:i*Mar u:5(3)			    !* Mar			!
:i*Apr u:5(4)			    !* Apr			!
:i*May u:5(5)			    !* May			!
:i*Jun u:5(6)			    !* Jun			!
:i*Jul u:5(7)			    !* Jul			!
:i*Aug u:5(8)			    !* Aug			!
:i*Sep u:5(9)			    !* Sep			!
:i*Oct u:5(10)			    !* Oct			!
:i*Nov u:5(11)			    !* Nov			!
:i*Dec u:5(12)			    !* Dec			!


!& Kill KMPTIME Library:! !& Clean up on exit !

qOld_FS_Clk_Macrofsclkmacro	    !* Reset clock interrupt thing	!
0fsclkint			    !* Turn off interrupts		!
				    !* Return				!


!& Get Current Time:! !S Gets string form of time 
Time in 7 chars + <Space> + Date in 9 chars
If qTime Only is nonzero, the just return time in 7 chars.!

!* q0 = String to put in mode line	!
!* q1 = full time (scrap)		!
!* q5 = date				!

[0[1[2[3[4[5[6

:i5				    !* Initialize q5 to null string	!

0fo..Q Time_Only u6		    !* Get time only?			!

fsdate+1"e			    !* If system doesn't know the time	!
 q6"n :i*No_Time '		    !*  Then say so			!
   "# :i*No_Time_&_No_Date  ''   !*					!

fsdate :fsfdconvertu1		    !* Save date/time as string in q1	!

q6"n oSkipDate '
3,5:g1 u2			    !* Get day in q2			!
0,2:g1 u3			    !* Get month # in q3		!

				    !* Get year in q4			!
fsOSTeco"e			    !* If ITS, still 2-digit years, I guess !
   6,8:g1 u4'
   "#				    !* but on Tops-20, now 4-digit years!
   6,10:g1 u4'

Q:Months(3) u3		    !* Get month string in q3		!
0:g2-48"e			    !* Leading zero in Day?		!
    0:F2_'			    !* Change to a space		!
:i5_2_3_4		    !* q5: _Day_Month_Yr		!

!SkipDate!			    !* Come here if no date wanted	!

				    !* Save minutes in q2		!
				    !* Save hour in q3			!
fsOSTeco"e			    !* ITS two-digit years need these offsets !
    12,14:g1 u2
     9,11:g1 u3'
    "#				    !* but Tops-20 4-digit years need these !
    14,16:g1 u2
    11,13:g1 u3'

0fo..QTime_Zone_Adjustmentf"n+3u3!* If time zone adjustment to do	!
 q3"l				    !* If negative			!
   q3+24u3			    !*  Correct the time		!
   q6"e 1,fq5:g5u5 :i5<5 !>! ''  !*  Maybe invalidate date		!
 q3-23"g			    !* If bigger than 23		!
   q3-24u3			    !*  Correct the time		!
   q6"e 1,fq5:g5u5 !<! :i5>5 ''  !*  Invalidate date			!
 q3:\u3 fq3-1"e :i303' 'w	    !* Correct format of q3 to string	!

F=200"e			    !* If its on the hour ...		!
   F=300"e :i*Midnite_5 '	    !*  Hour = 0 means midnite		!
   F=312"e :i*12_Noon_5 ''    !*  Hour = 12 means noon		!

3/12"e			    !* If before noon, ...		!
   :i4am'			    !*  Then Use am			!
"# (3-12):\u3			    !*  Else put (Hour - 12) in q3	!
   fq3-1"e :i3_3'		    !*   If only one digit, slide over	!
   :i4pm'			    !*   Use pm				!

F=3_0"e :i312'		    !* If Hour = _0, change to 12	!
"# F=300"e :i312''		    !* (Else) If Hour = 00, change to 12!

0:g3-48"e			    !* If Hour begins with a 0, ...	!
  0:F3_'			    !*  Make it into a blank		!

q6"e :i*3:24_5 '	    !* Return the Time and Date		!
  "# :i*3:24     '	    !*  or maybe just the Time		!


!& Start Realtime Modeline Clock:! !S Get the realtime clock interrupts going
Postcomma arg is the number of seconds to wait between updates (Default 60).
Precomma arg is time will only f^E the mode line when that macro is in 
 fsmodemacro!

ff&1"n ' "# 60' *30 fsClkInt

 m.v Modeline_Safe_Macro	    !* Precomma arg (default 0) is safe to f^E!
0 m.v Modeline_Full_Update_Time
M.M &_Insert_Correct_Time_in_Mode_Linefs CLK Macro
0

!& Enable MODLIN AutoSave:! !& Set up to run AutoSave every 5 clock updates !

0m.vAutoSaveFlag
[0[1
 :i* fo..QMM_&_Periodic_Actionu0
 @:i1| %AutoSaveFlag-9"g 0uAutoSaveFlagw m(m.m&_Real-time_Interrupt)'|
 :i*01m.vMM_&_Periodic_Action



!& Insert Correct Time In Mode Line:! !S Updates modline display of time!

1,M.M &_Periodic_Action"n
   M(M.M &_Periodic_Action)'

qModeline_Full_Update_Time"e
  1 uModeline_Full_Update_Time 
  0'
"#
  0 uModeline_Full_Update_Time'
    
f[inslen			    !* Bind insert length info		!
qEditor_Name[0		    !* Put Editor name in q0		!
f~..J0-1-FQ0"N oSet'	    !* If ..J is unknown, Set mode line	!
FQ..J-(FQ0+18)"l oSet'		    !* If ..J is short, same thing	!
qModeline_Safe_Macrof"n[0	    !* If a mode safe macro was named	!
 q0-(]0w fsmodemacro)"n oSet''    !*  do the f^E only if a match	!
:i0..J			    !* Copy ..J into q0			!
qTime_OnlyuSaved_time	    !* Push Time Only on q-reg 0        !   
qOnly_Time_in_ModelineuTime_Only !* and temply set Time Only        !
M(M.M &_Get_Current_Time)[1	    !* Get current time in q1		!
qSaved_TimeuTime_Only	    !* restore old value of Time Only   !
FQEditor_Name+1:F01	    !* Rplac time into mode line	!
F=0..J"e 0'		    !* Exit if no change to make	!
q0 u..J				    !* Put new mode line in ..J		!
FR				    !* Redisplay the mode line		!
0				    !* Return				!
!Set!
fs mode macrof"n[0 m0fr ]0'	    !* If a ModeMacro in effect, call it!
0				    !* And return			!
