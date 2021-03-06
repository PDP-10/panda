!* -*-TECO-*- *!

!~Filename~:! !Mode line with load average and time.  !
Modeline



!& Setup Modeline Library :! !S  Load the new mode line and start the clock. 
   The time and load average are updated every minute.  If Time Only is zero,
   both time and date are displayed;  if nonzero, just the time (default is
   zero).  This library calls up the Time library.              !

 fs mode macro m.c Old_FS_Mode_Macro            !*  Save old values   !
 fs clk interval m.c Old_FS_Clk_Interval        !*  for cleanup.      !
 fs clk macro m.c Old_FS_Clk_Macro
 m.m &_Modeline fs mode macro                    !*  Insert modeline.  !
 1,m(m.m &_Get_Library_Pointer)Kmptime "e        !*  Grab the time     !
    m(m.m Load_Library)time'                     !*  routines.         !
 1800 fs clk interval
 m.m &_Update_Time_and_Load_Avg fs clk macro     !*  Start the clock.  !
 m.m &_Modeline m.v Modeline_Safe_Macro
 m.m &_Modeline m.v mm_&_Set_Mode_Line
 0 m.v Modeline_Full_Update_Time
 0 m.c Time_Only*_If_zero,_display_both_time_and_date,_otherwise_just_time.



!& Modeline :! !S  The mode line routine 
   Same as the usual Emacs default, plus time and load average.   !

 -(fs qp ptr * 2)fs mode change           !*  Setup for re-call if state   !
                                            !*   changes.                    !
 q..o[9                                     !*  Save current buffer in q9.   !
 fs vz + b [4                              !*  q4 is nonzero if buffer is   !
                                            !*   narrow.                     !
 qEditor_Name[0                           !*  Save Editor Name in q0.      !
 qMode[1                                  !*  Save Major Mode in q1.       !
 qBuffer_Index[3                          !*  Save Buffer Index in q3.     !
  "n :i1 q1 uMode                  !*  If an argument was given,    !
                                            !*   put it into Mode,           !
  0fo..q1 _Mode_Hook[2                   !*   search for <Mode> Mode Hook,!
  q2 "n m2''                                !*   and run it if it exists.    !
 0[.1 q..j[.2                               !*  Set q.1 to 0 (counter), save !
                                            !*   the current modeline in q.2.!
 <fq.2 @; 0:g.2-[ :@; %.1                 !*  Strip off all [, keeping     !
 1,fq.2 :g.2 u.2>                           !*   count in q.1.               !
 f~.20 - 1 - fq0 "n 0'                 !*  If stripped modeline does not!
                                            !*   include Editor Name, quit.  !
 f[ BBind g0 i__                          !*  Save the buffer.  In the new !
                                            !*   buffer, insert Editor Name  !
                                            !*   and spaces.                 !
 m(m.m &_Get_Current_Time) u0              !*  Put current time into q0,    !
 g0                                         !*   and insert it.              !
 fs os teco - 1 "e                         !*  If on Twenex,                !
  fs load average u0                       !*   insert the load average.    !
  i__0_'
 0fo..q Editor_Type[2                      !*  If there is an Editor Type,  !
 q2 "n g2 i__'                             !*   insert it, and spaces.      !
 i( g1                                     !*  Insert ( and Major Mode.     !
 qSubmode u2 fq2 "g                       !*  If there is a submode,       !
  i[ 2 ]'                                !*   insert it within [ ].       !
 qAuto_Fill_Mode "n                       !*  If Auto Fill Mode, signal it.!
  i_Fill'
 q:.b(q3+10) "n                             !*  If Auto Save Mode, signal it.!
  i_Save'
 "# qAuto_Save_Default "n                 !*  If normally Auto Save,       !
  i_Save_(off)''                           !*   so indicate.                !
 fs ^R Replace "n i_Ovwrt'                !*  Note if Overwrite Mode.      !
 fs tyi sink "n i_Def'                    !*  Note if Define Mode (KBDMAC).!
 q4 "n i_Narrow'                           !*  Note if Narrow Buffer.       !
 mSet_Mode_Line_Hook + 0 u2               !*  Call hook and save in q2.    !
 fq2 "g g2'                                !*  If any result, insert it.    !
 i)__                                      !*  Insert ), end of Mode.       !
 qBuffer_Name u2                          !*  Fetch name and file name.    !
 qBuffer_Filenames u1
 q1 "n q1 f[ dfile                         !*  If file name exists, save it !
                                            !*   in FS DFILE, and            !
  f~ (fs d fn1 :f6) 2 "e 0 u2''       !*   if file name = buffer name, !
                                            !*    set buffer name to 0.      !
 q2 "n i 2 :__'                        !*  If there is a buffer name,   !
                                            !*   insert it, with : and space.!
 fq1 "g g1                                  !*  If there is a file name,     !
                                            !*   insert it, and              !
  fs os teco "n                            !*   if not on ITS,              !
   fq1 r fs hsname :f6 u2                  !*    back up, save directory    !
                                            !*    name in q2, and            !
   fs os teco - 1 "e                       !*    if on Twenex,              !
    fq2   f~ 2  "e fq2 d''              !*     delete directory of file  !
                                            !*     if same as user's.        !
   "# 4  f~ dsk: "e 4d                    !*    else (Tenex), delete DSK:, !
    fq2 + 2   f~ < 2 > "e fq2 + 2 d'''  !*     and directory if user's.  !
   zj fs d vers "e -2d''                   !*    If FS DVERS = 0, delete    !
                                            !*     last 2 characters.        !
  fs d vers "'e + (fs d vers + 2 "'e) "l  !*   If FS DVERS neither 0 nor 2,!
   q:.b(q3+9) u1                            !*    get version from .b table, !
   i_( g1 i)'                             !*    and insert it within ( ).  !
  q:.b(q3+12) "g i_(R-O)'                  !*   According to .b table, note !
  q:.b(q3+12) "l i_(Buf R-O)'              !*    read-only file or buffer.  !
  i__'
 zj q.1 <i]_> j q.1,[i                   !*  Put q.1 levels of [ ] around !
                                            !*   modeline (counted above).   !
 hf= ..j "n hx..j'                     !*  If buffer differs from mode  !
                                            !*   line, place it into ..j.    !
 0                                        !*  Return.                      !



!& Update Time and Load Avg :! !S  Real-time updating of time and load avg 
   Same as the Insert routine in the Time library, with added lines to update
   load average.  If Time Only is zero, display both time and date;  if non-
   zero, display time alone.        !

 1,m.m &_Periodic_Action "n             !*  Perform any Periodic Action.    !
  m(m.m &_Periodic_Action)'
 qModeline_Full_Update_Time "e         !*  Not time yet, come back later.  !
  1 uModeline_Full_Update_Time
  0'
 "#
  0 uModeline_Full_Update_Time'
 f[ inslen                              !*  Save last insert length.        !
 qEditor_Name [0                       !*  Save Editor Name in q0.         !
 f~..j 0 - 1 - fq0 "n o Set'         !*  If modeline damaged, go set it. !
 fq..j - (fq0 + 18) "l o Set'           !*  If modeline too short, ditto.   !
 qModeline_Safe_Macro f"n [0           !*  If a Modeline Safe Macro exists,!
  q0 - (]0 w fs mode macro) "n o Set'' !*   and isn't Mode Macro, goto Set.!
 :i0 ..j                              !*  Put modeline into q0.           !
 m(m.m &_Get_Current_Time) [1           !*  Save current time in q1.        !
 fqEditor_Name + 2 :f 0 1         !*  Insert time after Editor Name.  !
 fs os teco - 1 "e                      !*  If on Twenex,                   !
  fs load average u1                    !*   get the load average, and      !
                                         !*   insert it after the time (and  !
                                         !*   date if present).              !
  fq Editor_Name + 11 + (q Time_Only "e 10' "# 0') :f 0 1'
 f=0 ..j "e 0'                      !*  If modeline unchanged, quit.    !
 q0 u..j                                 !*  Otherwise, put it into ..j.     !
 fr                                      !*  Redisplay and return.           !
 0
 !Set!
 fs mode macro f"n [0 m0 fr ]0'         !*  If there is a Mode Macro, call  !
 0                                     !*   it, redisplay, and return.     !



!Toggle Date Display :! !C  Add/remove date display in mode line.  !

 q Time_Only "n 0' "# 1' uTime_Only
 1 fs mode change
 0



!& Kill Modeline Library :! !S  Restore the old mode line and clock macros.  !


 q Old_FS_Mode_Macro fs mode macro
 q Old_FS_Clk_Interval fs clk interval
 q Old_FS_Clk_Macro fs clk macro
 1 fs mode change
 0
   