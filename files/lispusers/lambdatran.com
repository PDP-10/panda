(FILECREATED "18-NOV-81 22:30:33" ("compiled on " <LISPUSERS>LAMBDATRAN.;24) (2 . 2) brecompiled 
explicitly: NARGS in "INTERLISP-MAXC " dated "18-NOV-81 22:01:03")
(FILECREATED "18-NOV-79 22:45:22" <LISPUSERS>LAMBDATRAN.;24 7286 changes to: LAMBDATRANCOMS previous 
date: " 6-AUG-79 22:50:04" <LISPUSERS>LAMBDATRAN.;23)
(VIRGINFN (QUOTE ARGLIST) T)
(MOVD? (QUOTE ARGLIST) (QUOTE OLDARGLIST))
(VIRGINFN (QUOTE NARGS) T)
(MOVD? (QUOTE NARGS) (QUOTE OLDNARGS))
(VIRGINFN (QUOTE ARGTYPE) T)
(MOVD? (QUOTE ARGTYPE) (QUOTE OLDARGTYPE))
ARGLIST BINARY
       #        "-.          ,<`  "  ,<   ,<   ,<w"  2B   +   
Zw-,   +   
Zw3B  +   
3B   +   
2B   +   ,<`  "  !+    Z   3B   +   ZwZ  ,   XBp  3B   +   XB`  /  +   Zw,<   Z   D  ![  [  [  Z  XBp  3B   +   ,<   ,<w "   ,   XBp  3B   +   +    ,<`  "  !+    )?"	  (FN . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 28)
(VARIABLE-VALUE-CELL LAMBDATRANFNS . 38)
CGETD
SUBRP
LAMBDA
NLAMBDA
FUNARG
OLDARGLIST
ASSOC
(KT EVCC BHC GETHSH URET2 SKLST KNIL ENTER1)   0           x   X  H    p   x  X   @      
ARGTYPE BINARY
              -.           ,<`  "  2B   +   ,<`  "  2B  +   Z"   ,~   2B  +   Z"   ,~   2B  +   
Z"  ,~   2B  +   Z"  ,~   Z   ,~   9L` (FN . 1)
OLDARGTYPE
FNTYP
EXPR
FEXPR
EXPR*
FEXPR*
(ASZ KNIL ENTER1)  H 
        8      
FNTYP1 BINARY
               -.          ,<   Z   3B   +   Z`  Z  ,   XBp  3B   +   B  +    Z`  ,<   Z   D  [  XBp  3B   +    [p  Z  XBp  3B  +   3B  +   3B  +   2B  +   +    2B   +   Z  +    ,<   ,<`   "   ,   +    ~`    (X . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 8)
(VARIABLE-VALUE-CELL LAMBDATRANFNS . 17)
FNTYP
ASSOC
EXPR
EXPR*
FEXPR
FEXPR*
(EVCC URET1 GETHSH KNIL ENTER1)       @  @          8   8        
LTDWIMUSERFN BINARY
        `    O    ]-.          H OZ   ,<   Z   ,<  @  S @
,~   Z   -,   +   Z  Z   ,   3B   +   
Z  +   Z  	-,   +   Z  
XB  B  VXB  +   Z  -,   Z   +   Z   3B   +   Z  -,   7   7   +   +   Z   +   Z  XB  B  VXB  XB` Z` ,<   Z   D  V[  Z  XB` 3B   +   NZ   XB   ,<` ,<`  "   ,   XB` -,   +   "Z   ,~   Z` ,<   Z  B  V,\  3B  +   *Z` ,<   Z  #,<  ,<  W$  W,\  2B  +   >[` -,   Z   [  ,<   ,<   ,<   ,<   Zw~XBwZw-,   +   1+   =Zw-,   Z   Z  XBp  3B  X+   <2B  X+   6+   <Z   2B  +   8+   <,<  YZ  &,<  ,   ,<   ,<w$  Y+   >[wXBw+   /Zw/  ,<` ,<` $  ZZ  3B   +   D,<  Z,<` Z   F  [,~   Z` 3B  [+   F2B  \+   NZ` Z  2B  +   M[  G,<   Z  H,<   ,<   ,<   ,<   Z  8L  \Z  I,~   Z` ,~   B
%	!  d B2<@        (VARIABLE-VALUE-CELL EXPR . 46)
(VARIABLE-VALUE-CELL FAULTFN . 152)
(VARIABLE-VALUE-CELL FAULTX . 154)
(VARIABLE-VALUE-CELL LAMBDASPLST . 14)
(VARIABLE-VALUE-CELL FAULTAPPLYFLG . 128)
(VARIABLE-VALUE-CELL LAMBDATRANFNS . 50)
(VARIABLE-VALUE-CELL CLISPCHANGE . 58)
(VARIABLE-VALUE-CELL COMMENTFLG . 108)
(VARIABLE-VALUE-CELL FAULTARGS . 133)
(VARIABLE-VALUE-CELL EXPR . 0)
(VARIABLE-VALUE-CELL FAULTFN . 0)
NIL
NIL
NIL
GETD
ASSOC
EXPR
GETP
DECLARE
CLISP:
LTSTKNAME
ATTACH
CLISPTRAN
FAULTAPPLY
RETAPPLY
LAMBDA
NLAMBDA
DWIMIFY0?
(BHC LIST2 SKNLST EVCC KT SKLA KNIL FMEMB SKLST ENTER0)  p   (    !          @   0     L 	@ K  3 h . X ,    X          ( + x        
LTSTKNAME BINARY
              -.          ,<   ,<  	,<  
,<   Z   H  
XBp  ,<   ,<`  $  ,<p  "  Z   +    "@  (NAME . 1)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 7)
-1
LTSTKNAME
REALSTKNTH
SETSTKNAME
RELSTK
(URET1 KT KNIL ENTER1)     @           

NARGS BINARY
                -.           ,<`  "  2B   +   ,<  ,<   ,<   @   ` +   Z   Z  XB Zw,<8  "  ZwXB8  Z   ,~   3B   +   Z`  2B   +   Z"   ,~   -,   +   B  ,~   Z"   ,~   Z   ,~   JD	     (X . 1)
OLDNARGS
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ARGLIST
LENGTH
(SKLST ASZ KT CF KNIL ENTER1)       p   8    x   0  H   P        
(PRETTYCOMPRINT LAMBDATRANCOMS)
(RPAQQ LAMBDATRANCOMS ((* Translation machinery for new LAMBDA words) (LOCALVARS . T) (DECLARE: FIRST 
(P (VIRGINFN (QUOTE ARGLIST) T) (MOVD? (QUOTE ARGLIST) (QUOTE OLDARGLIST)) (VIRGINFN (QUOTE NARGS) T) 
(MOVD? (QUOTE NARGS) (QUOTE OLDNARGS)) (VIRGINFN (QUOTE ARGTYPE) T) (MOVD? (QUOTE ARGTYPE) (QUOTE 
OLDARGTYPE)))) (FNS ARGLIST ARGTYPE FNTYP1 LTDWIMUSERFN LTSTKNAME NARGS) (ADDVARS (DWIMUSERFORMS (
LTDWIMUSERFN))) (PROP VARTYPE LAMBDATRANFNS) (ALISTS (LAMBDATRANFNS)) (PROP MACRO LTSTKNAME) (P (
PUTHASH (QUOTE LTSTKNAME) (QUOTE (NIL)) MSTEMPLATES)) (P (RELINK (QUOTE WORLD))) (DECLARE: 
EVAL@COMPILE DONTCOPY (P (RESETSAVE DWIMIFYCOMPFLG T)) (GLOBALVARS CLISPARRAY COMMENTFLG LAMBDASPLST 
LAMBDATRANFNS BOUNDPDUMMY)) (DECLARE: DOCOPY (DECLARE: EVAL@LOADWHEN (NEQ (EVALV (QUOTE LDFLG)) (QUOTE
 SYSLOAD)) (RECORDS LAMBDAWORD))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (
ADDVARS (NLAMA) (NLAML LTSTKNAME) (LAMA)))))
(ADDTOVAR DWIMUSERFORMS (LTDWIMUSERFN))
(PUTPROPS LAMBDATRANFNS VARTYPE ALIST)
(ADDTOVAR LAMBDATRANFNS)
(PUTPROPS LTSTKNAME MACRO (X (CONS COMMENTFLG X)))
(PUTHASH (QUOTE LTSTKNAME) (QUOTE (NIL)) MSTEMPLATES)
(RELINK (QUOTE WORLD))
(DECLARE: EVAL@LOADWHEN (NEQ (EVALV (QUOTE LDFLG)) (QUOTE SYSLOAD)) (DECLARE: EVAL@COMPILE (RECORD 
LAMBDAWORD (TRANFN FNTYP ARGLIST))))
NIL
