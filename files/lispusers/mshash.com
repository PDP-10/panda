(FILECREATED "10-APR-82 14:08:06" ("compiled on " <LISPUSERS>MSHASH.;195) (2 . 2) recompiled exprs: 
UPDATEDB in "INTERLISP-MAXC " dated " 3-APR-82 00:43:41")
(FILECREATED "10-APR-82 14:07:45" <LISPUSERS>MSHASH.;195 39763 changes to: UPDATEDB previous date: 
"10-APR-82 10:44:16" <LISPUSERS>MSHASH.;193)
(MOVD? (QUOTE GETTABLE) (QUOTE OLDHASHGETTABLE))
(MOVD? (QUOTE MAKETABLE) (QUOTE OLDHASHMAKETABLE))
(MOVD? (QUOTE MAPTABLE) (QUOTE OLDHASHMAPTABLE))
(MOVD? (QUOTE TESTTABLE) (QUOTE OLDHASHTESTTABLE))
(MOVD? (QUOTE EQMEMBTABLE) (QUOTE OLDHASHEQMEMBTABLE))
(MOVD? (QUOTE STORETABLE) (QUOTE OLDHASHSTORETABLE))
(MOVD? (QUOTE PUTTABLE) (QUOTE OLDHASHPUTTABLE))
(MOVD? (QUOTE ADDTABLE) (QUOTE OLDHASHADDTABLE))
(MOVD? (QUOTE SUBTABLE) (QUOTE OLDHASHSUBTABLE))
HFGETTABLE BINARY
        C    :    A-.          :Z` -,   Z   Z  2B  <+   8,<`  [` [  Z  D  =,<   ,<   Zw3B   +   [` [  [  [  Z  3B   +   ,<` ,<`  $  =,<   Z   D  >XBp  3B   +   Z   ,<  ZwD  >Z  ,<   Z   D  ?XBp  +   Zw2B  ?+   Z   XBw[` [  [  [  Z  2B   +   Zw2B   +    Zp  +    ,<` "  @XB` Zw3B   +   %Zp  3B   +   %,<wD  @+   'Zw2B   +   'Zp  ,<   ,<   Zw-,   +   .Zp  Z   2B   +   , "  +   .[  QD   "  +   7Zw,<   ,<p  ,<`  ,<` ,<   (  A/   3B   +   5ZwZp  ,   XBp  [wXBw+   (/  +    ,<`  ,<` $  =,~   aI,	dQ!    (KEY . 1)
(TABLE . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 30)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 39)
(VARIABLE-VALUE-CELL FILERDTBL . 41)
HFTABLE
OLDHASHGETTABLE
MSKEY
GETHASHFILE
SETFILEPTR
READ
**BOGUSVALUE**
FORWARDTABLE
UNION
HFEQMEMBTABLE
(COLLCT BHC KT SKNLST URET2 KNIL SKLST ENTER2)   5    8 0            h   8 + 0 ( h #    H       8    0      
HFMAKETABLE BINARY
       ,         *-.            Z   3B   +   ,<   ,<   ,<`  "  $XBp  Z` ,<   ,<wZ` XBw~Z` 3B   +   
Z  $+   Z  %,<   ,<` $  %,<   Z   Z$   ,   ,<   Z  ,<   Z   3B   +   Z  &+   Z  &H  'XB   3B   +   Z  +   Z  2B   +      '+   ,<  ("  (B  ),<   ,<  )$  %,<   ,<w~,   Z  *,   /  ,~   ,<`  "  $,~   HrOl!      (N . 1)
(NAME . 1)
(INVFLG . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 30)
(VARIABLE-VALUE-CELL NEXTHASHKEY . 26)
(VARIABLE-VALUE-CELL MSREADONLYFLG . 44)
(VARIABLE-VALUE-CELL TEMP . 42)
OLDHASHMAKETABLE
"do!"
"by!"
CONCAT
RETRIEVE
((RETRIEVE INSERT) . 0)
LOOKUPHASHFILE
NEXTHASHKEY
"CAN'T SET UP READ-ONLY DATABASE FILE"
HELP
CHARACTER
!
HFTABLE
(BHC CONS21 LIST4 CONS ASZ KNIL ENTER3)                        P     @        
HFMAPTABLEA0004 BINARY
         	    -.          	,<` Z   D  XB`  3B   +   Z   ,<  ,<   ,<`  "  ,   ,~   Z   ,~       (VAL . 1)
(ITEM . 1)
(VARIABLE-VALUE-CELL TABLE . 4)
(VARIABLE-VALUE-CELL MFN . 9)
HFGETTABLE
(EVCC KNIL ENTER2)      	  H      
HFMAPTABLEA0005 BINARY
        
        	-.          Z`  3B  	7   7   +   Z   ,<   ,<`  ,<`  "  ,   ,~   @   (VAL . 1)
(ITEM . 1)
(VARIABLE-VALUE-CELL MFN . 8)
**BOGUSVALUE**
(EVCC KNIL KT ENTER2)                  
HFMAPTABLE BINARY
     6    ,    5-.          ,Z   -,   Z   Z  2B  .+   )[  [  Z  ,<   @  /  +   )[  [  [  [  Z  3B   +   Z   ,<   Z  0D  0+   Z  ,<   Z  1D  0Z  ,<   ,<  1$  2,<   Z   D  2XB` 3B   +   (Z   ,<  Z` D  3Z  ,<   Z   D  3,<   Zp  -,   +   +   'Zp  ,<   ,<   ,<wZ  D  42B   +   %,<wZ  D  4XBp  3B   +   %Z   ,<  ,<   ,<w~ "  ,   /  [p  XBp  +   /   Z   ,~   ,~   Z   ,<   Z  "D  0,~   a '
$ @  (VARIABLE-VALUE-CELL TABLE . 83)
(VARIABLE-VALUE-CELL MFN . 85)
(VARIABLE-VALUE-CELL MSHASHFILE . 37)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 46)
(VARIABLE-VALUE-CELL FILERDTBL . 48)
HFTABLE
(VARIABLE-VALUE-CELL HA . 59)
NIL
HFMAPTABLEA0004
OLDHASHMAPTABLE
HFMAPTABLEA0005
**ALLKEYS**
MSKEY
GETHASHFILE
SETFILEPTR
READ
OLDHASHTESTTABLE
HFGETTABLE
(BHC EVCC SKNLST KNIL SKLST ENTERF)    &    &        ) (  X  8            
HFTESTTABLE BINARY
    Q    F    O-.          FZ` -,   Z   Z  2B  I+   D,<   ,<   ,<   ,<`  [` [  Z  D  I3B   +   %[` [  [  [  Z  3B   +   ,<` "  JXBp  ,<`  [` [  Z  D  J,<   ,<   ,<   Zw-,   +   +   Z  XBp  ,<   ,<`  ,<w},<   (  K2B   +   +   Z   +   [wXBw+   +   Zw/  +   /  +   /+    ,<`  Z  K,<   [` [  Z  F  L2B   +   $7   Z   +    [` [  [  [  Z  2B   +   .,<` ,<`  $  L,<   ,<   Z   ,<   ,<   (  M+    ,<` "  JXBp  ,<` ,<`  $  L,<   Z  +D  MXBw3B   +    Z   ,<  ZwD  NZ  4,<   Z   D  N,<   ,<   ,<   Zw-,   +   ;+   CZ  XBp  ,<   ,<`  ,<w},<   (  K2B   +   @+   AZ   +   C[wXBw+   9Zw/  +    ,<`  ,<` $  I,~   `SB D@$     (KEY . 1)
(TABLE . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 99)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 108)
(VARIABLE-VALUE-CELL FILERDTBL . 110)
HFTABLE
OLDHASHTESTTABLE
FORWARDTABLE
OLDHASHGETTABLE
HFEQMEMBTABLE
**BOGUSVALUE**
OLDHASHEQMEMBTABLE
MSKEY
LOOKUPHASHFILE
GETHASHFILE
SETFILEPTR
READ
(URET3 BHC KT SKNLST KNIL SKLST ENTER2)   P 4 h &     H  `    ? P      0     @   9 @ - @ ) X $   (     `   8    0      
HFEQMEMBTABLE BINARY
     ,    $    +-.           $Z` -,   Z   Z  2B  '+   ![` [  [  [  Z  3B   +   ,<` Z`  XB` ,\   XB`  ,<` "  'XB` ,<`  [` [  Z  D  (3B   +   ,<`  ,<` [` [  Z  F  (,~   Z` 3B   +   Z   ,~   ,<` ,<`  $  ),<   Z   D  )XB`  3B   +    ,<` "  *,<   Z   ,<   Z`  ,<   [`  H  *3B   +    Z   ,~   Z   ,~   ,<`  ,<` ,<` &  (,~   `  PD(
     (KEY . 1)
(VALUE . 1)
(TABLE . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 47)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 55)
HFTABLE
FORWARDTABLE
OLDHASHTESTTABLE
OLDHASHEQMEMBTABLE
MSKEY
GETHASHFILE
MSVAL
FILEPOS
(KT KNIL SKLST ENTER4)       ! x  H               
HFSTORETABLE BINARY
        )    #    (-.           #[` Z  -,   Z   Z  2B  %+   !,<`  Z` 2B   +   Z  %,<   [` Z  [  [  Z  F  &[` [  3B   +   #[` [  -,   Z   Z  3B  %+      &[` [  [  [  Z  ,<   ,<` ,<   ,<   Zw2B   +   +   -,   +   XBp  Z   XBw+   ZwXBp  [wXBw,<p  ,<`  ,<w}&  '+   Zw/  Z   +    ,<`  ,<` ,<` &  ',~   1@D      (KEY . 1)
(TABLST . 1)
(VALUE . 1)
HFTABLE
**BOGUSVALUE**
OLDHASHPUTTABLE
SHOULDNT
OLDHASHADDTABLE
OLDHASHSTORETABLE
(URET1 BHC SKNLST KNIL SKLST ENTER3)  !             !    `  x   p       8      
HFPUTTABLE BINARY
                -.           Z` -,   Z   Z  2B  +   
,<`  Z` 2B   +   Z  ,<   [` [  Z  F  ,~   ,<`  Z` 2B   +   Z  ,<   ,<` &  ,~   c (KEY . 1)
(VALUE . 1)
(TABLE . 1)
HFTABLE
**BOGUSVALUE**
OLDHASHPUTTABLE
(KNIL SKLST ENTER3)   @   8    0      
HFADDTABLE BINARY
                -.           Z` -,   Z   Z  2B  	+      
,~   ,<`  ,<` ,<` &  
,~   p@  (KEY . 1)
(VALUE . 1)
(TABLE . 1)
HFTABLE
SHOULDNT
OLDHASHADDTABLE
(KNIL SKLST ENTER3)             
HFSUBTABLE BINARY
             -.           Z` -,   Z   Z  2B  	+      
,~   ,<`  ,<` ,<` &  
,~   p@  (KEY . 1)
(VALUE . 1)
(TABLE . 1)
HFTABLE
SHOULDNT
OLDHASHSUBTABLE
(KNIL SKLST ENTER3)             
LOCALFNP BINARY
               -.          ,<  ,<   ,<   Zw-,   +   +   Z  XBp  ,<`  ,<   Z   D  [  Z  XBw-,   Z   Z  2B  +   [w[  Z  XBw+   ZwD  3B   +   ,<`  Z  ,<   ,<w&  3B   +   +   Z   +    [wXBw+   Zw+    0 0U,   (FN . 1)
(VARIABLE-VALUE-CELL MSDATABASELST . 14)
((CALL REF NOBIND) . 0)
ASSOC
HFTABLE
OLDHASHTESTTABLE
**BOGUSVALUE**
OLDHASHEQMEMBTABLE
(URET3 KT SKLST SKNLST KNIL ENTER1)   `   X   (    H   @  0   0      
MSKEY BINARY
                -.          Z`  -,   Z   Z  3B  +      Z   ,<   ,<  [`  [  [  Z  F  Z  ,<   ,<  ,<` &  Z  	,<   ,<  ^"  ,>  ,>   ,<` "  ,   .Bx  ,^   /   ,   ,<   Z  H  ,~      r	%0    (TABLE . 1)
(KEY . 1)
(VARIABLE-VALUE-CELL MSHASHSCRATCHSTRING . 23)
HFTABLE
SHOULDNT
1
RPLSTRING
3
NCHARS
""
SUBSTRING
(MKN BHC IUNBOX KNIL SKLST ENTER2) (           8    0      
FORWARDTABLE BINARY
              -.          Z   ,<   ,<   ,<   Zw-,   +   +   Z  XBp  Zp  ,<   [`  Z  ,\  3B  +   
+   [p  Z  +    [wXBw+   [`  Z     Zw+     (TABLE . 1)
(VARIABLE-VALUE-CELL MSDATABASELST . 3)
HELP
(URET3 SKNLST KNIL ENTER1)    H    P    @        
MSVAL BINARY
             -.          Z   ,<   ,<  ,<  &  ,<   ,<  ,<   ,<`  ,<w,<   Z   H  XBp  2B   +   
+   Z  ,<   w."   ,   ,<   ,<w&   w."   ,   XBw+   Z  
,<    w."   ,   ,<   ,<  &  Z  ,<   ,<   w~."   ,   ,<   Z  H  +    P&C   (VAL . 1)
(VARIABLE-VALUE-CELL MSHASHSCRATCHSTRING . 41)
(VARIABLE-VALUE-CELL FILERDTBL . 14)
1
" "
RPLSTRING
NTHCHAR
" "
""
SUBSTRING
(URET3 MKN KT KNIL ENTER1)        8  P    x      P      
NEXTHASHKEY BINARY
               
-.           Z   ,<   ,<  	   ."   ,   XB  Z$   ,   ,<   Z   F  
,\   ,~    @  (VARIABLE-VALUE-CELL NEXTHASHKEY . 9)
(VARIABLE-VALUE-CELL MSHASHFILE . 13)
NEXTHASHKEY
PUTHASHFILE
(CONS ASZ MKN ENTER0)  h    `    P      
STOREHASHVALUE BINARY
    =    0    ;-.          0Z   ,<   ,<  3$  3,<` ,<`  $  4,<   Z` 3B   +   -Z  4,<   Z  ,       Z  5 D  ,<   Z` -,   +   ",<  5Z  D  6,<` ,<   ,<   ZwXBp  Zp  -,   +   3B   +   ,<  6Z  D  6,<p  Z  ,<   Z   F  7,<  7Z  D  6Zw+   Zp  ,<   Z  ,<   Z  F  7,<  8Z  D  6[p  XBp  +   /  ,<  8Z  D  6+   ',<  9Z   D  6,<` Z  ",<   Z  F  7,<  9Z  $D  6Z  &,       Z  : D      ,\   XCp  QEp  ,\   +   -Z   ,<   Z   F  :Z` ,~   B 4AR]@      (KEY . 1)
(VALUE . 1)
(TABLE . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 79)
(VARIABLE-VALUE-CELL FILERDTBL . 74)
(VARIABLE-VALUE-CELL MSHASHFILE . 92)
-1
SETFILEPTR
MSKEY
((NIL) . 0)
1000000
"( "
PRIN3
". "
PRIN4
" "
" "
")"
" "
" "
1000000
PUTHASHFILE
(BHC SKNLST SKLST FGFPTR KNIL ENTER3)               )    `      p      
GETHASHTABLE BINARY
              -.          ,<` ,<`  $  ,<   Z   D  XB`  3B   +   
Z   ,<  Z`  D  Z  ,<   Z   D  ,~   Z   ,~   $"  (KEY . 1)
(TABLE . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 7)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 16)
(VARIABLE-VALUE-CELL FILERDTBL . 18)
MSKEY
GETHASHFILE
SETFILEPTR
READ
(KNIL ENTER2)  8        
ANALYZEFILES BINARY
        n    [    k-.           [,<`  ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   Zw{2B   +   +   Z-,   +   XBw}Z   XBw{+   Zw{XBw}[w{XBw{Zw}-,   +   Zw}XBw~[w}XBw+   XBw~Z   XBw,<w~"  ^XBw~Z`  -,   Z   [  3B   +   ,<   "  _,<w~,<   $  _,<w~Z   D  `2B   +   "@  `  +   !Zw~,<?~"  aZw~XB?~,~   ,<w~"  ^XBw~,<w~,<  a$  bZ  XBwZ` 2B   +   ,Zw2B   +   ,,<  b"  c3B   +   ,[wB  b2B   +   M,<w~"  cXBp  Z   ,<  @  d  +   IZ   ,<   ,<  e,<  f,<   @  f ` +   BZ   Z  hXB Zw~Z?2B   +   8Z8  +   8,<   Zp  -,   +   ;Z   +   @Zp  ,<   ,<p  ,<   $  h/   [p  XBp  +   9/   Zw~XB8 Z   ,~   3B   +   DZ   +   EZ  iXB` D  iZ` 3B   +   H   j,~   Z` ,~   ,<w~,<w$  j,<w~Z   ,<   ,<w~&  kZ`  -,   Z   [  3B   +   Q,<   "  _[wXBw}Zw|3B   +   W,<   Zw|,   XBw|,\  QB  +   YZw},   XBw|XBw|+   Zw|/  ,~    4 !
%R	u(S*("i     (FILES . 1)
(EVENIFVALID . 1)
(VARIABLE-VALUE-CELL FILELST . 53)
(VARIABLE-VALUE-CELL LISPXHIST . 91)
(VARIABLE-VALUE-CELL RESETVARSLST . 96)
(VARIABLE-VALUE-CELL MSFILETABLE . 151)
NAMEFIELD
TERPRI
PRINT
MEMB
(NO VARIABLE-VALUE-CELL LOADDBFLG . 0)
LOADFROM
FILEDATES
GETPROP
LOADDB
GETD
FILEFNSLST
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
UPDATEFN
ERROR
RESETRESTORE
ERROR!
UPDATECONTAINS
STORETABLE
(CONSNL BHC CF KT SKLST SKNLST KNIL ENTER2)  V    [  ?    5    Q ( > x (    0   	p  p   ( 	    T 
 O x D 8 ; 0 ,   & H  h      h   X   H   8        
BUILDDB BINARY
        +    #    )-.          #Z`  2B   +   Z   XB`  2B   +   ,<  %"  %Z` 2B   +   	,<`  "  &   &XB` ,<`  ,<  '$  &,<` ,<   ,<   ,<   ,<   Zw~2B   +   +   -,   +   XBp  Z   XBw~+   Zw~XBp  [w~XBw~,<  ',<   ,<  (,<w~(  (XBwZw3B   +   ,<   Zw,   XBw~,\  QB  +   Zw,   XBwXBw~+   Zw~/  XB` ,<   ,<   $  ),<`  "  &,~   Y@4BQ
     (NAME . 1)
(FILES . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 6)
"No database file name"
ERROR
SETDB
MSFILES
CREATE
VERSION
BODY
PACKFILENAME
ANALYZEFILES
(KT BHC CONSNL SKNLST KNIL ENTER2)        `          `  p  X  H   P        
COPYDBA0006 BINARY
            -.          Z   ,<   ,<  $  [`  ,   0B   +   Z`  ,~   Z  ,<   Z  ,       Z   D  ,<   Z   ,<   Z  ,<  Z`  ,<   [`  H  Z  ,       Z   D      ,\   XCp  QEp  ,\   ,~   	 D     (VAL . 1)
(VARIABLE-VALUE-CELL NEWFILE . 29)
(VARIABLE-VALUE-CELL OLDFILE . 21)
-1
SETFILEPTR
((NIL) . 0)
1000000
COPYBYTES
1000000
(FGFPTR IUNBOX ENTER1)     	           
COPYDB BINARY
            -.          Z   3B   +   ,<  ,<   ,<  ,<  (  +   Z   B  XB  Z   3B   +   ,<  ,<   ,<  ,<  (  +   ,<  ,<   ,<  Z  H  B  XB  Z  ,<  ,<   Z  ,<   ,<   ,<` *  ,~   =za    (VARIABLE-VALUE-CELL OLDFILE . 31)
(VARIABLE-VALUE-CELL NEWFILE . 30)
(LEAVEOPEN . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 12)
BODY
EXTENSION
HASHDATABASE
PACKFILENAME
INFILEP
VERSION
OUTFILEP
COPYDBA0006
COPYHASHFILE
(KNIL ENTERF) 0          
FLUSHDBA0007 BINARY
                -.           Z   ,<   ,<   Z   D  ,<   Z  F  3B   +   	Z  Z   ,   XB  +   Z  Z   ,   XB  	Z  	,<   ,<   Z   F  ,~   J      (VARIABLE-VALUE-CELL VAL . 0)
(VARIABLE-VALUE-CELL ITEM . 22)
(VARIABLE-VALUE-CELL TABLE . 9)
(VARIABLE-VALUE-CELL KEYS . 16)
(VARIABLE-VALUE-CELL REMKEYS . 21)
(VARIABLE-VALUE-CELL LA . 25)
HFGETTABLE
STOREHASHVALUE
OLDHASHPUTTABLE
(CONS KNIL ENTERF) 0       h      
FLUSHDBA0008 BINARY
              -.           Z   2B  +   Z   XB  3B   +   Z   Z   ,   XB  +   	Z  Z   ,   XB  Z  ,<   Z  ,<  Z   D  D  2B   +   Z  
,<   Z  	,<  Z  F  Z  ,<   ,<   Z   F  ,~   @    (VARIABLE-VALUE-CELL VAL . 30)
(VARIABLE-VALUE-CELL ITEM . 34)
(VARIABLE-VALUE-CELL KEYS . 13)
(VARIABLE-VALUE-CELL REMKEYS . 18)
(VARIABLE-VALUE-CELL TABLE . 32)
(VARIABLE-VALUE-CELL LA . 37)
**BOGUSVALUE**
GETHASHTABLE
EQLST
STOREHASHVALUE
OLDHASHPUTTABLE
(CONS KNIL ENTERF)  	  p   0   P        
FLUSHDB BINARY
        O    ?    M-.          0 ?Z   3B   +   >Z   2B   +   >Z   ,<  @  B  0+   >Z`  -,   +   	+   =Z  XB   [  	[  XB   -,   Z   Z  2B  F+   Z   XB   Z   XB   [  [  Z  XB   ,<   Z  FD  GZ  2B   +   Z  3B   +   ,<  GZ  ,<   ,<  GZ  D  H,<   Z  D  HD  I,<   Z  F  I[  
Z  XB  -,   Z   Z  2B  F+   ;Z   XB  Z   XB  [  [  Z  XB  ,<   Z  JD  GZ  !2B   +   )Z  "3B   +   ;Z  #,<   ,<  G$  J,<   Z   D  KXB   3B   +   4Z  ,<  Z  -D  KZ  .,<   Z   D  LXB  /,<   Z  (D  H,<   Z  &D  IXB  5Z  2,<  D  L2B   +   ;,<  GZ  6,<   Z  )F  I[`  XB`  +   Z` ,~   ,~   Z   ,~   % 22L@`IID	        (VARIABLE-VALUE-CELL MSHASHFILENAME . 97)
(VARIABLE-VALUE-CELL MSREADONLYFLG . 6)
(VARIABLE-VALUE-CELL MSDATABASELST . 9)
(VARIABLE-VALUE-CELL REMKEYS . 103)
(VARIABLE-VALUE-CELL MSHASHFILE . 88)
(VARIABLE-VALUE-CELL FILERDTBL . 99)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 58)
(NIL VARIABLE-VALUE-CELL LA . 73)
(NIL VARIABLE-VALUE-CELL KEYS . 115)
(NIL VARIABLE-VALUE-CELL FILEV . 109)
(NIL VARIABLE-VALUE-CELL TABLE . 117)
HFTABLE
FLUSHDBA0007
OLDHASHMAPTABLE
**ALLKEYS**
GETHASHTABLE
LDIFFERENCE
UNION
STOREHASHVALUE
FLUSHDBA0008
MSKEY
GETHASHFILE
SETFILEPTR
READ
EQLST
(SKLST SKNLST KNIL ENTER0)    H      x 9 h )   #     h     P   0      
EQLST BINARY
                -.           ,<`  ,<   ,<   Zw-,   +   +   Z  XBp  Zp  Z` ,   3B   +   	+   
Z   +    [wXBw+   ,<` ,<   ,<   Zw-,   +   +   Z  XBp  Zp  Z`  ,   3B   +   +   Z   +   [wXBw+   Z   /  +    0 `i    (L1 . 1)
(L2 . 1)
(BHC KT URET3 FMEMB SKNLST KNIL ENTER2)  p   h   x 
         h      (  P 
    0      
HFGETARGS BINARY
            -.          Z   3B   +   ,<  ,<   ,<   @   ` +   Z   Z  XB Z  ZwZ8 7   [  Z  Z  1H  +   2D   +   	,<   Zw~,<8 "  2B   +   Z   D  Z   ,~   Z` ,~    *     (NAME . 1)
(DEF . 1)
(DATA . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 3)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ARG
ARGLIST
RPLACD
(KT CF KNIL ENTER3)            P   H        
MSFILECHECK BINARY
    F    <    D-.          <Z`  2B   +      =XB`  +   2B   +   Z   ,<  ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   ,<p  ,<  >$  >Z  [  /   Zp  ,   XBp  [wXBw+   /  B  ?XB`  ,<   ,<   ,<   ,<   ,<   ,<   Zw}2B   +   +   3-,   +   XBw~Z   XBw}+    Zw}XBw~[w}XBw},<  ?,<   ,<  @,<w}(  @B  AXBw3B   +   ,,<   ,<w~"  A,<   [   Z  D  B[  ,\  3B  +   3ZwZw,   XBw+   3,<w~"  A,<   [  &Z  D  B[  XBw~3B   +   3Zp  ,   XBp  +   Zp  3B   +   7B  BZ  C,   ,   ,<   Zw3B   +   ;B  BZ  C,   ,   D  D+    (" VHD"H   (FILES . 1)
(VARIABLE-VALUE-CELL FILELST . 11)
(VARIABLE-VALUE-CELL MSFILETABLE . 92)
MSFILES
FILEDATES
GETPROP
SORT
VERSION
BODY
PACKFILENAME
INFILEP
NAMEFIELD
GETTABLE
DREVERSE
DELETED
CHANGED
NCONC
(URET6 CONSNL CONS21 CONS COLLCT BHC SKNLST KNIL KT ENTER1)  <    ; x   0 7    3 @   0   X          5  $   (       ( 
  x            
MSFILESA0009 BINARY
                -.          [`  Z   ,   XB  ,~       (DATE . 1)
(FILE . 1)
(VARIABLE-VALUE-CELL VAL . 6)
(CONS ENTER2)    8      
MSFILES BINARY
      
        	-.           @    ,~   [   Z  ,<   Z  D  Z   B  	,~      (VARIABLE-VALUE-CELL MSFILETABLE . 6)
(NIL VARIABLE-VALUE-CELL VAL . 11)
MSFILESA0009
MAPTABLE
SORT
(ENTER0)      
RESTOREDB BINARY
    I    <    G-.          <,<`  "  >,<  >,<   ,<  ?,<`  (  ?B  @2B   +      @Z   ,~   ,<   ,<  A$  @XB`   ` ,>  ;,>   ,<`  ,<  A$  B,       ,^   /   3B  +   :,<` ,<   ,<   ,<   ,<   Zw~-,   +   +   3Z  XBwZw,<   [   Z  D  B[  XBp  [w2B  +   +   2Zw2B   +   !,<   "  C,<  C,<   $  D,<   "  CZ   XBw[w3B   +   .,<   "  C[w,<   ,<   $  D,<  E,<   $  DZp  3B   +   ,,<  E,<   $  D,<p  ,<   $  D+   2,<  F,<   $  D+   2,<   "  C,<p  ,<   $  D,<  F,<   $  D[w~XBw~+   Zw3B   +   9,<   "  C,<   "  C,<  G,<   $  D,<   "  CZw~/  Z   ,~      [L54vM5    (FILE . 1)
(WRITEDATE . 1)
(OLDFILES . 1)
(VARIABLE-VALUE-CELL MSFILETABLE . 45)
AFTERCLOSE
VERSION
BODY
PACKFILENAME
INFILEP
SETDB
RESTORE
IWRITEDATE
GETFILEINFO
GETTABLE
TERPRI
"***WARNING:  The database has been updated.  Information about files
             that you currently have loaded has changed:"
PRIN1
PRIN2
" has been "
"replaced by "
"deleted"
" has been added"
"You might want to LOADFROM or REANALYZE those files."
(KT SKNLST BHC IUNBOX KNIL ENTER3)   8 9  7 ` 2  / X +   ' X #    p         ; x   `   P ( (  0         @      
SETDBA0010 BINARY
                -.          ,<  ,<`  ,<`  ,<  $  ,<   Z   ,<   ,<   Zw-,   +   Zp  Z   2B   +   
 "  +   [  QD   "  +   Zw,<   ,<p  ,<w[   Z  D  [  ,   /   Zp  ,   XBp  [wXBw+   /  ,   ,~   @E    (FILE . 1)
(VARIABLE-VALUE-CELL FILELST . 9)
(VARIABLE-VALUE-CELL MSFILETABLE . 29)
RESTOREDB
IWRITEDATE
GETFILEINFO
HFGETTABLE
(ALIST4 COLLCT BHC CONSS1 SKNLST KNIL ENTER1) `   0   X             	         
SETDBA0011 BINARY
             -.          Z   XB   Z   XB   ,~       (F . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 4)
(VARIABLE-VALUE-CELL MSHASHFILE . 6)
(KNIL ENTER1)    (      
SETDB BINARY
        a    J    ^-.         8 JZ` 2B  N7   Z   ,<   ,<   Z   3B   +   B  O3B   +   Z` 3B  O+   	   PZ  B  PXBp  Z`  2B   +   Zp  3B   +   ',<   ,<` $  QXB  	+   '3B   +   ',<  Q,<   ,<  R,<  R(  SXB`  Zw3B   +   Z   2B   +   7   Z   XB` +   ,<  S"  TZ` 2B  T+    Z   XB` Z   XB   ,<`  ,<  U$  U+   !,<`  D  QXB  ,<  VD  VXB   3B   +   &Z  ",   ,   XB  $+   'Z"   XB  %Z  !3B   +   FZp  2B   +   3Z   ,<  Zp  -,   +   -+   3Zp  ,<   Zp  ,<   [wZ  D  W/   [p  XBp  +   +/   Z  'B  W,<   ,<  XZ  X,<   ,<  Y,<  Y,<  Z,<  Z,<  [Z  [R  \Z  3B  WXB   Z` 3B  \+   >2B   +   ?Z   +   ?Z   XB  Z`  3B   +   EZw2B   +   EZ   2B   +   E,<  ]"  TZ  ;+    Zp  3B   +    ,<  ]"  TZp  +    ]	8Hv,%?S($p`         (FILE . 1)
(MODE . 1)
(VARIABLE-VALUE-CELL MSHASHFILE . 116)
(VARIABLE-VALUE-CELL MSREADONLYFLG . 127)
(VARIABLE-VALUE-CELL MSDBEMPTY . 59)
(VARIABLE-VALUE-CELL NEXTHASHKEY . 78)
(VARIABLE-VALUE-CELL MSHFNS . 85)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 139)
(VARIABLE-VALUE-CELL MSDATABASELST . 134)
RESTORE
HASHFILEP
NOFLUSH
FLUSHDB
CLOSEHASHFILE
OPENHASHFILE
BODY
EXTENSION
HASHDATABASE
PACKFILENAME
((ERASE) . 0)
%.
CREATE
2NUMBERS
CREATEHASHFILE
NEXTHASHKEY
GETHASHFILE
MOVD
HASHFILENAME
STATUS
SETDBA0010
CLOSEALL
NO
EOF
NILL
AFTER
SETDBA0011
WHENCLOSE
INPUT
((WHO CALLS FUM) . 0)
((ERASE) . 0)
(URET2 BHC SKNLST ASZ MKN IUNBOX KT KNIL ENTER2)   J 	 G    4     P   x   `   X    ? `     @   	  D 0 @ ` *  $   `  `   `   8      
UPDATECONTAINS BINARY
    4    +    2-.          +,<  -Z   D  -,<   @  .  ,~   Zw,<8  [`  Z  D  /XB` ZwZ8 2B   +   ,<` ,<8 $  0XB   3B   +   ,<  0"  1,<` Zp  -,   +   +   'Zp  ,<   Zp  Zw~Z8 ,   2B   +   %,<p  [`  [  D  /,<   ,<   ,<   Zw2B   +   +   $-,   +   XBp  Z   XBw+   ZwXBp  [wXBw,<p  ,<`  ,<w},<w~[`  Z  D  /D  1F  2+   Zw/  /   [p  XBp  +   /   Zw,<8  ,<`  ,<8 &  2Z   ,~   @B' h@   (FILE . 1)
(NEWFNS . 1)
(KEEPFLG . 1)
(VARIABLE-VALUE-CELL MSDATABASELST . 4)
CONTAINS
ASSOC
(0 . 1)
(NIL VARIABLE-VALUE-CELL UPDATEFNS . 23)
NIL
GETTABLE
LDIFFERENCE
((ERASE IN UPDATEFNS) . 0)
%.
REMOVE
STORETABLE
(BHC FMEMB SKNLST KNIL ENTER3)   & X   @   0     + H    H         

UPDATEDB BINARY
       _   ,   V-.          (,Z   2B   +   ,< 0" 1Z   ,<   @ 1  ,~   Z   ,<   ,< 3,< 3,<   @ 4 ` +  $Z   Z 5XB Z   ,   ,<   Z  ,<   ,<   ,<   ,<   ,<   ,<   ,< 6Zw|,   Z  ,   XB  ,<w},< 6,<w|,< 6$ 7,<   ,< 7,< 8,< 8,< 9,< 9,< :0 :XBw},<   ,< ;,< ;& <B <D =Z  XBw}Z =6@   Z >2B >+   $,< >,<   ,< ?,<w|( :XBw~,<   ,<   ,< ?Zw{,<   ,<w|,< @$ @XBw,\  2B  +   ++   <,< A" AZp  3B   +   <0B  +   :,<   " B,<w,< B$ C,<   ,<   $ C,< D,<   $ C,<   " B,< D,<   $ C,<   " B,<   " BZ   XBp  +   < p  ."   ,   XBp  +   &Zw/  Zw{Z8 2B   +   A,<   " EXBw~,< E  F,   Z  ,   XB  BZw{Z8  -,   +   HXBwZ   Zw{XB8  Z FZw~7   [  Z  Z  1H  +   M2D   +   I[  ,<   Zw{Z8  -,   3B   7    ,   D GZw{XB8  ,<   ,<   Zw-,   +   ZZp  Z   2B   +   X "  +   Y[  QD   "  +   qZw,<   Zwz,<8 ,<w" G,<   ,<   ,<   Zw~-,   +   `+   iZ  XBp  Zw,<   ,<w" G,\  2B  +   hZp  2B   +   gZ   XBw+   i[w~XBw~+   ^Zw/  2B   +   l7   Z   /   3B   +   pZwZp  ,   XBp  [wXBw+   S/  Zw{XB8  B HXBp   p  1b   +   ,<   " B,<p  ,<   $ C,< H,<   $ C,< I,<   ,<   & I,< I,< JZwz,<8  ,<   ,<   ,<   , JZw{Z8 3B   +  ,< K" K2B   +  ,< L" L,<w},<w|$ K,<w},< M$ M+  
,<w},<w|,<   & N,<w},<   $ FZw{,<8 ,<   ,<   Zw2B   +  +  -,   +  XBp  Z   XBw+  ZwXBp  [wXBw,<p  " GXBp  B N,<p  Z   ,<   ,<   & O+  Zw/  Z OZw~7   [  Z  Z  1H  +  2D   +  [  ,<   ,<   ,<   ,<   Zw~-,   +  $+  CZ  XBwB GXBp  Zwy,<8 ,<   ,<   Zw2B   +  *+  4-,   +  -XBwZ   XBw+  /ZwXBw[wXBwZw~,<   ,<w" G,\  2B  +  4Z   XBp  +  4+  (Zp  /  3B   +  AZ   ,<   ,< P,< >,<   ,< ?,<w}( :,<   ,< P,   F Q3B P+  >+  A,<p  " N,<p  Z ,<   ,<   & O[w~XBw~+  "Zw/  Zw2B   +  FZp  ,<   Zw{,<8  ,<   ,<   ,<   ,<   Z"   XBp  Zw~-,   +  L+  `Z  XBw p  ,> +,>    w}    ,^   /   3b  +  R+  `,<   " B,<   " B,<w,<   $ Q,<w" RB RXBw3B   +  [Zw|,   XBw|+  \,<w,<   $ S[w~XBw~ p  ."   ,   XBp  +  JZw~/    F,<w},< >,<   ,< ?,<w{( :D SXBw}3B   +  ,<w},< >$ 7,<   ,< >,<   ,< ?,<w{( :,<   ,<   ,<   ,<w,< @$ @XBp  3B   +  x w~,> +,>   ,<p  ,< >$ 7,       ,^   /   3"  +  x,<p  " T2B   +  x+  x+  lZw/  ,<wZp  -,   +  |+  Zp  ,<   ,<p  ,< >$ 7,<   ,< >,<   ,< ?,<w~( :,<   ,<   ,<   ,<w,< @$ @XBp  3B   +   w~,> +,>   ,<p  ,< >$ 7,       ,^   /   3"  +  ,<p  " T2B   +  +  +  Zw/  [p  XBp  +  z/   Zw3B   +  ! p  ,> +,>    w    ,^   /   3b  +  !,<   " B p  ,> +,>    w    ,^   /   /  ,   ,<   ,<   $ C,< T,<   $ C,<   " BZw}/  Zw~XB8 Z   ,~   3B   +  &Z   +  'Z 1XB` D UZ` 3B   +  *  U,~   Z` ,~      H5 osrzce,kTB0@P(IEn.D
@P h@$Dj^B! K" %,Z!J0+A(2L
a
PP&            (ADDFILES . 1)
(DELETEFILES . 1)
(ADDONLY . 1)
(NOGCFLG . 1)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 27)
(VARIABLE-VALUE-CELL LISPXHIST . 8)
(VARIABLE-VALUE-CELL RESETVARSLST . 135)
(VARIABLE-VALUE-CELL MSFILETABLE . 383)
(VARIABLE-VALUE-CELL DWIMWAIT . 365)
"No current hash-database file"
ERROR
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
((PROGN (CLOSEF? (CAR OLDVALUE)) (AND RESETSTATE (DELFILE (CAR OLDVALUE)))) . 0)
DIRECTORY
FILENAMEFIELD
NAME
NEWHASHDATABASE
EXTENSION
SCRATCH
TEMPORARY
S
PACKFILENAME
OUTPUT
NEW
OPENFILE
CLOSEF
RPLACA
TENEX
TOPS20
VERSION
BODY
1
OLDEST
FULLNAME
2000
DISMISS
TERPRI
AUTHOR
GETFILEINFO
PRIN1
" seems to be updating the database right now."
"I'm waiting for him to finish."
MSFILECHECK
((PROGN (SETDB (PACKFILENAME (QUOTE VERSION) NIL (QUOTE BODY) OLDVALUE))) . 0)
SETDB
CHANGED
NCONC
NAMEFIELD
LENGTH
" files to be updated:"
5
TAB
0
PRINTPARA
COPYFILE
GETD
(((SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) COPYFILE) . 0)
FILESLOAD
BOTH
OPENHASHFILE
COPYDB
UPDATECONTAINS
STORETABLE
DELETED
Y
"no longer exists.  Shall I remove it from the database"
ASKUSER
PRINT
FINDFILE
LOADDB
ANALYZEFILES
RENAMEFILE
DELFILE
" files still to be updated."
RESETRESTORE
ERROR!
(IUNBOX LIST2 COLLCT SKNLST SKLST SKI BHC MKN KT ASZ KL20FLG CONS ALIST2 CONSNL CF KNIL ENTER4) 
 8   H       8L 0#  ` 
P   
    `   $0 "x "  u Q H6 0 r X k `   #`_ @   $H! $ #\ `T 8( 8
 x ~ 8 y   v H g  8 x 6 P 4 ( /   J h      ( D @   0     Q X   8   %& $X !`  8  w xm Hj hc J I E 9 h3 H)  "  ! x   ` 8 p { ` m 8 f p ^ 
p V 
@ P 	P G x 9 X & X #     x          
(PRETTYCOMPRINT MSHASHCOMS)
(RPAQQ MSHASHCOMS ((VARS MSHFNS) (DECLARE: FIRST (P * (MAPCAR MSHFNS (FUNCTION (LAMBDA (X) (LIST (
QUOTE MOVD?) (KWOTE (CADR X)) (KWOTE (CADDR X)))))))) (FNS * (MAPCAR MSHFNS (FUNCTION CAR))) (DECLARE:
 DONTCOPY (RECORDS HFTABLE)) (FNS LOCALFNP MSKEY FORWARDTABLE MSVAL NEXTHASHKEY STOREHASHVALUE 
GETHASHTABLE) (VARS (MSHASHSCRATCHSTRING (CONCAT MACSCRATCHSTRING))) (GLOBALVARS MSHASHSCRATCHSTRING) 
(ADDVARS (MSHASHFILE) (MSHASHFILENAME) (MSREADONLYFLG) (NEXTHASHKEY) (MSFILETABLE)) (DECLARE: 
EVAL@COMPILE DONTCOPY (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) NOBOX) (PROP MACRO BOGUSVAL 
BOGUSVALP)) (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) HASH) (LOCALVARS . T) (FNS ANALYZEFILES
 BUILDDB COPYDB FLUSHDB EQLST HFGETARGS MSFILECHECK MSFILES RESTOREDB SETDB UPDATECONTAINS UPDATEDB) (
ADDVARS (ANALYZEUSERFNS HFGETARGS))))
(RPAQQ MSHFNS ((HFGETTABLE GETTABLE OLDHASHGETTABLE) (HFMAKETABLE MAKETABLE OLDHASHMAKETABLE) (
HFMAPTABLE MAPTABLE OLDHASHMAPTABLE) (HFTESTTABLE TESTTABLE OLDHASHTESTTABLE) (HFEQMEMBTABLE 
EQMEMBTABLE OLDHASHEQMEMBTABLE) (HFSTORETABLE STORETABLE OLDHASHSTORETABLE) (HFPUTTABLE PUTTABLE 
OLDHASHPUTTABLE) (HFADDTABLE ADDTABLE OLDHASHADDTABLE) (HFSUBTABLE SUBTABLE OLDHASHSUBTABLE)))
(RPAQ MSHASHSCRATCHSTRING (CONCAT MACSCRATCHSTRING))
(ADDTOVAR MSHASHFILE)
(ADDTOVAR MSHASHFILENAME)
(ADDTOVAR MSREADONLYFLG)
(ADDTOVAR NEXTHASHKEY)
(ADDTOVAR MSFILETABLE)
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) HASH)
(ADDTOVAR ANALYZEUSERFNS HFGETARGS)
NIL
