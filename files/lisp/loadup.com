(FILECREATED "30-Dec-83 01:38:46" ("compiled on " <NEWLISP>LOADUP..157) (2 . 2) bcompl'd in WORK dated
 "30-Dec-83 01:23:53")
(FILECREATED "10-MAR-83 22:58:18" <NEWLISP>LOADUP.;1 12722 changes to: (VARS LOADUPCOMS) previous 
date: " 7-OCT-81 10:36:02" <LISP>LOADUP.;145)

LOADUP BINARY
       j    T    g-.          H TZ   3B  Z+   2B  [+   #Z   2B   +   Z  [XB  Z   ,<  Zp  -,   +   	+   Zp  ,<   @  T   +   [  ,<   Z  D  \,~   [p  XBp  +   /   Z  ,<   Zp  -,   +   +   Zp  ,<   @  T   +   Z  B  \,~   [p  XBp  +   /   Z  ,<   Zp  -,   +   +   "Zp  ,<   @  T   +   !,<  ]Z  D  \,~   [p  XBp  +   /   Z  3B   +   )B  ]2B   +   )Z  #B  ^B  ^,<  _Z  &D  _Z   3B   +   .B  ]2B   +   .Z  )B  ^B  ^XB  ,Z   XB   XB   XB   XB   Z  `XB   @  `  ,~   Z   ,<   Zp  -,   +   6Z   +   BZp  ,<   ,<w/   @  b   +   >,<  bZ   ,<   ,<  c,<  c(  dB  dXB   ,~   3B   +   @Zp  +   B[p  XBp  +   4/   3B   +   HZ  =B  e3B   +   H   e,<   Z  CB  f,\   +   IZ   XB   ,<  f"  d3B   +   P,<  f"  e3B   +   P   e,<   ,<  f"  f,\   +   QZ   XB   Z  ,<  Z   D  g,~   LQ2QDkS,BgEYMmP       (VARIABLE-VALUE-CELL X . 163)
(VARIABLE-VALUE-CELL EXCEPTFILES . 0)
(VARIABLE-VALUE-CELL CONTINUEFLG . 165)
(VARIABLE-VALUE-CELL NOCOMPFLG . 0)
(VARIABLE-VALUE-CELL FNS/VARSFILE . 80)
(VARIABLE-VALUE-CELL LOADUPMINFS . 51)
(VARIABLE-VALUE-CELL LOADUPLISTFILE . 91)
(VARIABLE-VALUE-CELL FILEPKGFLG . 93)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 94)
(VARIABLE-VALUE-CELL DWIMFLG . 95)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 96)
(VARIABLE-VALUE-CELL GLOBALVARSVARS . 98)
(VARIABLE-VALUE-CELL LOADUPDIRECTORIES . 102)
PARC
NETLISP
FNS-VARS
MINFS
RECLAIM
50
OPENP
OUTFILE
OUTPUT
"(SETQQ FNS/VARS ("
PRIN1
NOBIND
(NIL VARIABLE-VALUE-CELL FL . 141)
(NIL VARIABLE-VALUE-CELL LOADUPROFILELST . 146)
(NIL VARIABLE-VALUE-CELL FILEDATESLST . 162)
(VARIABLE-VALUE-CELL DIR . 117)
DIRECTORY
BODY
LOADUP.LISP
PACKFILENAME
INFILEP
INFILE
READ
CLOSEF
FILEDATES.LISP
LOADUPROFILE
(BHC SKNLST KNIL ENTERF) 0 9 8     X  0 	    Q 	X K 	 E 8 ? h / @ * ` $  X      

LOADUPROFILE BINARY
            -.          @    ,~   Z   -,   +   ,<  D  +   ,<   Z   D  XB   3B   +   [  ,<   Zp  -,   +   +   Zp  B  [p  XBp  +   
/   +   ,<  ,<   $  Z  ,~   <H4Z     (VARIABLE-VALUE-CELL X . 34)
(VARIABLE-VALUE-CELL CONTINUEFLG . 0)
(VARIABLE-VALUE-CELL LOADUPROFILELST . 13)
(NIL VARIABLE-VALUE-CELL LST . 18)
LOADUP0
APPLY
ASSOC
EVAL
?
PRINT
(KT BHC SKNLST KNIL SKLST ENTERF)               	           

LOADUP0 BINARY
              -.         Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   Z  -,   +   
,   XB  Z   3B   +   Z  	,<  Zp  -,   +   +    Zp  ,<   @     +   Z  ,   ,<   Z  
2B   +   7   Z   D  ,~   [p  XBp  +   Z  ,<  ,<   $  ,~   [p  XBp  +   BH!
	D  (VARIABLE-VALUE-CELL X . 47)
(VARIABLE-VALUE-CELL NOCOMPFLG . 37)
LOADUP1
(KT CONSNL SKA URET1 KNIL SKNLST ENTERF)   P   ( 
    	      X   X  8       @      

LOADUP1A0004 BINARY
            -.           Z   2B  +   [  Z  2B  +   [  [  Z  B  +   	[  +   	Z   ,<   Zp  -,   +   Z   +    Zp  ,<   @     +   Z   ,<   B  D  3B   +   Z  B  ,~   [p  XBp  +   	1PBMD    (VARIABLE-VALUE-CELL COM . 15)
FNS
*
EVAL
(VARIABLE-VALUE-CELL FN . 35)
GETD
MKSWAPP
MKSWAP
(URET1 SKNLST KNIL ENTERF)            @ 	       

LOADUP1 BINARY
         h    -.         @ hZ   ,<   @  m   
,~   Z   Z   ,   3B   +   Z   ,~   Z  Z   ,   3B   +   
+   Z  ,<   ,<  o,   B  pXB   ,<   Zp  -,   +   Zp  Z 7@  7   Z  2B  p+   ,<p  ,<   Z   F  qB  q3B   +   Z   +   Z   /   3B   +   !Z   ,<   @  j   +   !Z  Z 7@  7   Z  ,<   ,<   Z  rF  r,~   +   VZ   3B   +   &,<  sZ  
,<  ,<  sZ   H  t+   'Z  #XB   XB   ,<   ,<   $  tZ   ,<   Zp  -,   +   ,+   BZp  ,<   ,<w/   @  u   +   ?,<  uZ   ,<   ,<  vZ  'H  tXB  'B  vXB  3B   +   >Z  03B   +   <,<  w,<   $  tZ  5,<   ,<   $  t,<  w,<   $  t+   =,<   "  xZ  4XB  3,~   3B   +   AZp  +   B[p  XBp  +   */   Z  >,<   ,<   $  x,<   "  xZ   3B   +   V,<   Zp  -,   +   J+   UZp  ,<   @  y   +   S,<  y,<   ,<   @  z ` +   SZ   Z  {XB Z   B  |Z   ,~   ,~   [p  XBp  +   H/   Z   XB  FZ  ,<   Zp  -,   +   Y+   \Zp  B  |[p  XBp  +   W/   Z  C3B   +   Z   B  }Z   3B   +   B  xZ  _B  xZ  \,<   Z  aD  }Z  cB  ~,<   ,<   $  ~,<   "  ~+   c(JS,0Y)46BH)2RHS"K           (VARIABLE-VALUE-CELL FILES . 173)
(VARIABLE-VALUE-CELL CFLG . 67)
(VARIABLE-VALUE-CELL SYSFILES . 9)
(VARIABLE-VALUE-CELL EXCEPTFILES . 16)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 40)
(VARIABLE-VALUE-CELL MKSWAPSIZE . 51)
(VARIABLE-VALUE-CELL COMPILE.EXT . 74)
(VARIABLE-VALUE-CELL LOADUPDIRECTORIES . 83)
(VARIABLE-VALUE-CELL LINKEDFNS . 188)
(VARIABLE-VALUE-CELL LOADUPLISTFILE . 200)
(VARIABLE-VALUE-CELL FL . 77)
(NIL VARIABLE-VALUE-CELL TEM . 123)
(NIL VARIABLE-VALUE-CELL CFILE . 100)
(NIL VARIABLE-VALUE-CELL CFL . 196)
(NIL VARIABLE-VALUE-CELL AFTERLOADUPFORMS . 172)
COMS
PACK
NOBIND
STKSCAN
RELSTK
LOADUP1A0004
LOADUP3
NAME
EXTENSION
PACKFILENAME
PRIN1
(VARIABLE-VALUE-CELL DIR . 113)
DIRECTORY
BODY
INFILEP
"    (FROM "
")
"
TERPRI
LOAD
(VARIABLE-VALUE-CELL FORM . 162)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
EVAL
LOADUP2
RELINK
PRINT
OUTPUT
STORAGE
(CF SKNLST BHC KT KNOB SKLA LIST2 KNIL FMEMB ENTERF)   
    I @   P V 8 /    x f 
0 N ` E X < ( 8           x   P   ` ` ` V 	h G   7 X #      H 
  x     	  `      

LOADUP2 BINARY
    L    <    I-.         ( <@  ?  ,~   Z   ,<   Z   D  AXB   3B   +   Z  ,<  [  Z  ,<   [  [  Z  F  A+   'Z   ,<  Zp  -,   +   Z   +   !Zp  ,<   ,<w/   @  B   +   Z   3B   +   ,<  B,<   ,<  CZ  H  C+   Z  XB   B  DXB  3B   +   Z  ,<  ,<   B  DF  AZ   ,~   3B   +   Zp  +   ![p  XBp  +   /   2B   +   ',<  E,<   $  EZ  ,<   ,<   $  E,<  F,<   $  EZ   ,<   Z  $,   D  FXB  'Z   3B   +   ;Z  (,<   ,<  G,   B  GXB   Z 7@  7   Z  XB  	-,   +   ;Z  *3B   +   8Z  .Z  1,   ,<   Z  2,<   Z   F  HZ  4,<   Z  6D  HZ  4Z  I,   Z   ,~    a!M2#
&% HP        (VARIABLE-VALUE-CELL FILE . 88)
(VARIABLE-VALUE-CELL FILEDATESLST . 8)
(VARIABLE-VALUE-CELL LOADUPDIRECTORIES . 23)
(VARIABLE-VALUE-CELL SYSFILES . 84)
(VARIABLE-VALUE-CELL FNS/VARSFILE . 114)
(VARIABLE-VALUE-CELL FILERDTBL . 110)
(NIL VARIABLE-VALUE-CELL TEM . 112)
(NIL VARIABLE-VALUE-CELL FL . 49)
(NIL VARIABLE-VALUE-CELL COMS . 116)
ASSOC
LOADUP2A
(VARIABLE-VALUE-CELL DIR . 37)
DIRECTORY
BODY
PACKFILENAME
INFILEP
FILEDATE
*****
PRIN1
" not found.
"
NCONC
COMS
PACK
PRINT
LOADUP3
NOBIND
(SET CONS SKLST KNOB LIST2 CONSNL KT BHC SKNLST KNIL ENTERF) @   `   (      h       H , x & @     "    `   @ " h  @   h      

LOADUP2A BINARY
                -.           @    ,~   Z   ,<   Z   ,<  ,<  $  XB   -,   +   +   -,   +   
Z  Z  +   Z   /   ,~   ,\  ,   2B   +   ,<  ,<   $  Z   ,<   ,<   $  ,<   "  ,<   "  Z   ,~   iQP    (VARIABLE-VALUE-CELL FILE . 8)
(VARIABLE-VALUE-CELL FULLNAME . 31)
(VARIABLE-VALUE-CELL FILEDATE . 6)
(NIL VARIABLE-VALUE-CELL TEM . 18)
FILEDATES
GETPROP
"*****date does not agree with that of "
PRIN1
PRINT
TERPRI
(KT EQUAL BHC KNIL SKLST SKSTP ENTERF)   8                `     	           

LOADUP3 BINARY
      O    E    L-.          EZ   ,<   Zp  -,   +   Z   +    Zp  ,<   @  G   +   C@  G  ,~   [   Z  2B  H+   [  	[  Z  -,   +   [  [  Z  XB   Z  2B  H+   Z  3B   +   Z  Z 7@  7   Z  +   [  ,<   Z   ,<   Z   F  I+   *2B  I+    [  Z  2B  H+   Z  Z 7@  7   Z  +   [  XB  +   *3B  J+   "2B  J+   *[  [  Z  2B  H+   *[  "[  [  Z  -,   +   *[  %[  [  Z  XB  Z  3B   +   /,<   Z  (,<   "   ,   ,~   Z  *3B   +   C-,   +   2,   ,<   Zp  -,   +   4+   BZp  ,<   @  K   +   AZ  3B   +   ?Z  /,<  Z  8Z 7@  7   Z  ,   ,<   Z  7,<   Z   F  KZ  9Z  L,   ,~   [p  XBp  +   2/   ,~   [p  XBp  +   BaBAf|`@ 
$ 
      (VARIABLE-VALUE-CELL COMS . 3)
(VARIABLE-VALUE-CELL FL . 122)
(VARIABLE-VALUE-CELL FN . 85)
(VARIABLE-VALUE-CELL FILERDTBL . 124)
(VARIABLE-VALUE-CELL COM . 89)
(NIL VARIABLE-VALUE-CELL NAME . 126)
*
COMS
LOADUP3
FILEVARS
PROP
IFPROP
(VARIABLE-VALUE-CELL NAME . 0)
PRINT
NOBIND
(BHC SET CONSS1 CONSNL EVCC KNOB SKLA URET1 KNIL SKNLST ENTERF)   C    A    =    2    /    < h     ( X    X    0 @   P   @ 1  @      

ENDLOAD BINARY
    2    %    0-.         P %,<  *Zp  -,   +   +   Zp  B  +[p  XBp  +   /   Z   XB   Z   XB   Z   XB  Z   3B   +   3B   +   ,<  +D  ,,<  ,Z  
D  ,Z  B  -Z   3B   +   B  -Z  .XB  Z  .XB  Z   3B   +   Z   XB   XB   XB   XB   ,<  ."  /Z   ,<   Z  .XB  ,\   ,<   Zp  -,   +   Z   +    Zp  ,<   @  /   +   #[   ,<   Z  !D  0,~   [p  XBp  +   R /)Q!"     (VARIABLE-VALUE-CELL FLG . 40)
(VARIABLE-VALUE-CELL ADVISEDFNS . 15)
(VARIABLE-VALUE-CELL LINKEDFNS . 19)
(VARIABLE-VALUE-CELL SYSLINKEDFNS . 17)
(VARIABLE-VALUE-CELL FNS/VARSFILE . 39)
(VARIABLE-VALUE-CELL LOADUPLISTFILE . 37)
(VARIABLE-VALUE-CELL DWIMFLG . 44)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 45)
(VARIABLE-VALUE-CELL FILEPKGFLG . 46)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 47)
(VARIABLE-VALUE-CELL INITMINFS . 53)
((LOADUP LOADUPROFILE LOADUP0 LOADUP1 LOADUP2 LOADUP2A LOADUP3 ENDLOAD) . 0)
PUTD
"))"
PRIN1
((MAPC FNS/VARS (FUNCTION (LAMBDA (X) (/SETATOMVAL (CAR X) (CDR X))))) . 0)
ENDFILE
CLOSEF
NOBIND
1
RECLAIM
(VARIABLE-VALUE-CELL X . 68)
MINFS
(URET1 KT KNIL BHC SKNLST ENTERF)   p   h      X  8 
      x   X        
(PRETTYCOMPRINT LOADUPCOMS)
(RPAQQ LOADUPCOMS ((FNS LOADUP LOADUPROFILE LOADUP0 LOADUP1 LOADUP2 LOADUP2A LOADUP3 ENDLOAD) (
INITVARS (LOADUPDIRECTORIES (QUOTE (NIL NEWLISP LISP)))) (VARS (FNS/VARSFILE) (LOADUPLISTFILE) 
LOADUPMINFS INITMINFS) (ADDVARS (SYSFILES)) (GLOBALVARS RECORD COMPILE.EXT MKSWAPSIZE SYSFILES 
FILERDTBL ADVISEDFNS BUILDMAPFLG FILEPKGFLG DWIMFLG ADDSPELLFLG SYSLINKEDFNS LINKEDFNS 
LOADUPDIRECTORIES LOADUPLISTFILE FNS/VARSFILE INITMINFS LOADUPMINFS) (DECLARE: DONTEVAL@LOAD 
DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA LOADUP0) (NLAML) (LAMA)))))
(RPAQ? LOADUPDIRECTORIES (QUOTE (NIL NEWLISP LISP)))
(RPAQQ FNS/VARSFILE NIL)
(RPAQQ LOADUPLISTFILE NIL)
(RPAQQ LOADUPMINFS ((1 . 4737) (4 . 156) (8 . 18000) (9 . 852) (12 . 10500) (16 . 30) (18 . 30) (24 . 
845) (28 . 7664) (30 . 2775)))
(RPAQQ INITMINFS ((1 . 10000) (4 . 512) (8 . 10000) (9 . 512) (12 . 1000) (16 . 512) (18 . 3000) (24 .
 512) (28 . 512) (30 . 512)))
(ADDTOVAR SYSFILES)
(PUTPROPS LOADUP COPYRIGHT ("Xerox Corporation" 1983))
NIL
