(FILECREATED "23-SEP-81 22:55:53" ("compiled on " 
<LISPUSERS>LOADTIMECONSTANT.;6) (2 . 2) bcompl'd in WORK dated NOBIND)
(FILECREATED " 2-NOV-79 10:40:54" <LISPUSERS>LOADTIMECONSTANT.;6 3030 
changes to: LOADTIMECONSTANTCOMS (LOADTIMECONSTANT MAXCMACRO) LTCDEFC 
LTCMAC previous date: "11-MAY-79 10:55:47" 
<LISPUSERS>LOADTIMECONSTANT.;5)

LTCDEFC BINARY
     °    )    /-.           )Z  *,<  Z   B  Š,<  @  + @+   &Z   ,<  Z  B  -,   /"     ,\   D  Z  ,<     
."     ,\   D     ,>  Ļ,>         ,^  /  3"  +   +   %Z  ,<     ,<  ,   XB   -,   Z   Z  2B  ­+   Z  ,<     ,<  [  B  .,   Z  ,<     ,<  ,   XB  -,   Z   Z  2B  ­+   ĪZ  ,<     ,<  [  B  .,   +   
Z` ,~   Z   ,<  Z  !D  Ū,~     (@ Ā@ ā @   (VARIABLE-VALUE-CELL NM . 76)
(VARIABLE-VALUE-CELL DF . 78)
100000
LASTLIT+1
(VARIABLE-VALUE-CELL J . 68)
(VARIABLE-VALUE-CELL END . 30)
NIL
(NIL VARIABLE-VALUE-CELL L . 70)
FIRSTLIT
LoadTimeConstant
EVAL
DEFC
(FFNCLD FFNOPD FFNCLA KNIL SKLST FFNOPA BHC IUNBOX ENTERF) P   h   @          h   X            

LTCMAC BINARY
             -.          Z   Z   ,   2B   +   Z  XB  -,   +   Z  B  Z  ,   3B   +   Z  ,<  [  	,<  ,<   Zwĸ-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ZwĸB  Zp  ,   XBp  [wĸXBwĸ+   /  ,   ,~   Z  
,~   EHĻ @   (VARIABLE-VALUE-CELL FORM . 47)
(VARIABLE-VALUE-CELL CLISPARRAY . 4)
ARGTYPE
((0 2) . 0)
LTCMAC
(CONSS1 BHC COLLCT SKNLST FMEMB SKLST KNIL GETHSH ENTERF)   x   p   H   P       `   p  @ 	  @    8      
(PRETTYCOMPRINT LOADTIMECONSTANTCOMS)
(RPAQQ LOADTIMECONSTANTCOMS ((FNS LTCDEFC LTCMAC) (MACROS CONSTANT 
LOADTIMECONSTANT) (P (CHANGENAME (QUOTE LAPBLOCK) (QUOTE DEFC) (QUOTE 
LTCDEFC)) (CHANGENAME (QUOTE BINRD) (QUOTE DEFC) (QUOTE LTCDEFC)) (MOVD?
 (QUOTE CONSTANT) (QUOTE LOADTIMECONSTANT))) (PROP MAXCMACRO 
LOADTIMECONSTANT)))
(PUTPROPS CONSTANT MACRO (MACROX (PROG ((VAL (APPLY (QUOTE PROG1) MACROX
))) (RETURN (COND ((CONSTANTOK VAL) (KWOTE VAL)) (T (CONS (QUOTE 
LOADTIMECONSTANT) MACROX)))))))
(PUTPROPS LOADTIMECONSTANT MACRO (ARGS (KWOTE (CONS (QUOTE 
LoadTimeConstant) (LTCMAC (CAR ARGS))))))
(CHANGENAME (QUOTE LAPBLOCK) (QUOTE DEFC) (QUOTE LTCDEFC))
(CHANGENAME (QUOTE BINRD) (QUOTE DEFC) (QUOTE LTCDEFC))
(MOVD? (QUOTE CONSTANT) (QUOTE LOADTIMECONSTANT))
(PUTPROPS LOADTIMECONSTANT MAXCMACRO (X (KWOTE (CONS LOADTIMECONSTANT (
LTCMAC (CAR X))))))
NIL
