(FILECREATED "24-SEP-81 16:14:31" ("compiled on " <LISPUSERS>SHOW.;14) (2 . 3) 
bcompl'd in USYS dated "24-SEP-81 16:09:13")
(FILECREATED "21-AUG-81 12:37:07" <LISPUSERS>SHOW.;14 1446 changes to: SHOW IT 
previous date: "31-JUL-79 09:55:23" <LISPUSERS>SHOW.;13)

IT BINARY
             	-.         Z   ,<  Z   Z  Z  ,<  ,<  $  D  ,~      (VARIABLE-VALUE-CELL LINE . 3)
(VARIABLE-VALUE-CELL LISPXHISTORY . 5)
IT
EDITFINDP
VALUOF
(ENTERF)      

SHOW BINARY
       *        ¨-.          Z   ,<  ,<   $  XB  ,<   "   ,<  @     +   ,<   Z   ,<  ,   ,   Z   ,   XB  XB` ,<  ¢,<  #,<   @  £ ` +   Z   Z  %XB Z  ,<  ,<  ¥$  &   ¦Zw~XB8 Z   ,~   2B   +   Z  'XB   [` XB  ,<   Z` Z  [  D  §Z  3B   +      (,~   Z` ,~   Z  ,~   @ÑAD&       (VARIABLE-VALUE-CELL EVENTSPEC . 59)
(VARIABLE-VALUE-CELL RESETVARSLST . 46)
VALUOF
OUTPUT
(VARIABLE-VALUE-CELL OLDVALUE . 15)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 52)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
0
PRINTDEF
TERPRI
ERROR
APPLY
ERROR!
(CF KNIL CONS CONSNL LIST2 KT ENTERF)       X         
          P        
(PRETTYCOMPRINT SHOWCOMS)
(RPAQQ SHOWCOMS ((FNS IT SHOW) (ADDVARS (LISPXMACROS (SHOW (SHOW (COND ((AND (
NULL (CDR LISPXLINE)) (LISTP (CAR LISPXLINE)))) (T LISPXLINE))))) (LISPXCOMS 
SHOW)) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (
NLAMA IT) (NLAML) (LAMA)))))
(ADDTOVAR LISPXMACROS (SHOW (SHOW (COND ((AND (NULL (CDR LISPXLINE)) (LISTP (CAR
 LISPXLINE)))) (T LISPXLINE)))))
(ADDTOVAR LISPXCOMS SHOW)
NIL
 