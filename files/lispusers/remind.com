(FILECREATED " 4-DEC-81 00:02:03" ("compiled on " <LISPUSERS>REMIND.;2) (2 . 2) brecompiled changes: 
nothing in WORK dated " 2-DEC-81 17:41:27")
(FILECREATED " 4-DEC-81 00:01:34" <LISPUSERS>REMIND.;2 8618 changes to: REMINDCOMS previous date: 
"27-NOV-81 12:43:59" <LISPUSERS>REMIND.;1)
ADDREMINDER BINARY
       @    �    >-.          �@  7  ,~   Z   -,   Z   Z  2B  8+   �   �,<  9,<  �$  :XB   [  [  [  [  Z  B  �,<  �Z  �,<  �Z   ,<  ,   XB   Z  �[  [  [  [  [  Z  2B   +   Z  [  [  [  [  [  ,<  �,<  ;$  �Z  �[  [  [  [  [  [  Z  2B   +   "Z  [  [  [  [  [  [  ,<  �,<  <$  �Z  [  [  [  [  [  [  [  Z  2B   +   -Z  "[  [  [  [  [  [  [  ,<  �,<  �$  �Z  �B  =+   2Z  ,<  �,<   Z  ,<  ,   XB  -Z  �Z   ,   XB  �   �Z   ,~   `   @       (VARIABLE-VALUE-CELL when . 93)
(VARIABLE-VALUE-CELL what . 96)
(VARIABLE-VALUE-CELL REMINDERLIST . 103)
(NIL VARIABLE-VALUE-CELL newRecord . 100)
(NIL VARIABLE-VALUE-CELL DATUM . 16)
MULTIPLEDATETIMES
SETNOWDATETIME
NOW
DATETIME
GETPROP
EVAL
0
RPLACA
1
AM
FINISHDATETIME
UPDATEREMINDFILE
(CONS LIST3 KNIL SKLST ENTERF)   4    2 p   X � x  8     �       
CANCELREMINDERS BINARY
     �    '    /-.           '@  �  ,~   Z   ,<  �Zp  -,   +   +   �Zp  ,<  �@  �   �+   !,<   "  ),<  �,<   $  *[   Z  -,   Z   Z  2B  �+   �[  Z  B  ++   �Z  �B  +,<  �,<   $  *,<   "  ),<  �,<   $  *[  �[  Z  ,<  �,<   $  *,<   "  ),<  ,,<  �,<  -,<  �(  .2B  �+   �Z  �Z   ,   XB  �,~   Z   XB   ,~   [p  XBp  +   /  �Z   3B   +   &Z  �XB     �Z   ,~   VAM-@H    (VARIABLE-VALUE-CELL REMINDERLIST . 74)
(NIL VARIABLE-VALUE-CELL newReminderList . 73)
(NIL VARIABLE-VALUE-CELL changes . 70)
(VARIABLE-VALUE-CELL reminder . 58)
TERPRI
"Expire date - "
PRIN1
MULTIPLEDATETIMES
DATETIMETOSTRING
"Reminder - "
10
N
"Do you want to delete this request? "
(((Y "es
") (N "o
")) . 0)
ASKUSER
UPDATEREMINDFILE
(BHC CONS KNIL SKLST KT SKNLST ENTER0)   8   p   p � X   P    �  � @  0 �    �       
CHECKREMINDERS BINARY
      J    :    H-.           :@  ;  0,~      >   �,<  ?,<  �$  @XB   Z   B  �,<  �@  A  �+   �Z` �XB   Z  �-,   +   �Z` ,~   Z  
XB   Z  ,<  �Z  �D  C3B   +   2Z   XB   ,<  �,<   $  D,<  �,<   $  DZ  �B  E,<  �,<   $  D,<   "  �[  �[  Z  -,   +   [  [  Z  ,<  �,<   $  D,<   "  �+   ![  �[  Z  B  F[  Z  -,   Z   Z  2B  �+   4Z  !XB   ,<   [  �Z  [  [  Z  B  FXB  %Z  ),<  �Z  �D  C2B   +   &Zp  /  �Z  &,<  �Z  �D  GZ  �Z   ,   XB  0+   4Z  �Z  1,   XB  �[  �XB  4+   
Z  2B   +   8Z   ,~   Z  �XB     �+   7y( �5,�@P!!@   (VARIABLE-VALUE-CELL REMINDERLIST . 113)
(VARIABLE-VALUE-CELL CHECKREMINDERINTERVAL . 110)
(NIL VARIABLE-VALUE-CELL remindFile . 0)
(NIL VARIABLE-VALUE-CELL fullName . 0)
(NIL VARIABLE-VALUE-CELL changes . 107)
(NIL VARIABLE-VALUE-CELL now . 85)
(NIL VARIABLE-VALUE-CELL DATUM . 93)
(NIL VARIABLE-VALUE-CELL newReminderList . 112)
CHECKTODAY
SETNOWDATETIME
NOW
DATETIME
GETPROP
APPEND
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL rem . 105)
(NIL VARIABLE-VALUE-CELL reminder . 100)
DLESSP
""
PRIN1
"Reminder expired "
DATETIMETOSTRING
TERPRI
EVAL
MULTIPLEDATETIMES
RPLACA
UPDATEREMINDFILE
(CONS BHC SKLST SKSTP KT KNIL SKNLST ENTER0)   4    `   0   (   h �    H     p � h �    8      
LOADREMINDERS BINARY
         �    -.            �@  �  ,~   ,<     �,<  �,<  ,<  �,<  ,<  �,  B  �XB   3B   +   �,<  �,<  ,<  �&  Z  �B  �B  Z  B  �Z   ,~   _KZ      (NIL VARIABLE-VALUE-CELL file . 25)
DIRECTORY
DIRECTORYNAME
NAME
REMIND
EXTENSION
LISP
PACKFILENAME
INFILEP
INPUT
OLD
OPENFILE
READ
EVAL
CLOSEF
(KNIL ENTER0)  �       
REMIND BINARY
       �    �    �-.      �    �@  �  ,~      U   �Z   3B   +   &B  VXB   -,   Z   Z  2B  �+   '[  [  [  [  [  Z  2B   +   [  	[  [  [  [  ,<  �,<  W$  �[  [  [  [  [  [  Z  2B   +   [  [  [  [  [  [  ,<  �,<  X$  �[  �[  [  [  [  [  [  Z  2B   +   $[  [  [  [  [  [  [  ,<  �,<  �$  �Z  B  YXB  $+   'Z   ,~   Z  %-,   Z   Z  2B  �+   8,<  Z,<   $  �[  '[  Z  ,<  �,<   $  �,<   "  [[  �[  [  [  Z  ,<  �,<   $  �,<   "  [,<  �,<   $  �,<   "  \XB  +   Z  �-,   Z   Z  3B  �+   >Z  8-,   Z   Z  2B  ]+   D,<  �,<   $  �,<   "  [,<  ^,<   $  �,<   "  \XB  7+   Z  ;-,   Z   Z  2B  �+   QZ  D,<  �,<  �,<  �$  _D  �3B   +   Q,<  `,<   $  �,<   "  [,<  �,<   $  �,<   "  \XB  C+   Z  G,<  �Z   D  a+   &L `�(A �(0uU{-(`      (VARIABLE-VALUE-CELL when . 160)
(VARIABLE-VALUE-CELL what . 164)
(NIL VARIABLE-VALUE-CELL time . 162)
CHECKTODAY
SETNOWDATETIME
PARSEDATETIME
DATETIME
0
RPLACA
1
AM
FINISHDATETIME
DATETIMEERROR
"Date format error - "
PRIN1
TERPRI
"Try again (NIL to give up) - "
READ
DURATION
QUALIFIEDDATETIME
"Date must be a specific time or a recurring time "
"Try again (NIL to give up) - "
NOW
GETPROP
DLESSP
"Your date has already expired"
"Try again (NIL to give up) - "
ADDREMINDER
(KT SKLST KNIL ENTERF)  
  O 	X � 0 B  � p 6 H � x � 8   X �  �  x   	0 F P :  ' p � P   X      
UPDATEREMINDFILE BINARY
           �    -.           �@    ,~   ,<     �,<  �,<  ,<  �,<  ,<  �,  XB   ,<  �,<  �$  XB   3B   +   B  �Z   3B   +   �Z  B  ,<  �"  Z  B  �,<  "  Z  �B  �Z   ,~   _K]     (VARIABLE-VALUE-CELL REMINDERLIST . 29)
(NIL VARIABLE-VALUE-CELL remindFile . 33)
(NIL VARIABLE-VALUE-CELL fullName . 18)
DIRECTORY
DIRECTORYNAME
NAME
REMIND
EXTENSION
LISP
PACKFILENAME
OLD
FULLNAME
DELFILE
OUTFILE
"(RPAQQ REMINDERLIST "
PRIN1
PRINT
")
STOP
"
CLOSEF
(KNIL ENTER0)   � H �       
(PRETTYCOMPRINT REMINDCOMS)
(RPAQQ REMINDCOMS ((FNS ADDREMINDER CANCELREMINDERS CHECKREMINDERS LOADREMINDERS REMIND 
UPDATEREMINDFILE) (DECLARE: DONTCOPY EVAL@COMPILE (RECORDS REMINDNOTICE) (FILES (SOURCE) 
DATETIMERECORDS)) (DECLARE: DONTEVAL@LOAD DOCOPY (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) 
DATETIME IOWAITDAEMON)) (VARS (REMINDERLIST NIL) (CHECKREMINDERINTERVAL 5)) (ADDVARS (
IOWAITDAEMONFORMS (CHECKREMINDERS)) (AFTERSYSOUTFORMS (LOADREMINDERS))) (DECLARE: DONTEVAL@LOAD 
DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML REMIND) (LAMA)))))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) DATETIME IOWAITDAEMON)
(RPAQQ REMINDERLIST NIL)
(RPAQQ CHECKREMINDERINTERVAL 5)
(ADDTOVAR IOWAITDAEMONFORMS (CHECKREMINDERS))
(ADDTOVAR AFTERSYSOUTFORMS (LOADREMINDERS))
(PUTPROPS REMIND COPYRIGHTOWNER NONE)
NIL
  