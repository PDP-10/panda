(FILECREATED "16-MAR-82 00:07:48" ("compiled on " <LISPUSERS>IOWAITDAEMON.;1) (2 . 2) brecompiled 
changes: IOWAITDAEMON in WORK dated "10-MAR-82 01:09:35")
(FILECREATED "19-Mar-79 19:42:08" <LISPUSERS>IOWAITDAEMON..3 3477 changes to: IOWAITDAEMON previous 
date: " 2-Jan-79 11:29:48" <LISPUSERS>IOWAITDAEMON..2)
(MOVD? (QUOTE PROMPTCHAR) (QUOTE OLDPROMPTCHAR))

IOWAITDAEMON BINARY
    K    ū    Č-.          8 ūZ   3B   +   Z   2B   +   ,<   "  B3B   +   Z   ,~   Z   +   Z   ,~   ,<   ,<   "  B3B   +   +   =Z   ,   @   ,   ,>  >,>         ,^  /  3"  +   ļZ  ,<  @  Â  +   7Z` -,   +   +   6Z  XB   ,<   "  B3B   +   ,~   Z  Z   ,   2B   +   ^"   +   ,   ,>  >,>        ,^  /  2"  +   īZ  ,<     ,>  >,>  ^"j0,>  >,>  ,<  Ä,<   ,<   @  E ` +   ŽZ   Z  ÆXB Z  ĒB  G+    Z  -,   +   /^"  +   Ŋ,   $Bx  ,^  /  .Bx  ,^  /  ,   ,<  Z  F  Į[` XB` +   Z` ,~   ^"    $   @  ,<   "  B3B   +   ŧZ   +    Z   B  H+   
Zp  +      *X J1 TJ*"@#        (VARIABLE-VALUE-CELL IOWAITDAEMONFORMS . 37)
(VARIABLE-VALUE-CELL READBUF . 6)
(VARIABLE-VALUE-CELL IOWaitDaemonTimer+IOWAITSLEEPINTERVAL . 25)
(VARIABLE-VALUE-CELL IOWaitDaemonTimer . 112)
(VARIABLE-VALUE-CELL IOWAITDAEMONINTERVAL . 31)
(VARIABLE-VALUE-CELL IOWAITDAEMONHARRAY . 103)
(VARIABLE-VALUE-CELL IOWAITSLEEPINTERVAL . 119)
READP
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL form . 86)
(NIL VARIABLE-VALUE-CELL IOWAITDAEMONFORMS . 0)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
EVAL
PUTHASH
DISMISS
(URET1 FIXT MKN SKNI CONSNL CF GETHSH SKNLST BHC IUNBOX GUNBOX KT KNIL ENTER0)   ū @      8   `   P   (   H   h   0 ą       0 p         đ    0   X   8 š      (   x   H        
PROMPTCHAR MAXC
       	        -.           Z   ,<  Z   ,<  Z   F  @  ,\  ,~   0   (VARIABLE-VALUE-CELL ID . 3)
(VARIABLE-VALUE-CELL FLG . 5)
(VARIABLE-VALUE-CELL HISTORY . 7)
OLDPROMPTCHAR
IOWAITDAEMON
(ENTERF)      
(PRETTYCOMPRINT IOWAITDAEMONCOMS)
(RPAQQ IOWAITDAEMONCOMS ((DECLARE: FIRST (P (MOVD? (QUOTE PROMPTCHAR) (QUOTE OLDPROMPTCHAR)))) (FNS 
IOWAITDAEMON PROMPTCHAR) (VARS (IOWAITSLEEPINTERVAL 500) (IOWAITDAEMONINTERVAL 60000) (
IOWAITDAEMONHARRAY (LIST (HARRAY 10))) (IOWaitDaemonTimer 123456789)) (ADDVARS (IOWAITDAEMONFORMS) (
AFTERSYSOUTFORMS (CLRHASH IOWAITDAEMONHARRAY))) (P (RELINK (QUOTE WORLD))) (DECLARE: EVAL@COMPILE 
DONTCOPY (P (RESETSAVE DWIMIFYCOMPFLG T)))))
(RPAQ IOWAITSLEEPINTERVAL 500)
(RPAQ IOWAITDAEMONINTERVAL 60000)
(RPAQ IOWAITDAEMONHARRAY (LIST (HARRAY 10)))
(RPAQ IOWaitDaemonTimer 123456789)
(ADDTOVAR IOWAITDAEMONFORMS)
(ADDTOVAR AFTERSYSOUTFORMS (CLRHASH IOWAITDAEMONHARRAY))
(RELINK (QUOTE WORLD))
NIL
   