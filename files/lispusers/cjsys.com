(FILECREATED "11-FEB-83 07:17:28" ("compiled on " <LISPUSERS>CJSYS.;65) (2 . 2) brecompiled exprs: 
nothing in WORK dated "10-FEB-83 22:52:39")
(FILECREATED "11-FEB-83 07:17:02" <LISPUSERS>CJSYS.;65 15159 changes to: (VARS CJSYSCOMS) previous 
date: "27-NOV-82 12:04:22" <LISPUSERS>CJSYS.;63)
CJSYS BINARY
       3      +-.          -.     (   @     +   L,< ,  L,<   ,  LZw[8  Z  3B   +   ,< Zw[8  Z  ,<   ,<   ,  oZ"   ,   XB` Zw[8  [  Z  3B   +   ,< Zw[8  [  Z  ,<   ,<` ,  o,<` Z"  ,   D XB` Zw[8  [  [  Z  3B   +   ,< Zw[8  [  [  Z  ,<   ,<` ,  o,< ZwZ8  B XB` [  Z  ,   ,<   ,  LZ   2B   +   *Z   2B   +   *Z   2B   +   *Z   3B   +   .Zw[8  [  [  [  Z  +   .Z   XB` [` [  Z  3B   +   <[` [  Z  ,   /"   4b  8,> ,>   ,< ,  L>`x  5   5/  Z` 2B   +   :Z +   ;Z ,<   ,  LZ` 2B   +   ?,< ,  L+   D1B   +   D3B   +   D,< ,< ,< ,<   ,   ,<   ,  LZ   B XB  DZ` 3B   +   K3B   +   K,< Z  E,<  ,   ,~   Z  I,~   +    ,<   Zw2B  +   m[w[  2B   +   mZ  KZ  2B  +   _Z  P[  Z  XBp  [  RXB  T[wZ  Zp  2B  +   X+   ^,< !,< ![w~Z  ,<   ,< ,< ",   ,   ,<   ,  LZ   +    2B +   mZ  U[  Z  [wZ  2B  +   mZ  `[  [  Z  2B +   mZ  Z  c[  [  [  ,   ,<   [  gXB  j,\   XBw/   +   LZwZ  j,   XB  m+   ^,<   Zw2B   +   rZ   +    ,<   , XBp  3B   +   x,< ",<   ,<w},   ,<   ,  L+    Zw-,   Z   Z  2B +  [wZ  -,   +  L,< #,< #,<w},< [w}Z  ,   ,   ,<   ,  L+    2B $+  [wZ  -,   +  ,< #,< #,<w},< [w}Z  ,   ,   ,<   ,  L,< $,<w~,< ,< %,   ,<   ,  L+    [wZ  XBw+  L2B %+  L[wZ  ,<   , XBp  3B   +  ,<w~[w~[  Z  ,<   ,<w~,  o,< &,<w~,< ,<w~,   ,<   ,  L+    Zw2B   +  .,<w~[w~[  Z  ,<   ,<   ,  o w~."   ,   ,<   [w~Z  ,<   Zw},   ,<   ,  o,< &,<w~,< ,< " w|."   ,   ,   ^,  ,   ,<   ,  L+    [w[  Z  ,<   , XBp  3B   +  =,<w~[w~Z  ,<   ,<w~,  o,< &,<w~,< ,<w},   ,<   ,  L,< ',<w~,<  w~A",   ,   ,<   ,  L+    ,<  ,<w~,   ,<   ,<w, \,   ,<   ,< [w~[  Z  ,<   ,<   ,  o,< ',  L,< [w~Z  ,<   ,<   ,  o,< (,  L,\   ,<   , y+    Zw2B   +  V,< (,<w~,   ,<   ,  LZw~1B   7   7   +    ,< ,<w~,< ,< ,   ,<   ,  L+    ,<   , \,<   ,<w~,<w~,<   ,  o,\   ,<   , y+    ,<   ,<   Zw2B   +  _Zw+    Z  nZ  3B #+  b2B )+  gZ _[  Z  XBp  Zw,   3B   +  r+  l2B "+  rZ b[  [  Z  XBp  Zw,   3B   +  rZ hZw,   XBw,<p  ,<w~$ )XBw[ lXB p+  ],<  Zw~,   ,<   ,  L,<  Zw~,   Zw,   XBw[wXBw+  ],<p  Zp  -,   +  |Z   +    Zp  ,<   ,  L[p  XBp  +  yZp  -,   +    -,   +  Zp  2B *+  [p  Z  B *+    2B %+  [p  Z  ,<   , ,<   Zp  3B   +  [w[  Z  ,<   , XBw3B   +  ,<p  D %+  Z   /   +    Z   +    Z   +       :IQtzxQ` L !L1P,:d8H@ @ H44
	CHbI	 x1@"0         (X . 1)
(VARIABLE-VALUE-CELL NCF . 73)
(VARIABLE-VALUE-CELL VCF . 76)
(VARIABLE-VALUE-CELL PIF . 79)
(VARIABLE-VALUE-CELL PCF . 82)
(VARIABLE-VALUE-CELL CODELST . 482)
(NIL VARIABLE-VALUE-CELL CODELST . 0)
NIL
NIL
NIL
ASSEMBLE
1
2
NCONC
3
JSYS
FINDJSYS
((JFCL) . 0)
((SKIPA 1 , KNIL) . 0)
((JFCL) . 0)
((MOVE 1 , KT) . 0)
MOVE
,
DREVERSE
LOC
PUSHN
POPN
NREF
MOVEM
0
LDN2
VAR
HRRZ
KNOWNSMALLP
SUBI
ASZ
XWD
HRLI
HRL
HRRI
((PUSHN 1) . 0)
((NREF (HRLM 1 , 0)) . 0)
CV
MOVEI
REMOVE
CONSTANT
EVAL
(SKNI SKNLST FMEMB URET3 CONSS1 ALIST MKN ALIST4 SKLA SKLST LIST3 URET4 CONS URET2 URET1 LIST2 LIST4 
KT BHC IUNBOX ALIST2 CONSNL ASZ KNIL BLKENT ENTER1)     {   l `          P   @+ @   H
    ` }        x   HW 0L `. X 8 y 0   xn p j   | x   "8 "   M   O x K   U   ` ] @     H X 9    P 8    4   v @
   ] @   @' p    Q    X   "0 " ! | Hf h] PZ (M E  " h ( u ( q  _ 
 M x A  / ( ) x & 0  H 	  h    (      
JS BINARY
      A    9    ?-.     (      9Z` 3B   +   ,<   ,<  <$  <+   Z  =,<   Z` 3B   +   	,<   ,<  <$  <+   
Z  =,<   Z` 3B   +   ,<   ,<  <$  <+   Z  >,<   ,<`  "  >,<   Z` 2B   +   '[p  Z  ,   ,>  9,>    w,>  9,>    w,>  9,>    w~,^  /   ,^  /    .  ,^  /    (  /.   /.   /.    "8  ,   ,>  9,>   [p  [  Z  2B   +   #^"   +   #,       ,^   /   3b  7   Z   +    Z` 2B   +   )^"   +   *,   ,>  9,>   [p  Z  ,   ,>  9,>    w,>  9,>    w,>  9,>    w~,^  /   ,^  /   ,^  /       +    +     x  Z` 3D   7  ?,   /  +       x^H	 
 *	     (JSYSNAME . 1)
(AC1 . 1)
(AC2 . 1)
(AC3 . 1)
(RESULT . 1)
INTERNAL
EVAL
-800572073
560383548
932972753
FINDJSYS
"garbage result from JS"
(MKN URET4 ASZ BHC IUNBOX KT KNIL ENTER5)     '        9 H 3 ( % @     P * @  @   p     7  &     x        
XWD BINARY
           
    -.           
 `  (B  	,>  	,>      
,>  	,>    ` ABx  ,^   /   GBx  ,^   /   ,   ,~        `   (N1 . 1)
(N2 . 1)
(MKN BHC ENTER2)   	    	  x      
JSYSERROR BINARY
            -.           ,<`  "  ,~       (ERRORNAME . 1)
FINDJSYSERROR
(ENTER1)    
BIT BINARY
             -.          .   .   Z8  0B   +   
   ,>  ,>   Z`  ,   "       ,^   /   (B  ,   ,~   Z` ,   ,>  ,>      ,>  ,>   Z`  ,   "       ,^   /   (B  ABx  ,^   /   1B   +   7   Z   ,~   @       p ,     (N . 1)
(KNIL KT MKN BHC IUNBOX ASZ CF CFARP ENTERN)   P   H       0     p   p    @    0    (      
BITS BINARY
            -.           ^"   ,>  ,>    ` ,>  ,>    `      ,^   /   /  ."       ,^   /   (B  /"   ,>  ,>    ` ,>  ,>    ` /"      ,^   /   (B  ABx  ,^   /   ,   ,~      @      (BIT1 . 1)
(BITN . 1)
(ARG . 1)
(MKN BHC ENTER3)        x 	  p      
PPOCTAL BINARY
      *        )-.          ,<  "   ,<   "  !,<   @  !  +   ,<  !Z   ,<   ,   ,   Z   ,   XB  XB` ,<  #,<  $,<   @  $ ` +   Z   Z  &XB Zw,<8  ,<   ,<   ,<   (  &Zw~XB8 Z   ,~   2B   +   Z  'XB   [` XB  	,<  !Z` Z  [  D  'Z  3B   +      (,~   Z` ,~   ,<  ("   Z   ,~   ,U`      (X . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 44)
%(
PRIN1
8
RADIX
(VARIABLE-VALUE-CELL OLDVALUE . 12)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 50)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
PRINTDEF
ERROR
APPLY
ERROR!
%)
(KT CF KNIL CONS CONSNL LIST2 ENTER1)       `   h  H       	               
CONSTANTP BINARY
              -.          Z`  2B   +   Z   ,~   3B   7   7   +   Z`  -,   +   Z`  -,   Z   Z  Z  ,   2B   +   Z`  Z   ,   ,~   B  (A . 1)
(VARIABLE-VALUE-CELL COMPILE.TIME.CONSTANTS . 24)
((CONSTANT QUOTE CHARCODE) . 0)
(FMEMB SKLST SKNNM KT KNIL ENTER1)   0       x    X   @   8 	  `        
FINDJSYS BINARY
               -.          Z`  -,   +   ,<   ,<   ,   ,~   Z`  Z   7   [  Z  Z  1H  +   
2D   +   2B   +   ,<`  ,<`  "  2B   +   ,<`  ,<  $  ,<   ,<  ,   Z  ,   XB  Z  ,~    
Jh     (JSYSNAME . 1)
(VARIABLE-VALUE-CELL JSYSES . 35)
SCANSYSTEMDEFS
((NOT JSYS NAME) . 0)
ERROR
3
(CONS LIST3 KNIL LIST2 SKI ENTER1)         X       P    0      
FINDJSYSERROR BINARY
             -.             ,>  ,>   Z`  Z   7   [  Z  Z  1H  +   2D   +   2B   +   ,<`  ,<`  ,<   $  2B   +   ,<`  "  ,   Z  ,   XB  Z  [  Z  ,   .Bx  ,^   /   ,   ,~          (T      (ERRORCODE . 1)
(VARIABLE-VALUE-CELL JSYSERRORCODES . 29)
SCANSYSTEMDEFS
ERROR
(MKN BHC IUNBOX CONS ALIST2 KT KNIL ENTER1)                                    
SCANSYSTEMDEFS BINARY
      b    M    _-.          MZ   ,<   @  P  ,~   Z   ,<   ,<  Q,<  R,<   @  R ` +   FZ   Z  TXB ,<   ,<   Z   ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   ,<p  ,<   $  TXBw~/   3B   +   Zp  +   [p  XBp  +   /   2B   +   ,<  UZ  
D  U,<  V,<w"  VB  WXBw,   ,<   ,<   ,   Z  ,   XB  ,<  W,<   $  X,<w,<   ,<   &  XZw~Z8 3B   +   %Z  Y+   &Z  Y,<   ,<   $  XZw~,<8  ,<   ,<   &  XZw~Z8 3B   +   -Z  Z+   -Z  Z,<   Zw},<8  ,<  [&  [,<   ,<w,<   ,<   ,<   ,<   ,  \3B   +   @Z"   XBp  ,<   ,<   ,<w~"  \XBp  -,   +   :Zw+   ? w$"  ,>  M,>    p  .Bx  ,^   /   ,   XBw+   6/  +   B,<  ],<   $  X,<   "  ]Zp  /  Zw~XB8 Z   ,~   3B   +   HZ   +   HZ  UXB` D  ^Z` 3B   +   L   ^,~   Z` ,~      (MXDy<0HTS         (NAME . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 61)
(VARIABLE-VALUE-CELL JSYSOURCES . 48)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
FINDFILE
"cannot find any of the files"
ERROR
CLOSEF?
INFILE
INPUT
"Scanning "
PRIN1
PRIN2
" for error "
" for JSYS "
"...QQQ ("
"
DEFJS "
","
CONCAT
FFILEPOS
READC
"... not found"
TERPRI
RESETRESTORE
ERROR!
(MKN SKNNM ASZ CONS LIST2 ALIST2 KT BHC SKNLST CF KNIL ENTER2)   ?    9    5                F 0 B 8 *  ' ( "      D  > p     P      	0 H p 7 h 4 0 2   , H  x  `  (        
(PRETTYCOMPRINT CJSYSCOMS)
(RPAQQ CJSYSCOMS ((FNS JS XWD JSYSERROR BIT BITS) (FNS CJSYS CJS1 JSC SAVEACS RESTOREACS CJSCONST 
PPOCTAL CONSTANTP) (ALISTS (JSYSES ASND ATPTY BIN BKJFN BOUT CFOBF CHFDB CLOSF CNDIR CVSKT DELDF DELF 
DELNF DIRST DOBE DTACH DTI FFFFP FFORK FFUFP FLIN FLOUT GDSKC GDSTS GET GETAB GEVEC GFRKH GJINF GNJFN 
GPJFN GTAD GTDAL GTFDB GTJFN GTSTS HALTF HFORK IDTIM IDTNC KFORK LGOUT MTOPR NIN NOUT ODCNV ODTIM 
OPENF PBIN PBOUT PMAP PUPI PUPO RELD RFACS RFBSZ RFCOC RFMOD RFORK RFPOS RFPTR RFSTS RIN RLJFN SDSTS 
SFACS SFBSZ SFCOC SFMOD SFORK SFPTR SIN SIZEF SOUT SPJFN STPAR SYSGT TLINK WFORK RTIW RCM EPCAP RIR 
DEBRK AIC STIW DIC RPACS RMAP GETJI) (PRETTYPRINTMACROS JSYS XWD JS)) (ADDVARS (JSYSERRORCODES)) (PROP
 VARTYPE JSYSES) (DECLARE: EVAL@COMPILE (MACROS JS BIT BITS JSYSERROR KNOWNSMALLP) (IFPROP (ARGNAMES 
AMAC) JS BIT BITS) (PROP AMAC CV CV2 NREF) (ADDVARS (SIMPLEFNS EQ PROGN PROG1 AND OR BIT BITS))) (FNS 
FINDJSYS FINDJSYSERROR SCANSYSTEMDEFS) (ADDVARS (JSYSOURCES <SUBSYS>STENEX.MAC <SUBSYS>MONSYM.MAC 
SYS:MONSYM.MAC)) (LOCALVARS . T) (BLOCKS (CJSYS CJSYS JSC CJS1 SAVEACS RESTOREACS (LOCALFREEVARS 
CODELST) CJSCONST (NOLINKFNS . T))) (TEMPLATES JS) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY 
COMPILERVARS (ADDVARS (NLAMA) (NLAML JSYSERROR JS) (LAMA BIT)))))
(ADDTOVAR JSYSES (ASND 56 1) (ATPTY 188 1) (BIN 40) (BKJFN 34 1) (BOUT 41) (CFOBF 65) (CHFDB 52) (
CLOSF 18 1) (CNDIR 36 1) (CVSKT 189 1) (DELDF 55) (DELF 22 1) (DELNF 207 1) (DIRST 33 1) (DOBE 68) (
DTACH 77) (DTI 96) (FFFFP 25) (FFORK 108) (FFUFP 137 1) (FLIN 154 1) (FLOUT 155 1) (GDSKC 140) (GDSTS 
101) (GET 128) (GETAB 8 1) (GEVEC 133) (GFRKH 116 1) (GJINF 11) (GNJFN 15 1) (GPJFN 134) (GTAD 151) (
GTDAL 197) (GTFDB 51) (GTJFN 16 1) (GTSTS 20) (HALTF 120) (HFORK 114) (IDTIM 145 1) (IDTNC 153 1) (
KFORK 107) (LGOUT 3) (MTOPR 63) (NIN 149 1) (NOUT 148 1) (ODCNV 146) (ODTIM 144) (OPENF 17 1) (PBIN 59
) (PBOUT 60) (PMAP 46) (PUPI 289 1) (PUPO 290 1) (RELD 57 1) (RFACS 113) (RFBSZ 37 1) (RFCOC 74) (
RFMOD 71) (RFORK 109) (RFPOS 73) (RFPTR 35 1) (RFSTS 110) (RIN 44) (RLJFN 19 1) (SDSTS 102) (SFACS 112
) (SFBSZ 38 1) (SFCOC 75) (SFMOD 72) (SFORK 111) (SFPTR 23 1) (SIN 42) (SIZEF 30 1) (SOUT 43) (SPJFN 
135) (STPAR 143) (SYSGT 14) (TLINK 142 1) (WFORK 115) (RTIW 123) (RCM 92) (EPCAP 105) (RIR 100) (DEBRK
 94) (AIC 89) (STIW 124) (DIC 91) (RPACS 47) (RMAP 49) (GETJI 327 3))
(ADDTOVAR PRETTYPRINTMACROS (JSYS . PPOCTAL) (XWD . PPOCTAL) (JS . PPOCTAL))
(ADDTOVAR JSYSERRORCODES)
(PUTPROPS JSYSES VARTYPE ALIST)
(DECLARE: EVAL@COMPILE (PUTPROPS JS 10MACRO (X (CJSYS X (FUNCTION ASSEMBLE)))) (PUTPROPS BIT MACRO (X 
(PROG ((MASK (LIST (QUOTE LRSH) -34359738368 (CAR X)))) (RETURN (COND ((CADR X) (LIST (QUOTE NEQ) (
LIST (QUOTE LOGAND) (CADR X) MASK) 0)) (T MASK)))))) (PUTPROPS BITS MACRO (X (PROG ((BIT1 (CAR X)) (
BITN (CADR X)) (WORD (CADDR X)) (MASK (QUOTE (SUB1 (LLSH 1 (ADD1 (IDIFFERENCE BITN BIT1)))))) (SHIFT (
QUOTE (IDIFFERENCE BITN 35)))) (COND ((CONSTANTP BITN) (SETQ SHIFT (EVAL SHIFT)) (COND ((CONSTANTP 
BIT1) (SETQ MASK (EVAL MASK)))))) (RETURN (SUBPAIR (QUOTE (BIT1 BITN)) (LIST BIT1 BITN) (LIST (QUOTE 
LOGAND) MASK (COND ((ZEROP SHIFT) WORD) (T (LIST (QUOTE LLSH) WORD SHIFT))))))))) (PUTPROPS JSYSERROR 
MACRO (X (FINDJSYSERROR (CAR X)))) (PUTPROPS KNOWNSMALLP 10MACRO ((X) X)))
(PUTPROPS JS ARGNAMES (JSYSNAME AC1 AC2 AC3 RESULT))
(PUTPROPS BIT ARGNAMES (BITN OPTIONALARG))
(PUTPROPS BITS ARGNAMES (BIT1 BITN ARG))
(PUTPROPS JS AMAC (LAMBDA (JSYSNAME) (LIST (LIST (QUOTE JSYS) (CADR (FINDJSYS JSYSNAME))))))
(PUTPROPS CV AMAC ((X) (CQ (VAG (FIX X)))))
(PUTPROPS CV2 AMAC ((X) (E (CNEXP2 (QUOTE (VAG (FIX X)))))))
(PUTPROPS NREF AMAC (NLAMBDA (I F) (SETQ F (LAST (SETQ I (COPY I)))) (RPLACA F (IDIFFERENCE (OR (CAR (
NTH NN (ADD1 (IMINUS (EVAL (CAR F)))))) (PROGN (COMPEM (QUOTE (BAD NREF))) (CAR NN))) (CAR NN))) (
RPLACD F (QUOTE ((CP)))) (STORIN I) NIL))
(ADDTOVAR SIMPLEFNS EQ PROGN PROG1 AND OR BIT BITS)
(ADDTOVAR JSYSOURCES <SUBSYS>STENEX.MAC <SUBSYS>MONSYM.MAC SYS:MONSYM.MAC)
(SETTEMPLATE (QUOTE JS) (QUOTE (TYPE .. EVAL)))
(PUTPROPS CJSYS COPYRIGHT ("Xerox Corporation" 1982 1983))
NIL
