(FILECREATED "12-May-83 22:40:43" ("compiled on " <DDYER>EDITHIST..5) (2 . 2) bcompl'd in WORK dated 
"12-May-83 19:07:09")
(FILECREATED " 5-MAY-83 22:05:37" /lisp/ddyer/lisp/init/EDITHIST.;4 13506 changes to: (VARS 
EDITHISTCOMS) (FNS INITEDITHIST) previous date: "18-FEB-83 13:54:32" /lisp/ddyer/lisp/init/EDITHIST)

CHECKEDITHIST BINARY
        $        #-.           Z   2B  !+   [   Z  2B  !+   [  [  2B   +   Z  Z  2B  +   [  Z  2B  !+   [  	[  Z  Z 7@  7   Z  +   [  +   Z   ,<   @  "   ,~   Z   2B   +   Z   3B   +   7   Z   ,~   -,   +   ,<   Z  D  ",~   2B   +   Z  ,~   Z  Z  ,   3B   +   Z   ,~   1	@)	H (VARIABLE-VALUE-CELL COM . 30)
(VARIABLE-VALUE-CELL NAME . 56)
(VARIABLE-VALUE-CELL TYPE . 14)
VARS
*
(VARIABLE-VALUE-CELL NAMEIT . 57)
INTERSECTION
(FMEMB SKLST KT KNOB KNIL ENTERF)  `       x  @   h   h  p          

DELEDITHISTDEF BINARY
    	        	-.          Z   ,<   ,<   Z   F  Z  ,<   Z   D  ,~   D   (VARIABLE-VALUE-CELL NAME . 8)
(VARIABLE-VALUE-CELL TYPE . 10)
(VARIABLE-VALUE-CELL EDITHISTALIST . 6)
/PUTASSOC
MARKASCHANGED
(KNIL ENTERF)  8      

GETEDITHISTDEF BINARY
               -.          Z   ,<   Z   D  [  ,~       (VARIABLE-VALUE-CELL NAME . 3)
(VARIABLE-VALUE-CELL TYPE . 0)
(VARIABLE-VALUE-CELL OPTIONS . 0)
(VARIABLE-VALUE-CELL EDITHISTALIST . 5)
ASSOC
(ENTERF)    

INITEDITHIST BINARY
    H    9    F-.           9Z   B  ;,<   @  <   
,~   Z   ,<   Z   D  >3B   +   Z  ,<   Z  D  ?XB  ,<  ?"  @,<   Z  ?Z 7@  7   Z  ,   Z  ?,   ,<   Z  ?Z   ,   ,\   Z   ,   XB  Z   ,<   Z  	D  >3B   +   "Z  ,<   Z  D  ?XB  ,<  ?"  @,<   Z  ?Z 7@  7   Z  ,   Z  ?,   ,<   Z  ?Z  @,   ,\   Z  ,   XB  !,<   ,<  AZ  B  AF  BXB   3B   +   2Z  #Z   7   [  Z  Z  1H  +   +2D   +   (2B   +   8Z  &,<   ,<  B$  CZ  [  XB   3B   +   8,<  CD  D+   8Z   2B   +   8Z  ,,<  ,<  D$  E,<   ,<  AZ  4F  EZ   ,~   EP$"hdSI(    (VARIABLE-VALUE-CELL FILE . 110)
(VARIABLE-VALUE-CELL OPTIONS . 49)
(VARIABLE-VALUE-CELL RESETVARSLST . 68)
(VARIABLE-VALUE-CELL EDITHISTALIST . 78)
(VARIABLE-VALUE-CELL ASKEDITHIST . 101)
U-CASE
(VARIABLE-VALUE-CELL FILE . 0)
((ASK ask COMMENT comment) VARIABLE-VALUE-CELL ASK . 17)
((NOASK noask NOCOMMENT nocomment) VARIABLE-VALUE-CELL NOASK . 47)
(NIL VARIABLE-VALUE-CELL FD . 95)
(NIL VARIABLE-VALUE-CELL OLDP . 74)
INTERSECTION
LDIFFERENCE
ASKEDITHIST
STKSCAN
NOCOMMENT
EDITHIST
FILECOMS
INFILECOMS?
FILEDATES
GETPROP
EDITHISTALIST
LOADVARS
NAME
FILENAMEFIELD
ADDTOFILE
(CONS SET KT CONS21 CONSS1 KNOB KNIL ENTERF)   " 8        4 8          `      `    1 H + h   x      

MAKEDITHIST BINARY
     V    @    T-.        0 @Z   3B   +   ;Z   3B   +   ;,<   "  C,<   @  D  +   ;,<  CZ   ,<   ,   ,   Z   ,   XB  
XB` ,<  F,<  F,<   @  G ` +   2Z   Z  HXB Z   B  I,<   @  I   +   0Z   ,<   Z  Z   7   [  Z  Z  1H  +   2D   +   [  -,   Z   @  J,<   Z   2B   +   Z   @  J,<   Z  ,<   ,   ,<   Z  3B  K+   (,<  K,<  L,<  L,<  M,<   ,<   ,<  M,<  N,   N  N+   (Z   D  O,   D  OB  O,<   Z  -,   +   .Z  ,   ,   XB  +F  PZ   ,~   Zw~XB8 Z   ,~   2B   +   4Z  PXB   [` XB  ,<  CZ` Z  [  D  QZ  33B   +   :   Q,~   Z` ,~   ,<  R,<  R,<  SZ  SZ  ,   ,   ,   ,   ,~   *`)PD(MV@1        (VARIABLE-VALUE-CELL A . 122)
(VARIABLE-VALUE-CELL CHANGES . 62)
(VARIABLE-VALUE-CELL ASKEDITHIST . 66)
(VARIABLE-VALUE-CELL RESETVARSLST . 105)
(VARIABLE-VALUE-CELL EDITHISTALIST . 92)
(VARIABLE-VALUE-CELL INITIALS . 56)
(VARIABLE-VALUE-CELL USERNAME . 59)
RAISE
(VARIABLE-VALUE-CELL OLDVALUE . 16)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 111)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
U-CASE
(VARIABLE-VALUE-CELL NAME . 89)
DATE
OUTFILE
NOCOMMENT
10
%]
"comments : "
(((%] " none
") ) . 0)
RETURN
((COND ((EQUAL ANSWER (QUOTE (%]))) NIL) (ANSWER)) . 0)
ASKUSER
NCONC
SHRINKEDITHIST
PUTASSOC
ERROR
APPLY
ERROR!
DECLARE:
DONTCOPY
ALISTS
EDITHISTALIST
(ALIST3 ALIST2 KT SKNLST LIST4 SKLST CF CONS CONSNL LIST2 KNIL ENTERF)  x   p       H      0       h     @ h .   
    '      3   ) ` % X     X   0      

MERGEEDITHIST BINARY
        B    ;    @-.           ;Z   ,<   Z   ,<   @  < @,~   Z   ,<   Z  XB   -,   +   +   	Z  ,<   Z   XB  -,   +   +   [  
,   D  >[  Z  ,<   [  	Z  ,\  ,   2B   +   [  ,<   [  Z  -,   3B   7    ,   ,<   [  Z  -,   3B   7    ,   D  >D  >[  [  ,<   [  [  Z  XB  -,   +   +    Z  ,<   [  [  Z  XB  -,   +   $+   $[  ",   D  >[  [  [  ,<   [  %[  [  Z  -,   3B   7    ,   ,<   [   [  [  Z  -,   3B   7    ,   D  >D  >[  '[  [  ,<   [  1[  [  [  ,<   [  ,[  [  [  D  ?D  ?Z  ,<   [  D  ?Z   ,~   @02   0       (VARIABLE-VALUE-CELL NEWER . 113)
(VARIABLE-VALUE-CELL OLDER . 115)
(VARIABLE-VALUE-CELL NEW . 102)
(VARIABLE-VALUE-CELL OLD . 107)
(NIL VARIABLE-VALUE-CELL TEMP . 72)
RPLACA
UNION
APPEND
RPLACD
(CONSNL SKLST KNIL EQUAL CONSS1 SKNLST ENTERF)  ,       / (  P   8 / 0  X         % X   8  8        

PUTEDITHISTDEF BINARY
    
        
-.          Z   ,<   Z   ,<  Z   F  	Z  ,<   Z   D  	,~   "   (VARIABLE-VALUE-CELL NAME . 9)
(VARIABLE-VALUE-CELL TYPE . 11)
(VARIABLE-VALUE-CELL DEFINITION . 5)
(VARIABLE-VALUE-CELL EDITHISTALIST . 7)
/PUTASSOC
MARKASCHANGED
(ENTERF)      

SHRINKEDITHIST BINARY
       i    [    f-.          [Z   ,<   [  ,<   @  \ @ ,~   Z   -,   +   YZ   -,   +   YZ   g  [  2B   9  	   ,>  Z,>          ,^   /   3b  +   YZ  B  ],<   @  ]  +   Y@  ^  +   N    ,>  Z,>    `      ,^   /   3b  +   Z` ,~   Z   ,<   Z  D  `XB   [  ,<      ."   ,   ,<   @  ` @+   CZ`  XB   Z   -,   +   #Z` ,~   Z  2B   +   %+   ?Z  ![  [  [  [  2B   +   6Z  1B  +   3Z  %[  Z  -,   3B   7    ,   ,<   Z  #[  Z  -,   3B   7    ,   D  b3B   +   6Z  .,<   Z  *D  c+   ?Z  )0B  +   >    ,>  Z,>          ,^   /   3b  +   >Z  3,<   Z  4D  c+   ?Z  =XB  <[  >XB  ?   7."   ,   XB  @+   !Z  g  [  2B   9  D   ,>  Z,>      9    ,^   /   2b  +   L   6."   ,   XB  J   K."   ,   XB  L+   ,<  c,<   $  dZ  Cg  [  2B   9  Q   ,   ,<   ,<   $  d,<  d,<   $  d,<   "  eZ  PB  e,~   ,~   Z  ,~      B! *T0  Q0!T     (VARIABLE-VALUE-CELL EH . 179)
(VARIABLE-VALUE-CELL LIMITEDITHIST . 5)
(VARIABLE-VALUE-CELL SOFTLIMIT . 57)
(VARIABLE-VALUE-CELL HARDLIMIT . 142)
REVERSE
(VARIABLE-VALUE-CELL OL . 175)
(NIL VARIABLE-VALUE-CELL WL . 126)
2
NIL
(1 VARIABLE-VALUE-CELL PASS . 155)
NTH
(0 . 1)
(VARIABLE-VALUE-CELL I . 132)
NIL
(NIL VARIABLE-VALUE-CELL WZ . 128)
INTERSECTION
MERGEEDITHIST
" << edit history reduced to "
PRIN1
" entries >>"
TERPRI
DREVERSE
(KT CONSNL SKLST ASZ SKNLST MKN BHC KNIL SKI ENTERF) 
x V 
P P    2 h    -    7 (   (   
@ N 	@ B h   	 ; x     R X 3  -  % (            
(PRINT (QUOTE EDITHISTCOMS) T T)
(RPAQQ EDITHISTCOMS ((FILEPKGCOMS EDITHIST) (ADDVARS (MAKEFILEFORMS (INITEDITHIST FILE))) (FNS 
CHECKEDITHIST DELEDITHISTDEF GETEDITHISTDEF INITEDITHIST MAKEDITHIST MERGEEDITHIST PUTEDITHISTDEF 
SHRINKEDITHIST) (* EDITHISTALIST is the home of all edit histories. ASKEDITHIST controls the 
activities of the EDITHISTORY package during MAKEFILE. If ASKEDITHIST=NIL, nothing is ever added to 
any history list. If ASKEDITHIST=NOCOMMENT, ASKUSER is not called and no session coments ARE recorded,
 but the DATE, user and CHANGE list ARE added to the history list. If ASKEDITHIST=COMMENT, ASKUSER 
will be called to ger a comment line from the user, which will be incorporated into the edit history. 
Finally, if ASKEDITHIST=T, the edit history list will create a new edit history for any FILE that is 
written that DOESN'T HAVE one, and will otherwise behave as ASKEDITHIST=COMMENT. Finally, if option 
"ASK" is given to makefile, Comments will be asked for, whatever the setting of ASKEDITHIST) (ALISTS (
EDITHISTALIST)) (VARS (ASKEDITHIST (QUOTE NOCOMMENT)) (LIMITEDITHIST (QUOTE (10 . 30)))) (GLOBALVARS 
ASKEDITHIST LIMITEDITHIST) (* Edit histories ARE all maintained on the ALIST EDITHISTALIST. The FORM 
of the individual ALIST entry is (histname (DATE USERID CHANGELIST COMMENTSLIST) (DATE USERID 
CHANGELIST COMMENTSLIST) ...) when there ARE several edithistories on a single EDITHIST command, the 
first is regarded as the currently active one, the others ARE treated as archival and ARE not added to
) (EDITHIST EDITHIST) (DECLARE: DONTCOPY (RECORDS * EDITHISTRECORDS)) (DECLARE: DONTEVAL@LOAD 
DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA MAKEDITHIST) (NLAML) (LAMA)))))
(PUTDEF (QUOTE EDITHIST) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (COMS * (MAKEDITHIST . X))) 
CONTENTS CHECKEDITHIST) (TYPE DESCRIPTION "file edit history" GETDEF GETEDITHISTDEF PUTDEF 
PUTEDITHISTDEF DELDEF DELEDITHISTDEF))))
(ADDTOVAR MAKEFILEFORMS (INITEDITHIST FILE))
(ADDTOVAR EDITHISTALIST)
(RPAQQ ASKEDITHIST NOCOMMENT)
(RPAQQ LIMITEDITHIST (10 . 30))
NIL
