(FILECREATED "11-MAY-83 12:06:30" ("compiled on " <LISPUSERS>COMPILEBANG.;4) (2 . 2) brecompiled 
changes: COMPILE! in WORK dated "27-MAR-83 10:06:46")
(FILECREATED "10-MAR-83 12:48:17" {PHYLUM}<LISPUSERS>COMPILEBANG.;5 2343 changes to: (FNS COMPILE!) 
previous date: "18-JAN-82 17:08:00" {PHYLUM}<LISPUSERS>COMPILEBANG.;3)

COMPILE! BINARY
       O    9    M-.          X 9Z   ,<   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   ,<  @  ;@ ,~   Z   ,<   @  @  ,~   Z   ,<   ,<  B,<  B,<   @  C ` +   2Z   Z  DXB Z   3B   +   Z   3B   +   Z   +   Z"  +   Z   ,<   Z   2B   +   7   Z   ,<   Z   2B   +   7   Z   ,<   Z   3B   +    Z   ,<  D  E+   !Z  ,<   @  E +   0Z   -,   +   %+   %Z  I,<   Z  #-,   +   ),<   ,<   $  I+   .B  J3B   +   ,Z  &+   .,<  J,<   Z  +,<   ,   ,<   ,<   &  K,~   XB   Z   ,~   3B   +   4Z   +   4Z  KXB   D  LZ  43B   +   8   L,~   Z  0,~    !TJB	Jq0-0         (VARIABLE-VALUE-CELL X . 90)
(VARIABLE-VALUE-CELL NOSAVE . 52)
(VARIABLE-VALUE-CELL NOREDEFINE . 46)
(VARIABLE-VALUE-CELL PRINTLAP . 34)
(VARIABLE-VALUE-CELL NLAMA . 3)
(VARIABLE-VALUE-CELL NLAML . 5)
(VARIABLE-VALUE-CELL LAMS . 7)
(VARIABLE-VALUE-CELL LAMA . 9)
(VARIABLE-VALUE-CELL NOFIXFNSLST . 11)
(VARIABLE-VALUE-CELL NOFIXVARSLST . 13)
(VARIABLE-VALUE-CELL LISPXHIST . 18)
(VARIABLE-VALUE-CELL RESETVARSLST . 23)
(VARIABLE-VALUE-CELL BYTECOMPFLG . 37)
(VARIABLE-VALUE-CELL LOCALVARS . 58)
(VARIABLE-VALUE-CELL SYSLOCALVARS . 65)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 112)
(NIL VARIABLE-VALUE-CELL RESETZ . 107)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
UNION
(VARIABLE-VALUE-CELL LAPFLG . 0)
(VARIABLE-VALUE-CELL STRF . 0)
(VARIABLE-VALUE-CELL SVFLG . 0)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(NIL VARIABLE-VALUE-CELL LCFIL . 0)
(T VARIABLE-VALUE-CELL LSTFIL . 0)
(T VARIABLE-VALUE-CELL SPECVARS . 0)
*DUMMY-COMPILED-FUNCTION*
VIRGINFN
ARGTYPE
LAMBDA
COMPILE1
ERROR
RESETRESTORE
ERROR!
(LIST3 SKNLST SKLA ASZ KT CF KNIL ENTERF)  /    '    $        2   ) h           7 @ 3 X + P     p  (        
(PRETTYCOMPRINT COMPILEBANGCOMS)
(RPAQQ COMPILEBANGCOMS ((E (RESETSAVE CLISPIFYPRETTYFLG NIL)) (LISPXMACROS C) (FNS COMPILE!) (
USERMACROS C)))
(ADDTOVAR LISPXMACROS (C (COND (LISPXLINE (COMPILE! (CAR LISPXLINE) T NIL T)) (T C))))
(ADDTOVAR USERMACROS (C NIL (ORR (UP 1) NIL) (ORR ((E (COMPILE! (OR (LISTP (##)) (## !0)) T T T))) ((E
 (QUOTE C?))))))
(ADDTOVAR EDITCOMSA C)
(PUTPROPS COMPILEBANG COPYRIGHT ("Xerox Corporation" 1982 1983))
NIL
