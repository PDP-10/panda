(FILECREATED "11-AUG-83 23:32:38" ("compiled on " <NEWLISP>MAC.;2) "11-AUG-83 22:19:15" brecompiled 
changes: MKSTRING BKSYSBUF in WORK dated " 4-AUG-83 02:15:32")
(FILECREATED "11-AUG-83 23:32:21" <NEWLISP>MAC.;2 151135Q changes to: (FNS MKSTRING BKSYSBUF) (VARS 
MACCOMS) previous date: "17-FEB-83 23:16:43" <LISP>MAC.;156)
(ADDTOVAR NOSWAPFNS KFORK1 RFSTS GDATE DIRECTORYBLOCK)
DCHCONBLOCK BINARY
        A    9    ?-.           9-.      :p ;             ,<w~,<w~,<w~,<w~,  XBw,<   Zp  -,   +   
+   ,<   ,<p  ZwA"  ?Z   ." Z  ,\  XB  /   [p  XBp  +   /   Zw+         ,<   ,<   ,<   Zw}-,   +   ,<  <d  <XB   Zw~ $  1Zw}2F   +   ,   +   Zw~,   Z  XBw-,   +   ,<w},<w}  =+    Zw}2B  +   "Z   +    [wXBw-,   +   %[w}+    [w}XBp  ZwZ   QD  Zw}ZwQD  Zw       [  2D   +   *XBw-,   +   /Zp  QD  +   0,<  >d  <Zp  +    ,>  9,>   [  -,   +   7*x  .$   XD  XB  2,^  /   ,~       +   5Z   +       A dP$   $r    (DCHCONBLOCK#0 . 1)
(VARIABLE-VALUE-CELL FCHARAR . 30Q)
(VARIABLE-VALUE-CELL DCHCONGV . 152Q)
DUNPACK
DCHCON
"DCHCON: SCRATCHLIST not a list"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . CHCON)
"DCHCON - Unusual CDR on SCRATCHLIST: "
(ASZ SKLST URET7 IPRE2 IPRE KNIL URET4 BHC SKNLST BLKENT ENTER1)  P   8 -    9  % (              9   , x "   @         7      $ X      (      
DUNPACK BINARY
              -.            ,<    ,~       (X . 1)
(SCRATCHLIST . 1)
(FLG . 1)
(RDTBL . 1)
DUNPACK
(NIL)
(LINKED-FN-CALL . DCHCONBLOCK)
(ENTER4)      
DCHCON BINARY
               -.            ,<    ,~       (X . 1)
(SCRATCHLIST . 1)
(FLG . 1)
(RDTBL . 1)
DCHCON
(NIL)
(LINKED-FN-CALL . DCHCONBLOCK)
(ENTER4)     
FORKBLOCKA0005 BINARY
              -.           Z`  Z   QD  ,~       (VALUE . 1)
(KT ENTER1)   0      
FORKBLOCK BINARY
   e      [-.          -.     Hh#       '   e     ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   Zwz2B   +   Z   XBwzZ %XBw{Zwz-,   +   #Z   ,   3B   +   ZwzXBw|b %XBp  Z  1B  +   ,<wz &,< ',<wy (Zw{3B   +   2B %+   [p  [  Z  +   "2B )+   Z"+   "2B )+   Z"+   "2B *+   !Zw|+  %,< *d (XBw+   Q3B   +   %2B ++   ,Z $6@   Z +2B ++   (Z ,+   )Z ,,<   ,<   ,<   ,< - -+   H,<   Z   2B ++   /Z .+   /Z /,<   ,<   ,< / -2B   +   HZ $6@   Z +2B ++   6Z 0+   6Z 0,<   ,<wy 1,<   Z $6@   Z +2B ++   <Z .+   <Z /,<   ,<   ,< 2 -2B   +   H,<wz,< 2Z   f 3XBw}3B   +   FZwzZw}3B  +   FZw}XBwz+   	,< 4,<wy (XBw}, eXBw|Zw|,   ,> ,>   Zw},   ,^  /   QD      @Zw{2B *+   P+    Z"XBwZwz2B   +   U,<   , Z  +   h-,   +   \,< 4 5b 6XBw},<wzd 7,<w} 8b 9b :XBw~b ;+   h,<   ,< < <3B   +   aZwzXBw~b ;+   h,<wz =3B   +   f,<wz 9b :ZwzXBw~b ;+   h,< >,<wz (XBw}Zw{2B   +   l,<   , [  +   w,<   ,< ? <3B   +   pZw{XBwb ;+   w,<w{ ?3B   +   v,<w{ 5b 6Zw{XBwb ;+   w,< @,<wz (XBw~Z   3B   7@   +   |\"  @      +     "      #   ,   XBw|    [8  aB     0*n     ?,> ,>   Zw~,   ,> ,>   Zw},   QBx  Zw|,   ,^  /      C,> ,>   Zw,       ,^   /   3d 3$ +  .$     @7       7   9,^   /      DZw|,        "      $,   ,   Zw~3B   +  b 8Zwz-,   +  ,<w~ AZw3B   +  b 8,<     ,> ,>            $+    +    +       ABx  ,^   /   ,   d B,< C,<w{ C/  ,~       Z $6@   Z +2B +7   Z   ,<   ,<   ,<   Zw~2B   +  /,<   ,<   Z   f DXBwZ   3B   +  3b %Z  1B  +  :Zw3B   +  7,< +,< E,< F,<   ,  +  :,< +,< F,< G,<   ,  XB /Zw~2B   +  A,<w~ Gb HZw3B   +  @Z I+  @Z Jb H,<    J,< K,<   ,<   @ L `  +  UZ   Z MXB Z :3B   +  Kb %Z  0B  +  KZ F+  KZ   ,<   ZwZ?~3B   +  R,<?~Z?3B   +  QZ N+  QZ Nd O,<   ,<   ,< %,  XB JZ   ,~   2B   +  ZZw~2B   +  Y,<    PZ   XB T+  /Zw~3B   +  ]Z   +    ,<    Q3B   +  c,<    R2B S+  cZ   XBp  ,<    S,<w TZp  +         ,<   Z   3B   +  n    ,> ,>       ,   XB g,       ,^   /   3B  +  n, zS"     57    +  r,   b U,<   ,< V (,   XBp  ,<    w/"  ,   ,   Z f,   XB vZ  ,<   Z  f WZp  +    Z w,<   Zp  -,   +  }+   Zp  Z   QD  [p  XBp  +  {/   Z x,<   Z Xd XZ z,<   Zp  -,   +  +  ,<   Zp  [  2B   +  Zp  Z  b YZp  Z   XD  /   [p  XBp  +  /   ,<   Z d ZXB Z   ,~   Zp  2B   +     $   +  ,      C_  ,> ,>   ^"  ,   XBp  ,^   /   ,   Zp  ,   +                       ` HD'w:wqgfoJ~5$&" pUrmS+
4jg! D @p m` D2{t,}JP#s$E8PE0 0#	4                       (FORKBLOCK#0 . 1)
(VARIABLE-VALUE-CELL LASTSUBSYS . 26Q)
(VARIABLE-VALUE-CELL USERFORKS . 1002Q)
(VARIABLE-VALUE-CELL SYSTEMTYPE . 131Q)
(VARIABLE-VALUE-CELL SUBSYSSPELLINGS . 201Q)
(VARIABLE-VALUE-CELL SUBSYSRESCANFLG . 360Q)
(VARIABLE-VALUE-CELL READBUF . 534Q)
(VARIABLE-VALUE-CELL EXECFORK . 663Q)
(VARIABLE-VALUE-CELL USERFORKLST . 1037Q)
(VARIABLE-VALUE-CELL CFORKTIME . 724Q)
SUBSYS
TENEX
CFORK
CONTINUE
(NIL)
(LINKED-FN-CALL . RFSTS)
(NIL)
(LINKED-FN-CALL . KFORK)
"ILLEGAL FORK:"
(NIL)
(LINKED-FN-CALL . ERROR)
START
REENTER
DONTSTART
"SUBSYS - ENTRYPOINTFLG NOT ONE OF START, REENTER, CONTINUE OR NIL:"
EXEC
TOPS20
SYSTEM:EXEC.EXE
<SYSTEM>EXEC.SAV
100000Q
(NIL)
(LINKED-FN-CALL . GTJFN)
EXE
SAV
100000Q
SYS:
<SUBSYS>
(NIL)
(LINKED-FN-CALL . PACK*)
100000Q
74Q
(NIL)
(LINKED-FN-CALL . FIXSPELL)
"SUBSYS - BAD FILE/FORK"
SUBSYS.INCOMFILE;T
(NIL)
(LINKED-FN-CALL . OUTFILE)
(NIL)
(LINKED-FN-CALL . OUTPUT)
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . CLOSEF)
(NIL)
(LINKED-FN-CALL . INFILE)
(NIL)
(LINKED-FN-CALL . INPUT)
(NIL)
(LINKED-FN-CALL . OPNJFN)
INPUT
(NIL)
(LINKED-FN-CALL . OPENP)
(NIL)
(LINKED-FN-CALL . INFILEP)
"SUBSYS - BAD INCOMFILE:"
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTFILEP)
"SUBSYS - BAD OUTCOMFILE:"
(NIL)
(LINKED-FN-CALL . DELFILE)
(NIL)
(LINKED-FN-CALL . POSITION)
LASTSUBSYS
(NIL)
(LINKED-FN-CALL . /SETATOMVAL)
(NIL)
(LINKED-FN-CALL . CLBUFS)
"POP
"
NUL:
"QUIT
"
NIL:
(NIL)
(LINKED-FN-CALL . MKSTRING)
(NIL)
(LINKED-FN-CALL . BKSYSBUF)
"
POP

"
"
QUIT

"
(NIL)
(LINKED-FN-CALL . TERPRI)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
"
POP
"
"
QUIT
"
(NIL)
(LINKED-FN-CALL . CONCAT)
(NIL)
(LINKED-FN-CALL . CLEARBUF)
(NIL)
(LINKED-FN-CALL . READP)
(NIL)
(LINKED-FN-CALL . PEEKC)
%

(NIL)
(LINKED-FN-CALL . READC)
(NIL)
(LINKED-FN-CALL . BKBUFS)
(NIL)
(LINKED-FN-CALL . ERSTR)
"TRY KILLING SOME FORKS."
(NIL)
(LINKED-FN-CALL . PUTHASH)
FORKBLOCKA0005
(NIL)
(LINKED-FN-CALL . MAPHASH)
(NIL)
(LINKED-FN-CALL . KFORK1)
(NIL)
(LINKED-FN-CALL . DREMOVE)
(FIXT SKNLST URET1 CONS CONSNL IUNBOX GCTIM URET5 CF SETMOD SETINT CTCTP MKN SKSTP BHC GUNBOX KL20FLG 
ASZ GETHSH SKI KT KNIL BLKENT ENTER1)   "@    X}    0   #0w   v   k   j   e X   `   X   P   x   #  `s j @ ~    
`   # !H P& 8 H 	`   "P 0 ` 	P K   (   : @ &   J 0 Q p  @       h   0b  ^ PY XB h* H     " !8 pg h_ @Z  V 8P `L  D 8? @: p4 . P, 8* 0  r h k   c p T 
0 C x > ( 1 0 * @   
  	    x   h            
SUBSYS BINARY
            -.            ,<    ,~       (FILE/FORK . 1)
(INCOMFILE . 1)
(OUTCOMFILE . 1)
(ENTRYPOINTFLG . 1)
SUBSYS
(NIL)
(LINKED-FN-CALL . FORKBLOCK)
(ENTER4)      
TENEX BINARY
             -.           ,<    ,~       (STR . 1)
(FILEFLG . 1)
TENEX
(NIL)
(LINKED-FN-CALL . FORKBLOCK)
(ENTER2)      
CFORK BINARY
                -.            ,<    ,~       CFORK
(NIL)
(LINKED-FN-CALL . FORKBLOCK)
(ENTER0)     
KFORKA0009 BINARY
             -.           ,<` "  ,~       (VALUE . 1)
(ITEM . 1)
KFORK
(ENTER2)    
KFORK BINARY
                -.          ,<   Z`  2B   +   Z   ,<  Z  D  +   Z  ,   XBp  3B   +   ,<`  "  ,<p  Z   D  XB  
,<`  ,<   Z  F  Z   +    B      (FORK . 1)
(VARIABLE-VALUE-CELL USERFORKS . 31Q)
(VARIABLE-VALUE-CELL USERFORKLST . 26Q)
KFORKA0009
MAPHASH
KFORK1
DREMOVE
PUTHASH
(URET1 GETHSH KT KNIL ENTER1)   p    x    8   h          
KFORK1 BINARY
            -.           Z`  -,   +    `  0b +    `  0"  +   Z   ,~   Z   +   	Z   ,~   Z`  ,   ,>  ,>      74  +   ""   _   ,^   /   8D    5,~      $! (FORK . 1)
(BHC GUNBOX KT KNIL SKI ENTER1)   p   (                   
RFSTS BINARY
             -.           Z`  2B   +       $   +   ,   0"  0" +      74  ,>  ,>   _   1B+      ,   ,   XB`  ^x  ,   Z`  ,   XB`  ,^   /   _   ,   Z`  ,   +   Z   ,~          "b       (FORK . 1)
(BHC CONS CONSNL MKN GUNBOX FIXT KNIL ENTER1)       h   @     8    X    H   0        
GEVEC BINARY
     	        -.           ,<`  "  3B   +   Z`  ,      B   ,   ,~   Z   ,~       (FORK . 1)
RFSTS
(MKN GUNBOX KNIL ENTER1)    h    P    x        
GTJFN BINARY
     ?    8    =-.            8,<` "  :0B  +   ,<` ,<  ;,<  ;&  <XB` Z` 2B   +   	^"    $   +   	,   ,>  6,>   ,>  7,>  7,>  7,>  7,>   ,>   ,>  7Z` 2B   +   ^"    $   +   ,   QB|Z` (B{Z  A"  ."   0B  +   Z` +   0B  +   ^"  ,>  8,>   Z` .Bx  ,^   /   [  +   ,<` "  <    ,  0 DZ`  (B{Z  A"  ."   0B  +   #Z`  +   )0B  +   (^"  ,>  8,>   Z`  .Bx  ,^   /   [  +   )Z   3B   +   / ,  0@dx  *Z` 3B   @@ "|   7   ,   /  ,~   ,     0H   0B  7    Z"  B  =h  1H  ,~   Z   ,~     ?{        8Jy*P
 %       (FILE . 1)
(EXT . 1)
(V . 1)
(FLAGS . 1)
CHCON1
2
-1
SUBSTRING
MKSTRING
(UPATM MKN BHC TYPTAB XXXMHC GUNBOX FIXT KNIL ASZ ENTER4)           ( 8         `           	    6 x -   ) x     $   ! x  P        
RLJFN BINARY
             -.           Z`  ,      	7   Z   ,~       (JFN . 1)
(KT KNIL GUNBOX ENTER1)   H    @    0      
DELFILE BINARY
              -.           ,<   ,<`  "  3B   +   Z   +    ,<`  ,<   ,<  &  XBp  2B   +   	+   B  XB`  Zp  ,      +   Z   +   Zp  ,      	+    Z   3B   +   Z`  +    Z   +    C     (FILE . 1)
OPENP
-2
GTJFN
JFNS
(KT GUNBOX URET1 KNIL ENTER1) P   h                  P   (      
RENAMEFILE BINARY
                -.           ,<   ,<   ,<   ,<`  "  2B   +   Z   +    XBwZ` 2B   +   	,<`  ,<   $  ,<   ,<   ,<  &  2B   +   +   XBwB  2B   +   +   XBp  Zw,   ,>  ,>   Zw,   Zx     ,  ,^   /      	,  Zp  +    Z   XBp  ,~   +      P$m1 @  (OLD . 1)
(NEW . 1)
GTJFN
NAMEFIELD
-1
JFNS
(BHC GUNBOX KT URET3 KNIL ENTER2)   `   8     	      h     H      P   0        
PAGEFAULTS BINARY
             -.             "     =   ,   ,~       (MKN ENTER0)         
LOADAV BINARY
            -.            ,<  ,<  ,<  &  ,~       -140614133614Q
14Q
FLOATING
GETAB
(ENTER0)      
GETER BINARY
             -.                  Z"  ,   ,~           (MKN ENTER0)         
RAND BINARY
      (    $    &-.          $Z   -,   +   ,<   "  &Z  Z  [  [  [  Q$   D  Z  Z     /  d"   B  Z`  -,   +   Z` -,   +    ` ,>  $,>    `      ,^   /   /  ."   Z  Z  %  ,>  $,>    `  .Bx  ,^   /   ,   ,~   Z  Z     (B|B  @,>  $,>   Z` ,   ,>  $,>   Z`  ,       ,^   /     Bx  Z`  ,   Bx  ,^   /   ,   ,~      @ @        (LOWER . 1)
(UPPER . 1)
(VARIABLE-VALUE-CELL RANDSTATE . 57Q)
RANDSET
(MKFN FUNBOX MKN BHC SKI KT SKNLST ENTER2)   $    " h         #       X                
RANDSET BINARY
        t    k    q-.          k,<   ,<   ,<   Z`  2B   +   +   O2B   +      lXBw   mXBp  +   --,   Z   [  -,   +   Z`  -,   +   Z`  XBw[`  XBp  +   -,<`  "  m0B  +   ,,<`  Zp  -,   +   Z   +   Zp  -,   +   Z   +   [p  XBp  +   /   3B   +   ,,<`  ,<   Zw-,   +   !Zp  Z   2B   +    "  +    [  QD   "  +   *Zw,<   ,<      i,   XBp  ,<   Zw,   ,\   B  ,   /  Zp  ,   XBp  [wXBw+   /  XBw+   F,<  n,<`  $  n,<  o,<   Zw-,   +   5Zp  Z   2B   +   3 "  +   4[  QD   "  +   EZw,<    p  ,>  j,>    w~$  j,>  j,>    w~.Bx  ,^   /   ,   ,<   Zw~XBw},\   XBw~,   .Bx  ,^   /   A  k,   /   Zp  ,   XBp  [wXBw+   ./  XBw,<w"  oZwQD  ,<  ,<w~^"      ,\   5d  M    Z   ,   +   N[  2B   =d  M,   XB   Z  O,<   ,<  p,<   ,<   ,<   ,<   ,<  pZw}-,   +   U+   hZ  XBw p  ,>  j,>    w}    ,^   /   3b  +   [+   h w."   ,   XBwZw~3B   +   b,<   Zw~,   XBw~,\  QB  +   dZw,   XBw~XBw~[w}XBw} p  ."   ,   XBp  +   SZw~/  ,~    ka     ]PMN?6PH*)$B" 6"&  @"&0      (X . 1)
(VARIABLE-VALUE-CELL RANDSTATE . 237Q)
CLOCK
IDATE
LENGTH
"ARG NOT PREVIOUS VALUE OF RANDSET"
ERROR
((47447503155Q 326000024101Q 231110260611Q 227761755153Q 232325706615Q 257441134336Q 142066625213Q 
220351020462Q 41050065502Q 354112240237Q 347723367427Q 4143151614Q 155441143612Q 322577020366Q 
53536334175Q 345317007070Q 246306130377Q 310574310360Q 363024357667Q 214106215653Q 310463172341Q 
11247622224Q 357251716512Q 327771474465Q 106336512534Q 62542651720Q 32000042612Q 102726157734Q 
212027450455Q 146411472776Q 12167637517Q 163346751512Q 145606523205Q 373036416215Q 123517722614Q 
116345213643Q 22266545767Q 272451137321Q 145226166110Q 354607155455Q 43655353345Q 220445470512Q 
266640523172Q 233412640056Q 42407046627Q 360344105522Q 320213565147Q 355242324677Q 207411666774Q 
277103114257Q 140765617644Q 304415444727Q 142614615772Q 336716353021Q 307146527652Q) . 0)
LAST
67Q
1
(CONSNL CONSS1 CONS IUNBOX COLLCT GUNBOX MKN BHC SKNI SKNLST ASZ SKI SKLST KT KNIL ENTER1) @ a    O    M    ?    C    `   x ]   < x $    i ( F ( A @ +           U    0      H     	      `   p S 
0 R 
  N 	H 2  / 0  X        8   (      
GETAB BINARY
        !         -.           Z`  -,   +   B  ,   +   ,      ,>  ,>  4D  Z` 2B   +   
^"    $   +   
,   QBx   x     +   Z` 3D  +   3D   +   3D  +    Bx  Z` (B{Z  A"  ."   ,   0B   1B   +   ,   +   ,   +   ,   B  +   ,   +   Z`  x   D  +   Z   /  ,~      %8VD  (TABLENAME . 1)
(INDEX . 1)
(FORMATFLG . 1)
SIXBIT
FLOATING
(BHC MKFN MKN FLOATT ASZ TYPTAB FIXT KNIL GUNBOX SKNI ENTER3)                                   H     @   X            
RPLSTR0 BINARY
                -.          Z`   $  (D{Z  1D  +   	0D  +   [ +   	,<  ,<`  $  ,<  ,<`  $  ,   ,>  ,>  ,>  Z   ,    `  3hx  +   ,^  /   ,^  4H    B  =h  1B  h  H  0B  7   Z   ,~      +4A	     (STR . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 27Q)
"Too big for string buff:"
ERROR
"Arg not string or atom:"
(KT KNIL BHC UPATM TYPTAB ENTER1)               (    @      
HOSTNUMBER BINARY
                -.            ,<  ,<  $  3B   +   
            ]+    +    +       ,   ,<   ,\   2B   +   Z",~        x  NETRDY
0
GETAB
(ASZ MKN KNIL ENTER0)  8      (        
IDATE BINARY
             -.          Z`  3B   +   B  Z   ,    `     @@     H+   	   +   
   K+   
Z   +   
,   ,~   *  (D . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 7)
RPLSTR0
(MKN UPATM KNIL ENTER1) 0    P            
USERNUMBER BINARY
             -.           ,<`  "  ,~       (USERNAME . 1)
INTERNALUSERNUM
(ENTER1)      
GDATE BINARY
             -.          Z` 2B   +   ^"   +   ,   ,>  ,>   Z`  2B   +   ^"+   ,   ,>  ,>   Z   ,      ,^  /   ,^  /      H4   $   D   Z` -,   +   B  +      +   Z   ,~      Q(@    (DATE . 1)
(FORMATBITS . 1)
(STRPTR . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 23Q)
STRCONC1
STRCONC0
(SKSTP BHC UPATM IUNBOX KNIL ENTER3)        H   0          p        
MACSTRBLOCK BINARY
    x    l    t-.           l-.      mH m                    1    L    Y     Z   ,   ,>  ,   7    ,   x  5B  	,^  ,   ,~        Z  ,   ,>  ,   7    ,   x  5B  ,^      ,   ,~       Z     Zp   D  ,    (     4B  9  Zp  h  k+         w,>  k,>   Zw2B   +      l+   ,   ,>  k,>   Z   
`d  @+   "Z   +   /Z  ,    `         x      +     &   F   Zp  -,   +   +,<   ,  +   /Zw3B   +   -,  +   /Z  q,<   ,  b  q/  +        Zp  -,   +   ;Zp  ,   ,>  k,>   Z  ",    `  ,^  /    "   )B  ."  B  5D  7D  ,  +    Zp  -,   +   A^"  ,>  k,>   Zp  .Bx  ,^   /   [  +   D-,   +   B+   D,<  r,<   ,   B  s,   0h  Z(  ^*'}@   <(  I  (B  ."p+   G9j  K(B  +   I,   +        Zp  3B   7  W,   ,>  k,>   Z  4,    `     ,^  /   Q$  S&      +    +   W@   F   ,  +   XZ   +        Zw2B   +   [   sXBw0B+   ]Z   +    Zw,   ,>  k,>   Z  O,    `     ,^  /    "     ]+   jZp  -,   +   g,<   ,  +   i3B   +   i,  +   i,  +   jZ   +    *8     "$@  ~ @ t `H"@\A `d-x     (MACSTRBLOCK#0 . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 277Q)
ATMCONC0
STRCONC0
STRCONC1
JFNS
SIXBIT
ERSTR
HOSTNAME
""
(NIL)
(LINKED-FN-CALL . MKATOM)
33Q
ERRORX
(NIL)
(LINKED-FN-CALL . HOSTNUMBER)
(URET2 ASZ MKN LIST2 SKLA GUNBOX SKI URET3 BHC SKSTP IUNBOX KNIL URET1 MKSP UNP1 MKSTR1 MKSTRS MKATM 
PAC PACS UPATM BLKENT ENTER1) 8 ^    \    L    D    <    _ 	p 4    2    1    c 
0 @ x 0    e   )        k   ] ( X 	` , (     Y 	H ;     0   (      x   H   (       Q X 6 @  h            
ATMCONC0 BINARY
               -.            ,<    ,~       ATMCONC0
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER0)     
STRCONC0 BINARY
               -.            ,<    ,~       STRCONC0
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER0)     
STRCONC1 BINARY
               -.           ,<    ,~       (FLG . 1)
STRCONC1
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER1)      
JFNS BINARY
            -.           ,<    ,~       (JFN . 1)
(AC3 . 1)
(STRPTR . 1)
JFNS
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER3)     
SIXBIT BINARY
               -.           ,<    ,~       (X . 1)
SIXBIT
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER1)     
ERSTR BINARY
                -.           ,<    ,~       (ERN . 1)
ERSTR
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER1)    
HOSTNAME BINARY
             -.           ,<    ,~       (HOSTN . 1)
(FLG . 1)
HOSTNAME
(NIL)
(LINKED-FN-CALL . MACSTRBLOCK)
(ENTER2)      
DIRECTORYBLOCK BINARY
     =   (   8-.          (-.     )H)        &    7    <    w      !    ,<w,< -,  >,<   Zp  2B   +   Z   +    ,<w -Z .6@   Z /2B .+   Z   ,   Zp           7   Z   3B   +   
+   $2B /+   
Z  ,      Zp     O
   Zw3B   +   2B /+     &+    3B   +   2B 0+     &+    2B 0+   
  ' $    54  "7   Z   3B   +   
,<p  ,<   ,  &+        Zw-,   +   +,<   ,< 1,  >2B   +   ++   6,   ,> ',>   Z  ,    `     ,^  /      +   6Zp  -,   +   3b 1+   53B   +   5  2+   5  3+   6Z   +        ,<p  ,< 4,  >3B   +   ;Z   +    Z   +        ,<p  ,<   ,  >+    +   K   7     +   ^S$  3B   @   ,> ',>  Z  ,,    `     ,^   /   ,~   7@   S"     54  K`b ` +   K   : x  ,~       A   Zw3B   +   Z3B   +   Yb -,  A6@   +   T   +    7   7    +   bZ   +   ^,  G7    +   ^,<w, 
,  A,  G+   R+   ^1$  +   ?7 ( &  1$  +   @O   \$    #+   R   Zp  2D   +   a,   +   b B     +    Zw3B   +   rb -S$  3B   @   ,> ',>  Z  C,    `     ,^   /   6@   +   n   +    7   7    +   vZ   +   s7@   S"     64  l`b ` +   l   +   s   Zp  2D   +   u,   +   v B     +        Zw-,   +   |,<   ,< 5,  b2B   +   |+  ,   ,> ',>   Z  g,    `     ,^  /      +  Zp  -,   +  b 1+  3B   +    2+    3+  Z   +        ,<p  ,<   ,  b+    Zp   $  (D{Z  1D  +  0D  +  [ +  ,< 5,<w 6,< 7,<w 6,   ,>  ,> ',>  Z  },    `  3hx  +  ,^  /   ,^  4H  "  B    B  =h 0B  +  h  +   $  D  H  0B  7   Z   +        ,<p  ,< 7,  b3B   +  %Z   +    Z   +    @                 ~1` >H[ 	o@(D (h->HE*Zx4A* h         (DIRECTORYBLOCK#0 . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 451Q)
CONNECTDIR
DIRECTORYNAME
DIRECTORYNAMEP
DIRECTORYNUMBER
USERNAME
USERNUMBER
USERNAMEP
1.419769E32
(NIL)
(LINKED-FN-CALL . RPLSTR0)
TENEX
TOPS20
CONNECT
ACCESS
NOACCESS
1.419769E32
(NIL)
(LINKED-FN-CALL . STRCONC1)
(NIL)
(LINKED-FN-CALL . ATMCONC0)
(NIL)
(LINKED-FN-CALL . STRCONC0)
1.0
1.419769E32
"Too big for string buff:"
(NIL)
(LINKED-FN-CALL . ERROR)
"Arg not string or atom:"
1.419769E32
(TYPTAB MKN TOPS20RELEASE URET1 URET2 SKSTP BHC GUNBOX SKNNM KT UPATM KL20FLG URET4 KNIL BLKENT ENTER1
)  P   X a    L   & X! 0 ? H ;    x c x   0 2     j p 0    } @    (   %  O 0 % 0  8   ` p h P . p     k 
 M `   h    & @    P { H m ` d   S 	` B ` <   7 @ * @ #    0  (    (      
CONNECTDIR BINARY
                -.           ,<    ,~       (DIRNAME . 1)
(PASSWORD . 1)
(FLG . 1)
CONNECTDIR
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER3)     
DIRECTORYNAME BINARY
             -.           ,<    ,~       (DIRNAME . 1)
(STRPTR . 1)
DIRECTORYNAME
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER2)     
DIRECTORYNAMEP BINARY
            -.           ,<    ,~       (DIRNAME . 1)
DIRECTORYNAMEP
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER1)      
DIRECTORYNUMBER BINARY
             -.           ,<    ,~       (DIRNAME . 1)
DIRECTORYNUMBER
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER1)     
USERNAME BINARY
               -.           ,<    ,~       (USERNAME . 1)
(STRPTR . 1)
USERNAME
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER2)    
USERNUMBER BINARY
                -.           ,<    ,~       (USERNAME . 1)
USERNUMBER
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER1)      
USERNAMEP BINARY
            -.           ,<    ,~       (USERNAME . 1)
USERNAMEP
(NIL)
(LINKED-FN-CALL . DIRECTORYBLOCK)
(ENTER1)     
FILDIR BINARY
            -.           -.           ,<w,<   ,<   ,<  (  ,<   ,<   Zw2B   +   	Z   +     wA",   ,<   ,<w~$  Zp  ,   XBp  ,<w,  3B   +   +   	,<p  "  +    Zp  ,      +   (Bv."   7        +     Z    (FILEGROUP . 1)
(FORMATFLG . 1)
100100Q
GTJFN
JFNS
DREVERSE
(URET1 ASZ GUNBOX CONS MKN URET4 KNIL BLKENT ENTER2)   h   P   0   X   0     	     x 	     P            

MKSTRING BINARY
             -.           Z   2B   +   Z   -,   +   Z  ,~   -,   +   Z  [ R  d$ (D|$"  ."   G  ,   ,~   ,   Z   $   Z  2F   +   ,   +   Z   ,       ,   ,~   "  P     (VARIABLE-VALUE-CELL X . 32Q)
(VARIABLE-VALUE-CELL FLG . 30Q)
(VARIABLE-VALUE-CELL RDTBL . 37Q)
(UNP1 IPRE2 IPRE MKSTR1 MKSTRS MKSP SKLA SKSTP KNIL ENTERF)         x   X   H                   0      

BKSYSBUF BINARY
            
    -.           
Z    $  Z   2F   +   ,   +   	Z   ,   +   	 $  1D   $   "      &Z  ,~   R   (VARIABLE-VALUE-CELL X . 22Q)
(VARIABLE-VALUE-CELL FLG . 3)
(VARIABLE-VALUE-CELL RDTBL . 12Q)
(IPRE2 IPRE KNIL ENTERF)                  
(PRETTYCOMPRINT MACCOMS)
(RPAQQ MACCOMS ((DECLARE: FIRST (ADDVARS (NOSWAPFNS KFORK1 RFSTS GDATE DIRECTORYBLOCK))) (FNS MKSTRING
 BKSYSBUF DCHCON DUNPACK TENEX SUBSYS CFORK GCFORKS GDATE KFORK KFORK1 RFSTS GEVEC GPJFN GTJFN RLJFN 
FILDIR GNJFN JFNS DELFILE RENAMEFILE PAGEFAULTS LOADAV GETAB SIXBIT GETER ERSTR IDATE HOSTNUMBER 
HOSTNAME ATMCONC0 STRCONC0 STRCONC1 RPLSTR0 RAND RANDSET CONNECTDIR DIRECTORYNAME DIRECTORYNAMEP 
DIRECTORYNUMBER INTERNALDIRNUM INTERNALUSERNUM USERNAME USERNUMBER RPLSTR1 USERNAMEP) (P (MOVD (QUOTE 
CHARACTER) (QUOTE FCHARACTER)) (SETQ FCHARAR (ARRAY 200Q)) (RPTQ 200Q (SETA FCHARAR RPTN (CHARACTER (
SUB1 RPTN))))) (VARS (USERFORKLST) (CFORKTIME (CLOCK 3)) (USERFORKS (LIST (HARRAY 31Q))) (EXECFORK) (
MACSCRATCHSTRING (QUOTE 
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
)) (SUBSYSSPELLINGS (QUOTE (LISPX EXEC MACRO SRCCOM TECO SNDMSG LISP TELNET FTP NETSTAT READMAIL 
CALENDAR HOSTAT RSEXEC FAIL))) (SUBSYSRESCANFLG)) (ADDVARS (AFTERSYSOUTFORMS (PROGN (CLRHASH USERFORKS
) (SETQ USERFORKLST)))) (BLOCKS * MACBLOCKS)))
(MOVD (QUOTE CHARACTER) (QUOTE FCHARACTER))
(SETQ FCHARAR (ARRAY 200Q))
(RPTQ 200Q (SETA FCHARAR RPTN (CHARACTER (SUB1 RPTN))))
(RPAQQ USERFORKLST NIL)
(RPAQ CFORKTIME (CLOCK 3))
(RPAQ USERFORKS (LIST (HARRAY 31Q)))
(RPAQQ EXECFORK NIL)
(RPAQQ MACSCRATCHSTRING 
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
)
(RPAQQ SUBSYSSPELLINGS (LISPX EXEC MACRO SRCCOM TECO SNDMSG LISP TELNET FTP NETSTAT READMAIL CALENDAR 
HOSTAT RSEXEC FAIL))
(RPAQQ SUBSYSRESCANFLG NIL)
(ADDTOVAR AFTERSYSOUTFORMS (PROGN (CLRHASH USERFORKS) (SETQ USERFORKLST)))
(RPAQQ MACBLOCKS ((DCHCONBLOCK DUNPACK DCHCON (ENTRIES DUNPACK DCHCON) (GLOBALVARS DCHCONGV)) (
FORKBLOCK SUBSYS TENEX CFORK GCFORKS GPJFN (ENTRIES SUBSYS TENEX CFORK) (GLOBALVARS USERFORKS 
USERFORKLST CFORKTIME READBUF EXECFORK SUBSYSSPELLINGS LASTSUBSYS)) (NIL KFORK KFORK1 RFSTS GEVEC 
GTJFN RLJFN DELFILE RENAMEFILE PAGEFAULTS LOADAV GETER RAND RANDSET GETAB RPLSTR0 HOSTNUMBER (
LOCALVARS . T) IDATE USERNUMBER (GLOBALVARS MACSCRATCHSTRING RANDSTATE USERFORKS USERFORKLST) GDATE) (
MACSTRBLOCK ATMCONC0 STRCONC0 STRCONC1 JFNS SIXBIT ERSTR HOSTNAME (ENTRIES ATMCONC0 STRCONC0 STRCONC1 
JFNS SIXBIT ERSTR HOSTNAME)) (DIRECTORYBLOCK CONNECTDIR DIRECTORYNAME DIRECTORYNAMEP DIRECTORYNUMBER 
INTERNALDIRNUM INTERNALUSERNUM USERNAME USERNUMBER RPLSTR1 USERNAMEP (ENTRIES CONNECTDIR DIRECTORYNAME
 DIRECTORYNAMEP DIRECTORYNUMBER USERNAME USERNUMBER USERNAMEP)) (FILDIR FILDIR GNJFN (NOLINKFNS . T)))
)
(PUTPROPS MAC COPYRIGHT ("Xerox Corporation" 3677Q))
NIL
