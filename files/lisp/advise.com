(FILECREATED "15-Aug-84 23:23:58" ("compiled on " <NEWLISP>ADVISE..11) (2 . 2) brecompiled changes: UNADVISE READVISE in 
"INTERLISP-10  14-Aug-84 ..." dated "14-Aug-84 00:36:23")
(FILECREATED "14-Aug-84 19:27:31" {ERIS}<LISPCORE>SOURCES>ADVISE.;2 12446 changes to: (FNS UNADVISE READVISE) previous date: 
"21-NOV-78 23:21:05" {ERIS}<LISPCORE>SOURCES>ADVISE.;1)
ADVISE BINARY
       k   L   e-.          L@ O  ,~   Z   -,   +   B PXB  +   h[  Z  2B Q+   U[  [  Z  XB   Z  XB   -,   +    Z  	-,   +   Z  
,<  D Q,~   ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   @ R   +   Z  ,<   Z  ,<  ,<   & Q,~   Zp  ,   XBp  [wXBw+   Z  -,   +   2Z  ,<  ,<   Zw-,   +   )Zp  Z   2B   +   ' "  +   )[  QD   "  +    Zw,<   @ R   +   /Z  !,<   Z   ,<  ,<   & Q,~   Zp  ,   XBp  [wXBw+   #Z  ,,<  ,<   ,<   ,<   Zw~-,   +   7Zw+    Zw~,<   @ R   +   KZ  -,<   ,<   Zw-,   +   BZp  Z   2B   +   @ "  +   A[  QD   "  +    Zw,<   @ R   +   HZ  2,<   Z  :,<  ,<   & Q,~   Zp  ,   XBp  [wXBw+   ;XBp  -,   +   SZw3B   +   OZp  QD  +   PZp  XBw       [  2D   +   QXBw[w~XBw~+   5Z  
,<   ,<   Zw-,   +   ]Zp  Z   2B   +   [ "  +   \[  QD   "  +    Zw,<   @ R   +   eZ  D,<   Z   B S,<   Z   B S,<   Z   B SH S,~   Zp  ,   XBp  [wXBw+   VZ  c2B   +   qZ  `2B   +   l+   qZ  b2B   +   pZ  jXB  hZ TXB  m+   qXB  nZ   XB  lZ  U,<   ,< T$ UZ  qB UXB   2B   +   xZ  sZ V,   B V+  B W3B   +   }Z  v,<   ,< W$ X2B   +  Z  z,<   ,< WZ  tF XXB  EZ  },<  Z  ,<   [ Z  ,<   ,< Y[ [  XB [  3B   +  	Z YZ ,   +  	Z ,   ,<   ,< Z" SF ZXB 	,   D [+  [  ~[  Z  XB ,< [Z  ,<   ,<   Z   D \,   D \Z  oXB  _Z 2B   +  Z ,~   2B T+  [ [  Z  [  [  Z  [  [  XB +  42B ]+  ![ [  [  XB +  42B ]+  .[  [  Z  [  [  Z  B ^Z  XB "Z &3B ^+  (+  H[ &,<   ,< _[ (Z  ,   ,<   Z  pF ZD _+  >2B `+  H[ *Z  ,<   Z ,-,   +  3,   +  3B `D a+  >Z  q2B   +  ;Z 0,<  Z /       [  2D   +  8D a+  >Z 7,<  Z 6,<  ,<   ,<   ( bZ ,<   ,< bZ ,<  Z 4,<  Z <,<  ,   F cZ   3B   +  Z >,<  ,< b$ c+  ,< SZ @,<   ,< d,   B dZ   ,~   4` 
AE @@BA
A$@D (I@IAR]PGBB0C |H	<P        (VARIABLE-VALUE-CELL FN . 395)
(VARIABLE-VALUE-CELL WHEN . 401)
(VARIABLE-VALUE-CELL WHERE . 386)
(VARIABLE-VALUE-CELL WHAT . 388)
(VARIABLE-VALUE-CELL ADVISEDFNS . 292)
(VARIABLE-VALUE-CELL FILEPKGFLG . 392)
(NIL VARIABLE-VALUE-CELL X . 298)
(NIL VARIABLE-VALUE-CELL Y . 374)
(NIL VARIABLE-VALUE-CELL D . 284)
FNCHECK
IN
ADVISE1
(VARIABLE-VALUE-CELL Y . 0)
(VARIABLE-VALUE-CELL X . 0)
COPY
ADVISE
BEFORE
BROKEN
RESTORE
GETD
((NOT DEFINED) . 0)
HELP
EXPRP
ADVISED
GETP
SAVED
((DEF) . 0)
PROGN
((ADV-PROG (!VALUE) (ADV-SETQ !VALUE (ADV-PROG NIL (ADV-RETURN DEF))) (ADV-RETURN !VALUE)) . 0)
SUBPAIR
/PUTD
ADVISEDFNS
/DREMOVE
/SETATOMVAL
AFTER
AROUND
LAST
ADV-RETURN
((*) . 0)
/RPLACA
BIND
APPEND
/NCONC
/ATTACH
ADDRULE
ADVICE
/ADDPROP
MARKASCHANGED
?
ERROR
(LIST3 CONSS1 ALIST3 CONSNL CONS SKLST URET4 COLLCT KT URET2 SKNLST KNIL SKA ENTERF)  0D         3 @
   	     	H       p I     > x / H   X B       X P 6 H    L X: ` p }   v  m 8 j   Y 
p S 	` ? h < X 5 H & ` # @       ! X   H      

UNADVISE BINARY
        x    e    u-.        ( eZ   B  hXB  Z  2B   +   Z   ,   XB  +   Z  2B   +   Z  B  hXB  ,<  i,<   $  i,<  j,<   $  iZ  	,<   ,<   ,<   ,<   Zw~-,   +   Zw+    Zw~,<   @  j   +   [Z   B  k,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   @  j   +   XZ  ,<   ,<  k$  l,<   Z  ,<   ,<  l$  l,<   Z  !,<   ,<  m$  l,<   @  m ` ,~   Z   3B   +   8Z  $Z  ,   2B   +   8Z  )B  o2B   +   8Z  ,,<   ,<  oZ  *F  p2B   +   7Z  .,<   ,<  oZ   ,<  ,<   ,<   Z  oL  p2B   +   7Z  1XB  7Z  7,<   ,<  p$  q,<  qZ  8,<   Z   D  rD  i,<  iZ  :,<   Z  /D  rD  iZ   3B   +   DZ  @,<   [  A,<   ,<   &  rZ   3B   +   KZ   3B   +   KZ  =,<  ,<  mZ  BZ  D,   F  s,<  jZ  G,<   Z  IZ  I,   ,   Z   ,   D  iZ  K,<   ,<  k$  qZ  P,<   ,<  s$  t,<   Z  L3B   +   WZ  RB  t,\   ,~   Zp  ,   XBp  [wXBw+   XBp  -,   +   cZw3B   +   _Zp  QD  +   `Zp  XBw       [  2D   +   aXBw[w~XBw~+   "*h*Pc**!!cF I# &1 $H@      (VARIABLE-VALUE-CELL X . 25)
(VARIABLE-VALUE-CELL ADVISEDFNS . 125)
(VARIABLE-VALUE-CELL DWIMFLG . 80)
(VARIABLE-VALUE-CELL USERWORDS . 102)
(VARIABLE-VALUE-CELL BROKENFNS . 119)
(VARIABLE-VALUE-CELL ADVINFOLST . 157)
NLAMBDA.ARGS
REVERSE
ADVISEDFNS
/SETATOMVAL
ADVINFOLST
(VARIABLE-VALUE-CELL FN . 172)
PACK-IN-
ADVICE
GETP
ALIAS
READVICE
(VARIABLE-VALUE-CELL ADVICE . 154)
(VARIABLE-VALUE-CELL ALIAS . 169)
(VARIABLE-VALUE-CELL READVICE . 140)
FNTYP
70
FIXSPELL
BROKEN
/REMPROP
BROKENFNS
/DREMOVE
CHNGNM
/PUT
ADVISED
RESTORE
PUTD
(SKLST COLLCT CONSS1 CONS FMEMB URET2 URET4 SKNLST KNIL CONSNL KT ENTERF)  \    Y    O    P 	h K    +                0 ^ 
` G ` A p 5 P 1 ` ,     x  h  0         D  H      

READVISE BINARY
        K    C    I-.         C@  D  ,~   Z   2B   +   Z   B  E,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    ZwB  EZp  ,   XBp  [wXBw+   B  FXB  Z  2B   +   Z  B  E,~   Z   ,<   Z  ,<  ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   "ZwZ  Zp  ,   XBp  [wXBw+   /  D  FXB   ,<   D  GXB  #Z  ,<  ,<   ,<   ,<   Zw~-,   +   *Zw+    Zw~,<   @  G   +   9Z   B  H,<   ,<   Zw-,   +   5Zp  Z   2B   +   3 "  +   4[  QD   "  +    ZwB  HZp  ,   XBp  [wXBw+   .XBp  -,   +   AZw3B   +   =Zp  QD  +   >Zp  XBw       [  2D   +   ?XBw[w~XBw~+   '("A

@T $@D      (VARIABLE-VALUE-CELL X . 74)
(VARIABLE-VALUE-CELL ADVINFOLST . 44)
(VARIABLE-VALUE-CELL ADVISEDFNS . 42)
(NIL VARIABLE-VALUE-CELL SPLST . 73)
REVERSE
READVISE1
NLAMBDA.ARGS
APPEND
INTERSECTION
(VARIABLE-VALUE-CELL FN . 89)
PACK-IN-
READVISE0
(SKLST URET4 BHC KT COLLCT URET2 SKNLST KNIL ENTERF)   :    *    #        7      5 X     )      A @ 2  /   ' p  (    	  p        
READVISE0 BINARY
      /    &    .-.           &@  )  ,~   Z   ,<   ,<  )$  *2B   +   Z  ,<   ,<  *$  *XB   3B   +   Z  ,<  ,<  +$  *Z  ,   2B   +   Z  	Z   7   [  Z  Z  1H  +   2D   +   [  XB  3B   +   ,<   Z  D  +,~   Z   3B   +   $Z  B  ,2B   +   $Z  ,<   ,<  ,Z   F  -2B   +   "Z  ,<   ,<  ,Z   ,<  ,<   ,<   Z  ,L  -XB  3B   +   $XB  +   Z  #Z  -,   ,~   4dbDE%$P    (VARIABLE-VALUE-CELL FN . 73)
(VARIABLE-VALUE-CELL ADVINFOLST . 28)
(VARIABLE-VALUE-CELL DWIMFLG . 45)
(VARIABLE-VALUE-CELL SPLST . 55)
(VARIABLE-VALUE-CELL USERWORDS . 62)
(NIL VARIABLE-VALUE-CELL Y . 68)
READVICE
GETP
ADVICE
ALIAS
READVISE1
FNTYP
70
FIXSPELL
((- no advice saved) . 0)
(CONS KNIL ENTERF) h     #  ! X     (          
READVISE1 BINARY
      *        (-.          @  !  ,~   Z   2B   +   Z   XB  [  XB  Z  ,<   ,<  !Z  F  "Z  XB   3B   +   Z  	,<   [  D  "Z  ,<   ,<  #$  #Z  ,<   ,<  $$  $Z  ,<   ,<  %$  $,<  %Z  ,<   Z   D  &D  &[  	XB  ,<  'Z  Z  ,   D  '[  XB  3B   +   +   Z  3B   +   Z  B  (Z  ,~    (DfqHF(      (VARIABLE-VALUE-CELL LST . 52)
(VARIABLE-VALUE-CELL FN . 61)
(VARIABLE-VALUE-CELL ADVISEDFNS . 41)
(NIL VARIABLE-VALUE-CELL ALIAS . 59)
READVICE
/PUT
CHNGNM
ADVICE
/REMPROP
BROKEN
RESTORE
ADVISED
ADVISEDFNS
/DREMOVE
/SETATOMVAL
ADVISE
APPLY
RELINK
(CONS KNIL ENTERF)     X  0        
ADVISE1 BINARY
                -.          @    ,~   Z   ,<   Z   ,<  ,<   ,<   &  D  XB   -,   +   	Z  ,~   Z   3B   +   Z  ,<  Z   B  ,<   Z   B  ,<   Z   B  H  +   Z  ,<  Z  ,<  Z  ,<  Z  H  +   DN    (VARIABLE-VALUE-CELL X . 8)
(VARIABLE-VALUE-CELL Y . 6)
(VARIABLE-VALUE-CELL FLG . 19)
(VARIABLE-VALUE-CELL WHEN . 36)
(VARIABLE-VALUE-CELL WHERE . 38)
(VARIABLE-VALUE-CELL WHAT . 40)
(NIL VARIABLE-VALUE-CELL Z . 34)
FNCHECK
CHNGNM
COPY
ADVISE
(SKNA KT KNIL ENTERF)             `      
ADVISEDUMP BINARY
        <    3    :-.           3Z   ,<   ,<   ,<   ,<   Zw~-,   +   Zw+   ,Zw~,<   @  4   +   "Z   B  4,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   @  4   +   @  5  ,~   Z  	,<   ,<  5$  6XB   3B   +   Z  ,<  ,<  6,<  ,<  7$  6,<   Z  B  7,   F  8Z  ,~   Zp  ,   XBp  [wXBw+   XBp  -,   +   +Zw3B   +   'Zp  QD  +   (Zp  XBw       [  2D   +   (XBw[w~XBw~+   /  XB  ,<   ,<  6$  8Z   3B   +   2Z  9Z  -,   B  9,~   
*P,(L@     (VARIABLE-VALUE-CELL X . 98)
(VARIABLE-VALUE-CELL FLG . 94)
(VARIABLE-VALUE-CELL FN . 61)
PACK-IN-
(NIL VARIABLE-VALUE-CELL Y . 57)
ADVICE
GETP
READVICE
ALIAS
APPEND
PUT
MAKEDEFLIST
READVISE
PRINTDEF1
(CONS BHC SKLST COLLCT CONSS1 URET2 SKNLST KNIL ENTERF) (   X   @      h       H     0 ( %   `   H   8      
ADDRULE BINARY
      H    9    F-.            9@  ;  ,~   Z   -,   +   3B  <+   3B  <+   3B  =+   2B   +   Z   3B   +   Z   ,<  Z          [  2D   +   D  =Z  ,~   Z  ,<  Z  
,   D  >,~   3B  >+   2B  ?+   4Z  ,<  Z  D  =,~   [  2B   +   Z  XB  +   Z  3B   +   "Z  ,<  ,<  ?$  @XB   3B   +   4[  XB  Z  ,<  ,<   $  @,<  A,<   ,<   @  A ` +   .Z   Z  CXB Z  ,<   Z  C[  ,   ,<   ,<  DZ  (,<   Z  ,<   ,   ,   D  D+    ,<   Z  3B   +   1Z  &,<  D  >,\   3B   +   4Z  0,~   Z  *Z  E,   ,<   ,<   ,<   &  E   FZ   ,~   ?R@<"$d(D"    (VARIABLE-VALUE-CELL LST . 102)
(VARIABLE-VALUE-CELL NEW . 86)
(VARIABLE-VALUE-CELL WHERE . 104)
(VARIABLE-VALUE-CELL FLG . 93)
(NIL VARIABLE-VALUE-CELL X . 64)
(NIL VARIABLE-VALUE-CELL Y . 0)
LAST
BOTTOM
END
/ATTACH
/NCONC
FIRST
TOP
2
NLEFT
/RPLACD
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
LC
((BELOW ^) . 0)
EDITE
((not found) . 0)
PRINT
ERROR!
(KT ALIST3 LIST2 CONS CF CONSNL KNIL SKA ENTERF)   x 7    -    -    6    `   h     9 0 0 @ #    8  ` 
     H      
CADVICE BINARY
      %        $-.           Z   ,<   Zp  -,   +   +   Zp  ,<   @      +   Z   ,<   ,<   ,<  !&  !Z  ,<   ,<  ",<  "&  !,~   [p  XBp  +   /   Z  B  #Z  ,<   Zp  -,   +   +   Zp  ,<   @      +   Z  	,<   ,<  !,<   &  !Z  ,<   ,<  "$  #Z  ,<   ,<  ",<  "&  !,~   [p  XBp  +   /   Z  ,~   eqJ9N (VARIABLE-VALUE-CELL FNS . 61)
(VARIABLE-VALUE-CELL X . 51)
ADVISED
CADVISED
CHANGEPROP
EXPR
ORIGEXPR
COMPILE
REMPROP
(BHC SKNLST ENTERF)    p            
(PRETTYCOMPRINT ADVISECOMS)
(RPAQQ ADVISECOMS ((FNS * ADVISEFNS) (VARS (ADVISEDFNS) (ADVINFOLST)) (P (MAP2C (QUOTE (PROG SETQ RETURN)) (QUOTE (ADV-PROG ADV-SETQ
 ADV-RETURN)) (FUNCTION MOVD))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA READVISE UNADVISE) (
NLAML) (LAMA))) (BLOCKS * ADVISEBLOCKS)))
(RPAQQ ADVISEFNS (ADVISE ADVISE1 UNADVISE ADVISEDUMP READVISE READVISE0 READVISE1 ADDRULE CADVICE))
(RPAQQ ADVISEDFNS NIL)
(RPAQQ ADVINFOLST NIL)
(MAP2C (QUOTE (PROG SETQ RETURN)) (QUOTE (ADV-PROG ADV-SETQ ADV-RETURN)) (FUNCTION MOVD))
(RPAQQ ADVISEBLOCKS ((NIL ADVISE (GLOBALVARS ADVISEDFNS FILEPKGFLG)) (NIL UNADVISE (GLOBALVARS ADVISEDFNS BROKENFNS ADVINFOLST 
DWIMFLG USERWORDS)) (NIL READVISE READVISE0 READVISE1 (GLOBALVARS ADVINFOLST DWIMFLG USERWORDS ADVISEDFNS))))
(PUTPROPS ADVISE COPYRIGHT ("Xerox Corporation" T 1978 1984))
NIL
