(FILECREATED "16-Aug-84 00:34:07" ("compiled on " <NEWLISP.DCROSS>BYTECOMPILER..2) (2 . 2) brecompiled
 changes: COMP.BIND.VARS in "INTERLISP-10  14-Aug-84 ..." dated "14-Aug-84 00:36:23")
(FILECREATED "14-Aug-84 14:51:03" {ERIS}<LISPCORE>SOURCES>BYTECOMPILER.;4 166686 changes to: (FNS 
COMP.BIND.VARS) previous date: " 7-Aug-84 13:34:17" {ERIS}<LISPCORE>SOURCES>BYTECOMPILER.;3)
BYTEBLOCKCOMPILE2 BINARY
        d    U    a-.         ( UZ   2B  Y+   @  Y  +   Z   ,<   Z   ,<  Z   F  Z,~   ,~   3B  Z+   ,Z  ,<  @  [   
+   +Z`  -,   +   +   *Z  XB   Z  Z  ,   2B   +   )Z  Z  3B  +   )Z  Z   ,   2B   +   )Z   -,   +   Z  Z  ,   2B   +   )Z  Z   ,   3B   +   +   )Z  ,<   ,<  ]Z  ,<   ,<  ^Z  H  ^,   XB` Z` 3B   +   ',<   Z` ,   XB` ,\  QB  +   )Z` ,   XB` XB` [`  XB`  +   Z` ,~   +   ,Z   ,<   @  _  ,~   Z"   XB   Z  	,<  ,<   ,<   ,<   Zw~-,   +   4Zw+    Zw~,<   @  `   +   KZ   Z   7   [  Z  Z  1H  +   <2D   +   8[  2B   +   >Z  7,<   [  =[  Z  ,<   Z  >F  `,<   [  @[  ,<   [  B[  Z  Z  ,<   [  C[  Z  [  Z  ,   ,\  XB  ,\   ,~   XBp  -,   +   SZw3B   +   OZp  QD  +   PZp  XBw       [  2D   +   QXBw[w~XBw~+   2 LSH!I!$  @   $@D      (VARIABLE-VALUE-CELL BLKNAME . 61)
(VARIABLE-VALUE-CELL BLKDEFS . 95)
(VARIABLE-VALUE-CELL ENTRIES . 31)
(VARIABLE-VALUE-CELL BYTECOMPFLG . 3)
(VARIABLE-VALUE-CELL RETFNS . 40)
(VARIABLE-VALUE-CELL NOLINKFNS . 48)
(VARIABLE-VALUE-CELL BLKAPPLYFNS . 53)
(VARIABLE-VALUE-CELL COMP.GENFN.NUM . 94)
NOBLOCK
(NIL VARIABLE-VALUE-CELL BYTECOMPFLG . 0)
BLOCKCOMPILE2
RETRY
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 140)
\
/
PACK*
(VARIABLE-VALUE-CELL INTERNALBLKFNS . 111)
(T VARIABLE-VALUE-CELL BLKFLG . 0)
(VARIABLE-VALUE-CELL X . 0)
COMP.ATTEMPT.COMPILE
(ALIST2 URET4 ASZ CONSNL CONSS1 SKLST KNIL FMEMB SKNLST ENTERF)   	   P   x    %    "    L x   
0 N X < ( 2  - 8        @  X     3 X      
BYTECOMPILE2 BINARY
      
        	-.          @    ,~   Z"   XB   Z   ,<  Z   D  	Z  ,~      (VARIABLE-VALUE-CELL FN . 12)
(VARIABLE-VALUE-CELL DEF . 10)
(VARIABLE-VALUE-CELL COMP.GENFN.NUM . 7)
(NIL VARIABLE-VALUE-CELL BLKFLG . 0)
COMP.ATTEMPT.COMPILE
(ASZ ENTERF)         
COMP.ATTEMPT.COMPILE BINARY
     0    #    .-.         ( #Z   ,<   @  '  ,~   Z  ,<   Z   ,<  Z   F  )XB   Z   2B   +   ,<  ),<   $  *Z   3B   +   ,<  *D  *Z  3B   +   Z   ,~   ,<  +"  +3B   +   Z   3B   +   Z  Z  ,,   ,<   ,<   ,<   &  ,Z   3B   +   Z   3B   +   Z  -Z   ,   B  -Z  ,<   Z  D  +,~   Z  Z  .,   ,   ,<   ,<   ,<   &  ,Z   ,~   M($d$     (VARIABLE-VALUE-CELL TOPFN . 60)
(VARIABLE-VALUE-CELL DEF . 57)
(VARIABLE-VALUE-CELL RECNAME . 12)
(VARIABLE-VALUE-CELL COUTFILE . 21)
(VARIABLE-VALUE-CELL BYTECOMPFLG . 35)
(VARIABLE-VALUE-CELL BLKFLG . 45)
(VARIABLE-VALUE-CELL SPECVARS . 48)
(VARIABLE-VALUE-CELL LOCALFREEVARS . 52)
(VARIABLE-VALUE-CELL EMFLAG . 15)
(NIL VARIABLE-VALUE-CELL COMFNS . 29)
(NIL VARIABLE-VALUE-CELL FLG . 26)
(NIL VARIABLE-VALUE-CELL SUBFNFREEVARS . 0)
COMP.RETFROM.POINT
"-----
"
LISPXPRIN1
"-----
"
COMPILE2
GETD
((-- retrying with PDP-10 compiler) . 0)
LISPXPRINT
SPECVARS
EVAL
((not compiled) . 0)
(CONSNL CONS KT KNIL ENTERF)         P     !   `  @ 
    #    h 	       
COMP.RETFROM.POINT BINARY
               -.           @    ,~   ,<  "  ,<  "  ,<  "  ,<  "  ,<  "  ,<  "  Z   ,<   Z   ,<  Z   F  ,<   ,<  "  ,<  "  ,<  "  ,<  "  ,<  "  ,<  "  ,\   ,~   x@    (VARIABLE-VALUE-CELL COMFN . 18)
(VARIABLE-VALUE-CELL DEF . 20)
(VARIABLE-VALUE-CELL RECNAME . 22)
(0 VARIABLE-VALUE-CELL LBCNT . 0)
FRA
OPT.INITHASH
LBA
PRA
VREFFRA
NODARR
BCINFO
COMP.TOPLEVEL.COMPILE
(ENTERF)     
COMPERROR BINARY
              -.           Z   3B   +   B  ,<  ,<   $  ,~   P   (VARIABLE-VALUE-CELL X . 3)
COMPERRM
COMP.RETFROM.POINT
RETFROM
(KNIL ENTERF)     0      
COMPPRINT BINARY
            -.          Z   ,<   Z   ,<  ,<   &  ,~       (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL COUTFILE . 5)
PRINT
(KT ENTERF)    H      
COMPERRM BINARY
     D    2    B-.          2Z   2B   +   Z   XB  Z   3B   +   ,<  5,<  5Z  F  5,<  6Z  D  6Z  ,<   Z  ,<  ,<   &  7,<  7Z  
D  8Z   3B   +   -,<  8Z  ,<  ,<   &  6@  9  +   -,<  9,<  :$  :,<   @  ;  ,~   ,<  :Z   ,<   ,   ,   Z   ,   XB  XB` ,<  =,<  =,<   @  > ` +   $Z   Z  ?XB Z  ,<   Z  ,<  ,<   &  8Zw}XB8 Z   ,~   2B   +   &Z  @XB   [` XB  ,<  :Z` Z  [  D  @Z  &3B   +   ,   A,~   Z` ,~   Z   3B   +   1Z  ,<  ,<   $  AZ   XB  	,~   h1=TD`D      (VARIABLE-VALUE-CELL X . 94)
(VARIABLE-VALUE-CELL FL . 91)
(VARIABLE-VALUE-CELL COUTFILE . 6)
(VARIABLE-VALUE-CELL EMFLAG . 99)
(VARIABLE-VALUE-CELL RESETVARSLST . 78)
0
LISPXTAB
"-----In "
LISPXPRIN1
LISPXPRIN2
:
LISPXPRINT
*****
(T VARIABLE-VALUE-CELL PLVLFILEFLG . 0)
2
20
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 46)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 84)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ERROR
APPLY
ERROR!
COMPERRM
(CF CONS CONSNL LIST2 KT KNIL ENTERF) p   (          / H "      2 8 % P   X        
COMP.TOPLEVEL.COMPILE BINARY
   ]   .   W-.         p.Z   ,<   Z   ,<  @ 7 A ,,~   Z   -,   +   +[  -,   +   +[  Z  XB   -,   +   2B   +   Z  2B B+   Z"   +   )2B B+   Z"   +   )Z   3B   +   ,<   ,<   Z  ,<   "  ,   XB  3B   +   )+   Z   +   )Z   3B   +   Z  	2B C+   Z   XB  Z"  +   )Z  ,   XB  Z  2B B+    Z"  +   )2B B+   "Z"  +   )Z  3B   +   ),<   ,<   Z  ,<   "  ,   XB  %3B   +   )+   Z   XB   2B   +   -Z   Z C,   B DZ   2B   +   /Z"   +   8Z  +,<  Z   D D3B   +   3Z"   +   8Z  )0B   +   7Z   2B   +   8Z  /+   8Z"   XB  -,<   ,< EZ  B EXB   XB   ,   ,<   ,<   ,<   ,<   ,<   ,   ,   XB   XB       ."   ,   XB  @,   Z F,   XB   B F[  '[  ,<   ,< G$ GZ  ?,<   ,<   $ H,<   Z  3,<   Z   B HXBwZ  G,<   ,<wZ  ;,<  ,   /   XB   Z  6,<  [  EZ  ,<   Z   ,<   @ I   
+   eZ`  -,   +   W+   dZ  XB   Z  X3B K+   Z+   b[  XXB` Z` 3B   +   `,<   Z` ,   XB` ,\  QB  +   bZ` ,   XB` XB` [`  XB`  +   UZ` ,~   XB   3B   +   iZ LZ  e,   ,   +   iZ   ,<   Z   ,<   ,<   Zw-,   +   rZp  Z   2B   +   p "  +   q[  QD   "  +   }Zw,<   @ L   +   yZ  Z,<   Z  0D D2B   +   x7   Z   ,~   3B   +   |ZwZp  ,   XBp  [wXBw+   k/  XB  j3B   +  Z MZ  ~,   ,   ,<   Z   3B   +  Z MZ ,   ,   F N,   ,   B NZ   1B   +  
2B   +  #Z   B O,<   @ O  +  #,< OZ   ,<   ,   ,   Z   ,   XB XB` ,< Q,< R,<   @ R ` +  Z   Z TXB Z  P,<   Z  PD TZw}XB8 Z   ,~   2B   +  Z UXB   [` XB ,< OZ` Z  [  D UZ 3B   +  "  V,~   Z` ,~   Z   ,<   Z ,<  Z ,<   "  ,   Z $Z   3B  +  +Z   ,<  Z  gD VXB )Z 'Z   ,   XB ,Z +,~   B!-i i1t 1)"RQ  #@ 
1B "DQ!$U0( b             (VARIABLE-VALUE-CELL COMFN . 347)
(VARIABLE-VALUE-CELL DEF . 163)
(VARIABLE-VALUE-CELL RECNAME . 106)
(VARIABLE-VALUE-CELL LOCALVARS . 3)
(VARIABLE-VALUE-CELL SPECVARS . 5)
(VARIABLE-VALUE-CELL COMPILEUSERFN . 69)
(VARIABLE-VALUE-CELL LAMBDANOBIND . 47)
(VARIABLE-VALUE-CELL OPCODEPROP . 235)
(VARIABLE-VALUE-CELL LBCNT . 132)
(VARIABLE-VALUE-CELL FREELST . 340)
(VARIABLE-VALUE-CELL LAPFLG . 271)
(VARIABLE-VALUE-CELL LSTFIL . 276)
(VARIABLE-VALUE-CELL RESETVARSLST . 313)
(VARIABLE-VALUE-CELL BYTEASSEMFN . 326)
(VARIABLE-VALUE-CELL TOPFN . 335)
(VARIABLE-VALUE-CELL SUBFNFREEVARS . 342)
(VARIABLE-VALUE-CELL COMFNS . 346)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(VARIABLE-VALUE-CELL SPECVARS . 0)
(NIL VARIABLE-VALUE-CELL ALAMS1 . 256)
(NIL VARIABLE-VALUE-CELL NLAMS1 . 264)
(NIL VARIABLE-VALUE-CELL CONSTS . 0)
(NIL VARIABLE-VALUE-CELL ALLVARS . 117)
(NIL VARIABLE-VALUE-CELL ALLDECLS . 0)
(NIL VARIABLE-VALUE-CELL ARGVARS . 156)
(NIL VARIABLE-VALUE-CELL ARGS . 115)
(NIL VARIABLE-VALUE-CELL COMTYPE . 148)
(NIL VARIABLE-VALUE-CELL CODE . 150)
(NIL VARIABLE-VALUE-CELL FREEVARS . 166)
(NIL VARIABLE-VALUE-CELL CI . 330)
(0 VARIABLE-VALUE-CELL LEVEL . 0)
(NIL VARIABLE-VALUE-CELL FRAME . 128)
(NIL VARIABLE-VALUE-CELL PIFN . 112)
(NIL VARIABLE-VALUE-CELL TOPLAB . 136)
(NIL VARIABLE-VALUE-CELL TOPFRAME . 153)
(NIL VARIABLE-VALUE-CELL MACEXP . 0)
(NIL VARIABLE-VALUE-CELL AC . 0)
(NIL VARIABLE-VALUE-CELL FRELST . 0)
(T VARIABLE-VALUE-CELL COMPILE.DUNBIND.POP.MERGE.FLG . 0)
NLAMBDA
LAMBDA
NOBIND
((not compilable) . 0)
COMPERROR
GETPROP
0
COMP.BINDLIST
TAG
COMP.STTAG
RETURN
COMP.VALN
COMP.UNBIND.VARS
OPT.POSTOPT
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 233)
FVAR
uses:
(VARIABLE-VALUE-CELL X . 0)
calls:
nlams:
NCONC
COMPPRINT
OUTPUT
(VARIABLE-VALUE-CELL OLDVALUE . 283)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 319)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
COMP.MLLIST
ERROR
APPLY
ERROR!
APPEND
(CF LIST2 CONSS1 COLLCT BHC LIST4 CONS21 MKN ALIST4 LIST3 ALIST2 KT CONS CONSNL EVCC ASZ KNIL SKNLST 
SKLST ENTERF)   X   x   x    |    ~ 
   
    H   (       x   H    
  I h   X X  -    `  b p C `   x ' P    8 P 3 x "        ! 0 8    y x o h l   f P J p > ` =  6 ( +   ( X $ 8  x  0  8   P W (            
COMP.BINDLIST BINARY
               -.           Z   ,<   ,<   Zw-,   +   	Zp  Z   2B   +    "  +   	[  QD   "  +    Zw,<   @     +   ,<   Z   ,<   ,<   $  XBp  Z  B  Zp  ,   /   ,~   Zp  ,   XBp  [wXBw+   "@PH    (VARIABLE-VALUE-CELL VARS . 3)
(VARIABLE-VALUE-CELL VAR . 30)
COMP.CHECK.VAR
COMP.VARTYPE
(COLLCT BHC CONS KT URET2 SKNLST KNIL ENTERF)  8          h        H   P   `        
COMP.CHECK.VAR BINARY
              -.           Z   3B   +   Z   ,<   B  ,\  3B  +   ,<  Z  D  B  Z  B  3B   +   Z  Z  ,   B  Z  
-,   +   3B   +   2B   +   Z  ,   B  ,~   &jRZ     (VARIABLE-VALUE-CELL X . 24)
(VARIABLE-VALUE-CELL BIND . 3)
COMP.USERFN
((Attempt to bind CONSTANT) . 0)
APPEND
COMPERRM
COMP.GLOBALVARP
((- is global) . 0)
((is not a legal variable name) . 0)
COMPERROR
(KT SKLA CONS KNIL ENTERF) h   X                  

COMP.BIND.VARS BINARY
    g    T    d-.          0 T@  Y  @,~   Z   ,<   Zp  -,   +   +   .Zp  ,<   @  ]   +   -,<   Z   ,<   ,<   $  ]XBp  Z  	B  ^Zp  ,   /   XB   Z  Z   7   [  Z  Z  1H  +   2D   +   [  XB   3B   +   !Z   ,<   [  XB  ,\   ,<   Z  D  ^Z  ,<   ,<  _$  _Z  Z  ,   Z   ,   XB  Z  Z   ,   XB  ,~   Z  ,<   [  !XB  ",\   XB  3B   +   (B  `Z   Z   2B  +   *   `Z  Z   ,   XB  (,~   Z  (Z   ,   XB  +,~   [p  XBp  +   /   Z  ",<   Zp  -,   +   2+   4Zp  B  a[p  XBp  +   0/   Z  )B  aXB   Z  ,B  aXB   ,   ,>  S,>           ,^   /   3b  +   >Z   Z  b,   B  b,<   ,<   ,<   ,<   ,<   Z   XBwZ  6B  aXBw~Z  B,<  Z  5B  cD  cXBwZ   ,<   Z  6,<  Zw~XBw}Zw~Z  ,   ,   ,<   ,<   ,<   ,<w|,<   ,   ,   XBp  ,<   ,<   ,<w}Z   F  c,\   /  ,~      PH Q L  1@$P         (VARIABLE-VALUE-CELL ARGS . 6)
(VARIABLE-VALUE-CELL VALS . 94)
(VARIABLE-VALUE-CELL TYPE . 141)
(VARIABLE-VALUE-CELL DECLARATIONS . 30)
(VARIABLE-VALUE-CELL CODE . 75)
(VARIABLE-VALUE-CELL OPNIL . 76)
(VARIABLE-VALUE-CELL MAXBVALS . 115)
(VARIABLE-VALUE-CELL EXP . 121)
(VARIABLE-VALUE-CELL FRAME . 130)
(VARIABLE-VALUE-CELL FRA . 162)
(NIL VARIABLE-VALUE-CELL VLV . 135)
(NIL VARIABLE-VALUE-CELL VLN . 137)
(NIL VARIABLE-VALUE-CELL NVALS . 111)
(NIL VARIABLE-VALUE-CELL NNILS . 143)
(NIL VARIABLE-VALUE-CELL DECL . 0)
(NIL VARIABLE-VALUE-CELL X . 71)
(NIL VARIABLE-VALUE-CELL VAR . 85)
(NIL VARIABLE-VALUE-CELL DECLS . 148)
(VARIABLE-VALUE-CELL VARNAME . 29)
COMP.CHECK.VAR
COMP.VARTYPE
COMP.EXPR
HVAR
RPLACA
COMP.VAL
COMP.DELPUSH
COMP.EFFECT
LENGTH
((-- too many variables with values) . 0)
COMPERROR
OPT.DREV
PUTHASH
(ALIST4 LIST3 CONSS1 IUNBOX BHC CONS KT KNIL SKNLST ENTERF)   O    O    L    9    S @ 5 x     K h ,     h  `   0   	h M 	P A  @   ? P  8 	    1  X      
COMP.UNBIND.VARS BINARY
               -.          Z   2B   +   Z   3B  +   Z   B  2B   +   Z  2B  7   Z   B  Z  ,<   ,<   Z   F  Z  ,~   jH0 (VARIABLE-VALUE-CELL F . 0)
(VARIABLE-VALUE-CELL TOPFLG . 3)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 13)
(VARIABLE-VALUE-CELL CODE . 18)
(VARIABLE-VALUE-CELL BCINFO . 21)
RETURN
OPT.JUMPCHECK
EFFECT
COMP.STUNBIND
PUTHASH
NOVALUE
(KT KNIL ENTERF) 0 	      h        
COMP.VALN BINARY
              -.           Z   B  ,~       (VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 0)
COMP.PROGN
(ENTERF)     
COMP.PROGN BINARY
              -.           [   2B   +   Z  B  ,~   Z   2B   +   Z   2B  7   Z   +   	Z   ,<   @     ,~   Z  B  Z   3B   +   ,<   Z   Z   3B  +   Zp  +      +   /   Z  B  2B   +   [  XB  [  3B   +   +   Z  B  ,~   Z   ,~   E   (VARIABLE-VALUE-CELL A . 47)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 9)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 12)
(VARIABLE-VALUE-CELL CODE . 37)
(VARIABLE-VALUE-CELL OPPOP . 29)
COMP.EXP1
RETURN
(VARIABLE-VALUE-CELL FLG . 24)
COMP.EFFECT
COMP.DELPOP
OPT.JUMPCHECK
(BHC KT KNIL ENTERF)           p  h     `        
COMP.EXP1 BINARY
              -.          Z   ,<   Z   D  ,~       (VARIABLE-VALUE-CELL E . 3)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 5)
COMP.EXPR
(ENTERF)      
COMP.EXPR BINARY
         s   	-.         ( s@  w  ,~   Z   2B   +   Z   B  x3B   +   
Z   B  x3B   +   	Z  y,~   Z  y,~      zZ   -,   +   !-,   +   3B   +   2B   +   B  z+   WB  {+   W-,   +   Z  B  {Z   7   [  Z  Z  1H  +   2D   +   [  XB   3B   +   Z  ,<   Z  ,<  ,<    "   ,   XB  ,\  2B  +   Z  B  z+   WZ  XB  -,   +   @-,   Z   Z  3B  |+   '3B  |+   '2B  }+   *Z  !,<   [  !D  }+   W2B  ~+   :Z  (,<   [  +,<   @  ~  +   9Z`  -,   +   0+   8Z  XB    ` ,>  s,>   Z  1B  ^"   .Bx  ,^   /   ,   XB` [`  XB`  +   .Z` ,~   D  +   WZ  ,B XB  '3B   +   >XB  :+   Z ,   B +   W,<   Z   D XB   3B   +   F3B   +   FZ  =,<  D +   WZ  2B +   KZ  ;Z   2B  +   K,<   [  DD +   WZ  GB XB  A3B   +   QZ  K,<  [  J,<   Z  LF +   WZ  OB XB  P3B   +   UXB  Q+   Z  N,<  [  TD XB  RZ  F2B   +   ZZ   ,~   2B +   ^Z  W3B  y+   ]  Z  y,~   2B +   bZ  B  x2B   +   a  Z  y,~   B  x3B   +   gZ  [3B  y+   fZ  WB Z  y,~   Z  e-,   Z   Z  2B +   kZ   ,~   Z  g-,   Z   Z  2B 7   7   +   rZ  d3B +   r[  kB Z ,~      *ZJ_P b?Hi6%$"o5jl	6        (VARIABLE-VALUE-CELL EXP . 172)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 226)
(VARIABLE-VALUE-CELL FRAME . 6)
(VARIABLE-VALUE-CELL CODE . 190)
(VARIABLE-VALUE-CELL COMPILETYPELST . 39)
(VARIABLE-VALUE-CELL COMPILERMACROPROPS . 129)
(VARIABLE-VALUE-CELL PIFN . 144)
(NIL VARIABLE-VALUE-CELL M . 170)
(NIL VARIABLE-VALUE-CELL V . 223)
OPT.JUMPCHECK
COMP.PREDP
PREDVALUE
NOVALUE
OPT.COMPILERERROR
COMP.CONST
COMP.VAR
TYPENAME
LAMBDA
NLAMBDA
OPENLAMBDA
COMP.LAMBDA
OPCODES
(0 . 1)
(NIL VARIABLE-VALUE-CELL X . 102)
0
COMP.VAL
COMP.STFN
COMP.TRYUSERFN
((- non-atomic CAR of form) . 0)
COMPERROR
GETMACROPROP
COMP.MACRO
RETURN
COMP.CPI
COMP.ARGTYPE
COMP.CALL
EFFECT
COMP.STPOP
COMP.STRETURN
COMP.STJUMP
TYPE
UNBOXED
COMP.UNBOX
(CONS MKN BHC SKLST SKNLA EVCC SKNNM KT SKLA SKNLST KNIL ENTERF)   ?    7    6    m  $    #            o @         0 H   p m 8 i @ a   Y 
@ N 0 = H        H      
COMP.TRYUSERFN BINARY
        
    -.          
Z   3B   +   	Z   B  XB   2B  +   Z  Z  ,   B  Z   ,~   ,~   Z   ,~   Z@  (VARIABLE-VALUE-CELL EXP . 11)
(VARIABLE-VALUE-CELL M . 8)
(VARIABLE-VALUE-CELL COMPILEUSERFN . 3)
COMP.USERFN
INSTRUCTIONS
((COMPILEUSERFN returned INSTRUCTIONS) . 0)
COMPERRM
(CONS KNIL ENTERF)      
         
COMP.USERFN BINARY
    #        "-.           Z   -,   +   Z   3B   +   Z  Z  ,   2B   +   Z  ,~   Z   ,<  Z   ,<  ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   @     +   [  ,~   Zp  ,   XBp  [wXBw+   
/  ,<   @  ! @ ,~   Z   ,<   [  ,<   Z  ,<    "  ,   ,~   ,~   ! "P	   (VARIABLE-VALUE-CELL X . 56)
(VARIABLE-VALUE-CELL COMPVARMACROHASH . 10)
(VARIABLE-VALUE-CELL TOPFN . 16)
(VARIABLE-VALUE-CELL ALLVARS . 18)
(VARIABLE-VALUE-CELL COMPILEUSERFN . 52)
(VARIABLE-VALUE-CELL FN . 0)
(VARIABLE-VALUE-CELL OTHERVARS . 0)
(EVCC BHC COLLCT SKNLST GETHSH KNIL SKLA ENTERF)                       X   p            
COMP.CONST BINARY
     '        %-.          Z   2B   +   Z   2B  +   Z   ,~   Z  2B   +   Z  B   3B   +   Z  2B  !+   Z   3B   +   +   2B  !+   Z  
3B   +   B  "+   2B  "+   Z  2B   +   +   2B  #+   Z  2B   +   B  "+      #3B   +   ,<  $[  	Z  ,<   [  [  F  $Z  %,~   Z  B  ",~   q+>yv       (VARIABLE-VALUE-CELL X . 57)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 11)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 52)
EFFECT
NOVALUE
COMP.PREDP
TJUMP
NTJUMP
COMP.STCONST
FJUMP
NFJUMP
SHOULDNT
JUMP
COMP.STJUMP
PREDVALUE
(KNIL ENTERF)    (  @ 	  p        
COMP.CALL BINARY
      I    =    G-.         ( =@  A  ,~   [   [  [  Z  [  [  Z  2B   +   Z   ,<   ,<  B$  B2B   +   [  [  [  Z  [  [  ,<   Z  D  CZ   0B  +   Z  Z   ,   3B   +   Z  +   Z  Z  ,   XB  Z   B  CZ  ,<   ,<  D$  D,~   0B   +    Z  Z  ,   3B   +   Z  +   'Z  Z  ,   XB  +   '2B   +   'Z  Z   ,   3B   +   %Z  "+   'Z  !Z  $,   XB  %Z  -,   +   0Z  0B   +   +Z  'B  C+   ,Z  *B  E    ."   ,   XB  ,[  +XB  .+   '3B   +   3Z  E,   B  F+   6Z  (3B   +   ;0B  +   6+   ;   .1b   +   ;Z   Z   2B  +   ;   F>  6+   6Z  %,<   Z  :D  D,~    M $(PP %PeQ   (VARIABLE-VALUE-CELL F . 118)
(VARIABLE-VALUE-CELL A . 94)
(VARIABLE-VALUE-CELL TYP . 102)
(VARIABLE-VALUE-CELL FRAME . 21)
(VARIABLE-VALUE-CELL NLAMS1 . 63)
(VARIABLE-VALUE-CELL ALAMS1 . 77)
(VARIABLE-VALUE-CELL CODE . 111)
(VARIABLE-VALUE-CELL OPNIL . 112)
(0 VARIABLE-VALUE-CELL N . 120)
FREEVARS
COMP.CLEANFNOP
RPLACA
COMP.STCONST
1
COMP.STFN
COMP.VAL
((- unusual CDR arg list) . 0)
COMPERROR
COMP.DELPUSH
(MKN SKLST CONS FMEMB ASZ KNIL ENTERF)  .    (    2 p   `   8  (   X * (     4  $   0 
  x      
COMP.VAR BINARY
             -.          Z   2B  +   Z  ,~   Z   ,<  ,<   $  XB  B  Z  ,<   Z   D  [  XB   -,   Z   Z  2B  7   7   +   [  	B  ,~   @     (VARIABLE-VALUE-CELL VAR . 14)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 3)
(VARIABLE-VALUE-CELL ALLDECLS . 16)
(VARIABLE-VALUE-CELL DECL . 27)
EFFECT
NOVALUE
COMP.LOOKUPVAR
COMP.STVAR
ASSOC
UNBOXED
COMP.BOX
(KNIL SKLST KT ENTERF)   P           `      
COMP.VAL1 BINARY
            -.           Z   B  ,~       (VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 0)
COMP.PROG1
(ENTERF)     
COMP.PROG1 BINARY
             -.          [   2B   +   Z  B  ,~   Z  ,<   Z   2B  7   7   +   Z  D  ,<   [  ,<   Zp  -,   +   +   Zp  B  [p  XBp  +   
/   ,\   ,~   B(      (VARIABLE-VALUE-CELL A . 19)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 16)
COMP.EXP1
EFFECT
COMP.EXPR
COMP.EFFECT
(BHC SKNLST KT KNIL ENTERF)      @        x        
COMP.EFFECT BINARY
        
    -.          
Z   ,<   @     ,~   Z   B  3B   +   Z   ,~   Z   ,<   ,<  $  ,<   ,\   ,~     (VARIABLE-VALUE-CELL E . 14)
(VARIABLE-VALUE-CELL LEVEL . 3)
(VARIABLE-VALUE-CELL CODE . 8)
(VARIABLE-VALUE-CELL LV . 0)
OPT.JUMPCHECK
EFFECT
COMP.EXPR
(KNIL ENTERF)    `      
COMP.VAL BINARY
         	    -.          	Z   ,<   @     ,~   Z   B  3B   +   Z   ,~   Z   B  ,<   ,\   ,~      (VARIABLE-VALUE-CELL X . 14)
(VARIABLE-VALUE-CELL LEVEL . 3)
(VARIABLE-VALUE-CELL CODE . 8)
(VARIABLE-VALUE-CELL LV . 0)
OPT.JUMPCHECK
COMP.EXPR
(KNIL ENTERF)   p        
COMP.MACRO BINARY
     P    B    N-.           BZ   -,   +   2B   +   Z   ,<   [  ,<   Z  B  CF  C,~   2B  D+   
   D,~   ,<   [  ,<    "   ,   ,~   Z  2B  D+   [  Z  ,<   [  
D  D,~   2B  E+   [  Z  ,<   [  [  [  ,   D  D,~   2B  E+   [  [  ,   B  F,~   3B  F+   3B  G+   2B  G+    Z  ,<   [  D  H,~   Z  ,<   @  H   ,~   Z  3B   +   %Z  "-,   +   4[   B  I,   ,>  A,>   Z  $B  I,       ,^   /   3b  +   0Z  (B  I[  2B   +   0Z  %Z  J,   B  JZ  ,,<   [  .,<   [  0F  KB  K,~   Z  GZ  2,   ,<   [  1D  DXB  53B  L+   =2B  L+   <Z  6Z  M,   B  M,~   B  F,~   Z  :,<   [  =,<   Z  >B  CF  C,~      A\B@,/b)(U@      (VARIABLE-VALUE-CELL EXP . 127)
(VARIABLE-VALUE-CELL MAC . 111)
COMP.ARGTYPE
COMP.CALL
COMP.PUNT
APPLY
APPLY*
=
COMP.EXP1
LAMBDA
NLAMBDA
OPENLAMBDA
COMP.LAMBDA
(VARIABLE-VALUE-CELL MACEXP . 0)
LENGTH
LAST
((- warning: too many args for macro) . 0)
COMPERRM
SUBPAIR
COMP.PROGN
IGNOREMACRO
INSTRUCTIONS
((returned INSTRUCTIONS) . 0)
COMPERROR
(BHC IUNBOX SKLST KNIL CONS EVCC KT SKNLST ENTERF) 8     '    %    . @   @ 6   h   P    @    0      
COMP.VARTYPE BINARY
              -.           Z   B  3B   +   Z  ,~   Z  ,~   P   (VARIABLE-VALUE-CELL VAR . 3)
COMP.ANONP
HVAR
AVAR
(KNIL ENTERF)    8      
COMP.LOOKUPVAR BINARY
    C    6    A-.          6@  9  ,~   Z   ,<   @  9  +   Z`  -,   +   +   Z  XB   [  Z   2B  +   Z  2B   +   Z   XB` +   [`  XB`  +   Z` ,~   XB   3B   +   Z  ,~   Z   ,<  @  ;  +   Z`  -,   +   +   Z  XB  
[  Z  	2B  +   Z  2B   +   Z   XB` +   [`  XB`  +   Z` ,~   XB  3B   +   !+   Z  ,<   B  <XB  ,\  3B  +   -Z   3B   +   +,<  =Z  =,<   Z  #,   ,<   ,<   (  >+   -Z  !Z  >,   B  ?Z   3B   +   1Z  +B  ?3B   +   1Z  @+   2Z  @,<   Z  .B  A,   XB  (Z  ,   XB  4+   )A!
0$H2')/@    (VARIABLE-VALUE-CELL V . 101)
(VARIABLE-VALUE-CELL FORVALUE . 74)
(VARIABLE-VALUE-CELL ALLVARS . 6)
(VARIABLE-VALUE-CELL FREEVARS . 107)
(VARIABLE-VALUE-CELL GLOBALVARFLG . 90)
(NIL VARIABLE-VALUE-CELL X . 104)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL VAR . 52)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL VAR . 0)
COMP.USERFN
COMP.VAR
COMP.VAL
RETAPPLY
" - is compile time constant, yet is bound or set."
COMPERRM
COMP.GLOBALVARP
GVAR
FVAR
COMP.CHECK.VAR
(CONSS1 CONS CONSNL KT KNIL SKNLST ENTERF)  H   ` -    )    * H     0 h &          p      
COMP.LOOKUPCONST BINARY
               -.          Z   2B   +   Z   ,~   Z   ,<  Zp  -,   +   Z   +   Zp  ,<   ,<w/   @     +   Z  ,<   [   ,\  2B  7   Z   ,~   3B   +   Zp  +   [p  XBp  +   /   Z  2B   +   Z  Z  ,   XB  ,<   Z  ,<  ,   D  XB  ,\   ,~   B@
F   (VARIABLE-VALUE-CELL X . 44)
(VARIABLE-VALUE-CELL OPNIL . 6)
(VARIABLE-VALUE-CELL CONSTS . 50)
(VARIABLE-VALUE-CELL Y . 24)
CONST
NCONC
(CONSNL CONS KT BHC SKNLST KNIL ENTERF)                     h   H  h   0      
COMP.ST BINARY
              -.          Z   2B   +   Z   2B   +   Z   Z   ,   XB  Z  -,   +   	Z   +      ,>  ,>      .Bx  ,^   /   ,   XB  	,~   Z   ,~       *  (VARIABLE-VALUE-CELL X . 9)
(VARIABLE-VALUE-CELL DL . 21)
(VARIABLE-VALUE-CELL LEVEL . 26)
(VARIABLE-VALUE-CELL CODE . 12)
(MKN BHC SKNI CONS KT KNIL ENTERF)                                
COMP.STFN BINARY
              -.          Z   ,<   Z   3B   +   Z   -,   +   Z  Z   7   [  Z  Z  1H  +   
2D   +   [  2B   +   Z  ,   Z  ,   ,<          ^"   /  ,   D  ,~   H     (VARIABLE-VALUE-CELL FN . 24)
(VARIABLE-VALUE-CELL N . 29)
(VARIABLE-VALUE-CELL BLKFLG . 5)
(VARIABLE-VALUE-CELL INTERNALBLKFNS . 12)
FN
COMP.ST
(MKN CONS21 CONSS1 SKLA KNIL ENTERF)                   (        
COMP.STCONST BINARY
                -.           Z   B  ,<   ,<  $  ,~   @   (VARIABLE-VALUE-CELL X . 3)
COMP.LOOKUPCONST
1
COMP.ST
(ENTERF)     
COMP.STVAR BINARY
             -.           Z   ,<   ,<  $  ,~       (VARIABLE-VALUE-CELL VREF . 3)
1
COMP.ST
(ENTERF)     
COMP.STPOP BINARY
             -.          Z   2B   +   Z"   ,<   ,<    w1b   +   Z   ,<   ,<  $  XBp   w/"   ,   XBw+   Zp  +    `@ (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL OPPOP . 12)
-1
COMP.ST
(URET2 MKN ASZ KNIL ENTERF)   H   (    @    P        
COMP.DELFN BINARY
         
    -.           
    /"   ,>  	,>   Z   [  Z  ,   .Bx  ,^   /   ,   XB  [  XB  ,~          (VARIABLE-VALUE-CELL LEVEL . 15)
(VARIABLE-VALUE-CELL CODE . 17)
(MKN BHC IUNBOX ENTER0)      x    `      
COMP.STRETURN BINARY
             -.           Z   ,<   ,<   $  Z   XB   XB   ,~       (VARIABLE-VALUE-CELL OPRETURN . 3)
(VARIABLE-VALUE-CELL FRAME . 8)
(VARIABLE-VALUE-CELL LEVEL . 9)
COMP.ST
(KNIL KT ENTER0)             
COMP.STTAG BINARY
     0    (    .-.           ([   [  ,<   Z  Z   ,   ,<   @  * @ ,~   Z   2B   +   	Z   3B   +   Z  ,<   Z   2B   +   Z  	XB  
,\  2B  +   Z  ,<   Z   2B   +   Z  XB  ,\  3B  +   +   Z  2B   +   Z  3B   +   [  ,<   Z  D  +[  3B   +   Z  ,<   Z  ,<  Z  F  ,2B   +      ,Z   Z  2B  -+   %Z  [  Z  Z  2B  +   %[  !XB  $Z  ",<   ,<  -$  .Z   ,~   $B,`    (VARIABLE-VALUE-CELL TAG . 74)
(VARIABLE-VALUE-CELL FRA . 57)
(VARIABLE-VALUE-CELL LEVEL . 48)
(VARIABLE-VALUE-CELL FRAME . 55)
(VARIABLE-VALUE-CELL CODE . 73)
(VARIABLE-VALUE-CELL NLV . 24)
(VARIABLE-VALUE-CELL NF . 34)
RPLACD
PUTHASH
OPT.COMPILERERROR
JUMP
0
COMP.ST
(KNIL GETHSH ENTERF)  ( h  p                
COMP.STJUMP BINARY
    A    4    ?-.           4Z   B  73B   +   Z   ,~   Z   2B   +   
[   Z  XB  [  [  XB   Z  XB  	Z  	,<   Z  Z  ,   ,   ,<   ,<  8$  8Z  Z   ,   ,<   [  [  ,<   @  9 @,~   Z   3B   +   +   Z  ,<  Z   ,<  Z  F  :Z  
2B  ;+   Z   ,<  Z   XB  XB  ,\   +   .3B  ;+   2B  <+   "   /"   ,   XB  +   .3B  <+   $2B  =+   (Z  !,<     $/"   ,   XB  %,\   +   .2B  =+   .   &/"   ,   ,<   Z  XB  Z"   XB  ),\   +   .   >XB   Z   3B   +   1+   3[  ,<   Z  .D  >Z   ,~    @C`> p      (VARIABLE-VALUE-CELL OP . 49)
(VARIABLE-VALUE-CELL TAG . 98)
(VARIABLE-VALUE-CELL JT . 86)
(VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL FRA . 47)
(VARIABLE-VALUE-CELL FRAME . 87)
(VARIABLE-VALUE-CELL LEVEL . 89)
OPT.JUMPCHECK
0
COMP.ST
(VARIABLE-VALUE-CELL F . 39)
(VARIABLE-VALUE-CELL V . 94)
(NIL VARIABLE-VALUE-CELL NV . 100)
PUTHASH
JUMP
FJUMP
TJUMP
NFJUMP
NTJUMP
ERRORSET
OPT.COMPILERERROR
RPLACD
(ASZ MKN GETHSH CONSS1 CONS KNIL ENTERF)   -    + p !                4   P   H        
COMP.STSETQ BINARY
            -.           Z  Z   ,   ,<   ,<  $  ,~   `   (VARIABLE-VALUE-CELL VREF . 4)
SETQ
0
COMP.ST
(CONS ENTERF)    8      
COMP.STCOPY BINARY
               -.           Z   ,<   ,<  $  ,~       (VARIABLE-VALUE-CELL OPCOPY . 3)
1
COMP.ST
(ENTER0)     
COMP.DELPUSH BINARY
              -.           >   [   XB  ,~       (VARIABLE-VALUE-CELL LEVEL . 3)
(VARIABLE-VALUE-CELL CODE . 5)
(ENTER0)      
COMP.DELPOP BINARY
               -.               ."   ,   XB  [   XB  ,~       (VARIABLE-VALUE-CELL LEVEL . 6)
(VARIABLE-VALUE-CELL CODE . 8)
(MKN ENTER0)         
COMP.STBIND BINARY
    F    :    D-.           :Z   Z   ,   2B   +   Z  ,<   Z   ,<  Z  F  <[  [  Z  2B   +   [  [  ,<       ,>  9,>   [  	[  [  Z  [  Z  ,       ,^   /   /  ,   D  =Z   ,<   Zp  -,   +   Z   +   -Zp  ,<   ,<w/   @  =   +   )Z   3B  >+   3B  >+   3B  ?+   3B  ?+   2B  @+    Z   ,~   2B  @+   ([  Z  [  Z  2B   +   %Z   ,~   [  [  ,<   ,<  A$  A,~   Z   ,~   2B   +   +Z   +   -[p  XBp  +   /   3B   +   3[  ![  [  Z  [  [  ,<   ,<   $  BZ   Z  .,   Z  B,   ,<   ,<  C$  CZ  3XB  Z"   XB  ,~      A !!/~0ABI "`    (VARIABLE-VALUE-CELL F . 110)
(VARIABLE-VALUE-CELL FRA . 12)
(VARIABLE-VALUE-CELL FRAME . 111)
(VARIABLE-VALUE-CELL LEVEL . 113)
(VARIABLE-VALUE-CELL CODE . 38)
PUTHASH
RPLACA
(VARIABLE-VALUE-CELL X . 75)
TAG
HVAR
AVAR
GVAR
CONST
FN
FREEVARS
COMP.CLEANFNOP
RPLACD
BIND
0
COMP.ST
(ASZ CONS21 CONS KT SKNLST MKN BHC IUNBOX KNIL GETHSH ENTERF)    `   P   0 %              .          4 h + ( ) H 	  @    8      
COMP.STUNBIND BINARY
             -.          Z   3B   +   Z  +   Z  ,<   Z   Z   ,   ,   ,<   ,<  $  [  [  Z  ,   ,>  ,>   Z  3B   +   ^"   +   ^"   .Bx  ,^   /   ,   XB  Z  Z   ,   XB  ,~      `0E      (VARIABLE-VALUE-CELL D . 23)
(VARIABLE-VALUE-CELL LEVEL . 33)
(VARIABLE-VALUE-CELL FRAME . 37)
(VARIABLE-VALUE-CELL FRA . 35)
DUNBIND
UNBIND
0
COMP.ST
(GETHSH MKN BHC IUNBOX CONSS1 CONS KNIL ENTERF)                             0      
COMP.ARGTYPE BINARY
      :    0    8-.         @ 0Z   -,   +   B  4,~   Z  Z   ,   3B   +   Z"  ,~   Z  Z   ,   3B   +   Z"   ,~   Z  Z   ,   3B   +   Z"   ,~   Z  Z   ,   3B   +   Z"  ,~   Z   3B   +   !Z  Z   7   [  Z  Z  1H  +   2D   +   [  [  Z  2B   +   /Z  Z   ,   3B   +    Z  ,<   ,<  5$  52B   +   /Z   Z  ,<   ,<  6$  62B   +   /Z  !B  73B   +   'Z  $2B   +   /Z  &,<   ,<  7$  62B   +   /Z  'Z   ,   3B   +   .Z"  ,~   Z   ,~   B  4,~   
&F)       (VARIABLE-VALUE-CELL FN . 85)
(VARIABLE-VALUE-CELL LAMA . 9)
(VARIABLE-VALUE-CELL LAMS . 16)
(VARIABLE-VALUE-CELL NLAML . 23)
(VARIABLE-VALUE-CELL NLAMA . 30)
(VARIABLE-VALUE-CELL BLKFLG . 36)
(VARIABLE-VALUE-CELL BLKDEFS . 40)
(VARIABLE-VALUE-CELL BLKLIBRARY . 55)
(VARIABLE-VALUE-CELL NOFIXFNSLST . 86)
ARGTYPE
BLKLIBRARYDEF
GETP
BROKEN
GETPROP
GETD
EXPR
(ASZ KNIL FMEMB SKNLA ENTERF)  .    0     / P * x & @ !   0  8  X 
  h   H                
COMP.CLEANEXPP BINARY
              -.           Z   -,   +   Z   ,~   Z  ,<   Z   D  3B   +   [  ,<   Zp  -,   +   
Z   +   Zp  ,<   ,<w/   @     +   Z  ,<   Z  D  ,~   2B   +   Z   +   [p  XBp  +   /   ,~   	H    (VARIABLE-VALUE-CELL X . 28)
(VARIABLE-VALUE-CELL TYPE . 30)
COMP.CLEANFNP
COMP.CLEANEXPP
(BHC KNIL KT SKNLST ENTERF)    P   (   p   (     	  0      
COMP.CLEANFNP BINARY
             -.          Z   -,   +   Z   ,<  ,<    "   ,   ,~   -,   +   Z   ,~   Z  3B  +   
2B  +   [  [  ,<   Zp  -,   +   Z   +    Zp  ,<   ,<w/   @     +   Z  
,<   Z   D  ,~   2B   +   Z   +    [p  XBp  +   Z   ,~   	   (VARIABLE-VALUE-CELL X . 36)
(VARIABLE-VALUE-CELL TYPE . 38)
(VARIABLE-VALUE-CELL CLEANFNTEST . 6)
LAMBDA
OPENLAMBDA
COMP.CLEANEXPP
(BHC URET1 KT KNIL SKNLST EVCC SKLA ENTERF)        p   h     X       p    `    0      
COMP.CLEANFNOP BINARY
            -.          Z   ,<   Z   ,<  Z   ,<   "  ,   ,~       (VARIABLE-VALUE-CELL FN . 5)
(VARIABLE-VALUE-CELL TYPE . 7)
(VARIABLE-VALUE-CELL CLEANFNTEST . 3)
(EVCC ENTERF)   `      
COMP.GLOBALVARP BINARY
        	        -.          Z   ,<   ,<  $  2B   +   Z  Z   ,   ,~       (VARIABLE-VALUE-CELL X . 9)
(VARIABLE-VALUE-CELL GLOBALVARS . 10)
GLOBALVAR
GETP
(FMEMB KNIL ENTERF)   h    H      
COMP.LINKCALLP BINARY
    "        !-.         ( Z   -,   +   Z   Z  ,   3B   +   Z   ,~   Z   3B   +   Z  Z   7   [  Z  Z  1H  +   2D   +   	2B   +   Z  Z   ,   3B   +   Z   ,~   Z   -,   +   Z  Z  ,   3B   +   Z   ,~   Z  2B   +   Z   ,~   Z  2B   +   Z  2B   7   7   +   Z   ,~    !@ (VARIABLE-VALUE-CELL FN . 38)
(VARIABLE-VALUE-CELL NOLINKFNS . 45)
(VARIABLE-VALUE-CELL BLKFLG . 50)
(VARIABLE-VALUE-CELL BLKDEFS . 17)
(VARIABLE-VALUE-CELL BLKLIBRARY . 29)
(VARIABLE-VALUE-CELL LINKFNS . 53)
(KT KNIL FMEMB SKLST ENTERF)   `  @  h      (  X  `      X   P   P   0        
COMP.ANONP BINARY
             -.           Z   3B   +   Z   Z  ,   ,~   Z   3B   +   Z  Z  ,   2B   +   Z   3B   +   Z  Z   ,   2B   +   7   Z   ,~   	 (VARIABLE-VALUE-CELL E . 21)
(VARIABLE-VALUE-CELL LOCALVARS . 7)
(VARIABLE-VALUE-CELL SPECVARS . 14)
(VARIABLE-VALUE-CELL BLKFLG . 18)
(VARIABLE-VALUE-CELL LOCALFREEVARS . 22)
(KNIL FMEMB KT ENTERF)   h  ( 	            h        
COMP.CPI BINARY
       7    +    6-.         0 +Z   ,<   @  /   ,~   Z   Z   2B  +   Z   ,<  Z   ,<  Z  B  /F  0,<   Z  Z  2B  +   Zp  +   ,<   "  0+   
/   Z   1B   +   B  1,<  1Z   D  2Z  2,~   Z  3B  3+   2B  3+   "[  Z  [  Z      Z  47   [  Z  Z  1H  +   2D   +   3B   +   &[  [  [  Z  [  [  [  2B   +   &Z   ,<   Z  ,<  ,<  4&  5+   *Z  Z   ,   XB  &3B   +   )+      5Z   ,~   GgAP8   (VARIABLE-VALUE-CELL FN . 69)
(VARIABLE-VALUE-CELL ARGS . 71)
(VARIABLE-VALUE-CELL FRAME . 20)
(VARIABLE-VALUE-CELL TOPFRAME . 21)
(VARIABLE-VALUE-CELL ARGVARS . 14)
(VARIABLE-VALUE-CELL LEVEL . 30)
(VARIABLE-VALUE-CELL TOPLAB . 35)
(VARIABLE-VALUE-CELL FRA . 77)
(VARIABLE-VALUE-CELL F . 79)
COMP.PICOUNT
COMP.CPI1
COMP.STUNBIND
COMP.STPOP
JUMP
COMP.STJUMP
NOVALUE
PROG
LAMBDA
AVAR
0
COMP.CALL
OPT.COMPILERERROR
(GETHSH ASZ BHC KT KNIL ENTERF)   (                +  " `  (      
COMP.CPI1 BINARY
    $        #-.           Z   2B   +   Z   -,   +   Z   ,~   Z  B   [  ,<       /"   ,   XB  ,\   XB  +      	0b   +   Z  
-,   +   Z  ,<   Z  [  ,\  3B  +   Z  B  ![  ,<   [  ,<      /"   ,   F  !Z  B  "   ",~   [  ,<   [  ,<      /"   ,   XB  ,\   XB  ,\   XB  +   " I@,  (VARIABLE-VALUE-CELL ARGS . 60)
(VARIABLE-VALUE-CELL VARS . 58)
(VARIABLE-VALUE-CELL N . 56)
COMP.EFFECT
COMP.VAL
COMP.CPI1
COMP.STSETQ
COMP.STPOP
(SKLA MKN SKNLST KNIL ENTERF)  `   H      H    X        
COMP.PICOUNT BINARY
                -.          Z   ,<   @    ,~   Z   3B   +       ."   ,   XB  Z   -,   +   Z  ,<   Z  [  ,\  3B  +   Z  	,<   ,<  $  2B   +   Z  XB   [  
XB  [  XB  +   Z  ,~   	P     (VARIABLE-VALUE-CELL ARGS . 36)
(VARIABLE-VALUE-CELL ARGVARS . 3)
(VARIABLE-VALUE-CELL VARS . 34)
(0 VARIABLE-VALUE-CELL N . 31)
(0 VARIABLE-VALUE-CELL ND . 38)
COMP.PICOUNT
COMP.CLEANEXPP
(SKLA MKN KNIL ENTERF)       x   x        
COMP.EVQ BINARY
               -.           @    ,~   Z   B  ,~   @   (VARIABLE-VALUE-CELL X . 6)
(NIL VARIABLE-VALUE-CELL COMPVARMACROHASH . 0)
COMP.EXP1
(ENTERF)      
COMP.BOOL BINARY
      :    /    8-.          /Z   2B   +   Z   B  1,~   [  2B   +   Z  B  1,~       ."   ,   XB  ,   Z  2,   ,<   @  2  ,~   Z   B  33B   +   Z  XB   Z  3B  4+   2B  4+   Z  3B   +   %Z  5+   #3B  5+   2B  5+   Z  3B   +   +   %Z  4+   #   6+   #Z  2B  6+    Z  3B   +   Z  5+   #Z  4+   #Z  3B   +   "Z  5+   #Z  4,<   Z   ,<   ,   XB  [  3B   +   *Z  %,<   Z  %D  7[  'XB  )+   %Z  ),<   Z  D  7,<   Z  #B  7,\   ,~   E#Os{       (VARIABLE-VALUE-CELL A . 85)
(VARIABLE-VALUE-CELL FLAG . 64)
(VARIABLE-VALUE-CELL LBCNT . 18)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 87)
COMP.CONST
COMP.EXP1
TAG
(VARIABLE-VALUE-CELL END . 90)
(NIL VARIABLE-VALUE-CELL P . 80)
COMP.PREDP
TJUMP
NTJUMP
FJUMP
NFJUMP
OPT.COMPILERERROR
EFFECT
COMP.EXPR
COMP.STTAG
(LIST2 CONS21 CONSNL MKN KNIL ENTERF)  X   8   (      p ! `  @   `        
COMP.APPLYFNP BINARY
               -.          Z   -,   +   Z  3B  +   2B  +   [  [  2B   +   [  Z  B  2B   +   [  Z  Z   ,   3B   +   Z  +   [  
Z  Z  ,   XB  Z   ,~   1B   +   1B   +   0B  +   Z   ,~   Z   ,~   Z   ,~   Z   ,~   Z   ,~   xJ T    (VARIABLE-VALUE-CELL X . 28)
(VARIABLE-VALUE-CELL ALAMS1 . 32)
FUNCTION
QUOTE
COMP.ARGTYPE
(ASZ KT CONS FMEMB KNIL SKLST ENTERF)   H  (   X                h               
COMP.AC BINARY
                -.           Z   XB   Z   3B  +      Z   ,~   `   (VARIABLE-VALUE-CELL EXP . 3)
(VARIABLE-VALUE-CELL AC . 4)
(VARIABLE-VALUE-CELL DONOTHING . 5)
COMP.PUNT
(KNIL ENTER0)         
COMP.PUNT BINARY
              -.           Z   Z  ,   ,<   @     ,~   Z   3B   +   Z  ,<   Z  Z   ,   ,   Z  ,   +   Z  B  Z   ,~   B"P (VARIABLE-VALUE-CELL EXP . 3)
(VARIABLE-VALUE-CELL MACEXP . 13)
((-- can't compile) . 0)
(VARIABLE-VALUE-CELL EM . 22)
-
Under
COMPERROR
(CONS21 CONSS1 KNIL CONS ENTER0)       
      h           
COMP.FUNCTION BINARY
               -.           Z   ,<   @     ,~   Z   -,   +   B  XB  [  3B   +   ,<  Z  [  ,   ,<   ,<  &  ,~   Z  B  ,~   0d (VARIABLE-VALUE-CELL A . 18)
(VARIABLE-VALUE-CELL FN . 24)
COMP.LAM1
FUNCTION
1
COMP.CALL
COMP.STCONST
(CONS KNIL SKLST ENTERF)  (        X      
COMP.LAM1 BINARY
            -.             ,<   @     ,~   Z   ,<   Z   D  Z   ,<   @    +   Z`  -,   +   
+   Z  XB   Z  3B  +   [  Z   ,   2B   +   +   Z  ,<   ,<  $  [`  XB`  +   Z` ,~   Z  ,~   S    (VARIABLE-VALUE-CELL DEF . 10)
(VARIABLE-VALUE-CELL ALLVARS . 12)
(VARIABLE-VALUE-CELL SUBFNFREEVARS . 27)
COMP.GENFN
(VARIABLE-VALUE-CELL FN . 41)
COMP.TOPLEVEL.COMPILE
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 32)
AVAR
RPLACA
(KNIL FMEMB SKNLST ENTERF)  x   p          
COMP.GENFN BINARY
                -.           Z   B  ,   ,>  ,>   ^"  ,>  ,>   Z   B  ,   .Bx  ,^   /       ,^   /   2b  +   ^"  ,>  ,>   Z  B  ,   .Bx  ,^   /   ,   B  XB      1" '+   Z"   XB  Z  ,<      ."   ,   XB  ,<   Z  ,<  ,<   Z"   J  ,~       R@ @  (VARIABLE-VALUE-CELL COMP.GENFN.BUF . 46)
(VARIABLE-VALUE-CELL COMFN . 39)
(VARIABLE-VALUE-CELL COMP.GENFN.NUM . 44)
NCHARS
ALLOCSTRING
GENSYM
(KNIL ASZ MKN BHC IUNBOX ENTER0)        8   h      ( 	      x        
COMP.COND BINARY
      Y    I    W-.           I    ."   ,   XB  ,   Z  L,   ,<   @  L   
,~   Z   XB   Z  XB   [  3B   +   0Z  ,<   ,<  O   ."   ,   XB  ,   Z  L,   XB   ,   D  OZ   B  P3B   +   +   [  	,<   Z   B  P3B   +   Z   +   Z  D  QZ  3B  Q+   Z  B  P2B   +   ,<  RZ   XB   D  RZ   2B   +   /Z  ,<  @  S  +   .Z`  -,   +   $+   -Z  XB   [  $-,   Z   Z  Z  2B  +   +Z  %2B   +   *Z   XB` +   -[`  XB`  +   "Z` ,~   3B   +   CZ  'B  T+   >[  3B   +   9Z  
,<   Z  2B  U+   5Z  U+   6Z  V,<   Z  XB  ,   D  O+   >Z  2,<   Z  3B  P3B   +   =Z   +   =Z  :D  O+   C[  0XB  >3B   +   A+   Z  =3B  U+   C,<   "  OZ  73B   +   FZ  6B  TZ  A2B  U+   HZ  V,~   Z   ,~   $"1*k) $HY1Z+     (VARIABLE-VALUE-CELL A . 126)
(VARIABLE-VALUE-CELL LBCNT . 27)
(VARIABLE-VALUE-CELL CODE . 63)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 140)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 60)
TAG
(VARIABLE-VALUE-CELL END . 138)
(NIL VARIABLE-VALUE-CELL NEXT . 94)
(NIL VARIABLE-VALUE-CELL PRED . 114)
(NIL VARIABLE-VALUE-CELL CLAUSE . 39)
(NIL VARIABLE-VALUE-CELL ENDF . 135)
FJUMP
COMP.EXPR
OPT.JUMPCHECK
COMP.PREDP
COMP.VALN
RETURN
JUMP
COMP.STJUMP
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 81)
COMP.STTAG
EFFECT
TJUMP
NTJUMP
NOVALUE
(KT SKLST SKNLST ALIST2 KNIL CONS21 CONSNL MKN ENTERF)  +    &    #    8    	 E 8 @ P <   /   ' x  x  0 
      X   p       8      
COMP.SELECTQ BINARY
     (      #-.         (    ."   ,   XB  ,   Z ,   ,<   @   (,~   Z   B [  XB  Z   Z  Z   ,   3B   +   Z  	XB     +   +Z  Z  2B +   Z  [  Z  Z  
,   3B   +   Z  [  XB    +   +Z  Z  2B +   *Z  [  ,<   @    +   )  [  2B   +   Z  ,~   Z  Z  -,   +   #Z   Z  Z  ,   3B   +   '+   &Z   Z  Z   2B  +   'Z  #[  ,~   [  &XB  '+   B ,~   Z   XB   [  (2B   +   9Z  *3B   +   0Z  2B   +   0  Z  +,<   Z   B 3B   +   4Z   +   4Z  1D ,<   Z  43B +   8Z   B ,\   ,~   Z   XB  ,Z  0,<   [  :XB  ;,\   XB   Z  XB   -,   +   a[  =-,   +   BZ  ?XB  @+   aZ   3B   +   KZ  .3B   +   FB +   H[  ;3B   +   H  Z  AB B ,< ,< $ +   i   ."   ,   XB  K,   Z ,   XB  9Z  H,<  Zp  -,   +   R+   `,<   @    +   _[   3B   +   ]Z  C3B   +   XB +   Y  Z  TB ,< ,< $ ,< Z  OD  ,~   Z  YXB  O,~   [p  XBp  +   P/   Z  V3B   +   cB +   gZ  \2B   +   f[  F3B   +   g  Z  ^B ,< ,< $ Z  c2B   +   y[  e2B   +   yZ  k2B   +   yZ  52B  +   pZ !+   qZ !,<   Z  7D  [  <,<   Z  n2B  7   7   +   vZ  sD ",<   Z  qB ,\   ,~   ,< !   M."   ,   XB  z,   Z ,   XB   D  Z  i3B   +   B Z  ~2B   +  [  l3B   +  Z  a2B   +    [  r,<   Z  v3B  +  	2B +  	+  
Z   D "Z 3B +  ,< "Z  wD  Z  }B +   +$ L,A1*h 	9?)zMrKrILIGkV          (VARIABLE-VALUE-CELL A . 260)
(VARIABLE-VALUE-CELL LBCNT . 247)
(VARIABLE-VALUE-CELL CODE . 48)
(VARIABLE-VALUE-CELL SELECTVARTYPES . 35)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 277)
(VARIABLE-VALUE-CELL SELECTQFMEMB . 132)
TAG
(VARIABLE-VALUE-CELL END . 281)
(NIL VARIABLE-VALUE-CELL VAR . 263)
(NIL VARIABLE-VALUE-CELL THISLABEL . 257)
(NIL VARIABLE-VALUE-CELL NEXT . 283)
(NIL VARIABLE-VALUE-CELL TEST . 206)
(NIL VARIABLE-VALUE-CELL CLAUSE . 267)
COMP.VAL
COMP.DELPUSH
SETQ
COMP.STPOP
CONST
(VARIABLE-VALUE-CELL C . 73)
COMP.PROGN
COMP.PREDP
COMP.EXPR
RETURN
COMP.STTAG
COMP.STVAR
COMP.STCOPY
APPEND
COMP.STCONST
FMEMB
2
COMP.STFN
(VARIABLE-VALUE-CELL Y . 187)
EQ
TJUMP
COMP.STJUMP
EFFECT
FJUMP
NFJUMP
COMP.VALN
JUMP
(BHC SKNLST KT SKLST KNIL FMEMB CONS21 CONSNL MKN ENTERF)  a    R    ` +    ?     ( 8   u ` l 0 f P b 
x V x E 8 : @ 3 x . H # P  @   (  8   ` O  X   P N  H   @ M  8      
COMP.QUOTE BINARY
        	        	-.          [   3B   +   Z   Z  ,   B  Z  B  ,~   T   (VARIABLE-VALUE-CELL A . 10)
(VARIABLE-VALUE-CELL EXP . 6)
((- probable parenthesis error) . 0)
COMPERRM
COMP.CONST
(CONS KNIL ENTERF)   P    0      
COMP.COMMENT BINARY
              -.          Z   3B  	+   Z   Z  	,   B  
Z   B  
,~   Z  ,~   U   (VARIABLE-VALUE-CELL A . 10)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 3)
(VARIABLE-VALUE-CELL EXP . 6)
EFFECT
((- value of comment used?) . 0)
COMPERRM
COMP.STCONST
NOVALUE
(CONS ENTERF)         
COMP.DECLARE BINARY
        +         *-.           Z   ,<   Zp  -,   +   +   Zp  ,<   @  "   +   Z   2B  "+   [  ,<   ,<  ",<  #Z   H  #,~   2B  #+   [  ,<   ,<  #,<  "Z   H  #,~   3B  $+   3B  $+   3B  %+   3B  %+   3B  &+   3B  &+   2B  '+   Z  B  ',~   2B  (+   ,~   Z  Z  (,   B  ),~   [p  XBp  +   /   Z  B  ),~   e3,kze	      (VARIABLE-VALUE-CELL A . 62)
(VARIABLE-VALUE-CELL SYSSPECVARS . 21)
(VARIABLE-VALUE-CELL SYSLOCALVARS . 30)
(VARIABLE-VALUE-CELL B . 53)
LOCALVARS
SPECVARS
COMP.DECLARE1
ADDTOVAR
DEFLIST
PUTPROPS
CONSTANTS
SETQQ
USEDFREE
GLOBALVARS
EVAL
TYPE
((- used in DECLARE) . 0)
COMPERRM
COMP.CONST
(BHC CONS SKNLST ENTERF)                  
COMP.DECLARE1 BINARY
       (    !    &-.           !Z   ,<   Z   -,   +   Z  Z 7@  7   Z  XB  -,   +   
Z  ,<  D  $+   3B   7   7   +   Z  +   2B   +   Z   Z   ,   Z   +       ,\   ,   [   Z  [  Z  ,<   Zp  -,   +   Z   +    Zp  ,<   @  $  +    [   B  %XB   ,<   Z  ,\  3B  +   Z  ,<   Z  D  &,~   [p  XBp  +   @& BP"     (VARIABLE-VALUE-CELL VAL . 24)
(VARIABLE-VALUE-CELL VAR . 13)
(VARIABLE-VALUE-CELL OTHERVAR . 28)
(VARIABLE-VALUE-CELL SYSOTHERVAR . 29)
(VARIABLE-VALUE-CELL FRAME . 36)
APPEND
(VARIABLE-VALUE-CELL V . 59)
(NIL VARIABLE-VALUE-CELL VTAG . 61)
COMP.VARTYPE
RPLACA
(URET1 SKNLST SET KNIL KT KNOB SKLST ENTERF)                p      `  0    h            
COMP.CARCDR BINARY
            -.          Z   2B  +   Z   ,<  D  ,~   Z  B  Z   ,<   ,<  $  ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   Z   2B  +   Z  +   Z  ,<   ,<  $  ,~   [p  XBp  +   $b
}    (VARIABLE-VALUE-CELL A . 10)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 3)
(VARIABLE-VALUE-CELL EXP . 12)
EFFECT
COMP.VAL1
CROPS
GETPROP
(VARIABLE-VALUE-CELL X . 27)
A
CAR
CDR
1
COMP.STFN
(URET1 KNIL SKNLST ENTERF)   8   0          
COMP.STCROP BINARY
       
        	-.           Z   2B  +   Z  +   Z  ,<   ,<  $  	,~   l   (VARIABLE-VALUE-CELL X . 3)
A
CAR
CDR
1
COMP.STFN
(ENTERF)     
COMP.NOT BINARY
             -.          Z   B  3B   +   Z  B  XB   3B   +   Z   ,<   Z  D  ,~   Z  B  ,<  ,<  $  ,~   $'@ (VARIABLE-VALUE-CELL A . 17)
(VARIABLE-VALUE-CELL TMP . 14)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 7)
COMP.PREDP
OPT.NOTJUMP
COMP.EXPR
COMP.VAL1
NULL
1
COMP.STFN
(KNIL ENTERF)  `        
COMP.SETQ BINARY
              -.          @    ,~   Z   B  XB   ,<   Z   D  XB   [  Z  ,<   [  D  Z  B  Z   ,~   D
  (VARIABLE-VALUE-CELL A . 13)
(VARIABLE-VALUE-CELL ALLDECLS . 10)
(NIL VARIABLE-VALUE-CELL VAR . 18)
(NIL VARIABLE-VALUE-CELL DECL . 16)
COMP.LOOKUPVAR
ASSOC
COMP.EXPR
COMP.STSETQ
(KNIL ENTERF) 0      
COMP.SETN BINARY
            -.           Z   Z  ,   B  Z  B  ,~       (VARIABLE-VALUE-CELL A . 7)
((- warning: SETN compiled as SETQ) . 0)
COMPERRM
COMP.SETQ
(CONS ENTERF)  8      
COMP.LAMBDA BINARY
      0      +-.         8[   Z  ,<   [  [  ,<   @  @8,~   Z  2B +   V,<   Z   2B   +   
Zp  +    Z   ,<   [  
XB  ,\   B Z   Z  2B +   Z  ,<   [  XB  ,\   Z   ,   XB  Z  [  3B   +   3B   +   -,   +   ,< ,<   ,   Z   ,   XB    +   Z  ,<   [  XB  ,\   Z   ,   XB  +   /   Z  ,<   Zp  -,   +   #+   &Zp  B [p  XBp  +   !/   ,<   Z  3B   +   6Z  Z  3B +   -3B +   -3B  +   -2B  +   0Z  ([  @ ,\   +   42B !+   4Z  -[  [  @ !,\   +   4Z   XB   2B   +   7Zp  +   =Z  ,   XB  7Z  ',<   [  8XB  9,\   Z  ,   XB  ;+   '/   Z  :2B   +   CZ  <,<  Z  8,<  Z   F "B ",~   ,<   Z  =2B   +   FZp  +   P  #Z  ,   XB  FZ  Z  @,   XB  HZ  C,<   [  JXB  K,\   Z  ?,   XB  LZ   Z   ,   XB  N+   C/   Z  M,<   Z  I,<  Z  AF "Z #,   XB  S+   {Z  B $0B   +   X+   {0B   +   kZ  O,<   ,<   Zw-,   +   aZp  Z   2B   +   _ "  +   a[  QD   "  +   iZw3B   +   f3B   +   f-,   +   f,< ,<   ,   Zp  ,   XBp  [wXBw+   [/  XB  Y+   {0B  +   pZ  VB $,<   Z  j,<   ,< %& %,~   0B  +   yZ  G,   XB  qZ  m3B   +   w3B   +   w-,   +   w,< ,<   ,   ,   XB  r+   {Z  lZ &,   B &Z  r,<   Z  x,<  ,< 'Z  UB 'H (XB   [  Z  [  Z  ,<   Z   D (,<   [  Z  [  [  ,<   Z   D (,<   Z   ,<   Z   ,<  @   +  Z B )Z  },<   Z   3B )+  2B *+  +  Z   D *,~   Z B +,~   E0,H'|\( ,  -(J`#+!`$         (VARIABLE-VALUE-CELL FN . 242)
(VARIABLE-VALUE-CELL VALS . 248)
(VARIABLE-VALUE-CELL CODE . 98)
(VARIABLE-VALUE-CELL DONOTHING . 156)
(VARIABLE-VALUE-CELL ALLVARS . 260)
(VARIABLE-VALUE-CELL ALLDECLS . 268)
(VARIABLE-VALUE-CELL LOCALVARS . 271)
(VARIABLE-VALUE-CELL SPECVARS . 273)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 282)
(VARIABLE-VALUE-CELL VARS . 246)
(VARIABLE-VALUE-CELL EXPS . 280)
(NIL VARIABLE-VALUE-CELL F . 291)
(NIL VARIABLE-VALUE-CELL V . 151)
(NIL VARIABLE-VALUE-CELL E . 0)
(0 VARIABLE-VALUE-CELL I . 0)
(NIL VARIABLE-VALUE-CELL SUBOLD . 162)
(NIL VARIABLE-VALUE-CELL SUBNEW . 164)
(NIL VARIABLE-VALUE-CELL VAR . 105)
OPENLAMBDA
COMP.VAL
CONST
QUOTE
COMP.DELPUSH
COMP.EFFECT
AVAR
HVAR
FVAR
GVAR
SETQ
COMP.STPOP
SUBPAIR
COMP.PROGN
COMP.GENFN
((DECLARE (LOCALVARS . T)) . 0)
ARGTYPE
COMP.LAM1
2
COMP.CALL
((- illegal open function) . 0)
COMPERROR
LAMBDA
COMP.LOOKFORDECLARE
COMP.BIND.VARS
APPEND
COMP.STBIND
EFFECT
RETURN
COMP.VALN
COMP.UNBIND.VARS
(CONSNL COLLCT ASZ CONS21 SKNLST BHC LIST2 SKNNM KT CONS KNIL ENTERF)    r    h    q @ Y     
X   H #    j 
 > p !    x p     v P     u @     { 
  N 	  H H 8 x  8    t 0 ^ ` [ P D p 6 P ( x          
COMP.PROG BINARY
     5      0-.         XZ   ,<   ,<   Zw-,   +   	Zp  Z   2B   +    "  +   	[  QD   "  +   Zw,<   @    +   Z   -,   +   ,~   -,   +   Z ,   B ,~   Z  ,~   Zp  ,   XBp  [wXBw+   /  ,<   Z  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   +Zw,<   @    +   (Z  -,   +   '[   [  3B   +   &Z  [  ",   ,~   [  $Z  ,~   Z   ,~   Zp  ,   XBp  [wXBw+   /  ,<   @   @,~   Z   ,<   Z   ,<  ,< "[  XB  0B "H #XB   [  2Z  [  Z  ,<   Z   D #,<   [  3Z  [  [  ,<   Z   D #,<   Z   ,<   Z   ,<  ,<       ."   ,   XB  =,<   Z   2B $+   BZ"   +   CZ"   ,   Z $,   XBp  ,<   ,<   Z  7,<  Z   F %,\   /   ,<   Z  @3B $+   L2B %+   L+   MZ   ,<   @ &@+  Z  FB *Z  1,<   Zp  -,   +   S+   nZp  ,<   @    +   mZ  &-,   +   l-,   +   ZZ +,   B ,~   Z  UZ   7   [  Z  Z  1H  +   _2D   +   [3B   +   bZ  ZZ +,   B ,~   Z  `,<   ,   Z $,   XB  b,   Z  Z,   XB  fZ  e,<  Z   ,<  Z  GF %[  g,<   ,< ,$ ,,~   [p  XBp  +   Q/   [  O[  [  ,<   Z  gD ,Z   2B   +   wZ  q2B   +   wZ   2B %7   Z   +   xZ   XB   Z  P,<  Zp  -,   +   {+  Zp  ,<   @    +  Z  j-,   +  Z  ~Z  s7   [  Z  Z  1H  +  2D   +  [  B -,~   B -Z  x3B   +  ,<   Z   Z   3B  +  Zp  +    .+  /   ,~   [p  XBp  +   y/   Z  I3B $+  Z B .2B   +  ,<   " /Z 3B %+  Z   B -,~   Z  oB /,~   "DR4
H@ H	@@  i e!J- U! DJ 2
RBjZ        (VARIABLE-VALUE-CELL A . 241)
(VARIABLE-VALUE-CELL ALLVARS . 107)
(VARIABLE-VALUE-CELL ALLDECLS . 115)
(VARIABLE-VALUE-CELL LOCALVARS . 118)
(VARIABLE-VALUE-CELL SPECVARS . 120)
(VARIABLE-VALUE-CELL LBCNT . 126)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 296)
(VARIABLE-VALUE-CELL FRA . 211)
(VARIABLE-VALUE-CELL FRAME . 209)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 228)
(VARIABLE-VALUE-CELL CODE . 290)
(VARIABLE-VALUE-CELL OPPOP . 274)
(VARIABLE-VALUE-CELL X . 255)
((- bad PROG variable) . 0)
COMPERROR
PROG1
(VARIABLE-VALUE-CELL VARS . 92)
(VARIABLE-VALUE-CELL VALS . 94)
(NIL VARIABLE-VALUE-CELL F . 302)
PROG
COMP.LOOKFORDECLARE
COMP.BIND.VARS
APPEND
EFFECT
TAG
PUTHASH
RETURN
(VARIABLE-VALUE-CELL ALLVARS . 0)
(VARIABLE-VALUE-CELL ALLDECLS . 0)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(VARIABLE-VALUE-CELL SPECVARS . 0)
(VARIABLE-VALUE-CELL RETURNLABEL . 299)
(VARIABLE-VALUE-CELL PROGCONTEXT . 234)
(NIL VARIABLE-VALUE-CELL TAGS . 256)
(NIL VARIABLE-VALUE-CELL PROGLEVEL . 0)
(NIL VARIABLE-VALUE-CELL FLG . 269)
COMP.STBIND
((- illegal tag) . 0)
((- multiply defined tag) . 0)
0
RPLACD
COMP.STTAG
COMP.EFFECT
COMP.DELPOP
OPT.JUMPCHECK
COMP.EXPR
COMP.UNBIND.VARS
(KT CONSNL SKNLA CONS21 CONSS1 ASZ MKN SKLST BHC COLLCT CONS SKLA SKNLST KNIL ENTERF)  x   H       X E    f @   8 B    ?    "    X o 	 , `         g   Y `      X   0 W 
(  p     0	    w P s   _ 	X >  $ 0      `        
COMP.GO BINARY
        )        '-.          @  !  ,~   Z   B  "3B   +   Z  ",~   Z   2B  #+   Z   ,<   [  [  [  [      ,\   7   [  Z  Z  1H  +   2D   +   XB   3B   +   Z   1B   +   B  #,<  $[  D  $Z  ",~   Z   XB   +   2B  %+   +   Z  ,<   Z  3B   +   Z  %+   Z  &,   B  &,<   "  '+   Y@ Rv,      (VARIABLE-VALUE-CELL A . 49)
(VARIABLE-VALUE-CELL CODE . 6)
(VARIABLE-VALUE-CELL FRAME . 17)
(VARIABLE-VALUE-CELL LEVEL . 34)
(NIL VARIABLE-VALUE-CELL D . 39)
(NIL VARIABLE-VALUE-CELL ANYPROG . 51)
OPT.JUMPCHECK
NOVALUE
PROG
COMP.STPOP
JUMP
COMP.STJUMP
LAMBDA
((- undefined tag) . 0)
((- illegal GO) . 0)
COMPERROR
COMP.STUNBIND
(CONSS1 KT ASZ KNIL ENTERF)   X   h             P      
COMP.RETURN BINARY
       6    (    5-.         8 (Z   ,<   @  ,   ,~   Z   3B  -+   
3B  -+   
Z   1B   +   
Z  2B  .+   
Z  B  .Z   2B  .+   +   2B  /+   Z  
Z   ,   XB  +   
Z   Z  /,   B  0Z   ,<   Z  D  0Z   B  13B   +   Z  1,~   Z  3B  -+   'Z  2B  .+   +    2B  /+   Z  2B  -7   Z   B  2+   Z  Z  2,   B  0Z  2B  -+   #Z  	B  .+   &Z  "1B   +   &,<  3"  3,<  4Z   D  4Z  1,~   ->

f}[=@   (VARIABLE-VALUE-CELL A . 36)
(VARIABLE-VALUE-CELL FRAME . 49)
(VARIABLE-VALUE-CELL PROGCONTEXT . 65)
(VARIABLE-VALUE-CELL LEVEL . 71)
(VARIABLE-VALUE-CELL FRA . 28)
(VARIABLE-VALUE-CELL COMFN . 61)
(VARIABLE-VALUE-CELL CODE . 40)
(VARIABLE-VALUE-CELL RETURNLABEL . 77)
(VARIABLE-VALUE-CELL PROGFRAME . 30)
RETURN
EFFECT
PROG
COMP.STPOP
LAMBDA
((- illegal RETURN) . 0)
COMPERROR
COMP.VAL1
OPT.JUMPCHECK
NOVALUE
COMP.STUNBIND
((- illegal RETURN) . 0)
((unimplemented RETURN) . 0)
OPT.COMPILERERROR
JUMP
COMP.STJUMP
(KT KNIL CONS GETHSH ASZ ENTERF) `   X           x   P        
COMP.NUMERIC BINARY
       !      -.     (     Z   ,<   @   ,~   Z   2B +   Z   2B   +   Z   B ,~   Z   2B   +   Z   XB  Z  -,   Z   Z  2B +   [  Z   3B  +   3[  Z   7   [  Z  Z  1H  +   2D   +   XB   3B   +   3Z  XB  [  Z  XB  
+   32B +   3[  Z  7   [  Z  Z  1H  +   2D   +   [  [  Z  XB  3B   +   3,<   Z  2B   +   %Zp  +   ,Z  #,<   [  %XB  &,\   ,<   Z  D     ."   ,   XB  )+   #/      +/"   4b  2,> ,>   Z  !,<   ,< $ >`x  5   //  Z ,~   ,<   Z  '2B   +   6Zp  +   `Z  4,<   [  6XB  7,\   ,<   Z  2B   +   <Z XB  9Z ,   D    ,."   ,   XB  =Z  2B   +   `Z  ;B ,<   Z   ,<   Z  D 2B   +   FZp  +   N   ?,> ,>   Z  B[  Z  ,   .Bx  ,^   /   . ,   XB  F  +   B/   Z  HZ  2B +   `   L1b   +   `Z   3B   +   XZ  
,<  ,<   Z  N[  ,<    "  ,   +   ]Z  A2B   +   ZZ ,<   Z  U[  ,<    "   ,   XB  R     P/"   ,   XB  ^+   4/   Z  ]3B   +   ~Z  S,<   Z  a,<   "   ,   ,<   Z  b,<    "   ,   ,\  ,   3B   +   j+   ~Z  cZ   ,   3B   +   r   _4b  q,> ,>     >`x  5   o/  Z  jB ,~      m1b   +   {Z  q,   5"  {Z  C2B +   {   t"   ,   B ,< ,< $ +   ~Z  wB    r."   ,   XB  |Z  }0B   +  Z  f,<   "   ,   B +  0B   +  Z  XB +     ~/"   4b ,> ,>   Z  u,<   ,< $ >`x  5  /  Z   ,~      "
 p
P#!@@PU L2 	 B -$%Ghkh      (VARIABLE-VALUE-CELL A . 112)
(VARIABLE-VALUE-CELL 2FN . 271)
(VARIABLE-VALUE-CELL TYPE . 263)
(VARIABLE-VALUE-CELL ZERO . 214)
(VARIABLE-VALUE-CELL COERSIONS . 54)
(VARIABLE-VALUE-CELL EXP . 3)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 81)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 127)
(VARIABLE-VALUE-CELL CODE . 181)
(VARIABLE-VALUE-CELL FN . 255)
(0 VARIABLE-VALUE-CELL N . 266)
(NIL VARIABLE-VALUE-CELL V . 246)
(NIL VARIABLE-VALUE-CELL TMP . 94)
EFFECT
COMP.PROGN
TYPE
UNBOXED
COMP.EXPR
2
COMP.STFN
FIX
COMP.DELFIX
OPT.CALLP
COMP.DELFN
CONST
COMP.DELPUSH
COMP.STPOP
COMP.STCONST
IPLUS
IDIFFERENCE
COMP.STFIX
(ASZ GUNBOX EQUAL EVCC IUNBOX CONS21 BHC MKN SKLST KNIL ENTERF)  8     u    l      h ` ]     	(   X   8 q  O 	@ 3 P   ` y   M x +        P j ( Y 
8 E 0 A 0 5 H $ 8 " x  P           
COMP.NUMBERCALL BINARY
     u    d    q-.         ( d@  h  ,~   Z   2B  i+   Z   2B   +   Z   B  i,~   Z  -,   Z   Z  2B  j+   [  Z   3B  +   0[  
Z   7   [  Z  Z  1H  +   2D   +   XB   3B   +   0Z  XB  [  Z  XB   +   02B  j+   0[  Z  7   [  Z  Z  1H  +   2D   +   [  [  Z  XB  3B   +   0,<   Z  2B   +   "Zp  +   (Z  ,<   [  "XB  #,\   ,<   Z  D  k    ."   ,   XB  &+   /      '/"   4b  /,>  c,>   Z  ,<   ,<  k$  l>`x  5   +/  Z  j,~   ,<   Z  #2B   +   3Zp  +   EZ  0,<   [  3XB  4,\   B  lZ  2B   +   BZ  B  mZ  73B  m+   BZ   Z  2B  n+   BZ  82B   +   >Z  n,<   Z  :[  @  o,\   ,<    "   ,   B  o   )."   ,   XB  B+   0/   Z  62B   +   aZ  >Z  2B  n+   aZ  D0B  +   a[  GZ  Z  2B  n+   VZ   ,<   [  JZ  [  ,<   Z  N[  ,<    "  ,   @  o   o,\   B  oZ  <B  p,~   Z  M,<   Z  P[  0B   +   ZZ  p+   \0B   +   \Z  q+   \Z       ,\   ,   3B   +   a   oZ  TB  p,~   Z  V,<   Z  ID  l,~      e p
(#! Lb"d0 j8       (VARIABLE-VALUE-CELL A . 105)
(VARIABLE-VALUE-CELL TYPE . 191)
(VARIABLE-VALUE-CELL COERSIONS . 47)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 74)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 139)
(VARIABLE-VALUE-CELL 2FN . 42)
(VARIABLE-VALUE-CELL CODE . 174)
(VARIABLE-VALUE-CELL EXP . 194)
(0 VARIABLE-VALUE-CELL N . 196)
(NIL VARIABLE-VALUE-CELL TMP . 87)
EFFECT
COMP.PROGN
TYPE
UNBOXED
COMP.EXPR
2
COMP.STFN
COMP.VAL
COMP.DELFIX
PLUS
CONST
FIX
COMP.DELPUSH
COMP.STCONST
COMP.STFIX
((IDIFFERENCE LSH RSH LLSH LRSH) . 0)
((IQUOTIENT) . 0)
(FMEMB ASZ EVCC BHC MKN SKLST KNIL ENTERF)  ^    [  J    S (   ` /    H (    	    _ P G X 7   1    p  0          
COMP.FIX BINARY
               -.           Z   B     ,~       (VARIABLE-VALUE-CELL A . 3)
COMP.VAL1
COMP.STFIX
(ENTERF)    
COMP.STFIX BINARY
                -.          Z   2B   +   Z  XB  Z   Z  2B  +   Z  [  -,   +   Z  ,<   Z  [  ,<    "   ,   @  ,\   B  ,~   Z  2B  +   Z  	,<   Z   D  2B   +   Z  ,<   ,<  $  ,~    b    (VARIABLE-VALUE-CELL TYPE . 36)
(VARIABLE-VALUE-CELL CODE . 30)
(VARIABLE-VALUE-CELL NUMBERFNS . 32)
FIX
CONST
COMP.DELPUSH
COMP.STCONST
OPT.CALLP
1
COMP.STFN
(EVCC SKNM KNIL ENTERF)            0      
COMP.DELFIX BINARY
               -.          ,<   Z   ,<   Z   3B  +   2B   +   Z  +   	2B  +   Z  +   	Z  ,<   ,<  &  2B   +   Zp  +       +   o{& (VARIABLE-VALUE-CELL TYPE . 6)
(VARIABLE-VALUE-CELL CODE . 4)
FIX
((IPLUS FIX) . 0)
FLOAT
PLUS
1
OPT.CALLP
COMP.DELFN
(URET1 KNIL ENTERF)         X        
COMP.EQ BINARY
        /    %    --.           %Z   2B  '+   Z   B  (,~   @  (  ,~   Z  ,<   [  XB  ,\   B  )Z   2B   +   Z   Z  3B  )+   Z  B  *+   Z  
[  XB   2B   +      *Z  B  +,~      *Z  B  *Z  Z  2B  )+   Z   ,<   Z  ,<   Z  [  ,<    "  ,   @  *,\   B  +,~   Z  B  +Z  Z  2B  )+   "Z  [  -,   +   "Z  ,+   #Z  ,<   ,<  ,$  -,~   P	)@
&@    (VARIABLE-VALUE-CELL A . 38)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 3)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 18)
(VARIABLE-VALUE-CELL CODE . 63)
(VARIABLE-VALUE-CELL EXP . 69)
EFFECT
COMP.PROGN
(NIL VARIABLE-VALUE-CELL C . 57)
COMP.VAL
CONST
COMP.VAL1
COMP.DELPUSH
COMP.NOT
COMP.STCONST
EQ
2
COMP.STFN
(SKLA EVCC KNIL ENTERF)     0    
       
COMP.NUMBERTEST BINARY
     X    G    V-.           G,<  JZ   ,   ,<   Z   F  K,<   @  K  ,~   Z   B  MZ   B  M3B   +   
Z  +   Z   3B  N+   3B  N+   2B  O+   Z   ,<   Z  	D  M,~   2B  O+   .Z   XB   Z  Z  P,   2B   +   Z  2B  P+   #[  XB  Z  ,<   ,<  N    ."   ,   XB  ,   Z  Q,   XB   ,   D  MZ  B  Q,<  R[  Z  D  RZ  B  SZ  S,~      TZ  ,<   ,<  N   ."   ,   XB  %,   Z  Q,   XB  !,   D  M,<  R[  Z  D  RZ  (B  S   TZ  S,~   Z  XB  Z  Z  U,   2B   +   4Z  /2B  P+   =[  2XB  3Z  #,<   ,<  O   &."   ,   XB  6,   Z  Q,   XB  ,,   D  MZ  4B  QZ  9B  S,~      TZ  4,<   ,<  N   7."   ,   XB  ?,   Z  Q,   XB  <,   D  M   T   UZ  CB  S,~   (U?a- F.	0$t     (VARIABLE-VALUE-CELL X . 13)
(VARIABLE-VALUE-CELL FORM . 7)
(VARIABLE-VALUE-CELL FLG . 0)
(VARIABLE-VALUE-CELL DONOTHING . 4)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 85)
(VARIABLE-VALUE-CELL CODE . 93)
(VARIABLE-VALUE-CELL LBCNT . 130)
((*) . 0)
SUBPAIR
(VARIABLE-VALUE-CELL TEST . 124)
(NIL VARIABLE-VALUE-CELL EXIT . 139)
(NIL VARIABLE-VALUE-CELL A . 118)
COMP.EXPR
COMP.PREDP
FJUMP
TJUMP
NFJUMP
NTJUMP
((AVAR HVAR GVAR FVAR) . 0)
SETQ
TAG
COMP.STVAR
JUMP
COMP.STJUMP
COMP.STTAG
PREDVALUE
COMP.STCOPY
COMP.STPOP
((AVAR HVAR GVAR FVAR) . 0)
COMP.STCONST
(ALIST2 CONS21 MKN FMEMB KNIL CONSNL ENTERF)   H ;       C   ) P    8 p     1 H      8 	    B  ( @        
COMP.MAP BINARY
      {   L   t-.     0    8LZ   ,<   [  Z  ,<   [  [  Z  ,<   @ S `(,~   Z   B W3B   +   [  Z  XB  	Z   2B   +   Z  
-,   Z   Z  2B W+   +   +,< WZ   ,<   Z  ,<  Z  2B X+   ,<  ,< X$ Y3B   +   Z  B X1B   +   Z Y+   Z  3B   +   Z Z+   Z Z,   ,   XB  +   +Z  ,<   Z   ,<  ,   XB   ,< [Z [XB  ,   XB   ,< WZ  ,<  Z  2B X+   (Z \+   *2B   +   *Z \+   *Z ],   XB  Z   2B   +   .Z ]XB  ++   >B W3B   +   9[  -Z  XB  0-,   Z   Z  3B W+   >,< WZ  $,<   Z  1,<  ,< ^,   ,   XB  5+   >Z  8Z  !,   XB  9Z ^Z  #,   XB  ;Z _XB  9Z   2B   +   AZ _XB  >+   RB W3B   +   K[  @Z  XB  B-,   Z   Z  3B W+   R,< WZ  4,<   Z  C,<  ,< ^,   ,   XB  H+   R,< `Z  J,<   ,< `,   Z  :,   XB  NZ aZ  <,   XB  PZ aXB  LZ   3B   +   _Z   Z  O,   Z   ,   Z   ,   Z   ,   XB  TZ bXB   ,<   Z ^Z  Q,   Z b,   Z c,   ,   XB  [Z  ^B c,<   Z  XB c,<   ,< d& dXB   [  cZ  [  Z  ,<   Z   D e,<   Z   ,<   Z   ,<      ."   ,   XB  i,   Z e,   ,<      k."   ,   XB  m,   Z e,   ,<      o."   ,   XB  q,   Z e,   ,<   @ f@+  KZ  cB i,< j" jZ  "B k,< kZ   D lZ"   XB   Z  wXB   Z   B l  mZ  R3B   +  #3B   +  2B m+  ,< n,< ^Z   ,<  ,   B j,< n,< b[  +Z  Z  G2B  +  [ [  Z  +  Z 	,<   ,< ^,   ,   B jZ  2B m+  Z n+  Z oB j+  .2B o+  "Z ,<  Z ,<  ,   ,<   ,< p   s."   ,   XB ,   Z e,   XB   ,   D p  m,< n,< b,< qZ ,<   ,   ,   B j,< q" jZ B l+  .  r+  .Z   3B   +  +Z ,<  Z ,<  ,   ,<   Z #,<   Z   ,<  ,   D p+  .Z %,<  Z &,<  ,   B jZ  =,<   Z ,,<  ,   B pZ  zB lZ  R,<   Z /,<  ,   B p,< rZ  }D lZ (3B   +  I2B s+  =Z   2B   +  =,<   " kZ )B l,~   Z 9B k,< k  ."   ,   XB ?,   Z e,   XB !D lZ <B l  sZ =2B   +  G7   Z   B kZ BB l,~   Z  YB k,~   Z  |B t,~   <+OG^P"FhH"%X @ ]PexpDK~>r 9)AJ$             (VARIABLE-VALUE-CELL L . 8)
(VARIABLE-VALUE-CELL CARFLG . 75)
(VARIABLE-VALUE-CELL COLLECT . 284)
(VARIABLE-VALUE-CELL PRED . 366)
(VARIABLE-VALUE-CELL NEG . 394)
(VARIABLE-VALUE-CELL WHILEF . 357)
(VARIABLE-VALUE-CELL ALLVARS . 204)
(VARIABLE-VALUE-CELL SPECVARS . 207)
(VARIABLE-VALUE-CELL LOCALVARS . 209)
(VARIABLE-VALUE-CELL LBCNT . 385)
(VARIABLE-VALUE-CELL LEVEL . 248)
(VARIABLE-VALUE-CELL FRAME . 250)
(VARIABLE-VALUE-CELL DONOTHING . 359)
(VARIABLE-VALUE-CELL FROMFORM . 242)
(VARIABLE-VALUE-CELL DOF . 343)
(VARIABLE-VALUE-CELL BYF . 349)
(NIL VARIABLE-VALUE-CELL BOUNDVARS . 190)
(NIL VARIABLE-VALUE-CELL BINDVALS . 193)
(NIL VARIABLE-VALUE-CELL F . 406)
(NIL VARIABLE-VALUE-CELL VAL . 403)
(($X) VARIABLE-VALUE-CELL XARG . 271)
COMP.APPLYFNP
LAMBDA
BOTH
NARGS
COMP.CLEANFNP
(((CAR $X) $X) . 0)
(((CAR $X)) . 0)
(($X) . 0)
$F1
$L
((APPLY* $F1 (CAR $X) $X) . 0)
((APPLY* $F1 $X) . 0)
((APPLY* $F1 (CAR $X)) . 0)
CDR
$X
$F2
((LAMBDA ($X) (COND ((NULL $F2) (CDR $X)) (T (APPLY* $F2 $X)))) . 0)
LISTP
OR
((QUOTE LISTP) . 0)
$F3
((LAMBDA ($X) (APPLY* $F3 $X)) . 0)
$V
$W
$Z
OPT.DREV
MAP
COMP.BIND.VARS
APPEND
TAG
(VARIABLE-VALUE-CELL ALLVARS . 0)
(VARIABLE-VALUE-CELL SPECVARS . 0)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(VARIABLE-VALUE-CELL LP . 364)
(VARIABLE-VALUE-CELL ENDLP . 355)
(VARIABLE-VALUE-CELL OUT . 391)
(NIL VARIABLE-VALUE-CELL NXT . 400)
COMP.STBIND
((DECLARE (LOCALVARS $F1 $F2 $X $V $Z $W $F3)) . 0)
COMP.EFFECT
COMP.VAL
JUMP
COMP.STJUMP
COMP.STTAG
COMP.STCOPY
J
SETQ
((.DOJOIN. $V $Z $W) . 0)
((.DOCOLLECT. $V $Z $W) . 0)
S
FJUMP
COMP.EXPR
CAR
((.DOCOLLECT. $V $Z $W) . 0)
SHOULDNT
NTJUMP
TJUMP
COMP.STPOP
COMP.UNBIND.VARS
(KT CONSNL MKN CONS21 LIST3 CONS ALIST2 LIST2 ALIST3 CONSS1 ASZ SKLST KNIL ENTERF)   x   B  t  l   A  s x k   C ( u  m h ]  X 
p   X N    \ 
` Q 	x = 0   8 $   5 . 0( x X J   !     ` K  + `   p     |    P 2 `    F @; %  X 
x V 
P T X B x 3   -   h  H 	       
COMP.MLLIST BINARY
    ;    )    9-.          )Z   ,<   @  +  ,~   Z   ,<   ,<  -,<  -,<   @  . ` +   "Z   Z  /XB ,<  0,<  0"  0,   ,   Z  ,   XB  ,<  1,<  1"  1,   ,   Z  ,   XB  Z   B  2[   [  [  Z  ,<   ,<   ,<  2,<  3,<  3Z  4L  4,<  5"  5Z  Z  67   [  Z  Z  1H  +   2D   +   [  B  6[  [  Z  B  7XB   Z   ,~   3B   +   $Z   +   %Z  7XB   D  8Z  %3B   +   (   8,~   Z  !,~   +A`@ T!i@        (VARIABLE-VALUE-CELL FN . 35)
(VARIABLE-VALUE-CELL CC . 62)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 81)
(NIL VARIABLE-VALUE-CELL RESETZ . 76)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
RADIX
10
LINELENGTH
72
PRIN2
"("
")"
" "
COMP.MLLVAR
MAPRINT
5
SPACES
(((0 . LAMBDA) (2 . LAMBDA*) (1 . NLAMBDA) (2 . NLAMBDA*) (NIL . ???)) . 0)
PRINT
COMP.MLL
ERROR
RESETRESTORE
ERROR!
(KT CONS CONSNL ALIST2 CF KNIL ENTERF) (         H         	    ' H # `   p      
COMP.MLL BINARY
     n    [    k-.           [Z   ,<   Zp  -,   +   +   YZp  ,<   @  [   +   WZ   -,   Z   Z  2B  \+      \1B   +      ][  Z  B  ],<  ^"  ^,~   Z  ,<   ,<  _$  _@  \,<   @  ` @ ,~       0"  +          ^"  /  ,   B  a+      1b  +      ],<  a"  a+   ,<  b"  aZ   3B   +   Z  B  ^[  [  2B  b+   #[  B  ]+   S2B  c+   %Z  !B  c+   S2B  d+   (Z  $B  d+   S2B  e+   *[  &B  c+   S2B  e+   .[  )Z  [  Z  B  ]+   S2B  f+   L[  +[  ,<   @  f  +   L[   [  [  Z  [  Z  XB   XB   [  2Z  [  Z  ,<   Zp  -,   +   ;+   HZp  ,<   @  h   +   GZ  6Z  52B  +   @Z  h+   C0B   +   BZ  i+   CZ  iB  ^   =/"   ,   XB  CZ   B  c,~   [p  XBp  +   9/   Z  E0B   +   K,<  j"  ^,~   +   S2B  j+   O[  /Z  B  ^+   SZ  MB  ^[  O3B   +   S[  P,   B  ^[  Z  3B   +   W[  SZ  B  ^,~   [p  XBp  +   /      ]   ],~   e3GB?J7=wCb@ 2G>G9R""@    (VARIABLE-VALUE-CELL LL . 3)
(VARIABLE-VALUE-CELL X . 164)
TAG
POSITION
TERPRI
PRIN2
:
PRIN1
MLSYM
GETP
(VARIABLE-VALUE-CELL S . 171)
(VARIABLE-VALUE-CELL P . 49)
SPACES
6
1
CONST
VAR
COMP.MLLVAR
FN
COMP.MLLFN
VREF
JUMP
BIND
(VARIABLE-VALUE-CELL F . 109)
(NIL VARIABLE-VALUE-CELL NN . 124)
(NIL VARIABLE-VALUE-CELL N . 146)
(VARIABLE-VALUE-CELL V . 139)
""
;
,
";"
UNBIND
(CONSNL BHC MKN ASZ KNIL SKLST SKNLST ENTERF)  
8     I    E     	( A 8   
X R h 	        :  @      
COMP.MLLVAR BINARY
           	    -.           	[   XB   Z  2B  
+   ,<  "  Z  +   2B  +   Z  +   Z  B  ,~   wh  (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL N . 16)
HVAR
"@"
PRIN1
XVAR
PRIN2
(ENTERF)      
COMP.MLLFN BINARY
                -.           [   [  XB   B  [  Z  XB  Z  -,   +   B  0B   +   Z  B  Z  3B  7   7   +   ,<  "  Z  	B  ,~   Z   ,~   (:      (VARIABLE-VALUE-CELL X . 25)
(VARIABLE-VALUE-CELL FN . 16)
PRIN2
ARGTYPE
NARGS
1
SPACES
(KNIL KT ASZ SKLA ENTERF) p                    
OPT.RESOLVEJUMPS BINARY
    9    1    7-.           1@  3  ,~   Z   ,<   Zp  -,   +   +   %Zp  ,<   @  4   +   $[   Z  ,<   [  Z  Z  D  5Z  
3B   +   !Z  Z  Z  ,<   Z   D  5Z  XB   [  [  ,<   Z  D  5    ,>  1,>   [  [  ,<   [  ,   ,>  1,>   Z  ,       ,^   /   /  ,   D  6Z  ,   .Bx  ,^   /   ,   XB  ,~   [  [  ,<   Z   D  6,~   [p  XBp  +   /   ,<   Z  ,<   Z  D  6XB   -,   +   +Zp  +   ,XB  &+   &/   Z  (3B   +   0Z  +,<  Z   D  7Z   ,~      P
 @%"      (VARIABLE-VALUE-CELL JL . 92)
(VARIABLE-VALUE-CELL PROP . 79)
(VARIABLE-VALUE-CELL FN . 94)
(0 VARIABLE-VALUE-CELL CU . 69)
(NIL VARIABLE-VALUE-CELL Z . 50)
(NIL VARIABLE-VALUE-CELL NEW . 89)
(VARIABLE-VALUE-CELL X . 66)
RPLACD
GETPROP
RPLACA
OPT.JLENPASS
OPT.JFIXPASS
(MKN BHC IUNBOX KNIL SKNLST ENTERF)     P   P &        (     1 ` ' X            
OPT.JLENPASS BINARY
           x   -.          x@  y  X,~   Z   ,<   Zp  -,   +   +   rZp  ,<   @     +   pZ   Z  XB   [  Z  ,<   [  
Z  Z  ,   ,>  w,>       .Bx  ,^   /   ,   D  Z  	2B   +       ,>  w,>   [  [  Z  ,       ,^   /   /  ,   XB   [  [  ,<   Z  D  ,~   [  [  Z  XB   1B   +   p[  Z  Z   ,   XB   [  !Z  Z  ,   ,>  w,>   [  Z  Z  ,       ,^   /   /  ,   XB   Z  ,<  [  "[  Z  ,   ,>  w,>          ,^   /   /  ,>  w,>   [  +Z  [  ,   ,>  w,>   [  %Z  [  ,       ,^   /   3b  +   A   ),>  w,>      .Bx  ,^   /   ,   XB  9,   ,>  w,>      .Bx  ,^   /   +   B   =.Bx  ,^   /   ,   ,<   Z   F  XB   Z  *,<  Z  A,<  Z  DF  XB   ,<   [  4[  [  XB   ,\  3B  +   X[  J[  ,<   Z  ID     :,>  w,>      O,>  w,>      K    ,^   /   /  .Bx  ,^   /   ,   XB  P   E,>  w,>      Q    ,^   /   /  ,   XB   Z  3B  +   k   \0"   +   a,< "    ?,>  w,>      ^,>  w,>      ]    ,^   /   /  .Bx  ,^   /   ,   XB  a[  M[  ,<   Z  bD     .,>  w,>      j.Bx  ,^   /   ,   XB  k,~   [p  XBp  +   /   Z  h1B   +   vZ  o1B   +   vZ  ,~   Z   ,~      P(  @ @  )  '$ @$       (VARIABLE-VALUE-CELL JL . 235)
(VARIABLE-VALUE-CELL PROP . 144)
(VARIABLE-VALUE-CELL LBA . 65)
(0 VARIABLE-VALUE-CELL INC . 175)
(0 VARIABLE-VALUE-CELL DEC . 229)
(0 VARIABLE-VALUE-CELL CU . 232)
(NIL VARIABLE-VALUE-CELL X . 140)
(NIL VARIABLE-VALUE-CELL U . 200)
(NIL VARIABLE-VALUE-CELL U1 . 218)
(NIL VARIABLE-VALUE-CELL DEF . 99)
(NIL VARIABLE-VALUE-CELL MIN . 142)
(NIL VARIABLE-VALUE-CELL ML . 166)
(NIL VARIABLE-VALUE-CELL SMIN . 179)
(NIL VARIABLE-VALUE-CELL SMAX . 176)
(VARIABLE-VALUE-CELL J . 210)
RPLACA
OPT.JSIZE
RPLACD
((U1 negative) . 0)
OPT.COMPILERERROR
(KT GETHSH ASZ KNIL MKN BHC IUNBOX SKNLST ENTERF) x       X t x   0     i P X H =       0 o  f @ W 
X D  =  0      h 7 @ - x $ p            
OPT.JFIXPASS BINARY
        #        "-.          @     ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @  !   +   Z   Z  XB   2B   +   [  [  ,<   ,<  !$  ",~   Z   ,<  Z  ,<   [  	Z  Z   ,   [  Z  Z  ,   ,>  ,>   [  Z  Z  ,       ,^   /   /  ,   ,<    "  ,   ,~   [p  XBp  +   /   Z   ,~      PF   @ (VARIABLE-VALUE-CELL JL . 6)
(VARIABLE-VALUE-CELL FN . 28)
(VARIABLE-VALUE-CELL LBA . 34)
(NIL VARIABLE-VALUE-CELL X . 32)
(VARIABLE-VALUE-CELL J . 42)
0
RPLACA
(EVCC MKN BHC IUNBOX GETHSH KNIL SKNLST ENTERF) 8       `      H   (   h            
OPT.JSIZE BINARY
              -.           Z   ,<   Z   D  [  ,<   @     ,~   Z   -,   +   Z  ,~       ,>  ,>   Z  ,       ,^   /   2"  +   [  
Z  +   [  [  XB  +      D"     (VARIABLE-VALUE-CELL OP . 3)
(VARIABLE-VALUE-CELL D . 17)
(VARIABLE-VALUE-CELL FN . 5)
GETPROP
(VARIABLE-VALUE-CELL Z . 32)
(BHC IUNBOX SKNLST ENTERF) P   8    x      
OPT.CALLP BINARY
            -.           Z   2B  +   Z   3B   +   [  Z  Z  2B  +   Z   2B   +   	Z   ,~   [  [  Z  3B  7   7   +   Z  
-,   +   [  	[  Z  ,   ,~   Z   ,~   Z   ,~   !@     (VARIABLE-VALUE-CELL OP . 29)
(VARIABLE-VALUE-CELL FN . 31)
(VARIABLE-VALUE-CELL N . 11)
FN
(FMEMB SKLST KT KNIL ENTERF)     h   H 	                
OPT.JUMPCHECK BINARY
               -.           Z   Z  3B  +   2B  +   Z   ,~   Z   ,~   `   (VARIABLE-VALUE-CELL C . 3)
JUMP
RETURN
(KNIL KT ENTERF)   h    X      
OPT.DREV BINARY
         	    -.           	@  
  ,~   Z   XB   -,   +   Z   ,~   [  XB  Z  Z  QD  XB  +     (VARIABLE-VALUE-CELL L . 13)
(VARIABLE-VALUE-CELL Z . 17)
(NIL VARIABLE-VALUE-CELL Y . 14)
(SKNLST ENTERF)   P      
OPT.CHLEV BINARY
        	    
-.          	Z   3B   +      ,>  	,>       .Bx  ,^   /   ,   XB  ,<   ,\   ,~      @   (VARIABLE-VALUE-CELL N . 9)
(VARIABLE-VALUE-CELL LEVEL . 14)
(MKN BHC KNIL ENTERF)   x    p    0      
OPT.CHECKTAG BINARY
              -.          Z   2B   +   [   ,<   ,<   $  [  ,~   [  [  2B   +   Z   3B   +   Z   XB  ,~   Z   ,~   Z   ,~   $  (VARIABLE-VALUE-CELL TAG . 12)
(VARIABLE-VALUE-CELL TAGFLAG . 16)
(VARIABLE-VALUE-CELL LEVEL . 20)
RPLACD
(KT KNIL ENTERF)        ( 	     0      
OPT.NOTJUMP BINARY
           	    
-.           	Z   2B  	+   Z  
+   2B  
+   Z  	+   Z   ,~   ,<   [  ,   ,~   |   (VARIABLE-VALUE-CELL X . 15)
FJUMP
TJUMP
(CONSS1 KNIL ENTERF)      p      
OPT.INITHASH BINARY
              -.           Z   Z 7@  7   Z  B  2B   +   Z  Z 7@  7   Z  -,   Z   Z  B  3B   +   Z  Z 7@  7   Z  B  ,~   Z  ,<   ,<  "      ,\   ,   ,~   (A     (VARIABLE-VALUE-CELL X . 29)
HARRAYP
CLRHASH
100
HASHARRAY
(SET SKLST KNIL KNOB ENTERF)      	                    
OPT.COMPINIT BINARY
                -.           ,<  Zp  -,   +   +   Zp  ,<   @     +   
Z   ,<   [  ,       ,\   ,   ,~   [p  XBp  +   /   Z  ,   XB   ,~   J  (VARIABLE-VALUE-CELL DONOTHING . 27)
(((OPRETURN . RETURN) (OPPOP . POP) (OPCOPY . COPY) (OPNIL . CONST)) . 0)
(VARIABLE-VALUE-CELL X . 15)
AC
(BHC SET CONSNL SKNLST ENTER0)      
         8      
OPT.CFRPTQ BINARY
        *        )-.          Z   2B  +       ."   ,   XB  ,   Z   ,   ,<      ."   ,   XB  ,   Z   ,   ,<   @    @ +   Z   B  !Z   B  "   ",<  #"  !,<  #,<  $$  $,<  %Z   D  %[  ,<   ,<  $  &,<  &"  !,<  ',<  $$  $,<  'Z  D  %Z  B  "Z   ,~   ,~   Z  (Z  ,   B  (,~   *'}"       (VARIABLE-VALUE-CELL L . 56)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 3)
(VARIABLE-VALUE-CELL LBCNT . 17)
EFFECT
TAG
(VARIABLE-VALUE-CELL END . 50)
(VARIABLE-VALUE-CELL ST . 48)
COMP.VAL
COMP.STTAG
COMP.STCOPY
0
IGREATERP
2
COMP.STFN
FJUMP
COMP.STJUMP
COMP.VALN
1
IDIFFERENCE
JUMP
RPTQ
COMP.EXP1
(CONS KNIL CONS21 CONSNL MKN ENTERF)            p         	  P      
COMP.AREF BINARY
    $        #-.          @    ,~   Z   -,   +   [   [  Z  -,   3B   7    ,   B  ,<   [  B  ,\  2B  +   Z  Z  	,   ,<   Z   D   ,~   Z  ,<   Zp  -,   +   +   Zp  B   [p  XBp  +   /   Z  B  0B  +   Z  !+   0B  +   Z  !+   Z  ",<   Z  B  D  "Z   ,~    0A$]s  (VARIABLE-VALUE-CELL A . 54)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 27)
(NIL VARIABLE-VALUE-CELL DECL . 9)
LENGTH
\16AREF
COMP.EXPR
COMP.VAL
\ASET.1
\ASET.2
ASET
COMP.STFN
(ASZ BHC SKNLST CONS CONSNL KNIL SKLST SKLA ENTERF)                         x    p    H      
COMP.ASET BINARY
    ;    0    9-.          0@  1  ,~   [   Z  -,   +   ![  Z  B  2Z   7   [  Z  Z  1H  +   2D   +   [  XB   Z  2B  2+   ![  [  Z  -,   3B   7    ,   B  3,<   [  [  B  3,\  [  Z  Z  3,   3B   +   Z  4Z  ,   ,<   Z   D  4,~   [  Z  Z  5,   3B   +   !Z  5Z  ,   ,<   Z  D  4,~      6Z  ,<   Zp  -,   +   $+   'Zp  B  6[p  XBp  +   "/   Z  !B  30B  +   *Z  7+   -0B  +   ,Z  7+   -Z  8,<   Z  'B  3D  8Z   ,~   F"0PR.y@      (VARIABLE-VALUE-CELL A . 91)
(VARIABLE-VALUE-CELL ALLDECLS . 13)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 63)
(NIL VARIABLE-VALUE-CELL DECL . 53)
COMP.LOOKUPVAR
ARRAY
LENGTH
((BYTE 16) . 0)
\16ASET
COMP.EXPR
((FLOATP FLONUM) . 0)
\LASET
HELP
COMP.VAL
\ASET.1
\ASET.2
ASET
COMP.STFN
(ASZ BHC SKNLST FMEMB CONS EQUAL CONSNL SKLST KNIL SKLA ENTERF)   +        @   P   x                 0 X              
COMP.BOX BINARY
               -.          Z   -,   +   ,<   ,<  $  +   Z   ,<   @     ,~   Z   3B   +   Z   ,<   [  ,<   ,<  &  3B   +      Z  B  +   Z  
,<   ,<  $  Z   ,~   r6f     (VARIABLE-VALUE-CELL TYPE . 27)
(VARIABLE-VALUE-CELL CODE . 18)
BOX
GETPROP
(VARIABLE-VALUE-CELL BOXER . 30)
1
OPT.CALLP
COMP.DELFN
COMP.STFIX
COMP.STFN
(KNIL SKLA ENTERF)    P 	  `    0      
COMP.LOOKFORDECLARE BINARY
    ,    %    *-.          %,<   Z   -,   Z   Z  Z   3B  +   Zp  +   	Z  ,<   [  XB  ,\   +   /   Z  -,   Z   Z  2B  &7   7   +   %Z  
[  ,<   @  '  ,~   Z`  -,   +   +   $Z  XB   Z  2B  )+   "[  [  ,<   Zp  -,   +   +   "Zp  ,<   @  )   +    Z   ,<   [  Z  B  *,   Z   ,   XB  ,~   [p  XBp  +   /   [`  XB`  +   Z  ,~   ,~   
	c     (VARIABLE-VALUE-CELL EXPS . 28)
(VARIABLE-VALUE-CELL COMMENTFLG . 8)
DECLARE
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL Y . 57)
(NIL VARIABLE-VALUE-CELL DECLS . 72)
TYPE
(VARIABLE-VALUE-CELL Z . 55)
COMP.DECLARETYPE
(CONS CONSS1 SKNLST KT BHC SKLST KNIL ENTERF)     p            # (   8      @   (      
COMP.DECLARETYPE BINARY
               -.           Z   3B  +   3B  +   2B  +   Z  ,~   -,   +   Z   ,~   Z  2B  +   
Z  ,~   Z   ,~   y  (VARIABLE-VALUE-CELL X . 19)
FLOATING
FLOATP
FLOAT
((UNBOXED . FLOAT) . 0)
ARRAY
(KNIL SKNLST ENTERF)        p      
COMP.FLOATBOX BINARY
             -.           Z   ,<   ,<  ,<  	&  	3B   +      
,~   ,<  
,<  	$  ,~   [@  (VARIABLE-VALUE-CELL CODE . 3)
\FLOATUNBOX
1
OPT.CALLP
COMP.DELFN
\FLOATBOX
COMP.STFN
(KNIL ENTER0)          
COMP.FLOATUNBOX BINARY
         	    -.           	,<  	"  
Z   ,<   ,<  
,<  &  3B   +      ,~   ,<  ,<  $  ,~   vp  (VARIABLE-VALUE-CELL CODE . 5)
FLOAT
COMP.DELFIX
\FLOATBOX
1
OPT.CALLP
COMP.DELFN
\FLOATUNBOX
COMP.STFN
(KNIL ENTER0)          
COMP.PREDP BINARY
             -.           Z   -,   +   Z  Z  ,   ,~   Z   ,~   @   (VARIABLE-VALUE-CELL CTX . 6)
((TJUMP FJUMP NTJUMP NFJUMP) . 0)
(KNIL FMEMB SKLST ENTERF)                  
COMP.UBFLOAT2 BINARY
       #        "-.          @    ,~   Z   2B  +   Z   2B   +   Z   B  ,~   ,<   Z  2B   +   
Zp  +   Z  ,<   [  
XB  ,\   B         ."   ,   XB  +   /      /"   4b  ,>  ,>   ,<  ,<   Z   ,<   ,   ,<   ,<   $  !>`x  5   /     !Z   ,~      el@  (VARIABLE-VALUE-CELL A . 24)
(VARIABLE-VALUE-CELL OP . 41)
(VARIABLE-VALUE-CELL COMPILE.CONTEXT . 6)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 9)
(0 VARIABLE-VALUE-CELL N . 34)
EFFECT
COMP.PROGN
COMP.VAL
COMP.FLOATUNBOX
OPCODES
UBFLOAT2
1
COMP.STFN
COMP.FLOATBOX
(LIST3 BHC MKN KNIL ENTERF)              ( 	         
COMP.UNBOX BINARY
             -.          Z   -,   +   ,<   ,<  $  +   Z   ,<   @     ,~   Z   3B   +   Z   ,<   Z  ,<   ,<  &  3B   +      +   Z  B  [  
,<   ,<  $  Z   ,~   r7&     (VARIABLE-VALUE-CELL TYPE . 28)
(VARIABLE-VALUE-CELL CODE . 18)
BOX
GETPROP
(VARIABLE-VALUE-CELL BOXER . 30)
1
OPT.CALLP
COMP.DELFN
COMP.DELFIX
COMP.STFN
(KNIL SKLA ENTERF)   P 	  `    0      
OPT.POSTOPT BINARY
       W    G    T-.         ( GZ   3B   +   (@  J  +   'Z   2B   +   +   &Z   XB   ,<   Z  ,<   [  XB  	,\   XB   Z  3B  L+   Zp  +   Z  
Z  ,   XB  +   /   ,<   Z  2B  L+   [  Z  ,   2B   +   Zp  +   Z  	,<   [  XB  ,\   XB  +   /   Z  ,<   Zp  -,   +   +   #Zp  ,<   @  M   +   "Z   Z   ,   XB   ,~   [p  XBp  +   /   Z  Z  !,   XB  $+   [  %,~   ,~   Z   ,<  Z  (,   ,   ,<   @  M @ ,~   Z  ,<   Z   ,   D  PZ   ,   XB  ,   QZ   XB   Z   0B   7   Z   B  Q3B   +   6Z   XB  1   R   R   SZ  62B   +   EZ   3B   +   >   S,<   ,<   ,<   &  Q2B   +   EZ   3B   +   C,<   ,<   Z  9F  Q2B   +   E[  0B  T[  ,~      2."   ,   XB  E+   1& B@AJ @D9R     (VARIABLE-VALUE-CELL CODE . 134)
(VARIABLE-VALUE-CELL OPTIMIZATIONSOFF . 3)
(VARIABLE-VALUE-CELL TAGS . 52)
(VARIABLE-VALUE-CELL TOPFRAME . 82)
(VARIABLE-VALUE-CELL XVARFLG . 130)
(VARIABLE-VALUE-CELL MERGEFRAMEFLG . 125)
NIL
(NIL VARIABLE-VALUE-CELL C . 72)
(NIL VARIABLE-VALUE-CELL VAL . 77)
TAG
JUMP
(VARIABLE-VALUE-CELL TAG . 63)
(VARIABLE-VALUE-CELL FRAME . 0)
(VARIABLE-VALUE-CELL FRAMES . 0)
(NIL VARIABLE-VALUE-CELL LABELS . 0)
(NIL VARIABLE-VALUE-CELL ANY . 112)
(1 VARIABLE-VALUE-CELL PASS . 141)
(NIL VARIABLE-VALUE-CELL DELETEDBINDS . 0)
NCONC
OPT.SETUPOPT
OPT.FRAMEOPT
OPT.SCANOPT
OPT.JUMPOPT
OPT.RETOPT
OPT.XVARSCAN
OPT.DREV
(MKN KT ASZ CONS21 CONSNL SKNLST FMEMB BHC CONS KNIL ENTERF) p    A X < h 4    3    0    / 0 *            $ (     &      C   > P ;  5 @ 2   . P     `        
OPT.SETUPOPT BINARY
        d    W    a-.            WZ   ,<   @  Y  ,~   Z   2B   +   Z   ,~   Z  Z  2B  Z+   Z  Z   7   [  Z  Z  1H  +   2D   +   
XB   3B   +   [  Z  XD  +   +Z  ,<   Z  ,<   ,   Z  	,   XB  +   +3B  [+   3B  [+   3B  \+   3B  \+   3B  ]+   2B  ]+   +Z  [  Z  Z  7   [  Z  Z  1H  +   !2D   +   XB  3B   +   %,<   Z  ,   D  ^+   +Z  #[  Z  ,<   ,<   Z  %,<   ,   Z  ,   XB  )Z  (Z  3B  ]+   .2B  ^+   =Z  +[  [  Z   7   [  Z  Z  1H  +   42D   +   0XB  !3B   +   8[  4,<   Z  .D  _+   OZ  6[  [  ,<   Z  8,<   ,   Z  /,   XB  ;+   O3B  _+   ?2B  `+   OZ  :[  [  Z  <7   [  Z  Z  1H  +   E2D   +   BXB  53B   +   I,<   Z  ?,   D  ^+   OZ  G[  [  ,<   ,<   Z  I,<   ,   Z  A,   XB  M[  LXB  EZ  O,<  D  `Z  P,<   Z   ,<  Z   F  aZ  QXB  RZ  OXB  T+   0
"| R0  ) | R0       (VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL LABELS . 85)
(VARIABLE-VALUE-CELL FRAMES . 157)
(VARIABLE-VALUE-CELL PRA . 167)
(VARIABLE-VALUE-CELL C . 172)
(NIL VARIABLE-VALUE-CELL P . 170)
(NIL VARIABLE-VALUE-CELL B . 171)
TAG
JUMP
TJUMP
FJUMP
NTJUMP
NFJUMP
ERRORSET
NCONC
BIND
RPLACA
UNBIND
DUNBIND
RPLACD
PUTHASH
(LIST3 CONSNL CONS LIST2 KNIL ENTER0) 	` *    I P   	p = 0     < @   	H G X 5 @ ( 0 ! p   h        
OPT.SCANOPT BINARY
   ~   `   w-.          ``Z   ,<   @ f  (,~   [   XB   Z   3B   +   Z  XB   Z  2B i+   AZ  ,<   ,<   ,< i& j3B   +   Z  	[  [  XB   Z   ,   2B   +   Z  Z   ,   2B   +   Z  Z   ,   3B   +   Z  ,<   Z  ,<  [  ,<    "   ,   Z i,   D jZ  B k+  #[  Z   7   [  Z  Z  1H  +   !2D   +   XB  3B   +  '[  !,<   Zp  -,   +   &Z   +   2Zp  ,<   ,<w/   @ k   +   .Z  ,<   [  XB  #Z  ,<   Z  +F j,~   3B   +   0Zp  +   2[p  XBp  +   $/   3B   +  'Z  B kZ  *B k[  +,<   Zp  -,   +   8+   @Zp  ,<   @ k   +   ?Z  -[  ;,   ,<   Z  D lXB  =,~   [p  XBp  +   6/   +  #2B l+   C+  '3B m+  '3B m+  '2B n+   F+  '2B n+   L[  5,<   Z  4D o3B   +  Z  3B k+  #2B o+   sZ  >Z  3B m+   T3B l+   T3B n+   T3B m+   T3B p+   T2B i+   WZ  MB kZ  JB kZ  HXB  T+  #2B p+   kZ  V[  [  ,<   ,< q$ q3B   +  Z  X[  Z  ,<   Z  \B kZ  UB k[  VXB  ^,\   ,<   ,<    w1b   +   jZ   ,<   Z  aD lXB  eXBp   w/"   ,   XBw+   cZp  /  +  #2B n+  [  fZ  Z r,   3B   +  [  lB kZ  _B kZ  `XB  o+  #2B r+   ~Z   3B   +  Z  rZ  d2B  +  Z  uB kZ  p[  ,<   Z  x[  Z  ,   ."   ,   D j+  &2B s+  Z  wZ  2B i+  Z  G,<   ,< r$ j[ ,<   [ Z  ,   /"   ,   D j3B   +  +  2B p+  Z  [  Z  0B   +  Z 	[  [  ,<   ,< s$ q3B   +  Z  z,<   Z D jZ ,<   Z D jZ ,<   [ [  Z   7   [  Z  Z  1H  +  2D   +  [  [  D t,<   Z D j+  #Z 2B   +   Z   ,~   Z XB  qZ XB  +   Z !XB "Z #Z   ,   XB !Z   XB   +   Z   3B   +  1Z #Z  2B o+  1[ ),<   Z $D t3B   +  1Z ,B kZ +B k[ %XB .+  &Z '3B   +  QZ 0,<  Z /D uXB  ;3B   +  DZ 0,<  D uXB 5Z 3Z $,   XB 6Z 8,<   [ 8,\  2B  +  ?Z ;B k+  @Z =Z vXD  Z   ,<   Z :D l[ :XB ?+  &Z 4,<  ,< iZ C,<  ,<   ( vXB A3B   +  Z E,<  D uXB G3B   +  Z B,<  D uXB JZ @,<  D lZ IZ wXD  +  &Z D,<  Z OD t3B   +  VZ RZ NXD  +  Z QZ  v2B  +  [ V,<   Z TD t3B   +  Z YB kZ X,<   [ \XB [,\   B k+  &h! + R)P!?su4
	I)d(f0a@ 	U$@PI$E"DE `       (VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL CONSTFNS . 29)
(VARIABLE-VALUE-CELL VCONDITIONALS . 34)
(VARIABLE-VALUE-CELL CONDITIONALS . 39)
(VARIABLE-VALUE-CELL CONST.FNS . 58)
(VARIABLE-VALUE-CELL OPPOP . 430)
(VARIABLE-VALUE-CELL COMPILE.DUNBIND.POP.MERGE.FLG . 232)
(VARIABLE-VALUE-CELL FRAMES . 300)
(VARIABLE-VALUE-CELL PRA . 370)
(VARIABLE-VALUE-CELL ANY . 333)
(VARIABLE-VALUE-CELL NEWOPTFLG . 355)
(VARIABLE-VALUE-CELL OPCOPY . 426)
(VARIABLE-VALUE-CELL CD . 444)
(NIL VARIABLE-VALUE-CELL A . 298)
(NIL VARIABLE-VALUE-CELL B . 443)
(NIL VARIABLE-VALUE-CELL P . 408)
(NIL VARIABLE-VALUE-CELL X . 411)
(NIL VARIABLE-VALUE-CELL Y . 0)
CONST
1
OPT.CALLP
RPLACA
OPT.PRDEL
(VARIABLE-VALUE-CELL X . 0)
OPT.PRATTACH
HVAR
AVAR
GVAR
FVAR
SETQ
OPT.DEADSETQP
POP
COPY
FN
NOSIDE
COMP.CLEANFNOP
((COPY) . 0)
DUNBIND
UNBIND
FREEVARS
MEMB
OPT.EQVALUE
OPT.JUMPCOPYTEST
OPT.DELCOPYFN
((SWAP) . 0)
OPT.SKIPPUSH
((SWAP) . 0)
(KT GETHSH ASZ IUNBOX EQUAL MKN CONS BHC SKNLST CONS21 EVCC FMEMB KNIL ENTER0)  G p   (&       H   p   p }    P   8 A 0 )    8 X   0       P      8T @I h3 `)  (   u x c H J 8 / h #   0  H   h      
OPT.XVARSCAN BINARY
      ;    2    9-.           2Z   ,<   @  3  ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @  4   +   Z   [  [  [  Z  [  [  ,<   Z  	[  Z  [  Z      Z  57   [  Z  Z  1H  +   2D   +   3B   +   7   Z   D  5,~   [p  XBp  +   /   Z   XB   Z  2B  6+   Z  ,<   Z  D  6+   /2B  7+   %[  XB   Z   2B  6+   /Z  !,<   Z  D  6+   /3B  7+   '2B  8+   /Z  #,<   ,<  8$  92B   +   /[  "[  [  [  [  Z  [  [  ,<   ,<   $  5[  'XB  /2B   +   Z   ,~    
HC~4 "      (VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL FRAMES . 8)
(VARIABLE-VALUE-CELL CD . 96)
(NIL VARIABLE-VALUE-CELL A . 84)
(VARIABLE-VALUE-CELL X . 27)
AVAR
RPLACD
HVAR
OPT.XVARSCAN1
SETQ
UNBIND
DUNBIND
0
OPT.CODELEV
(BHC KT KNIL SKNLST ENTER0)      / p   ( 1    `            
OPT.XVARSCAN1 BINARY
       !         -.          Z   B  ,<   @     ,~   Z   2B   +      Z   ,<   [  Z  [  Z      ,\   ,   3B   +   Z   ,~   Z  Z   ,   XB  Z  ,<   [  Z  [  Z      ,\   ,   3B   +   [  [  [  Z  [  [  ,<   ,<   $   +   Z  Z   2B  +      +     G  (VARIABLE-VALUE-CELL A . 30)
(VARIABLE-VALUE-CELL CD . 3)
(VARIABLE-VALUE-CELL FRA . 27)
(VARIABLE-VALUE-CELL TOPFRAME . 52)
OPT.CODEFRAME
(VARIABLE-VALUE-CELL FR . 51)
OPT.COMPILERERROR
RPLACD
(KT GETHSH FMEMB KNIL ENTERF)            8   H  @        
OPT.JUMPOPT BINARY
            -.           Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   [   Z  3B   +   Z  ,<   [  	D  2B   +   Z  
,<   [  D  3B   +   Z   XB   ,~   [p  XBp  +   BD(P@    (VARIABLE-VALUE-CELL LABELS . 3)
(VARIABLE-VALUE-CELL ANY . 32)
(VARIABLE-VALUE-CELL X . 27)
OPT.JUMPTHRU
OPT.JUMPREV
(KT URET1 KNIL SKNLST ENTER0)           H 	  P    @      
OPT.JUMPTHRU BINARY
     d   9   ^-.         H9Z   ,<   Z  ,<   Z   Z   ,   ,<   [  [  ,<   @ > X,~   ,<   [   Z  XB   -,   Z   Z  3B F+   Z  	Z   ,   XB   Z  XB  
-,   Z   Z  3B F+   Zp  +   Z  ,<   Z  D F+   	/   [   2B   +   Z  B G,~   Z  Z   2B  +   Z GXB   +   2Z  2B H+   Z H+   12B I+   !Z I+   12B J+   #Z J+   12B K+   %Z K+   12B L+   'Z L+   12B M+   )Z M+   12B N+   +Z N+   13B O+   /3B O+   /3B P+   /2B P+   0Z Q+   1Z   ,~   XB  [  Z  XB   Z  Z  Z  17   [  Z  Z  1H  +   92D   +   5XB   2B   +   ;+  2Z  3Z  2B  +   ?Z   Z Q,   B R+  2[  ;XB   [  9[  2B   +   D[  Z  +  #2B R+   GZ  ?Z   XD  Z   +  #2B S+   Z  @,<   Z  ;D S2B   +   TZ  EZ  2B I+   XZ  H,<   Z   ,<   ,< T& T3B   +   X[  M,<   Z  ID S3B   +   XZ  ,<   ,< TZ   ,<  ,< T( U+  #Z  R,<   Z  QD UXB   3B   +  2@ V  +   ~Z   3B   +   uZ  XZ  ,   XB   ,<   Z  ZZ  _,   XB  @Z  ,<   ,<   ,< T& T3B   +   nZ  c[  [  ,<   ,< W$ W3B   +   nZ  g,<   Z  `D X2B   +   oZp  +   tZ  kXB  aZ  lZ  b,   XB  p    ."   ,   XB  r+   a/   Z   ,<   Z  oD XZ   ,<   Z  KD XZ   XB  oZ  T,<  Z  s,<  Z  V,<  ,< T( U,~   +  #2B Y+  
Z  YZ  w2B  +  2[  ,<   Z  _D S3B   +  2Z B YZ  z,<   ,< TZ  |,<  ,< T( U+  #0B   +  Z ,<   ,< TZ ,<  ,< Z( U+  #2B Z+  Z ,<   ,< TZ ,<  ,< T( U+  #2B [+  "Z ,<   ,< T,<   ,<   ( [XB   3B   +  2[ ,<   Z B Y,\   XB Z 3B  +  +  Z ,<  ,< TZ ,<  ,< Z( U+  #  \XB  v3B   +  *Z  x[  ,<   Z #D \Z &B ],<   Z $,   D ]Z   XB   Z  2[ +[  QD  [  yZ  3B   +  3Z (,<   [ -Z  D \+  3[ +XB 2[ 23B   +  5+   2[  2B   +  8Z  B G,~   Z *,~    @ QE_x 
1,	aE4)M 4* D8E$tOr$!Id e              (VARIABLE-VALUE-CELL TAG . 365)
(VARIABLE-VALUE-CELL OPT.DEFREFS . 362)
(VARIABLE-VALUE-CELL FRA . 8)
(VARIABLE-VALUE-CELL PRA . 225)
(VARIABLE-VALUE-CELL OPNIL . 52)
(VARIABLE-VALUE-CELL COMFN . 122)
(VARIABLE-VALUE-CELL OPRETURN . 139)
(VARIABLE-VALUE-CELL VCONDITIONALS . 157)
(VARIABLE-VALUE-CELL NEWOPTFLG . 187)
(VARIABLE-VALUE-CELL OPCOPY . 234)
(VARIABLE-VALUE-CELL OPPOP . 257)
(VARIABLE-VALUE-CELL DR . 358)
(VARIABLE-VALUE-CELL DEF . 317)
(VARIABLE-VALUE-CELL FRAME . 0)
(VARIABLE-VALUE-CELL LEVEL . 320)
(NIL VARIABLE-VALUE-CELL P . 0)
(NIL VARIABLE-VALUE-CELL APD . 133)
(NIL VARIABLE-VALUE-CELL ALST . 105)
(NIL VARIABLE-VALUE-CELL ANY . 368)
(NIL VARIABLE-VALUE-CELL INFO . 352)
(NIL VARIABLE-VALUE-CELL Y . 334)
(NIL VARIABLE-VALUE-CELL REF . 350)
(NIL VARIABLE-VALUE-CELL BR . 312)
(NIL VARIABLE-VALUE-CELL END . 0)
(NIL VARIABLE-VALUE-CELL PD . 262)
(NIL VARIABLE-VALUE-CELL B . 313)
TAG
OPT.LBMERGE
OPT.LBDEL
(((FJUMP NFJUMP . OPNIL)) . 0)
JUMP
(((JUMP) (TJUMP) (FJUMP) (NTJUMP) (NFJUMP)) . 0)
TJUMP
(((NTJUMP TJUMP) (NFJUMP FJUMP . 1)) . 0)
FJUMP
(((NTJUMP TJUMP . 1) (NFJUMP FJUMP)) . 0)
NTJUMP
(((NTJUMP) (NFJUMP FJUMP . 1)) . 0)
NFJUMP
(((NTJUMP TJUMP . 1) (NFJUMP)) . 0)
POP
(((NTJUMP TJUMP . 1) (NFJUMP FJUMP . 1) (JUMP NIL . JP)) . 0)
RETURN
(((JUMP NIL . R)) . 0)
AVAR
GVAR
FVAR
HVAR
(((FJUMP NFJUMP . L) (TJUMP NTJUMP . L) (JUMP NIL . LL)) . 0)
((-- infinite loop) . 0)
COMPERRM
R
L
OPT.EQVALUE
1
OPT.CALLP
OPT.LABELNTHPR
OPT.JUMPCOPYTEST
(1 VARIABLE-VALUE-CELL N . 246)
(NIL VARIABLE-VALUE-CELL PDN . 227)
NOSIDE
COMP.CLEANFNOP
OPT.EQOP
OPT.PRATTACH
LL
OPT.PRDEL
-1
OPNIL
JP
OPT.SKIPPUSH
OPT.COMPILERERROR
RPLACA
OPT.DEFREFS
NCONC
(CONSNL KT ASZ MKN CONS BHC SKLST KNIL GETHSH ENTERF) *   +     0   @   p   X      8   h4 p$  P z ` k p e   _ @ T 
 K x B ( 9          c    X      
OPT.LBMERGE BINARY
       #        "-.          Z   B  [  ,<   @     ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @     +   Z   [  ,<   Z   D  ,~   [p  XBp  +   /   Z  B  ,<   Z  D   [  [  2B   +   [  ,<   ,<   $   Z  Z   ,   2B   +   Z  ,<   ,<   Z  F  !Z  B  !,~   @e$B
  (VARIABLE-VALUE-CELL TO . 49)
(VARIABLE-VALUE-CELL FROM . 54)
(VARIABLE-VALUE-CELL FRA . 52)
OPT.DEFREFS
(VARIABLE-VALUE-CELL REFS . 34)
(VARIABLE-VALUE-CELL X . 21)
RPLACA
NCONC
RPLACD
PUTHASH
OPT.LBDEL
(GETHSH KNIL BHC SKNLST ENTERF)          @        x      
OPT.PRDEL BINARY
            -.          [   ,<   Z  Z   ,   ,<   @   @ ,~   Z   3B   +   
,<   Z   ,<  Z  F  Z  3B   +   ,<   Z  D  Z  ,<   ,<   Z  	F  Z   ,~   B$     (VARIABLE-VALUE-CELL X . 26)
(VARIABLE-VALUE-CELL PRA . 29)
(VARIABLE-VALUE-CELL B . 24)
(VARIABLE-VALUE-CELL P . 20)
PUTHASH
RPLACD
(KNIL GETHSH ENTERF)    8            
OPT.UBDEL BINARY
              -.          Z   ,<   Z  [  [  Z   7   [  Z  Z  1H  +   2D   +   2B   +   
   D  ,~    W  (VARIABLE-VALUE-CELL CD . 5)
(VARIABLE-VALUE-CELL FRAMES . 8)
OPT.COMPILERERROR
DREMOVE
(KNIL ENTERF)         
OPT.LBDEL BINARY
              -.          Z   B  Z  ,<   @    ,~   [   XB   Z  B  Z  ,<   ,<   $  Z  B  3B   +   Z  	Z   ,   B  Z   ,~   A
D      (VARIABLE-VALUE-CELL TAG . 14)
(VARIABLE-VALUE-CELL PRA . 23)
OPT.DEFREFS
(VARIABLE-VALUE-CELL DEF . 12)
(NIL VARIABLE-VALUE-CELL B . 22)
OPT.PRDEL
OPT.SETDEFREFS
OPT.JUMPCHECK
OPT.DELCODE
(KT GETHSH KNIL ENTERF)                  
OPT.LABELNTHPR BINARY
    +    !    )-.            !Z   ,<   @  %  ,~   Z   B  &Z   Z   ,   XB      1b   +   Z  -,   Z   Z  3B  &+   >  +   Z  -,   Z   Z  2B  &+   Z  ,<   ,<   $  'Z  ,~       ."   ,   XB  ,   Z  &,   XB   ,<   ,<   Z   ,<  Z   F  'Z  ,<   [  D  (XB  Z  ,<  ,   D  ([  ,<   Z   D  ),\   ,~   h1 D      (VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL CNT . 23)
(VARIABLE-VALUE-CELL LEVEL . 62)
(VARIABLE-VALUE-CELL DL . 8)
(VARIABLE-VALUE-CELL PRA . 11)
(VARIABLE-VALUE-CELL LBCNT . 40)
(VARIABLE-VALUE-CELL FRAME . 47)
(VARIABLE-VALUE-CELL FRA . 49)
(VARIABLE-VALUE-CELL CD . 55)
(NIL VARIABLE-VALUE-CELL G . 60)
OPT.CHLEV
TAG
OPT.CHECKTAG
PUTHASH
OPT.PRATTACH
OPT.SETDEFREFS
RPLACD
(CONS21 CONSNL MKN KT KNIL SKLST GETHSH ENTERF)  h   `              (   ` 
           
OPT.JUMPREV BINARY
   ?      6-.         8Z   ,<   Z  ,<   [   [  ,<   Z  Z   ,   ,<   @  x&,~   [   Z  XB   Z   ,   XB   [   XB   Z  XB   [  	XB   Z  XB   Z  XB   Z  Z  XB   2B '+   jZ  Z  2B  +   B (+  Z  ,<  Z  D (3B   +   !Z  ,<   Z  ,<  Z   F )XB   3B   +   !2B   +    Z   XB   +  Z   ,~   Z  3B   +   (Z  !-,   Z   Z  3B )+   (Z  "B *3B   +  Z   ,~   Z  2B *+   *+   .2B '+   CZ  Z  ,   2B   +   CZ  ,<   Z  D +Z  
,   XB   3B   +   CZ  +,<  ,<   Z  0F +Z  1,<   [  5XB  6,\   ,<   Z  2D ,Z  ,<   Z  .,<  Z  4F +Z  :,<   Z  9D ,Z  %,<   Z  6D ,Z  ?,<   Z  >,<  Z  ;F ++  Z  2B ,+   ^Z   3B -+   G2B -+   I[  XB   +   N3B .+   K2B .+  [  G2B   +   M7   Z   XB  HZ  /[  ,<   Z  M3B   +   VZ  E3B -+   S2B .+   TZ  =B ([  QZ  +   ZZ  SB (Z  <,<   ,< /Z  ,<  ,< /( 0D 0Z  B 1,<   Z  N,   D 1+  3B -+   `2B .+  Z  \[  Z  ,<   [  KZ  ,\  2B  +  Z  `B (Z   ,<   [  VD 2Z  b,<   ,< '$ 0+  3B .+   l2B -+  ZZ  eZ  82B  +   pZ  fXD  +  Z  C2B ,+   }Z  2B -+   u[  h3B   +   {+   v[  s2B   +   {Z  l,<   ,< '$ 0Z  gB (Z   XB  +   Z  vB (Z  xB (+  Z  u,<  ,< 2,< /& 33B   +  Z  {,<   Z B 3,\  XB  Z  |B (+  Z  }Z   2B  +  Z  AZ  n2B  +  Z B (Z B (Z ,<   Z  q2B -+  Z -+  Z .D 0+  Z  (2B '+  [  mZ 2B  +  Z ,<   Z 2B -+  Z .+  Z -D 0Z B (+  Z 
,<   Z 	D 4XB   3B   +  Z ,<   Z  WZ  B,   Z  ,\  2B  +  (Z ,<   Z D 2Z ,<   ,< /Z  X,<  ,< /( 0XB   +  S[ $B 43B   +  Z ,<   Z D 52B   +  6Z 2B .+  Z ,<  Z   ,<  ,< /& 33B   +  [ *,<   Z +D 53B   +  Z (,<   Z D +XB  @3B   +  [ 6,<   Z 8Z ,   ,<   Z ;F +Z :Z <,   ,<   [ 9D ,Z 7,<   Z ?,<  Z >F +Z A,<   Z @D ,Z 4,<   Z =D ,Z F,<   Z E,<  Z BF +Z D,<   Z -2B .+  NZ -+  NZ .D 0Z H,<   ,< 5Z %,<  ,< /( 0XB 'Z OB (Z J[  ,<   Z RD 0Z UB 1,<   Z T,   D 1+  3B .+  \2B -+  Z  p2B ,+  gZ K2B -+  a[ /3B   +  e+  b[ _2B   +  eZ X,<   ,< '$ 0+  Z 3B (Z bB (+  Z e,<  Z SD 53B   +  rZ ",<   [ fD 2Z hB (Z k,<   Z ]2B -+  qZ -+  qZ .D 0+  Z n2B -+  Z a,<  Z   D 32B   +  Z t,<   Z 0D 32B   +  Z mZ I,   Z  Z   2B  +  Z zZ z,   B (Z j,<   Z gD 2Z },<   ,< -$ 0+  Z w,<   Z x,<  ,< /& 33B   +  [  ,<   Z lD 53B   +  Z ,<   [ D 2Z 	B (Z ,<   ,< -$ 0+  Z   XB  zZ  ,[ [  QD  +  [ XB [ 3B   +  +   Z ,~   Z   XB +    @  cE)5BB"o> i$h~ QD[+:D*XGv 	Q,(H#y[1Ev(	aQ"            (VARIABLE-VALUE-CELL TAG . 10)
(VARIABLE-VALUE-CELL OPT.DEFREFS . 5)
(VARIABLE-VALUE-CELL FRA . 11)
(VARIABLE-VALUE-CELL PRA . 508)
(VARIABLE-VALUE-CELL OPPOP . 272)
(VARIABLE-VALUE-CELL OPCOPY . 534)
(VARIABLE-VALUE-CELL VCONDITIONALS . 522)
(VARIABLE-VALUE-CELL CONDITIONALS . 490)
(VARIABLE-VALUE-CELL OPNIL . 504)
(VARIABLE-VALUE-CELL DR . 554)
(VARIABLE-VALUE-CELL D . 391)
(VARIABLE-VALUE-CELL LEVEL . 417)
(VARIABLE-VALUE-CELL FRAME . 0)
(NIL VARIABLE-VALUE-CELL R . 540)
(NIL VARIABLE-VALUE-CELL END . 399)
(NIL VARIABLE-VALUE-CELL ANY . 561)
(NIL VARIABLE-VALUE-CELL LB . 429)
(NIL VARIABLE-VALUE-CELL CD . 326)
(NIL VARIABLE-VALUE-CELL BD . 292)
(NIL VARIABLE-VALUE-CELL ABD . 296)
(NIL VARIABLE-VALUE-CELL FLG . 159)
(NIL VARIABLE-VALUE-CELL BR . 536)
(NIL VARIABLE-VALUE-CELL ABR . 520)
(NIL VARIABLE-VALUE-CELL OABR . 440)
(NIL VARIABLE-VALUE-CELL PR . 538)
(NIL VARIABLE-VALUE-CELL APD . 169)
(NIL VARIABLE-VALUE-CELL OAR . 485)
(NIL VARIABLE-VALUE-CELL TMP . 56)
JUMP
OPT.PRDEL
OPT.EQOP
OPT.COMMONBACK
TAG
OPT.DELCODE
RETURN
OPT.FINDEND
PUTHASH
RPLACD
CONST
TJUMP
NTJUMP
FJUMP
NFJUMP
1
-1
OPT.LABELNTHPR
RPLACA
OPT.DEFREFS
NCONC
OPT.PRATTACH
((NOT NULL) . 0)
OPT.CALLP
OPT.NOTJUMP
OPT.JUMPCOPYTEST
OPT.JUMPCHECK
OPT.EQVALUE
0
(CONSNL FMEMB SKLST KT KNIL GETHSH ENTERF)  ^    -    $    " z 	X ! x     !0  w (b 9 `3 X* X h t 
 N 	H 2 ` ( x $ (     x| x<  1 8        
OPT.COMMONBACK BINARY
      m    T    j-.          T[   ,<   Z   ,<   @  V @
,~   Z   Z  2B  Y+   
Z  ,<   Z   D  Y[  XB  	+   Z  	,<   Z   D  Z3B   +   FZ  Z  3B  Z+   3B  [+   3B  [+   3B  \+   3B  \+   2B  ]+   ,<  ]"  ^+   ?3B  ^+   ?3B  _+   ?2B  _+   +   ?2B  `+   %[  Z  ,<   [  
Z  D  Z2B   +   $[  Z  Z  2B  ^+   $[  Z  Z  2B  ^+   $+   F,<  `"  ^+   ?3B  a+   )3B  a+   )3B  b+   )2B  b+   2,<  `"  ^Z  [  Z  ,<   Z  [  Z  ,\  2B  +   0Z  cXB   Z  *B  c+   ?2B  d+   7Z  ![  Z  ,   /"   ,   B  ^+   ?3B  d+   92B  e+   >Z  0B  eZ  9[  Z  XB  Z  :[  [  XB  +   ?,<  f"  fZ  02B   +   BZ   XB  ?[  3XB  B[  <,<   Z  CB  g,\   XB  D+   Z  A3B   +   SZ  B,<  ,<  gZ  ;,<  ,<  g(  hXB   Z  ,B  cZ  L[  ,<   Z  KD  hZ  NB  i,<   Z  M,   D  iZ  F,~   Z   ,~   C	
?p(c~ 3`~@@$Q       (VARIABLE-VALUE-CELL BDEF . 144)
(VARIABLE-VALUE-CELL REF . 162)
(VARIABLE-VALUE-CELL LEVEL . 147)
(VARIABLE-VALUE-CELL FRAME . 123)
(VARIABLE-VALUE-CELL BREF . 139)
(VARIABLE-VALUE-CELL FRAME . 0)
(NIL VARIABLE-VALUE-CELL G . 159)
(NIL VARIABLE-VALUE-CELL FLG . 165)
(NIL VARIABLE-VALUE-CELL TMP . 0)
TAG
OPT.CHECKTAG
OPT.EQOP
AVAR
HVAR
GVAR
FVAR
CONST
COPY
-1
OPT.CHLEV
SETQ
STORE
SWAP
POP
1
TJUMP
FJUMP
NTJUMP
NFJUMP
SAME
OPT.DELTAGREF
FN
UNBIND
DUNBIND
OPT.UBDEL
((OPT.COMMONBACK shouldn't get here) . 0)
OPT.COMPILERERROR
OPT.PRDEL
0
OPT.LABELNTHPR
RPLACA
OPT.DEFREFS
NCONC
(CONSNL KT MKN IUNBOX KNIL ENTERF)   R    B    6    5    T 	  A h        
OPT.DELTAGREF BINARY
               -.           Z   [  Z  B  ,<   @    ,~   Z`  XB   Z  -,   +   +   [  Z  Z  3B  +   +   Z  ,<   [  [  D  ,~   [  XB  +      Z` ,~    0a     (VARIABLE-VALUE-CELL REF . 19)
OPT.DEFREFS
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 30)
RPLACD
OPT.COMPILERERROR
(SKNLST ENTERF)        
OPT.FINDEND BINARY
           
    -.          
Z   Z   2B  +   Z   ,~   B  3B   +   Z  ,~   Z  Z   ,   XB  3B   +   +     (VARIABLE-VALUE-CELL C . 17)
(VARIABLE-VALUE-CELL STOP . 4)
(VARIABLE-VALUE-CELL PRA . 15)
OPT.JUMPCHECK
(GETHSH KNIL ENTERF)         H      
OPT.RETOPT BINARY
        @    8    >-.           8Z   B  9,<   @  9  ,~   Z   ,<   Zp  -,   +   +   Zp  ,<   @  ;   +   Z   B  ;3B   +   Z   XB   Z  
,<   D  <3B   +   Z  Z   ,   XB  ,~   Z  Z   ,   XB  ,~   [p  XBp  +   /   Z  2B   +   Z  ,~   ,<   ,<   Zw-,   +    Zp  Z   2B   +    "  +    [  QD   "  +   ,Zw,<   @  <   +   'Z   ,<   Z  D  =2B   +   &7   Z   ,~   3B   +   *ZwZp  ,   XBp  [wXBw+   /  XB  ,<   Zp  -,   +   /+   7,<   @  =   +   5Z   -,   +   5Z  1,<   [  3D  =,~   [p  XBp  +   -/   +   JPP D(J(  j"(    (VARIABLE-VALUE-CELL CODE . 3)
(VARIABLE-VALUE-CELL ANY . 48)
OPT.RETFIND
(VARIABLE-VALUE-CELL RL . 9)
(NIL VARIABLE-VALUE-CELL TESTL . 89)
(NIL VARIABLE-VALUE-CELL TARGL . 72)
(VARIABLE-VALUE-CELL C . 36)
OPT.RETPOP
OPT.RETTEST
(VARIABLE-VALUE-CELL X . 70)
OPT.RETOPT1
(VARIABLE-VALUE-CELL Z . 104)
(SKLST COLLCT BHC CONS KT KNIL SKNLST ENTER0)  3    *    8 P         p     ( x & X  (  x     / 8        
OPT.RETFIND BINARY
        
    -.          
Z   ,<   @    ,~   Z   [   ,   XB  3B   +   	Z   ,   XB  +   Z  ,~     (VARIABLE-VALUE-CELL C . 3)
(VARIABLE-VALUE-CELL OPRETURN . 8)
(VARIABLE-VALUE-CELL L1 . 11)
(NIL VARIABLE-VALUE-CELL R . 18)
(CONS KNIL FMEMB ENTERF)      p    `      
OPT.RETPOP BINARY
        :    /    8-.           /@  /  ,~   [   XB  Z  Z  2B  1+   
Z   3B  1+    2B  2+   	+    Z  B  2+   !2B  3+   Z  3B   +    +   !2B  3+   Z  3B   +    Z  	B  2+   !2B  4+   Z  [  2B   +    +   !3B  1+   3B  2+   3B  4+   3B  5+   2B  5+   Z  2B   +   !Z  XB  +   2B  6+    Z  Z   ,   XB  +   Z   ,~   Z  B  6Z   XB   Z  ,<  Zp  -,   +   &+   -Zp  ,<   @  7   +   +[   ,<   ,<   $  7,~   [p  XBp  +   $/   Z   XB  #+   {gKGdpDQ@      (VARIABLE-VALUE-CELL RET . 67)
(NIL VARIABLE-VALUE-CELL ANY . 70)
(NIL VARIABLE-VALUE-CELL TAGS . 92)
(NIL VARIABLE-VALUE-CELL VAL . 56)
UNBIND
AVAR
HVAR
OPT.UBDEL
POP
DUNBIND
COPY
FVAR
GVAR
CONST
TAG
OPT.PRDEL
(VARIABLE-VALUE-CELL X . 82)
RPLACD
(BHC SKNLST KT CONS KNIL ENTERF)  .    &    #         . 0  H  P      
OPT.RETOPT1 BINARY
               -.          @    ,~   Z   ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   @     +   Z   ,<   Z   D  XB   ,~   3B   +   Zp  +   [p  XBp  +   /   XB   3B   +   Z  
,<  Z  ,<  Z  F  Z   XB   ,~   

$A    (VARIABLE-VALUE-CELL X . 37)
(VARIABLE-VALUE-CELL L . 6)
(VARIABLE-VALUE-CELL ANY . 44)
(NIL VARIABLE-VALUE-CELL END . 39)
(NIL VARIABLE-VALUE-CELL Y1 . 41)
(VARIABLE-VALUE-CELL Y . 22)
OPT.RETTEST
OPT.RETMERGE
(KT BHC KNIL SKNLST ENTERF)           (   h    X      
OPT.RETTEST BINARY
       t    b    p-.          bZ   ,<   Z   ,<  @  d @
,~   Z   Z   2B  +   Z   XB   XB   [  XB  [  XB  	Z  	-,   Z   Z  2B  f+   Z  2B   +   Z  
Z   ,   XB  [  XB  +   
Z  
-,   Z   Z  2B  f+   Z  2B   +   Z  Z  ,   XB  [  XB  +   Z  Z  2B  g+   +   X2B  g+   +   S3B  h+    2B  h+   &Z  [  Z  ,<   Z  Z   ,   Z  ,\  2B  +   R+   S3B  i+   (2B  i+   ,Z   Z  2B  +   RZ   XB   +   3B  j+   .2B  j+   @Z  (-,   Z   [  -,   Z   Z  ,<   Z  )-,   Z   [  -,   Z   Z  ,\  2B  +   RZ  .-,   Z   [  [  ,<   Z  2-,   Z   [  [  ,\  2B  +   RZ   XB  XB  +   2B  k+   DZ  7,<   Z  :D  k3B   +   R+   2B  l+   F+   R3B  l+   K3B  m+   K3B  m+   K3B  n+   K2B  n+   MZ  AZ  B2B  +   R+   3B  o+   O2B  o+   RZ  KZ  K,   3B   +   R+   Z   ,~   Z  ?2B   +   XZ  O[  Z  Z  ,   XB  SZ  +3B   +   aZ  W2B   +   \Z  UB  p,<   Z  >2B   +   _Z  PB  p,\  3B  +   a+   RZ  [,~   A  C@b>    #E~C(S        (VARIABLE-VALUE-CELL TEST . 69)
(VARIABLE-VALUE-CELL TARGET . 5)
(VARIABLE-VALUE-CELL FRA . 173)
(VARIABLE-VALUE-CELL PRA . 70)
(VARIABLE-VALUE-CELL L1 . 194)
(VARIABLE-VALUE-CELL L2 . 188)
(NIL VARIABLE-VALUE-CELL F1 . 179)
(NIL VARIABLE-VALUE-CELL F2 . 185)
(NIL VARIABLE-VALUE-CELL ONLYIFSAMEFRAME . 176)
TAG
RETURN
JUMP
FJUMP
TJUMP
HVAR
AVAR
UNBIND
DUNBIND
FN
OPT.EQOP
BIND
POP
CONST
FVAR
GVAR
SWAP
STORE
COPY
OPT.CODEFRAME
(EQUAL GETHSH KNIL SKLST KT ENTERF)  Q    X H     ` [  U 
8 R @ <  5 @ 1    H  H   8 8 P 3  / @     ? 8        
OPT.RETMERGE BINARY
           x   
-.          xZ   ,<   Z   ,<  @  z @ ,~   [  B  }XB   3B   +   ,<   [  B  },\  2B  +   Z   XB   [  ,<   ,<  ~$  ~XB  3B   +   ,<   [  ,<   ,<  ~$  ~,\  2B  +   Z   XB   Z   Z   2B  +   HZ  Z  3B  +   2B  +   DZ   XB   -,   Z   Z  3B  +   0    ."   ,   XB  ,   Z  ,   XB  Z  3B   +   ,Z   ,<  Z  [  Z  Z   ,   ,<   Z  $F  Z  3B   +   ,[  ",<   Z  #[  Z  [  [  D Z  (,<   ,<   Z  D ,   D +   8Z  '2B   +   4[  ,,<   ,<   $ Z   2B   +   8Z  2,<  ,<   Z  &F  Z  ),<   Z  8B ,\  XB  Z  9,<   Z  ;[  Z  B D Z  <[  ,<   Z  5D Z  @B ,<   Z  >,   D +   G3B +   G2B +   G+   G  Z   ,~   Z  B-,   Z   Z  2B  +   [Z  02B   +   OZ  H[  ,<   ,<   $ Z  42B   +   SZ  M,<   ,<   Z  7F  Z  QB ,<   Z  S,<   Z  .D D [  U,<   Z  WB ,\   XB  X+   Z  V-,   Z   Z  2B  +   gZ  K2B   +   bZ  [[  ,<   ,<   $ Z  O2B   +   fZ  _,<   ,<   Z  RF  [  cXB  f+   [Z  ZZ  3B +   j2B +   lZ  gB +   s3B  +   s3B +   s3B  +   s3B 	+   s3B +   s3B 	+   s2B 
+   s  [  j,<   Z  sB ,\   XB  t[  fXB  v+   DI# O Y	@0QH(1!H$=D      (VARIABLE-VALUE-CELL TEST . 23)
(VARIABLE-VALUE-CELL END . 41)
(VARIABLE-VALUE-CELL TARGET . 31)
(VARIABLE-VALUE-CELL LBCNT . 60)
(VARIABLE-VALUE-CELL FRA . 202)
(VARIABLE-VALUE-CELL L1 . 236)
(VARIABLE-VALUE-CELL L2 . 238)
(NIL VARIABLE-VALUE-CELL G . 130)
(NIL VARIABLE-VALUE-CELL VEQ . 188)
(NIL VARIABLE-VALUE-CELL FEQ . 196)
(NIL VARIABLE-VALUE-CELL LEV . 27)
OPT.CODEFRAME
0
OPT.CODELEV
TJUMP
FJUMP
TAG
PUTHASH
RPLACD
OPT.PRATTACH
OPT.SETDEFREFS
OPT.NOTJUMP
OPT.DEFREFS
DREMOVE
RPLACA
NCONC
JUMP
RETURN
OPT.COMPILERERROR
OPT.PRDEL
UNBIND
DUNBIND
OPT.UBDEL
NTJUMP
NFJUMP
BIND
ERRORSET
(GETHSH CONS21 CONSNL MKN SKLST KT KNIL ENTERF)  `      @ 0 x   h   H J 0   @     e 8 b x ] 
0 Q 	x M 	( H x 5 @ 2  " 8   x      
OPT.CODELEV BINARY
       `    Q    ]-.           QZ   Z  2B  R+   Z  [  [  2B   +   Z   ,~   ,   +   M3B  S+   
2B  S+   >   Z  [  Z  [  [  2B   +   [  
XB  +   ,   +   M3B  T+   2B  T+   Z  [  Z  [  [  2B   +   [  ,<      
/"   ,   XB  ,\   XB  +   ,   +   M3B  U+   !3B  U+   !3B  V+   !3B  V+   !3B  W+   !2B  W+   &[  ,<      ."   ,   XB  ",\   XB  !+   2B  X+   0[  %,<      $,>  Q,>   Z  '[  Z  ,       ,^   /   /  ."   ,   XB  (,\   XB  )+   2B  X+   6[  /,<      ./"   ,   XB  2,\   XB  1+   3B  Y+   82B  Y+   9^"   +   M2B  Z+   >Z  5[  [  [  [  Z  ,   +   M2B  Z+   EZ  :[  [  [  [  Z  2B   +   C+   ,   ."   +   M3B  [+   H3B  [+   H2B  \+   I[  ?XB  H+   2B   +   K^"   +   MZ  HB  \,   ,>  Q,>      4.Bx  ,^   /   ,   ,~      >@@p  {@8?(        (VARIABLE-VALUE-CELL CD . 151)
(VARIABLE-VALUE-CELL LEV . 156)
TAG
NTJUMP
NFJUMP
TJUMP
FJUMP
AVAR
HVAR
COPY
CONST
FVAR
GVAR
FN
POP
BIND
ERRORSET
DUNBIND
UNBIND
SETQ
STORE
SWAP
OPT.COMPILERERROR
(BHC MKN IUNBOX KNIL ENTERF) 
 -    Q H / H     M H > @       J 0  `   `      
OPT.CODEFRAME BINARY
     )         '-.           Z   Z  2B  "+   Z  Z   ,   2B   +    [  XB  +   3B  "+   3B  #+   3B  #+   2B  $+   Z  [  Z  Z  ,   2B   +    [  XB  +   3B  $+   2B  %+   Z  [  [  ,~   3B  %+   2B  &+   Z  [  [  Z  ,   ,~   2B   +   Z   ,~   3B  &+   2B  '+   Z   ,~   [  XB  +   ,~   `'C`a      (VARIABLE-VALUE-CELL CD . 62)
(VARIABLE-VALUE-CELL FRA . 48)
(VARIABLE-VALUE-CELL TOPFRAME . 53)
TAG
NTJUMP
NFJUMP
TJUMP
FJUMP
BIND
ERRORSET
UNBIND
DUNBIND
JUMP
RETURN
(KNIL GETHSH ENTERF)   (   `      X      
OPT.DEFREFS BINARY
       	        -.          Z   Z   7   [  Z  Z  1H  +   2D   +   [  ,~   
   (VARIABLE-VALUE-CELL D . 3)
(VARIABLE-VALUE-CELL LABELS . 4)
(KNIL ENTERF)          
OPT.SETDEFREFS BINARY
              -.          Z   Z   7   [  Z  Z  1H  +   2D   +   2B   +   
Z  ,   Z  ,   XB  Z  Z   QD  ,~   
@  (VARIABLE-VALUE-CELL D . 15)
(VARIABLE-VALUE-CELL V . 21)
(VARIABLE-VALUE-CELL LABELS . 19)
(CONS CONSNL KNIL ENTERF)         x        
OPT.FRAMEOPT BINARY
        L    D    J-.          D@  F  ,~   Z   3B   +   Z   ,<  Zp  -,   +   +   Zp  ,<   @  G   +   Z   B  G3B   +   Z   XB   ,~   [p  XBp  +   /   Z  ,<   Zp  -,   +   +   Zp  ,<   @  H   +   [   Z  3B   +   Z  B  H3B   +   Z   XB  ,~   [p  XBp  +   /   Z   3B   +   +Z  ,<  Zp  -,   +   !+   *Zp  ,<   @  H   +   )[  Z  3B   +   (Z  #B  I3B   +   (Z   XB  ,~   [p  XBp  +   /   Z  ,<   ,<   Zw-,   +   3Zp  Z   2B   +   1 "  +   2[  QD   "  +   BZw,<   @  H   +   >[  %Z  3B   +   <Z  5,<   Z   D  I3B   +   <Z   XB  (2B   +   =7   Z   ,~   3B   +   AZwZp  ,   XBp  [wXBw+   ,/  XB  +Z  ;,~   !JP Je%"      (VARIABLE-VALUE-CELL TRYLOCAL . 6)
(VARIABLE-VALUE-CELL TRYMERGE . 57)
(VARIABLE-VALUE-CELL TRYXVAR . 113)
(VARIABLE-VALUE-CELL FRAMES . 134)
(NIL VARIABLE-VALUE-CELL ANY . 135)
(VARIABLE-VALUE-CELL X . 20)
OPT.FRAMELOCAL
(VARIABLE-VALUE-CELL F . 111)
OPT.FRAMEVAR
OPT.FRAMEMERGE
OPT.FRAMEDEL
(COLLCT BHC KT SKNLST KNIL ENTERF)      8 + P     = 8 (       .    p   p > H : x 0 x - x % `  p   H      
OPT.FRAMEMERGE BINARY
    q    c    m-.         ( cZ   3B   +   aZ   ,<   @  f  +   a[   Z  [  Z  XB   3B   +   `Z  ,<           ,\   5d      Z   ,   +   [  2B   =d  [  2B   +   `Z  Z   ,   XB   3B   +   `Z  ,<  ,<   Z  	F  h3B   +   `[  [  [  Z  [  Z  ,<   Z  ,<   [  Z  [  ,<   @  h `+   _Z  Z  ,   XB   3B   +   'Z  ,<  ,<   Z  F  h3B   +   'Z  !XB  +   [  &Z  [  ,<   [  'Z  [  Z  ,<   Z  $D  jD  k[  "Z  [  ,<   ,<   $  k[  )Z  ,<   [  0Z  Z  ,   ,>  b,>   [  -Z  Z  ,   .Bx  [  5[  [  Z  [  Z  ,   .Bx  ,^   /   ,   D  k[  7Z  ,<   [  =[  [  Z  [  ,<   ,<  k$  kZ  D  kZ   3B   +   [Z  lZ  D,   XB       1b   +   MZ   ,<   Z  G,<  Z   D  lD  l+   WZ  G0B   +   QZ   ,<  Z  KD  lXB  OZ  F,<   Z  P,<   Z  2F  m2B   +   WZ  J,<   Z  RD  lXB  V   M/"   ,   XB  W[  QXB  Y+   DZ  Y,   5"  ^Z  I,<   Z  WD  l,~   Z   ,~   Z   ,~   ,~   Z   ,~      (( 
)   @ r $         (VARIABLE-VALUE-CELL F . 56)
(VARIABLE-VALUE-CELL MERGEFRAMEFLG . 3)
(VARIABLE-VALUE-CELL MERGEFRAMEMAX . 20)
(VARIABLE-VALUE-CELL FRA . 64)
(VARIABLE-VALUE-CELL OPPOP . 185)
(VARIABLE-VALUE-CELL OPNIL . 157)
(VARIABLE-VALUE-CELL FR . 126)
(NIL VARIABLE-VALUE-CELL VAR . 170)
(NIL VARIABLE-VALUE-CELL VARS . 88)
(NIL VARIABLE-VALUE-CELL P . 166)
OPT.MERGEFRAMEP
(VARIABLE-VALUE-CELL N . 182)
(VARIABLE-VALUE-CELL V . 180)
(VARIABLE-VALUE-CELL CD . 187)
(NIL VARIABLE-VALUE-CELL P2 . 76)
NCONC
RPLACA
0
SETQ
OPT.PRATTACH
OPT.NONILVAR
(KT GUNBOX ASZ MKN BHC IUNBOX GETHSH CONS KNIL ENTERF)       H   	h    =    =    ; x 4    ! 0   x     b  U X 0 ` " x    X 	  0      
OPT.NONILVAR BINARY
      4    &    3-.           &Z   Z  3B  '+   #3B  (+   #3B  (+   #3B  )+   #3B  )+   #3B  *+   #3B  *+   #3B  ++   #3B  ++   #3B  ,+   #3B  ,+   #3B  -+   #3B  -+   #2B  .+   +   #2B   +   +   %2B  .+   Z  [  [  ,<   ,<  /$  /3B   +   %+   #2B  0+   Z   ,<   Z  [  [  ,\  2B  +   #Z   ,~   3B  0+   %2B  1+    +   %3B  1+   #3B  2+   #2B  2+   %[  XB  #+   Z   ,~   ~po O     (VARIABLE-VALUE-CELL V . 0)
(VARIABLE-VALUE-CELL CD . 72)
(VARIABLE-VALUE-CELL FR . 50)
CONST
POP
COPY
AVAR
HVAR
FVAR
GVAR
TJUMP
FJUMP
NTJUMP
NFJUMP
SETQ
STORE
SWAP
FN
FREEVARS
COMP.CLEANFNOP
BIND
TAG
RETURN
UNBIND
DUNBIND
ERRORSET
(KT KNIL ENTERF)  `   `         
OPT.MERGEFRAMEP BINARY
        Q    D    N-.           DZ   Z   ,   3B   +   CZ  GZ   7   [  Z  Z  1H  +   	2D   +   3B   +   @Z  ,<   Z   D  H3B   +   ?Z  ,<   @  H  +   =Z`  -,   +   +   <Z  XB   Z   ,<  @  J  +   -Z`  -,   +   +   ,Z  XB   Z  Z  2B  +   +   *Z  [  Z  [  Z  ,<   @  K  +   (Z`  -,   +   !+   'Z  XB   [  !,<   [  ,\  2B  +   %+   ([`  XB`  +   Z` ,~   +   * $   ""  ,   +   >[`  XB`  +   Z` ,~   Z   ,<   @  M  +   8Z`  -,   +   1+   7Z  XB  "[  2,<   [  #,\  2B  +   6+   9[`  XB`  +   /Z` ,~   +   ; $   ""  ,   +   >[`  XB`  +   Z` ,~   Z   +   ?Z   ,~   Z   ,~   Z   2B   7   Z   ,~   Z   ,~   `*S
00`2"!&       (VARIABLE-VALUE-CELL FR . 49)
(VARIABLE-VALUE-CELL PARENT . 20)
(VARIABLE-VALUE-CELL VARS . 26)
(VARIABLE-VALUE-CELL MERGEFRAMETYPES . 4)
(VARIABLE-VALUE-CELL FRAMES . 37)
(VARIABLE-VALUE-CELL FREEVARS . 90)
(VARIABLE-VALUE-CELL MERGEFRAMEFLG . 129)
AVAR
OPT.CLEANFRAME
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL V . 103)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL F . 53)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL V2 . 101)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL V2 . 0)
(KT NLGO SKNLST KNIL FMEMB ENTERF)   0 B h   0 *    1      @ B  ? P 
             
OPT.FRAMELOCAL BINARY
              -.           @    ,~   [   Z  [  Z  XB       Z  7   [  Z  Z  1H  +   
2D   +   3B   +   Z  B  3B   +   Z  ,<   Zp  -,   +   +   Zp  ,<   @     +   Z   ,<   ,<  $  ,~   [p  XBp  +   /   Z   ,~   Z   ,~   *&   (VARIABLE-VALUE-CELL F . 23)
(NIL VARIABLE-VALUE-CELL VARS . 27)
AVAR
OPT.CLEANFRAME
(VARIABLE-VALUE-CELL X . 38)
HVAR
RPLACA
(KT BHC SKNLST KNIL ENTERF)              8 
       
OPT.CLEANFRAME BINARY
              -.          [   [  [  Z  [  [  Z  2B   +   Z   ,<   @    +   Z`  -,   +   
+   Z  XB   Z  Z   ,   Z  2B  +   Z  Z   2B  +   +   Z  ,<   Z  D  2B   +   Z   XB` +   [`  XB`  +   Z` ,~   ,~   Z   ,~   S F)   (VARIABLE-VALUE-CELL FRAME . 26)
(VARIABLE-VALUE-CELL AVOIDING . 36)
(VARIABLE-VALUE-CELL FRAMES . 12)
(VARIABLE-VALUE-CELL FRA . 24)
(0 . 1)
(NIL VARIABLE-VALUE-CELL F . 34)
T
OPT.CLEANFRAME
(GETHSH SKNLST KNIL ENTERF)      
     P   `      
OPT.FRAMEDEL BINARY
        y   -.         @yZ   ,<   @ ~  0,~   Z   3B   +   2B +   Z   ,~   [  Z  [  Z  XB   [  [  Z  XB   Z   XB   [  [  ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   @    +   Z   Z  2B +   Z  [  Z  ,   1b   7   Z   ,~   Z   ,~   3B   +   Zp  +   [p  XBp  +   /   2B   +   Z  	3B   +   3Z Z   7   [  Z  Z  1H  +   '2D   +   #2B   +   Z  ",<   Z  D 2B   +   3Z   3B   +   [  
[  [  Z  [  [  [  2B   +   Z   XB  3B   +   Z  ,2B +   4Z  3Z   ,   XB   2B   +   8  Z  13B   +   C   ,> x,>   [  4Z  Z  ,   .Bx  [  ;[  [  Z  [  Z  ,   .Bx  ,^   /   ,   XB  9Z  (,<   Zp  -,   +   F+   j,<   @    +   iZ   ,<   Zp  -,   +   K+    ,<   @    +   gZ   [  Z   2B  +   [Z  MZ  2B +   [Z  83B   +   ZZ  P,<  ,<  [  NB D 2B   +   X  Z ,   D ,~   Z  SB ,~   Z  R3B   +   gZ  ZZ  U2B  +   gZ  ],<   [  _,<   [  ]B D XB   0B   +   eZ   +   fZ 	Z  b,   D ,~   [p  XBp  +   I[p  XBp  +   D/   Z   ,<   Zp  -,   +   n+  Zp  ,<   @    +  Z  Z  5,   Z  =2B  +  Z  p,<   Z  6,<   Z  qF 	Z  s[  [  3B   +  Z  C3B   +  Z  v[  ,<   Z  z[  [  ,   ,> x,>      y.Bx  ,^   /   ,   D 
,~   [p  XBp  +   l/   [  )Z  ,<   @    +  Z  [2B   +  
Z  C+  
Z   Z   ,   ,<   Zp  -,   +  +  Zp  ,<   /   Z  `Z   ,   ,<   Z B ,\   XB [p  XBp  +  /   [  rZ  Z  ,   4b ,> x,>   Z   ,<   [ D 
>`x  5  /  ,~   [ [  [  Z  [  [  Z  3B   +  &[  t[  [  Z  [  [  ,<   ,<   $ [ [  ,<   Zp  -,   +  )+  \Zp  ,<   @    +  ZZ XB   Z  ,<   [ ,,<   Z .B ,\   XB /,\   2B +  EZ 3B   +  Z[ ,Z  ,   ,> x,>   Z 	B ,   .Bx  ,^   /   . x,   XB  e1B   +  ZZ Z :,   ,<   Z 0D 
XB >  <4b E,> x,>   Z   ,<   Z ?D 
>`x  5  A/  ,~   2B +  YZ 23B   +  R[ 4Z  ,   ,> x,>   [ [  [  Z  [  Z  ,   .Bx  [ JZ  Z  ,   .Bx  ,^   /   +  T[ HZ  ,   4b Y,> x,>   Z A,<   Z BD 
>`x  5  U/  ,~     ,~   [p  XBp  +  '/   Z   ,<   Zp  -,   +  _+  vZp  ,<   @    +  uZ   Z  u,   Z N2B  +  tZ b,<   Z !,<   Z bF 	Z e[  [  ,<   Z  3B   +  sZ h[  [  Z  XB ?3B   +  s  m,> x,>     j.Bx  ,^   /   ,   +  tZ   D ,~   [p  XBp  +  ]/   Z   ,~        
`$L
E,   B(&!]"2d$ A@@DP0P AJ	0LH@ aHAJ      (VARIABLE-VALUE-CELL F . 332)
(VARIABLE-VALUE-CELL TRYXVAR . 86)
(VARIABLE-VALUE-CELL FRA . 462)
(VARIABLE-VALUE-CELL CODE . 145)
(VARIABLE-VALUE-CELL OPCOPY . 200)
(VARIABLE-VALUE-CELL LABELS . 214)
(VARIABLE-VALUE-CELL PRA . 288)
(VARIABLE-VALUE-CELL OPNIL . 306)
(VARIABLE-VALUE-CELL OPPOP . 427)
(VARIABLE-VALUE-CELL FRAMES . 441)
(VARIABLE-VALUE-CELL FRM . 455)
(NIL VARIABLE-VALUE-CELL VARS . 365)
(NIL VARIABLE-VALUE-CELL PARENT . 460)
(NIL VARIABLE-VALUE-CELL OP . 421)
(NIL VARIABLE-VALUE-CELL FLV . 481)
(NIL VARIABLE-VALUE-CELL TMP . 478)
(NIL VARIABLE-VALUE-CELL DOXVAR . 397)
ERRORSET
(VARIABLE-VALUE-CELL X . 248)
UNBIND
AVAR
OPT.DELETEFRAMECHECK
MAP
OPT.COMPILERERROR
(VARIABLE-VALUE-CELL VR . 194)
(VARIABLE-VALUE-CELL CD . 429)
SETQ
LENGTH
OPT.CODELEV
STORE
RPLACA
OPT.PRDEL
COPY
PUTHASH
RPLACD
OPT.PRATTACH
DUNBIND
(VARIABLE-VALUE-CELL F2 . 471)
(CONS ASZ CONS21 URET1 MKN GETHSH KT IUNBOX BHC SKNLST KNIL ENTERF)  ` g   < @   @ Y    L   s 0 8   @ ( 6   x ` 2 (   HQ hJ 6   ~  =    xs PY (E   ` P 8 C      _  X K `    t pk  4  0	 ( y P W 
8 9 x 3  , 0 ( p "   8     x        
OPT.FRAMEVAR BINARY
             -.          Z   ,<   @   0,~   [   Z  [  Z  2B   +   Z   ,~   B XB   [  Z  Z  XB   [  	[  [  Z  [  Z  XB   Z  ,<  Z  
,<  @  @
+   mZ`  XB       ,> 
,>    `     ,^   /   3"  +   Z  -,   +   Z` ,~   Z  Z  2B +   +   jZ  Z   ,   XB   2B   +   8Z  0B   +   'Z"   XB  Z   ,<  [  Z  [  D    /"   ,   XB  %+   )   /"   ,   XB  'Z  ,<   @    +   5Z  2B   +   .,~   Z  ,[  Z  2B  +   3Z  .Z  2B +   3Z  0B [  2XB  3+   ,Z  /,<   ,<   $ Z   XB   +   jZ  ),<  Zp  -,   +   <Z   +   HZp  ,<   ,<w/   @    +   EZ   2B +   D[  ?Z  52B  7   Z   ,~   Z   ,~   3B   +   GZ   +   H[p  XBp  +   9/   3B   +   jZ  !1B   +   N   )/"   ,   XB  KZ   +   `[  #Z  [  Z  XB   Z  2B +   WZ   ,<   [  P,<    "   ,   3B   +   `+   XZ   +   `Z"   XB  J   &/"   ,   XB  Y[  NZ  [  Z  ,<   [  [Z  [  B ,\   XB  S3B   +   j,<   Z  4Z  `XD  Z  AZ  b,   XB  d2B   +   bZp  /   Z  cZ   XD  Z   XB  7[  gXB  j   X. 
,   XB  k+   Z  i3B   +  	[  Z  [  ,<   Z  ,<   ,<   Zw-,   +   yZp  Z   2B   +   w "  +   x[  QD   "  +  Zw,<   @    +   |Z  A,~   3B   +   ZwZp  ,   XBp  [wXBw+   r/  B D [  oZ  ,<   Z  MD [ [  [  Z  [  ,<   Z  ZD Z  m,~       	 !$	R$@
I h @  "DQa @      (VARIABLE-VALUE-CELL F . 187)
(VARIABLE-VALUE-CELL CODE . 113)
(VARIABLE-VALUE-CELL OPPOP . 68)
(VARIABLE-VALUE-CELL OPNIL . 155)
(VARIABLE-VALUE-CELL EQCONSTFN . 165)
(VARIABLE-VALUE-CELL FR . 266)
(NIL VARIABLE-VALUE-CELL VARS . 226)
(NIL VARIABLE-VALUE-CELL CD . 202)
(NIL VARIABLE-VALUE-CELL VAL . 197)
(NIL VARIABLE-VALUE-CELL ANY . 274)
(NIL VARIABLE-VALUE-CELL NNILS . 264)
(NIL VARIABLE-VALUE-CELL NVALS . 272)
REVERSE
(0 . 1)
(VARIABLE-VALUE-CELL I . 217)
0
NIL
(NIL VARIABLE-VALUE-CELL V . 213)
AVAR
OPT.PRATTACH
(VARIABLE-VALUE-CELL CD . 0)
SETQ
OPT.PRDEL
RPLACA
(VARIABLE-VALUE-CELL X . 247)
CONST
OPT.DREV
(COLLCT EVCC KT MKN ASZ FMEMB SKNLST BHC KNIL ENTERF)  x   
`     D @ 8    m 0 M  '    Y 	8 "    X     t 0       I h     } ` u 0 o  f ( a   V 	  G ` E 8 7 X           
OPT.DELETEFRAMECHECK BINARY
             -.          Z   ,<   Z   D  ,<   @     ,~   Z   3B   +   	[  [   Z  3B  +   
Z   ,~   [  XB  
Z  Z   ,   XB  Z  2B   +   Z   ,~   Z  ,<   Z  D  Z  2B  +   	+   
!      (VARIABLE-VALUE-CELL VARS . 32)
(VARIABLE-VALUE-CELL F . 15)
(VARIABLE-VALUE-CELL CODE . 34)
(VARIABLE-VALUE-CELL PRA . 24)
OPT.ONLYMEMB
(VARIABLE-VALUE-CELL CD . 36)
(KT GETHSH KNIL ENTERF)            (        
OPT.ONLYMEMB BINARY
        
    	    
-.           	Z   Z   ,   XB  3B   +   Z  [  ,   2B   +   Z  ,~   Z   ,~   !   (VARIABLE-VALUE-CELL X . 9)
(VARIABLE-VALUE-CELL Y . 14)
(KNIL FMEMB ENTERF)      H    h        
OPT.SKIPPUSH BINARY
        k    ]    h-.           ]Z   2B   +   Z"   XB     0"   +   Z   ,~   Z  0B   +   	Z   ,~   Z  Z  3B  `+   3B  `+   3B  a+   3B  a+   2B  b+   [  	,<      /"   ,   XB  ,\   XB  +   2B  b+   Z  [  2B   +   [  ,<      /"   ,   XB  ,\   XB  +   Z   ,~   2B  c+   !   1"  +    [  XB  +   Z   ,~   2B  c+   &[  ,<      ."   ,   XB  #,\   XB  "+   3B  d+   *3B  d+   *3B  e+   *2B  e+   3Z   3B   +   2Z   2B   +   2[  %,<      $."   ,   XB  .,\   XB  -+   Z   ,~   2B  f+   PZ  1[  [  ,<   ,<  f$  g2B   +   GZ  *3B   +   FZ   Z  3B  b+   <2B  `+   =Z   +   G3B  a+   @3B  `+   @2B  a+   EZ  4[  [  ,<   ,<  g$  g3B   +   \+   GZ   ,~   Z   ,~   [  @,<      0,>  ],>   Z  G[  Z  ,   .Bx  ,^   /   /"   ,   XB  H,\   XB  I+   2B  h+   \Z  83B   +   YZ  93B   +   YZ  R,<   Z  O[  ,\  2B  +   XZ   ,~   Z   +   ZZ   ,~   [  UXB  Z+   Z   ,~      !` 	I~$i`  9    (VARIABLE-VALUE-CELL CD . 182)
(VARIABLE-VALUE-CELL N . 156)
(VARIABLE-VALUE-CELL VL . 168)
(VARIABLE-VALUE-CELL LEVOPFLG . 88)
(VARIABLE-VALUE-CELL NEWOPTFLG . 162)
AVAR
HVAR
FVAR
GVAR
CONST
COPY
SWAP
POP
FJUMP
TJUMP
NFJUMP
NTJUMP
FN
NOSIDE
COMP.CLEANFNOP
FREEVARS
SETQ
(BHC IUNBOX KT MKN ASZ KNIL ENTERF)   	X   	@    =    N  %        @   P Z  T 
( G ` D  8 0 - @ ! @   h        
OPT.DELCODE BINARY
    M    >    J-.         ( >@  A  ,~   Z   XB   Z  2B   +   Z   ,~   2B  B+   +   3B  B+   
2B  C+   %[  [  Z   7   [  Z  Z  1H  +   2D   +   [  ,<   ,<   $  CZ   ,<   @  D  +   $Z`  -,   +   +   #Z  XB   Z  Z   ,   ,<   [  
[  ,\  3B  +   +   "[  ,<   Zp  -,   +   +   !Zp  B  E[p  XBp  +   /   [`  XB`  +   Z` ,~   +   83B  F+   '2B  F+   .Z  ,<   [  [  Z  7   [  Z  Z  1H  +   -2D   +   *D  G+   83B  G+   43B  H+   43B  H+   43B  I+   43B  I+   42B  C+   8Z  ',<   [  (Z  B  JD  GZ   XB  Z   XB   Z  4Z   ,   ,<   Z  9B  E,\   XB  ;+   	~ Q)@> |0        (VARIABLE-VALUE-CELL CD . 122)
(VARIABLE-VALUE-CELL FRAMES . 82)
(VARIABLE-VALUE-CELL LABELS . 35)
(VARIABLE-VALUE-CELL FRA . 47)
(VARIABLE-VALUE-CELL ANY . 114)
(VARIABLE-VALUE-CELL PRA . 116)
(NIL VARIABLE-VALUE-CELL X . 107)
(NIL VARIABLE-VALUE-CELL FLG . 112)
TAG
BIND
ERRORSET
RPLACA
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL LB . 56)
OPT.PRDEL
UNBIND
DUNBIND
DREMOVE
JUMP
FJUMP
TJUMP
NFJUMP
NTJUMP
OPT.DEFREFS
(KT BHC GETHSH SKNLST KNIL ENTERF)  8    "    ;    h     -    X      
OPT.PRATTACH BINARY
              -.          Z   Z   ,   ,<   Z   ,   ,<   @   @ ,~   Z   ,<   Z   ,<  Z  F  Z  ,<   Z  D  Z  	Z   XD  Z  
,<  ,<   Z  F  Z  3B   +   ,<   Z  D  Z  ,~    @    (VARIABLE-VALUE-CELL ITEM . 24)
(VARIABLE-VALUE-CELL BEFORE . 26)
(VARIABLE-VALUE-CELL PRA . 29)
(VARIABLE-VALUE-CELL AFTER . 31)
(VARIABLE-VALUE-CELL NEW . 37)
PUTHASH
RPLACD
(CONSNL KNIL GETHSH ENTERF)  P               
OPT.JUMPCOPYTEST BINARY
            -.           Z   ,<   Z   D  3B   +   Z  ,~   Z  B  3B   +   Z  Z  3B  +   Z  [  [  ,<   ,<  $  3B   +   [  	,<   Z  [  Z  ,   /"   ,   ,<   Z  ,<   ,<   (  XB  3B   +   +   Z   ,~   "L 	@   (VARIABLE-VALUE-CELL VL . 36)
(VARIABLE-VALUE-CELL CDFROM . 40)
OPT.EQVALUE
OPT.CALLP
HVAR
FREEVARS
COMP.CLEANFNP
OPT.SKIPPUSH
(KT MKN IUNBOX KNIL ENTERF)               X   x        
OPT.EQOP BINARY
       >    1    <-.           1Z   Z   3B  7   7   +   1Z  ,<   Z  ,\  2B  +   0Z  3B  2+   3B  3+   3B  3+   3B  4+   2B  4+   [  ,<   [  ,\  2B  7   Z   ,~   3B  5+   3B  5+   2B  6+   Z   ,~   2B  6+   Z  Z  ,   ,~   3B  7+   !3B  7+   !3B  8+   !3B  8+   !3B  9+   !3B  9+   !3B  :+   !3B  :+   !2B  ;+   +[  Z  ,<   [  Z  ,\  2B  +   *[  ![  ,<   [  "[  ,\  2B  7   Z   ,~   Z   ,~   2B  ;+   /[  %,<   [  &XB  -,\   XB  ,+   Z   ,~   Z   ,~    _|yC`  `       (VARIABLE-VALUE-CELL OP1 . 93)
(VARIABLE-VALUE-CELL OP2 . 91)
FVAR
GVAR
CONST
COPY
STORE
POP
RETURN
SWAP
FN
JUMP
TJUMP
NTJUMP
FJUMP
NFJUMP
BIND
ERRORSET
UNBIND
DUNBIND
SETQ
(EQUAL KNIL KT ENTERF)       1  +    H              
OPT.EQVALUE BINARY
    ,    "    *-.           "Z   Z  2B  #+   Z  [  3B   +   Z   ,~   Z   [  XB  +   2B  #+   Z  [  Z   3B  7   7   +   ![  	XB  +   3B  $+   3B  $+   3B  %+   3B  %+   2B  &+   Z  Z  
2B  7   Z   ,~   3B  &+   3B  '+   3B  '+   3B  (+   3B  (+   2B  )+   ![  ,<   ,<  )Z  F  *XB  3B   +   !+   Z   ,~   p`     (VARIABLE-VALUE-CELL CD . 62)
(VARIABLE-VALUE-CELL V . 60)
COPY
SETQ
HVAR
AVAR
FVAR
GVAR
CONST
POP
FJUMP
TJUMP
NFJUMP
NTJUMP
SWAP
1
OPT.SKIPPUSH
(KT KNIL ENTERF)   h   x       `   h        
OPT.DELCOPYFN BINARY
       8    .    6-.          .,<   Z   ,<   ,<   ,<  /&  03B   +   %Z  ,<   Z   Z   ,   Z  D  03B   +   %Z  [  [  ,<   ,<  1$  13B   +   %Z  
,<   @  2  +   $Z   3B   +   #Z  2B  +   +   #Z  Z  2B  3+   Z  [  [  ,<   ,<  1$  12B   +   !+    3B  3+   !3B  4+   !3B  4+   !3B  5+   !2B  5+    +   !Z   XB` +   #[  XB  !+   Z` ,~   2B   +   &Zp  +   ,[  ,<   Z  &B  6,\   Z  ,   XB  'Z  Z  (,   XB  *+   /   Z  +,~   h
C?(@       (VARIABLE-VALUE-CELL P . 83)
(VARIABLE-VALUE-CELL X . 90)
(VARIABLE-VALUE-CELL PRA . 85)
1
OPT.CALLP
OPT.EQOP
NOSIDE
COMP.CLEANFNOP
(VARIABLE-VALUE-CELL Z . 68)
T
FN
FVAR
AVAR
HVAR
GVAR
SETQ
OPT.PRDEL
(BHC GETHSH KNIL ENTERF)  -    ,       %          @        
OPT.DEADSETQP BINARY
           	    -.           	Z   3B  
+   2B  +   @    +   Z  ,<   Z   D  ,~   ,~   Z   ,~   h@  (VARIABLE-VALUE-CELL VAR . 11)
(VARIABLE-VALUE-CELL CD . 13)
AVAR
HVAR
(NIL VARIABLE-VALUE-CELL TAGS . 0)
(50 VARIABLE-VALUE-CELL ICNT . 0)
OPT.DS1
(KNIL ENTERF)         
OPT.DS1 BINARY
      T    D    Q-.           D@  G  ,~   Z   XB   Z  2B  H+   [  Z   2B  +   <Z   ,~   2B  H+   Z  2B  I+   <[  [  ,<   ,<  I$  J2B   +   <Z   ,~   3B  J+   2B  K+   Z  	,<   [  [  [  Z  [  Z      ,\   ,   3B   +   <+   2B  K+   $[  B  LXB  3B   +   #,<   Z  2B  L+   Z   XBp  +   "Z  Z   ,   XB  2B   +   Zp  +    Z   ,~   2B  M+   )[  !Z  B  MZ  XB  2B   +   +   3B  N+   .3B  N+   .3B  O+   .3B  O+   .2B  L+   3Z  ,<   [  %Z  B  MZ  D  P2B   +   <+   2B  P+   :Z  /Z   ,   3B   +   7+   Z  4Z  5,   XB  8+   <Z  7Z  .2B  +   <+   Z  'Z   ,   XB  <2B   +   @   QZ   0B   +   B+      @/"   ,   XB  B+   MFO R22<0F0@     (VARIABLE-VALUE-CELL VAR . 117)
(VARIABLE-VALUE-CELL CD . 124)
(VARIABLE-VALUE-CELL FRA . 64)
(VARIABLE-VALUE-CELL TAGS . 114)
(VARIABLE-VALUE-CELL PRA . 122)
(VARIABLE-VALUE-CELL ICNT . 135)
(NIL VARIABLE-VALUE-CELL A . 116)
SETQ
FN
AVAR
FREEVARS
COMP.CLEANFNOP
UNBIND
DUNBIND
RETURN
OPT.CODEFRAME
ERRORSET
JUMP
OPT.DEFREFS
TJUMP
FJUMP
NTJUMP
NFJUMP
OPT.DS1
TAG
OPT.COMPILERERROR
(MKN ASZ CONS URET1 GETHSH FMEMB KNIL KT ENTERF) @         @   h !    6 x   x 7 0 ) H " p     h   P        
OPT.COMPILERERROR BINARY
                -.           ,<  ,<   $  Z   ,<   Z   D  ,~      (VARIABLE-VALUE-CELL MESS1 . 6)
(VARIABLE-VALUE-CELL MESS2 . 8)
"Compiler error
"
LISPXPRIN1
HELP
(KT ENTERF)  0      
OPT.OPTCHECK BINARY
     C   -   >-.          0-Z   ,<   @ 0  ,~   Z   2B   +   cZ   ,<  Zp  -,   +   +   6Zp  ,<   @ 2   +   4[   3B   +   4Z  Z  ,   2B   +   Z  ,<   ,< 2$ 3[  ,<   Zp  -,   +   +   Zp  ,<   @ 3   +   Z   ,<   Z  D 42B   +   Z  ,<   ,< 4$ 3,~   [p  XBp  +   /   [  Z  Z  Z  3B  +   #Z  ,<   ,< 5$ 3[  ![  ,<   Zp  -,   +   &+   3Zp  ,<   ,<w/   @ 3   +   0Z  [  Z  Z  #3B  7   7   +   0Z  +,<   ,< 5$ 3,~   2B   +   2+   3[p  XBp  +   $/   ,~   [p  XBp  +   /   Z   ,<   Zp  -,   +   9+   aZp  ,<   @ 2   +   `Z  .Z   2B  +   B[  <3B   +   _Z 6Z  >,   B 3,~   [  @,<   Zp  -,   +   E+   VZp  ,<   @ 3   +   UZ  *,<   Z  D 42B   +   N,< 6Z  G,<   Z  B,<  ,   B 3Z  K[  [  Z  L3B  +   T,< 7Z  N,<   Z  O,<  ,   B 3,~   [p  XBp  +   C/   Z  RZ   ,   Z  67   [  Z  Z  1H  +   ]2D   +   Y2B   +   _,< 7Z  WD 3,~   [p  XBp  +   7/   Z   ,~   Z  Z  2B 8+   yZ  cZ  7   [  Z  Z  1H  +   j2D   +   fXB   2B   +   l  3[  jZ  Z  e3B  +   o  3Z  mZ  W,   3B   +  $Z  oZ  o,   Z  X7   [  Z  Z  1H  +   w2D   +   t2B   +  $  3+  $3B 8+   {2B 9+  Z  q[  [  Z  s7   [  Z  Z  1H  +  2D   +   ~[  Z  Z  {3B  +  $  3+  $3B 9+  2B :+  Z ,<   Z [  [  Z  }7   [  Z  Z  1H  +  2D   +  
[  [      ,\   ,   2B   +  $  3+  $3B :+  3B ;+  3B ;+  3B <+  2B <+  $Z [  Z  Z  e7   [  Z  Z  1H  +  2D   +  XB  l2B   +    3Z ,<   Z D =2B   +  $Z ,<   ,< =$ 3[ "XB  [ $Z %2B  +  *Z %Z   ,   Z   3B  +  +  3Z 'XB )Z &XB ++   2H&"L &3& e@
hA@)/px (@
1L       (VARIABLE-VALUE-CELL CODE . 145)
(VARIABLE-VALUE-CELL LABELS . 306)
(VARIABLE-VALUE-CELL FRAMES . 275)
(VARIABLE-VALUE-CELL TOPFRAME . 121)
(VARIABLE-VALUE-CELL FRA . 228)
(VARIABLE-VALUE-CELL PRA . 336)
(VARIABLE-VALUE-CELL CD . 345)
(NIL VARIABLE-VALUE-CELL P . 343)
(NIL VARIABLE-VALUE-CELL B . 344)
(VARIABLE-VALUE-CELL X . 189)
((not in code) . 0)
OPT.COMPILERERROR
(VARIABLE-VALUE-CELL Y . 163)
TAILP
((NOT CODE TAIL) . 0)
((TAG wrong) . 0)
((TAG wrong) . 0)
TOPFRAME
((NOT IN CODE) . 0)
((WRONG FRAME) . 0)
((PARENT NOT FRAME) . 0)
TAG
BIND
ERRORSET
UNBIND
DUNBIND
JUMP
TJUMP
FJUMP
NTJUMP
NFJUMP
MEMB
((NOT IN JUMP LIST) . 0)
(GETHSH LIST3 CONS KT BHC FMEMB SKNLST KNIL ENTER0) ) 8 q    
H N    A    c X   ( W p 4      h   H 9 `      ( X `  w  k   ^ P J x 1 `  p   X      
OPT.CCHECK BINARY
                -.           Z   2B   +      ,~       (VARIABLE-VALUE-CELL X . 3)
OPT.COMPILERERROR
(KNIL ENTERF)          
(PRETTYCOMPRINT BYTECOMPILERCOMS)
(RPAQQ BYTECOMPILERCOMS ((* THE BYTE LISP COMPILER) (COMS (FNS BYTEBLOCKCOMPILE2 BYTECOMPILE2 
COMP.ATTEMPT.COMPILE COMP.RETFROM.POINT COMPERROR COMPPRINT COMPERRM) (FNS COMP.TOPLEVEL.COMPILE 
COMP.BINDLIST COMP.CHECK.VAR COMP.BIND.VARS COMP.UNBIND.VARS) (FNS COMP.VALN COMP.PROGN COMP.EXP1 
COMP.EXPR COMP.TRYUSERFN COMP.USERFN COMP.CONST COMP.CALL COMP.VAR COMP.VAL1 COMP.PROG1 COMP.EFFECT 
COMP.VAL COMP.MACRO) (FNS COMP.VARTYPE COMP.LOOKUPVAR COMP.LOOKUPCONST) (FNS COMP.ST COMP.STFN 
COMP.STCONST COMP.STVAR COMP.STPOP COMP.DELFN COMP.STRETURN COMP.STTAG COMP.STJUMP COMP.STSETQ 
COMP.STCOPY COMP.DELPUSH COMP.DELPOP COMP.STBIND COMP.STUNBIND) (FNS COMP.ARGTYPE COMP.CLEANEXPP 
COMP.CLEANFNP COMP.CLEANFNOP COMP.GLOBALVARP COMP.LINKCALLP COMP.ANONP) (FNS COMP.CPI COMP.CPI1 
COMP.PICOUNT) (PROP BYTEMACRO EVQ) (FNS COMP.EVQ) (PROP BYTEMACRO AND OR) (FNS COMP.BOOL) (FNS 
COMP.APPLYFNP) (PROP BYTEMACRO AC ASSEMBLE ASSEM FLOC) (FNS COMP.AC COMP.PUNT) (PROP BYTEMACRO 
FUNCTION) (FNS COMP.FUNCTION COMP.LAM1 COMP.GENFN) (INITVARS (COMP.GENFN.NUM 0) (COMP.GENFN.BUF (
ALLOCSTRING 100))) (GLOBALVARS COMP.GENFN.NUM COMP.GENFN.BUF) (PROP BYTEMACRO COND SELECTQ) (FNS 
COMP.COND COMP.SELECTQ) (PROP BYTEMACRO PROGN PROG1) (PROP BYTEMACRO QUOTE *) (FNS COMP.QUOTE 
COMP.COMMENT) (PROP BYTEMACRO DECLARE) (FNS COMP.DECLARE COMP.DECLARE1) (PROP (BYTEMACRO CROPS) * 
MCROPS) (FNS COMP.CARCDR COMP.STCROP) (PROP BYTEMACRO NOT NULL) (FNS COMP.NOT) (PROP BYTEMACRO SETQ 
SETN) (FNS COMP.SETQ COMP.SETN) (FNS COMP.LAMBDA) (PROP BYTEMACRO PROG GO RETURN) (FNS COMP.PROG 
COMP.GO COMP.RETURN) (VARS NUMBERFNS (GLOBALVARFLG T) (NEWOPTFLG) (COMPVERSION (DATE))) (PROP 
BYTEMACRO IPLUS ITIMES LOGOR LOGXOR LOGAND IDIFFERENCE IQUOTIENT IREMAINDER IMINUS LSH LLSH RSH LRSH 
FIX PLUS DIFFERENCE TIMES QUOTIENT FPLUS FDIFFERENCE FTIMES FQUOTIENT) (FNS COMP.NUMERIC 
COMP.NUMBERCALL COMP.FIX COMP.STFIX COMP.DELFIX) (PROP BYTEMACRO EQ EQUAL EQP) (FNS COMP.EQ) (PROP 
BYTEMACRO .TEST.) (FNS COMP.NUMBERTEST) (PROP BYTEMACRO * MAPFNS) (PROP BYTEMACRO .DOCOLLECT. .DOJOIN.
) (FNS COMP.MAP) (PROP BYTEMACRO LISPXWATCH) (PROP BYTEMACRO FETCHFIELD REPLACEFIELD FFETCHFIELD 
FREPLACEFIELD REPLACEFIELDVAL FREPLACEFIELDVAL) (PROP BYTEMACRO GETPROP) (PROP BYTEMACRO BLKAPPLY 
BLKAPPLY*) (PROP BYTEMACRO ADD1VAR SUB1VAR KWOTE FRPLNODE RPLNODE LISTGET1 FRPLNODE2) (PROP BYTEMACRO 
JSYS) (PROP BYTEMACRO EQMEMB MKLIST) (COMS (* Pass 1 listing) (FNS COMP.MLLIST COMP.MLL COMP.MLLVAR 
COMP.MLLFN) (VARS COPS) (IFPROP MLSYM * (PROGN COPS))) (COMS (* ARJ - JUMP LENGTH RESOLVER) (FNS 
OPT.RESOLVEJUMPS OPT.JLENPASS OPT.JFIXPASS OPT.JSIZE)) (COMS (* utilities used by all files) (FNS 
OPT.CALLP OPT.JUMPCHECK OPT.DREV OPT.CHLEV OPT.CHECKTAG OPT.NOTJUMP OPT.INITHASH OPT.COMPINIT)) (P (
MOVD? (QUOTE NILL) (QUOTE REFRAME)) (AND (GETD (QUOTE OPT.COMPINIT)) (OPT.COMPINIT))) (PROP BYTEMACRO 
LOADTIMECONSTANT) (PROP BYTEMACRO FRPTQ) (FNS OPT.CFRPTQ) (DECLARE: EVAL@COMPILE DONTCOPY (SPECVARS AC
 ALAMS1 ALLVARS ARGS ARGVARS BLKDEFS BLKFLG CODE COMFN COMFNS COMTYPE CONSTS EMFLAG EXP FRAME FREELST 
FREEVARS LAPFLG LBCNT LEVEL LOCALVARS LOCALVARS LSTFIL MACEXP NLAMS1 PIFN COMPILE.CONTEXT PROGCONTEXT 
RETURNLABEL SPECVARS SPECVARS SUBFNFREEVARS TAGS TOPFN TOPFRAME TOPLAB VARS INTERNALBLKFNS) (SPECVARS 
PLVLFILEFLG)) (PROP BYTEMACRO IMAX2 IMIN2) (PROP DMACRO AREF ASET) (PROP BOX FLOAT) (FNS COMP.AREF 
COMP.ASET COMP.BOX COMP.LOOKFORDECLARE COMP.DECLARETYPE COMP.FLOATBOX COMP.FLOATUNBOX COMP.PREDP 
COMP.UBFLOAT2 COMP.UNBOX)) (ADDVARS (COMPILETYPELST)) (COMS (* POST OPTIMIZATION) (FNS OPT.POSTOPT 
OPT.SETUPOPT OPT.SCANOPT OPT.XVARSCAN OPT.XVARSCAN1 OPT.JUMPOPT OPT.JUMPTHRU OPT.LBMERGE OPT.PRDEL 
OPT.UBDEL OPT.LBDEL OPT.LABELNTHPR OPT.JUMPREV OPT.COMMONBACK OPT.DELTAGREF OPT.FINDEND OPT.RETOPT 
OPT.RETFIND OPT.RETPOP OPT.RETOPT1 OPT.RETTEST OPT.RETMERGE OPT.CODELEV OPT.CODEFRAME OPT.DEFREFS 
OPT.SETDEFREFS) (FNS OPT.FRAMEOPT OPT.FRAMEMERGE OPT.NONILVAR OPT.MERGEFRAMEP OPT.FRAMELOCAL 
OPT.CLEANFRAME OPT.FRAMEDEL OPT.FRAMEVAR OPT.DELETEFRAMECHECK OPT.ONLYMEMB) (VARS MERGEFRAMETYPES (
OPTIMIZATIONSOFF)) (FNS OPT.SKIPPUSH OPT.DELCODE OPT.PRATTACH OPT.JUMPCOPYTEST OPT.EQOP OPT.EQVALUE 
OPT.DELCOPYFN) (FNS OPT.DEADSETQP OPT.DS1) (DECLARE: EVAL@COMPILE DONTCOPY (SPECVARS CODE LEVEL) (
SPECVARS LABELS PASS ANY CODE FRAME FRAMES) (GLOBALVARS MERGEFRAMEMAX MERGEFRAMEFLG MERGEFRAMETYPES) (
SPECVARS VARS ANY FRAME) (SPECVARS ICNT TAG) (SPECVARS FRAME LEVEL ANY) (SPECVARS FRAME LEVEL ANY) (
SPECVARS TAGS ANY))) (COMS (* CONSISTENCY CHECKS) (DECLARE: EVAL@COMPILE DONTCOPY (MACROS OPT.CCHECK) 
(VARS (COMPILECOMPILERCHECKS NIL))) (FNS OPT.COMPILERERROR OPT.OPTCHECK OPT.CCHECK)) (GLOBALVARS ALAMS
 BLKLIBRARY BYTE.EXT BYTEASSEMFN BYTECOMPFLG COMPILERMACROPROPS CIA CLEANFNLIST COMP.SCRATCH 
COMPILETYPELST COMPILEUSERFN COMPSTATLST COMPSTATS CONDITIONALS CONST.FNS CONSTOPS DONOTHING FILERDTBL
 FNA FORSHALLOW FRA GLOBALVARS HEADERBYTES HOKEYDEFPROP LAMBDANOBIND LAMS LBA LEVELARRAY LINKEDFNS 
LINKFNS LOADTIMECONSTANT MAXBNILS MAXBVALS MCONSTOPS MERGEFRAMEFLG MERGEFRAMEMAX MERGEFRAMETYPES 
MOPARRAY MOPCODES NLAMA NLAML NODARR NOLINKFNS NOSTATSFLG NUMBERFNS OPCOPY OPNIL OPPOP OPRETURN PRA 
SELECTQFMEMB SELECTVARTYPES STATAR STATMAX STATN SYSSPECVARS UNIQUE#ARRAY VCA VCONDITIONALS VREFFRA 
COUTFILE XVARFLG MERGEFRAMEFLG OPTIMIZATIONSOFF NOFREEVARSFNS EQCONSTFN NEWOPTFLG) (DECLARE: DONTCOPY 
(* for compiling compiler) EVAL@COMPILE (RECORDS CODELST) (PROP MACRO OASSOC) (RECORDS OP JUMP TAG VAR
) (RECORDS FRAME COMINFO COMP JD)) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (
ADDVARS (NLAMA) (NLAML OPT.INITHASH) (LAMA)))))
(PUTPROPS EVQ BYTEMACRO COMP.EVQ)
(PUTPROPS AND BYTEMACRO (APPLY* COMP.BOOL T))
(PUTPROPS OR BYTEMACRO (APPLY* COMP.BOOL NIL))
(PUTPROPS AC BYTEMACRO COMP.AC)
(PUTPROPS ASSEMBLE BYTEMACRO COMP.PUNT)
(PUTPROPS ASSEM BYTEMACRO COMP.PUNT)
(PUTPROPS FLOC BYTEMACRO COMP.PUNT)
(PUTPROPS FUNCTION BYTEMACRO COMP.FUNCTION)
(RPAQ? COMP.GENFN.NUM 0)
(RPAQ? COMP.GENFN.BUF (ALLOCSTRING 100))
(PUTPROPS COND BYTEMACRO COMP.COND)
(PUTPROPS SELECTQ BYTEMACRO COMP.SELECTQ)
(PUTPROPS PROGN BYTEMACRO COMP.PROGN)
(PUTPROPS PROG1 BYTEMACRO COMP.PROG1)
(PUTPROPS QUOTE BYTEMACRO COMP.QUOTE)
(PUTPROPS * BYTEMACRO COMP.COMMENT)
(PUTPROPS DECLARE BYTEMACRO COMP.DECLARE)
(RPAQQ MCROPS (CAR CDR CAAR CDAR CADR CDDR CAAAR CDAAR CADAR CDDAR CAADR CDADR CADDR CDDDR CAAAAR 
CDAAAR CADAAR CDDAAR CAADAR CDADAR CADDAR CDDDAR CAAADR CDAADR CADADR CDDADR CAADDR CDADDR CADDDR 
CDDDDR))
(PUTPROPS CAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAAAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDAAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDAAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAADAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDADAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADDAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDDAR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAAADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDAADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDADR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAADDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDADDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CADDDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CDDDDR BYTEMACRO COMP.CARCDR)
(PUTPROPS CAR CROPS (A))
(PUTPROPS CDR CROPS (D))
(PUTPROPS CAAR CROPS (A A))
(PUTPROPS CDAR CROPS (A D))
(PUTPROPS CADR CROPS (D A))
(PUTPROPS CDDR CROPS (D D))
(PUTPROPS CAAAR CROPS (A A A))
(PUTPROPS CDAAR CROPS (A A D))
(PUTPROPS CADAR CROPS (A D A))
(PUTPROPS CDDAR CROPS (A D D))
(PUTPROPS CAADR CROPS (D A A))
(PUTPROPS CDADR CROPS (D A D))
(PUTPROPS CADDR CROPS (D D A))
(PUTPROPS CDDDR CROPS (D D D))
(PUTPROPS CAAAAR CROPS (A A A A))
(PUTPROPS CDAAAR CROPS (A A A D))
(PUTPROPS CADAAR CROPS (A A D A))
(PUTPROPS CDDAAR CROPS (A A D D))
(PUTPROPS CAADAR CROPS (A D A A))
(PUTPROPS CDADAR CROPS (A D A D))
(PUTPROPS CADDAR CROPS (A D D A))
(PUTPROPS CDDDAR CROPS (A D D D))
(PUTPROPS CAAADR CROPS (D A A A))
(PUTPROPS CDAADR CROPS (D A A D))
(PUTPROPS CADADR CROPS (D A D A))
(PUTPROPS CDDADR CROPS (D A D D))
(PUTPROPS CAADDR CROPS (D D A A))
(PUTPROPS CDADDR CROPS (D D A D))
(PUTPROPS CADDDR CROPS (D D D A))
(PUTPROPS CDDDDR CROPS (D D D D))
(PUTPROPS NOT BYTEMACRO COMP.NOT)
(PUTPROPS NULL BYTEMACRO COMP.NOT)
(PUTPROPS SETQ BYTEMACRO COMP.SETQ)
(PUTPROPS SETN BYTEMACRO COMP.SETN)
(PUTPROPS PROG BYTEMACRO COMP.PROG)
(PUTPROPS GO BYTEMACRO COMP.GO)
(PUTPROPS RETURN BYTEMACRO COMP.RETURN)
(RPAQQ NUMBERFNS (ITIMES2 LOGOR2 LOGXOR2 LOGAND2 LLSH1 LRSH1 LLSH8 LRSH8 IPLUS ITIMES LOGOR LOGXOR 
LOGAND IDIFFERENCE IQUOTIENT IREMAINDER IMINUS LSH LLSH RSH LRSH FIX))
(RPAQQ GLOBALVARFLG T)
(RPAQQ NEWOPTFLG NIL)
(RPAQ COMPVERSION (DATE))
(PUTPROPS IPLUS BYTEMACRO (APPLY* COMP.NUMERIC IPLUS))
(PUTPROPS ITIMES BYTEMACRO (APPLY* COMP.NUMERIC ITIMES FIX 0))
(PUTPROPS LOGOR BYTEMACRO (APPLY* COMP.NUMERIC LOGOR FIX -1))
(PUTPROPS LOGXOR BYTEMACRO (APPLY* COMP.NUMERIC LOGXOR))
(PUTPROPS LOGAND BYTEMACRO (APPLY* COMP.NUMERIC LOGAND FIX 0))
(PUTPROPS IDIFFERENCE BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS IQUOTIENT BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS IREMAINDER BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS IMINUS BYTEMACRO ((X) (IDIFFERENCE 0 X)))
(PUTPROPS LSH BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS LLSH BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS RSH BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS LRSH BYTEMACRO COMP.NUMBERCALL)
(PUTPROPS FIX BYTEMACRO COMP.FIX)
(PUTPROPS PLUS BYTEMACRO (APPLY* COMP.NUMERIC PLUS PLUS))
(PUTPROPS DIFFERENCE BYTEMACRO (APPLY* COMP.NUMBERCALL PLUS))
(PUTPROPS TIMES BYTEMACRO (APPLY* COMP.NUMERIC TIMES PLUS 0))
(PUTPROPS QUOTIENT BYTEMACRO (APPLY* COMP.NUMBERCALL PLUS))
(PUTPROPS FPLUS BYTEMACRO (APPLY* COMP.NUMERIC FPLUS FLOAT))
(PUTPROPS FDIFFERENCE BYTEMACRO (APPLY* COMP.NUMBERCALL FLOAT))
(PUTPROPS FTIMES BYTEMACRO (APPLY* COMP.NUMERIC FTIMES FLOAT 0))
(PUTPROPS FQUOTIENT BYTEMACRO (APPLY* COMP.NUMBERCALL FLOAT ((FLOAT FQUOTIENT (OPCODES UBFLOAT2 4)))))
(PUTPROPS EQ BYTEMACRO COMP.EQ)
(PUTPROPS EQUAL BYTEMACRO COMP.EQ)
(PUTPROPS EQP BYTEMACRO COMP.EQ)
(PUTPROPS .TEST. BYTEMACRO (APPLY COMP.NUMBERTEST))
(RPAQQ MAPFNS (MAP MAPC MAPLIST MAPCAR MAPCON MAPCONC SUBSET SOME EVERY NOTANY NOTEVERY))
(PUTPROPS MAP BYTEMACRO (APPLY* COMP.MAP))
(PUTPROPS MAPC BYTEMACRO (APPLY* COMP.MAP T))
(PUTPROPS MAPLIST BYTEMACRO (APPLY* COMP.MAP NIL T))
(PUTPROPS MAPCAR BYTEMACRO (APPLY* COMP.MAP T T))
(PUTPROPS MAPCON BYTEMACRO (APPLY* COMP.MAP NIL J))
(PUTPROPS MAPCONC BYTEMACRO (APPLY* COMP.MAP T J))
(PUTPROPS SUBSET BYTEMACRO (APPLY* COMP.MAP T S))
(PUTPROPS SOME BYTEMACRO (APPLY* COMP.MAP BOTH NIL TJUMP))
(PUTPROPS EVERY BYTEMACRO (APPLY* COMP.MAP BOTH NIL FJUMP T))
(PUTPROPS NOTANY BYTEMACRO (APPLY* COMP.MAP BOTH NIL TJUMP T))
(PUTPROPS NOTEVERY BYTEMACRO (APPLY* COMP.MAP BOTH NIL FJUMP NIL))
(PUTPROPS .DOCOLLECT. BYTEMACRO ((VAL TAIL ITEM) (COND ((NOT TAIL) (SETQ TAIL (SETQ VAL (LIST ITEM))))
 (T (FRPLACD TAIL (SETQ TAIL (LIST ITEM)))))))
(PUTPROPS .DOJOIN. BYTEMACRO ((VAL TAIL ITEM) (AND (LISTP ITEM) (COND (TAIL (FRPLACD (SETQ TAIL (LAST 
TAIL)) ITEM)) (T (SETQ TAIL (SETQ VAL ITEM)))))))
(PUTPROPS LISPXWATCH BYTEMACRO T)
(PUTPROPS FETCHFIELD BYTEMACRO T)
(PUTPROPS REPLACEFIELD BYTEMACRO T)
(PUTPROPS FFETCHFIELD BYTEMACRO (= . FETCHFIELD))
(PUTPROPS FREPLACEFIELD BYTEMACRO (= . REPLACEFIELD))
(PUTPROPS REPLACEFIELDVAL BYTEMACRO T)
(PUTPROPS FREPLACEFIELDVAL BYTEMACRO (= . REPLACEFIELDVAL))
(PUTPROPS GETPROP BYTEMACRO (= . GETP))
(PUTPROPS BLKAPPLY BYTEMACRO (= . APPLY))
(PUTPROPS BLKAPPLY* BYTEMACRO (= . APPLY*))
(PUTPROPS ADD1VAR BYTEMACRO ((X) (SETQ X (ADD1 X))))
(PUTPROPS SUB1VAR BYTEMACRO ((X) (SETQ X (SUB1 X))))
(PUTPROPS KWOTE BYTEMACRO (OPENLAMBDA (Q) (COND ((AND Q (NEQ Q T) (NOT (NUMBERP Q))) (LIST (QUOTE 
QUOTE) Q)) (T Q))))
(PUTPROPS FRPLNODE BYTEMACRO (OPENLAMBDA (X A D) (FRPLACD (FRPLACA X A) D)))
(PUTPROPS RPLNODE BYTEMACRO (OPENLAMBDA (X A D) (RPLACD (RPLACA X A) D)))
(PUTPROPS LISTGET1 BYTEMACRO (OPENLAMBDA (X Y) (CADR (MEMB Y X))))
(PUTPROPS FRPLNODE2 BYTEMACRO (OPENLAMBDA (X Y) (FRPLACD (FRPLACA X (CAR Y)) (CDR Y))))
(PUTPROPS JSYS BYTEMACRO COMP.PUNT)
(PUTPROPS EQMEMB BYTEMACRO (OPENLAMBDA (X Y) (OR (EQ X Y) (AND (LISTP Y) (FMEMB X Y) T))))
(PUTPROPS MKLIST BYTEMACRO (OPENLAMBDA (X) (OR (LISTP X) (AND X (LIST X)))))
(RPAQQ COPS (BIND UNBIND DUNBIND ERRORSET JUMP TJUMP FJUMP NTJUMP NFJUMP POP COPY RETURN TAG FN CONST 
SETQ AVAR HVAR GVAR FVAR STORE))
(PUTPROPS BIND MLSYM ("BIND[" %] . BIND))
(PUTPROPS UNBIND MLSYM ("UNBIND(" %) . UNBIND))
(PUTPROPS DUNBIND MLSYM ("DUNBIND(" %) . UNBIND))
(PUTPROPS ERRORSET MLSYM ("ERRORSET " %
 . JUMP))
(PUTPROPS JUMP MLSYM ("JUMP " %
 . JUMP))
(PUTPROPS TJUMP MLSYM ("TJUMP " %
 . JUMP))
(PUTPROPS FJUMP MLSYM ("FJUMP " %
 . JUMP))
(PUTPROPS NTJUMP MLSYM ("NTJUMP " %
 . JUMP))
(PUTPROPS NFJUMP MLSYM ("NFJUMP " %
 . JUMP))
(PUTPROPS FN MLSYM (%[ %] . FN))
(PUTPROPS CONST MLSYM (' NIL . CONST))
(PUTPROPS SETQ MLSYM ("SETQ<" > . VREF))
(PUTPROPS AVAR MLSYM (< > . VAR))
(PUTPROPS HVAR MLSYM (< > . VAR))
(PUTPROPS GVAR MLSYM (< > . VAR))
(PUTPROPS FVAR MLSYM (< > . VAR))
(MOVD? (QUOTE NILL) (QUOTE REFRAME))
(AND (GETD (QUOTE OPT.COMPINIT)) (OPT.COMPINIT))
(PUTPROPS LOADTIMECONSTANT BYTEMACRO (= . DEFERREDCONSTANT))
(PUTPROPS FRPTQ BYTEMACRO OPT.CFRPTQ)
(PUTPROPS IMAX2 BYTEMACRO (OPENLAMBDA (X Y) (COND ((NOT (IGREATERP X Y)) Y) (T X))))
(PUTPROPS IMIN2 BYTEMACRO (OPENLAMBDA (X Y) (COND ((IGREATERP X Y) Y) (T X))))
(PUTPROPS AREF DMACRO COMP.AREF)
(PUTPROPS ASET DMACRO COMP.ASET)
(PUTPROPS FLOAT BOX (\FLOATBOX . \FLOATUNBOX))
(ADDTOVAR COMPILETYPELST)
(RPAQQ MERGEFRAMETYPES (PROG LAMBDA MAP))
(RPAQQ OPTIMIZATIONSOFF NIL)
(PUTPROPS BYTECOMPILER COPYRIGHT ("Xerox Corporation" 1981 1982 1983 1984))
NIL
