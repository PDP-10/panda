(FILECREATED " 9-NOV-83 02:59:10" ("compiled on " <LISPUSERS>DATABASEFNS.;2) (2 . 2) brecompiled 
exprs: DBFILE1 DBFILE2 DUMPDB LOADDB MAKEDB in WORK dated "26-SEP-83 00:54:17")
(FILECREATED " 9-NOV-83 02:58:48" <LISPUSERS>DATABASEFNS.;2 12680 changes to: (VARS DATABASEFNSCOMS) (
FNS DBFILE1 DBFILE2 DUMPDB LOADDB MAKEDB) previous date: "29-APR-81 20:27:35" 
<LISPUSERS>DATABASEFNS.;1)
(VIRGINFN (QUOTE LOAD) T)
(MOVD? (QUOTE LOAD) (QUOTE OLDLOAD))
(VIRGINFN (QUOTE LOADFROM) T)
(MOVD? (QUOTE LOADFROM) (QUOTE OLDLOADFROM))
(VIRGINFN (QUOTE MAKEFILE) T)
(MOVD? (QUOTE MAKEFILE) (QUOTE OLDMAKEFILE))

LOADDB BINARY
     w   N   p-.          N-.     HO   TZ   ,<   @ T   +  Z   ,<   ,< U,< V,<   @ V ` +  Z   Z XXB Zw,<?" X,<   Zw,<?,<8  , ,<   ,<   ,<   ,<   Zw~3B   +   [w~XBp  Zw~XBw~+   Zw}Z8  2B   +   ,< Y,<   $ Y,<w~,<   $ Y,<   " ZZ   +   ~Zw}Z8  3B   +   :,<w~,< Z$ [2B [+   !+   =2B \+   "+   Z   2B [+   ',<w~,< Z,< [& \3B   +   +   =2B \+   +,<w~,< Z,< \& \+   Z   3B   +   /,<w~[  +Z  D ]2B   +   =Z   ,<   ,< ],< ^,<w|,   F ^2B ]+   7,<w~,< Z,< [& \3B   +   +   =,<w~,< Z,< \& \+   ,<w~,< Z,< [& \3B   +   ,<w~,<   $ _,< _,<w~" _,   ,   Z  ,   XB  A,<   Z   D `XBw2B `+   ],<   Z  CD `XBw,<   Z  FD `XBw2B a+   ]Z   3B   +   V,<   ,<   ,<   Z  HD `XBp  2B   +   QZw+   U,<   Z   ,<  ,<   Z  MD `F a+   M/  +   [,<   ,<   Z  SD `2B   +   ZZp  +   Z+   V/   ,<   Z  WD `XBw-,   Z   Z  3B b+   aZw2B b+   xZw3B b+   c  bZ  J3B   +   f,<w~,<w$ cZ  -3B   +   i,<w~,<   ,<w& a  c,<w~,< d$ d[  ,<   Zp  -,   +   n+   wZp  ,<   ,<p  " e2B   +   t,<p  ,< e$ d3B   +   u,<p  " f/   [p  XBp  +   l/   +   ~,<   " Z,<w~,<   $ Y,< f,<   $ Y,<   " ZZ   XBw~Zw~/  ZwXB8 Z   ,~   3B   +  Z   +  Z gXB` D gZ` 3B   +    h,~   Z` ,~   +    Zw2B   +    _XBw+  ,<   ,< h$ iZ   2B  +  ,< h,<   ,< i,<   ,< j,<w}, jXBw,<w,< i$ i2B   +  ,<w" X,<   ,< k$ [Z  2B   +   Zp  3B   +  ,<w" k+  ,<w" lXBw3B   +   B lZw,   ,<   Zp  3B   +  $,<w,<   , %+    Z   +    ,< h,< Z,< i,<   ,< j,<w}, jB k,<   Zp  2B   +  ,Z   +    ,<   ,<w, B3B   +  0Zp  Zw,   +    ,<p  ,< h,< Z,< i,< m,< j,<w|, jB mD n,<   ,<   ,<   Zw-,   +  9+  @Z  XBp  ,<   ,<w}, B2B   +  =+  ?Zp  Zw~,   +  A[wXBw+  7Zw/  +    ,< n,<w,< _$ oXBw,   Z  B,   XB E,<w" oZp  ,<   ,<wZ  [D `Z  ,\  ,   2B   +    ,<w" pZ   +    )U B*};o&;7]2,B(
D9+(Tj Z0f)UI4`k(p0XHX@@            (FILE . 1)
(ASKFLAG . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 6)
(VARIABLE-VALUE-CELL RESETVARSLST . 396)
(VARIABLE-VALUE-CELL LOADDBFLG . 69)
(VARIABLE-VALUE-CELL MSFILETABLE . 204)
(VARIABLE-VALUE-CELL DWIMWAIT . 95)
(VARIABLE-VALUE-CELL FILERDTBL . 402)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 198)
(VARIABLE-VALUE-CELL MSARGTABLE . 163)
(VARIABLE-VALUE-CELL COMPILE.EXT . 282)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
NAMEFIELD
"no database file found for "
PRIN1
TERPRI
DATABASE
GETPROP
YES
NO
/PUT
TESTTABLE
Y
"load database for"
ASKUSER
LISPXPRINT
INPUT
READ
FNS
ARGS
STORETABLE
READATABASE
STOP
UPDATECONTAINS
UPDATEFILES
FILE
GETP
EXPRP
EXPR
MSMARKCHANGED
" is not a database file!"
ERROR
RESETRESTORE
ERROR!
EXTENSION
FILENAMEFIELD
VERSION
BODY
PACKFILENAME
FILEDATES
INFILEP
FINDFILE
FILEDATE
*
FILDIR
REMOVE
((PROGN (CLOSEF? OLDVALUE)) . 0)
OPENFILE
SKREAD
CLOSEF
(STREQUAL URET3 URET2 SKNLST SKLST BHC CONS CONSNL ALIST2 LIST2 KT CF KNIL BLKENT ENTER2)  L   B , X$   O P	   8 `   `        v 8 V   F p0  B    A   E    0    } @ z  > 0     (   hL H7 p. @+ x%   ( P  
 `   ~ @ q x d h \  W 
p S 
  N 	X M 	@ H h C P 7 x , p  @  (        (      
LOAD BINARY
            -.           ,<`  ,<` ,<` &  	XB`  Z` 3B  
+   ,<`  ,<   $  
Z`  ,~      (FILE . 1)
(LDFLG . 1)
(PRINTFLG . 1)
OLDLOAD
SYSLOAD
LOADDB
(KT ENTER3)    p      
LOADFROM BINARY
     	        	-.           ,<`  ,<` ,<` &  XB`  ,<   ,<   $  Z`  ,~      (FILE . 1)
(FNS . 1)
(LDFLG . 1)
OLDLOADFROM
LOADDB
(KT ENTER3)    X      
MAKEFILE BINARY
     
        
-.            ,<`  ,<` ,<` ,<` (  	XB`  ,<   ,<   $  	Z`  ,~   D   (FILE . 1)
(OPTIONS . 1)
(REPRINTFNS . 1)
(SOURCEFILE . 1)
OLDMAKEFILE
DUMPDB
(KT ENTER4)  `      

DUMPDB BINARY
        q   	-.         ( qZ`  3B   +   p-,   +   pB  t,<   ,<`  "  u,<   ,<   ,<   Zw2B   +   Z   3B   +   ,<w~[  	Z  D  u3B   +   Z   XB` +   Z` 3B   +   ,<w~,<  v$  v+   ,<   "  w,<`  ,<   $  w,<  x,<   $  w,<   "  wZ   +    ZwXBp  Z` 3B   +   #,<w~,<  v$  x3B  y+   #Z   3B  y+   #Z  3B   +   ,<w~[  Z  D  u3B   +   Z   3B   +   5,<p  ,<   Zw-,   +   ,Zp  Z   2B   +   * "  +   ,[  QD   "  +   4Zw,<   ,<p  "  y,<p  "  z/   3B   +   3ZwZp  ,   XBp  [wXBw+   &/  XBp  Z   ,<   @  z  +   iZ   ,<   ,<  |,<  |,<   @  } ` +   bZ   Z  ~XB ,<  ,<  ,<  v,<  ,<   ,<  Zw|,<8  , ,<   ,< ,< & Zw~XB?,   Z  8,   XB  E,< Zw~,<?" ,   ,   Z  F,   XB  J,< "  wZ  !3B   +   RZw~,<?~,<   ,<?~,< $  xZ  B F Z  #3B   +   VZw~,<?~,<?,<   & ,< ,<   $  wZw~,<?,<   $ ,<   "  wZw~Z8  3B   +   ^B +   `,< ,<   $  w,<   "  wZw~XB8 Z   ,~   3B   +   dZ   +   eZ XB` D Z` 3B   +   h  ,~   Z` ,~   Z` 3B   +   m,<w,<   $ +   o,<w~,<  v,<  y& 	Zw+    Z   ,~   d	
%S(lE!
$)U= dh#jSn         (FILE . 1)
(PROPFLG . 1)
(VARIABLE-VALUE-CELL MSFILETABLE . 153)
(VARIABLE-VALUE-CELL SAVEDBFLG . 59)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 165)
(VARIABLE-VALUE-CELL LISPXHIST . 107)
(VARIABLE-VALUE-CELL RESETVARSLST . 150)
NAMEFIELD
FILEFNSLST
TESTTABLE
DATABASE
/REMPROP
TERPRI
PRIN1
" has no functions."
GETPROP
YES
UPDATEFN
LOCALFNP
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
((PROGN (CLOSEF? OLDVALUE) (AND RESETSTATE (DELFILE OLDVALUE))) . 0)
EXTENSION
VERSION
BODY
PACKFILENAME
OUTPUT
NEW
OPENFILE
"(PROGN (PRIN1 %"Use LOADDB to load database files!
%" T) (ERROR!))
"
FILEDATES
PRINT
STORETABLE
UPDATECONTAINS
"FNS "
PRIN2
DUMPDATABASE
"STOP"
ERROR
RESETRESTORE
ERROR!
/PUT
(CONSNL CONS ALIST2 CF COLLCT BHC SKNLST URET4 KT SKLA KNIL ENTER2)   J    K p   	  F    =    3    5    x        l ( V x  P         q 0 g H c  _ P [   X 
@ N  ;  )  & P #     h  ( 	     0      

MAKEDB BINARY
     "        !-.          ,<`  "  XB`  ,<   ,<  B  F  3B   +   ,<`  ,<  $  Z  ,   2B   +   Z   Z  ,   2B   +   Z   3B   +   ,<`  [  Z  D  2B   +   ,<`  ,<  Z   ,<   ,<  ,<  &  2B  +   Z   +   Z   F  !,~   ue?p   (F . 1)
(VARIABLE-VALUE-CELL SAVEDBFLG . 19)
(VARIABLE-VALUE-CELL MSFILETABLE . 28)
(VARIABLE-VALUE-CELL DWIMWAIT . 35)
NAMEFIELD
FNS
FILECOMS
INFILECOMS?
DATABASE
GETPROP
((YES NO) . 0)
((YES NO) . 0)
TESTTABLE
N
"Do you want a Masterscope Database for this file? "
ASKUSER
Y
YES
NO
/PUT
(FMEMB KNIL KT ENTER1)         @ 	  `    @      
(PRETTYCOMPRINT DATABASEFNSCOMS)
(RPAQQ DATABASEFNSCOMS ((* Does automatic Masterscope database maintenance) (DECLARE: FIRST (P (
VIRGINFN (QUOTE LOAD) T) (MOVD? (QUOTE LOAD) (QUOTE OLDLOAD)) (VIRGINFN (QUOTE LOADFROM) T) (MOVD? (
QUOTE LOADFROM) (QUOTE OLDLOADFROM)) (VIRGINFN (QUOTE MAKEFILE) T) (MOVD? (QUOTE MAKEFILE) (QUOTE 
OLDMAKEFILE)))) (FNS DBFILE DBFILE1 DBFILE2 LOAD LOADFROM MAKEFILE) (ADDVARS (LINKEDFNS OLDLOAD)) (P (
RELINK (QUOTE MAKEFILES))) (FNS DUMPDB LOADDB MAKEDB) (PROP PROPTYPE DATABASE) (INITVARS (LOADDBFLG (
QUOTE ASK)) (SAVEDBFLG (QUOTE ASK))) (ADDVARS (MAKEFILEFORMS (MAKEDB FILE))) (* To permit MSHASH 
interface) (INITVARS (MSHASHFILENAME) (MSFILETABLE)) (LOCALVARS . T) (BLOCKS (LOADDB LOADDB DBFILE 
DBFILE1 DBFILE2 (NOLINKFNS . T))) (DECLARE: EVAL@COMPILE DONTCOPY (P (RESETSAVE DWIMIFYCOMPFLG T)))))
(ADDTOVAR LINKEDFNS OLDLOAD)
(RELINK (QUOTE MAKEFILES))
(PUTPROPS DATABASE PROPTYPE IGNORE)
(RPAQ? LOADDBFLG (QUOTE ASK))
(RPAQ? SAVEDBFLG (QUOTE ASK))
(ADDTOVAR MAKEFILEFORMS (MAKEDB FILE))
(RPAQ? MSHASHFILENAME)
(RPAQ? MSFILETABLE)
NIL
