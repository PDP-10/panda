(FILECREATED "26-SEP-83 04:53:31" ("compiled on " <LISPUSERS>CMLSPECIALFORMS.;4) (2 . 2) bcompl'd in 
WORK dated "19-JUN-83 15:13:55")
(FILECREATED "26-SEP-83 04:43:42" {PHYLUM}<LISPUSERS>CMLSPECIALFORMS.;4 15366 changes to: (MACROS 
CATCH PROGV *CATCH *THROW UNWINDPROTECT) (FNS DEFUN CATCH \THROW.AUX \CATCH.FINDFRAME) (VARS 
CMLSPECIALFORMSCOMS) previous date: "25-SEP-83 23:41:30" {PHYLUM}<LISPUSERS>CMLSPECIALFORMS.;1)

\LETtran BINARY
      p    b    l-.          bZ   ,<   ,<   Zw-,   +   	Zp  Z   2B   +    "  +   	[  QD   "  +   Zw,<   @  b   +   Z  -,   +   Z  XB  3B   +   3B   +   Z   ,~   Z   ,<  dZ  ,<   ,   B  d,~   Zp  ,   XBp  [wXBw+   /  ,<   Z  ,<   ,<   Zw-,   +   !Zp  Z   2B   +    "  +    [  QD   "  +   *Zw,<   @  b   +   'Z  -,   +   &[  #Z  ,~   Z   ,~   Zp  ,   XBp  [wXBw+   /  ,<   [  %,<   @  e `
,~   Z   2B   +   5Z   ,<  Z   ,   Z  g,   ,<   Z   ,<   ,   +   a@  h  +   FZ  0XB   -,   +   <Z   Z  73B  +   =Z  93B  i+   =Z`  ,~   Z  6,<   [  =XB  >,\   Z  :2B  i+   CZ   Z  ?,   XB  A+   EZ   Z  B,   XB  D+   6[  3B  i,<   [  /B  i,<   @  j @
+   XZ` XB   Z`  XB   Z  L-,   +   OZ  K-,   +   PZ` ,~   ,   ,<   Z  >,   Z  g,   ,<   Z  L,<   ,   XB  Q[  NXB  V[  TXB  W+   LZ  G,   ,<   Z  CB  i,<   Z  AB  i,<   Z  U,   ,   ,   Z  g,   ,<   Z  F,   Z   ,~   "DRD% !D,B
T@@$        (VARIABLE-VALUE-CELL X . 87)
(VARIABLE-VALUE-CELL SEQUENTIALP . 92)
(VARIABLE-VALUE-CELL COMMENTFLG . 113)
14
ERRORX
(VARIABLE-VALUE-CELL VARS . 177)
(VARIABLE-VALUE-CELL VALS . 193)
(VARIABLE-VALUE-CELL BODY . 186)
(NIL VARIABLE-VALUE-CELL DECLS . 183)
(NIL VARIABLE-VALUE-CELL COMNTS . 180)
LAMBDA
NIL
(NIL VARIABLE-VALUE-CELL FIRSTFORM . 138)
DECLARE
DREVERSE
(0 . 1)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL VAR . 173)
(NIL VARIABLE-VALUE-CELL VAL . 175)
(ALIST2 CONSNL CONS CONS21 CONSS1 BHC COLLCT LIST2 KT SKLST SKNLST KNIL ENTERF)        Q    E 0    T 0   x _ h S     8     ) h   
` 5 H        N  % X   	x   H   ( / x  X  (   h   8      

\LetPPMacro BINARY
     ^    O    [-.          O[   -,   +   	[  [  -,   +   	[  Z  -,   +   
[  Z  3B   +   
Z  ,~      Q,<   @  Q  ,~   ,<  S,<   $  SZ   ,<   ,<   $  TZ  	,<   [  XB  ,\   ,<   ,<   $  SZ   ,<   ,<   $  T,<  T,<   $  S   QXB   Z  ,<   [  XB  ,\   ,<   Zp  -,   +   +   @Zp  ,<   @  U   +   ?Z   -,   +   1Z  ,<  ,<  U$  V,<  V,<   $  SZ   ,<   ,<   $  W,<  W,<   ,<   &  V[  %Z  ,<   ,<   "  Q,<   ,<   ,<   ,<   ,<   ,  X,<  X,<   $  SZ   XB   ,~   Z  03B   +   :,<  Y"  Y3B   +   :,<  Y"  SZ  )B  Y2B   +   <Z  !,<   ,<  U$  V+   <Z  8,<   ,<  U$  VZ  6B  WZ   XB  1,~   [p  XBp  +   /   ,<  Z"  S   Z^"  ,>  O,>      :.Bx  ,^   /   ,   ,<   ,<  U$  VZ  ,<   ,<   "  Q,<   ,<   ,<   ,<   ,<   ,  X,<  ["  SZ   ,~      	%l e#AP;)fA:        (VARIABLE-VALUE-CELL FORM . 144)
(VARIABLE-VALUE-CELL CLISPFONT . 28)
(VARIABLE-VALUE-CELL DEFAULTFONT . 40)
POSITION
(VARIABLE-VALUE-CELL POS . 0)
(NIL VARIABLE-VALUE-CELL VPOS . 136)
(NIL VARIABLE-VALUE-CELL LASTWASATOM . 124)
"("
PRIN1
CHANGEFONT
" ("
(VARIABLE-VALUE-CELL X . 121)
0
TAB
"("
PRIN2
1
PRINTDEF
")"
% 
FITP
")"
TERPRI
")"
(MKN BHC KT KNIL SKNLST SKLST ENTERF) p   h A    L 	8 > P   	p M 	H J   5 0 1   . ` - 8 )  ' P  `        P     !  P        

DEFUN BINARY
        ~    g    z-.         g@  h   ,~   Z   -,   +   +   dZ  XB   3B   +   	-,   +   	2B   +   ,<  j,<   ,   B  k[  -,   +   +   dZ  XB   [  [  XB   Z  3B  k+   2B  l+   XB   Z  XB  Z  -,   +   +   d[  XB  +   2B  l+   ,<  m"  mZ  -,   +   2B   +   +-,   +   ),<   @  n  +   (Z`  -,   +   !Z   ,~   Z   ,<  Z`  ,<   ,<`   "  ,   2B   +   &Z   ,~   [`  XB`  +   2B   +   +Z  ,<   ,<  o$  oZ  2B  l+   2Z  )-,   +   /[  ,3B   +   1Z  .,<   ,<  o$  oZ  /XB  1Z  ,<   @  p  +   XZ`  XB   Z  5-,   +   ?[  6-,   +   ?Z  7-,   +   @Z   Z  9Z  3B  +   @Z  ;Z  3B  q+   @Z` ,~   Z  =-,   +   B+   W,<  rZ  @,<   ,<  r&  s,<   @  s   +   W,<  t,<   ,<   @  t ` +   PZ   Z  vXB Z   B  v,<   Z  K,<   ,<   Z   F  w,\   +    XB  L-,   Z   Z  XB  P-,   +   VZ  B,<  Z  :Z  R,   D  w,~   [  SXB  W+   6Z  ,<   Z  +2B  k+   \Z  x+   ^2B  l+   ^Z  x+   ^   y,<   Z  2,<   Z  2,   ,   ,   ,   B  yZ  X,~   Z  ,<   ,<  z$  oZ   ,~   1,L) S2&
!9VTA  D`0      (VARIABLE-VALUE-CELL X . 200)
(VARIABLE-VALUE-CELL COMMENTFLG . 169)
(VARIABLE-VALUE-CELL \STRINGOFDS . 156)
(NIL VARIABLE-VALUE-CELL NAME . 198)
(NIL VARIABLE-VALUE-CELL LL . 190)
(NIL VARIABLE-VALUE-CELL BODY . 192)
(EXPR VARIABLE-VALUE-CELL TYPE . 179)
14
ERRORX
EXPR
FEXPR
MACRO
"MACRO defun'itions not supported"
HELP
(0 . 1)
((LAMBDA (X) (AND X (LITATOM X) (NEQ X T))) VARIABLE-VALUE-CELL MACROF . 66)
Bad% LAMBDA% list% for% DEFUN
ERROR
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL Y . 175)
DECLARE
"("
")"
CONCAT
(VARIABLE-VALUE-CELL Z . 170)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
READ
PUTHASH
RPLACA
LAMBDA
NLAMBDA
SHOULDNT
DEFINE
"Bad format for DEFUN"
(ALIST2 CONSS1 CONS CONSNL CF SKNSTP EVCC SKLST LIST2 KT SKLA KNIL SKNLST ENTERF)  (     a    V    c 
   	(      P   
8 Q ( 9 x . H   0        (     g 
  N 	 H x ) h %  p      H        

LIST@ BINARY
                -.          Z   0B   +   Z   ,~          ^"   2B  +   Z`  ,~      /"   ,   ,<      ."`  Z  ,<   @   @,~       0b   +   +      .wZ  Z   ,   XB     .  ,   XB  +   Z  ,~    `$    (VARIABLE-VALUE-CELL NARGS . 19)
(VARIABLE-VALUE-CELL I . 39)
(VARIABLE-VALUE-CELL VAL . 41)
NIL
(CONS MKN KNIL ASZ ENTERF)           @    0      

CATCH BINARY
      	        	-.           Z   ,<   ,<  $  ,<   Z   ,<   ,<   &  ,~      (VARIABLE-VALUE-CELL TAG . 3)
(VARIABLE-VALUE-CELL FORM . 8)
INTERNAL
EVAL
\CATCH.AUX
(KT ENTERF)         

\CATCH.AUX BINARY
                -.           Z   B  @  ,<   @   @,~   Z   3B   +   Z   +   Z  -,   +   3B   +   2B   +   ,<  "  Z  ,   ,<   Z`  Z` ,   ,   D  ,~   BJp     (VARIABLE-VALUE-CELL TAG . 3)
(VARIABLE-VALUE-CELL FUN . 24)
(VARIABLE-VALUE-CELL FORMP . 10)
\CATCH.TAG.INTERN
\CATCH.FINDFRAME
(0 . 1)
(0 . 1)
(NIL VARIABLE-VALUE-CELL \CATCH.1SHOT.OPOS . 0)
"unacceptable function"
SHOULDNT
EVALA
(CONS CONSNL KT SKLA KNIL ENTERF)        X   0               

\CATCH.FINDFRAME BINARY
               -.           ,<  	,<  	,<   ,<   Z   H  
XB  -,   +      
,<   Z  F  ,~   &   (VARIABLE-VALUE-CELL POS . 14)
-1
\CATCH.AUX
STKPOS
SHOULDNT
STKNTH
(SKNSTK KNIL ENTERF)   `    @        

\CATCH.TAG.INTERN BINARY
              -.           Z   B  3B  +   Z  ,<   ,<  "  D  +   Z  XB  3B   +   	2B   +   ,<   ,<  $  Z  B  ,   0"  :7   7   +   ,<  Z  D  B  2B   +   Z  ,<   ,<  $  ,~   Pm0    (VARIABLE-VALUE-CELL TAG . 35)
TYPENAME
LITATOM
Not% of% type% TYPE
CONCAT
ERROR
"NIL and T not usable as CATCH tags"
NCHARS
\CATCH.TAG.
MKATOM
"name too long to be CATCH tag"
(IUNBOX KT KNIL ENTERF) P   h 	     `        

THROW BINARY
        
        	-.           Z   B  Z 7@  7   Z  ,<   Z  ,<   Z   F  	,~      (VARIABLE-VALUE-CELL TAG . 10)
(VARIABLE-VALUE-CELL VAL . 12)
\CATCH.TAG.INTERN
\THROW.AUX
(KNOB ENTERF)    H      

\THROW.AUX BINARY
              -.           Z`  -,   +   B  3B   +   ,<  "  ,<`  ,<` ,<   &  ,<` ,<  $  XB` ,<` "  Z 7@  7   Z  XB`  +   8Y      (POS . 1)
(TAG . 1)
(VAL . 1)
RELSTKP
"THROW to a released frame"
SHOULDNT
RETTO
Tag% to% THROW,% but% no% corresponding% tag% in% a% CATCH
ERROR
\CATCH.TAG.INTERN
(KNOB KT KNIL SKSTK ENTER3)                      
(PRETTYCOMPRINT CMLSPECIALFORMSCOMS)
(RPAQQ CMLSPECIALFORMSCOMS ((COMS (* CommonLisp style DEFUN, LET and LET@ macros and other primitives)
 (MACROS LET LET@) (FNS \LETtran \LetPPMacro) (ALISTS (PRETTYPRINTMACROS LET LET@)) (FNS DEFUN LIST@) 
(MACROS LIST@ PSETQ PROGV)) (COMS (* CommonLisp style CATCH and THROW) (FNS CATCH \CATCH.AUX 
\CATCH.FINDFRAME \CATCH.TAG.INTERN THROW \THROW.AUX) (MACROS CATCH *CATCH \CATCHRUNFUN THROW *THROW 
\CATCHRELSTKP UNWINDPROTECT) (VARS (\CATCH.1SHOT.OPOS (STKNTH 0 T)) (\THROW.1SHOT.OPOS (STKNTH 0 T))) 
(DECLARE: EVAL@COMPILE (PROP SPECVAR \CATCH.1SHOT.OPOS \THROW.1SHOT.OPOS) (DECLARE: DONTCOPY (MACROS 
DATATYPE.TEST))) (DECLARE: COPYWHEN (EQ COMPILEMODE (QUOTE D)) (* Crufty low-level stuff to help make 
\CATCH.TAG.INTERN more efficient) (VARS (\THROW.STRBUFFER (PROG ((X (ALLOCSTRING 256))) (RPLSTRING X 1
 (QUOTE \CATCH.TAG.)) (RETURN X)))) (DECLARE: EVAL@COMPILEWHEN (EQ COMPILEMODE (QUOTE D)) (PROP 
GLOBALVAR \THROW.STRBUFFER) (DECLARE: DONTCOPY (MACROS UNINTERRUPTABLY) (RECORDS LITATOM DSTRINGP) (
I.S.OPRS inatom))))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA 
DEFUN) (NLAML CATCH) (LAMA LIST@)))))
(PUTPROPS LET MACRO (X (\LETtran X)))
(PUTPROPS LET@ MACRO (X (\LETtran X T)))
(ADDTOVAR PRETTYPRINTMACROS (LET . \LetPPMacro) (LET@ . \LetPPMacro))
(PUTPROPS LIST@ MACRO (X (COND ((NLISTP X) NIL) ((NLISTP (CDR X)) (CAR X)) (T (LIST (QUOTE CONS) (CAR 
X) (CONS (QUOTE LIST@) (CDR X)))))))
(PUTPROPS PSETQ MACRO (X (COND ((NLISTP X) NIL) ((NLISTP (CDR X)) (HELP "Odd number args for PSETQ")) 
(T (LIST (QUOTE SETQ) (CAR X) (COND ((CDDR X) (LIST (QUOTE PROG1) (CADR X) (LIST (QUOTE PSETQ) (CDDR X
)))) (T (CADR X))))))))
(PUTPROPS PROGV MACRO ((SYMS VALS . BODY) (EVALA (LIST (FUNCTION (LAMBDA NIL . BODY))) ((LAMBDA (\Vars
 \Vals) (DECLARE (LOCALVARS \Vars \Vals)) (while \Vars collect (CONS (pop \Vars) (OR (pop \Vals) (
QUOTE NOBIND))))) SYMS VALS))))
(PUTPROPS CATCH MACRO (X ((LAMBDA (TAGFORM FN) (COND ((SETQ TAGFORM (CONSTANTEXPRESSIONP TAGFORM)) (
SETQ TAGFORM (\CATCH.TAG.INTERN (CAR TAGFORM))) (SUBPAIR (QUOTE (X FORM)) (LIST TAGFORM (CADR X)) (
SELECTQ COMPILEMODE (D (QUOTE (\CATCHRUNFUN (FUNCTION (LAMBDA NIL ((LAMBDA (X) (DECLARE (SPECVARS X)) 
FORM) (\MYALINK))))))) (QUOTE (\CATCHRUNFUN (FUNCTION (LAMBDA NIL ((LAMBDA (X \CATCH.1SHOT.OPOS) (
DECLARE (SPECVARS X \CATCH.1SHOT.OPOS)) FORM) (STKNTH -2 NIL \CATCH.1SHOT.OPOS))))))))) (T (LIST (
QUOTE \CATCH.AUX) (CAR X) (LIST (QUOTE FUNCTION) (LIST (QUOTE LAMBDA) NIL (CADR X))))))) (CAR X))))
(PUTPROPS *CATCH MACRO (= . CATCH))
(PUTPROPS \CATCHRUNFUN DMACRO (= . SPREADAPPLY*))
(PUTPROPS \CATCHRUNFUN MACRO ((FUN . REST) ((LAMBDA (\CatchBody) (DECLARE (LOCALVARS \CatchBody)) (
APPLY* \CatchBody . REST)) FUN)))
(PUTPROPS THROW MACRO (X ((LAMBDA (TAGFORM) (COND (TAGFORM (LIST (QUOTE \THROW.AUX) (\CATCH.TAG.INTERN
 (CAR TAGFORM)) (KWOTE (CAR TAGFORM)) (CADR X))) (T (QUOTE IGNOREMACRO)))) (CONSTANTEXPRESSIONP (CAR X
)))))
(PUTPROPS *THROW MACRO (= . THROW))
(PUTPROPS \CATCHRELSTKP DMACRO ((X) (ZEROP (\GETBASE X 1))))
(PUTPROPS \CATCHRELSTKP MACRO (= . RELSTKP))
(PUTPROPS UNWINDPROTECT MACRO ((FORM . CLEANUPS) (RESETLST (RESETSAVE NIL (LIST (FUNCTION (LAMBDA NIL 
. CLEANUPS)))) FORM)))
(RPAQ \CATCH.1SHOT.OPOS (STKNTH 0 T))
(RPAQ \THROW.1SHOT.OPOS (STKNTH 0 T))
(PUTPROPS \CATCH.1SHOT.OPOS SPECVAR T)
(PUTPROPS \THROW.1SHOT.OPOS SPECVAR T)
(DECLARE: DONTCOPY (DECLARE: EVAL@COMPILE (PUTPROPS DATATYPE.TEST MACRO (OPENLAMBDA (X TYPE) (COND ((
NOT (TYPENAMEP X TYPE)) (ERROR X (CONCAT (QUOTE Not% of% type% TYPE)))) (T X)))) (PUTPROPS 
DATATYPE.TEST DMACRO (= . \DTEST))))
(PUTPROPS CMLSPECIALFORMS COPYRIGHT ("Xerox Corporation" 1983))
NIL
