(FILECREATED "10-SEP-83 15:29:15" ("compiled on " <NEWLISP>MACROAUX.;1) (2 . 2) bcompl'd in WORK dated
 "19-JUN-83 15:13:55")
(FILECREATED "12-JUN-83 01:26:40" {PHYLUM}<LISPCORE>SOURCES>MACROAUX.;4 20180 changes to: (VARS 
MACROAUXCOMS) previous date: " 3-JUN-83 23:11:33" {PHYLUM}<LISPCORE>SOURCES>MACROAUX.;3)

ARGS.COMMUTABLEP.LIST BINARY
              -.           Z   ,<  Zp  -,   +   Z   +    Zp  ,<  ,<w˙/  @     +   Z   ,<  Z   D  ,~   2B   +   Z   +    [p  XBp  +   @Q@(VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL Y . 19)
(VARIABLE-VALUE-CELL X . 17)
ARGS.COMMUTABLEP
(KNIL BHC URET1 KT SKNLST ENTERF) P           X    P    @      

EVALUABLE.CONSTANT.FIXP BINARY
                -.           Z   B  Z  -,   Z   ,~       (VARIABLE-VALUE-CELL X . 3)
EVALUABLE.CONSTANTP
(KNIL SKI ENTERF)             

LISPFORM.SIMPLIFY BINARY
      ˝    ł    ť-.          łZ   -,   +   3B  6+   7   Z   XB  @  ś  ,~   Z   -,   +   Z  XB   -,   +   ,<  Z   D  ˇXB  	3B   +   Z  ,<  ,<  Z  D  8XB  ,\  3B  +   +   Z  B  ¸XB  3B   +   Z  3B   +   3B   +   -,   +   ,<  9,<  ,   XB  +   ŹZ  -,   +   ŹZ  3B   +   ŹZ  Z   ,   XB  2B   +   +Z  ,<  ,<   Z  -,   Z   F  šZ  !Z  ,   XB  ,<  Z  ¤,<  ,<   Z  %F  :,\  3B   +   ŹZ  &XB  '+   Z   2B   +   ąZ  Ť,<  ,<   ,<   &  ş   ;+   ˛Z  .,~   Z   ,~   DR+	 @	      (VARIABLE-VALUE-CELL X . 99)
(VARIABLE-VALUE-CELL QUIETFLG . 89)
(VARIABLE-VALUE-CELL DWIMIFYFLGORLST . 69)
(VARIABLE-VALUE-CELL COMPILERMACROPROPS . 22)
(VARIABLE-VALUE-CELL CLISPARRAY . 81)
DONT
(NIL VARIABLE-VALUE-CELL Y . 86)
(T VARIABLE-VALUE-CELL CLISPIFTRANFLG . 0)
GETMACROPROP
MACROEXPANSION
CONSTANTEXPRESSIONP
QUOTE
DWIMIFY
PUTHASH
PRINTDEF
TERPRI
(GETHSH LIST2 SKNNM SKLA SKLST KNIL KT SKNLST ENTERF)   h                  $ H     ł   . 0 ) H ! `  P   X    # x            

NO.SIDEEFFECTS.FNP BINARY
     ľ    Ź    4-.          ŹZ   3B   +   Ť-,   +   ŤB  .,<  Z  B  Ž,<  @  / @ +   +    0b  +   Z   ,<  Z"  Ą,\  2B  +   Z  ,<  Z  D  0,<  Z"  ),\  2B  +   Z  B  °2B   +   Ş   1"  +   )Z  ,<  Z"  .,\  2B  +   )Z  ,<  ,<  1$  0,<  Z"  ˘,\  2B  +   ),<   Z   2B   +   ,<  ą"  2,<  Z   XB  ,\  XBp  Z  ,<  ,<  ˛,<  1,<wţ(  3Z  ł,   ,<  Zw˙XB   ,\  /  2B   +   ŞZ  ĄZ   ,   ,~   ,~   Z   ,~   e$Â$	B`   (VARIABLE-VALUE-CELL X . 82)
(VARIABLE-VALUE-CELL \NSE.STRPTR . 77)
(VARIABLE-VALUE-CELL NO.SIDEEFFECTS.HARRAY . 83)
NCHARS
CHCON1
(VARIABLE-VALUE-CELL N . 38)
(VARIABLE-VALUE-CELL C1 . 41)
NTHCHARCODE
CARCDR.FNP
8
0
ALLOCSTRING
1
SUBSTRING
"\GETBASE"
(GETHSH BHC EQUAL ASZ SKLA KNIL ENTERF)   +    ¨    &     h  8    @   H )   P   0      

CARCDR.FNP BINARY
              -.           Z   ,<  ,<  $  ,~       (VARIABLE-VALUE-CELL X . 3)
CROPS
GETPROP
(ENTERF)      

CODE.SUBST BINARY
              -.           Z   ,<  Z   ,<  Z   F  ,~       (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL Y . 5)
(VARIABLE-VALUE-CELL FORM . 7)
SUBST
(ENTERF)    

CODE.SUBPAIR BINARY
            -.           Z   ,<  Z   ,<  Z   F  ,~       (VARIABLE-VALUE-CELL L1 . 3)
(VARIABLE-VALUE-CELL L2 . 5)
(VARIABLE-VALUE-CELL FORM . 7)
SUBPAIR
(ENTERF)     

ARGS.COMMUTABLEP BINARY
     B    ¸    @-.           ¸@  š  ,~   Z   -,   +   Z   -,   +   Z   ,~   Z  ,<  XB  ,\  XB  Z  	-,   +   Z  ,<  ,<  :$  ş3B   +   +   3B   +   -,   +   +   Z  ,<  ,<   $  ;XB  Z  XB   -,   +   Z  2B  ť7   7   +   8Z  ,<  Z  ,<  ,<   $  ;D  <,~   ,<  ,<  ź$  ş3B   +   Z   ,~   Z  2B  =+   *Z  ,<  [  Z  D  ˝3B   +   )[  "[  ,<  Z  !,<  ,<   $  ;D  <,~   Z   ,~   ,<  ,<  >$  ş3B   +   ąZ  ž,<  Z  ¤,<  Z  &,<  ,<   $  ;F  ?,~   Z  B  ż3B   +   ˇ[  ­,<  Z  Ž,<  ,<   $  ;D  <,~   Z   ,~   $ MV!$ha@aXP`    (VARIABLE-VALUE-CELL X . 105)
(VARIABLE-VALUE-CELL Y . 103)
(NIL VARIABLE-VALUE-CELL FN . 99)
((QUOTE FUNCTION DECLARE CONSTANT DEFERREDCONSTANT) . 0)
MEMB
LISPFORM.SIMPLIFY
LAMBDA
ARGS.COMMUTABLEP.LIST
((QUOTE FUNCTION DECLARE CONSTANT DEFERREDCONSTANT) . 0)
SETQ
\VARNOTUSED
((COND SELECTQ SELECTC AND OR SETQ FRPTQ APPLY APPLY* MAP MAPLIST MAPC MAPCAR MAPCON MAPCONC MAPHASH 
MAPATOMS EVERY SOME NOTEVERY NOTANY) . 0)
ARGS.COMMUTABLEP
\WALKOVER.SPECIALFORMS
NO.SIDEEFFECTS.FNP
(SKNLA KNIL SKLST KT SKNLST ENTERF)       ¸ 8 Ź   ¤ h  x      0   h °    0  0       H      

ARGS.COMMUTABLEP.LIST BINARY
             -.           Z   ,<  Zp  -,   +   Z   +    Zp  ,<  ,<w˙/  @     +   Z   ,<  Z   D  ,~   2B   +   Z   +    [p  XBp  +   @Q@(VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL Y . 19)
(VARIABLE-VALUE-CELL X . 17)
ARGS.COMMUTABLEP
(KNIL BHC URET1 KT SKNLST ENTERF) P           X    P    @      

VAR.NOT.USED BINARY
            -.           Z   -,   +   ,<  D     XB  +   ,<  ,<  $  3B   +   ,<  Z  D     XB  +   Z   ,<  Z  
,<  Z   F  ,~   k6A      (VARIABLE-VALUE-CELL FORM . 22)
(VARIABLE-VALUE-CELL VAR . 24)
(VARIABLE-VALUE-CELL SETQONLY? . 26)
14
SETERRORN
ERRORX
((NIL T) . 0)
MEMB
27
\VARNOTUSED
(KNIL SKNLA ENTERF)        0      

\VARNOTUSED BINARY
     ˇ    0    6-.           0Z   -,   +   	Z   2B   +   Z   Z  3B  +   7   Z   ,~   Z   ,~   Z  -,   +   Z  	,<  Z  ,<  Z  F  ą,~   Z  2B  2+   Z  ,<  [  Z  D  ˛2B   +   Ż[  [  XB  +   Z  ,<  ,<  3$  ˛3B   +   Z   ,~   Z  ,<  ,<  ł$  ˛3B   +   #Z  [  Z  3B  +   "Z  ,<  Z  ,<  Z  F  ą,~   Z   ,~   Z  ,<  ,<  4$  ˛3B   +   ŞZ  ´,<  Z  #,<  Z  ,<  Z   H  5,~   Z  'B  ľ3B   +   Ż[  Ş,<  Z  (,<  Z  )F  ą,~   "°"4lP  (VARIABLE-VALUE-CELL FORM . 89)
(VARIABLE-VALUE-CELL VAR . 91)
(VARIABLE-VALUE-CELL SETQONLY? . 93)
\VARNOTUSED.LIST
LAMBDA
MEMB
((QUOTE FUNCTION DECLARE CONSTANT DEFERREDCONSTANT) . 0)
((SETQ) . 0)
((COND SELECTQ SELECTC AND OR SETQ FRPTQ APPLY APPLY* MAP MAPLIST MAPC MAPCAR MAPCON MAPCONC MAPHASH 
MAPATOMS EVERY SOME NOTEVERY NOTANY) . 0)
\VARNOTUSED
\WALKOVER.SPECIALFORMS
NO.SIDEEFFECTS.FNP
(SKLST KT KNIL SKNLST ENTERF)  (        Ź ` # @  0 	              

\VARNOTUSED.LIST BINARY
               -.           Z   ,<  Zp  -,   +   Z   +    Zp  ,<  ,<w˙/  @     +   Z   ,<  Z   ,<  Z   F  ,~   2B   +   Z   +    [p  XBp  +   @P$(VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL X . 19)
(VARIABLE-VALUE-CELL SETQONLY? . 21)
(VARIABLE-VALUE-CELL FORM . 17)
\VARNOTUSED
(KNIL BHC URET1 KT SKNLST ENTERF)    P    x   h                

EVALUABLE.CONSTANTP BINARY
    ô    c    q-.          cZ   -,   +   Z  3B  d+   Z  3B  ä+   Z  Z   ,   3B   +   
Z  B  e,~   Z  -,   +   ,<  ,<   $  ĺXB  
-,   +   B  e,~   Z  ,<  Zp  3B   +   -,   7   Z   +   Z   /  3B   +   ˝Z  ,<  ,<  f$  ć3B   +   Z  g,<  Z  D  ç3B   +   âZ  B  h,   ,~   Z  Z  č,   2B   +   #Z  B  i3B   +   â+   $Z   ,~   [   ,<  @  é   
+   śZ` -,   +   ¨+   ľZ  XB   B  g2B   +   ,Z   ,~   Z  XB` Z` 3B   +   2,<  Z` ,   XB` ,\  QB  +   4Z` ,   XB` XB` [` XB` +   ŚZ` ,~   ,<  @  l   +   =Z   3B   +   źZ  $,<  Z  ¸D  ě,   ,~   ,~   Z  :-,   +   ÂZ  ˝Z  2B  m7   7   +   â+   ĂZ   ,~   Z  ?[  Z  -,   +   K[  Ă,<  Z  F[  [  D  íZ  n,   XB  G+   [  J,<  @  î  ,~   Z` -,   +   Ď+   ŰZ  XB  )Z  PB  g2B   +   ÓZ   ,~   Z  3B   +   Ř3B   +   Ř-,   +   Ř,<  d,<  ,   Z  ;,   XB  Ř[` XB` +   ÍZ  K[  Z  ,<  Z  Ů,<  Z  nZ  Ű[  [  ,   F  đB  g,~   ,~   l$ŕMJDVeD	2!E0`       (VARIABLE-VALUE-CELL X . 190)
(VARIABLE-VALUE-CELL CONSTANTFOLDFNS . 13)
QUOTE
CONSTANT
CONSTANTEXPRESSIONP
LISPFORM.SIMPLIFY
((COND SELECTQ SELECTC AND OR SETQ FRPTQ APPLY APPLY* MAP MAPLIST MAPC MAPCAR MAPCON MAPCONC MAPHASH 
MAPATOMS EVERY SOME NOTEVERY NOTANY) . 0)
MEMB
EVALUABLE.CONSTANTP
\WALKOVER.SPECIALFORMS
EVAL
((CONS LIST CREATECELL \ALLOCKBLOCK ARRAY MKSTRING MKATOM ALLOCSTRING SYSTEMTYPE MACHINETYPE GETD) . 0
)
NO.SIDEEFFECTS.FNP
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL Z . 161)
(VARIABLE-VALUE-CELL VALS . 187)
APPLY
LAMBDA
APPEND
PROGN
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL Z . 0)
(NIL VARIABLE-VALUE-CELL VALS . 0)
CODE.SUBPAIR
(CONS LIST2 SKNNM CONS21 CONSNL BHC SKLA SKNLST KT KNIL FMEMB SKLST ENTERF)  á        
p   	(   P ł              O ` ( h   
` B @     U 
8 Ň 8 Á   Ž @ + @ ˘     P              p   0      

EVALUABLE.CONSTANT.FIXP BINARY
                -.           Z   B  Z  -,   Z   ,~       (VARIABLE-VALUE-CELL X . 3)
EVALUABLE.CONSTANTP
(KNIL SKI ENTERF)             

\WALKOVER.SPECIALFORMS BINARY
     Ć   /   A-.     (     /Z   -,   Z   Z  2B ą+   [  ,<  Zp  -,   +   Z   +    Zp  ,<  ,<w˙/  @ 2   +   Z   -,   +   Z   ,~   Z   ,<  ,<  Z   ,<  Z   ,<  Z   J ˛,~   2B   +   Z   +    [p  XBp  +   3B 3+   2B ł+   ;Z  ,<  [  Z  ,<  Z  ,<  Z  ,<  Z  ,<   "  ,   3B   +   :Z  ,<  Z  B 4Z  ,<  Z  ,<  Z  ,<  Z  ,<   "  ,   3B   +   :[  ![  ,<  @ ´  +   šZ` XB   Z  Ť-,   +   ¸[  ,2B   +   Ż+   ¸Z   ,<  Z  ­[  ,<  Z  #,<  Z  $,<  Z  %J ˛2B   +   7Z   ,~   [  °XB  7+   ,Z   ,~   ,~   Z   ,~   3B 6+   ?3B ś+   ?3B 7+   ?2B ˇ+   ÄZ  Ż,<  [  (,<  Z  2,<  Z  3,<  Z  4J ˛,~   3B 8+   Ć2B ¸+   TZ  ?,<  [  @Z  ,<  Z  A,<  Z  B,<  Z  CJ 93B   +   SZ  Ć,<  [  Ç[  ,<  Z  I,<  Z  J,<  Z  KJ ˛,~   Z   ,~   3B š+   _3B :+   _3B ş+   _3B ;+   _3B ť+   _3B <+   _3B ź+   _3B =+   _3B ˝+   _3B >+   _2B ž+   yZ  M,<  [  NZ  ,<  Z  Ď,<  Z  Đ,<  Z  Ń,<   "  ,   3B   +   x[  `[  XB  ćZ  3B   +   xZ  _,<  Z  ç,<  Z  á,<  Z  â,<  Z  ăJ 93B   +   x[  ę-,   +   rZ   ,~   Z  é,<  [  ďZ  ,<  Z  ë,<  Z  ě,<  Z  íJ 9,~   Z   ,~   2B ?+   Z  r,<  [  sZ  ,<  Z  ô,<  Z  ő,<  Z  öJ 9,~   2B ż+  .[  {Z  ,<  Zp  -,   +  Z   +  Zp  ,<  ,<w˙/  @ @   +  Z   -,   +  Z   ,~   [ -,   +  Z   ,~   Z  z,<  [ Z  ,<  Z  ü,<  Z  ý,<  Z  ţ,<   "  ,   ,~   2B   +  Z   +  [p  XBp  +  /  3B   +  -[ [  ,<  Zp  -,   +  Z   +    Zp  ,<  ,<w˙/  @ @   +  ŠZ -,   +  ŁZ   ,~   Z ,<  ,<  Z ,<  Z ,<  Z ,<   "  ,   ,~   2B   +  ŤZ   +    [p  XBp  +  Z   ,~     Ŕ,~   a$ H>  E`x< P˙p  # @ 
$
@ H      (VARIABLE-VALUE-CELL PRED . 327)
(VARIABLE-VALUE-CELL FORM . 307)
(VARIABLE-VALUE-CELL REST1 . 330)
(VARIABLE-VALUE-CELL REST2 . 332)
(VARIABLE-VALUE-CELL REST3 . 334)
COND
(VARIABLE-VALUE-CELL CLZ . 23)
\WALKOVER.SF.LIST
SELECTQ
SELECTC
LAST
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL LL . 111)
AND
OR
FRPTQ
SETQ
APPLY
APPLY*
\WALKOVER.FUNCTION
MAP
MAPLIST
MAPC
MAPCAR
MAPCON
MAPCONC
MAPHASH
EVERY
SOME
NOTEVERY
NOTANY
MAPATOMS
PROG
(VARIABLE-VALUE-CELL L . 322)
SHOULDNT
(EVCC BHC URET1 KT SKNLST KNIL SKLST ENTERF) Š H f x       (   @ X    Ł X 0   š `    ˘ H      p   `Ť ( h  ď  ć 
@ M 0 7 ` /     P   8   X        

\WALKOVER.SF.LIST BINARY
              -.     (      Z   ,<  Zp  -,   +   Z   +    Zp  ,<  ,<w˙/  @     +   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   ,<   "  ,   ,~   2B   +   Z   +    [p  XBp  +   @P @    (VARIABLE-VALUE-CELL PRED . 17)
(VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL REST1 . 21)
(VARIABLE-VALUE-CELL REST2 . 23)
(VARIABLE-VALUE-CELL REST3 . 25)
(VARIABLE-VALUE-CELL X . 19)
(KNIL EVCC BHC URET1 KT SKNLST ENTERF)       p    x                   

\WALKOVER.FUNCTION BINARY
     ˘        Ą-.     (      Z   -,   +   Z  ,<  ,<   $   2B   +   Z   ,<  Z  ,<  Z   ,<  Z   ,<  Z   ,<   "  ,   3B   +   Z  ,<  ,<  !Z  ,<  Z  	,<  Z  
,<   "  ,   ,~   Z   ,~   Z  ,<  [  Z  XB  -,   +   ,   +   ,<  Z  ,<  Z  ,<  Z  ,<   "  ,   ,~   4 @ 
   (VARIABLE-VALUE-CELL PRED . 40)
(VARIABLE-VALUE-CELL FN . 44)
(VARIABLE-VALUE-CELL REST1 . 50)
(VARIABLE-VALUE-CELL REST2 . 52)
(VARIABLE-VALUE-CELL REST3 . 54)
((QUOTE FUNCTION) . 0)
MEMB
((\TypicalUnknownFunction) . 0)
(CONSNL SKNLST EVCC KNIL SKLST ENTERF)           0      P            
(PRETTYCOMPRINT MACROAUXCOMS)
(RPAQQ MACROAUXCOMS ((EXPORT (DECLARE: DONTCOPY (MACROS NNLITATOM \NULL.OR.FIXP \CHECKTYPE 
CANONICAL.TIMERUNITS)) (COMS (* Macros which do, respectively, macro-expansion and evaluation of their
 "argument") (DECLARE: DONTCOPY (FNS \MACRO...ppmacro) (MACROS \MACRO.MX \MACRO.EVAL) (ADDVARS (
PRETTYPRINTMACROS (\MACRO.MX . \MACRO...ppmacro) (\MACRO.EVAL . \MACRO...ppmacro)))))) (COMS (* 
functions which help macro and compiler writers.) (FNS ARGS.COMMUTABLEP.LIST EVALUABLE.CONSTANT.FIXP 
LISPFORM.SIMPLIFY NO.SIDEEFFECTS.FNP CARCDR.FNP CODE.SUBST CODE.SUBPAIR) (GLOBALRESOURCES \NSE.STRPTR)
 (FNS ARGS.COMMUTABLEP ARGS.COMMUTABLEP.LIST VAR.NOT.USED \VARNOTUSED \VARNOTUSED.LIST 
EVALUABLE.CONSTANTP EVALUABLE.CONSTANT.FIXP) (MACROS EVALUABLE.CONSTANT.FIXP) (FNS 
\WALKOVER.SPECIALFORMS \WALKOVER.SF.LIST \WALKOVER.FUNCTION) (DECLARE: DONTCOPY (CONSTANTS 
\QUOTIFYING.NLS \WALKABLE.SPECIALFORMS) (MACROS \WALKABLE.SPECIALFORMP)) (ADDVARS (CONSTANTFOLDFNS 
IMIN IMAX IABS LOGOR LOGXOR LOGAND)) (UGLYVARS NO.SIDEEFFECTS.HARRAY) (PROP GLOBALVAR 
NO.SIDEEFFECTS.HARRAY) (GLOBALVARS CLISPARRAY CONSTANTFOLDFNS))))
(RPAQQ \NSE.STRPTR NIL)
(PUTPROPS EVALUABLE.CONSTANT.FIXP MACRO ((X) (FIXP (CAR (EVALUABLE.CONSTANTP X)))))
(ADDTOVAR CONSTANTFOLDFNS IMIN IMAX IABS LOGOR LOGXOR LOGAND)
(READVARS NO.SIDEEFFECTS.HARRAY)
(({H2047 244 T COPYTERMTABLE T FFETCHFIELD T EXPANDMACRO T NEQ T SUBPAIR T \GETBITS T 
COMPILEDFETCHFIELD T FRAMESCAN T VALUEOF T GETDEF T NEGATE T READTABLEP T CONSCOUNT T BOXCOUNT T 
FETCHFIELD T COPY T TYPENAMEFROMNUMBER T ARRAYBEG T COPYSTK T ARCTAN T ARCCOS T ARCSIN T ARCTAN2 T LOG
 T TAN T COS T SIN T GETTYPEDESCRIPTION T TYPENUMBERFROMNAME T DATEFORMAT T NTYP T SCODEP T 
COPYDEFCOPYREADTABLE T COVERS T GETQ T NCHAR T SUBTYPES T SUPERTYPES T STRINGWIDTH T \ALLOCKBLOCK T 
HARRAYSIZE T HARRAY T ELTD T COPYARRAY T HARRAYP T ARRAYTYP T ARRAYSIZE T BIT T U-CASEP T L-CASE T 
STREQUAL T CONCAT T EQUALALL T READP T ALLOCSTRING T PEEKC T LOWERCASE T EXPT T SQRT T IDATE T FNTH T 
FTIMES T FLOAT T FPLUS T FMINUS T LESSP T FREMAINDER T REMAINDER T ABS T IEQP T MINUS T GCD T ADD1 T 
SUB1 T LOGXOR T LOGOR T ITIMES T IPLUS T IMINUS T ILESSP T MINUSP T RSH T LSH T LRSH T EQP T IQUOTIENT
 T IGREATERP T IDIFFERENCE T ASSOC T NTH T GETATOMVAL T NARGS T ARGTYPE T FNTYP T SUBRP T CCODEP T 
VARS T EXPRP T REALSTKNTH T REALFRAMEP T MAX T LEQ T IMIN T IMAX T ILEQ T IGEQ T FMIN T FMAX T FLESSP 
T PROG1 T PROG2 T BOUNDP T TYPENAME T MKLIST T FREEVARS T EQMEMB T ARG T PAGEFAULTS T DISMISS T DATE T
 CLOCK T COUNTDOWN T NCHARS T GETD T SUBLIS T NUMBERP T ATOM T NLISTP T EQUALN T COPYALL T PROGN T 
MKATOM T MEMB T SUBSTRING T MKSTRING T PACK* T EQUAL T MINFS T CHCON1 T SUBATOM T FULLNAME T INFILEP T
 FCHARACTER T CHARACTER T STRPOS T PACKFILENAME T U-CASE T FASSOC T APPEND T NOT T LOGAND T ZEROP T 
GETPROPLIST T VAG T LOC T EQ T LENGTH T GETTOPVAL T FIELDLOOK T GETTEMPLATE T RECLOOK T HASDEF T 
PROPNAMES T LLSH T ARRAY T TYPESOF T EQLENGTH T UNION T SUBSET T REMOVE T RPT T LISTPUT1 T LISTPUT T 
LISTGET1 T LISTGET T LDIFFERENCE T LDIFF T LASTN T KWOTE T MEMBER T INTERSECTION T GETLIS T GENSYM T 
LSUBST T SUBST T FIX T COUNT T LIST T FGETD T LAST T NULL T TYPENAMEP T FLTFMT T LINELENGTH T SASSOC T
 GREATERP T FGREATERP T FQUOTIENT T FDIFFERENCE T IREMAINDER T QUOTIENT T TIMES T DIFFERENCE T PLUS T 
\VAG2 T UNPACKFILENAME T NILL T FONTNAME T NTHCHARCODE T ELT T CONS T GETHASH T FMEMB T GETPROP T 
OPENP T STACKP T STRINGP T ARRAYP T LISTP T LITATOM T FLOATP T FIXP T SMALLP T TYPEP T MIN T GDATE T 
OPENR T MAKEBITTABLE T STRPOSL T PACK T PACKC T ALPHORDER T FLAST T UNPACK T CHCON T TAILP T NLEFT T 
FLENGTH T SYNTAXP T GETSEPR T GETREADTABLE T GETSYNTAX T VARIABLES T GETTERMTABLE }))
(PUTPROPS NO.SIDEEFFECTS.HARRAY GLOBALVAR T)
(PUTPROPS MACROAUX COPYRIGHT ("Xerox Corporation" 1983))
NIL
    