(FILECREATED "18-Apr-83 13:52:30" ("compiled on " 
<LISPUSERS>SYSALL.LSP.21117) (2 . 2) tcompl%'d in WORK dated 
"27-MAR-83 14:33:23")
(FILECREATED "18-Apr-83 13:51:35" <LISPUSERS>SYSALL.LSP.21117 1735 
changes to: (VARS SYSALLCOMS) previous date: "16-NOV-82 12:35:13" 
<LISPUSERS>SYSALL.LSP.21116)

CHECKSYSOUT BINARY
               -.          @    ,~   ,<  ,<   ,<   @   ` +   
Z   Z  XB Z   B  XB   Z   ,~   2B   +   ,<  Z  B  ,   Z   ,   XB  +   Z  3B   +   [  Z  ,<   Z  B  ,<   Z  ,   Z  ,   XB  Z   ,~   h$     (VARIABLE-VALUE-CELL JFN . 36)
(VARIABLE-VALUE-CELL SYSOUTS . 43)
(NIL VARIABLE-VALUE-CELL INFO . 39)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SYSOUTP
0
JFNS
(ALIST3 CONS ALIST2 KT CF KNIL ENTERF)   P   `         
            P        

PRINTSYSOUTS BINARY
      )         (-.            Z   ,<   ,<   $  !,<   @  "  ,~   Z`  -,   +   +   Z  XB   Z  Z   ,   3B   +   Z  $+   Z  XB  	0B   +   Z   +   Z   Z  B  $,<   Z   D  %,<  %,<   Z  F  &[  Z  ,<   Z  D  %,<  &,<   Z  F  &[  [  Z  2B   +   Z  ',<   Z  D  %Z  B  '[`  XB`  +   Z` ,~   !@q$H2R      (VARIABLE-VALUE-CELL SYSOUTS . 3)
(VARIABLE-VALUE-CELL LOGFILE . 58)
SORT
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL INFO . 49)
(-1 VARIABLE-VALUE-CELL LASTDATE . 31)
""
GDATE
PRIN1
20
TAB
56
"makesys"
TERPRI
(ASZ KNIL EQUAL SKNLST KT ENTERF)           p     
          8      

SYSALL BINARY
             -.           @    ,~   Z   ,<   ,<  $  Z   2B   +   Z  ,<   ,<  $  XB  Z   ,<  D  Z  B  ,~   31  (VARIABLE-VALUE-CELL SUBTREE . 6)
(VARIABLE-VALUE-CELL LOGFILE . 21)
(NIL VARIABLE-VALUE-CELL SYSOUTS . 18)
((@ CHECKSYSOUT) . 0)
DIRECTORY
SYSOUT.OWNERS
OUTPUT
OPENFILE
PRINTSYSOUTS
CLOSEF
(KNIL ENTERF)    h      
(PRETTYCOMPRINT SYSALLCOMS)
(RPAQQ SYSALLCOMS ((FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) 
CJSYS) (FNS CHECKSYSOUT PRINTSYSOUTS SYSALL) (VARS (FILELINELENGTH 132))
))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) CJSYS)
(RPAQQ FILELINELENGTH 132)
(PUTPROPS SYSALL.LSP COPYRIGHT (NONE))
NIL
