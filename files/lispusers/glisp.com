(FILECREATED " 8-JAN-83 14:31:57" ("compiled on " <LISPUSERS>GLISP.LSP;5) (2 . 2) bcompl'd in WORK 
dated "30-DEC-82 00:01:56")
(FILECREATED " 2-DEC-82 14:39:50" {DSK}GLISP.LSP;110 208089 changes to: (FNS GLCOMPOPEN GLCONST? 
GLDOFOR GLPREDICATE GLTHE GLMACLISPTRANSFM GLCOMPPROP GLCOMPPROPL GLINIT GLDESCENDANTP GLDOMSG 
GLGETSUPERS) (VARS GLISPCOMS) previous date: "18-NOV-82 16:55:12" {DSK}GLISP.LSP;105)

A BINARY
            -.          Z   B  ,~       (VARIABLE-VALUE-CELL L . 3)
GLAINTERPRETER
(ENTERF)      

AN BINARY
            -.          Z   B  ,~       (VARIABLE-VALUE-CELL L . 3)
GLAINTERPRETER
(ENTERF)      

GL-A-AN? BINARY
                -.           Z   Z  ,   ,~       (VARIABLE-VALUE-CELL X . 3)
((A AN a an An) . 0)
(FMEMB ENTERF)  8      

GLABSTRACTFN? BINARY
            
    -.           
@  
  ,~   Z   B  XB   3B   +   	-,   +   	Z  2B  7   Z   ,~   Z   ,~   J@  (VARIABLE-VALUE-CELL FNNAME . 6)
(NIL VARIABLE-VALUE-CELL DEFN . 13)
GETD
MLAMBDA
(KT SKLST KNIL ENTERF)       h       X      

GLADDINSTANCEFN BINARY
              -.           Z   ,<   ,<  Z   F  ,~   @   (VARIABLE-VALUE-CELL FN . 3)
(VARIABLE-VALUE-CELL ENTRY . 6)
GLINSTANCEFNS
ADDPROP
(ENTERF)    

GLADDRESULTTYPE BINARY
              -.          Z   2B   +   Z   XB  ,~   -,   +   Z  2B  +   Z  ,<   [  D  3B   +   Z   ,~   Z   Z  ,<   Z  ,   D  ,~   Z  Z  ,   3B   +   Z   ,~   Z   ,<  Z  ,<   Z  ,<  ,   XB  ,~   
     (VARIABLE-VALUE-CELL SDES . 40)
(VARIABLE-VALUE-CELL RESULTTYPE . 43)
OR
MEMBER
NCONC
(LIST3 EQUAL CONSNL KT SKLST KNIL ENTERF)               @    X      0 
  0      

GLADDSTR BINARY
                
-.            Z   ,<   Z   ,<  Z   ,<  Z   ,<  ,   Z  ,   D  
,~    @  (VARIABLE-VALUE-CELL ATM . 5)
(VARIABLE-VALUE-CELL NAME . 7)
(VARIABLE-VALUE-CELL STR . 9)
(VARIABLE-VALUE-CELL CONTEXT . 12)
RPLACA
(CONS LIST3 ENTERF)             

GLADJ BINARY
        L    >    I-.          >@  A   ,~   Z   2B  C+   
Z   ,<  ,<  C,<  D&  DXB   3B   +   	+   $Z   ,~   [   Z  ,<   Z  ,<   Z  F  DXB  3B   +   +   $[  
Z  B  EXB   Z  2B   +   +   	,<  EZ  B  F,   ,<   Z  ,<   Z  F  FXB   3B   +   "Z  ,<   [  Z  ,<   ,<   &  GXB   Z  ,<  Z  D  GZ  ,<   Z  D  GZ  ,~   [  XB  "+   [  Z  -,   +   :[  $Z  Z  ,<   ,<  H$  H3B   +   :[  &Z  [  Z  -,   +   :[  *Z  [  [  2B   +   :[   Z  ,<   Z  ,<   [  -Z  [  Z  F  DXB  !3B   +   :XB  2Z   2B   +   97   Z   XB  7+   $Z  0,<   Z  6,<  ,<   Z   H  I,~   g2:@B4D         (VARIABLE-VALUE-CELL SOURCE . 117)
(VARIABLE-VALUE-CELL PROPERTY . 44)
(VARIABLE-VALUE-CELL ADJWD . 99)
(VARIABLE-VALUE-CELL NOTFLG . 115)
(VARIABLE-VALUE-CELL CONTEXT . 122)
(NIL VARIABLE-VALUE-CELL ADJL . 119)
(NIL VARIABLE-VALUE-CELL TRANS . 70)
(NIL VARIABLE-VALUE-CELL TMP . 106)
(NIL VARIABLE-VALUE-CELL FETCHCODE . 61)
ISASELF
ISA
self
GLSTRPROP
GLTRANSPARENTTYPES
*GL*
GLXTRTYPE
GLADJ
GLSTRFN
GLSTRVAL
((NOT Not not) . 0)
MEMB
GLCOMPMSG
(KT SKA SKLST ALIST2 KNIL ENTERF)    P   `   `   X :  6   * P  0           

GLAINTERPRETER BINARY
            -.           @    P,~   Z"   XB   Z  XB   Z   XB   Z"   XB   Z   ,   XB   XB   Z  Z   ,   B  XB   Z  B  ,~    H      (VARIABLE-VALUE-CELL L . 19)
(NIL VARIABLE-VALUE-CELL CODE . 23)
(NIL VARIABLE-VALUE-CELL GLNATOM . 7)
(NIL VARIABLE-VALUE-CELL FAULTFN . 9)
(NIL VARIABLE-VALUE-CELL CONTEXT . 17)
(NIL VARIABLE-VALUE-CELL VALBUSY . 11)
(NIL VARIABLE-VALUE-CELL GLSEPATOM . 0)
(NIL VARIABLE-VALUE-CELL GLSEPPTR . 13)
(NIL VARIABLE-VALUE-CELL EXPRSTACK . 0)
(NIL VARIABLE-VALUE-CELL GLTOPCTX . 16)
(NIL VARIABLE-VALUE-CELL GLGLOBALVARS . 0)
GLAINTERPRETER
A
GLDOA
EVAL
(CONS CONSNL KNIL KT ASZ ENTERF)                    @      

GLAMBDATRAN BINARY
             -.          @    ,~   Z   XB   Z  B  Z  ,<   ,<  ,<   Z   ,<  ,<   &  XB   F  Z  B  ,<   Z  	,<   Z   F  Z  ,~   
B      (VARIABLE-VALUE-CELL GLEXPR . 14)
(VARIABLE-VALUE-CELL FAULTFN . 20)
(VARIABLE-VALUE-CELL GLLASTFNCOMPILED . 7)
(VARIABLE-VALUE-CELL CLISPARRAY . 25)
(NIL VARIABLE-VALUE-CELL NEWEXPR . 27)
SAVEDEF
GLCOMPILED
GLCOMP
PUTPROP
GETD
PUTHASH
(KNIL ENTERF)       

GLANALYZEGLISP BINARY
                -.           @    ,~   Z   [  XB   ,<   Z   D  XB   ,<  "  ,<   ,<  $  B  XB   ,<   Zp  -,   +   +   Zp  ,<   @     +      Z   B  Z  ,<   ,<  ,<  &  B  B  ,~   [p  XBp  +   
/   Z   ,~   \4x@   (VARIABLE-VALUE-CELL GLISPCOMS . 6)
(VARIABLE-VALUE-CELL GLSPECIALFNS . 10)
(NIL VARIABLE-VALUE-CELL CALLEDFNS . 19)
(NIL VARIABLE-VALUE-CELL GLFNS . 12)
(NIL VARIABLE-VALUE-CELL GLALLFNS . 8)
LDIFFERENCE
((WHAT FNS NOT IN GLALLFNS ARE CALLED BY FNS IN GLFNS) . 0)
MASTERSCOPE
((ATOM apply RPLACD CDDR SET SOME EQUAL NUMBERP CAR CADR CONS RPLACA LIST DECLARE NCONC) . 0)
SORT
(VARIABLE-VALUE-CELL X . 33)
TERPRI
PRINT
FN
((WHAT FNS IN GLFNS CALL FN) . 0)
SUBST
(KNIL BHC SKNLST ENTER0)                  

GLANDFN BINARY
      5    0    3-.           0Z   2B   +   Z   ,~   Z  2B   +   Z  ,~   Z  -,   +   Z  Z  2B  1+   Z  -,   +   Z  
Z  2B  1+   Z  ,<   Z  [  D  2,<   [  Z  ,   ,~   Z  -,   +   Z  Z  2B  1+   Z  ,<   Z  ,   D  2,<   [  Z  ,   ,~   Z  -,   +   $Z  Z  2B  1+   $Z  Z  [  ,   Z  1,   ,<   [  Z  ,   ,~   Z  ",<   ,<  1Z  ,   F  22B   +   0Z  $,<   ,<  1Z  %F  32B   +   0,<  1Z  (,<   Z  ),   ,<   [  -Z  ,   ,~   &&	B J`  (VARIABLE-VALUE-CELL LHS . 88)
(VARIABLE-VALUE-CELL RHS . 93)
AND
APPEND
GLDOMSG
GLUSERSTROP
(ALIST3 CONS21 CONS CONSNL ALIST2 SKLST KNIL ENTERF)   .    "    !    '     $ 0      @      8 (  X        

GLANYCARCDR? BINARY
      $        #-.           @     ,~   Z   ,<   ,<  $  2B   +   	Z  ,<   ,<   $  3B  !+   
Z   ,~   Z  B  !,   /"   ,   XB   Z"  XB      ,>  ,>          ,^   /   3b  +   Z   ,~   Z  
,<   Z  D  XB   3B  "+   2B  "+   	Z  ,   XB     ."   ,   XB  +      <x@ A<  (VARIABLE-VALUE-CELL ATM . 39)
(NIL VARIABLE-VALUE-CELL RES . 50)
(NIL VARIABLE-VALUE-CELL N . 54)
(NIL VARIABLE-VALUE-CELL NMAX . 31)
(NIL VARIABLE-VALUE-CELL TMP . 43)
1
NTHCHAR
C
-1
R
NCHARS
D
A
(CONS BHC ASZ MKN IUNBOX KNIL ENTERF)          `   8         
       

GLATOMSTRFN BINARY
               -.           @    ,~   ,<  [   D  XB   3B   +   
Z   ,<  ,<   Z   ,<  ,<   (  2B   +   ,<  [  D  XB  3B   +   Z  ,<  [  Z  ,<   ,<  &  ,~   Z   ,~   $R     (VARIABLE-VALUE-CELL IND . 27)
(VARIABLE-VALUE-CELL DES . 22)
(VARIABLE-VALUE-CELL DESLIST . 15)
(NIL VARIABLE-VALUE-CELL TMP . 29)
PROPLIST
ASSOC
GLPROPSTRFN
BINDING
((EVAL *GL*) . 0)
GLSTRVALB
(KT KNIL ENTERF)   	     X 
  `      

GLATMSTR? BINARY
       .    )    --.           )@  *  ,~   [   3B   +   [  Z  -,   +   [  [  3B   +   [  [  Z  -,   +   [  [  [  3B   +   Z   ,~   ,<  *[  D  +XB   3B   +   [  [  2B   +   [  Z  B  +2B   +   +   ,<  ,[  D  +XB  3B   +   ([  ,<   Zp  -,   +   Z   +    Zp  ,<   ,<w/   @  ,   +   %Z   -,   +   $[   Z  B  +,~   Z   ,~   2B   +   'Z   +    [p  XBp  +   Z   ,~   "B)tBI    (VARIABLE-VALUE-CELL STR . 46)
(NIL VARIABLE-VALUE-CELL TMP . 51)
BINDING
ASSOC
GLOKSTR?
PROPLIST
(VARIABLE-VALUE-CELL X . 68)
(SKA BHC URET1 KT SKNLST SKLST KNIL ENTERF)  "        ' X              h   p & P  `    X   H      

GLBUILDALIST BINARY
    !         -.          @    ,~   Z   2B   +   	Z   3B   +   ,<   ,<   $  ,~   Z   ,~   Z  ,<   [  	XB  
,\   XB   ,<   Z   ,<  Z   F  XB   3B   +   Z  ,<  Z  3B   +   3B   +   -,   +   ,<  ,<   ,   ,<   Z  ,<   ,<   &  ,   D  XB  +   $@ HVP  (VARIABLE-VALUE-CELL ALIST . 21)
(VARIABLE-VALUE-CELL PREVLST . 27)
(VARIABLE-VALUE-CELL PAIRLIST . 25)
(NIL VARIABLE-VALUE-CELL LIS . 51)
(NIL VARIABLE-VALUE-CELL TMP1 . 34)
(NIL VARIABLE-VALUE-CELL TMP2 . 45)
GLBUILDLIST
GLBUILDSTR
QUOTE
GLBUILDCONS
NCONC
(CONSNL LIST2 SKNNM KT KNIL ENTERF)     h   H           	  x   H      

GLBUILDCONS BINARY
     +    $    *-.           $Z   2B   +   Z   ,   ,<   Z   D  &,~   -,   +   Z  2B  &+   Z  [  ,   ,<   Z  D  &,~   Z  
3B   +   Z  B  '3B   +   Z  	B  '3B   +   ,<  'Z  B  (,<   Z  B  (,   ,   ,~   Z  3B   +   !Z  B  (3B   +   !Z  B  (3B   +   !,<  ),<  'Z  B  (,<   Z  B  (,   ,   ,   ,~   ,<  )Z  ,<   Z  ,<  ,   ,~   	0"U$
W$     (VARIABLE-VALUE-CELL X . 67)
(VARIABLE-VALUE-CELL Y . 69)
(VARIABLE-VALUE-CELL OPTFLG . 44)
GLBUILDLIST
LIST
GLCONST?
QUOTE
GLCONSTVAL
GLCONSTSTR?
COPY
CONS
(LIST3 ALIST2 CONSS1 CONS SKLST CONSNL KNIL ENTERF)  H      `         
                 X        

GLBUILDLIST BINARY
       N    G    L-.           GZ   ,<   Zp  -,   +   Z   +   
Zp  ,<   ,<w$  H2B   +   	Z   +   
[p  XBp  +   /   3B   +   +Z   3B   +   ,<  HZ  ,<  ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ZwB  IZp  ,   XBp  [wXBw+   /  ,   ,~   ,<  I,<  HZ  ,<  ,<   Zw-,   +   $Zp  Z   2B   +   " "  +   $[  QD   "  +   (ZwB  IZp  ,   XBp  [wXBw+   /  ,   ,   B  J,~   Z  ,<   Zp  -,   +   .Z   +   4Zp  ,<   ,<w$  J2B   +   2Z   +   4[p  XBp  +   ,/   3B   +   E,<  K,<  HZ  +,<   ,<   Zw-,   +   >Zp  Z   2B   +   < "  +   >[  QD   "  +   BZwB  IZp  ,   XBp  [wXBw+   8/  ,   ,   B  J,~   Z  KZ  6,   ,~   Q)(P#P"
IA
P     (VARIABLE-VALUE-CELL LST . 139)
(VARIABLE-VALUE-CELL OPTFLG . 24)
GLCONST?
QUOTE
GLCONSTVAL
APPEND
GLGENCODE
GLCONSTSTR?
COPY
LIST
(CONS ALIST2 COLLCT BHC KNIL KT SKNLST ENTERF)  G    D @ *       A p     C P ) 0     ; 0 8 X 2  !   0     @ 	     h     9 X          

GLBUILDNOT BINARY
        .    &    ,-.          &@  '  ,~   Z   B  '3B   +   Z  B  (2B   +   7   Z   ,~   Z  -,   +   ,<  (,<   ,   ,~   Z  2B  (+   [  Z  ,~   Z  -,   +   Z   ,~   Z  ,<   Z   2B  )+   Z  )+   3B  *+   2B  *+   Z  ++   2B  ++   Z  ,+   Z       ,\   7   [  Z  Z  1H  +   2D   +   XB   3B   +   #[  Z  [  ,   ,~   ,<  (Z  ",<  ,   ,~   U`
      (VARIABLE-VALUE-CELL CODE . 72)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 37)
(NIL VARIABLE-VALUE-CELL TMP . 66)
GLCONST?
GLCONSTVAL
NOT
INTERLISP
(((LISTP NLISTP) (EQ NEQ) (NEQ EQ) (IGREATERP ILEQ) (ILEQ IGREATERP) (ILESSP IGEQ) (IGEQ ILESSP) (
GREATERP LEQ) (LEQ GREATERP) (LESSP GEQ) (GEQ LESSP)) . 0)
MACLISP
FRANZLISP
(((> <=) (< >=) (<= >) (>= <)) . 0)
PSL
(((EQ NE) (NE EQ) (LEQ GREATERP) (GEQ LESSP)) . 0)
(CONS SKNA LIST2 SKNLST KT KNIL ENTERF)  #        & @             0     P      

GLBUILDPROPLIST BINARY
              -.          @    ,~   Z   2B   +   	Z   3B   +   ,<   ,<   $  ,~   Z   ,~   Z  ,<   [  	XB  
,\   XB   ,<   Z   ,<  Z   F  XB   3B   +   Z  ,<  Z  3B   +   3B   +   -,   +   ,<  ,<   ,   ,<   Z  ,<   ,   D  XB  +   $@ HV@  (VARIABLE-VALUE-CELL PLIST . 21)
(VARIABLE-VALUE-CELL PREVLST . 27)
(VARIABLE-VALUE-CELL PAIRLIST . 25)
(NIL VARIABLE-VALUE-CELL LIS . 49)
(NIL VARIABLE-VALUE-CELL TMP1 . 34)
(NIL VARIABLE-VALUE-CELL TMP2 . 45)
GLBUILDLIST
GLBUILDSTR
QUOTE
NCONC
(LIST2 SKNNM KT KNIL ENTERF)                  	  x   H      

GLBUILDRECORD BINARY
       %      !-.         @   ,~   [   Z  -,   +   [  Z  XB   [  [  XB   +   	[  XB  Z  2B +   Z Z  	,   XB  Z   2B +   AZ  3B   +   -,<   Z  ,<  ,<   ,<   ,<   Zw~-,   +   Zw+   +Zw~,<   @    +   !Z   ,<   Z   ,<  Z   F XB   3B   +    Z  ,<   ,< Z  ,<   ,   ,~   Z   ,~   XBp  -,   +   )Zw3B   +   %Zp  QD  +   &Zp  XBw       [  2D   +   'XBw[w~XBw~+   /  ,   Z ,   ,~   Z  ,<  ,<   Zw-,   +   5Zp  Z   2B   +   3 "  +   5[  QD   "  +   >Zw,<   @    +   ;Z  ,<   Z  ,<  Z  F ,~   Zp  ,   XBp  [wXBw+   //  ,<   ,<   $ ,~   2B +   V,< Z  -,<  ,<   Zw-,   +   JZp  Z   2B   +   H "  +   J[  QD   "  +   SZw,<   @    +   PZ  8,<   Z  9,<  Z  :F ,~   Zp  ,   XBp  [wXBw+   D/  ,<   ,<   $ ,   ,~   2B +   oZ  B,<  ,<   Zw-,   +   _Zp  Z   2B   +   ] "  +   _[  QD   "  +   hZw,<   @    +   eZ  M,<   Z  N,<  Z  OF ,~   Zp  ,   XBp  [wXBw+   Y/  XB  ,< [  i,<   Z  j,   D ,<   ,<   $ ,   ,~   2B  +  Z  W,<  ,<   Zw-,   +   xZp  Z   2B   +   v "  +   w[  QD   "  +  Zw,<   @    +   ~Z  b,<   Z  c,<  Z  dF ,~   Zp  ,   XBp  [wXBw+   q/  Z  ,   ,~   Z  p,<  ,<   Zw-,   +  Zp  Z   2B   +  	 "  +  
[  QD   "  +  Zw,<   @    +  Z  z,<   Z  {,<  Z  |F ,~   Zp  ,   XBp  [wXBw+  /  ,<   ,<   $ ,~   aH	Q(8DP "0E	 @HIA
A@"DP@D   (VARIABLE-VALUE-CELL STR . 19)
(VARIABLE-VALUE-CELL PAIRLIST . 285)
(VARIABLE-VALUE-CELL PREVLST . 287)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 26)
(NIL VARIABLE-VALUE-CELL TEMP . 214)
(NIL VARIABLE-VALUE-CELL ITEMS . 262)
(NIL VARIABLE-VALUE-CELL RECORDNAME . 29)
OBJECT
((CLASS ATOM) . 0)
INTERLISP
(VARIABLE-VALUE-CELL X . 283)
GLBUILDSTR
_
create
GLBUILDLIST
FRANZLISP
MAKHUNK
MACLISP
NCONC
PSL
Vector
(CONSNL ALIST2 KT COLLCT CONS21 CONSS1 BHC SKLST LIST3 SKNLST KNIL CONS SKA ENTERF)  l    o 
h   ` U    x g 
  =    X   H   P  T x ,    "         0 Z X 0 H   ` x P t   \ @ Y x G H @ ( 2 x ) @ ! H  0      P    P      

GLBUILDSTR BINARY
     r   S   k-.          S@ T  (
,~   Z WXB   Z   2B   +   Z   ,~   -,   +   ,<   Z  D WXB   3B   +   [  	,~   Z  ,<  Z   D X3B   +   +   Z  B XXB  
3B   +   ,<   ,<   Z  Z  ,   F Y,~   -,   +   ,< Y,< Y,<   ,   D Z+   Z  2B Z+   $[  Z  ,<   Z   ,<   Z  F Y,<   [  [  Z  ,<   Z  ,<   Z  F Y,<   ,<   & [,~   2B [+   9[  ,<   ,<   Zw-,   +   -Zp  Z   2B   +   + "  +   -[  QD   "  +   6Zw,<   @ \   +   3Z   ,<   Z   ,<  Z  !F Y,~   Zp  ,   XBp  [wXBw+   '/  ,<   ,<   $ \,~   2B ]+   SZ  23B   +   ?3B   +   ?-,   +   ?,< ],<   ,   ,<   [  %,<   ,<   Zw-,   +   GZp  Z   2B   +   E "  +   G[  QD   "  +   PZw,<   @ \   +   MZ  0,<   Z  1,<  Z  :F Y,~   Zp  ,   XBp  [wXBw+   A/  ,   ,<   ,<   $ \,~   2B ^+   W[  ?,<   Z  LD ^,~   2B _+   Z[  T,<   Z  UD _,~   2B `+   ,< `Z a,   ,<   ,< a,< aZ  Y3B   +   hZ  ^-,   +   h,< bZ  `3B   +   g3B   +   g-,   +   g,< ],<   ,   ,   +   iZ b,   ,   ,   XB   ,< cZ  XD WXB  3B   +   u[  lZ  ,<   Z  K,<   Z  bF YXB   Z  j,<  ,< c,< a,<   ,   ,   D d,< _Z  kD WXB  m3B   +   {[  wXB   ,<   Z  pD dZ  q,<   ,< e" e,   D dZ  {,~   2B f+  ,< `Z a,   ,<   ,< a,< aZ  z3B   +  Z -,   +  ,< bZ 3B   +  3B   +  -,   +  ,< ],<   ,   ,   +  Z b,   ,   ,   XB  ~,<   ,< f,< a,< ],< g,   ,<   Z 3B   +  3B   +  -,   +  ,< ],<   ,   ,   B g,   D d[  v,<   Z D dZ ,<   ,< h" e,   D d,~   2B h+  ,[ Z  ,<   Z D X2B   +  +[  Z  B XXB  x3B   +  +,<   Z  o,<  [ #Z  Z !,   F Y,~   Z   ,~   2B i+  .Z   ,~   2B i+  2Z (,<   Z ',<  Z )F j,~   2B j+  >Z /,<   ,< gZ 13B   +  :3B   +  :-,   +  :,< ],<   ,   ,<   ,< `,   Z 0,   ,<   Z 5F j,~   Z 3-,   +  RZ >,<   Z ;D WXB %3B   +  E[ BZ  ,~   [ @Z  -,   +  N[ EZ  ,<   Z  D W2B   +  N[ GZ  ,<   ,<   Z =F Y,~   [ JZ  ,<   Z A,<   Z LF Y,~   Z   ,~   Iis00"DP EJ`Q(XX<de1BFH&22X`pV&XR L%1! @            (VARIABLE-VALUE-CELL STR . 412)
(VARIABLE-VALUE-CELL PAIRLIST . 415)
(VARIABLE-VALUE-CELL PREVLST . 417)
(NIL VARIABLE-VALUE-CELL PROPLIS . 242)
(NIL VARIABLE-VALUE-CELL TEMP . 391)
(NIL VARIABLE-VALUE-CELL PROGG . 311)
(NIL VARIABLE-VALUE-CELL TMPCODE . 226)
(NIL VARIABLE-VALUE-CELL ATMSTR . 401)
(((ATOM) (INTEGER . 0) (REAL . 0.0) (NUMBER . 0) (BOOLEAN) (NIL) (ANYTHING)) . 0)
ASSOC
MEMB
GLGETSTR
GLBUILDSTR
"Illegal structure type encountered:"
GLERROR
CONS
GLBUILDCONS
LIST
(VARIABLE-VALUE-CELL X . 148)
GLBUILDLIST
LISTOBJECT
QUOTE
ALIST
GLBUILDALIST
PROPLIST
GLBUILDPROPLIST
ATOM
PROG
ATOMNAME
SETQ
GLMKATOM
GENSYM
BINDING
SET
NCONC
GLPUTPROPS
((RETURN ATOMNAME) . 0)
COPY
ATOMOBJECT
PUTPROP
CLASS
GLGENCODE
((RETURN ATOMNAME) . 0)
TRANSPARENT
LISTOF
RECORD
GLBUILDRECORD
OBJECT
(ALIST4 LIST3 ALIST3 ALIST2 CONSNL CONSS1 SKNNM KT BHC COLLCT LIST2 SKNLST CONS SKA KNIL ENTERF)     < P   p ( j        h ` ` u  ]    R   8 `
 X =   7 P	 H <    Q x   	p 5   :   @ g x     B     = (    G       S PJ 86 `, h# @ H x X c   S H D  ;  *   ' @    (   X      

GLCARCDRRESULTTYPE BINARY
                -.           Z   2B   +   Z   ,~   Z  2B   +   Z   ,~   -,   +   	B  XB  +   -,   +      ,~   Z  ,<  B  D  ,~   k (VARIABLE-VALUE-CELL LST . 22)
(VARIABLE-VALUE-CELL STR . 16)
GLGETSTR
ERROR
GLXTRTYPE
GLCARCDRRESULTTYPEB
(SKNLST SKA KNIL ENTERF)  
          X        

GLCARCDRRESULTTYPEB BINARY
    :    3    8-.          3Z   2B   +   Z   ,~   -,   +   Z   ,<  D  4,~   -,   +   	   5,~   Z  -,   +   Z  	,<   Z   D  52B   +   [  
3B   +   [  [  2B   +   Z  ,<   [  Z  D  4,~   Z  2B  6+   Z  3B  6+   Z  3B  7+   Z  2B  7+   [  ,<   [  Z  D  4,~   Z   ,~   Z  2B  8+   2Z  2B  7+   $[  ,<   [  [  Z  D  4,~   Z  "2B  7+   -[  $[  3B   +   ,[  !,<   Z  7[  &[  ,   D  4,~   Z   ,~   Z  )2B  67   7   +   2[  (,<   Z  -D  4,~      5,~   1
"6a`HB"@     (VARIABLE-VALUE-CELL LST . 95)
(VARIABLE-VALUE-CELL STR . 97)
(VARIABLE-VALUE-CELL GLTYPENAMES . 23)
GLCARCDRRESULTTYPE
ERROR
MEMB
A
LISTOF
CONS
LIST
D
(KT CONS SKNLST SKA KNIL ENTERF) x   8       (     / P ( `  p   @        

GLCARCDR? BINARY
            -.           Z   Z  ,   ,~       (VARIABLE-VALUE-CELL X . 3)
((CAR CDR CAAR CADR CDAR CDDR CAAAR CAADR CADAR CDAAR CADDR CDADR CDDAR CDDDR) . 0)
(FMEMB ENTERF)    8      

GLCC BINARY
           
    -.          
Z   2B   +   Z   XB  B  2B   +   Z  B  ,<  "     ,~   Z  B  ,~   +d  (VARIABLE-VALUE-CELL FN . 17)
(VARIABLE-VALUE-CELL GLLASTFNCOMPILED . 6)
GLGETD
PRIN1
" ?"
TERPRI
GLCOMPILE
(KNIL ENTERF)    X        

GLCLASS BINARY
              -.           @    ,~   Z   -,   +   ,<   ,<  $  +   	-,   +   Z  +   	Z   XB   3B   +   B  3B   +   Z  	,~   Z   ,~   .QP (VARIABLE-VALUE-CELL OBJ . 15)
(NIL VARIABLE-VALUE-CELL CLASS . 24)
CLASS
GETPROP
GLCLASSP
(KNIL SKLST SKA ENTERF)  `  ( 	               

GLCLASSMEMP BINARY
               -.           Z   B  ,<   Z   D  ,~   @   (VARIABLE-VALUE-CELL OBJ . 3)
(VARIABLE-VALUE-CELL CLASS . 6)
GLCLASS
GLDESCENDANTP
(ENTERF)      

GLCLASSP BINARY
             -.           @    ,~   Z   -,   +   ,<   ,<  $  XB   3B   +   Z  B  Z  ,<   ,<  $  ,~   Z   ,~   ,S  (VARIABLE-VALUE-CELL CLASS . 6)
(NIL VARIABLE-VALUE-CELL TMP . 15)
GLSTRUCTURE
GETPROP
GLXTRTYPE
((OBJECT ATOMOBJECT LISTOBJECT) . 0)
MEMB
(KNIL SKA ENTERF)   @            

GLCLASSSEND BINARY
           
    -.            
@    ,~   Z   ,<   Z   ,<  Z   F  XB   3B   +   	,<   Z   D  ,~   Z  ,~   J  (VARIABLE-VALUE-CELL CLASS . 6)
(VARIABLE-VALUE-CELL SELECTOR . 8)
(VARIABLE-VALUE-CELL ARGS . 16)
(VARIABLE-VALUE-CELL PROPNAME . 10)
(NIL VARIABLE-VALUE-CELL FNCODE . 12)
GLCOMPPROP
APPLY
GLSENDFAILURE
(KNIL ENTERF)  x      

GLCOMP BINARY
     2    $    1-.          $@  &  X,~   Z"   XB   Z   2B   +   ,<  ,Z   ,<  ,   B  ,Z   ,   XB   Z"   XB   Z   ,   XB   [  Z  ,<   ,<   ,<   Z  ,<   Z  J  -XB   [  [  XB     -   .   -   .[  2B   +   7   Z   XB   Z  ,<  Z   Z  ,   D  .XB   Z  ,<  ,<  /Z   2B   +   [  Z  F  /Z  Z  ,   Z  0,   XB   ,<   ,<   $  0,~     <@     (VARIABLE-VALUE-CELL GLAMBDAFN . 54)
(VARIABLE-VALUE-CELL GLEXPR . 47)
(VARIABLE-VALUE-CELL GLTYPESUBS . 0)
(VARIABLE-VALUE-CELL GLQUIETFLG . 8)
(NIL VARIABLE-VALUE-CELL NEWARGS . 63)
(NIL VARIABLE-VALUE-CELL NEWEXPR . 64)
(NIL VARIABLE-VALUE-CELL GLNATOM . 20)
(NIL VARIABLE-VALUE-CELL GLTOPCTX . 50)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 57)
(NIL VARIABLE-VALUE-CELL GLGLOBALVARS . 0)
(NIL VARIABLE-VALUE-CELL RESULT . 68)
(NIL VARIABLE-VALUE-CELL GLSEPATOM . 0)
(NIL VARIABLE-VALUE-CELL GLSEPPTR . 7)
(NIL VARIABLE-VALUE-CELL VALBUSY . 46)
(NIL VARIABLE-VALUE-CELL EXPRSTACK . 18)
GLCOMP
PRINT
GLDECL
GLSKIPCOMMENTS
GLRESGLOBAL
GLPROGN
GLRESULTTYPE
PUTPROP
LAMBDA
GLUNWRAP
(CONS21 CONS KT CONSNL LIST2 KNIL ASZ ENTERF)   "    ! (   @  h   @ 	           `  8     
  @      

GLCOMPABSTRACT BINARY
       !         -.           @    ,~   Z   ,<   ,<  $  2B   +   ^"   +   ,   ."   ,   XB   Z  ,<  ,<  F  Z  	B  ,<   Z  B  Z  ,   D  B  XB   Z  ,<  ,   XB   D  Z  ,<   ,<   Z  B  ,<   Z   F  D  Z  ,~   5S0B0   (VARIABLE-VALUE-CELL FN . 40)
(VARIABLE-VALUE-CELL TYPESUBS . 43)
(NIL VARIABLE-VALUE-CELL INSTFN . 46)
(NIL VARIABLE-VALUE-CELL N . 25)
(NIL VARIABLE-VALUE-CELL INSTENT . 35)
GLINSTANCEFNNO
GETPROP
PUTPROP
UNPACK
-
NCONC
PACK
GLADDINSTANCEFN
GETD
GLCOMP
PUTD
(CONSNL CONS21 MKN IUNBOX KNIL ENTERF)      p           `      

GLCOMPCOMS BINARY
      .    %    ,-.           %@  &  ,~   Z   2B   +   Z   ,~   Z  -,   +   #Z  Z  2B  &+   #Z  [  Z  2B  '+   Z  	[  [  Z  B  '+   Z  [  XB   ,<   Zp  -,   +   +   #Zp  ,<   @  (   +   !Z   B  (Z  2B  )+   !Z  B  )Z   3B   +   !   *   *   *Z  B  *Z  B  (B  +   *Z  ,<   ,<  +$  ,B  +,~   [p  XBp  +   /   [  XB  #+   !a@JZ=9b     (VARIABLE-VALUE-CELL COMSLIST . 72)
(VARIABLE-VALUE-CELL PRINTFLG . 49)
(NIL VARIABLE-VALUE-CELL FNS . 31)
FNS
*
EVAL
(VARIABLE-VALUE-CELL X . 61)
GLGETD
GLAMBDA
GLCOMPILE
TERPRI
PRINT
PRINTDEF
GLCOMPILED
GETPROP
(BHC SKNLST SKLST KNIL ENTERF)   @        p       H      

GLCOMPILE BINARY
               -.           Z   B  B  Z  ,~       (VARIABLE-VALUE-CELL FAULTFN . 6)
GLGETD
GLAMBDATRAN
(ENTERF)     

GLCOMPILE? BINARY
              -.           Z   ,<   ,<  $  2B   +   Z  B  ,~   (   (VARIABLE-VALUE-CELL FN . 9)
GLCOMPILED
GETPROP
GLCOMPILE
(KNIL ENTERF)  H      

GLCOMPMSG BINARY
            -.           @   (
,~   [   [  ,<   ,< $ XB   [  Z  XB   -,   +   =[  [  ,<   ,< $ 3B   +   Z  ,<   Z   Z   ,   ,<   [  Z  ,<   [  [  ,<   ,< $ ,   ,<   Z  ,<   [  [  ,<   ,< $ J 	,~   Z  ,<   Z  ,<   Z  ,<   ,<   Zw-,   +   "Zp  Z   2B   +     "  +   "[  QD   "  +   &ZwZ  Zp  ,   XBp  [wXBw+   /  ,   ,   ,<   Z  ,<   [  Z  ,<   Z  ,<   ,<   Zw-,   +   3Zp  Z   2B   +   1 "  +   2[  QD   "  +   7Zw[  Z  Zp  ,   XBp  [wXBw+   ,/  ,   D 	2B   +   <[  [  ,<   ,< $ ,   ,~   -,   +   A,< 
,< 
Z  :,   D ,~   Z  (-,   +   SZ  AZ  ,<   ,< $ 3B   +   S[  ?[  ,<   ,< $ XB   2B   +   P[  )Z  ,<   Z  CD XB  IZ  F,<  ,< ,<   ,   D Z  J,<   Z  M,<   ,   ,~   Z   ,   XB   Z  P-,   +   \,< Z  U,   ,<   ,< [  WZ  ,<   Z  TH +   oZ  Y-,   +   iZ  \Z  2B +   iZ  ][  Z  -,   +   iZ  _[  [  2B   +   iZ  b,<   ,< [  dZ  ,<   Z  ZH +   o,< Z  f,   Z   ,   XB  j,< ,<   [  iZ  ,<   Z  gH Z  L,<   Z  nD XB   ,<   Z  q[  3B   +   vZ Z  r,   +   wZ  uZ  D Z  k3B   +   },< ,<   ,< Z  v,   ,   B +   ~Z  {,<   Z  2B   +  [  }Z  ,   ,~   P ` "D  FD4d b!pA#         (VARIABLE-VALUE-CELL OBJECT . 218)
(VARIABLE-VALUE-CELL MSGLST . 155)
(VARIABLE-VALUE-CELL ARGLIST . 86)
(VARIABLE-VALUE-CELL CONTEXT . 225)
(NIL VARIABLE-VALUE-CELL GLPROGLST . 240)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 253)
(NIL VARIABLE-VALUE-CELL METHOD . 223)
(NIL VARIABLE-VALUE-CELL RESULT . 256)
(NIL VARIABLE-VALUE-CELL VTYPE . 163)
RESULT
LISTGET
OPEN
ARGTYPES
SPECVARS
GLCOMPOPEN
GLRESULTTYPE
GLCOMPMSG
"The form of Response is illegal for message"
GLERROR
((virtual Virtual VIRTUAL) . 0)
MEMB
VTYPE
GLMAKEVTYPE
NCONC
PROG1
self
GLADDSTR
GLPROGN
PROGN
RPLACA
PROG
RETURN
GLGENCODE
(ALIST3 CONSNL LIST2 SKLST ALIST2 BHC COLLCT SKNLST CONSS1 CONS KNIL SKA ENTERF) P   
P   
8 P    ] 0     | 0 X  =    8 x   ` %    > `     9  ( @   h l p     y H m H T 	( F   0 x - x  H     b 
h        

GLCOMPOPEN BINARY
       .      )-.     (    @   0,~   Z   ,   XB   Z   B  XB   [  Z  ,<   ,<   ,<   Z  ,<   ,<   *  Z  B !XB   Z  
,<  ,<   $ !Z  2B   +   +   ]Z   2B   +   Z  Z  ,<   ,<   Z   2B   +   Z  [  [  Z  ,<   Z  H "Z  Z  Z   ,   XB  +   XZ  Z  -,   +   .Z   3B   +   .Z  Z  ,<   Z  D "2B   +   .,< #Z  Z  ,   ,<   Z  Z  ,<   Z  #[  Z  2B   +   ,Z  2B   +   ,Z  %[  [  Z  ,<   Z  H "+   XZ   3B   +   IZ  *Z  ,<   Z  .D "2B   +   IZ  &Z  -,   +   IZ  3Z  Z  2B #+   IZ  5Z  [  Z  -,   +   IZ  8Z  [  [  2B   +   IZ  ;Z  ,<   Z  0Z  ,<   Z  >[  Z  2B   +   GZ  )2B   +   GZ  ?[  [  Z  ,<   Z  -H "+   XZ  EZ  ,<   Z  AZ  ,   Z   ,   XB  LZ  IZ  ,<   Z  M[  Z  ,<   Z  J[  Z  2B   +   WZ  C2B   +   WZ  O[  [  Z  ,<   Z  GH "[  UXB  XZ  Q-,   +   \[  YXB  [[  SXB  \+   [  [  XB  ]Z  ^3B   +   eZ  _-,   +   eZ  `Z  2B #+   e[  bXB  d+   _Z  d,<   Z  WD $XB   Z   2B   +   |Z   [  3B   +   |Z  g,<   ,< $$ %XB  Y[  Z  -,   +   z[  mZ  -,   +   |[  pZ  Z  2B #+   |[  rZ  [  Z  -,   +   |[  tZ  [  [  2B   +   |Z  w,<   ,<   $ %Z  M3B   +  Z  kB &XB  z,<   ,< &Z  ,   D !Z  |B !Z  ~,   Z ',   B '+  Z [  3B   +  
Z (Z ,   +  Z Z  ,<   Z   2B   +  Z  ,<  ,<   $ (2B   +  [ 
Z  ,   XB   Z  [2B   +  Z ,<  ,< )Z  B !,<   Z ,   D !Z ,~   !$ Q  `  $!&"0D0 D$Rc"        (VARIABLE-VALUE-CELL FN . 282)
(VARIABLE-VALUE-CELL ARGS . 292)
(VARIABLE-VALUE-CELL ARGTYPES . 185)
(VARIABLE-VALUE-CELL RESULTTYPE . 279)
(VARIABLE-VALUE-CELL SPCVARS . 99)
(VARIABLE-VALUE-CELL VALBUSY . 208)
(VARIABLE-VALUE-CELL EXPR . 211)
(VARIABLE-VALUE-CELL RESULT . 304)
(NIL VARIABLE-VALUE-CELL PTR . 257)
(NIL VARIABLE-VALUE-CELL FNDEF . 203)
(NIL VARIABLE-VALUE-CELL GLPROGLST . 260)
(NIL VARIABLE-VALUE-CELL NEWEXPR . 288)
(NIL VARIABLE-VALUE-CELL CONTEXT . 205)
(NIL VARIABLE-VALUE-CELL NEWARGS . 298)
GLGETD
GLDECL
DREVERSE
RPLACA
GLADDSTR
MEMB
PROG1
*
GLPROGN
2
NLEFT
RPLACD
LAST
RETURN
PROG
GLGENCODE
PROGN
GLRESULTTYPE
LAMBDA
(ALIST3 CONS21 SKNA SKLST ALIST2 SKA CONS KT CONSNL KNIL ENTERF)     X         b 0 5      L P   x ; X     	X                 p   ~ H z 8 i  U 
8 E 8 > 8 *  " P  x  ( 	  @      

GLCOMPPROP BINARY
      C    2    A-.           2@  3  p,~   Z  :XB   Z   ,<  ,<  ;$  ;2B   +      <Z   ,<   Z   ,<  Z  F  <XB   3B   +   [  
Z  -,   +   [  Z  ,~   Z  ,<   ,<  =$  =XB   3B   +   Z  	,<  D  >XB   3B   +   Z  ,<  [  D  >XB  3B   +   [  Z  ,~   Z"   XB   Z   XB   Z"   XB   Z   ,   XB   XB   Z  ,<  Z  ,<  Z  F  >XB   2B   +   %Z   ,~   Z  2B   +   -Z   ,<  ,<  =,<  ?"  ?XB  %F  @Z  ",<   Z  )D  >XB  Z  ,,<   Z  !Z  #,   [  -,   D  @Z  .,~   A$D@ B:      (VARIABLE-VALUE-CELL STR . 78)
(VARIABLE-VALUE-CELL PROPNAME . 92)
(VARIABLE-VALUE-CELL PROPTYPE . 85)
(NIL VARIABLE-VALUE-CELL CODE . 98)
(NIL VARIABLE-VALUE-CELL PL . 87)
(NIL VARIABLE-VALUE-CELL SUBPL . 95)
(NIL VARIABLE-VALUE-CELL PROPENT . 51)
(NIL VARIABLE-VALUE-CELL GLNATOM . 55)
(NIL VARIABLE-VALUE-CELL CONTEXT . 63)
(NIL VARIABLE-VALUE-CELL VALBUSY . 57)
(NIL VARIABLE-VALUE-CELL GLSEPATOM . 0)
(NIL VARIABLE-VALUE-CELL GLSEPPTR . 59)
(NIL VARIABLE-VALUE-CELL EXPRSTACK . 0)
(NIL VARIABLE-VALUE-CELL GLTOPCTX . 62)
(NIL VARIABLE-VALUE-CELL GLGLOBALVARS . 0)
(NIL VARIABLE-VALUE-CELL GLTYPESUBS . 0)
(NIL VARIABLE-VALUE-CELL FAULTFN . 7)
GLCOMPPROP
((ADJ ISA PROP MSG) . 0)
MEMB
ERROR
GLGETPROP
GLPROPFNS
GETPROP
ASSOC
GLCOMPPROPL
(((PROP) (ADJ) (ISA) (MSG)) . 0)
COPY
PUTPROP
RPLACD
(CONS CONSNL KT ASZ SKA KNIL ENTERF)  0             @   `   p % H    0   p      

GLCOMPPROPL BINARY
     h    V    e-.           V@  X  0,~   Z   ,<   Z   ,<  Z   F  [XB   3B   +   &[  Z  -,   +   [  [  ,<   ,<  [$  \3B   +   [  	Z  ,<   ,<   Z  ,   ,<   ,<   ,<   *  \XB   +   *[  Z  ,<   [  Z  ,<   ,<   $  ],   XB  +   *,<  ]Z  ,<   ,   ,<   Z  ,<   Z  F  ^XB  3B   +   *,<  ^Z  ],   ,<   Z  ,<   ,<   $  _,   ,<   [   Z  ,   XB  #+   *Z  B  _XB   3B   +   )+   2Z   ,~   Z  %,<   ,<   $  _,<   [  *Z  2B   +   1[  [  ,<   ,<  `$  \,   ,~   Z  '2B   +   4+   )Z  2,<   Z  ,<   Z  F  `XB   3B   +   UZ  7-,   +   >,<  `,<  aZ  5,<   ,<  a,   D  b+   )Z  4,<   Z  &,<   ,<   &  bXB      cXB   Z  A,<  D  c,<  ^Z  BZ  8[  Z  [  ,   ,<   ,<  dZ  E[  Z  Z  ,<   Z  B,   ,   ,<   ,<  dZ  H[  [  Z  ,   ,   ,   ,<   ,<   $  _,<   [  MZ  ,   ,~   [  >XB  U+   2D4   N
0!$r`Q@@ @     (VARIABLE-VALUE-CELL STR . 126)
(VARIABLE-VALUE-CELL PROPNAME . 118)
(VARIABLE-VALUE-CELL PROPTYPE . 108)
(NIL VARIABLE-VALUE-CELL CODE . 89)
(NIL VARIABLE-VALUE-CELL MSGL . 93)
(NIL VARIABLE-VALUE-CELL TRANS . 171)
(NIL VARIABLE-VALUE-CELL TMP . 166)
(NIL VARIABLE-VALUE-CELL FETCHCODE . 150)
(NIL VARIABLE-VALUE-CELL NEWVAR . 137)
GLSTRPROP
OPEN
LISTGET
GLCOMPOPEN
GLRESULTTYPE
self
GLADJ
LAMBDA
GLUNWRAP
GLTRANSPARENTTYPES
RESULT
GLCOMPPROPL
"GLISP cannot currently
handle inheritance of the property"
"which is specified as a function name
in a TRANSPARENT subtype.  Sorry."
GLERROR
GLSTRFN
GLMKVAR
GLSTRVAL
PROG
RETURN
(CONS LIST3 ALIST3 LIST2 ALIST2 CONSNL KT SKA KNIL ENTERF)   	    X   
 Q 8   0   
P P 	H 2 X     M      R @ " x     	    A  3 h *   p     x      

GLCONST? BINARY
                -.           Z   2B   +   Z   ,~   3B   7   7   +   Z  -,   +   -,   +   Z  2B  +   [  Z  -,   7   7   +   Z  
-,   +   ,<   ,<  $  ,~   Z   ,~   VX     (VARIABLE-VALUE-CELL X . 26)
QUOTE
GLISPCONSTANTFLG
GETPROP
(SKA SKNA SKLST SKNNM KT KNIL ENTERF)                     X   @      `        

GLCONSTSTR? BINARY
               -.           Z   B  2B   +   Z  -,   +   Z  3B  7   7   +   Z  ,<   ,<  $  3B   +   [  Z  -,   +   [  
Z  Z  2B  +   Z  3B  +   Z   ,~   [  [  2B   +   Z   ,~   [  [  Z  2B   +   7   Z   ,~   Z   ,~   Z   ,~   Ml   (VARIABLE-VALUE-CELL X . 41)
GLCONST?
QUOTE
((COPY APPEND) . 0)
MEMB
APPEND
(KT SKLST KNIL ENTERF)            P   (    8 
  x        

GLCONSTVAL BINARY
        &    !    %-.           !Z   3B   +   3B   +   -,   +   ,~   -,   +   	Z  2B  !+   	[  Z  ,~   Z  -,   +   Z  	,<   ,<  "$  "3B   +   [  Z  -,   +   [  Z  Z  2B  !+   [  [  3B   +   [  [  Z  2B   +   [  Z  [  Z  ,~   Z  -,   +    ,<   ,<  #$  #3B   +    Z  ,<   ,<  $$  #,~      $,~   R`MD&@     (VARIABLE-VALUE-CELL X . 59)
QUOTE
((COPY APPEND) . 0)
MEMB
GLISPCONSTANTFLG
GETPROP
GLISPCONSTANTVAL
ERROR
(SKA SKLST SKNM KT KNIL ENTERF)       0              p  `        

GLCP BINARY
            -.          Z   2B   +   Z   XB  B  2B   +   Z  B  ,<  "     ,~   Z  B  Z  B  ,~   +e  (VARIABLE-VALUE-CELL FN . 19)
(VARIABLE-VALUE-CELL GLLASTFNCOMPILED . 6)
GLGETD
PRIN1
" ?"
TERPRI
GLCOMPILE
GLP
(KNIL ENTERF)    X        

GLDECL BINARY
          q   -.     (      q@  t  P,~   Z   2B   +   
Z   3B   +   ,<   ,<  yZ   B  yF  zZ   B  y,~   Z  ,<   [  
XB  ,\   XB   -,   +   +   QZ   XB   Z   XB   Z  B  z   {XB      {XB   Z  2B  {+   'Z  2B   +    Z   3B   +   mZ  3B   +   mZ  B  |3B   +   m   |,<   Z  ,<   [  XB  ,\   D  }+   Z  3B   +   mZ  B  |3B   +   m   {2B   +   m   |,<   Z  !D  }+   Z  ,<   Z  ,   D  }XB  'Z  &2B   +   ,+   F2B  {+   ;   {XB   3B   +   4B  |3B   +   4   {2B   +   4Z  .XB  +   FZ  22B   +   mZ  B  |3B   +   mZ  5,<   [  7XB  8,\   XB  3+   F2B  ~+   m   {XB  (3B   +   ?   {XB  *+   'Z  9-,   +   FZ  ?,<   [  AXB  B,\   B  z   {XB  <   {XB  >+   'Z  *,<   Zp  -,   +   I+   PZp  ,<   @  ~   +   NZ   ,<   Z  :D  },~   [p  XBp  +   G/   +   Z  B  3B   +   YZ   3B   +   YZ  QB  |3B   +   Y   |,<   Z  TD  }+   Z   3B   +   mZ  WB  2B   +   mZ  Z-,   +   m[  \3B   +   m[  ^XB   ,<   Z   ,<  ,<   &  XB   Z  `3B   +   e+   mZ  _,<   ,<   [  cZ  ,<   Z  aH  Z  e,<   Z  g,   Z  ,   XB  k+   ,<  ,< Z  B,<   ,   D Z   ,~   %4A&$V3>6IP4AT2D*JfTH`         (VARIABLE-VALUE-CELL LST . 221)
(VARIABLE-VALUE-CELL NOVAROK . 166)
(VARIABLE-VALUE-CELL VALOK . 178)
(VARIABLE-VALUE-CELL GLTOPCTX . 209)
(VARIABLE-VALUE-CELL FN . 9)
(NIL VARIABLE-VALUE-CELL RESULT . 217)
(NIL VARIABLE-VALUE-CELL FIRST . 137)
(NIL VARIABLE-VALUE-CELL SECOND . 139)
(NIL VARIABLE-VALUE-CELL THIRD . 104)
(NIL VARIABLE-VALUE-CELL TOP . 211)
(NIL VARIABLE-VALUE-CELL TMP . 213)
(NIL VARIABLE-VALUE-CELL EXPR . 199)
(NIL VARIABLE-VALUE-CELL VARS . 141)
(NIL VARIABLE-VALUE-CELL STR . 154)
(NIL VARIABLE-VALUE-CELL ARGTYPES . 14)
GLARGUMENTTYPES
DREVERSE
PUTPROP
GLSEPINIT
GLSEPNXT
:
GLOKSTR?
GLMKVAR
GLDECLDS
NCONC
,
(VARIABLE-VALUE-CELL X . 152)
GL-A-AN?
GLDOEXPR
GLADDSTR
GLDECL
"Bad argument structure"
GLERROR
(LIST2 CONS ALIST2 KT BHC SKNLST SKA CONSNL SKNA KNIL ENTERF)      P   @   0   
   	   ` A    *        q x e  _ H Z 
h T 
0 > x 5 ( 1 x , P #     h  x   H      

GLDECLDS BINARY
                -.           Z   3B   +   Z   ,<  D  XB  Z   Z   ,   XB  Z  Z   ,   XB  Z  ,<  ,<   Z  ,<  Z   H  Z   ,~      (VARIABLE-VALUE-CELL ATM . 18)
(VARIABLE-VALUE-CELL STR . 21)
(VARIABLE-VALUE-CELL GLTYPESUBS . 3)
(VARIABLE-VALUE-CELL RESULT . 13)
(VARIABLE-VALUE-CELL ARGTYPES . 17)
(VARIABLE-VALUE-CELL GLTOPCTX . 23)
GLSUBSTTYPE
GLADDSTR
(CONS KNIL ENTERF)  	  p   X   0      

GLDEFFNRESULTTYPES BINARY
                -.           Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   [   Z  ,<   Zp  -,   +   +    Zp  ,<   @     +   Z   ,<   ,<  Z  F  ,~   [p  XBp  +   	[p  XBp  +   BA
(    (VARIABLE-VALUE-CELL LST . 3)
(VARIABLE-VALUE-CELL X . 30)
(VARIABLE-VALUE-CELL Y . 27)
GLRESULTTYPE
PUTPROP
(URET1 KNIL SKNLST ENTERF) 8         
  @      

GLDEFFNRESULTTYPEFNS BINARY
              -.           Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   
Z   ,<   ,<  [  F  ,~   [p  XBp  +   BJ (VARIABLE-VALUE-CELL LST . 3)
(VARIABLE-VALUE-CELL X . 18)
GLRESULTTYPEFN
PUTPROP
(URET1 KNIL SKNLST ENTERF)                 

GLDEFPROP BINARY
    .    $    --.           $@  &  ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @  &   +   Z   2B  '+   Z   -,   +   Z  
-,   +   Z  -,   +   [  2B   +   ,<  '"  (Z   B  (,<  ("  (Z  B  (,<  )"  (Z  B  (,<  )"  (   *,<  *"  (   *,~   Z  Z   ,   XB  ,~   [p  XBp  +   /   Z  ,<   ,<  +$  +,<   Z  ,<   Z  B  ,,   D  ,Z   ,~   V$Nn #     (VARIABLE-VALUE-CELL OBJECT . 60)
(VARIABLE-VALUE-CELL PROP . 65)
(VARIABLE-VALUE-CELL LST . 6)
(NIL VARIABLE-VALUE-CELL LSTP . 67)
(VARIABLE-VALUE-CELL X . 51)
SUPERS
"GLDEFPROP: For object "
PRIN1
" the "
" property "
" has bad form."
TERPRI
"This property was ignored."
GLSTRUCTURE
GETPROP
DREVERSE
NCONC
(ALIST2 BHC CONS KNIL SKA SKLST SKNA SKNLST ENTERF)   #            $     h   P   8    X      

GLDEFSTR BINARY
        B    4    @-.           4@  5  ,~   Z   ,<   [  XB  ,\   XB   Z  ,<   [  XB  ,\   XB   Z  ,<  ,<  6,   F  6Z  B  72B   +   Z  	B  7,<  8"  7   8Z  2B   +   Z   ,~   Z  3B  9+   3B  9+   2B  :+   Z  ,<   ,<  9[  Z  F  :+   23B  ;+   3B  ;+   2B  <+    Z  ,<   ,<  ;[  Z  F  :+   23B  <+   %3B  =+   %3B  =+   %3B  >+   %2B  >+   (Z  ,<   ,<  <[  Z  F  :+   23B  ?+   +3B  ?+   +2B  @+   /Z  %,<   ,<  ?[  &Z  F  :+   2Z  +,<   Z  -,<   [  0Z  F  :[  1[  XB  2+    *yIdI@D     (VARIABLE-VALUE-CELL LST . 103)
(NIL VARIABLE-VALUE-CELL STRNAME . 94)
(NIL VARIABLE-VALUE-CELL STR . 23)
GLSTRUCTURE
PUTPROP
GLOKSTR?
PRIN1
" has faulty structure specification."
TERPRI
ADJ
Adj
adj
GLDEFPROP
PROP
Prop
prop
ISA
Isa
IsA
isA
isa
MSG
Msg
msg
(KNIL CONSNL ENTERF) (  X   8      

GLDEFSTRNAMES BINARY
                -.         Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   @    ,~   Z   ,<   Z   D  XB   3B   +   ,<   [  	D  ,~   Z  
,<  Z  ,   D  XB  ,~   [p  XBp  +   B`I    (VARIABLE-VALUE-CELL LST . 3)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 34)
(VARIABLE-VALUE-CELL X . 31)
(NIL VARIABLE-VALUE-CELL TMP . 22)
ASSOC
RPLACD
NCONC
(CONSNL URET1 KNIL SKNLST ENTERF)     X   H            

GLDEFSTRQ BINARY
        
    -.          
Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   	Z   B  ,~   [p  XBp  +   BQ  (VARIABLE-VALUE-CELL ARGS . 3)
(VARIABLE-VALUE-CELL ARG . 15)
GLDEFSTR
(URET1 KNIL SKNLST ENTERF)  X    P    @      

GLDEFUNITPKG BINARY
            -.          @    ,~   Z   XB   Z  2B   +   	Z  ,<  Z   ,   D  XB  Z   ,~   Z  Z  Z  2B  +   Z  	,<   Z  
D  [  XB  +    (VARIABLE-VALUE-CELL UNITREC . 26)
(VARIABLE-VALUE-CELL GLUNITPKGS . 16)
(NIL VARIABLE-VALUE-CELL LST . 29)
NCONC
RPLACA
(CONSNL KNIL ENTERF)       	  X      

GLDELDEF BINARY
                -.           Z   ,<   ,<  $  ,~       (VARIABLE-VALUE-CELL NAME . 3)
(VARIABLE-VALUE-CELL TYPE . 0)
GLSTRUCTURE
REMPROP
(ENTERF)     

GLDESCENDANTP BINARY
                -.           @    ,~   Z   Z   2B  +   Z   ,~   B  XB   Z  2B   +   	Z   ,~   Z  ,<   Z  D  3B   +   +   [  	XB  +   ,@(VARIABLE-VALUE-CELL SUBCLASS . 6)
(VARIABLE-VALUE-CELL CLASS . 21)
(NIL VARIABLE-VALUE-CELL SUPERS . 27)
GLGETSUPERS
GLDESCENDANTP
(KNIL KT ENTERF)   H 	     `      

GLDOA BINARY
              -.           @    ,~   [   Z  XB   B  3B   +   	Z  ,<   [  [  D  ,~   Z  B  XB   3B   +   ,<  [  
[  Z  D  XB   3B   +   [  ,<   Z  ,<    "   ,   ,~   ,<  ,<  Z  	,<   ,<  ,   D  Z   ,~   1    (VARIABLE-VALUE-CELL EXPR . 33)
(NIL VARIABLE-VALUE-CELL TYPE . 40)
(NIL VARIABLE-VALUE-CELL UNITREC . 24)
(NIL VARIABLE-VALUE-CELL TMP . 31)
GLGETSTR
GLMAKESTR
GLUNIT?
A
ASSOC
GLDOA
"The type"
"is not defined."
GLERROR
(LIST3 EVCC KNIL ENTERF)           x   `      

GLDOCASE BINARY
        f    X    c-.          X@  Y  @,~   Z   XB   [   Z  ,   ,<   ,<   Z   ,<   ,<   (  ]XB   Z  XB   [  	Z  XB   [  [  XB  Z  ,<   ,<  ^$  ^3B   +   [  XB  Z  2B   +   Z  	,<  Z   ,<  Z   ,   D  _,   Z  _,   B  `,<   Z   ,<   ,   ,~   Z  ,<   ,<  `$  ^3B   +   '[  ,<   Z  D  aXB  
Z  [  3B   +   $Z  aZ   ,   +   %Z  "Z  XB  Z   XB  +   MZ  &[  ,<   Z  D  aXB  $Z  ,<  Z  'Z  -,   +   5Z  ,<   ,<  bZ  +Z  F  bXB   3B   +   3[  0Z  2B   +   JZ  .Z  +   JZ  3Z  ,<   ,<   Zw-,   +   =Zp  Z   2B   +   ; "  +   =[  QD   "  +   JZw,<   @  c   +   GZ  -,<   ,<  bZ   F  bXB  13B   +   F[  BZ  2B   +   FZ  A,~   Zp  ,   XBp  [wXBw+   7/  Z  ),   ,   D  _XB  *Z  3B   +   WZ  2B   +   R[  JZ  XB  N+   WZ  Q[  PZ  ,   2B   +   WZ   XB  MZ   XB  R[  5XB  W+     h@T"	(J)""     (VARIABLE-VALUE-CELL EXPR . 175)
(VARIABLE-VALUE-CELL CONTEXT . 81)
(NIL VARIABLE-VALUE-CELL SELECTOR . 37)
(NIL VARIABLE-VALUE-CELL SELECTORTYPE . 128)
(NIL VARIABLE-VALUE-CELL RESULT . 153)
(NIL VARIABLE-VALUE-CELL TMP . 165)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 173)
(NIL VARIABLE-VALUE-CELL TYPEOK . 171)
(NIL VARIABLE-VALUE-CELL ELSECLAUSE . 74)
(NIL VARIABLE-VALUE-CELL TMPB . 136)
GLPUSHEXPR
((OF Of of) . 0)
MEMB
NCONC
SELECTQ
GLGENCODE
((ELSE Else else) . 0)
GLPROGN
PROGN
VALUES
GLSTRPROP
(VARIABLE-VALUE-CELL X . 140)
(EQUAL BHC COLLCT SKNLST SKA CONS LIST2 CONS21 CONSS1 KNIL CONSNL KT ENTERF)   
H   	0   	      P   	@ $                W 
` U 
  N ` D ( : x 3  &    (   p   	H   `           

GLDOCOND BINARY
     -    &    +-.          &@  '   ,~   Z   XB   [   XB  2B   +   +   Z  ,<   Z   D  )XB   Z  Z  3B   +   Z   ,<   Z  	,   D  *XB  Z  3B   +   Z   2B   +   [  Z  XB  +   Z  [  Z  ,   2B   +   Z   XB  Z   XB  Z  Z  3B   +   +   [  2B   +    Z  Z  2B   +    Z  *Z  [  ,   +   "Z  +Z  ,   ,<   Z  3B   +   %Z  +   %Z   ,   ,~   B @2`     (VARIABLE-VALUE-CELL CONDEXPR . 13)
(VARIABLE-VALUE-CELL CONTEXT . 15)
(NIL VARIABLE-VALUE-CELL RESULT . 66)
(NIL VARIABLE-VALUE-CELL TMP . 48)
(NIL VARIABLE-VALUE-CELL TYPEOK . 69)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 72)
GLPROGN
NCONC
PROGN
COND
(ALIST2 CONS EQUAL CONSNL KNIL KT ENTERF) h   (              & @     `  x   `   `   @      

GLDOEXPR BINARY
       \   #   V-.         #@ &  ,~   Z   Z   ,   XB  Z  -,   +   	,< 'Z (,   D (+  !Z   2B   +   Z  -,   +   Z  
,<   [  XB  ,\   ,<   ,< ),   XB   +  !Z  -,   +   Z  	2B   +   +   Z   2B )+   Z  2B *+   Z  ,<   ,<   ,   XB  +  !Z  ,<   ,< *$ +3B   +   Z  XB   +   =Z  B +  ,XB  Z  3B  +   0Z  !,<   ,< ,$ +2B   +   -Z  "B -2B   +   -Z  %,<   ,< -$ .2B   +   -Z   3B .+   /B /3B   +   /  /Z  'XB  *+   =  /+   Z  .3B .+   32B 0+   4  /+   [  .-,   +   =[  4Z  -,   +   8+   =[  5Z  B +  ,XB     /Z  :B /3B   +   =+   Z  03B 0+   D3B 1+   D3B 1+   D3B 2+   D3B 2+   D2B 3+   LZ  8,<  [  DZ  -,   +   HZ 3+   K[  EZ  -,   +   KZ )+   KZ   ,   +  3B 4+   O3B 4+   O2B 5+   RZ  H,<  Z   D 5+  3B 6+   U3B 6+   U2B 7+   WZ  O,<  ,< 7,   +  3B 8+   Z3B 8+   Z2B 9+   \Z  UB 9+  3B :+   _3B :+   _2B ;+   `Z  ZB ;+  3B <+   c3B <+   c2B =+   eZ  _B =+  3B >+   h3B >+   h2B ?+   iZ  cB ?+  3B @+   l3B @+   l2B A+   nZ  hB A+  3B B+   q3B B+   q2B C+   rZ  lB C+  3B D+   u3B D+   u2B E+   xZ  q,<  Z  PD E+  3B F+   }3B F+   }3B G+   }3B G+   }2B H+   ~Z  uB H+  3B I+  3B I+  3B J+  2B J+  Z  }B K+  3B K+  2B L+  Z B L+  2B M+  Z ,<  Z  vD M+  3B N+  2B N+  Z ,<  Z 	D O+  3B O+  3B P+  2B P+  Z ,<  Z D Q+  3B Q+  3B R+  2B R+  Z B S+  3B S+  3B T+  2B T+  Z B U+  Z B UXB  +  !  VXB [  XB !Z  ,~   YMX%DUv;yU_?G|__w}?_w|?~ooc|?o{,               (VARIABLE-VALUE-CELL START . 37)
(VARIABLE-VALUE-CELL CONTEXT . 295)
(VARIABLE-VALUE-CELL VALBUSY . 0)
(VARIABLE-VALUE-CELL EXPR . 316)
(VARIABLE-VALUE-CELL EXPRSTACK . 323)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 41)
(NIL VARIABLE-VALUE-CELL FIRST . 123)
(NIL VARIABLE-VALUE-CELL TMP . 118)
(NIL VARIABLE-VALUE-CELL RESULT . 324)
GLDOEXPR
"Expression is not a list."
GLERROR
STRING
INTERLISP
*
((QUOTE Quote quote) . 0)
MEMB
GLSEPINIT
GLSEPNXT
((APPLY* BLKAPPLY* PACK* PP*) . 0)
GETD
MACRO
GETPROP
~
GLOPERATOR?
GLSEPCLR
-
QUOTE
Quote
quote
GO
Go
go
ATOM
PROG
Prog
prog
GLDOPROG
FUNCTION
Function
function
LISP
SETQ
Setq
setq
GLDOSETQ
COND
Cond
cond
GLDOCOND
RETURN
Return
return
GLDORETURN
FOR
For
for
GLDOFOR
THE
The
the
GLDOTHE
THOSE
Those
those
GLDOTHOSE
IF
If
if
GLDOIF
A
a
AN
An
an
GLDOA
_
SEND
Send
send
GLDOSEND
PROGN
PROG2
GLDOPROGN
PROG1
GLDOPROG1
SELECTQ
CASEQ
GLDOSELECTQ
WHILE
While
while
GLDOWHILE
REPEAT
Repeat
repeat
GLDOREPEAT
CASE
Case
case
GLDOCASE
GLUSERFN
GLPARSEXPR
(ALIST2 SKA SKNLA SKLST SKLA LIST2 SKSTP KNIL CONSNL SKNLST CONS ENTERF)   L    G    7    5        W       J @   	@ = X * x % X  @ 
                   

GLDOFOR BINARY
         l    }-.          l@  m  P,~   Z   XB   Z  ,<   [  XB  ,\   Z  ,<   ,<  r$  s3B   +   Z   XB   Z  ,<   [  
XB  ,\   +   Z  -,   +   k[  Z  ,<   ,<  s$  s3B   +   kZ  ,<   [  XB  ,\   XB   Z  ,<   [  XB  ,\   Z  
B  tXB   2B   +   +   k[  Z  B  tXB   3B   +   2B  u+    Z  uXB  +   &Z  3B  v+   &Z   B  vB  tXB  "Z  3B  v+   &+   kZ   Z   ,   XB   Z  2B   +   *   wXB  (,<   Z  3B   +   -Z   +   .Z   ,<   [  #Z  ,<   Z  'H  wZ  ,<   ,<  x$  s3B   +   =Z  1,<   [  4XB  5,\   Z  *,<   [  .Z  ,   ,<   Z  0,<   ,<   ,<   (  xXB   +   HZ  5,<   ,<  y$  s3B   +   HZ  =,<   [  @XB  A,\   Z  6,<   [  7Z  ,   ,<   Z  9,<   ,<   ,<   (  xXB  <Z  A3B   +   TZ  H,<   ,<  y$  s3B   +   TZ  J,<   [  MXB  N,\   Z  H,<   ,<   Z  E,<  ,<   &  zD  zXB  OZ  N,<   ,<  {$  s3B   +   ]Z  T,<   [  WXB  X,\   ,<   Z  Q,<   ,<   &  zXB   +   eZ  X,<   ,<  {$  s3B   +   bZ  ],<   [  `XB  a,\   Z  a,<   Z  ZD  |Z  XB   Z  B,<   Z  ,<  Z  e,<  Z  S,<  Z  \J  |,~   Z  B  },~    4#@[8h   	P c 
4      (VARIABLE-VALUE-CELL EXPR . 197)
(VARIABLE-VALUE-CELL CONTEXT . 77)
(NIL VARIABLE-VALUE-CELL DOMAIN . 205)
(NIL VARIABLE-VALUE-CELL DOMAINNAME . 89)
(NIL VARIABLE-VALUE-CELL DTYPE . 135)
(NIL VARIABLE-VALUE-CELL ORIGEXPR . 214)
(NIL VARIABLE-VALUE-CELL LOOPVAR . 203)
(NIL VARIABLE-VALUE-CELL NEWCONTEXT . 199)
(NIL VARIABLE-VALUE-CELL LOOPCONTENTS . 207)
(NIL VARIABLE-VALUE-CELL SINGFLAG . 86)
(NIL VARIABLE-VALUE-CELL LOOPCOND . 209)
(NIL VARIABLE-VALUE-CELL COLLECTCODE . 211)
((EACH Each each) . 0)
MEMB
((IN In in) . 0)
GLDOMAIN
GLXTRTYPE
ANYTHING
((LISTOF ANYTHING) . 0)
LISTOF
GLGETSTR
GLMKVAR
GLADDSTR
((WITH With with) . 0)
GLPREDICATE
((WHICH Which which WHO Who who THAT That that) . 0)
((when When WHEN) . 0)
GLDOEXPR
GLANDFN
((collect Collect COLLECT) . 0)
((DO Do do) . 0)
GLPROGN
GLMAKEFORLOOP
GLUSERFN
(ALIST2 CONS SKA KT KNIL ENTERF) X 9    (        \ 
0 H x 
    ` ( W 
 M 	  @ @ ; @ . H ) p  (        

GLDOIF BINARY
     D    8    B-.           8@  9  0,~   Z   XB   Z   ,<   [  XB  ,\   Z  2B   +   Z  <Z   ,   ,<   Z   ,<   ,   ,~   Z   Z  ,   XB  ,<   ,<   ,<   ,<   (  =XB   Z  ,<   ,<  =$  >3B   +   Z  ,<   [  XB  ,\   Z  ,   XB   [  Z  XB  
Z  ,<   Z  ,   D  >XB  Z  2B   +   +   Z  ,<   ,<  ?$  >3B   +   $Z  ,<   [  !XB  ",\   +   Z  #,<   ,<  ?$  >3B   +   -Z  $,<   [  'XB  (,\   Z   ,   XB  Z  @XB  +   ,<   Z  ,<   ,<   &  @XB   3B   +   5Z  +,<  Z  /,   D  >[  2Z  XB  ,+   ,<  AZ  A,   D  BZ   ,~    0 h PM ($P    (VARIABLE-VALUE-CELL EXPR . 82)
(VARIABLE-VALUE-CELL CONTEXT . 91)
(NIL VARIABLE-VALUE-CELL PRED . 48)
(NIL VARIABLE-VALUE-CELL ACTIONS . 98)
(NIL VARIABLE-VALUE-CELL CONDLIST . 56)
(NIL VARIABLE-VALUE-CELL TYPE . 105)
(NIL VARIABLE-VALUE-CELL TMP . 103)
(NIL VARIABLE-VALUE-CELL OLDCONTEXT . 25)
COND
GLPREDICATE
((THEN Then then) . 0)
MEMB
NCONC
((ELSEIF ElseIf Elseif elseIf elseif) . 0)
((ELSE Else else) . 0)
BOOLEAN
GLDOEXPR
GLDOIF
"IF statement contains bad code."
GLERROR
(CONSNL KT LIST2 CONS KNIL ENTERF)  x 3 8      x +    @   ` 
    8  . x ! `     P        

GLDOLAMBDA BINARY
                -.           @    ,~   [   Z  XB   Z   Z   ,   XB  Z  3B   +   Z  ,<   ,<   Z   ,<   Z  H  [  XB  [  	XB  +   Z   XB   [  [  ,<   Z  
D  XB   [  Z  Z  ,   Z  ,   ,<   [  Z  ,   ,~     !    (VARIABLE-VALUE-CELL EXPR . 36)
(VARIABLE-VALUE-CELL ARGTYPES . 26)
(VARIABLE-VALUE-CELL CONTEXT . 33)
(NIL VARIABLE-VALUE-CELL ARGS . 24)
(NIL VARIABLE-VALUE-CELL NEWEXPR . 43)
(NIL VARIABLE-VALUE-CELL VALBUSY . 29)
GLADDSTR
GLPROGN
LAMBDA
(ALIST2 CONS21 KT CONS KNIL ENTERF) x   X   p   H     
          

GLDOMAIN BINARY
     /    %    --.          %@  '  ,~   Z   Z  (,   3B   +   Z  XB   ,<   "  ),~   Z  -,   +   "Z  B  )   *XB   Z  	2B  +   Z  ,<   [  XB  ,\   Z  XB   Z   3B   +   Z  Z  *,   3B   +   Z  +XB  Z  B  +Z  ,   XB  ,<   "  ),~   Z  B  +,<   ,<   $  ,,~   Z  ,<  ,<   $  ,,~      ,,<   Z   ,<   ,<   &  -,~   ,<   Z   ,<   ,<   &  -,~   HED &!
     (VARIABLE-VALUE-CELL SINGFLAG . 33)
(VARIABLE-VALUE-CELL EXPR . 47)
(VARIABLE-VALUE-CELL DOMAINNAME . 32)
(VARIABLE-VALUE-CELL CONTEXT . 70)
(NIL VARIABLE-VALUE-CELL NAME . 57)
(NIL VARIABLE-VALUE-CELL FIRST . 42)
((THE The the) . 0)
GLPARSFLD
GLSEPINIT
GLSEPNXT
((OF Of of) . 0)
THE
GLPLURAL
GLIDNAME
GLSEPCLR
GLDOEXPR
(KT CONS SKA KNIL FMEMB ENTERF)  %            8   h        X   @        

GLDOMSG BINARY
      i    X    f-.          X@  Z  0,~   [   Z  B  ]XB   ,<   ,<  ]Z   F  ^XB   3B   +   %[  [  ,<   ,<  ^$  _3B   +    Z  ,<   Z  ,<   Z   ,<  ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ZwZ  Zp  ,   XBp  [wXBw+   /  ,   ,   Z  _,   ,<   [  [  ,<   ,<  `$  _,   ,~   Z  ,<   Z  ,<  Z  ,<  Z   H  `,~   Z  B  aXB   3B   +   1,<  ][  &[  Z  D  aXB   3B   +   1[  *,<   Z   ,<   Z  ,<  Z  ",<   "  ,   ,~   [  ,Z  B  bXB   2B   +   DZ  %Z  b,   3B   +   CZ  -Z  c,   3B   +   CZ  .3B   +   C[  92B   +   CZ  :[  Z  B  ]Z  c,   3B   +   CZ  6,<   Z  1,<  Z  <F  d,~   Z   ,~   Z  22B   +   F+   C,<  dZ  DB  ],   ,<   Z  @,<   Z  BF  eXB  +3B   +   UZ  G,<   [  AZ  ,<   ,<   &  eXB   Z  K,<  Z  PD  fZ  P,<   Z  MD  fZ  R,~   [  TXB  U3B   +   C+   D%P(@" ID@ JR$2 !     (VARIABLE-VALUE-CELL OBJECT . 167)
(VARIABLE-VALUE-CELL SELECTOR . 146)
(VARIABLE-VALUE-CELL ARGS . 148)
(VARIABLE-VALUE-CELL CONTEXT . 71)
(NIL VARIABLE-VALUE-CELL UNITREC . 80)
(NIL VARIABLE-VALUE-CELL TYPE . 104)
(NIL VARIABLE-VALUE-CELL TMP . 172)
(NIL VARIABLE-VALUE-CELL METHOD . 67)
(NIL VARIABLE-VALUE-CELL TRANS . 153)
(NIL VARIABLE-VALUE-CELL FETCHCODE . 163)
GLXTRTYPE
MSG
GLSTRPROP
MESSAGE
LISTGET
SEND
RESULT
GLCOMPMSG
GLUNIT?
ASSOC
GLTRANSPARENTTYPES
((NUMBER REAL INTEGER) . 0)
((+ - * / ^ > < >= <=) . 0)
((NUMBER REAL INTEGER) . 0)
GLREDUCEARITH
*GL*
GLDOMSG
GLSTRFN
GLSTRVAL
(FMEMB EVCC ALIST2 CONS21 CONSS1 BHC COLLCT SKNLST KNIL ENTERF) x 8 `      	           8   0         
x P 	H F H @ @ :  6 @ + x  (  @        

GLDOPROG BINARY
     7    .    6-.           .@  /  0,~   Z   ,<   [  XB  ,\   Z   Z   ,   XB  Z  ,<   [  XB  ,\   ,<   ,<   ,<   Z  ,<   ,<   *  2XB   Z   Z  ,   XB  Z  	2B   +   +   'Z  ,<   [  XB  ,\   XB   -,   +   Z   ,   XB  +   -,   +   ,<  2,<  3,<   ,   D  3+   Z  2B  4+    Z  Z  ,   XB  +   Z  ,<   ,<   Z  ,<  ,<   (  4XB   3B   +   Z  #Z  ,   XB  %+   Z  ,<   Z  &B  5,   Z  5,   XB   ,<   Z   ,<  ,   ,~      Efa!
   (VARIABLE-VALUE-CELL EXPR . 39)
(VARIABLE-VALUE-CELL CONTEXT . 67)
(NIL VARIABLE-VALUE-CELL PROGLST . 79)
(NIL VARIABLE-VALUE-CELL NEWEXPR . 81)
(NIL VARIABLE-VALUE-CELL RESULT . 86)
(NIL VARIABLE-VALUE-CELL NEXTEXPR . 64)
(NIL VARIABLE-VALUE-CELL TMP . 74)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 88)
GLDECL
GLDOPROG
"PROG contains bad stuff:"
GLERROR
*
GLPUSHEXPR
DREVERSE
PROG
(CONS21 CONSS1 LIST2 SKNLST SKA KT CONS KNIL ENTERF)   +    *    . 8      `         ' x        % 8  p  8        

GLDOPROGN BINARY
        	    -.          	@  
  ,~   [   ,<   Z   D  XB   Z  Z  ,   ,<   [  Z  ,   ,~      (VARIABLE-VALUE-CELL EXPR . 11)
(VARIABLE-VALUE-CELL CONTEXT . 8)
(NIL VARIABLE-VALUE-CELL RES . 15)
GLPROGN
(ALIST2 CONS ENTERF)       x      

GLDOPROG1 BINARY
       "        !-.           @     ,~   [   XB  Z  2B   +   
Z   B  Z  ,   ,<   Z   ,<   ,   ,~   ,<   Z   ,<  Z   2B   +   7   Z   F  XB   3B   +   Z  Z  ,   XB  Z  2B   +   [  Z  XB  Z   XB  +   ,<   Z   ,   D  !Z  ,<   [  XB  ,\   +    H:  (VARIABLE-VALUE-CELL EXPR . 52)
(VARIABLE-VALUE-CELL CONTEXT . 21)
(NIL VARIABLE-VALUE-CELL RESULT . 35)
(NIL VARIABLE-VALUE-CELL TMP . 39)
(NIL VARIABLE-VALUE-CELL TYPE . 41)
(NIL VARIABLE-VALUE-CELL TYPEFLG . 43)
DREVERSE
PROG1
GLDOEXPR
GLDOPROG1
"PROG1 contains bad subexpression."
GLERROR
(CONSNL CONS KT LIST2 CONS21 KNIL ENTERF)            `           8  h  0        

GLDOREPEAT BINARY
        =    1    ;-.          1@  2  ,~   Z   ,<   [  XB  ,\   Z  ,<   ,<  3$  43B   +   Z  ,<   [  XB  	,\   +   Z  
3B   +   ,<   Z   ,<  ,<   &  4XB   3B   +   Z   ,<  Z  ,   D  5XB  +   Z  3B   +   ,<  5Z  6,   D  6,~   Z  3B   +    ,<   Z  ,<  ,<   ,<   (  7XB  3B   +    Z  3B   +   $,<  5Z  7,   D  6,<   ,<  8,   XB     8XB   ,<   Z  ,<  ,<  9Z  #B  9,<   ,<  :Z  $,<   ,   ,   ,   ,   D  5,   Z   ,   Z  :,   ,<   ,<   ,   ,~   P$t IjBP       (VARIABLE-VALUE-CELL EXPR . 61)
(VARIABLE-VALUE-CELL CONTEXT . 53)
(NIL VARIABLE-VALUE-CELL ACTIONS . 75)
(NIL VARIABLE-VALUE-CELL TMP . 78)
(NIL VARIABLE-VALUE-CELL LABEL . 82)
((UNTIL Until until) . 0)
MEMB
GLDOEXPR
NCONC
GLDOREPEAT
"REPEAT contains bad subexpression."
GLERROR
GLPREDICATE
"REPEAT contains no UNTIL or bad UNTIL clause"
BOOLEAN
GLMKLABEL
COND
GLBUILDNOT
GO
PROG
(CONS21 CONSS1 ALIST2 LIST2 CONSNL KT KNIL ENTERF)   / h   X   @ +    1 0 $    ,    8   0     0 `   h  H       P        

GLDORETURN BINARY
                -.          @    ,~   Z   ,<   [  XB  ,\   Z  2B   +   	,<   "  Z  ,~   ,<   Z   ,<  ,<   &  XB   [  Z  B  ,<  Z  ,   ,<   [  Z  ,   ,~   0#      (VARIABLE-VALUE-CELL EXPR . 11)
(VARIABLE-VALUE-CELL CONTEXT . 19)
(NIL VARIABLE-VALUE-CELL TMP . 31)
GLADDRESULTTYPE
(((RETURN) NIL) . 0)
GLDOEXPR
RETURN
(ALIST2 KT KNIL ENTERF)          
          

GLDOSELECTQ BINARY
       d    W    a-.           W@  X  8,~   Z   XB   [  Z  ,   ,<   ,<   Z   ,<   ,<   (  [Z  ,   XB   Z   XB   [  [  XB  Z  	-,   Z   XB   2B   +   Z  -,   +   7Z  Z  2B  \+   7Z  [  Z  XB  3B   +   7Z  ,<  Zp  -,   +   Z   +   )Zp  ,<   ,<w/   @  \   +   %Z   -,   +    Z  Z  ,   ,~   Z  -,   +   $Z  ,<   Z   D  ],~   Z   ,~   3B   +   'Zp  +   )[p  XBp  +   /   XB   3B   +   ,[  )2B   +   0Z  B  ],<   Z  D  ^XB   +   3Z  +[  ,<   Z  .D  ^XB  /Z  ^Z  2,   ,<   [  3Z  ,   ,~   Z  ,2B   +   =Z  Z  ,   B  _,<   Z   ,<   ,   ,~   Z  9,<  [  72B   +   AZ  82B  _+   FZ  >[  ,<   Z  1D  ^XB  0Z  AZ  Z  C,   +   J,<   Z  B,<  ,<   &  `XB  EZ  I,   D  `XB  =Z  
3B   +   UZ  ;2B   +   P[  IZ  XB  M+   UZ  O[  NZ  ,   2B   +   UZ   XB  KZ   XB  P[  DXB  U+   7  `BBHPP B"       (VARIABLE-VALUE-CELL EXPR . 172)
(VARIABLE-VALUE-CELL CONTEXT . 142)
(NIL VARIABLE-VALUE-CELL RESULT . 150)
(NIL VARIABLE-VALUE-CELL RESULTTYPE . 170)
(NIL VARIABLE-VALUE-CELL TYPEOK . 168)
(NIL VARIABLE-VALUE-CELL KEY . 68)
(NIL VARIABLE-VALUE-CELL TMP . 162)
(NIL VARIABLE-VALUE-CELL TMPB . 106)
(NIL VARIABLE-VALUE-CELL FN . 127)
GLPUSHEXPR
QUOTE
(VARIABLE-VALUE-CELL X . 70)
MEMBER
LAST
GLPROGN
PROGN
GLGENCODE
CASEQ
GLDOEXPR
NCONC
(LIST2 ALIST2 CONS EQUAL SKA BHC SKNLST SKLST SKNM KT KNIL CONSNL ENTERF)  P   p   h : P   
0          * @                I 0     U 
H S 	h M x ?  , 0 & X  `  h     K          

GLDOSEND BINARY
     C    8    A-.          8@  9  0,~   Z   XB   [  XB   Z  ,<   [  XB  ,\   ,   ,<   ,<   Z   ,<   ,<   (  <XB   Z  ,<   [  XB  ,\   XB   3B   +   -,   +   ,<  =,<   ,<  =,   D  >,~   Z  2B   +   .Z  ,<  Z  ,<  Z   F  >XB   3B   +   Z  ,~   Z  ,<  Z  ,<   Z  ,<   Z  ,<  ,<   Zw-,   +   %Zp  Z   2B   +   # "  +   %[  QD   "  +   )ZwZ  Zp  ,   XBp  [wXBw+   /  ,   ,   ,   B  ?,<   [  Z  ,   ,~   ,<   Z  	,<  ,<   &  ?XB  3B   +   5Z  ,<  ,   D  @XB  2+   ,<  =Z  @,   D  >Z   ,~     @"@ E EP    (VARIABLE-VALUE-CELL EXPRR . 8)
(VARIABLE-VALUE-CELL CONTEXT . 94)
(NIL VARIABLE-VALUE-CELL EXPR . 39)
(NIL VARIABLE-VALUE-CELL OBJECT . 89)
(NIL VARIABLE-VALUE-CELL SELECTOR . 57)
(NIL VARIABLE-VALUE-CELL ARGS . 105)
(NIL VARIABLE-VALUE-CELL TMP . 98)
(NIL VARIABLE-VALUE-CELL FNNAME . 53)
GLPUSHEXPR
GLDOSEND
"is an illegal message Selector."
GLERROR
GLDOMSG
GLGENCODE
GLDOEXPR
NCONC
"A message argument is bad."
(ALIST2 CONSS1 BHC COLLCT SKNLST LIST2 SKNLA KT KNIL CONSNL ENTERF)  h   @ + 0   (          0           8 ( / ( " x  P     x 4       

GLDOSETQ BINARY
                -.          @    ,~   Z   ,<   [  XB  ,\   Z  ,<   [  XB  ,\   XB   ,<   ,<   Z   ,<  ,<   &  D  ,~     0 (VARIABLE-VALUE-CELL EXPR . 14)
(VARIABLE-VALUE-CELL CONTEXT . 19)
(NIL VARIABLE-VALUE-CELL VAR . 16)
GLDOEXPR
GLDOVARSETQ
(KT KNIL ENTERF)  8          

GLDOTHE BINARY
        	    -.           	@  
  ,~   ,<   "  
XB   Z   3B   +   ,<  ,<  ,<   ,   D  Z  ,~   G  (VARIABLE-VALUE-CELL EXPR . 9)
(NIL VARIABLE-VALUE-CELL RESULT . 17)
GLTHE
GLDOTHE
"Stuff left over at end of The expression."
GLERROR
(LIST2 KNIL ENTERF)     `        

GLDOTHOSE BINARY
        
    -.           
@    ,~   [   XB  ,<   "  XB   Z  3B   +   	,<  ,<  ,<   ,   D  Z  ,~   d  (VARIABLE-VALUE-CELL EXPR . 11)
(NIL VARIABLE-VALUE-CELL RESULT . 19)
GLTHE
GLDOTHOSE
"Stuff left over at end of The expression."
GLERROR
(LIST2 KNIL KT ENTERF)   	               

GLDOVARSETQ BINARY
           	    -.           	Z   ,<   [   Z  D  
,<  
Z  ,<   Z  ,   ,<   [  Z  ,   ,~   `   (VARIABLE-VALUE-CELL VAR . 9)
(VARIABLE-VALUE-CELL RHS . 14)
GLUPDATEVARTYPE
SETQ
(ALIST2 ALIST3 ENTERF)       p      

GLDOWHILE BINARY
       5    +    3-.           +@  ,  ,~   Z   Z   ,   XB  Z   ,<   [  XB  ,\   ,<   Z  ,<   ,<   ,<   (  -Z  ,   XB   Z  ,<   ,<  .$  .3B   +   Z  ,<   [  XB  ,\   Z  3B   +   ,<   Z  ,<  ,<   &  /XB   3B   +   Z  ,<  Z  ,   D  /XB  +   Z  3B   +   !,<  0,<  0,<   ,   D  1Z  ,<   [  XB  ,\   +      1XB   ,<  2,<   ,<   ,<  2Z  ,<  ,<  3,<   ,   ,   D  /,   ,   ,<   ,<   ,   ,~     !SHH@   (VARIABLE-VALUE-CELL EXPR . 64)
(VARIABLE-VALUE-CELL CONTEXT . 39)
(NIL VARIABLE-VALUE-CELL ACTIONS . 73)
(NIL VARIABLE-VALUE-CELL TMP . 48)
(NIL VARIABLE-VALUE-CELL LABEL . 68)
GLPREDICATE
((DO Do do) . 0)
MEMB
GLDOEXPR
NCONC
GLDOWHILE
"Bad stuff in While statement:"
GLERROR
GLMKLABEL
PROG
COND
GO
(ALIST4 ALIST2 LIST2 CONSNL KT CONS KNIL ENTERF)       0 ' h      @   X 
        * @  p  0      @      

GLED BINARY
               -.           ,<  "  Z   ,~       (VARIABLE-VALUE-CELL FN . 5)
(((GETPROPLIST (OR FN GLLASTFNCOMPILED))) . 0)
EDITV
(ENTERF)      

GLEDS BINARY
              -.           ,<  "  Z   ,~       (VARIABLE-VALUE-CELL STR . 5)
(((GETPROP (SETQ GLLASTSTREDITED (OR STR GLLASTSTREDITED)) (QUOTE GLSTRUCTURE))) . 0)
EDITV
(ENTERF)      

GLEQUALFN BINARY
       1    (    0-.           (@  )  ,~   Z   ,<   ,<  )Z   ,   F  *XB   3B   +   ,~   Z  ,<  ,<  )Z  F  *XB  3B   +   ,~   Z  	2B   +   ,<  +Z  ,   +   &Z  2B   +   ,<  +Z  ,   +   &[  Z  3B  ++   [  Z  2B  ++   Z  ,+   #[  Z  3B  ,+   [  Z  2B  ,+   Z  -+   #[  Z  2B  -+   "[  Z  2B  -+   "Z  .+   #Z  .,<   Z  ,<   Z  ,   B  /,<   ,<  /,   ,~   $EI3f>
    (VARIABLE-VALUE-CELL LHS . 71)
(VARIABLE-VALUE-CELL RHS . 73)
(NIL VARIABLE-VALUE-CELL TMP . 21)
=
GLDOMSG
GLUSERSTROP
NULL
INTEGER
EQP
ATOM
EQ
STRING
STREQUAL
EQUAL
GLGENCODE
BOOLEAN
(LIST2 ALIST3 ALIST2 KNIL CONSNL ENTERF)     `   8      `   x    `      

GLERR BINARY
              -.          ,<  "  Z   B     ,~   @   (VARIABLE-VALUE-CELL ERREXP . 5)
"Execution of GLISP error expression: "
PRIN1
PRINT
ERROR
(ENTERF)     

GLERROR BINARY
    K    7    H-.           7,<  :"  :Z   B  :,<  ;"  :Z   B  ;Z   ,<   Zp  -,   +   +   Zp  ,<   @  <   +   Z   B  :,<  <"  =,~   [p  XBp  +   /      =,<  >"  :,<  >"  ?,<   @  ?  +   0,<  ?Z   ,<   ,   ,   Z   ,   XB  XB` ,<  A,<  B,<   @  B ` +   'Z   Z  DXB Z   ,<   ,<  D,<   ,<   (  E   =,<  E"  :[  Z  ,<   ,<  D,<   ,<   (  EZw~XB8 Z   ,~   2B   +   )Z  FXB   [` XB  ,<  ?Z` Z  [  D  FZ  (3B   +   /   G,~   Z` ,~      =Z   3B   +   2   F,<  G,<  HZ  !,   ,   ,<   ,<   ,   ,~   h2\/,U	q b	p          (VARIABLE-VALUE-CELL FN . 5)
(VARIABLE-VALUE-CELL MSGLST . 11)
(VARIABLE-VALUE-CELL FAULTFN . 9)
(VARIABLE-VALUE-CELL RESETVARSLST . 83)
(VARIABLE-VALUE-CELL EXPRSTACK . 103)
(VARIABLE-VALUE-CELL GLBREAKONERROR . 97)
"GLISP error detected by "
PRIN1
" in function "
PRINT
(VARIABLE-VALUE-CELL X . 22)
1
SPACES
TERPRI
"in expression: "
((2 . 20) . 0)
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 41)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 89)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
15
PRINTDEF
"within expr. "
ERROR
APPLY
ERROR!
GLERR
QUOTE
(ALIST2 KT CF KNIL CONS CONSNL LIST2 BHC SKNLST ENTERF)  5 P   p $           6   .   % (       p   p                

GLEXPANDPROGN BINARY
     @    :    >-.           :Z   ,<   Zp  -,   +   Z   +    ,<   @  :   +   8Z   -,   +   8Z  Z  Z  ;,   3B   +   Z  [  [  3B   +   Z  B  ;,<   [  D  <Z  ,<   Z  [  [  D  <Z  ,<   Z  [  Z  D  <,~   Z  Z  2B  =+   8Z  [  Z  2B   +   8Z  [  [  ,<   Zp  -,   +    Z   +   *Zp  ,<   ,<w/   @  =   +   &Z   -,   +   %7   Z   ,~   2B   +   (Z   +   *[p  XBp  +   /   3B   +   8Z  [  [  [  3B   +   4Z  +B  ;,<   [  .D  <Z  0,<   Z  1[  [  [  D  <Z  2,<   Z  4[  [  Z  D  <,~   [p  XBp  +   E!$#!$A$@   (VARIABLE-VALUE-CELL LST . 3)
(VARIABLE-VALUE-CELL X . 107)
((PROGN PROG2) . 0)
LAST
RPLACD
RPLACA
PROG
(VARIABLE-VALUE-CELL Y . 71)
(SKNA BHC KT FMEMB SKLST URET1 KNIL SKNLST ENTERF)   %    + (   `                  . 8 ( x & 8  8       @      

GLEXPENSIVE? BINARY
            -.           Z   -,   +   Z   ,~   -,   +      ,~   Z  Z  ,   3B   +   
[  Z  XB  +   Z  	2B  +   [  
[  2B   +   [  Z  XB  +   Z   ,~   1     (VARIABLE-VALUE-CELL EXPR . 30)
ERROR
((CDR CDDR CDDDR CDDDDR CAR CAAR CADR CAADR CADDR CADDDR) . 0)
PROG1
(KT FMEMB SKNLST KNIL SKA ENTERF)          P   `   @    0      

GLFINDVARINCTX BINARY
       
        
-.           Z   3B   +   Z   ,<  Z  D  	2B   +   [  XB  +   Z   ,~   @  (VARIABLE-VALUE-CELL VAR . 6)
(VARIABLE-VALUE-CELL CONTEXT . 13)
ASSOC
(KNIL ENTERF)    `        

GLFRANZLISPTRANSFM BINARY
     i    [    f-.           [@  \  ,~   Z   -,   +   Z  ,~   Z  Z  ],   3B   +   Z  ,<   [  [  Z  ,<   [  	Z  ,   XB  +   Z  Z  ],   3B   +   Z  ,<   [  Z  ,<   [  [  [  Z  ,<   [  [  Z  ,   XB  Z  Z  ^,   XB   Z  Z  ^7   [  Z  Z  1H  +   2D   +   XB   3B   +   #[  Z  [  ,   XB  !+   VZ  "Z  _,   3B   +   .[  #[  [  2B   +   .Z  %,<   [  (Z  ,<   [  )[  Z  ,<   ,<   ,   XB  *+   VZ  -Z  _,   3B   +   7[  .[  2B   +   7Z  1,<   [  3Z  ,<   ,<   ,   XB  4+   VZ  62B  `+   E,<  `[  7[  Z  -,   +   ?[  9[  Z  ,   /"   ,   +   B,<  a[  <[  Z  ,   ,<   [  @Z  ,   XB  B+   VZ  D2B  a+   TZ  E,<   ,<  b$  bZ  F,<   ,<  c$  cXB   [  JZ  2B   +   OZ  K,<   ,<   $  d+   VZ  M,<   ,<   [  OZ  ,   ,   D  d+   VZ  H2B  d+   VZ  TB  eZ  3B   +   Z,<  eZ  U,<  ,   ,~   Z  X,~   " H )@$  ,L@6L     (VARIABLE-VALUE-CELL X . 181)
(NIL VARIABLE-VALUE-CELL TMP . 162)
(NIL VARIABLE-VALUE-CELL NOTFLG . 173)
((MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON push PUSH GLSTRGREATERP ALPHORDER) . 0)
((PUTPROP) . 0)
((ALPHORDER GLSTRGEP NLISTP) . 0)
(((MEMB MEMQ) (FMEMB MEMQ) (FASSOC ASSQ) (LITATOM SYMBOLP) (GETPROP GET) (GETPROPLIST PLIST) (
IGREATERP >) (IGEQ >=) (GEQ >=) (ILESSP <) (ILEQ <=) (LEQ <=) (IPLUS +) (IDIFFERENCE -) (ITIMES *) (
IQUOTIENT /) (ADD1 1+) (SUB1 1-) (EQP =) (* COMMENT) (MAPCONC MAPCAN) (APPLY* FUNCALL) (DECLARE 
COMMENT) (NCHARS FLATC) (LISTP DTPR) (NLISTP DTPR) (UNPACK EXPLODE) (PACK READLIST) (STREQUAL EQUAL) (
GLSTRLESSP ALPHALESSP) (ALPHORDER ALPHALESSP) (GLSTRGREATERP ALPHALESSP) (GLSTRGEP ALPHALESSP) (
DREVERSE NREVERSE)) . 0)
((SOME EVERY) . 0)
((APPEND) . 0)
NTH
NTHCDR
1-
SELECTQ
CASEQ
RPLACA
2
NLEFT
RPLACD
PROG
GLTRANSPROG
not
(LIST2 CONSNL KT ALIST2 MKN IUNBOX SKI LIST3 LIST4 CONS ALIST4 ALIST3 KNIL FMEMB SKNLST ENTERF) (   
8   
   
0 B    ?    >    <    7    .    "        D P     O 	P 6 0 1 X ( X   h       %    x    H      

GLGENCODE BINARY
               -.          Z   2B  +   Z   B  ,~   2B  +   Z  B  ,~   2B  +   	Z  B  ,~   2B  +   Z  B  ,~   2B  +   Z  
B  ,~      ,~   Zk-      (VARIABLE-VALUE-CELL X . 26)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 3)
INTERLISP
GLINTERLISPTRANSFM
MACLISP
GLMACLISPTRANSFM
FRANZLISP
GLFRANZLISPTRANSFM
UCILISP
GLUCILISPTRANSFM
PSL
GLPSLTRANSFM
ERROR
(ENTERF)      

GLGETASSOC BINARY
                
-.           @  	  ,~   Z   ,<   Z   D  
XB   3B   +   [  ,~   Z   ,~      (VARIABLE-VALUE-CELL KEY . 6)
(VARIABLE-VALUE-CELL ALST . 8)
(NIL VARIABLE-VALUE-CELL TMP . 13)
ASSOC
(KNIL ENTERF)          

GLGETCONSTDEF BINARY
             -.           Z   ,<   ,<  $  3B   +   Z  ,<   ,<  $  3B   +   3B   +   -,   +   ,<  ,<   ,   ,<   Z  ,<   ,<  $  ,   ,~   Z   ,~   &V      (VARIABLE-VALUE-CELL ATM . 23)
GLISPCONSTANTFLG
GETPROP
GLISPCONSTANTVAL
QUOTE
GLISPCONSTANTTYPE
(ALIST2 LIST2 SKNNM KT KNIL ENTERF)   h   8         x   H      

GLGETD BINARY
             -.           Z   B  3B   +   
Z  ,<   ,<  $  2B  +   
Z  B  ,<  "  ,<  "     Z  B  ,~   ~@ (VARIABLE-VALUE-CELL FN . 20)
CCODEP
EXPR
UNSAVEDEF
PRIN1
1
SPACES
"unsaved."
TERPRI
GETD
(KNIL ENTERF)    8      

GLGETDB BINARY
            
-.           Z   B  2B  	+   Z  B  	2B   +   Z  ,<   ,<  	$  
,~   )@  (VARIABLE-VALUE-CELL FN . 11)
FNTYP
EXPR
GETD
GETPROP
(KNIL ENTERF)         

GLGETDEF BINARY
     	        -.           ,<  Z   ,<   ,<   ,<  $  ,   ,   ,~   `   (VARIABLE-VALUE-CELL NAME . 4)
(VARIABLE-VALUE-CELL TYPE . 0)
GLDEFSTRQ
GLSTRUCTURE
GETPROP
(ALIST2 CONSS1 ENTERF)   `    X      

GLGETFIELD BINARY
      _    R    \-.           R@  T  ,~   Z   2B   +   +   ;-,   +   ,,<   Z   D  UXB   3B   +   Z  ,<  Z   ,<  [  [  Z  ,<   ,<   (  VXB   3B   +   Z  ,~   ,<  V,<  WZ  
,<  ,<  WZ  	,<  ,<  X[  [  Z  ^,  ,   D  X+   ,,<   Z  ,<  Z  F  VXB  3B   +   XB  +   ,Z  B  YXB  3B   +   ",<   Z  ,<  ,<   &  V,~   Z  B  YXB  3B   +   (,<   Z   ,<  ,<   &  V,~   ,<  V,<  ZZ  ",<  ,<  Z,   D  X,~   Z  )-,   +   ;Z  ,,<   Z  %,<   [  -Z  ,<   ,<   (  VXB  #3B   +   4+   ,<  V,<  [Z  .,<  ,<  [[  /Z  ,<   ,<  \Z  6^,  ,   D  X,~   Z  2B   +   =Z   ,~   Z  ;,<   [  =XB  >,\   XB   Z  @2B   +   B+   ;Z  @,<   [  BXB  C,\   XB  Z  5[  EZ  2B  +   KZ  F,<   [  H[  Z  ,   ,~   Z  I,<   Z  E,<   [  K[  Z  ,<   ,<   (  VXB  22B   +   +   @4H$R	!2DD"           (VARIABLE-VALUE-CELL SOURCE . 113)
(VARIABLE-VALUE-CELL FIELD . 153)
(VARIABLE-VALUE-CELL CONTEXT . 126)
(NIL VARIABLE-VALUE-CELL TMP . 161)
(NIL VARIABLE-VALUE-CELL CTXENTRY . 155)
(NIL VARIABLE-VALUE-CELL CTXLIST . 136)
GLFINDVARINCTX
GLVALUE
GLGETFIELD
"The property"
"cannot be found for"
"whose type is"
GLERROR
GLGETGLOBALDEF
GLGETCONSTDEF
"The name"
"cannot be found."
"The property"
"cannot be found for type"
"in"
(ALIST2 SKLST LIST3 ALIST SKA KNIL ENTERF) 	8   X   8   (         R 
 B X < 8 2 x %    @  x          

GLGETFROMUNIT BINARY
             -.           @    ,~   ,<  [   [  Z  D  XB   3B   +   [  ,<   Z   ,<   Z   ,<   "  ,   ,~   Z   ,~   	   (VARIABLE-VALUE-CELL UNITREC . 7)
(VARIABLE-VALUE-CELL IND . 16)
(VARIABLE-VALUE-CELL DES . 18)
(NIL VARIABLE-VALUE-CELL TMP . 14)
GET
ASSOC
(EVCC KNIL ENTERF) 8   H        

GLGETGLOBALDEF BINARY
        	    -.           	Z   ,<   ,<  	$  
3B   +   Z  ,<   ,<   ,<  
$  
,   ,~   Z   ,~   #   (VARIABLE-VALUE-CELL ATM . 9)
GLISPGLOBALVAR
GETPROP
GLISPGLOBALVARTYPE
(ALIST2 KNIL ENTERF)       	  H      

GLGETPAIRS BINARY
      "        !-.          @    ,~   Z   2B   +   Z   ,~   Z  ,<   [  XB  ,\   XB   -,   +   ,<  ,<   ,<  ,   D  +   2B  +   +   Z  ,<   ,<  $   3B   +   Z  ,<   [  XB  ,\   ,<   Z   ,<   ,<   &   XB   Z  ,<  Z  Z  ,   ,   D  !XB  +    _ @(  (VARIABLE-VALUE-CELL EXPR . 37)
(VARIABLE-VALUE-CELL CONTEXT . 40)
(NIL VARIABLE-VALUE-CELL PROP . 47)
(NIL VARIABLE-VALUE-CELL VAL . 48)
(NIL VARIABLE-VALUE-CELL PAIRLIST . 52)
GLGETPAIRS
"is not a legal property name."
GLERROR
,
((= _ :=) . 0)
MEMB
GLDOEXPR
NCONC
(CONSNL CONS KT LIST2 SKNA KNIL ENTERF)          `   @      H   H      

GLGETPROP BINARY
               -.           @    ,~   Z   ,<   ,<  $  XB   3B   +   [  ,<   Z   D  XB   3B   +   Z   ,<  D  XB   ,~   Z   ,~   2       (VARIABLE-VALUE-CELL STR . 6)
(VARIABLE-VALUE-CELL PROPNAME . 20)
(VARIABLE-VALUE-CELL PROPTYPE . 15)
(NIL VARIABLE-VALUE-CELL PL . 13)
(NIL VARIABLE-VALUE-CELL SUBPL . 17)
(NIL VARIABLE-VALUE-CELL PROPENT . 23)
GLSTRUCTURE
GETPROP
LISTGET
ASSOC
(KNIL ENTERF)  X 
  h      

GLGETSTR BINARY
                -.           @    ,~   Z   B  XB   3B   +   
-,   +   
,<   ,<  $  XB   3B   +   
Z  ,~   Z   ,~   Jd  (VARIABLE-VALUE-CELL DES . 6)
(NIL VARIABLE-VALUE-CELL TYPE . 8)
(NIL VARIABLE-VALUE-CELL TMP . 19)
GLXTRTYPE
GLSTRUCTURE
GETPROP
(SKA KNIL ENTERF)    h   8 	  X      

GLGETSUPERS BINARY
     	        -.           Z   ,<   ,<  $  [  ,<   ,<  $  ,~      (VARIABLE-VALUE-CELL CLASS . 3)
GLSTRUCTURE
GETPROP
SUPERS
LISTGET
(ENTERF)    

GLIDNAME BINARY
        ?    3    =-.          3@  5  ,~   Z   -,   +   32B   +   ,<   ,<   ,   ,~   -,   +   *2B   +   ,<   ,<  6,   ,~   ,<   Z   D  6XB   3B   +   Z  ,<  2B  7+   Z   +   ,   ,~   ,<   Z  ,<  Z  F  72B   +   3Z  ,<   Z  D  8XB  3B   +   Z  ,<   [  [  Z  ,   ,~   Z  B  82B   +   3Z  B  92B   +   3Z   3B   +   $Z   3B   +   ',<  9,<  :Z  ,<   ,<  :,   D  ;Z  %,<   ,<   ,   ,~   -,   +   -,<   ,<  ;,   ,~      +   0,<   ,<  <,   ,~   ,<  9,<   ,<  <,   D  ;,~   ,~   (MD@$e"J@     (VARIABLE-VALUE-CELL NAME . 79)
(VARIABLE-VALUE-CELL DEFAULTFLG . 66)
(VARIABLE-VALUE-CELL CONTEXT . 46)
(VARIABLE-VALUE-CELL GLCAUTIOUSFLG . 69)
(NIL VARIABLE-VALUE-CELL TMP . 53)
BOOLEAN
GLVARTYPE
*NIL*
GLGETFIELD
GLIDTYPE
GLGETCONSTDEF
GLGETGLOBALDEF
GLIDNAME
"The name"
"cannot be found in this context."
GLERROR
INTEGER
REAL
"is an illegal name."
(FLOATT SKI LIST3 ALIST2 KT SKLA LIST2 KNIL SKA ENTERF)   .    +    '     (         ( 0 P * 8     ) @ "     8  h   h            

GLIDTYPE BINARY
     "        !-.           @    ,~   Z   XB   Z  2B   +   Z   ,~   Z  ,<   [  XB  ,\   XB   Z  	2B   +   +   Z  	XB   [  XB  [  Z  Z   3B  +   [  [  Z  Z  3B  +   [  [  Z  -,   +   	[  [  Z  Z  B   3B   +   	Z  [  [  Z  [  Z  2B  +   	Z  ,~    `! @ (VARIABLE-VALUE-CELL NAME . 50)
(VARIABLE-VALUE-CELL CONTEXT . 6)
(NIL VARIABLE-VALUE-CELL CTXLEVELS . 16)
(NIL VARIABLE-VALUE-CELL CTXLEVEL . 26)
(NIL VARIABLE-VALUE-CELL CTXENTRY . 58)
GL-A-AN?
(SKLST KNIL ENTERF)        0   X      

GLINIT BINARY
     ^    F    [-.          ` F,<  L"  MXB   Z   XB   Z   XB   Z   XB   Z   XB   Z"   XB   Z   XB   Z   XB   Z   XB   Z   XB   Z   XB   Z   2B  M+   Z  N+   2B  N+   Z  O+   2B  O+   Z  P+   2B  P+   Z  Q+   2B  Q+   Z  R+   Z   ,<   Zp  -,   +   +   !Zp  ,<   @  R   +    Z   ,<   ,<  S,<   &  S,~   [p  XBp  +   /   Z  2B  M+   $Z  T+   -2B  N+   &Z  T+   -2B  O+   (Z  U+   -2B  P+   *Z  U+   -2B  Q+   ,Z  V+   -Z   ,<   Zp  -,   +   /+   6Zp  ,<   @  R   +   5Z  ,<   ,<  V,<   &  S,~   [p  XBp  +   -/   ,<  W"  WZ  "2B  M+   ;,<  X"  W+   D2B  N+   =,<  X"  W+   D2B  O+   @,<  Y"  W+   D2B  P+   B,<  Y"  W+   D2B  Q+   D,<  Z"  W,<  Z"  [Z   ,~     x2Jpe[p          (VARIABLE-VALUE-CELL GLSEPBITTBL . 5)
(VARIABLE-VALUE-CELL GLUNITPKGS . 7)
(VARIABLE-VALUE-CELL GLSEPMINUS . 9)
(VARIABLE-VALUE-CELL GLQUIETFLG . 11)
(VARIABLE-VALUE-CELL GLSEPATOM . 13)
(VARIABLE-VALUE-CELL GLSEPPTR . 15)
(VARIABLE-VALUE-CELL GLBREAKONERROR . 17)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 19)
(VARIABLE-VALUE-CELL GLLASTFNCOMPILED . 21)
(VARIABLE-VALUE-CELL GLLASTSTREDITED . 23)
(VARIABLE-VALUE-CELL GLCAUTIOUSFLG . 25)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 112)
((: _ + - ' = ~ < > * / , ^) . 0)
MAKEBITTABLE
INTERLISP
((EQ EQP NEQ EQUAL MEMB AND OR NOT ZEROP NULL NUMBERP FIXP FLOATP ATOM LITATOM LISTP MINUSP STRINGP 
FASSOC ASSOC IGREATERP IGEQ ILESSP ILEQ IPLUS ITIMES IDIFFERENCE IQUOTIENT ADD1 SUB1 PLUS MINUS IMINUS
 TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP GEQ LESSP LEQ CAR CDR CAAR CADR) . 0)
MACLISP
((EQ EQP AND OR NOT EQUAL ZEROP NULL NULL NUMBERP FIXP FLOATP ATOM SYMBOLP PAIRP BIGP HUNKP ASCII 
PLUSP MINUSP ODDP GREATERP LESSP MEMQ ASSQ > = MAX MIN ABS FIX FLOAT REMAINDER GCD \ \\ ^ LOG EXP SIN 
COS ATAN BOOLE ASH LSH ROT < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT 
CAR CDR CAAR CADR) . 0)
FRANZLISP
((EQ NEQ AND OR NOT EQUAL ATOM NULL DTPR SYMBOLP STRINGP HUNKP MEMQ > = < + * / - 1+ 1- ADD1 SUB1 PLUS
 MINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT ABS BOOLE COS EVENP EXP FIX FIXP FLOAT FLOATP GREATERP 
LESSP LOG LSH MAX MIN MINUSP MOD NUMBERP ODDP ONEP REMAINDER ROT SIN SQRT ZEROP CAR CDR CAAR CADR) . 0
)
UCILISP
((EQ EQUAL AND OR NOT MEMQ > GE = LE < + * / - ADD1 SUB1 PLUS MINUS TIMES DIFFERENCE QUOTIENT CAR CDR 
CAAR CADR) . 0)
PSL
((EQ NE EQUAL AND OR NOT MEMQ ADD1 SUB1 EQN ASSOC PLUS MINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT 
GREATERP GEQ LESSP LEQ CAR CDR CAAR CADR) . 0)
(VARIABLE-VALUE-CELL X . 100)
GLEVALWHENCONST
PUTPROP
((IGREATERP IGEQ ILESSP ILEQ IPLUS ITIMES IDIFFERENCE IQUOTIENT ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT
 EXPT DIFFERENCE QUOTIENT GREATERP GEQ LESSP LEQ) . 0)
((> = < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP LESSP) 
. 0)
((> = < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP LESSP) 
. 0)
((> GE = LE < + * / - ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP LESSP) 
. 0)
((ADD1 SUB1 EQN PLUS MINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP GEQ LESSP LEQ) . 0)
GLARGSNUMBERP
(((NUMBER (PLUS MINUS DIFFERENCE TIMES EXPT QUOTIENT REMAINDER MIN MAX ABS)) (INTEGER (LENGTH FIX ADD1
 SUB1)) (REAL (SQRT LOG EXP SIN COS ATAN ARCSIN ARCCOS ARCTAN ARCTAN2 FLOAT)) (BOOLEAN (ATOM NULL 
EQUAL MINUSP ZEROP GREATERP LESSP NUMBERP FIXP FLOATP STRINGP ARRAYP EQ NOT NULL BOUNDP))) . 0)
GLDEFFNRESULTTYPES
(((INTEGER (FLENGTH IPLUS NCHARS IMINUS IDIFFERENCE ITIMES IQUOTIENT IREMAINDER IMIN IMAX LOGAND LOGOR
 LOGXOR LSH RSH LRSH LLSH GCD COUNT COUNTDOWN NARGS)) (BOOLEAN (LISTP IGREATERP SMALLP FGREATERP 
FLESSP GEQ LEQ LITATOM NLISTP NEQ ILESSP IGEQ ILEQ IEQP CCODEP SCODEP SUBRP EVERY EQUALALL EQLENGTH 
EQUALN EXPRP EQP)) (REAL (RAND RANDSET))) . 0)
(((INTEGER (+ - * / 1+ 1- FLATC)) (BOOLEAN (> PAIRP HUNKP BIGP EQP < = SYMBOLP))) . 0)
(((INTEGER (+ - * / 1+ 1- FLATC)) (BOOLEAN (> BIGP HUNKP < = DTPR SYMBOLP))) . 0)
(((INTEGER (+ - * / ADD1 SUB1 FLATSIZE FLATSIZEC)) (BOOLEAN (CONSP GE LE INUMP))) . 0)
(((INTEGER (FLATSIZE FLATSIZE2)) (BOOLEAN (EQN NE PAIRP IDP UNBOUNDP))) . 0)
(((NTH . GLNTHRESULTTYPEFN) (CONS . GLLISTRESULTTYPEFN) (LIST . GLLISTRESULTTYPEFN) (NCONC . 
GLLISTRESULTTYPEFN)) . 0)
GLDEFFNRESULTTYPEFNS
(BHC KT SKNLST ASZ KNIL ENTER0) x "    4 x   p         F X  P  0 
    `   @      

GLINSTANCEFN BINARY
            -.           @    ,~   Z   ,<   ,<  $  XB   2B   +   Z   ,~   Z  2B   +   	+   Z  Z  ,<   ,<  $  XB   Z   XB   Z  2B   +   Z  	,~   Z  B  ,<   Z  B  ,\  ,   3B   +   [  XB  [  XB  +   [  XB  +   20"D   (VARIABLE-VALUE-CELL FNNAME . 6)
(VARIABLE-VALUE-CELL ARGTYPES . 25)
(NIL VARIABLE-VALUE-CELL INSTANCES . 47)
(NIL VARIABLE-VALUE-CELL IARGS . 42)
(NIL VARIABLE-VALUE-CELL TMP . 44)
GLINSTANCEFNS
GETPROP
GLARGUMENTTYPES
GLXTRTYPEB
(EQUAL KNIL ENTERF)  @   H     h      

GLINTERLISPTRANSFM BINARY
        6    0    4-.           0@  0  ,~   Z   -,   +   Z  ,~   Z  Z  1,   3B   +   Z  ,<   [  [  Z  ,<   [  	Z  ,   XB  Z  Z  2,   XB   Z  Z  27   [  Z  Z  1H  +   2D   +   XB   3B   +   [  Z  [  ,   XB  +   +Z  2B  3+   +[  [  Z  -,   +   +[  [  Z  0B   +   ![  Z  XB  +   +[   [  Z  ,   0"  +   +,<  3[  ![  Z  ,   /"   ,   D  3Z  ,<   [  $Z  ,   XB  )Z  3B   +   /,<  4Z  *,<  ,   ,~   Z  -,~   " )a @@  (VARIABLE-VALUE-CELL X . 94)
(NIL VARIABLE-VALUE-CELL TMP . 43)
(NIL VARIABLE-VALUE-CELL NOTFLG . 86)
((GLSTRLESSP GLSTRGEP) . 0)
((GLSTRGREATERP GLSTRLESSP) . 0)
(((GLSTRLESSP ALPHORDER) (GLSTRGREATERP ALPHORDER) (GLSTRGEP ALPHORDER)) . 0)
NTH
((CDR CDDR CDDDR CDDDDR) . 0)
NOT
(LIST2 ALIST2 MKN IUNBOX ASZ SKNM CONS ALIST3 KNIL FMEMB SKNLST ENTERF)  p   0       p #                    , X      p            

GLISPCONSTANTS BINARY
    )    !    '-.          !@  !   ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @  #   +   Z   ,<   ,<  $,<   &  $Z  ,<   ,<  %[  Z  F  $Z  ,<   ,<  %[  Z  ,   XB   ,<   ,<   ,<   &  &XB   Z  ,<   Z  B  &    ,\   ,   F  $Z  ,<   ,<  '[  [  Z  2B   +   [  Z  F  $,~   [p  XBp  +   /   Z   ,~   RIDB"      (VARIABLE-VALUE-CELL ARGS . 6)
(NIL VARIABLE-VALUE-CELL TMP . 56)
(NIL VARIABLE-VALUE-CELL EXPR . 34)
(NIL VARIABLE-VALUE-CELL EXPRSTACK . 0)
(NIL VARIABLE-VALUE-CELL FAULTFN . 0)
(VARIABLE-VALUE-CELL ARG . 51)
GLISPCONSTANTFLG
PUTPROP
GLISPORIGCONSTVAL
GLISPCONSTANTVAL
GLDOEXPR
EVAL
GLISPCONSTANTTYPE
(BHC SET KNIL CONSNL KT SKNLST ENTERF)           0          0    X      

GLISPGLOBALS BINARY
            -.          Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   Z   ,<   ,<  ,<   &  Z  ,<   ,<  [  
Z  F  ,~   [p  XBp  +   BJ$ (VARIABLE-VALUE-CELL ARGS . 3)
(VARIABLE-VALUE-CELL ARG . 23)
GLISPGLOBALVAR
PUTPROP
GLISPGLOBALVARTYPE
(KT URET1 KNIL SKNLST ENTERF)        X    P    @      

GLISPOBJECTS BINARY
        
    -.          
Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   	Z   B  ,~   [p  XBp  +   BQ  (VARIABLE-VALUE-CELL ARGS . 3)
(VARIABLE-VALUE-CELL ARG . 15)
GLDEFSTR
(URET1 KNIL SKNLST ENTERF)  X    P    @      

GLLISPADJ BINARY
               -.           @    ,~   Z   B  Z  7   [  Z  Z  1H  +   2D   +   XB   3B   +   [  ,~   Z   ,~   `R  (VARIABLE-VALUE-CELL ADJ . 6)
(NIL VARIABLE-VALUE-CELL TMP . 20)
U-CASE
(((ATOMIC . ATOM) (NULL . NULL) (NIL . NULL) (INTEGER . FIXP) (REAL . FLOATP) (BOUND . BOUNDP) (ZERO .
 ZEROP) (NUMERIC . NUMBERP) (NEGATIVE . MINUSP) (MINUS . MINUSP)) . 0)
(KNIL ENTERF)  @ 
       

GLLISPISA BINARY
               -.           @    ,~   Z   B  Z  7   [  Z  Z  1H  +   2D   +   XB   3B   +   [  ,~   Z   ,~   `R  (VARIABLE-VALUE-CELL ISAWORD . 6)
(NIL VARIABLE-VALUE-CELL TMP . 20)
U-CASE
(((ATOM . ATOM) (LIST . LISTP) (NUMBER . NUMBERP) (INTEGER . FIXP) (SYMBOL . LITATOM) (ARRAY . ARRAYP)
 (STRING . STRINGP) (BIGNUM . BIGP) (LITATOM . LITATOM)) . 0)
(KNIL ENTERF)  @ 
       

GLLISTRESULTTYPEFN BINARY
        E    >    C-.           >@  ?  ,~   Z   B  @XB   [  3B   +   [  Z  B  @XB   Z   2B  A+   Z  -,   +   Z  	2B  A+   Z  [  ,   Z  A,   2B   +   >+   Z  2B  B+   Z  [  Z  ,   3B   +   +   Z   +   Z  2B   +   >Z  ,<   Z  ,<  ,   ,~   2B  B+   .Z  Z  ,   3B   +   Z  ,~   Z  -,   +   ,Z  -,   +   ,Z  2B  B+   ,Z  !2B  A+   ,[  $[  2B   +   ,[  "Z  [  %Z  ,   3B   +   ,Z  ',~   Z  +2B   +   >Z  (,~   2B  A+   =,<   Z  ,<  ,<   Zw-,   +   8Zp  Z   2B   +   6 "  +   7[  QD   "  +   <ZwB  @Zp  ,   XBp  [wXBw+   1/  ,   ,~      C,~   DLXM$%1`"
   (VARIABLE-VALUE-CELL FN . 48)
(VARIABLE-VALUE-CELL ARGTYPES . 96)
(NIL VARIABLE-VALUE-CELL ARG1 . 88)
(NIL VARIABLE-VALUE-CELL ARG2 . 91)
GLXTRTYPE
CONS
LIST
LISTOF
NCONC
ERROR
(CONSS1 BHC COLLCT SKNLST LIST2 EQUAL CONS21 CONS SKLST KNIL ENTERF) X   P   (   0   0   (  H   x   h   ( ! 0   P 4   - 0 ' h  h           

GLLISTSTRFN BINARY
       *    !    (-.           !@  #  ,~   Z"   XB   Z  $XB   Z   2B  %+   	   ."   ,   XB  [  XB  Z  ,<   [  	XB  
,\   Z  2B   +   Z   ,~   Z  -,   +   Z   ,<   Z  ,<   Z   F  %XB   3B   +   ,<   Z  	3B   +   Z  +   ,<  &,<  &,<  'Z  ,<  ,   B  ',   D  (,~      ."   ,   XB  Z  3B   +   	[  XB   +   	& $/
     (VARIABLE-VALUE-CELL IND . 32)
(VARIABLE-VALUE-CELL DES . 34)
(VARIABLE-VALUE-CELL DESLIST . 36)
(NIL VARIABLE-VALUE-CELL TMP . 38)
(NIL VARIABLE-VALUE-CELL N . 60)
(NIL VARIABLE-VALUE-CELL FNLST . 65)
(((CAR *GL*) (CADR *GL*) (CADDR *GL*) (CADDDR *GL*)) . 0)
LISTOBJECT
GLSTRFN
CAR
NTH
*GL*
GLGENCODE
GLSTRVAL
(ALIST2 LIST3 SKLST KNIL MKN ASZ ENTERF) @   0          H  X   h            

GLMACLISPTRANSFM BINARY
       b    U    _-.           U@  U  ,~   Z   -,   +   Z  ,~   Z  Z  V,   3B   +   Z  ,<   [  [  Z  ,<   [  	Z  ,   XB  +   Z  Z  W,   3B   +   Z  ,<   [  Z  ,<   [  [  [  Z  ,<   [  [  Z  ,   XB  Z  Z  W,   XB   Z  Z  X7   [  Z  Z  1H  +   2D   +   XB   3B   +   #[  Z  [  ,   XB  !+   PZ  "2B  X+   )[  #2B   +   )Z  $,<   ,<   ,   XB  &+   PZ  (2B  Y+   1[  )[  2B   +   1Z  *,<   [  ,Z  ,<   ,<   ,   XB  -+   PZ  02B  Y+   @Z  1,<   ,<  Z$  ZZ  2,<   ,<  [$  [XB   [  6Z  2B   +   ;Z  7,<   ,<   $  \+   PZ  9,<   ,<   [  ;Z  ,   ,   D  \+   PZ  42B  \+   M,<  ][  @[  Z  -,   +   H[  B[  Z  ,   /"   ,   +   J,<  ][  D[  Z  ,   ,<   [  HZ  ,   XB  K+   PZ  L2B  ^+   PZ  MB  ^Z  3B   +   T,<  _Z  O,<  ,   ,~   Z  R,~   " H )HLBp@@&       (VARIABLE-VALUE-CELL X . 168)
(NIL VARIABLE-VALUE-CELL TMP . 122)
(NIL VARIABLE-VALUE-CELL NOTFLG . 160)
((MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON push PUSH SOME EVERY SUBSET GLSTRGREATERP ALPHORDER) . 0)
((PUTPROP) . 0)
((ALPHORDER GLSTRGEP NEQ NLISTP) . 0)
(((MEMB MEMQ) (FMEMB MEMQ) (FASSOC ASSQ) (LITATOM SYMBOLP) (GETPROP GET) (GETPROPLIST PLIST) (LISTP 
PAIRP) (NLISTP PAIRP) (NEQ EQ) (IGREATERP >) (IGEQ >=) (GEQ >=) (ILESSP <) (ILEQ <=) (LEQ <=) (IPLUS +
) (IDIFFERENCE -) (ITIMES *) (IQUOTIENT //) (ADD1 1+) (SUB1 1-) (* COMMENT) (MAPCONC MAPCAN) (APPLY* 
FUNCALL) (DECLARE COMMENT) (NCHARS FLATC) (UNPACK EXPLODE) (PACK READLIST) (DREVERSE NREVERSE) (
STREQUAL EQUAL) (ALPHORDER ALPHALESSP) (GLSTRGREATERP ALPHALESSP) (GLSTRGEP ALPHALESSP) (GLSTRLESSP 
ALPHALESSP)) . 0)
RETURN
APPEND
SELECTQ
CASEQ
RPLACA
2
NLEFT
RPLACD
NTH
NTHCDR
1-
PROG
GLTRANSPROG
NOT
(MKN IUNBOX SKI CONSNL ALIST2 KT LIST3 LIST2 CONS ALIST4 ALIST3 KNIL FMEMB SKNLST ENTERF) 	    p   H   x   	0 ?    =    0    T    (   x   	P     Q 0 9   ,   &           x            

GLMAKEFORLOOP BINARY
     D    :    B-.     (      :Z   2B   +   ,<  <Z   ,<   ,<  =,<  =Z   ,   ,<   Z   3B   +   ,<  >Z  Z   ,   ,   +   [  	2B   +   Z  +   Z  >Z  ,   ,   ,   ,   B  ?,<   ,<   ,   ,~   Z  	3B   +    ,<  ?Z  ,<   ,<  =,<  =Z  ,   ,<   ,<  @Z  ,<   ,<  @Z  ,<   ,<   ,   ,   ,   ,   ,   B  ?+   6Z  -,   +   0Z   Z  -,   +   0Z  ![  3B   +   0Z  #[  Z  Z  2B  +   0Z  %[  [  2B   +   0,<  AZ  ,<   ,<  =Z  (Z  ,   ,   B  ?+   6,<  AZ  +,<   ,<  =,<  =Z  ',   ,<   Z  -,   ,   ,   B  ?,<   ,<  A[  4Z  ,   ,   ,~   %AH!H9@P    (VARIABLE-VALUE-CELL LOOPVAR . 101)
(VARIABLE-VALUE-CELL DOMAIN . 97)
(VARIABLE-VALUE-CELL LOOPCONTENTS . 29)
(VARIABLE-VALUE-CELL LOOPCOND . 51)
(VARIABLE-VALUE-CELL COLLECTCODE . 111)
MAPC
FUNCTION
LAMBDA
COND
PROGN
GLGENCODE
MAPCONC
AND
CONS
MAPCAR
LISTOF
(SKA SKLST LIST3 LIST2 ALIST3 ALIST2 CONS CONSNL KNIL ENTERF)   #    !            6 X / x  `       9 ` / p  8         4      + X  P  P   0      

GLMAKEGLISPVERSION BINARY
                -.          @    ,~   Z  XB   Z   ,<  D  2B   +   ,<  Z  D  ,<  "  Z   [  ,<   Z   D  XB   ,<   Zp  -,   +   +   Zp  B  [p  XBp  +   /   ,<   "  Z  ,<   Z   D  ,~   8!RD    (VARIABLE-VALUE-CELL OUTPUTDIALECT . 8)
(VARIABLE-VALUE-CELL FILE . 39)
(VARIABLE-VALUE-CELL GLISPCOMS . 18)
(VARIABLE-VALUE-CELL GLSPECIALFNS . 21)
(NIL VARIABLE-VALUE-CELL FNS . 37)
(NIL VARIABLE-VALUE-CELL DIALECTS . 14)
((MACLISP FRANZLISP UCILISP PSL) . 0)
MEMB
"Dialect must be a member of "
ERROR
LISPTRANS.LSP
LOAD?
LDIFFERENCE
COUNTARGS
UNBREAK
LTRANFNS
(BHC SKNLST KNIL ENTERF)       `   (        

GLMAKESTR BINARY
    3    )    2-.          )@  +  ,~   Z   ,<   ,<  ,$  ,3B   +   Z  ,<   [  XB  ,\   Z   B  -XB   2B   +   ,<  -,<  .Z  ,<  ,<  .,   D  /Z  	2B  /+   "Z  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   @  *   +   ,<   Z   ,<   ,<   &  0,~   Zp  ,   XBp  [wXBw+   /  Z  0,   ,~   Z  B  1XB   Z  ,<  ,<   Z  ,   F  1,<   Z  %,<   ,   ,~   4rX"DP@Q    (VARIABLE-VALUE-CELL TYPE . 79)
(VARIABLE-VALUE-CELL EXPR . 69)
(VARIABLE-VALUE-CELL CONTEXT . 54)
(NIL VARIABLE-VALUE-CELL PAIRLIST . 71)
(NIL VARIABLE-VALUE-CELL STRDES . 72)
((WITH With with) . 0)
MEMB
GLGETSTR
GLMAKESTR
"The type name"
"is not defined."
GLERROR
LISTOF
GLDOEXPR
LIST
GLGETPAIRS
GLBUILDSTR
(LIST2 CONSNL CONS21 BHC COLLCT KT SKNLST LIST3 KNIL ENTERF)   )    '    "    !                     P      `      

GLMAKEVTYPE BINARY
     2    '    0-.           '@  (  (
,~   [   Z  XB   [  [  XB  Z  ,<   ,<  +$  +3B   +   
[  XB  	Z  	2B   +   +   Z  
XB   [  XB  Z  2B  ,+   [  XB  Z   XB   Z  3B   +   Z  2B  ,+   [  XB  Z  ,<  Z  B  -,   Z   ,   XB  +   
Z  Z  ,   XB  [  XB  +      -XB   ,<   ,<  .,<  .Z   ,<  ,   ,<   ,<  /Z  ,<   ,<  /Z  ,   ^,  ,   F  0Z  ,~    h00, 3    (VARIABLE-VALUE-CELL ORIGTYPE . 64)
(VARIABLE-VALUE-CELL VLIST . 57)
(NIL VARIABLE-VALUE-CELL SUPER . 72)
(NIL VARIABLE-VALUE-CELL PL . 69)
(NIL VARIABLE-VALUE-CELL PNAME . 43)
(NIL VARIABLE-VALUE-CELL TMP . 55)
(NIL VARIABLE-VALUE-CELL VTYPE . 77)
((with With WITH) . 0)
MEMB
=
,
DREVERSE
GLMKVTYPE
GLSTRUCTURE
TRANSPARENT
PROP
SUPERS
PUTPROP
(ALIST CONSNL LIST2 CONS ALIST2 KNIL ENTERF)   &    %    "           0  8 	       

GLMINUSFN BINARY
            -.           Z   ,<   ,<  ,<   &  2B   +   Z  ,<   ,<  ,<   &  2B   +   Z  -,   +   Z  B  +   [  
Z  B  2B  +   ,<  Z  ,   +   ,<  Z  ,   B  ,<   [  Z  ,   ,~   RRgL     (VARIABLE-VALUE-CELL LHS . 37)
MINUS
GLDOMSG
GLUSERSTROP
GLXTRTYPE
INTEGER
IMINUS
GLGENCODE
(ALIST2 SKNM KNIL ENTERF) H             P        

GLMKATOM BINARY
             -.           @    ,~   Z   ,<   ,<  ,<   ,<  $  2B   +   ^"   +   ,   ."   ,   XB   F  Z  B  ,<   Z  	B  D  B  XB   [  3B   +   +   Z  ,~   -!'     (VARIABLE-VALUE-CELL NAME . 21)
(NIL VARIABLE-VALUE-CELL N . 24)
(NIL VARIABLE-VALUE-CELL NEWATOM . 33)
GLISPATOMNUMBER
GETPROP
PUTPROP
UNPACK
APPEND
PACK
(MKN IUNBOX KNIL ENTERF)                   

GLMKLABEL BINARY
    	        -.               ."   ,   XB  ,<  B  D  B  ,~   x   (VARIABLE-VALUE-CELL GLNATOM . 6)
((G L L A B E L) . 0)
UNPACK
APPEND
PACK
(MKN ENTER0)         

GLMKVAR BINARY
      	        -.               ."   ,   XB  ,<  B  D  B  ,~   x   (VARIABLE-VALUE-CELL GLNATOM . 6)
((G L V A R) . 0)
UNPACK
APPEND
PACK
(MKN ENTER0)    8      

GLMKVTYPE BINARY
               -.            ,<  "  ,~       GLVIRTUALTYPE
GLMKATOM
(ENTER0)      

GLNCONCFN BINARY
       j    X    g-.          X@  Z  (
,~   Z   XB   [  Z  B  \XB   2B  ]+   Z   Z$   ,   3B   +   ,<  ]Z  ,<   ,   XB   +   RZ  -,   +   [  Z  2B  ]+   ,<  ^Z  
,<   Z  ,   XB  +   R,<  ^Z  ,<   Z  ,   XB  +   R3B  _+   2B  _+   ,<  ^Z  ,<  Z  ,   XB  +   R2B  `+   !,<  `Z  ,<  Z  ,   XB  +   R2B   +   .,<  aZ  ,<  Z  ,   XB   Z  "-,   +   R[  #Z  3B   +   RZ  %,<   ,<   ,<  a[  &Z  ,   ,<   Z   H  b+   R-,   +   4Z  2B  a+   4,<  aZ  (,<   Z  *,   XB  $+   RZ  ,<   Z  2,<  ,<  b&  cXB   3B   +   9Z  7,~   Z  4,<  ,<  cZ  5,   F  dXB  83B   +   >+   8Z  9,<  ,<  dZ  ;,   F  dXB  <3B   +   DZ  AXB  3+   RZ  /B  eXB   3B   +   MZ  >,<   Z  E,<   ,   ,<   Z  @D  eXB  C3B   +   M+   8Z  G,<   ,<  cZ  JF  fXB  K3B   +   Q+   8Z   ,~   Z  M,<   Z  CB  f,<   Z  D,<   ,   ,<   ,<   &  g,~   	Ap,"\d2$R2L     (VARIABLE-VALUE-CELL LHS . 165)
(VARIABLE-VALUE-CELL RHS . 157)
(VARIABLE-VALUE-CELL CONTEXT . 89)
(NIL VARIABLE-VALUE-CELL LHSCODE . 98)
(NIL VARIABLE-VALUE-CELL LHSDES . 170)
(NIL VARIABLE-VALUE-CELL NCCODE . 167)
(NIL VARIABLE-VALUE-CELL TMP . 159)
(NIL VARIABLE-VALUE-CELL STR . 144)
GLXTRTYPE
INTEGER
ADD1
IPLUS
PLUS
NUMBER
REAL
BOOLEAN
OR
NCONC1
LISTOF
GLADDSTR
NCONC
GLUNITOP
_+
GLDOMSG
+
GLGETSTR
GLNCONCFN
GLUSERSTROP
GLGENCODE
GLPUTFN
(KT CONSNL SKLST ALIST2 SKA ALIST3 SKNI LIST2 KNIL EQP ASZ ENTERF)   X    A H   p   H   h   8 %   h         W 	      R 
 L p C ` 8 ( (   	    	           

GLNEQUALFN BINARY
        #        "-.           @    ,~   Z   ,<   ,<  Z   ,   F  XB   3B   +   Z  ,~   Z  ,<  ,<  Z  F  XB  3B   +   +   [  Z  3B  +   [  
Z  2B  +   ,<  Z  ,<   Z  ,   B   ,<   ,<   ,   ,~   ,<  !Z  ,<   Z  D  !Z  ,   B   ,<   ,<   ,   ,~   $BLg
"(  (VARIABLE-VALUE-CELL LHS . 45)
(VARIABLE-VALUE-CELL RHS . 47)
(NIL VARIABLE-VALUE-CELL TMP . 22)
~=
GLDOMSG
GLUSERSTROP
ATOM
NEQ
GLGENCODE
BOOLEAN
NOT
GLEQUALFN
(ALIST2 LIST2 ALIST3 KNIL CONSNL ENTERF)       @           x    `      

GLNOTFN BINARY
            -.           Z   ,<   ,<  ,<   &  2B   +   Z  ,<   ,<  ,<   &  2B   +   Z  B  ,<   ,<  ,   ,~   RU  (VARIABLE-VALUE-CELL LHS . 17)
~
GLDOMSG
GLUSERSTROP
GLBUILDNOT
BOOLEAN
(LIST2 KNIL ENTERF)        x   @      

GLNTHRESULTTYPEFN BINARY
        	    -.           	@  
  ,~   Z   B  
XB   -,   +   Z  2B  +   Z  ,~   Z   ,~   K   (VARIABLE-VALUE-CELL FN . 0)
(VARIABLE-VALUE-CELL ARGTYPES . 14)
(NIL VARIABLE-VALUE-CELL TMP . 11)
GLXTRTYPE
LISTOF
(KNIL SKLST ENTERF)   	           

GLOCCURS BINARY
             -.           Z   Z   2B  +   Z   ,~   Z  -,   +   Z   ,~   Z  ,<  Z  D  2B   +   [  XB  
+   ,~   
  (VARIABLE-VALUE-CELL X . 14)
(VARIABLE-VALUE-CELL STR . 21)
GLOCCURS
(KNIL SKNLST KT ENTERF)                  

GLOKSTR? BINARY
        z   -.          zZ   2B   +   Z   ,~   -,   +   Z   ,~   -,   +   yZ  -,   +   yZ  3B  |+   3B  |+   3B  }+   3B  }+   2B  ~+   [  [  3B   +   Z   ,~   [  Z  B  ~2B   +   z[  Z  B  2B   +   zZ   3B   +   ,<  "  [  Z  B  ,<  "    Z   ,~   Z   ,~   2B +   *[  3B   +   )[  [  3B   +   )[   [  [  2B   +   )[  "Z  B 3B   +   )[  $[  Z  XB  '+   Z   ,~   3B +   .3B +   .3B +   .2B +   :[  (3B   +   9[  .,<   Zp  -,   +   3Z   +    Zp  ,<   ,<w$ 2B   +   7Z   +    [p  XBp  +   1Z   ,~   2B +   R[  03B   +   A[  ;Z  -,   +   AZ  <,<   [  >XB  ?,\   [  @3B   +   Q[  A,<   Zp  -,   +   FZ   +    Zp  ,<   ,<w/   @    +   NZ   -,   +   M[  IZ  B ,~   Z   ,~   2B   +   PZ   +    [p  XBp  +   CZ   ,~   2B +   Z[  B3B   +   Y[  S[  2B   +   Y[  UZ  XB  W+   Z   ,~   3B +   \2B +   m[  X3B   +   l[  \,<   Zp  -,   +   aZ   +    Zp  ,<   ,<w/   @    +   iZ  K-,   +   h[  dZ  B ,~   Z   ,~   2B   +   kZ   +    [p  XBp  +   ^Z   ,~   2B +   pZ  ]B ,~   [  n3B   +   u[  p[  2B   +   u[  qZ  XB  s+   Z  t,<   Z   D 2B   +   zZ   ,~   Z   ,~   RN<J	AB2 R!d"yMD(      (VARIABLE-VALUE-CELL STR . 235)
(VARIABLE-VALUE-CELL GLCAUTIOUSFLG . 44)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 237)
A
AN
a
an
An
GLGETSTR
GLUNIT?
"The structure "
PRIN1
" is not currently defined.  Accepted."
TERPRI
CONS
GLOKSTR?
LIST
OBJECT
ATOMOBJECT
LISTOBJECT
RECORD
(VARIABLE-VALUE-CELL X . 204)
LISTOF
ALIST
PROPLIST
ATOM
GLATMSTR?
ASSOC
(BHC URET1 SKNLST SKLST KT SKA KNIL ENTERF) 8 H    k  P h 8 @     E (    p    F 8  H     f 	0 >      z  x 8 q X k   i X Z 
p U 
( P 	p N ( <   7 h 0 ( ' H "    `     @        

GLOPERAND BINARY
            -.              XB   3B   +      ,~   Z   2B   +   Z   ,~   Z  -,   +   Z  ,<   [  XB  	,\   ,<   ,<  ,   ,~   Z  
-,   +   Z  ,<   [  XB  ,\   B     XB     ,~   Z  ,<   [  XB  ,\   ,<   ,<   Z   ,<   ,<   (  ,~   DA    (VARIABLE-VALUE-CELL FIRST . 36)
(VARIABLE-VALUE-CELL EXPR . 42)
(VARIABLE-VALUE-CELL CONTEXT . 46)
GLSEPNXT
GLPARSNFLD
STRING
GLSEPINIT
GLPUSHEXPR
(KT SKA LIST2 SKSTP KNIL ENTER0)                      `        

GLOPERATOR? BINARY
               -.           Z   Z  ,   ,~       (VARIABLE-VALUE-CELL ATM . 3)
((_ := __ + - * / > < >= <= ^ _+ +_ _- -_ = ~= <> AND And and OR Or or __+ __- _+_) . 0)
(FMEMB ENTERF)  8      

GLORFN BINARY
             -.           Z   ,<   ,<  Z   ,   F  2B   +   Z  ,<   ,<  Z  F  2B   +   ,<  Z  ,<   Z  ,   ,<   [  	Z  B  ,<   [  
Z  B  ,\  ,   3B   +   [  Z  +   Z   ,   ,~   ),     (VARIABLE-VALUE-CELL LHS . 35)
(VARIABLE-VALUE-CELL RHS . 28)
OR
GLDOMSG
GLUSERSTROP
GLXTRTYPE
(ALIST2 EQUAL ALIST3 KNIL CONSNL ENTERF)                 	  X    H      

GLP BINARY
                -.          @    ,~   Z   2B   +   Z   XB   ,<  "  Z  ,<   ,<  $  B  Z  ,<   ,<  $  B     Z  	,~   &9p      (VARIABLE-VALUE-CELL FUN . 6)
(VARIABLE-VALUE-CELL GLLASTFNCOMPILED . 9)
(NIL VARIABLE-VALUE-CELL FN . 24)
"GLRESULTTYPE: "
PRIN1
GLRESULTTYPE
GETPROP
PRINT
GLCOMPILED
PRINTDEF
TERPRI
(KNIL ENTERF)    H      

GLPARSEXPR BINARY
      [    K    X-.            K@  M  (
,~      OZ   ,   XB  Z   2B   +   0Z   3B   +   GZ  -,   +   
+   GZ  B  P   PXB  B  Q3B   +   Z  
,<   [  XB  ,\   +   5Z  ,<   ,<  Q$  R3B   +   /Z   3B   +   Z  B  R,   1b  +      SZ   XB  +   Z  ,<   [  XB  ,\   ,<   Z   ,<   ,<   ,<  SZp  -,   +   (Zp  Z 7@  7   Z  2B  T+   ',<p  ,<   Z   F  TB  U3B   +   (Z   +   (Z   /   3B   +   +Z   +   +Z   H  UZ  ,   XB  ,Z   XB  +      V+   GB  Q3B   +   2+   5,<  VZ  .,<   ,<  W,   D  WZ  3B   +   DZ  5B  RXB   ,   ,>  J,>   Z  2B  RXB   ,       ,^   /   3"  +   DZ  7Z  :,   3B   +   CZ  9,<   ,<  X$  R2B   +   D   S+   5Z  @Z  6,   XB  E+   Z  F3B   +   I   S+   GZ  -,~      &jRL@	E {JR !Bp    (VARIABLE-VALUE-CELL EXPR . 30)
(VARIABLE-VALUE-CELL CONTEXT . 57)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 73)
(VARIABLE-VALUE-CELL ADDISATYPE . 84)
(NIL VARIABLE-VALUE-CELL OPNDS . 147)
(NIL VARIABLE-VALUE-CELL OPERS . 142)
(NIL VARIABLE-VALUE-CELL FIRST . 137)
(NIL VARIABLE-VALUE-CELL LHSP . 124)
(NIL VARIABLE-VALUE-CELL RHSP . 125)
GLOPERAND
GLSEPINIT
GLSEPNXT
GLOPERATOR?
((IS Is is HAS Has has) . 0)
MEMB
GLPREC
GLREDUCE
ADDISATYPE
NOBIND
STKSCAN
RELSTK
GLPREDICATE
GLSEPCLR
GLPARSEXPR
"appears illegally or cannot be interpreted."
GLERROR
((_ ^ :=) . 0)
(EQP LIST2 BHC KNOB SKLA KT IUNBOX SKNA KNIL CONS ENTER0)   @    5    =    (             <      	    H 8 @ h 1 h ,   ) p %   8        F X        

GLPARSFLD BINARY
    =    3    ;-.          3@  5  ,~   Z   2B   +   %Z   2B  6+      6XB   3B   +      6XB  Z  3B   +   3B   +   -,   +   ,<  7,<   ,   ,<   ,<  7,   ,~   Z   3B   +   Z   XB  Z  ,<   [  XB  ,\   3B   +   3B   +   -,   +   ,<  7,<   ,   ,<   ,<   ,   ,~   Z   ,~   ,<   ,<  8$  83B   +   ",<   "  9XB  	Z   XB  Z   ,~   Z  !3B  9+   %XB     6XB  "Z  %2B  9+   -   6XB   3B   +   Z  $,<  ,<   Z   F  :XB  )   6XB  %+   %Z  +2B  :+   1,<   ,<   ,   ,~   ,<   ,<   $  ;,~   .1,! V 5'U@@     (VARIABLE-VALUE-CELL PREV . 91)
(VARIABLE-VALUE-CELL FIRST . 89)
(VARIABLE-VALUE-CELL EXPR . 40)
(VARIABLE-VALUE-CELL CONTEXT . 85)
(NIL VARIABLE-VALUE-CELL FIELD . 79)
(NIL VARIABLE-VALUE-CELL TMP . 67)
'
GLSEPNXT
QUOTE
ATOM
((THE The the) . 0)
MEMB
GLTHE
:
GLGETFIELD
*NIL*
GLIDNAME
(LIST2 SKNNM KT KNIL ENTERF)      h         2 p     0   )    p  0  (  (   H      

GLPARSNFLD BINARY
      -    %    +-.           %@  &  ,~   Z   3B  '+   2B  (+   #XB      (XB  3B   +   
,<   "  )XB   +   Z   3B   +   Z  
-,   +   Z  ,<   [  XB  ,\   B  )   (XB  ,<   "  )XB  	+   Z  3B   +   Z  -,   +   Z  ,<   [  XB  ,\   ,<   ,<   Z   ,<   ,<   (  *XB  +   Z  ,<   ,<   ,   ,~   Z  2B  '+   "Z  B  *,~   Z   B  +,~   ,<   "  ),~   z*$$@R@    (VARIABLE-VALUE-CELL FIRST . 33)
(VARIABLE-VALUE-CELL EXPR . 47)
(VARIABLE-VALUE-CELL CONTEXT . 51)
(NIL VARIABLE-VALUE-CELL TMP . 68)
(NIL VARIABLE-VALUE-CELL UOP . 62)
~
-
GLSEPNXT
GLPARSFLD
GLSEPINIT
GLPUSHEXPR
GLNOTFN
GLMINUSFN
(LIST2 KT SKLST SKA KNIL ENTER0)           `   P   H  H  8 	        

GLPLURAL BINARY
        0    $    /-.           $@  $   ,~   Z   ,<   ,<  &$  'XB   3B   +   Z  ,~   Z  B  'B  (XB   Z  	B  (XB   Z  	,<   ,<  )$  )3B   +   [  Z  ,<   ,<  *$  )2B   +   [  XB  Z  
3B   +   Z  *+   Z  +XB   +   !Z  ,<   ,<  +$  )3B   +   Z  3B   +   Z  ,+   Z  ,XB  +   !Z  3B   +    Z  -+    Z  -XB  ,<   Z  D  .B  (B  .,~   2&O'G     (VARIABLE-VALUE-CELL WORD . 15)
(NIL VARIABLE-VALUE-CELL TMP . 13)
(NIL VARIABLE-VALUE-CELL LST . 67)
(NIL VARIABLE-VALUE-CELL UCASE . 59)
(NIL VARIABLE-VALUE-CELL ENDING . 65)
PLURAL
GETPROP
UNPACK
DREVERSE
U-CASEP
((Y y) . 0)
MEMB
((A a E e O o U u) . 0)
((S E I) . 0)
((s e i) . 0)
((S s X x) . 0)
((S E) . 0)
((s e) . 0)
((S) . 0)
((s) . 0)
APPEND
PACK
(KNIL ENTERF)   0  @  `        

GLPOPFN BINARY
      Q    D    N-.           D@  E  0,~   Z   XB   [  Z  B  HXB   -,   +   Z  2B  H+   Z  ,<   ,<  IZ  ,<  ,   ,<   Z  ,<   ,   ,<   ,<   &  IXB   Z   ,<  ,<  JZ  ,   ,<   [  Z  ,   ,<   ,<   &  IXB   +   ?Z  2B  J+   Z  ,<  ,<  K,<   &  IXB  Z  ,<  Z  ,<  ,<   &  IXB  +   ?Z  ,<  ,<  KZ  ,   F  LXB   3B   +   $Z  ",~   Z  B  LXB   3B   +   -Z   ,<  Z  ,<   Z  %,<   ,   D  MXB  #3B   +   -+   #Z  (,<   ,<  KZ  'F  MXB  +3B   +   1+   #Z  -,<  ,<  IZ  
,<  ,   ,<   Z  $,<   ,   ,<   ,<   &  IXB  Z  .,<  ,<  JZ  1,   ,<   [  5Z  ,   ,<   ,<   &  IXB  ,<  NZ  >,<   Z  8,   ,<   [  ?Z  ,   ,~   	2 ",PI& @       (VARIABLE-VALUE-CELL LHS . 113)
(VARIABLE-VALUE-CELL RHS . 116)
(NIL VARIABLE-VALUE-CELL RHSCODE . 102)
(NIL VARIABLE-VALUE-CELL RHSDES . 119)
(NIL VARIABLE-VALUE-CELL POPCODE . 129)
(NIL VARIABLE-VALUE-CELL GETCODE . 132)
(NIL VARIABLE-VALUE-CELL TMP . 95)
(NIL VARIABLE-VALUE-CELL STR . 82)
GLXTRTYPE
LISTOF
CDR
GLPUTFN
CAR
BOOLEAN
((NIL NIL) . 0)
-_
GLDOMSG
GLGETSTR
GLPOPFN
GLUSERSTROP
PROG1
(ALIST3 CONSNL KNIL ALIST2 KT LIST2 SKLST ENTERF)   B    "    >  , p # `  X   @ = 8  (         7 P + `            

GLPREC BINARY
               -.           @    ,~   Z   Z  7   [  Z  Z  1H  +   2D   +   XB   3B   +   
[  ,~   Z  2B  +   Z"  ,~   Z"  ,~   A$0 (VARIABLE-VALUE-CELL OP . 21)
(NIL VARIABLE-VALUE-CELL TMP . 19)
(((_ . 1) (:= . 1) (__ . 1) (_+ . 2) (__+ . 2) (+_ . 2) (_+_ . 2) (_- . 2) (__- . 2) (-_ . 2) (= . 5) 
(~= . 5) (<> . 5) (AND . 4) (And . 4) (and . 4) (OR . 3) (Or . 3) (or . 3) (/ . 7) (+ . 6) (- . 6) (> 
. 5) (< . 5) (>= . 5) (<= . 5) (^ . 8)) . 0)
*
(ASZ KNIL ENTERF)    P           

GLPREDICATE BINARY
      0      +-.          @   (
,~   Z   2B   +   ,<   Z   ,<  ,<   & XB   +  Z   2B   +   ,< ,< Z   ,<  ,   D +  Z  
,<   ,< $ 3B   +   Z  ,<   [  XB  ,\   Z  ,<   ,< $ 3B   +   Z   XB   Z  ,<   [  XB  ,\   ,<   Z  ,<   ,<   & XB  +  Z  ,<   ,< $ 3B   +  Z  ,<   [  XB   ,\   Z  !,<   ,< $ 3B   +   (Z   XB  Z  ",<   [  &XB  ',\   Z  'B 3B   +   pZ  (,<   [  *XB  +,\   Z  ,,<   [  -XB  .,\   XB   Z  ,<  ,<   ,< &  XB  2B   +  Z  0,<  Z  /,<  ,<  &  XB  23B   +   PZ   3B   +  Z  4-,   +   ?Z  :,<   ,<   Z  5,<   Z  H !+  Z  ;-,   +  Z  ?Z  ,<   ,< !$ 3B   +  Z  A[  Z  -,   +  Z  D[  Z  ,<   Z  G,<   Z  >D "XB   3B   +   M[  KZ  ,<   Z  =,<   Z  JH !+  Z  NB "3B   +   \,< #Z  I,<   Z  P3B   +   Y3B   +   Y-,   +   Y,< #,<   ,   ,   ,<   ,< $,   XB  7+  Z  TB $XB  L3B   +   b,<   Z  S,   ,<   ,< $,   XB  [+  ,< ,< %Z  \,<  ,< %Z  _,<   ,< &[  eZ  ^,  ,   D ,< &Z  f,<   ,< ',< 'Z  c,<   ^"  ,   ,<   ,< $,   XB  a+  Z  .XB   Z  i,<  ,<   ,< (&  XB  o3B   +   xZ  p,<   [  uXB  v,\   +  Z  pB (XB  ]3B   +  Z  v,<   [  zXB  {,\   Z  y,<   Z  q,   ,<   ,< $,   XB  s+  ,< ,< )Z  x,<  ,< )Z  ~,<   ,< *[ Z  ^,  ,   D Z  |,<   [ XB 	,\   ,< &Z ,<   ,< 'Z ,<   ,   ,<   ,< $,   XB  Z  %3B   +  Z B *,<   ,< $,   ,~   Z ,~   !'h  
 HdHFB 5BXJ!H3AH@	dBB         (VARIABLE-VALUE-CELL SOURCE . 278)
(VARIABLE-VALUE-CELL CONTEXT . 158)
(VARIABLE-VALUE-CELL VERBFLG . 6)
(VARIABLE-VALUE-CELL ADDISATYPE . 113)
(VARIABLE-VALUE-CELL EXPR . 275)
(NIL VARIABLE-VALUE-CELL NEWPRED . 297)
(NIL VARIABLE-VALUE-CELL SETNAME . 215)
(NIL VARIABLE-VALUE-CELL PROPERTY . 281)
(NIL VARIABLE-VALUE-CELL TMP . 250)
(NIL VARIABLE-VALUE-CELL NOTFLG . 288)
GLDOEXPR
GLPREDICATE
"The object to be tested was not found.  EXPR ="
GLERROR
((HAS Has has) . 0)
MEMB
((NO No no) . 0)
((IS Is is ARE Are are) . 0)
((NOT Not not) . 0)
GL-A-AN?
ISA
GLADJ
ISASELF
GLADDSTR
((SETQ PROG1) . 0)
GLFINDVARINCTX
GLCLASSP
GLCLASSMEMP
QUOTE
BOOLEAN
GLLISPISA
"IS A adjective"
"could not be found for"
"whose type is"
GLERR
IS
A
ADJ
GLLISPADJ
"The adjective"
"could not be found for"
"whose type is"
GLBUILDNOT
(LIST4 LIST ALIST ALIST2 ALIST3 SKNNM SKLST SKA LIST2 KT KNIL ENTERF) h   `     i            
x      p ;      x b 8 Y H   
h & 8   p    z P ^ 
X R 	H D X :  4 ( % x  X     H      

GLPRETTYPRINTCONST BINARY
        6    +    4-.          +   ,   ,,<  -"  -,<  ."  -Z   ,<   Zp  -,   +   +   'Zp  ,<   @  .   +   %,<   "  ,,<   "  ,,<  /,<   $  -Z   ,<   ,<   $  /Z   ,<   ,<   $  -Z   ,<   ,<   $  /,<  0,<   $  0Z  ,<   ,<  1$  1,<   ,<   "  2,<   ,<   ,<   ,<   ,<   ,  2,<  0,<   $  0Z  ,<   ,<  3$  1,<   ,<   "  2,<   ,<   ,<   ,<   ,<   ,  2,<  3,<   $  -,~   [p  XBp  +   /      ,,<  4"  -   ,   ,Z   ,~   aJZ2LA"|   (VARIABLE-VALUE-CELL LST . 9)
(VARIABLE-VALUE-CELL LAMBDAFONT . 27)
(VARIABLE-VALUE-CELL DEFAULTFONT . 35)
TERPRI
%[
PRIN1
GLISPCONSTANTS
(VARIABLE-VALUE-CELL X . 58)
"("
CHANGEFONT
3
SPACES
GLISPORIGCONSTVAL
GETPROP
POSITION
PRINTDEF
GLISPCONSTANTTYPE
"  )"
%]
(BHC KNIL SKNLST ENTERF)     0 % 8 # ( "   8  (    8  x  @            

GLPRETTYPRINTGLOBALS BINARY
        -    #    ,-.          #   $   $,<  %"  %,<  &"  %Z   ,<   Zp  -,   +   +   Zp  ,<   @  &   +   ,<   "  $,<   "  $,<  ',<   $  %Z   ,<   ,<   $  'Z   ,<   ,<   $  %Z   ,<   ,<   $  ',<  (,<   $  (Z  ,<   ,<  )$  ),<   ,<   "  *,<   ,<   ,<   ,<   ,<   ,  *,<  +,<   $  %,~   [p  XBp  +   /      $,<  +"  %   $   $Z   ,~   aJZ2Ex     (VARIABLE-VALUE-CELL LST . 9)
(VARIABLE-VALUE-CELL LAMBDAFONT . 27)
(VARIABLE-VALUE-CELL DEFAULTFONT . 35)
TERPRI
%[
PRIN1
GLISPGLOBALS
(VARIABLE-VALUE-CELL X . 42)
"("
CHANGEFONT
3
SPACES
GLISPGLOBALVARTYPE
GETPROP
POSITION
PRINTDEF
"  )"
%]
(BHC KNIL SKNLST ENTERF)     0  8  (    8  x  @            

GLPRETTYPRINTSTRS BINARY
      H    ;    F-.          ;@  <  ,~      =   =,<  >"  >,<  ?"  ?Z   2B   +      =,<  @"  >   =   =Z   ,~   Z  ,<   [  XB  ,\   XB   ,<   ,<  @$  AXB   3B   +   ,<   "  =,<   "  =,<  A,<   $  >Z   ,<   ,<   $  BZ  ,<   ,<   $  >Z   ,<   ,<   $  B,<   "  =,<   "  =,<  B,<   ,<   &  CZ  ,<   ,<   "  C,<   ,<   ,<   ,<   ,<   ,  D[  ,<   Zp  -,   +   &+   8,<   @  D   +   6,<   "  =,<   "  =,<  B,<   ,<   &  CZ   ,<   ,<   $  >,<  E,<   ,<   &  C[  ,Z  ,<   ,<   "  C,<   ,<   ,<   ,<   ,<   ,  D,~   [p  [  XBp  +   $/   ,<  E,<   $  >+   |~ 24"HA+H 0   (VARIABLE-VALUE-CELL LST . 25)
(VARIABLE-VALUE-CELL LAMBDAFONT . 41)
(VARIABLE-VALUE-CELL DEFAULTFONT . 49)
(NIL VARIABLE-VALUE-CELL TMP . 71)
(NIL VARIABLE-VALUE-CELL OBJ . 45)
TERPRI
%[
PRIN1
GLISPOBJECTS
PRINT
%]
GLSTRUCTURE
GETPROP
"("
CHANGEFONT
3
TAB
POSITION
PRINTDEF
(VARIABLE-VALUE-CELL REST . 97)
10
"  )"
(BHC SKNLST KNIL ENTERF)  9    &    : ` 5 P 4 0 0   . H , ( ) 8 # ( "   `  8    H     0        

GLPROGN BINARY
              -.          @    (
,~   Z"   XB   Z   2B   +   	Z   B  ,<   Z   ,<   ,   ,~   ,<   Z   ,<  Z   F  XB   3B   +   Z  Z  ,   XB  [  Z  XB  +   ,<  ,<  Z  ,<  ,   D  Z   ,~   
 $    (VARIABLE-VALUE-CELL EXPR . 36)
(VARIABLE-VALUE-CELL CONTEXT . 19)
(VARIABLE-VALUE-CELL VALBUSY . 21)
(NIL VARIABLE-VALUE-CELL RESULT . 29)
(NIL VARIABLE-VALUE-CELL TMP . 30)
(NIL VARIABLE-VALUE-CELL TYPE . 32)
(NIL VARIABLE-VALUE-CELL GLSEPATOM . 0)
(NIL VARIABLE-VALUE-CELL GLSEPPTR . 7)
DREVERSE
GLDOEXPR
GLPROGN
"Illegal item appears in implicit PROGN.  EXPR ="
GLERROR
(CONS LIST2 KNIL ASZ ENTERF) p   @ 	     P 
  X    @      

GLPROPSTRFN BINARY
     o    [    l-.           [@  ^   ,~   Z   ,<   [  XB  ,\   XB   2B  `+   Z  -,   +   Z  ,<   [  XB  	,\   XB   Z"   XB   Z  
2B   +   Z   ,~   Z  -,   +   VZ  Z  -,   +   VZ  [  3B   +   VZ   ,<   Z  ,<   Z   F  `XB   3B   +   V,<   Z  2B  a+   #,<  aZ  Z  3B   +   !3B   +   !-,   +   !,<  b,<   ,   ,<   ,<  b,   +   R3B  `+   %2B  c+   DZ   2B  c+   6Z  3B   +   -,<  d,<   Z  Z  ,   ,<   ,<  d,<  b,   +   R,<  e,<  e,<  bZ  2B  c+   2   ."   ."   ,   +   4   0."   ,   ,   B  f,   +   R3B  f+   82B  g+   ;,<  gZ  2,<  ,<  b,   +   R2B  h+   ?,<  h,<  bZ  8,<  ,   +   R,<  e,<  e,<  b   =."   ,   ,   B  f,   +   R3B  i+   F2B  i+   RZ   2B   +   IZ  .2B  i+   JZ  j+   JZ  j,<   ,<  bZ  )Z  3B   +   Q3B   +   Q-,   +   Q,<  b,<   ,   ,   +   RZ   D  kXB  ,<   Z  SB  fD  kZ  T,~   Z  K,<   [  VXB  W,\      @."   ,   XB  Y+   D	+l`o0B|_y}
bF     (VARIABLE-VALUE-CELL IND . 41)
(VARIABLE-VALUE-CELL DES . 176)
(VARIABLE-VALUE-CELL DESLIST . 45)
(VARIABLE-VALUE-CELL FLG . 140)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 74)
(NIL VARIABLE-VALUE-CELL DESIND . 143)
(NIL VARIABLE-VALUE-CELL TMP . 171)
(NIL VARIABLE-VALUE-CELL RECNAME . 77)
(NIL VARIABLE-VALUE-CELL N . 181)
RECORD
GLSTRFN
ALIST
GLGETASSOC
QUOTE
*GL*
OBJECT
INTERLISP
fetch
of
CAR
NTH
GLGENCODE
MACLISP
FRANZLISP
CXR
PSL
GetV
PROPLIST
ATOMOBJECT
GETPROP
LISTGET
GLSTRVAL
RPLACA
(ALIST3 MKN LIST4 ALIST2 LIST3 LIST2 SKNNM KT SKLST KNIL ASZ SKA ENTERF)  
  C P   0 B H 2    -    D ` +    ? 0 #    Q    	x     N h      
0 M x ( X  H  `   H   (        

GLPSLTRANSFM BINARY
      h    Z    e-.           Z@  [  ,~   Z   -,   +   Z  ,~   Z  Z  \,   3B   +   Z  ,<   [  [  Z  ,<   [  	Z  ,   XB  +   Z  Z   ,   3B   +   Z  ,<   [  Z  ,<   [  [  [  Z  ,<   [  [  Z  ,   XB  +   Z  2B  \+   ,<  ][  Z  ,<   Z  ][  [  ,   ,   XB  Z  Z  ^,   XB   Z  Z  ^7   [  Z  Z  1H  +   %2D   +   "XB   3B   +   *[  %Z  [   ,   XB  (+   UZ  )2B  _+   0[  *2B   +   0Z  +,<   ,<   ,   XB  -+   UZ  /2B  _+   8[  0[  2B   +   8Z  1,<   [  3Z  ,<   ,<   ,   XB  4+   UZ  72B  `+   DZ  8,<   ,<  `[  92B   +   =Z   +   B[  ;[  2B   +   A[  =Z  +   BZ  ][  ?,   ,   XB  A+   UZ  C2B  a+   SZ  D,<   ,<  a$  bZ  E,<   ,<  b$  cXB  '[  IZ  2B   +   NZ  J,<   ,<   $  c+   UZ  L,<   ,<   [  NZ  ,   ,   D  c+   UZ  G2B  d+   UZ  SB  dZ   3B   +   Y,<  eZ  T,<  ,   ,~   Z  W,~   "  bRHDa30FZ0     (VARIABLE-VALUE-CELL X . 179)
(NIL VARIABLE-VALUE-CELL TMP . 160)
(NIL VARIABLE-VALUE-CELL NOTFLG . 171)
((push PUSH) . 0)
APPLY*
APPLY
LIST
((NLISTP BOUNDP GEQ LEQ IGEQ ILEQ) . 0)
(((MEMB MEMQ) (FMEMB MEMQ) (FASSOC ASSOC) (LITATOM IDP) (GETPROP GET) (GETPROPLIST PROP) (PUTPROP PUT)
 (LISTP PAIRP) (NLISTP PAIRP) (NEQ NE) (IGREATERP GREATERP) (IGEQ LESSP) (GEQ LESSP) (ILESSP LESSP) (
ILEQ GREATERP) (LEQ GREATERP) (IPLUS PLUS) (IDIFFERENCE DIFFERENCE) (ITIMES TIMES) (IQUOTIENT QUOTIENT
) (* CommentOutCode) (MAPCONC MAPCAN) (DECLARE CommentOutCode) (NCHARS FlatSize2) (DREVERSE REVERSIP) 
(STREQUAL String!=) (ALPHORDER String!<!=) (GLSTRGREATERP String!>) (GLSTRGEP String!>!=) (GLSTRLESSP 
String!<) (EQP EQN) (LAST LASTPAIR) (NTH PNth) (NCONC1 ACONC) (U-CASE String!-UpCase) (DSUBST SUBSTIP)
 (BOUNDP UNBOUNDP) (KWOTE MKQUOTE) (UNPACK EXPLODE) (PACK IMPLODE)) . 0)
RETURN
APPEND
ERROR
0
SELECTQ
CASEQ
RPLACA
2
NLEFT
RPLACD
PROG
GLTRANSPROG
NOT
(CONSNL ALIST2 KT LIST3 LIST2 CONS ALIST4 ALIST3 KNIL FMEMB SKNLST ENTERF)  R    R    P    7    Y x   0 ) `   x   8  P   
p N 	@ ? X < p 3 p - p %           x    H      

GLPURE BINARY
             -.           Z   Z  ,   ,~       (VARIABLE-VALUE-CELL X . 3)
((CAR CDR CXR CAAR CADR CDAR CDDR ADD1 SUB1 CADDR CADDDR) . 0)
(FMEMB ENTERF)         

GLPUSHEXPR BINARY
                -.            @  	  ,~   Z"   XB   Z   ,<  Z   ,<  Z   F  
,~      (VARIABLE-VALUE-CELL EXPR . 0)
(VARIABLE-VALUE-CELL START . 8)
(VARIABLE-VALUE-CELL CONTEXT . 10)
(VARIABLE-VALUE-CELL VALBUSY . 12)
(NIL VARIABLE-VALUE-CELL GLSEPATOM . 0)
(NIL VARIABLE-VALUE-CELL GLSEPPTR . 7)
GLDOEXPR
(ASZ ENTERF)  @      

GLPUSHFN BINARY
        n    [    k-.          [@  \  (
,~   Z   XB   [  Z  B  _XB   2B  _+   Z   Z$   ,   3B   +   ,<  `Z  ,<   ,   XB   +   UZ  -,   +   [  Z  2B  _+   ,<  `Z  
,<   Z  ,   XB  +   U,<  aZ  ,<   Z  ,   XB  +   U3B  a+   2B  b+   ,<  aZ  ,<  Z  ,   XB  +   U2B  b+   !,<  cZ  ,<  Z  ,   XB  +   U2B   +   .,<  cZ  ,<   Z  ,<   ,   XB   Z  #-,   +   U[  "Z  3B   +   UZ  %,<   ,<   ,<  d[  'Z  ,   ,<   Z   H  d+   U-,   +   6Z  ,<   ,<  e$  e3B   +   6,<  cZ  +,<   Z  ),<   ,   XB  %+   UZ  ,<   Z  3,<  ,<  f&  fXB   3B   +   <Z  9,~   Z  6,<  ,<  gZ  7,   F  gXB  ;3B   +   A+   ;Z  <,<  ,<  hZ  =,   F  gXB  ?3B   +   GZ  DXB  5+   UZ  /B  hXB   3B   +   OZ  A,<   Z  H,<   ,   ,<   Z  BD  iXB  E3B   +   O+   ;Z  I,<   ,<  gZ  LF  iXB  M3B   +   T+   ;Z   ,~   Z  O,<   Z  FB  j,<   Z  G,<   ,   ,<   ,<   &  j,~   	Ap,&`CII	J0 @    (VARIABLE-VALUE-CELL LHS . 170)
(VARIABLE-VALUE-CELL RHS . 162)
(VARIABLE-VALUE-CELL CONTEXT . 90)
(NIL VARIABLE-VALUE-CELL LHSCODE . 104)
(NIL VARIABLE-VALUE-CELL LHSDES . 175)
(NIL VARIABLE-VALUE-CELL NCCODE . 172)
(NIL VARIABLE-VALUE-CELL TMP . 164)
(NIL VARIABLE-VALUE-CELL STR . 149)
GLXTRTYPE
INTEGER
ADD1
IPLUS
PLUS
NUMBER
REAL
BOOLEAN
OR
CONS
LISTOF
GLADDSTR
((LIST CONS LISTOF) . 0)
MEMB
PUSH
GLUNITOP
+_
GLDOMSG
+
GLGETSTR
GLPUSHFN
GLUSERSTROP
GLGENCODE
GLPUTFN
(KT CONSNL SKLST ALIST2 SKA LIST3 ALIST3 SKNI LIST2 KNIL EQP ASZ ENTERF)   Z    D p   x   P   p   ` %      @  0   `    L @   
P S 	p I X @ 0 2 0 )   	    	           

GLPUTARITH BINARY
        ]    O    Z-.           O@  P  (
,~   Z   XB   Z  XB   Z  Z  S7   [  Z  Z  1H  +   
2D   +   XB   2B   +   Z   ,~   Z  3B  S+   3B  T+   3B  T+   2B  U+   [  
Z  ,<   Z   ,   XB   [  Z  XB   +   D3B  U+   3B  V+   3B  V+   3B  W+   3B  W+   3B  X+   3B  X+   2B  Y+   ;[  [  Z  -,   +   '[  Z  ,<   Z  ,<   [  [  Z  ,   XB  [  #Z  XB  +   D[  %Z  -,   +   DZ  3B  V+   .3B  X+   .3B  W+   .2B  Y+   4,<   [  'Z  ,<   Z  ",   XB  %[  .[  Z  XB  &+   D[   Z  ,<   Z  0,<   [  1Z  ,   XB  1[  6[  Z  XB  3+   D2B  Y+   D[  8[  Z  Z$  ,   3B   +   D[  4Z  ,<   Z  5,   XB  8[  <Z  XB  :Z  C3B   +   NZ  B3B   +   NZ  D,<  [  Z  ,   ,<   Z  E,<   [  AZ  ,   ,<   ,<   &  Z,~   Z   ,~   
#~ p@~            (VARIABLE-VALUE-CELL LHS . 144)
(VARIABLE-VALUE-CELL RHS . 150)
(NIL VARIABLE-VALUE-CELL LHSC . 133)
(NIL VARIABLE-VALUE-CELL OP . 83)
(NIL VARIABLE-VALUE-CELL TMP . 127)
(NIL VARIABLE-VALUE-CELL NEWLHS . 142)
(NIL VARIABLE-VALUE-CELL NEWRHS . 148)
(((PLUS DIFFERENCE) (MINUS MINUS) (DIFFERENCE PLUS) (TIMES QUOTIENT) (QUOTIENT TIMES) (IPLUS 
IDIFFERENCE) (IMINUS IMINUS) (IDIFFERENCE IPLUS) (ITIMES IQUOTIENT) (IQUOTIENT ITIMES) (ADD1 SUB1) (
SUB1 ADD1) (EXPT SQRT)) . 0)
ADD1
SUB1
MINUS
IMINUS
PLUS
DIFFERENCE
TIMES
QUOTIENT
IPLUS
IDIFFERENCE
ITIMES
IQUOTIENT
EXPT
GLPUTFN
(EQUAL ASZ ALIST3 SKNM ALIST2 KNIL ENTERF)   ?    >    8  %    )    	P J (     O 	` G X ? H         

GLPUTFN BINARY
   V   8   P-.          8@ :  (
,~   Z   XB   -,   +   Z  ,<  ,< <Z   ,   F =2B   +  8Z  ,<   ,< <Z  F =2B   +  8[  	Z  2B   +   [  
Z  3B   +   Z  ,<   [  Z  ,   ,<   ,< <Z  F =2B   +  8Z  ,<   Z  D >,~   Z  XB   2B >+   0Z   3B   +   +[  Z  B ?3B   +   +,< ?  @XB   ,<   [  Z  ,   ,   ,<   ,< @,< >,< AZ  ,<   ,<   [   Z  ,<   Z  F A,   ,   ,   ,   +   /,< >,< A[  &Z  ,<   Z  ',   ,   XB   +  32B B+   FZ  3B   +   A[  ,Z  B ?3B   +   A,< ?  @XB  $,<   [  2Z  ,   ,   ,<   ,< @,< B,< BZ  6,<   ,<   [  7Z  ,<   Z  -F A,   ,   ,   ,   +   E,< B,< B[  <Z  ,<   Z  >,   ,   XB  /+  3Z  Z C7   [  Z  Z  1H  +   K2D   +   HXB   3B   +   fZ  13B   +   `[  BZ  B ?3B   +   `,< ?  @XB  ;,<   [  K,<   [  NZ  ,   ,   ,   ,<   ,< @,< >,< AZ  R,<   ,< >,<   ,   ,<   Z  T,<   Z  DF A,   ,   ,   ,   +   e,< >,< A[  S,<   [  [Z  ,   ,<   Z  \,   ,   XB  E+  3Z  F2B C+   o,< C,< D[  bZ  ,<   [  i[  Z  ,<   Z  d,   ,   XB  e+  32B D+   v,< E[  jZ  ,<   [  p[  Z  ,<   Z  l,   XB  n+  3,<   ,< E$ F3B   +   ~,< F[  rZ  ,<   [  y[  Z  ,<   Z  t,   XB  u+  3Z  f2B G+  ,< G[  zZ  ,<   [  [  Z  ,<   Z  |,   XB  }+  32B H+  ,< H[ Z  ,<   Z ,<   [ [  Z  ,   XB +  32B I+  ,< I[ 
Z  ,<   Z 	,   XB +  32B J+  ,< J[ Z  ,<   ,< K[ [  [  Z  ,<   ,< KZ ^,  ,   XB +  3Z  ,<  Z ,<  ,< L& LXB  a3B   +   Z ,~   Z ,<  ,< <Z ,   F =XB 3B   +  %+  Z  ,<  ,< <Z "F =XB #3B   +  *+  Z %,<  Z 'D MXB (3B   +  .+  ,< M,< NZ *,<  ,< NZ +,<  ,   D O,~   Z B O,<   [ /Z  2B   +  7[ 0Z  ,   ,~   )(D
D2.@!`K p8.  ``l \ < <Cb<D         (VARIABLE-VALUE-CELL LHS . 361)
(VARIABLE-VALUE-CELL RHS . 365)
(VARIABLE-VALUE-CELL OPTFLG . 154)
(NIL VARIABLE-VALUE-CELL LHSD . 299)
(NIL VARIABLE-VALUE-CELL LNAME . 253)
(NIL VARIABLE-VALUE-CELL TMP . 344)
(NIL VARIABLE-VALUE-CELL RESULT . 358)
(NIL VARIABLE-VALUE-CELL TMPVAR . 177)
_
GLDOMSG
GLUSERSTROP
GLDOVARSETQ
CAR
GLEXPENSIVE?
PROG
GLMKVAR
RETURN
RPLACA
SUBST
CDR
RPLACD
(((CADR . CDR) (CADDR . CDDR) (CADDDR . CDDDR)) . 0)
CXR
RPLACX
GetV
PutV
((GET GETPROP) . 0)
MEMB
PUTPROP
LISTGET
LISTPUT
GLGETASSOC
PUTASSOC
EVAL
SET
fetch
replace
of
with
PUT
GLUNITOP
GLPUTARITH
GLPUTFN
"Illegal assignment.  LHS ="
"RHS ="
GLERROR
GLGENCODE
(LIST4 ALIST ALIST4 LIST2 ALIST3 ALIST2 KNIL CONSNL SKA ENTERF)  (   (   H ` u `   8    e   ^ X A   / 0 )   8 h f @ _ p V 
` F  @  / ( * (    6 X) P  Q 	h M 	8 5 (  @    H 	   # 
p 9 0            

GLPUTPROPS BINARY
                -.          @    ,~   Z   2B   +   Z   ,~   Z  ,<   [  XB  ,\   XB   ,<   Z   ,<  Z   F  XB   3B   +   Z   ,<  ,<  ,<  Z  3B   +   3B   +   -,   +   ,<  ,<   ,   ,<   Z  ,<   ,   B  ,   D  +     IJ@X   (VARIABLE-VALUE-CELL PROPLIS . 14)
(VARIABLE-VALUE-CELL PREVLST . 20)
(VARIABLE-VALUE-CELL PAIRLIST . 18)
(VARIABLE-VALUE-CELL PROGG . 25)
(NIL VARIABLE-VALUE-CELL TMP . 29)
(NIL VARIABLE-VALUE-CELL TMPCODE . 40)
GLBUILDSTR
PUTPROP
ATOMNAME
QUOTE
GLGENCODE
NCONC
(CONSNL LIST4 LIST2 SKNNM KT KNIL ENTERF)                        H   H      

GLPUTUPFN BINARY
       =    1    ;-.          1@  3  ,~   Z   ,<   ,<  4$  5XB   2B   +   
,<  5Z  ,<  ,   ,<   ,<  6$  6Z   -,   +   !,<  7Zp  -,   +   Zp  Z 7@  7   Z  2B  7+   ,<p  ,<   Z   F  8B  83B   +   Z   +   Z   /   3B   +   !Z  
,<   Z   D  5XB   3B   +   ![  ,<   [  Z  ,<   [  Z  ,   ,<   Z   F  9,~   Z  -,   +   -Z  !Z  2B  9+   -Z  "[  Z  -,   +   -[  ,<   Z  $[  Z  ,<   [  (Z  ,   ,<   Z  F  9,~   ,<  5,<  :Z  *,<   ,   D  :,~   325H DB       (VARIABLE-VALUE-CELL OP . 14)
(VARIABLE-VALUE-CELL LHS . 93)
(VARIABLE-VALUE-CELL RHS . 88)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 36)
(VARIABLE-VALUE-CELL GLPROGLST . 49)
(NIL VARIABLE-VALUE-CELL TMP . 56)
(NIL VARIABLE-VALUE-CELL TMPOP . 78)
(((__ . _) (__+ . _+) (__- . _-) (_+_ . +_)) . 0)
ASSOC
GLPUTUPFN
" Illegal operator."
ERROR
GLPROGLST
NOBIND
STKSCAN
RELSTK
GLREDUCEOP
PROG1
"A self-assignment __ operator is used improperly.  LHS ="
GLERROR
(SKLST ALIST2 BHC KT KNOB SKLA SKA LIST2 KNIL ENTERF)  "    , x   p   X       X   p     0    0  h  (        

GLREDUCE BINARY
     0    (    /-.           (@  )  ,~   Z   ,<   [  XB  ,\   XB   Z   ,<   [  XB  ,\   XB   ,<   ,<  *$  *3B   +   Z  ,<   Z  ,<   [  XB  ,\   ,<   Z  F  ++   %Z  Z  +,   3B   +   Z  ,<   Z  ,<   [  XB  ,\   ,<   Z  F  ,+   %Z  2B  ,+   Z  B  -+   %2B  -+   Z  B  .+   %,<   Z  ,<   [  XB   ,\   Z  ,<   Z  ,   B  .,<   ,<   ,   Z   ,   XB  %Z   ,~     7X      (VARIABLE-VALUE-CELL OPNDS . 77)
(VARIABLE-VALUE-CELL OPERS . 15)
(NIL VARIABLE-VALUE-CELL RHS . 69)
(NIL VARIABLE-VALUE-CELL OPER . 50)
((_ := _+ +_ _- -_ = ~= <> AND And and OR Or or __+ __ _+_ __-) . 0)
MEMB
GLREDUCEOP
((+ - * / > < >= <= ^) . 0)
GLREDUCEARITH
MINUS
GLMINUSFN
~
GLNOTFN
GLGENCODE
(CONS LIST2 ALIST3 FMEMB KNIL ENTER0)   '    &    $        ( X  8      

GLREDUCEARITH BINARY
       s   R   l-.          R@ T  8,~   Z WXB   Z XXB   Z XXB   Z YXB   [   Z  B YXB   [   Z  B YXB   Z  2B Z+   Z  
2B Z+   Z   Z  7   [  Z  Z  1H  +   2D   +   XB   2B   +   !Z  ,<   Z  D Z3B   +   >Z  ,<   Z  D Z3B   +   >Z  Z  7   [  Z  Z  1H  +   2D   +   XB  3B   +   >Z  -,   +   (Z  	-,   +   ([  ,<   Z  !,<   Z  ",   B [B [+   8[  $2B \+   .Z  &Z$   ,   3B   +   .,< \Z  %,   +   7[  (2B ]+   4Z  *Z$   ,   3B   +   4,< ]Z  -,   +   7[  .,<   Z  3,<   Z  0,   B [,<   [  4,<   Z  D Z3B   +   <Z ^+   =Z  ,   ,~   Z  <2B ^+   TZ  3B ^+   C,< _Z _,   D `,~   Z  Z `7   [  Z  Z  1H  +   H2D   +   EXB  83B   +   Q[  HZ  ,<   Z  5,<   Z  6,   B [,<   [  J[  Z  ,   ,~   ,< _Z  C,<  ,< a,   D `,~   -,   +  
Z  >2B a+  
Z  ?-,   +   sZ  W2B a+   s[  UZ  [  XZ  ,   2B   +   b,< _,< b[  ZZ  ,<   [  [Z  ,   D `,~   Z  QZ b7   [  Z  Z  1H  +   g2D   +   dXB  N3B   +   o[  gZ  ,<   Z  K,<   Z  L,   B [,<   Z  ^,<   ,   ,~   ,< _,< cZ  b,<  ,< c,   D `,~   [  mZ  Z  `,   3B   +  Z  pZ d,   3B   +  Z  v2B d+   {Z e+  2B e+   }Z f+  2B f7   7   +  Z  t2B g+  Z Z+  Z g,<   Z  k,<   Z  j,   B [,<   Z  s,<   ,   ,~   ,< _Z h,   D `,~   Z  -,   +   Z 
2B a+   [ Z  Z ,   3B   +   Z  yZ h,   3B   +   Z 2B d+  Z e+  2B i7   7   +  Z 2B g+  Z Z+  Z g,<   Z ,<   Z ,   B [,<   Z ,<   ,   ,~   Z ,<   Z ,<  Z ,   F iXB  i3B   +  &Z #,~   Z  ,<  Z !,<  Z "F jXB %3B   +  ++  %Z B jXB )3B   +  6Z ',<  Z &,<   Z ,,<   ,   ,<   Z (,<   Z B j2B   +  5Z 2,   F _,~   Z -Z  7   [  Z  Z  1H  +  ;2D   +  8XB /3B   +  MZ +3B   +  CZ 43B   +  C,< _,< kZ =,<  ,<   ,   D `[ ;,<   Z .,<   Z 1,   B [,<   [ C,<   Z  9D Z3B   +  KZ ^+  LZ k,   ,~   ,< _Z 6,<  Z D,<  Z E,<  ,   B lZ   ,~   * $(P
$l0d.tAHRe`$
  e%`AQ0R|_  HI!<@            (VARIABLE-VALUE-CELL OP . 411)
(VARIABLE-VALUE-CELL LHS . 413)
(VARIABLE-VALUE-CELL RHS . 415)
(NIL VARIABLE-VALUE-CELL TMP . 399)
(NIL VARIABLE-VALUE-CELL OPLIST . 366)
(NIL VARIABLE-VALUE-CELL IOPLIST . 29)
(NIL VARIABLE-VALUE-CELL PREDLIST . 401)
(NIL VARIABLE-VALUE-CELL NUMBERTYPES . 49)
(NIL VARIABLE-VALUE-CELL LHSTP . 386)
(NIL VARIABLE-VALUE-CELL RHSTP . 381)
(((+ . PLUS) (- . DIFFERENCE) (* . TIMES) (/ . QUOTIENT) (> . GREATERP) (< . LESSP) (>= . GEQ) (<= . 
LEQ) (^ . EXPT)) . 0)
(((+ . IPLUS) (- . IDIFFERENCE) (* . ITIMES) (/ . IQUOTIENT) (> . IGREATERP) (< . ILESSP) (>= . IGEQ) 
(<= . ILEQ)) . 0)
((GREATERP LESSP GEQ LEQ IGREATERP ILESSP IGEQ ILEQ) . 0)
((INTEGER REAL NUMBER) . 0)
GLXTRTYPE
INTEGER
MEMB
GLGENCODE
EVAL
IPLUS
ADD1
IDIFFERENCE
SUB1
BOOLEAN
STRING
GLREDUCEARITH
"operation on string and non-string"
GLERROR
(((+ CONCAT STRING) (> GLSTRGREATERP BOOLEAN) (>= GLSTRGEP BOOLEAN) (< GLSTRLESSP BOOLEAN) (<= 
ALPHORDER BOOLEAN)) . 0)
"is an illegal operation for strings."
LISTOF
"Operations on lists of different types"
(((+ UNION) (- LDIFFERENCE) (* INTERSECTION)) . 0)
"Illegal operation"
"on lists."
((+ - >=) . 0)
+
CONS
-
REMOVE
>=
ATOM
MEMBER
"Illegal operation on list."
((+ <=) . 0)
<=
GLDOMSG
GLUSERSTROP
GLXTRTYPEC
"Warning: Arithmetic operation on non-numeric arguments of types:"
NUMBER
ERROR
(LIST4 KT FMEMB LIST3 EQUAL SKLST LIST2 CONSNL ALIST2 EQP ASZ ALIST3 SKNM KNIL ENTERF)     x        8 s    ` ]     U   1   x T   #   C   M ` Q ` 4 h     ,    1 8   p X m   N   '    $ (   (J  > P; H- (% p    v  g X J 	 ; ( ,   (  H        

GLREDUCEOP BINARY
        '         &-.            @  !  ,~   Z   Z  ",   3B   +   	Z   ,<   Z   ,<  ,<   &  ",~   Z  Z  #7   [  Z  Z  1H  +   2D   +   
XB   3B   +   [  ,<   Z  ,<   Z  ,<   "  ,   ,~   Z  	,<  ,<  #$  $3B   +   Z  ,<   Z  ,<  Z  F  $,~   ,<  %Z  ,<   Z  ,<  Z  ,<  ,   B  %Z   ,~   HP(      (VARIABLE-VALUE-CELL OP . 54)
(VARIABLE-VALUE-CELL LHS . 56)
(VARIABLE-VALUE-CELL RHS . 58)
(NIL VARIABLE-VALUE-CELL TMP . 31)
((_ :=) . 0)
GLPUTFN
(((_+ . GLNCONCFN) (+_ . GLPUSHFN) (_- . GLREMOVEFN) (-_ . GLPOPFN) (= . GLEQUALFN) (~= . GLNEQUALFN) 
(<> . GLNEQUALFN) (AND . GLANDFN) (And . GLANDFN) (and . GLANDFN) (OR . GLORFN) (Or . GLORFN) (or . 
GLORFN)) . 0)
((__ __+ __- _+_) . 0)
MEMB
GLPUTUPFN
GLREDUCEOP
ERROR
(LIST4 EVCC KNIL FMEMB ENTERF) p   @      x              

GLREMOVEFN BINARY
        W    F    T-.           F@  G  (
,~   Z   XB   [  Z  B  JXB   2B  J+   Z   Z$   ,   3B   +   ,<  KZ  ,<   ,   XB   +   A,<  KZ  
,<   Z  ,   XB  +   A3B  L+   2B  L+   ,<  MZ  ,<  Z  ,   XB  +   A2B  M+   ,<  NZ  ,<  ,<  NZ  ,   ,   XB  +   A3B   +   -,   +   "Z  2B  O+   ",<  OZ  ,<   Z  ,<   ,   XB  +   AZ  ,<   Z  ,<  ,<  O&  PXB   3B   +   (Z  %,~   Z  ",<  ,<  PZ  #,   F  QXB  '3B   +   -+   'Z  (,<  ,<  QZ  ),   F  QXB  +3B   +   3Z  0XB  !+   AZ  B  RXB   3B   +   ;Z  -,<   Z  4,<   ,   ,<   Z  .D  RXB  13B   +   ;+   'Z  5,<   ,<  PZ  8F  SXB  93B   +   @+   'Z   ,~   Z  ;,<  B  S,<   Z  3,<   ,   ,<   ,<   &  T,~   Ar
\2	)&     (VARIABLE-VALUE-CELL LHS . 130)
(VARIABLE-VALUE-CELL RHS . 122)
(NIL VARIABLE-VALUE-CELL LHSCODE . 64)
(NIL VARIABLE-VALUE-CELL LHSDES . 134)
(NIL VARIABLE-VALUE-CELL NCCODE . 100)
(NIL VARIABLE-VALUE-CELL TMP . 124)
(NIL VARIABLE-VALUE-CELL STR . 109)
GLXTRTYPE
INTEGER
SUB1
IDIFFERENCE
NUMBER
REAL
DIFFERENCE
BOOLEAN
AND
NOT
LISTOF
REMOVE
GLUNITOP
_-
GLDOMSG
-
GLGETSTR
GLREMOVEFN
GLUSERSTROP
GLGENCODE
GLPUTFN
(KT CONSNL LIST3 SKLST ALIST2 ALIST3 LIST2 KNIL EQP ASZ ENTERF)  `     +    "             P     E      A x ; X 1 H ' @ 	    	           

GLRESGLOBAL BINARY
       3    (    1-.          0 (Z   -,   +   Z   ,~   Z  Z  ,<   ,<  +$  ,3B   +   Z  [  Z  B  ,3B   +   Z  [  [  2B   +   Z   ,<   ,<  -Z  
[  Z  ,<   Z   D  -XB   F  .Z  ,<   [  XB  ,\   ,~   ,<  .,<  /Z  ,   D  /Z  ,<   [  XB  ,\   ,~   Z  Z  ,<   ,<  0$  ,3B   +   (Z  [  ,<   ,<   ,<   Z   ,<   ,<   *  0XB   Z  ,<  ,<  1F  .Z  ,<   [  %XB  &,\   ,~   EA@d h0    (VARIABLE-VALUE-CELL GLEXPR . 78)
(VARIABLE-VALUE-CELL GLAMBDAFN . 71)
(VARIABLE-VALUE-CELL GLTYPESUBS . 33)
(VARIABLE-VALUE-CELL RESULTTYPE . 35)
(VARIABLE-VALUE-CELL GLTOPCTX . 66)
(VARIABLE-VALUE-CELL GLGLOBALVARS . 70)
((RESULT Result result) . 0)
MEMB
GLOKSTR?
GLRESULTTYPE
GLSUBSTTYPE
PUTPROP
GLCOMP
"Bad RESULT structure declaration:"
GLERROR
((GLOBAL Global global) . 0)
GLDECL
GLGLOBALS
(ALIST2 KNIL SKNLST ENTER0)       #  ! h  (   @    0      

GLRESULTTYPE BINARY
    <    0    :-.          0@  2   ,~   Z   ,<   ,<  4$  4XB   3B   +   Z  ,~   Z  ,<  ,<  5$  4XB   3B   +   ,<   Z  ,<  Z   ,<   "  ,   ,~   Z  B  5XB  	3B   +   ,<   Z  D  6,~   Z  B  6XB   -,   +   Z  Z  7,   2B   +   Z   ,~   [  [  XB  Z  3B   +   Z  -,   +   +   Z   2B  7+   "Z  Z  3B  8+   %Z   Z  ,<   ,<  8$  93B   +   (Z  ",<   [  %XB  &,\   +   Z  'Z  ,<   ,<  9$  93B   +   Z  ([  Z  XB   B  :3B   +   Z  -,~   2@	$RP#!       (VARIABLE-VALUE-CELL ATM . 39)
(VARIABLE-VALUE-CELL ARGTYPES . 36)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 61)
(NIL VARIABLE-VALUE-CELL TYPE . 13)
(NIL VARIABLE-VALUE-CELL FNDEF . 88)
(NIL VARIABLE-VALUE-CELL STR . 95)
(NIL VARIABLE-VALUE-CELL TMP . 32)
GLRESULTTYPE
GETPROP
GLRESULTTYPEFN
GLANYCARCDR?
GLCARCDRRESULTTYPE
GLGETDB
((LAMBDA GLAMBDA) . 0)
INTERLISP
*
((GLOBAL Global global) . 0)
MEMB
((RESULT Result result) . 0)
GLOKSTR?
(SKNLST FMEMB SKLST EVCC KNIL ENTERF)                   / @ % H    0        

GLSENDB BINARY
               -.            @    ,~   Z   B  XB   2B   +   ,<  Z  ,<  ,<  ,   B  Z  ,<   Z   ,<  Z  Z   ,   ,<   Z   H  XB   3B  +   Z  ,~   ,<  Z  	,<  ,<  Z  
,<  ,<  Z  ,<  ,<  ^"  ,   B  Z   ,~   LPd    (VARIABLE-VALUE-CELL OBJ . 36)
(VARIABLE-VALUE-CELL SELECTOR . 33)
(VARIABLE-VALUE-CELL PROPTYPE . 25)
(VARIABLE-VALUE-CELL ARGS . 22)
(NIL VARIABLE-VALUE-CELL CLASS . 39)
(NIL VARIABLE-VALUE-CELL RESULT . 30)
GLCLASS
"Object"
"has no Class."
ERROR
GLCLASSSEND
GLSENDFAILURE
"Message"
"to object"
"of class"
"not understood."
(LIST CONS LIST3 KNIL ENTERF)                 X      

GLSEPCLR BINARY
                -.           Z"   XB   ,~       (VARIABLE-VALUE-CELL GLSEPPTR . 4)
(ASZ ENTER0)    (      

GLSEPINIT BINARY
               -.          Z   XB   Z"   XB   Z   ,~       (VARIABLE-VALUE-CELL ATM . 3)
(VARIABLE-VALUE-CELL GLSEPATOM . 4)
(VARIABLE-VALUE-CELL GLSEPPTR . 6)
(KNIL ASZ ENTERF)              

GLSEPNXT BINARY
     ^    S    [-.            S@  U  ,~   Z   0B   +   Z   ,~   Z   2B   +   	Z"   XB  Z  V,~   -,   +   XB   Z"   XB  Z  
,~   Z   ,<  ,<   Z  F  VXB   Z  2B   +    Z  Z$   ,   3B   +   Z  +      ,>  R,>   Z  B  W,       ,^   /   3b  +   Z   +   Z  ,<   Z  ,<  B  WF  W,<   Z"   XB  ,\   ,~   Z  ,<  Z  ,<     !."  ,   F  WXB  ,<   ,<  X$  X3B   +   *   "."  ,   XB  '+   Z   ,<   Z  ),<     +."   ,   F  WXB  $,<   ,<  Y$  X3B   +   3   ,."  ,   XB  1+   Z   2B   +   AZ  *,<  Z  D  Y2B  Z+   AZ  5,<      6."   ,   D  Y3B  Z+   AZ  ,<   Z  8,<     9."   ,   F  VXB  >+      @,>  R,>      2    ,^   /   3b  +   LZ  =,<   Z  B,<     A/"   ,   F  W,<   Z  GXB  F,\   ,~   Z  E,<   Z  J,<  ,<  &  W,<      M."   ,   XB  O,\   ,~      ! "(0 M48P        (VARIABLE-VALUE-CELL GLSEPPTR . 162)
(VARIABLE-VALUE-CELL GLSEPATOM . 152)
(VARIABLE-VALUE-CELL GLSEPBITTBL . 120)
(VARIABLE-VALUE-CELL GLSEPMINUS . 103)
(NIL VARIABLE-VALUE-CELL END . 148)
(NIL VARIABLE-VALUE-CELL TMP . 92)
*NIL*
STRPOSL
NCHARS
GLSUBATOM
((__+ __- _+_) . 0)
MEMB
((:= __ _+ +_ _- -_ ~= <> >= <=) . 0)
NTHCHAR
-
_
(MKN BHC IUNBOX EQP SKNM KNIL ASZ ENTER0)   
 I   ; 0 .  $    E        0       P 1 x  8   p      (           

GLSKIPCOMMENTS BINARY
            -.           Z   -,   +   Z  -,   +   Z   2B  +   Z  Z  3B  +   
Z  Z  2B  +   Z  ,<   [  
XB  ,\   +   Z   ,~   ,f (VARIABLE-VALUE-CELL GLEXPR . 23)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 9)
INTERLISP
*
COMMENT
(KNIL SKLST ENTER0)   `    H        

GLSTRFN BINARY
          k    {-.          k@  m   ,~   Z   Z   ,   3B   +   Z   ,~   Z  Z  ,   XB  Z  3B   +   Z   2B   +   +   Z  -,   +   -,   +   %[  Z  -,   +   %Z  B  o3B   +   %[  Z  XB  3B   +   %B  pXB   3B   +   Z  
,<  ,<   Z  F  p,~   Z  B  qXB   3B   +   ,<   Z  ,<  Z  F  q,~   Z  Z  2B  +   $,<   [   Z  ,   ,~   Z   ,~   Z  "-,   +   ),<  p,<  r,<   ,   D  rZ  %XB   Z  Z  )3B  +   .Z  )Z  *2B  +   0,<   [  *Z  ,   ,~   2B  s+   :Z  ,,<  [  .Z  ,<   ,<  s&  t2B   +   kZ  1,<   [  2[  Z  ,<   ,<  t&  t,~   3B  u+   <2B  u+   @Z  6,<  Z  7,<  Z  F  v,~   3B  v+   E3B  w+   E3B  w+   E3B  x+   E2B  x+   IZ  <,<  Z  =,<  Z  >,<  ,<   (  y,~   2B  y+   NZ  E,<  Z  F,<  Z  GF  z,~   2B  z+   SZ  J,<  [  KZ  ,<   Z  LF  p,~   ,<   Z   D  {XB   3B   +   ^[  TZ  3B   +   ^[  VZ  ,<   Z  O,<   Z  P,<  Z  Q,<   "  ,   ,~   [  Z3B   +   f[  ^Z  -,   +   f[  _Z  -,   +   g[  aZ  Z  B  o3B   +   gZ   ,~   Z  Y,<   [  cZ  ,<   Z  [F  p,~   2ECI"^`,	 D(     (VARIABLE-VALUE-CELL IND . 207)
(VARIABLE-VALUE-CELL DES . 209)
(VARIABLE-VALUE-CELL DESLIST . 212)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 167)
(NIL VARIABLE-VALUE-CELL DESIND . 88)
(NIL VARIABLE-VALUE-CELL TMP . 176)
(NIL VARIABLE-VALUE-CELL STR . 43)
(NIL VARIABLE-VALUE-CELL UNITREC . 54)
GL-A-AN?
GLGETSTR
GLSTRFN
GLUNIT?
GLGETFROMUNIT
"Bad structure specification"
GLERROR
CONS
((CAR *GL*) . 0)
GLSTRVALB
((CDR *GL*) . 0)
LIST
LISTOBJECT
GLLISTSTRFN
PROPLIST
ALIST
RECORD
ATOMOBJECT
OBJECT
GLPROPSTRFN
ATOM
GLATOMSTRFN
TRANSPARENT
ASSOC
(EVCC LIST2 SKNLST ALIST2 SKA SKLST SKNA CONS KNIL FMEMB ENTERF)  ^    )    &    0 @      8     a X      x f x X 
` I ` / P " H  P  8 
  h            

GLSTRPROP BINARY
    0    &    /-.           &@  (  0,~   Z   B  +XB   2B   +   Z   ,~   ,<   ,<  +$  ,XB   3B   +   [  ,<   Z   D  ,XB   3B   +   Z   ,<  D  -XB   3B   +   Z  ,~   [  	,<   ,<  -$  ,XB   Z  3B   +   Z  ,<   Z  
,<   Z  F  .XB  3B   +   +   [  XB  +   Z  B  .XB   3B   +   [  [  [  Z  ,<   Z  ,<   Z  ,<  Z  ,<   "  ,   XB  3B   +   +   Hd$Hbe     (VARIABLE-VALUE-CELL STR . 6)
(VARIABLE-VALUE-CELL GLPROP . 67)
(VARIABLE-VALUE-CELL PROP . 69)
(NIL VARIABLE-VALUE-CELL STRB . 65)
(NIL VARIABLE-VALUE-CELL UNITREC . 60)
(NIL VARIABLE-VALUE-CELL GLPROPS . 34)
(NIL VARIABLE-VALUE-CELL PROPL . 23)
(NIL VARIABLE-VALUE-CELL TMP . 73)
(NIL VARIABLE-VALUE-CELL SUPERS . 53)
GLXTRTYPE
GLSTRUCTURE
GETPROP
LISTGET
ASSOC
SUPERS
GLSTRPROP
GLUNIT?
(EVCC KNIL ENTERF)  P   `          X      

GLSTRVAL BINARY
            
    -.           
Z   3B   +   Z  ,<   Z   ,<  ,<  Z  F  D  +   	Z  ,<   Z  D  Z  ,~   D  (VARIABLE-VALUE-CELL OLDFN . 19)
(VARIABLE-VALUE-CELL NEW . 17)
*GL*
SUBST
RPLACA
(KNIL ENTERF)  0      

GLSTRVALB BINARY
               -.          @    ,~   Z   ,<   Z   ,<  Z   F  XB   3B   +   
,<   Z   B  D  ,~   Z   ,~   L  (VARIABLE-VALUE-CELL IND . 6)
(VARIABLE-VALUE-CELL DES . 8)
(VARIABLE-VALUE-CELL NEW . 16)
(VARIABLE-VALUE-CELL DESLIST . 10)
(NIL VARIABLE-VALUE-CELL TMP . 12)
GLSTRFN
COPY
GLSTRVAL
(KNIL ENTERF)  0        

GLSUBATOM BINARY
    	        	-.           Z   ,<   Z   ,<  Z   F  2B   +   Z  ,~   ,   (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL Y . 5)
(VARIABLE-VALUE-CELL Z . 7)
SUBATOM
*NIL*
(KNIL ENTERF)          

GLSUBSTTYPE BINARY
               -.           Z   ,<   Z   D  ,~       (VARIABLE-VALUE-CELL TYPE . 5)
(VARIABLE-VALUE-CELL SUBS . 3)
SUBLIS
(ENTERF)    

GLSUPERS BINARY
            
    -.           
@  
  ,~   Z   ,<   ,<  $  XB   3B   +   	[  ,<   ,<  $  ,~   Z   ,~   20  (VARIABLE-VALUE-CELL CLASS . 6)
(NIL VARIABLE-VALUE-CELL TMP . 13)
GLSTRUCTURE
GETPROP
SUPERS
LISTGET
(KNIL ENTERF)   
  h      

GLTHE BINARY
      w    _    s-.          _@  a  H,~      eZ   3B   +   Z  ,<   ,<  f$  f+   Z   XB   Z   2B   +   Z  ,<   ,<  g$  f3B   +   Z   ,<   Z   ,<  ,<   ,<   (  g,~   Z  3B   +   +   /Z  ,~   Z  3B   +   Z   2B   +   [  2B   +   Z  XB   Z  ,<  Z  B  hD  hZ  2B   +   'Z  ,<   [  XB  ,\   XB  ,<   ,<   $  iXB  2B   +   ,<  i,<  jZ   ,<  ,<  j,   D  k,~   Z  3B   +   Z  ",<  Z  ',<   [  *XB  +,\   ,<   Z  F  kXB  )+   [  .Z  B  lXB   Z  3B  l+   ;Z  0B  mB  lXB  2Z  3B  l+   ;,<  i,<  mZ  $,<   ,<  nZ  4,<  ,<  n^"  ,   D  kZ   Z  -,   XB      oXB   ,<   Z  7,<  [  8Z  ,<   Z  =H  oZ  >,<   [  @Z  ,   ,<   Z  A,<   Z  
,<   [  FXB  G,\   ,<   ,<  p$  f,<   ,<   (  gXB   Z  3B   +   OZ  p+   OZ  q,<   Z  /,<   ,<  q,<  rZ  B,   ,<   Z  L,   ,   ,   B  rXB   Z  L3B   +   [Z  V,<  Z  C,<  ,   ,~   ,<  sZ  X,<  ,   ,<   [  YZ  ,   ,~   B4a 	JIYdH  GF         (VARIABLE-VALUE-CELL PLURALFLG . 173)
(VARIABLE-VALUE-CELL EXPR . 144)
(VARIABLE-VALUE-CELL CONTEXT . 120)
(NIL VARIABLE-VALUE-CELL SOURCE . 160)
(NIL VARIABLE-VALUE-CELL SPECS . 87)
(NIL VARIABLE-VALUE-CELL NAME . 126)
(NIL VARIABLE-VALUE-CELL QUALFLG . 40)
(NIL VARIABLE-VALUE-CELL DTYPE . 187)
(NIL VARIABLE-VALUE-CELL NEWCONTEXT . 139)
(NIL VARIABLE-VALUE-CELL LOOPVAR . 164)
(NIL VARIABLE-VALUE-CELL LOOPCOND . 167)
(NIL VARIABLE-VALUE-CELL TMP . 183)
GLTHESPECS
((with With WITH who Who WHO which Which WHICH that That THAT) . 0)
MEMB
((IS Is is HAS Has has ARE Are are) . 0)
GLPREDICATE
GLPLURAL
RPLACA
GLIDNAME
GLTHE
"The definite reference to"
"could not be found."
GLERROR
GLGETFIELD
GLXTRTYPE
LISTOF
GLGETSTR
"The group name"
"has type"
"which is not a legal group type."
GLMKVAR
GLADDSTR
((who Who WHO which Which WHICH that That THAT) . 0)
SUBSET
SOME
FUNCTION
LAMBDA
GLGENCODE
CAR
(LIST2 ALIST3 CONSNL ALIST2 CONS LIST LIST3 KT KNIL ENTERF)  X [    V 
P   
8   x U X   X   8   p         N 	@ <  #      X        P      

GLTHESPECS BINARY
      ,    $    +-.            $Z   2B   +   Z   ,~   Z  ,<   ,<  &$  &3B   +   Z  ,<   [  XB  ,\   Z  2B   +   ,<  'Z  ',   D  (,~   Z  	-,   +   Z  B  (   )Z  2B  +   Z  ,<   [  XB  ,\   Z   ,   XB  +      ),<   Z   ,<   ,<   &  *XB   +   ,<   Z  ,<   ,<   &  *XB  +   Z  ,<   ,<  *$  &3B   +   Z  ,<   [  !XB  ",\   +    t, 0PS      (VARIABLE-VALUE-CELL EXPR . 69)
(VARIABLE-VALUE-CELL SPECS . 43)
(VARIABLE-VALUE-CELL CONTEXT . 54)
(VARIABLE-VALUE-CELL SOURCE . 58)
((THE The the) . 0)
MEMB
GLTHE
"Nothing following THE"
GLERROR
GLSEPINIT
GLSEPNXT
GLSEPCLR
GLDOEXPR
((OF Of of) . 0)
(KT CONS SKA CONSNL KNIL ENTER0)      `   p   P         p   0      

GLTRANSPARENTTYPES BINARY
        
        
-.           @    ,~   Z   -,   +   B  XB  B  	Z   B  	,~   5   (VARIABLE-VALUE-CELL STR . 10)
(NIL VARIABLE-VALUE-CELL TTLIST . 12)
GLGETSTR
GLTRANSPB
DREVERSE
(SKA ENTERF)   H      

GLTRANSPB BINARY
               -.          Z   -,   +   Z   ,~   Z  2B  +   Z  Z   ,   XB  ,~   Z  ,<   ,<  $  2B   +   [  ,<   Zp  -,   +   Z   +   Zp  B  [p  XBp  +   /   ,~   BR     (VARIABLE-VALUE-CELL STR . 22)
(VARIABLE-VALUE-CELL TTLIST . 14)
TRANSPARENT
((LISTOF ALIST PROPLIST) . 0)
MEMB
GLTRANSPB
(BHC KNIL CONS KT SKNLST ENTERF)     h               0      

GLTRANSPROG BINARY
     N    E    L-.           E@  F  ,~   [   Z  ,<   Zp  -,   +   +   >,<   @  G   +   =Z   -,   +   <[  Z  ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   @  H   +   Z   -,   +   Z  ,<   Z  [  Z  D  H,~   Z   ,~   3B   +   Zp  +   [p  XBp  +   /   2B   +   +Z   ,<   Zp  -,   +    Z   +   *Zp  ,<   ,<w/   @  H   +   &Z  Z  ,<   Z  D  H,~   3B   +   (Zp  +   *[p  XBp  +   /   3B   +   ,   I+   -Z  #Z  XB   Z   ,<  ,<  I,<   Z  ,[  Z  ,   ,   D  JXB  .Z  -,<  Z  0Z  ,<   [  
[  F  JZ  4[  Z  Z  ,   XB  9Z  7,<  Z  3D  K,~   [p  XBp  +   /   Z  33B   +   D[  6,<   Z  ?,<   [  @[  D  JD  KZ  B,~   R BI	$p  @     (VARIABLE-VALUE-CELL X . 137)
(NIL VARIABLE-VALUE-CELL TMP . 119)
(NIL VARIABLE-VALUE-CELL ARGVALS . 116)
(NIL VARIABLE-VALUE-CELL SETVARS . 131)
(VARIABLE-VALUE-CELL Y . 117)
(VARIABLE-VALUE-CELL Z . 74)
GLOCCURS
GLMKVAR
SETQ
NCONC
DSUBST
RPLACA
RPLACD
(CONS CONSNL ALIST3 BHC KNIL SKLST SKNLST ENTERF)   :    3    2    ? 0 " @     @ 8 '      `   0 
     P        

GLUCILISPTRANSFM BINARY
       O    E    M-.           E@  E  ,~   Z   -,   +   Z  ,~   Z  Z  F,   3B   +   Z  ,<   [  [  Z  ,<   [  	Z  ,   XB  +   Z  Z  G,   3B   +   Z  ,<   [  Z  ,<   [  [  [  Z  ,<   [  [  Z  ,   XB  Z  Z  G,   XB   Z  Z  H7   [  Z  Z  1H  +   2D   +   XB   3B   +   #[  Z  [  ,   XB  !+   @Z  "2B  H+   )[  #2B   +   )Z  $,<   ,<   ,   XB  &+   @Z  (2B  I+   1[  )[  2B   +   1Z  *,<   [  ,Z  ,<   ,<   ,   XB  -+   @Z  02B  I+   4Z  1B  J+   @Z  22B  J+   ;,<  K[  4Z  ,<   Z  K[  6[  ,   ,   XB  8+   @Z  :2B  L+   @Z  ;,<   Z  K[  <,   ,   XB  >Z  3B   +   D,<  LZ  ?,<  ,   ,~   Z  B,~   " H )H[ 0      (VARIABLE-VALUE-CELL X . 136)
(NIL VARIABLE-VALUE-CELL TMP . 64)
(NIL VARIABLE-VALUE-CELL NOTFLG . 128)
((MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON SOME EVERY SUBSET GLSTRGEP GLSTRLESSP) . 0)
((PUTPROP) . 0)
((GLSTRGREATERP GLSTRLESSP) . 0)
(((MEMB MEMQ) (FMEMB MEMQ) (FASSOC ASSOC) (GETPROP GET) (GETPROPLIST CDR) (EQP =) (IGREATERP >) (IGEQ 
GE) (GEQ GE) (ILESSP <) (ILEQ LE) (LEQ LE) (IPLUS +) (IDIFFERENCE -) (ITIMES *) (IQUOTIENT //) (
MAPLIST MAPL) (MAPCAR MAPCL) (DECLARE COMMENT) (NCHARS FLATSIZEC) (* COMMENT) (PACK READLIST) (UNPACK 
EXPLODE) (FIXP INUMP) (pop POP) (push PUSH) (LISTP CONSP) (ALPHORDER LEXORDER) (GLSTRGREATERP LEXORDER
) (GLSTRLESSP LEXORDER) (STREQUAL EQSTR) (GLSTRGEP LEXORDER)) . 0)
RETURN
APPEND
PROG
GLTRANSPROG
APPLY*
APPLY
LIST
ERROR
NOT
(ALIST2 LIST3 LIST2 CONS ALIST4 ALIST3 KNIL FMEMB SKNLST ENTERF)         @ (    ?   "        : P    0 H ( `   h         x    H      

GLUNITOP BINARY
                -.          @    ,~   Z   XB   Z  2B   +   Z   ,~   Z   Z  ,<   Z  [  Z  D  2B   +   [  XB  +   Z  XB   Z   ,<  [  [  Z  D  XB   3B   +   [  ,<   Z  ,<   Z   ,<   "  ,   ,~   H     (VARIABLE-VALUE-CELL LHS . 38)
(VARIABLE-VALUE-CELL RHS . 40)
(VARIABLE-VALUE-CELL OP . 27)
(VARIABLE-VALUE-CELL GLUNITPKGS . 6)
(NIL VARIABLE-VALUE-CELL TMP . 36)
(NIL VARIABLE-VALUE-CELL LST . 25)
(NIL VARIABLE-VALUE-CELL UNITREC . 29)
MEMB
ASSOC
(EVCC KNIL ENTERF)        0   X      

GLUNIT? BINARY
            -.          @    ,~   Z   XB   Z  2B   +   Z   ,~   Z  Z  ,<   Z   ,<    "   ,   3B   +   Z  ,~   [  XB  +    B (VARIABLE-VALUE-CELL STR . 16)
(VARIABLE-VALUE-CELL GLUNITPKGS . 6)
(NIL VARIABLE-VALUE-CELL UPS . 25)
(EVCC KNIL ENTERF)  (   0   X      

GLUNWRAP BINARY
       p   Q   i-.         QZ   -,   +   ,~   Z  -,   +   ,< SZ  D S,~   Z  3B T+   	2B T+   
Z  ,~   3B U+   2B U+   "[  	[  2B   +   [  Z  XB  +   [  ,<   Zp  -,   +   +   ,<   @ V   +   Z   ,<   Z  ,<   Z   3B   +   [  2B   +   7   Z   +   Z   D SD V,~   [p  XBp  +   /   Z  B WZ   ,~   2B W+   >[  ![  2B   +   '[  #Z  XB  %+   [  &,<   Zp  -,   +   *+   6,<   @ V   +   5Z  ,<   Z  ,,<   Z  3B   +   3Z  -[  'Z  2B  7   Z   +   3Z   D SD V,~   [p  XBp  +   (/   Z  .3B   +   :[  0[  B W+   =Z  8,<  ,< U$ VZ  :B WZ  <,~   2B X+   P[  =,<   [  ?Z  ,<   Z  7D SD V[  @[  ,<   Zp  -,   +   G+   N,<   @ V   +   MZ  /,<   Z  I,<   ,<   $ SD V,~   [p  XBp  +   E/   Z  C,~   3B X+   W3B Y+   W3B Y+   W3B Z+   W3B Z+   W3B [+   W2B [+   YZ  O,<   Z  BD \,~   2B \+   m[  W[  ,<   Zp  -,   +   ^+   j,<   @ V   +   hZ  J,<   Z  `,<   Z  X3B   +   f[  a2B   +   e7   Z   +   gZ   D SD V,~   [p  XBp  +   \/   [  Z[  B WZ  j,~   2B ]+   pZ  l,<   Z  bD ],~   2B ^+   tZ  n,<   Z  oD ^,~   3B _+   v2B _+   xZ  q,<   Z  rD `,~   Z  v2B `+   |Z   2B a+   |Z  x,~   Z  w2B   +  [  {3B   +  [  ~[  2B   +  Z  B a3B   +  [ Z  ,<   Z   XB  |,\   XB +   [ ,<   Zp  -,   +  
+  ,<   @ V   +  Z  c,<   Z ,<   ,<   $ SD V,~   [p  XBp  +  /   [ 3B   +  1[ [  2B   +  1[ Z  -,   +  1Z B b3B   +  1[ Z  Z  B b3B   +  1Z B b,   ,> Q,>   [ Z  Z  B b,   .Bx  ,^   /   0"  +  1Z ,<   [ $Z  Z  B c,<   Z %B cD cZ d,   B dZ e,   B eD V[ (,<   [ -Z  [  Z  D V+   Z .,<   ,< f$ f3B   +  L[ 1,<   Zp  -,   +  7Z   +  =Zp  ,<   ,<w$ g2B   +  ;Z   +  =[p  XBp  +  5/   3B   +  LZ 4,<   ,< g$ f3B   +  J[ >,<   Zp  -,   +  EZ   +  IZp  -,   +  GZ   +  I[p  XBp  +  B/   3B   +  LZ AB h,~   Z JZ h,   3B   +  PZ LB i,~   Z N,~      <xD5b&"  ,DfL bbATKX^0(AD*!	m@f
I
R)       (VARIABLE-VALUE-CELL X . 416)
(VARIABLE-VALUE-CELL BUSY . 267)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 244)
GLUNWRAP
ERROR
QUOTE
GO
PROG2
PROGN
(VARIABLE-VALUE-CELL Y . 283)
RPLACA
GLEXPANDPROGN
PROG1
FUNCTION
MAP
MAPC
MAPCAR
MAPCONC
SUBSET
SOME
EVERY
GLUNWRAPMAP
LAMBDA
PROG
GLUNWRAPPROG
COND
GLUNWRAPCOND
SELECTQ
CASEQ
GLUNWRAPSELECTQ
*
INTERLISP
GLPURE
GLCARCDR?
NCHARS
GLANYCARCDR?
NCONC
R
DREVERSE
C
PACK
GLEVALWHENCONST
GETPROP
GLCONST?
GLARGSNUMBERP
EVAL
((AND OR) . 0)
GLUNWRAPLOG
(FMEMB SKNNM CONS21 IUNBOX SKLST BHC KT KNIL SKNA SKNLST ENTERF)   `   h   H+   " p        > @ 0 O x     E x ` L 0    N (G > 8: @   @ 8 x ~ x f P c  4 ( / P  @          D h
 X F    0      

GLUNWRAPCOND BINARY
    7    1    6-.           1@  2  ,~   Z   XB   [  2B   +   +   )[  Z  ,<   [  Z  Z  ,<   ,<   $  3D  3[  Z  Z  2B   +   Z  ,<   [  [  D  4+   [  Z  [  ,<   Zp  -,   +   +    ,<   @  4   +   Z   ,<   Z  ,<   Z   3B   +   [  2B   +   7   Z   +   Z   D  3D  3,~   [p  XBp  +   /   [  Z  [  B  5[  !Z  Z  2B   +   '[  #,<   ,<   $  4[  %XB  '+   [  [  2B   +   0[  )Z  Z  2B   +   0Z  5[  +Z  [  ,   ,~   Z  .,~   B $XB  (VARIABLE-VALUE-CELL X . 97)
(VARIABLE-VALUE-CELL BUSY . 49)
(NIL VARIABLE-VALUE-CELL RESULT . 80)
GLUNWRAP
RPLACA
RPLACD
(VARIABLE-VALUE-CELL Y . 52)
GLEXPANDPROGN
PROGN
(CONS BHC SKNLST KT KNIL ENTERF)  0    !        - X  (   0 ' `  8  X        

GLUNWRAPLOG BINARY
       1    ,    0-.           ,@  -  ,~   Z   2B  -+   [  [  2B   +   [  Z  ,~   [  Z  2B   +   Z   ,~   [  Z  2B   +   [  [  Z  ,~   Z  2B  .+   [  [  2B   +   [  Z  ,~   [  Z  2B   +   [  [  Z  ,~   [  Z  2B   +   Z   ,~   [  XB   Z  2B   +   Z  ,~   Z  -,   +   +Z  Z  Z  2B  +   +Z   B  .,<   [  "D  /Z  $,<   Z  %[  [  D  /Z  &,<   Z  ([  Z  D  /[  )XB  ++   b@@ ! A  (VARIABLE-VALUE-CELL X . 66)
(NIL VARIABLE-VALUE-CELL Y . 87)
AND
OR
LAST
RPLACD
RPLACA
(SKLST KT KNIL ENTERF)               `  0 
  h      

GLUNWRAPMAP BINARY
    )      $-.         @   P,~   Z   3B +   3B +   2B +   [   Z  ,<   ,<   $ XB   [  [  Z  ,<   Z  	,<   ,< $ 2B   +   7   Z   D XB   +   3B +   3B +   2B +   [  [  Z  ,<   ,<   $ XB  	[  Z  ,<   Z  ,<   ,< $ 2B   +   7   Z   D XB  +     Z  XB   ,<   ,< $ 3B   +  
Z  -,   +  
Z  "XB   ,<   ,< $ 2B   +   (+  
Z  B XB   Z  3B +   ,2B +   /[  $Z  XB   [  ,[  Z  +   63B +   23B +   22B +   6[  -[  Z  XB  -[  2Z  +   6  B XB   Z  $2B +   XZ  3B +   ;2B +   CXB   ,< [  7Z  ,<   Z  <,<   Z  ),<   [  ?Z  F ,   XB   +  2B +   NZ XB  ;,< [  >Z  ,<   ,< Z  E,<   Z  @,<   [  HZ  F ,<   ,<   ,   ,   XB  B+  2B +   WZ XB  D,< [  GZ  ,<   Z  P,<   Z  I,<   [  SZ  F ,   XB  M+    +  2B +   ,<     XB   ,   ,<   ,< !Z  Z,<   [  RZ  ,   ,<   ,< !,< ",   ,   XB  VZ  92B +   nZ XB  O,< Z  \,<  Z  T,<   [  eZ  F ,<   ,< Z  d,<   ,<   ,   ,   ,<   ,< "Z  aF XB  l+  2B +   wZ XB  cZ  i,<  Z  f,<   [  qZ  F ,<   ,< "Z  mF XB  u+  2B +   Z XB  pZ  p,<  Z  r,<   [  zZ  F ,<   ,< "Z  vF XB  }+    +    Z  x,<   Z  4,<  ,< ",< #Z  ],   ,<   Z  ~,<   ,   ,   ,   B #,<   Z   D ,~   Z  a,<   Z  4,<  Z  (,<  ,   B #,~   ~Kx,4S`?@fz 'QP? W@*x^          (VARIABLE-VALUE-CELL X . 62)
(VARIABLE-VALUE-CELL BUSY . 274)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 83)
(NIL VARIABLE-VALUE-CELL LST . 279)
(NIL VARIABLE-VALUE-CELL FN . 281)
(NIL VARIABLE-VALUE-CELL OUTSIDE . 246)
(NIL VARIABLE-VALUE-CELL INSIDE . 264)
(NIL VARIABLE-VALUE-CELL OUTFN . 277)
(NIL VARIABLE-VALUE-CELL INFN . 111)
(NIL VARIABLE-VALUE-CELL NEWFN . 267)
(NIL VARIABLE-VALUE-CELL NEWMAP . 258)
(NIL VARIABLE-VALUE-CELL TMPVAR . 242)
(NIL VARIABLE-VALUE-CELL NEWLST . 260)
INTERLISP
UTLISP
PSL
GLUNWRAP
((MAPC MAP) . 0)
MEMB
MACLISP
FRANZLISP
UCILISP
((MAPC MAP) . 0)
ERROR
((SUBSET MAPCAR MAPC MAPCONC) . 0)
((SUBSET MAPCAR) . 0)
GLXTRFN
SUBSET
MAPCONC
AND
SUBST
MAPCAR
CONS
MAPC
PROG
GLMKVAR
SETQ
RETURN
*GLCODE*
FUNCTION
LAMBDA
GLGENCODE
(ALIST2 ALIST4 LIST2 CONSNL LIST3 ALIST3 SKLST KNIL KT ENTERF)           X [    x k 	P    l p V 	X B    $    k 	H ' (  @  h   P  x 	       

GLUNWRAPPROG BINARY
      <    2    :-.          2@  4  ,~   Z   3B  4+   Z   B  5Z   2B   +   Z  B  5XB   3B   +   Z  -,   +   Z  	Z  2B  6+   Z  [  Z  -,   +   Z  ,<   ,<  6$  7,<   ,<   $  7+   Z  ,<   Z  [  Z  D  8[  Z  ,<   Zp  -,   +   +   $Zp  ,<   @  8   +   "Z   -,   +   "[  ,<   [  Z  ,<   ,<   $  9D  8,~   [p  XBp  +   /   [  [  ,<   Zp  -,   +   (+   /,<   @  8   +   .Z  ,<   Z  *,<   ,<   $  9D  8,~   [p  XBp  +   &/   [  $[  B  9Z  0,~   i$L0 eT"      (VARIABLE-VALUE-CELL X . 99)
(VARIABLE-VALUE-CELL BUSY . 11)
(VARIABLE-VALUE-CELL GLLISPDIALECT . 6)
(NIL VARIABLE-VALUE-CELL LAST . 41)
INTERLISP
GLTRANSPROG
LAST
RETURN
2
NLEFT
RPLACD
RPLACA
(VARIABLE-VALUE-CELL Y . 86)
GLUNWRAP
GLEXPANDPROGN
(BHC KT SKNLST SKA SKLST KNIL ENTERF)  0 P      x          0   P          

GLUNWRAPSELECTQ BINARY
        T    J    Q-.           J@  K  ,~   [   ,<   [  Z  ,<   ,<   $  LD  L[  [  ,<   Zp  -,   +   
+   ',<   @  M   +   %[   2B   +   Z  2B  M+   !Z  [  ,<   Zp  -,   +   +   ,<   @  N   +   Z   ,<   Z  ,<   Z   3B   +   [  2B   +   7   Z   +   Z   D  LD  L,~   [p  XBp  +   /   Z  [  B  N,~   Z  ,<   Z  !,<   Z  D  LD  L,~   [p  XBp  +   /   [  Z  B  O2B   +   +Z  ',~   [  *Z  B  OXB   [  +[  XB   Z  .2B   +   1Z   ,~   [  .2B   +   5Z  -2B  P+   5Z  1,~   Z  22B  M+   <Z  4Z  2B   +   <Z  PZ  6[  ,   ,<   Z  #D  L,~   Z  ,Z  9Z  3B  +   DZ  =Z  -,   +   HZ  <,<   Z  ?Z  D  Q3B   +   HZ  PZ  B[  ,   ,<   Z  ;D  L,~   [  EXB  H+   .)0j%D bXFB`    (VARIABLE-VALUE-CELL X . 106)
(VARIABLE-VALUE-CELL BUSY . 142)
(NIL VARIABLE-VALUE-CELL L . 146)
(NIL VARIABLE-VALUE-CELL SELECTOR . 130)
GLUNWRAP
RPLACA
(VARIABLE-VALUE-CELL Y . 69)
CASEQ
(VARIABLE-VALUE-CELL Z . 49)
GLEXPANDPROGN
GLCONST?
GLCONSTVAL
SELECTQ
PROGN
MEMB
(SKLST CONS BHC KNIL SKNLST KT ENTERF)     p ;    (     H 2  0    8               h      

GLUPDATEVARTYPE BINARY
              -.          @    ,~   Z   3B   +   Z   ,<  Z   D  XB   3B   +   [  [  Z  2B   +   [  [  ,<   Z  D  +   Z  ,<  ,<   Z  ,<  Z  H  Z   ,~   "!     (VARIABLE-VALUE-CELL VAR . 27)
(VARIABLE-VALUE-CELL TYPE . 30)
(VARIABLE-VALUE-CELL CONTEXT . 32)
(NIL VARIABLE-VALUE-CELL CTXENT . 21)
GLFINDVARINCTX
RPLACA
GLADDSTR
(KNIL ENTERF)   x 
          

GLUSERFN BINARY
     .    '    ,-.          '@  )  ,~   Z   XB   Z   XB   Z  2B   +   +   Z  ,<  Z  [  [  [  [  Z  D  *XB   3B   +   [  ,<   Z  ,<   Z   ,<   "  ,   ,~   [  XB  +   Z   XB  Z  2B   +   Z  B  +,~   Z  ,<  Z  [  [  [  [  Z  D  +3B   +   %,<  ,Z  [  [  Z  D  *XB  3B   +   %[  ,<   Z  ,<   Z  ,<   "  ,   ,~   [  XB  %+    $ ! B     (VARIABLE-VALUE-CELL EXPR . 68)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 8)
(VARIABLE-VALUE-CELL CONTEXT . 70)
(VARIABLE-VALUE-CELL GLUNITPKGS . 38)
(NIL VARIABLE-VALUE-CELL FNNAME . 46)
(NIL VARIABLE-VALUE-CELL TMP . 66)
(NIL VARIABLE-VALUE-CELL UPS . 76)
ASSOC
GLUSERFNB
MEMB
UNITFN
(EVCC KNIL ENTERF)   %      X   h      

GLUSERFNB BINARY
       H    =    F-.          =@  >   ,~   Z   ,<   [  XB  ,\   XB   Z  2B   +   -Z   B  @XB  Z   B  @XB  	Z  ,<  ,<  @$  A3B   +   Z  ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w$  A2B   +   Z   +   [p  XBp  +   /   3B   +   Z  
Z  ,   B  B,<   Z  ,<   Z  
D  B,   ,~   Z  B  C3B   +   (Z  ,<   Z  D  CXB   3B   +   (Z  !Z  ,   ,<   Z  #,<   ,<  B$  A,   ,~   Z  Z  #,   ,<   Z  (,<   Z   D  B,   ,~   ,<   Z   ,<  ,<   &  D2B   +   5,<  D,<  EZ  ,<   ,   D  E,<   Z   XB  1,\   XB  %3B   +   <Z  5Z  (,   XB  7[  7Z  Z  +,   XB  :+   Z   ,~    R
*$!
  .    (VARIABLE-VALUE-CELL EXPR . 105)
(VARIABLE-VALUE-CELL CONTEXT . 91)
(NIL VARIABLE-VALUE-CELL ARGS . 113)
(NIL VARIABLE-VALUE-CELL ARGTYPES . 118)
(NIL VARIABLE-VALUE-CELL FNNAME . 84)
(NIL VARIABLE-VALUE-CELL TMP . 114)
DREVERSE
GLEVALWHENCONST
GETPROP
GLCONST?
EVAL
GLRESULTTYPE
GLABSTRACTFN?
GLINSTANCEFN
GLDOEXPR
GLUSERFNB
"Function call contains illegal item.  EXPR ="
GLERROR
(LIST2 ALIST2 CONS BHC KT SKNLST KNIL ENTERF)  8   P ( X   8 9   %     x   x         = p 5  . 0     @   x      

GLUSERGETARGS BINARY
                -.           @    ,~   Z   ,<   [  XB  ,\   Z  2B   +   Z   B  ,~   ,<   Z   ,<  ,<   &  2B   +   ,<  ,<  Z  ,<   ,   D  ,<   Z   XB  ,\   XB   3B   +   Z  ,   XB  +   Z   ,~    \ D    (VARIABLE-VALUE-CELL EXPR . 32)
(VARIABLE-VALUE-CELL CONTEXT . 18)
(NIL VARIABLE-VALUE-CELL ARGS . 39)
(NIL VARIABLE-VALUE-CELL TMP . 34)
DREVERSE
GLDOEXPR
GLUSERFNB
"Function call contains illegal item.  EXPR ="
GLERROR
(CONS LIST2 KT KNIL ENTERF)               (  @ 	  p      

GLUSERSTROP BINARY
     !         -.          @    ,~   [   Z  XB   2B   +   Z   ,~   -,   +   Z  ,<   Z  B  ,   ,<   Z   ,<   Z   F  ,~   -,   +   +   Z  ,<   Z   D   XB   3B   +   Z  
,<  [  [  [  Z  D   XB   3B   +   [  ,<   Z  ,<   Z  ,<   "  ,   ,~   D	D   (VARIABLE-VALUE-CELL LHS . 48)
(VARIABLE-VALUE-CELL OP . 36)
(VARIABLE-VALUE-CELL RHS . 50)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 31)
(NIL VARIABLE-VALUE-CELL TMP . 38)
(NIL VARIABLE-VALUE-CELL DES . 29)
(NIL VARIABLE-VALUE-CELL TMPB . 46)
GLGETSTR
GLUSERSTROP
ASSOC
(EVCC SKNLST ALIST2 SKA KNIL ENTERF)   8   `   (    x   p   h        

GLVALUE BINARY
      7    ,    5-.           ,@  /   ,~   Z   Z   ,   3B   +   Z   ,~   Z   ,<   Z  ,<  Z  F  1XB   3B   +   ,<   Z   D  1,~   Z  ,<  ,<  2Z  F  2XB   3B   +   Z  ,<  Z  ,<  ,   ,<   Z  ,<   ,<   Z   H  3XB  	Z  ,~   Z  B  3XB   Z  2B   +   +   ,<  4Z  ,<  Z  B  4,<   Z  Z  ,   H  5XB  3B   +   *Z  ,<   Z  ,<   ,<   &  1XB   Z   ,<  Z  %D  1Z  %,<   Z  D  1+   [  'XB  *3B   +   +   HR !H!0  (VARIABLE-VALUE-CELL SOURCE . 81)
(VARIABLE-VALUE-CELL PROP . 56)
(VARIABLE-VALUE-CELL TYPE . 70)
(VARIABLE-VALUE-CELL DESLIST . 62)
(VARIABLE-VALUE-CELL CONTEXT . 43)
(NIL VARIABLE-VALUE-CELL TMP . 85)
(NIL VARIABLE-VALUE-CELL PROPL . 40)
(NIL VARIABLE-VALUE-CELL TRANS . 68)
(NIL VARIABLE-VALUE-CELL FETCHCODE . 77)
GLSTRFN
GLSTRVAL
PROP
GLSTRPROP
GLCOMPMSG
GLTRANSPARENTTYPES
*GL*
GLXTRTYPE
GLVALUE
(CONS LIST2 KNIL FMEMB ENTERF)    @   @ %    `  0   X    P      

GLVARTYPE BINARY
               -.           @    ,~   Z   ,<   Z   D  XB   3B   +   
[  [  Z  2B   +   
Z  ,~   Z   ,~     (VARIABLE-VALUE-CELL VAR . 6)
(VARIABLE-VALUE-CELL CONTEXT . 8)
(NIL VARIABLE-VALUE-CELL TMP . 13)
GLFINDVARINCTX
*NIL*
(KNIL ENTERF)   0 	  h      

GLXTRFN BINARY
            -.           @    ,~   [   Z  -,   +   [  ,<   ,<     XB   ,   ,<   [  Z  ,<   Z  ,<   ,   ,   D  [  Z  [  Z  Z  ,<   [  Z  [  [  Z  ,   ,~          (VARIABLE-VALUE-CELL FNLST . 31)
(NIL VARIABLE-VALUE-CELL TMP . 20)
LAMBDA
GLMKVAR
RPLACA
(ALIST2 ALIST3 LIST2 CONSNL SKA ENTERF)  0   H   @       P      

GLXTRTYPE BINARY
       %        $-.          Z   -,   +   ,~   -,   +   Z   ,~   Z  B   2B   +   	Z  2B  !+   [  3B   +   [  	Z  -,   +   [  
Z  ,~   Z  ,<   Z   D  !3B   +   Z  ,~   Z  ,<   Z   D  "3B   +   Z  ,~   Z  -,   +   [  3B   +   [  Z  XB  +   ,<  "Z  ,<   ,<  #,   D  #Z   ,~   "Y

	P (VARIABLE-VALUE-CELL TYPE . 55)
(VARIABLE-VALUE-CELL GLTYPENAMES . 30)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 38)
GL-A-AN?
TRANSPARENT
MEMB
ASSOC
GLXTRTYPE
"is an illegal type specification."
GLERROR
(LIST2 KNIL SKNLST SKA ENTERF)  `   p  P  (   X    H   x   0      

GLXTRTYPEB BINARY
      #        "-.          Z   2B   +   Z   ,~   -,   +   
,<   Z   D  3B   +   Z  ,~   Z  B   XB  +   -,   +   Z   ,~   Z  	,<   Z   D  3B   +   Z  ,~   Z  ,<   Z   D   3B   +   Z  ,~   Z  -,   +   [  3B   +   [  Z  XB  +   ,<  !Z  ,<   ,<  !,   D  "Z   ,~   E PPHe  (VARIABLE-VALUE-CELL TYPE . 52)
(VARIABLE-VALUE-CELL GLBASICTYPES . 11)
(VARIABLE-VALUE-CELL GLTYPENAMES . 27)
(VARIABLE-VALUE-CELL GLUSERSTRNAMES . 35)
MEMB
GLGETSTR
ASSOC
GLXTRTYPE
"is an illegal type specification."
GLERROR
(LIST2 SKNLST SKA KNIL ENTERF)            P   X  8  H   @        

GLXTRTYPEC BINARY
                -.          Z   -,   +   ,<   Z   D  	2B   +   Z  B  
B  
,~   Z   ,~   +   (VARIABLE-VALUE-CELL TYPE . 11)
(VARIABLE-VALUE-CELL GLBASICTYPES . 7)
MEMB
GLGETSTR
GLXTRTYPE
(KNIL SKA ENTERF)    X    0      

SEND BINARY
               -.          Z   B  ,<   [  Z  ,<   ,<  [  [  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ZwB  Zp  ,   XBp  [wXBw+   /  H  ,~   "A@    (VARIABLE-VALUE-CELL GLISPSENDARGS . 10)
EVAL
MSG
GLSENDB
(BHC COLLCT SKNLST KNIL ENTERF)   (          ( 
  x      

SENDPROP BINARY
                -.          Z   B  ,<   [  Z  ,<   [  [  Z  ,<   [  [  [  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ZwB  Zp  ,   XBp  [wXBw+   	/  H  ,~    
    (VARIABLE-VALUE-CELL GLISPSENDPROPARGS . 13)
EVAL
GLSENDB
(BHC COLLCT SKNLST KNIL ENTERF)          
     @ 	       
(PRETTYCOMPRINT GLISPCOMS)
(RPAQQ GLISPCOMS ((FNS A AN GL-A-AN? GLABSTRACTFN? GLADDINSTANCEFN GLADDRESULTTYPE GLADDSTR GLADJ 
GLAINTERPRETER GLAMBDATRAN GLANALYZEGLISP GLANDFN GLANYCARCDR? GLATOMSTRFN GLATMSTR? GLBUILDALIST 
GLBUILDCONS GLBUILDLIST GLBUILDNOT GLBUILDPROPLIST GLBUILDRECORD GLBUILDSTR GLCARCDRRESULTTYPE 
GLCARCDRRESULTTYPEB GLCARCDR? GLCC GLCLASS GLCLASSMEMP GLCLASSP GLCLASSSEND GLCOMP GLCOMPABSTRACT 
GLCOMPCOMS GLCOMPILE GLCOMPILE? GLCOMPMSG GLCOMPOPEN GLCOMPPROP GLCOMPPROPL GLCONST? GLCONSTSTR? 
GLCONSTVAL GLCP GLDECL GLDECLDS GLDEFFNRESULTTYPES GLDEFFNRESULTTYPEFNS GLDEFPROP GLDEFSTR 
GLDEFSTRNAMES GLDEFSTRQ GLDEFUNITPKG GLDELDEF GLDESCENDANTP GLDOA GLDOCASE GLDOCOND GLDOEXPR GLDOFOR 
GLDOIF GLDOLAMBDA GLDOMAIN GLDOMSG GLDOPROG GLDOPROGN GLDOPROG1 GLDOREPEAT GLDORETURN GLDOSELECTQ 
GLDOSEND GLDOSETQ GLDOTHE GLDOTHOSE GLDOVARSETQ GLDOWHILE GLED GLEDS GLEQUALFN GLERR GLERROR 
GLEXPANDPROGN GLEXPENSIVE? GLFINDVARINCTX GLFRANZLISPTRANSFM GLGENCODE GLGETASSOC GLGETCONSTDEF GLGETD
 GLGETDB GLGETDEF GLGETFIELD GLGETFROMUNIT GLGETGLOBALDEF GLGETPAIRS GLGETPROP GLGETSTR GLGETSUPERS 
GLIDNAME GLIDTYPE GLINIT GLINSTANCEFN GLINTERLISPTRANSFM GLISPCONSTANTS GLISPGLOBALS GLISPOBJECTS 
GLLISPADJ GLLISPISA GLLISTRESULTTYPEFN GLLISTSTRFN GLMACLISPTRANSFM GLMAKEFORLOOP GLMAKEGLISPVERSION 
GLMAKESTR GLMAKEVTYPE GLMINUSFN GLMKATOM GLMKLABEL GLMKVAR GLMKVTYPE GLNCONCFN GLNEQUALFN GLNOTFN 
GLNTHRESULTTYPEFN GLOCCURS GLOKSTR? GLOPERAND GLOPERATOR? GLORFN GLP GLPARSEXPR GLPARSFLD GLPARSNFLD 
GLPLURAL GLPOPFN GLPREC GLPREDICATE GLPRETTYPRINTCONST GLPRETTYPRINTGLOBALS GLPRETTYPRINTSTRS GLPROGN 
GLPROPSTRFN GLPSLTRANSFM GLPURE GLPUSHEXPR GLPUSHFN GLPUTARITH GLPUTFN GLPUTPROPS GLPUTUPFN GLREDUCE 
GLREDUCEARITH GLREDUCEOP GLREMOVEFN GLRESGLOBAL GLRESULTTYPE GLSENDB GLSEPCLR GLSEPINIT GLSEPNXT 
GLSKIPCOMMENTS GLSTRFN GLSTRPROP GLSTRVAL GLSTRVALB GLSUBATOM GLSUBSTTYPE GLSUPERS GLTHE GLTHESPECS 
GLTRANSPARENTTYPES GLTRANSPB GLTRANSPROG GLUCILISPTRANSFM GLUNITOP GLUNIT? GLUNWRAP GLUNWRAPCOND 
GLUNWRAPLOG GLUNWRAPMAP GLUNWRAPPROG GLUNWRAPSELECTQ GLUPDATEVARTYPE GLUSERFN GLUSERFNB GLUSERGETARGS 
GLUSERSTROP GLVALUE GLVARTYPE GLXTRFN GLXTRTYPE GLXTRTYPEB GLXTRTYPEC SEND SENDPROP) (P (SETQ 
GLLISPDIALECT (QUOTE INTERLISP)) (GLINIT)) (GLISPOBJECTS GLTYPE GLPROPENTRY) (ADDVARS (LAMBDASPLST 
GLAMBDA) (LAMBDATRANFNS (GLAMBDA GLAMBDATRAN EXPR NIL))) (GLOBALVARS GLQUIETFLG GLSEPBITTBL GLUNITPKGS
 GLSEPMINUS GLTYPENAMES GLBREAKONERROR GLUSERSTRNAMES GLLASTFNCOMPILED GLLASTSTREDITED GLCAUTIOUSFLG 
GLLISPDIALECT GLBASICTYPES) (SPECVARS CONTEXT EXPR VALBUSY FAULTFN GLSEPATOM GLSEPPTR GLTOPCTX 
RESULTTYPE RESULT GLNATOM FIRST OPNDS OPERS GLEXPR DESLIST EXPRSTACK GLTYPESUBS GLPROGLST ADDISATYPE) 
(VARS GLTYPENAMES GLSPECIALFNS GLBASICTYPES) (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) 
LAMBDATRAN) (FILEPKGCOMS GLISPCONSTANTS GLISPGLOBALS GLISPOBJECTS) (DECLARE: DONTEVAL@LOAD 
DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA SENDPROP SEND GLISPOBJECTS GLISPGLOBALS 
GLISPCONSTANTS GLERR GLDEFSTRQ GLDEFSTRNAMES AN A) (NLAML) (LAMA)))))
(SETQ GLLISPDIALECT (QUOTE INTERLISP))
(GLINIT)
(GLISPOBJECTS (GLTYPE (ATOM (PROPLIST (GLSTRUCTURE (CONS (STRDES ANYTHING) (PROPLIST (PROP (PROPS (
LISTOF GLPROPENTRY))) (ADJ (ADJS (LISTOF GLPROPENTRY))) (ISA (ISAS (LISTOF GLPROPENTRY))) (MSG (MSGS (
LISTOF GLPROPENTRY))) (SUPERS (LISTOF GLTYPE)))))))) (GLPROPENTRY (CONS (NAME ATOM) (CONS (CODE 
ANYTHING) (PROPLIST (RESULT GLTYPE) (OPEN BOOLEAN)))) PROP ((SHORTVALUE (NAME)))))
(ADDTOVAR LAMBDASPLST GLAMBDA)
(LOAD (QUOTE LAMBDATRAN.COM))
(FILEPKGCOM 'GLISPCONSTANTS 'MACRO (QUOTE (GLISPCONSTANTS (E (GLPRETTYPRINTCONST (QUOTE GLISPCONSTANTS
))))))
(FILEPKGTYPE 'GLISPCONSTANTS 'DESCRIPTION "GLISP compile-time constants" 'GETDEF 'GLGETCONSTDEF)
(FILEPKGCOM 'GLISPGLOBALS 'MACRO (QUOTE (GLISPGLOBALS (E (GLPRETTYPRINTGLOBALS (QUOTE GLISPGLOBALS))))
))
(FILEPKGTYPE 'GLISPGLOBALS 'DESCRIPTION "GLISP global variables" 'GETDEF 'GLGETGLOBALDEF)
(FILEPKGCOM 'GLISPOBJECTS 'MACRO (QUOTE (GLISPOBJECTS (E (GLPRETTYPRINTSTRS (QUOTE GLISPOBJECTS))))))
(FILEPKGTYPE 'GLISPOBJECTS 'DESCRIPTION "GLISP Object Definitions" 'GETDEF 'GLGETDEF 'DELDEF 'GLDELDEF
)
(ADDTOVAR LAMBDATRANFNS (GLAMBDA GLAMBDATRAN EXPR NIL))
(RPAQQ GLTYPENAMES (CONS LIST RECORD LISTOF ALIST ATOM OBJECT LISTOBJECT ATOMOBJECT))
(RPAQQ GLSPECIALFNS (GLAMBDATRAN GLANALYZEGLISP GLCOMPCOMS GLED GLEDS GLERROR GLGETD GLGETDB 
GLMAKEGLISPVERSION GLP GLPRETTYPRINTCONST GLPRETTYPRINTGLOBALS GLPRETTYPRINTSTRS))
(RPAQQ GLBASICTYPES (ATOM INTEGER REAL NUMBER STRING BOOLEAN ANYTHING))
NIL
