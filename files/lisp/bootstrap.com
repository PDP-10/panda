(FILECREATED "12-Sep-84 23:34:33" ("compiled on " <NEWLISP>BOOTSTRAP..164) (2 . 2) brecompiled changes: FILECREATED in 
"INTERLISP-10  24-Aug-84 ..." dated "24-Aug-84 01:43:38")
(FILECREATED "12-AUG-84 19:37:39" <BLISP>BOOTSTRAP.;2 22523 changes to: (VARS BOOTSTRAPCOMS) (FNS FILECREATED) previous date: 
" 9-May-84 15:55:09" <BLISP>BOOTSTRAP.;1)
GETPROP BINARY
               -.           Z   -,   +   B  ,<  @     +   Z   -,   +   [  -,   +   Z   ,~   Z  Z   2B  +   [  Z  ,~   [  [  XB  +   ,~   Z   ,~   )       (VARIABLE-VALUE-CELL ATM . 3)
(VARIABLE-VALUE-CELL PROP . 20)
GETPROPLIST
(VARIABLE-VALUE-CELL PLIST . 28)
(KNIL SKNLST SKLST SKLA ENTERF)          p    0      
SETATOMVAL BINARY
                -.           ,<  	"  3B   +   Z   Z   ,   ,~   Z  ,<  Z  D  
,~    @  (VARIABLE-VALUE-CELL X . 11)
(VARIABLE-VALUE-CELL Y . 13)
VCTOAC
GETD
SETTOPVAL
(SET KNIL ENTERF)             
RPAQQ BINARY
             -.          Z   Z   ,   ,~       (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL Y . 4)
(SET ENTERF)  8      
RPAQ BINARY
            -.          Z   ,<  Z   B  D  ,~   @   (VARIABLE-VALUE-CELL RPAQX . 3)
(VARIABLE-VALUE-CELL RPAQY . 5)
EVAL
SETTOPVAL
(ENTERF)      
RPAQ? BINARY
             -.          Z   B  3B  	+   Z   ,~   Z  ,<  Z   B  D  
,~      (VARIABLE-VALUE-CELL RPAQX . 9)
(VARIABLE-VALUE-CELL RPAQY . 11)
GETTOPVAL
NOBIND
EVAL
SETTOPVAL
(KT ENTERF)   H      
MOVD BINARY
            -.          Z   B  2B   +   7   Z   ,<  @     ,~   Z  ,<  Z   3B   +   Z   B  B  +   Z  	B  D  Z   3B   +   Z  B  3B   +   Z  ,<  ,<  Z   F  Z  ,~   Y)@    (VARIABLE-VALUE-CELL FROM . 22)
(VARIABLE-VALUE-CELL TO . 37)
(VARIABLE-VALUE-CELL COPYFLG . 15)
(VARIABLE-VALUE-CELL FILEPKGFLG . 25)
GETD
(VARIABLE-VALUE-CELL NEWFLG . 35)
VIRGINFN
COPY
PUTD
EXPRP
FNS
MARKASCHANGED
(KT KNIL ENTERF)  H         8      
MOVD? BINARY
                -.          Z   B  3B   +   Z   ,~   Z   Z  ,<  Z   3B   +   Z   B  B  +   Z  B  D  Z   3B   +   Z  B  3B   +   Z  ,<  ,<  ,<   &  Z  ,~    ]JJ     (VARIABLE-VALUE-CELL FROM . 19)
(VARIABLE-VALUE-CELL TO . 34)
(VARIABLE-VALUE-CELL COPYFLG . 12)
(VARIABLE-VALUE-CELL FILEPKGFLG . 22)
GETD
VIRGINFN
COPY
PUTD
EXPRP
FNS
MARKASCHANGED
(KT KNIL ENTERF)       H   H        
SELECTQ BINARY
                -.          ,<  Z   ,<  ,<  $  	,<  [  D  ,<  ,<  &  
,~   K   (VARIABLE-VALUE-CELL SELCQ . 9)
PROGN
SELECTQ
EVAL
SELECTQ1
APPLY
(ENTERF)    
SELECTQ1 BINARY
             -.           @    ,~   Z   XB   [  XB  2B   +   Z  ,~   Z  XB  Z  Z   3B  +   Z  -,   +   Z  Z  
,   3B   +   [  ,~   ! (VARIABLE-VALUE-CELL M . 23)
(VARIABLE-VALUE-CELL L . 9)
(NIL VARIABLE-VALUE-CELL C . 28)
(FMEMB SKLST KNIL ENTERF)   X   8   `        
NCONC1 BINARY
            -.           Z   ,<  Z   Z  ,   Z   QD  D  ,~      (VARIABLE-VALUE-CELL LST . 6)
(VARIABLE-VALUE-CELL X . 5)
NCONC
(KNIL CONS ENTERF)  P    H      
PUTPROP BINARY
      «    %    *-.           %Z   2B   +   ,<  ¦,<  Z   ,<  ,   ,   B  '+   
-,   +   
,<  §,<  ,   B  'Z  B  (,<  @  ¨  ,~   Z   -,   +   2B   +   Z   3B   +   [  ,<  Z  ,<  Z   ,<  ,   ,\  QB  Z  ,~   [  -,   +   +   Z  Z  2B  +   [  Z  XD  +   Z  XB  [  [  XB  +   Z  
,<  Z  ,<  Z  ,<  B  (,   ,   D  ©+   2PR `    (VARIABLE-VALUE-CELL ATM . 63)
(VARIABLE-VALUE-CELL PROP . 65)
(VARIABLE-VALUE-CELL VAL . 67)
7
ERRORX
14
GETPROPLIST
(VARIABLE-VALUE-CELL X . 61)
(NIL VARIABLE-VALUE-CELL X0 . 58)
SETPROPLIST
(CONSS1 SKNLST SKNLA ALIST2 LIST2 KNIL ENTERF)  H $     h        h   P 
  `      0      
PUTPROPS BINARY
             -.          [   ,<  Zp  -,   +   Z   +    ,<  @     +   Z  ,<  Z   ,<  [  Z  F  ,~   [p  [  XBp  +   E (VARIABLE-VALUE-CELL X . 14)
(VARIABLE-VALUE-CELL Y . 18)
/PUT
(URET1 KNIL SKNLST ENTERF)                 
PROPNAMES BINARY
              -.           Z   B  ,<  @    ,~   Z` -,   +   Z` Z   2B   +   	 "  +   [  QD   "  ,~   Z` Z` ,   XB` [` [  XB` +   (  (VARIABLE-VALUE-CELL ATM . 3)
GETPROPLIST
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL MACROZ . 0)
(NIL VARIABLE-VALUE-CELL MACROW . 0)
(COLLCT KNIL SKNLST ENTERF)         x    `      
ADDPROP BINARY
      7    ¯    µ-.            ¯Z   2B   +   ,<  ±Z   ,<  Z   ,<  ,   ,   B  2+   -,   +   ,<  ²,<  ,   B  2Z  B  3,<  @  ³  ,~   Z   -,   +   2B   +   ¨Z   3B   +   ¨[  ,<  Z  ,<  Z  ,   XB  ,   ,\  QB  Z  ,~   [  -,   +   +   ¨Z  Z  2B  +   ¥[  ,<  Z   3B   +    Z  [  Z  ,   +   £[  Z  ,<  Z  ,   D  ´XB  ",\  XB  +   Z   XB  [  [  XB  ¥+   Z  ,<  Z  ,<  Z  £,   XB  ª,<  Z  ¨B  3,   ,   D  5+   Y() DA ` (VARIABLE-VALUE-CELL ATM . 89)
(VARIABLE-VALUE-CELL PROP . 83)
(VARIABLE-VALUE-CELL NEW . 87)
(VARIABLE-VALUE-CELL FLG . 57)
7
ERRORX
14
GETPROPLIST
(VARIABLE-VALUE-CELL X . 79)
(NIL VARIABLE-VALUE-CELL X0 . 76)
NCONC
SETPROPLIST
(CONSS1 CONS CONSNL SKNLST SKNLA ALIST2 LIST2 KNIL ENTERF) p ®         , 8      p      `       h   `           
REMPROP BINARY
                 -.           Z   -,   +   ,<  ,<  ,   B  Z  B  ,<  @    ,~   Z   -,   +   [  -,   +   Z   ,~   Z  Z   2B  +   Z  XB  Z   3B   +   [  [  [  QD  +   Z  ,<  [  [  D  [  [  XB  +   Z  XB  [  [  XB  +   A!  (VARIABLE-VALUE-CELL ATM . 38)
(VARIABLE-VALUE-CELL PROP . 28)
14
ERRORX
GETPROPLIST
(VARIABLE-VALUE-CELL X . 51)
(NIL VARIABLE-VALUE-CELL X0 . 48)
(NIL VARIABLE-VALUE-CELL VAL . 29)
SETPROPLIST
(KNIL SKNLST SKLST LIST2 SKNLA ENTERF)                         
NAMEFIELD BINARY
      0    §    ®-.           §@  ¨  ,~   ,<   ,<  *Z   ,<  Z   F  ª2B   +   ,<  +Z  ,<  Z  F  ª2B   +   ,<  «Z  ,<  Z  F  ªXB   2B   +   Zp  +      ."  ,   XB  +   /  ,<  ,Z  D  ªXB  3B   +      /"  ,   XB   Z  ,<  D  ¬2B  -+      /"  ,   XB  ,<  -Z  ,<  Z  F  ªXB  3B   +   £Z   2B   +   £   /"  ,   XB  Z  ,<  Z  ,<  Z  #F  ­B  .,~   EEDÐ)a	    (VARIABLE-VALUE-CELL FILE . 71)
(VARIABLE-VALUE-CELL SUFFIXFLG . 64)
(NIL VARIABLE-VALUE-CELL POS . 67)
(1 VARIABLE-VALUE-CELL START . 73)
(NIL VARIABLE-VALUE-CELL END . 75)
}
STRPOS
>
/
;
NTHCHAR
%.
SUBSTRING
MKATOM
(BHC MKN KNIL ENTERF)      £ @        X  (   @      

FILECREATED BINARY
             -.         Z   ,<  [  Z  ,<  Z  B  ,<  @   ` ,~   Z   ,<  Z  ,   D  XB  Z   3B   +   Z   ,<  ,<   $  Z   ,<  ,<   $  ,<   "  Z   3B   +   -,   +   B  ,<  ,<  Z  Z  ,   ,   F  Z   ,~   "4   (VARIABLE-VALUE-CELL X . 16)
(VARIABLE-VALUE-CELL FILECREATEDLST . 19)
(VARIABLE-VALUE-CELL PRETTYHEADER . 20)
FILECREATED1
(VARIABLE-VALUE-CELL FILEDATE . 41)
(VARIABLE-VALUE-CELL FILE . 42)
(VARIABLE-VALUE-CELL MESS . 23)
NCONC
LISPXPRIN1
LISPXTERPRI
ROOTFILENAME
FILEDATES
/PUT
(CONS SKLA KT KNIL CONSNL ENTERF)           x                   
FILECREATED1 BINARY
              -.          [   Z  ,<  @     ,~   Z   -,   +   ,~   -,   +   Z  ,~   Z   ,~   @  (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL PRETTYHEADER . 17)
(VARIABLE-VALUE-CELL FILE . 15)
(SKLST SKSTP ENTERF)    x    `      
DECLARE: BINARY
             -.          Z   ,<  ,<   $  ,~       (VARIABLE-VALUE-CELL X . 3)
DECLARE:1
(KT ENTERF)          
DECLARE:1 BINARY
              -.           Z   -,   +   Z   ,~   Z  -,   +   Z   3B   +   Z  Z  2B  +   Z  [  ,<  ,<   $  +   Z  	B  +   Z  3B  +   2B  +   Z   XB  +   2B  +   [  Z  B  XB  [  XB  +   2B  +   Z   XB  [  XB  +   	6ùHp@  (VARIABLE-VALUE-CELL X . 49)
(VARIABLE-VALUE-CELL EVALFLG . 47)
DECLARE:
DECLARE:1
EVAL
EVAL@LOAD
DOEVAL@LOAD
EVAL@LOADWHEN
DONTEVAL@LOAD
(KT SKLST KNIL SKNLST ENTERF)    8    X       @    0      
LOAD BINARY
      P   ù-.         `PZ   ,<  Z   ,<  Z   ,<  Z   ,<  @ ×  ,~   Z   ,<  @ Ù  ,~   Z   ,<  ,< [,< Û,<   @ \ ` +  ÈZ   Z ÝXB Z  ,<  Z  3B   +     ^+   Z   ,<  @ Þ @8+  GZ  Z   ,   2B   +   ¢Z   3B   +    Z  ,<  ,<   Z  ,<  ,<   ( cXB   3B   +    XB  Z  XB   +   ¢,< ãZ  D dXB   +   Z   ,<  ,< ä$ e3B   +   ¦Z  ¢B åZ  ¥,<  ,< ä,< f,<   Z   J æXB  ¦,< äB ä,   ,   Z  ,   XB  ¬  äXB  *Z   3B   +   ³,<   " gZ  ®,<  ,<   $ çZ  ¡2B h+   :Z   XB  Z   XB  Z   XB  Z   XB  Z   XB  Z  ¹3B   +   ÄZ èZ  :,   XB   3B   +   A[  =Z  Z$ÿXD  +   Ä,< èZ"ÿ,   ,<  ,<   Z  <H iZ  ·3B   +   NZ  ±B é3B   +   NZ  FB jXB  -,   +   LZ  I3B   +   N,<   ,<   $ êXB   Z  Í3B   +   R,<   Z   D kXB  ¾+   T,<   Z  PD ëXB  Q3B l+   V2B   +   ñZ  ³2B h+   aZ  H,<  [   D ìXB   ,<  Z   D m2B   +   ßZ  Ú,<  Z  Ù,   D íXB  ÜZ  ÝB n+   fZ  ¸3B   +   fZ  ×,<  ,<   Z   ,<  Z  ØH îZ  N3B   +   pZ  â,<  Z  f,<  Z  eF oZ   3B   +   pZ  ç,<  Z   D ïZ  l,<  Z  èD pZ  nB å,~   -,   +  B ð0B  +  Z  ÓB q,   A"  ¿,> Ï,>  Z  ÒB ñ.Bx  ,^  /  ."  [  1B  Ñ+  Z  tB q,   A"  ¿,> Ï,>  Z  wB ñ.Bx  ,^  /  ."  [  0B  Q+  Z  p,   /"  ,   XB  m,<   Z  þD k2B r+  Z  o3B   +  ©,<   Z D êXB   ,<  ,<   $ êZ ,<  Z D ê+  ©Z ,<  Z 
D ï,<   Z D ëB òXB  û+  %Z -,   +  B òXB +  %Z  ¶3B   +  Z B sZ 3B   +  Z ,   ,   XB Z B óZ 3B   +  %,<  Z ,<  Z ,   ,   Z ,   ,   D êZ   3B   +   NZ #,<  ,<   ,<   & t+   N,<   Z D k3B ô+  -2B u+  ´Z 3B   +  2Z -[  ,<  Z   ,   ,   D õZ ¦B vB öXB 2+  %3B w+  ¶2B ÷+  E,<   Z   ,   /"  ,   XB  D ï,<   Z *D ëZ ³,   XB »Z ®3B   +  ©,<  Z ¼Z  ,<  Z 9,<  Z   ,   ,   ,   ,   D ê+  ©,< x" dZ   ,~   XB   Z   ,~   3B   +  ÊZ   +  KZ dXB   D øZ K3B   +  Î  y,~   Z G,~     jÁJ	ÔTeA
 `Ê$HJ-1S)$#&J H!OH|A 4`            (VARIABLE-VALUE-CELL FILE . 323)
(VARIABLE-VALUE-CELL LDFLG . 172)
(VARIABLE-VALUE-CELL PRINTFLG . 330)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 137)
(VARIABLE-VALUE-CELL FILEPKGFLG . 194)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 303)
(VARIABLE-VALUE-CELL LISPXHIST . 135)
(VARIABLE-VALUE-CELL RESETVARSLST . 91)
(VARIABLE-VALUE-CELL LOADOPTIONS . 53)
(VARIABLE-VALUE-CELL DWIMFLG . 47)
(VARIABLE-VALUE-CELL LOADPARAMETERS . 82)
(VARIABLE-VALUE-CELL PRETTYHEADER . 94)
(VARIABLE-VALUE-CELL FILERDTBL . 373)
(VARIABLE-VALUE-CELL SYSFILES . 190)
(VARIABLE-VALUE-CELL UPDATEMAPFLG . 213)
(VARIABLE-VALUE-CELL DFNFLG . 107)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 0)
(VARIABLE-VALUE-CELL FILEPKGFLG . 0)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 0)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 413)
(NIL VARIABLE-VALUE-CELL RESETZ . 408)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
FILEPKGCHANGES
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(VARIABLE-VALUE-CELL PRLST . 200)
(NIL VARIABLE-VALUE-CELL FILEMAP . 317)
(NIL VARIABLE-VALUE-CELL FNADRLST . 378)
(NIL VARIABLE-VALUE-CELL ADR . 385)
(NIL VARIABLE-VALUE-CELL ROOTNAME . 191)
(NIL VARIABLE-VALUE-CELL TEM . 149)
(NIL VARIABLE-VALUE-CELL FILECREATEDLST . 211)
(NIL VARIABLE-VALUE-CELL LOADA . 382)
FIXSPELL
"unrecognized load option"
ERROR
INPUT
OPENP
CLOSEF
OLD
OPENFILE
LISPXTERPRI
LISPXPRINT
SYSLOAD
SIDE
LISPXPUT
RANDACCESSP
GETFILEMAP
TCONC
RATOM
READ
STOP
ROOTFILENAME
MEMB
NCONC
SMASHFILECOMS
ADDFILE
PUTFILEMAP
SETFILEPTR
UPDATEFILEMAP
NCHARS
CHCON1
GETREADTABLE
DEFINEQ
EVAL
ADDSPELL
LAPRD
PRINT
%)
%]
RPLACA
DREVERSE
DEFINE
%(
%[
"illegal argument in defineq"
RESETRESTORE
ERROR!
(CONSS1 MKN FGFPTR BHC IUNBOX SKLA SKLST ASZ CONS CONSNL ALIST2 KT FMEMB CF KNIL ENTERF)   HD P   8¹  £ X   C ± 0 H    z    ý `   (   ` Ê    t ( À   = H .    _ 0 -    ¬   È ¨ H 6 8 ± H   X        Í (É pÂ h;  · ® (¦    P  @ ç ( Ü 
` S 
 Ï 	X M 	@ H ` D h »   9   7  © X  0  x          
ROOTFILENAME BINARY
                -.           Z   ,<  Z   2B   +   7   Z   D  ,~   H   (VARIABLE-VALUE-CELL NAME . 3)
(VARIABLE-VALUE-CELL COMPFLG . 5)
NAMEFIELD
(KT KNIL ENTERF)   P    X        
MEMB BINARY
      
        -.           Z   -,   +   Z   ,~   Z   Z  2B  +   Z  ,~   [  XB  +     (VARIABLE-VALUE-CELL X . 8)
(VARIABLE-VALUE-CELL Y . 15)
(KNIL SKNLST ENTERF)   @    0      
(PRETTYCOMPRINT BOOTSTRAPCOMS)
(RPAQQ BOOTSTRAPCOMS ((FNS GETPROP SETATOMVAL RPAQQ RPAQ RPAQ? MOVD MOVD? SELECTQ SELECTQ1 NCONC1 PUTPROP PUTPROPS PROPNAMES ADDPROP
 REMPROP NAMEFIELD FILECREATED FILECREATED1 DECLARE: DECLARE:1 LOAD ROOTFILENAME MEMB) (P (MAPC (QUOTE ((PUTD . /PUTD) (PUTPROP . 
/PUTPROP) (PUTPROP . PUT) (PUT . /PUT) (PRIN1 . LISPXPRIN1) (PRIN2 . LISPXPRIN2) (PRINT . LISPXPRINT) (TERPRI . LISPXTERPRI) (SPACES
 . LISPXSPACES) (GETPROP . GETP) (SET . SAVESET) (NILL . MISSPELLED?))) (FUNCTION (LAMBDA (X) (OR (CCODEP (CDR X)) (MOVD (CAR X) (
CDR X)))))) (MAPC (QUOTE ((STRPOS (LAMBDA (X Y START SKIP ANCHOR TAIL) (COND ((LITATOM X) (SETQ X (CDR (VAG (IPLUS (LOC X) 2))))) ((
NULL (STRINGP X)) (SETQ X (MKSTRING X)))) (COND ((STRINGP Y)) ((LITATOM Y) (SETQ Y (CDR (VAG (IPLUS (LOC Y) 2))))) (T (SETQ Y (
MKSTRING Y)))) (COND (SKIP (SETQ SKIP (NTHCHAR SKIP 1)))) (COND (START (COND ((MINUSP START) (SETQ START (IPLUS START (NCHARS Y) 1))
))) (T (SETQ START 1))) (SETQ Y (SUBSTRING Y START)) (PROG ((N START) W X1 Y1) L2 (SETQ X1 (SUBSTRING X 1)) (SETQ Y1 (SUBSTRING Y 1)
) LP (COND ((SETQ W (GNC X1)) (COND ((EQ W (GNC Y1)) (GO LP)) ((EQ W SKIP) (GO LP)) (T (GO NX)))) (TAIL (RETURN (IPLUS (NCHARS X) N)
)) (T (RETURN N))) NX (COND (ANCHOR (RETURN))) (COND ((GNC Y) (SETQ N (ADD1 N)) (GO L2)) (T (RETURN)))))) (PACKFILENAME (LAMBDA (X) 
X)) (UNPACKFILENAME (LAMBDA (X) X)) (RESETRESTORE (LAMBDA (RESETVARSLST0 RESETSTATE) (PROG (RESETZ) LP (COND ((AND RESETVARSLST (NEQ
 RESETVARSLST RESETVARSLST0)) (SETQ RESETZ (CAR RESETVARSLST)) (SETQ RESETVARSLST (CDR RESETVARSLST)) (COND ((LISTP (CAR RESETZ)) (
APPLY (CAAR RESETZ) (CDR (CAR RESETZ))))) (GO LP)))))))) (FUNCTION (LAMBDA (X) (OR (GETD (CAR X)) (PUTD (CAR X) (CADR X))))))) (
INITVARS (EOLCHARCODE (CHCON1 (QUOTE %
))) (PRETTYHEADER) (DWIMFLG) (UPDATEMAPFLG) (DFNFLG) (ADDSPELLFLG) (BUILDMAPFLG) (FILEPKGFLG) (SYSFILES) (NOTCOMPILEDFILES) (
RESETVARSLST) (LOADPARAMETERS)) (VARS (FILERDTBL (OR (READTABLEP (EVALV (QUOTE FILERDTBL))) (COPYREADTABLE (QUOTE ORIG)))) (
LISPXHIST) (LISPXPRINTFLG T) (PRETTYHEADER "FILE CREATED ") (BELLS (QUOTE "")) (LOADOPTIONS (QUOTE (SYSLOAD NIL T PROP ALLPROP
)))) (GLOBALVARS FILEPKGFLG PRETTYHEADER DWIMFLG PRETTYHEADER UPDATEMAPFLG LOADOPTIONS LOADPARAMETERS FILERDTBL DFNFLG ADDSPELLFLG 
BUILDMAPFLG FILEPKGFLG SYSFILES) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA DECLARE: FILECREATED 
PUTPROPS SELECTQ) (NLAML RPAQ? RPAQ RPAQQ) (LAMA))) (P (PRINTLEVEL 1000) (RADIX 10) (SETSEPR (QUOTE (20 124)) 1 FILERDTBL))))
(MAPC (QUOTE ((PUTD . /PUTD) (PUTPROP . /PUTPROP) (PUTPROP . PUT) (PUT . /PUT) (PRIN1 . LISPXPRIN1) (PRIN2 . LISPXPRIN2) (PRINT . 
LISPXPRINT) (TERPRI . LISPXTERPRI) (SPACES . LISPXSPACES) (GETPROP . GETP) (SET . SAVESET) (NILL . MISSPELLED?))) (FUNCTION (LAMBDA 
(X) (OR (CCODEP (CDR X)) (MOVD (CAR X) (CDR X))))))
(MAPC (QUOTE ((STRPOS (LAMBDA (X Y START SKIP ANCHOR TAIL) (COND ((LITATOM X) (SETQ X (CDR (VAG (IPLUS (LOC X) 2))))) ((NULL (
STRINGP X)) (SETQ X (MKSTRING X)))) (COND ((STRINGP Y)) ((LITATOM Y) (SETQ Y (CDR (VAG (IPLUS (LOC Y) 2))))) (T (SETQ Y (MKSTRING Y)
))) (COND (SKIP (SETQ SKIP (NTHCHAR SKIP 1)))) (COND (START (COND ((MINUSP START) (SETQ START (IPLUS START (NCHARS Y) 1))))) (T (
SETQ START 1))) (SETQ Y (SUBSTRING Y START)) (PROG ((N START) W X1 Y1) L2 (SETQ X1 (SUBSTRING X 1)) (SETQ Y1 (SUBSTRING Y 1)) LP (
COND ((SETQ W (GNC X1)) (COND ((EQ W (GNC Y1)) (GO LP)) ((EQ W SKIP) (GO LP)) (T (GO NX)))) (TAIL (RETURN (IPLUS (NCHARS X) N))) (T 
(RETURN N))) NX (COND (ANCHOR (RETURN))) (COND ((GNC Y) (SETQ N (ADD1 N)) (GO L2)) (T (RETURN)))))) (PACKFILENAME (LAMBDA (X) X)) (
UNPACKFILENAME (LAMBDA (X) X)) (RESETRESTORE (LAMBDA (RESETVARSLST0 RESETSTATE) (PROG (RESETZ) LP (COND ((AND RESETVARSLST (NEQ 
RESETVARSLST RESETVARSLST0)) (SETQ RESETZ (CAR RESETVARSLST)) (SETQ RESETVARSLST (CDR RESETVARSLST)) (COND ((LISTP (CAR RESETZ)) (
APPLY (CAAR RESETZ) (CDR (CAR RESETZ))))) (GO LP)))))))) (FUNCTION (LAMBDA (X) (OR (GETD (CAR X)) (PUTD (CAR X) (CADR X))))))
(RPAQ? EOLCHARCODE (CHCON1 (QUOTE %
)))
(RPAQ? PRETTYHEADER)
(RPAQ? DWIMFLG)
(RPAQ? UPDATEMAPFLG)
(RPAQ? DFNFLG)
(RPAQ? ADDSPELLFLG)
(RPAQ? BUILDMAPFLG)
(RPAQ? FILEPKGFLG)
(RPAQ? SYSFILES)
(RPAQ? NOTCOMPILEDFILES)
(RPAQ? RESETVARSLST)
(RPAQ? LOADPARAMETERS)
(RPAQ FILERDTBL (OR (READTABLEP (EVALV (QUOTE FILERDTBL))) (COPYREADTABLE (QUOTE ORIG))))
(RPAQQ LISPXHIST NIL)
(RPAQQ LISPXPRINTFLG T)
(RPAQ PRETTYHEADER "FILE CREATED ")
(RPAQQ BELLS "")
(RPAQQ LOADOPTIONS (SYSLOAD NIL T PROP ALLPROP))
(PRINTLEVEL 1000)
(RADIX 10)
(SETSEPR (QUOTE (20 124)) 1 FILERDTBL)
(PUTPROPS BOOTSTRAP COPYRIGHT ("Xerox Corporation" 1983 1984))
NIL
   