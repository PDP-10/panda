(FILECREATED "24-SEP-81 21:44:14" ("compiled on " <LISPUSERS>SYSCOND.;6) (2 . 3
) bcompl'd in WORK dated NOBIND)
(FILECREATED "15-JAN-81 18:18:00" <LISPUSERS>SYSCOND.;6 2986 changes to: 
SYSCOND previous date: "22-MAY-80 22:44:12" <LISPUSERS>SYSCOND.;5)

SYSCOND BINARY
        "        !-.          Z   ,<   @     ,~   Z   -,   +   
3B   +   ,<  D  ,~   ,<  Z  D  ,~   Z  6@   Z  Z  Z  3B  +   Z  Z  -,   Z   Z  2B  +   Z  6@   Z  ,<   Z  Z  [  D  3B   +   Z   ,<   Z  [  ,<   ,<   &  !,~   [  XB  +   U"BaD  (VARIABLE-VALUE-CELL FORMS . 17)
(VARIABLE-VALUE-CELL TAIL . 53)
"UNUSUAL CDR ARG LIST"
ERROR
"UNRECOGNIZED SYSTEM TYPE"
TENEX
TOPS20
OR
MEMB
PROGN
INTERNAL
APPLY
(SKLST KL20FLG KNIL SKNLST ENTERF)  x   (                   

SYSRECTRAN BINARY
        ;    4    9-.           4   52B  5+   [   [  ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   @  6   +   Z  5Z   1B  +   *  -,   +   *  ,   2B   7       ,~   3B   +   Zp  +   [p  XBp  +   /   Z  [  Z  +   .3B  6+   3B  7+   2B  7+   .[  [  ,<   Zp  -,   +   Z   +   +Zp  ,<   ,<w/   @  6   +   (Z  8Z  1B  +   &*  -,   +   '*  ,   2B   7       ,~   3B   +   *Zp  +   +[p  XBp  +   /   Z  [  Z  +   .   8,<   @  9   ,~   Z   ,<   [  Z  [  0,   ,   ,~   I $`PY C       (VARIABLE-VALUE-CELL DECL . 99)
COMPILEMODE
ALTO
(VARIABLE-VALUE-CELL X . 68)
PDP-10
MAXC/10
MAXC
TENEX
SHOULDNT
(VARIABLE-VALUE-CELL RESULT . 101)
(CONSS1 CONS KT FMEMB SKLST BHC KNIL SKNLST ENTERF)  H   @   x     & x   P     ,       ( p             `      
(PRETTYCOMPRINT SYSCONDCOMS)
(RPAQQ SYSCONDCOMS ((E (RESETSAVE CLISPIFYPRETTYFLG NIL)) (FNS SYSCOND) (ALISTS
 (DWIMEQUIVLST SYSCOND) (PRETTYEQUIVLST SYSCOND)) (ADDVARS (NOFIXVARSLST ALTO 
TENEX)) (PROP (ALTOMACRO MACRO) SYSCOND) (ADDVARS (CLISPRECORDTYPES SYSREC)) (P
 (MOVD? (QUOTE RECORD) (QUOTE SYSREC))) (PROP USERRECORDTYPE SYSREC) (FNS 
SYSRECTRAN) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (
ADDVARS (NLAMA SYSCOND) (NLAML) (LAMA)))))
(ADDTOVAR DWIMEQUIVLST (SYSCOND . COND))
(ADDTOVAR PRETTYEQUIVLST (SYSCOND . COND))
(ADDTOVAR NOFIXVARSLST ALTO TENEX)
(PUTPROPS SYSCOND ALTOMACRO (FORMS (MKPROGN (CDAR (SOME FORMS (FUNCTION (LAMBDA
 (X) (COND ((OR (EQ (CAR X) (QUOTE ALTO)) (AND (EQ (CAR (LISTP (CAR X))) (QUOTE
 OR)) (MEMB (QUOTE ALTO) (CDAR X)))))))))))))
(PUTPROPS SYSCOND MACRO (FORMS (MKPROGN (CDAR (SOME FORMS (FUNCTION (LAMBDA (X)
 (COND ((OR (EQ (CAR X) (QUOTE TENEX)) (AND (EQ (CAR (LISTP (CAR X))) (QUOTE OR
)) (MEMB (QUOTE TENEX) (CDAR X)))))))))))))
(ADDTOVAR CLISPRECORDTYPES SYSREC)
(MOVD? (QUOTE RECORD) (QUOTE SYSREC))
(PUTPROPS SYSREC USERRECORDTYPE SYSRECTRAN)
NIL
