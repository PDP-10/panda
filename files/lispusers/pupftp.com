(FILECREATED "26-Aug-84 01:07:06" ("compiled on " <LISPUSERS>PUPFTP..11) (2 . 2) brecompiled changes: PUPFTP in 
"INTERLISP-10  24-Aug-84 ..." dated "24-Aug-84 01:43:38")
(FILECREATED "26-Aug-84 01:06:47" <LISPUSERS>PUPFTP..11 22682 changes to: (FNS PUPFTP) previous date: "25-JUL-84 00:44:50" 
<LISPUSERS>PUPFTP..10)
MTPA0007 BINARY
     
        
-.          Z   3B   +   ,<` "  B  	,<`  "  	,<` "  	,~   j   (IN . 1)
(OUT . 1)
(VARIABLE-VALUE-CELL RESETSTATE . 3)
OPNJFN
SENDPUPABORT
CLOSEF?
(KNIL ENTER2)    0      
MTP BINARY
    
   R   -.     (     R-.     (T   WZ   ,<   @ W   +  ?Z   ,<   ,< X,< Y,<   @ Y ` +  8Z   Z [XB ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,< [Z   XB   ZwzZ?2B   +    Z?~Z   ,   Z  2B   +   Z   Z  ,   Z  2B   +   Zwz,<?~ \ZwzXB?3B   +    [?b ]ZwzXB?Z?ZwzXB?,<   ,<?~,< ^,< ^ _XBw}b `XBw| w|   ^+       ,   ,<   Zwz,<?~,< ^,< a _XBw}b `XBw|Z a,<   ,<w|,<w|,   XBw~,<   ,<   ,   Z  ,   XB  /,< bZwzZ?XBw~,   ,<   ,< bZwyZ?2B   +   7Z c,   ,<   ,< cZwyZ8  2B   +   ;Z?,   ,   XBw~ w|,> Q,>   Z"  ,<   ,< d d,       ,^   /     Q   ,<w~,<w{ eZ   3B   +   G,<w~b `d e w|,> Q,>   Z"  ,<   ,< d d,       ,^   /     Q   ZwzZ?~3B   +   R,<   ,< ^ fZwzXB?~,< g,< h,< h,<    i,<   ,< j,< j fXBw{,< k,<   ,   ,<   ,<   ,   Z  0,   XB  Z,<   ,<w| k0B  +   w."   ,   XBw,<w| lXBw~Z  D3B   +   d,<w~d m,<w| k0B  +  ,<w{,< [ n,<w|,<wz `,<   , GZ oZw~7   [  Z  Z  1H  +   o2D   +   l[  ,<   Zwy,<?~, ?,< pZwy,<?~ pZw{,   ,   ,<   Zwy,<?~ p,< qZwy,<?~ pZ rZw~7   [  Z  Z  1H  +   ~2D   +   {[  Z  2B r+  ^"   +  ^"   ,> Q,>   Z sZw~7   [  Z  Z  1H  +  2D   +  [  Z  2B r+  ^"  +  ^"   .Bx  ,^   /   ,   ,<   Zwy,<?~ pZwz,<?~ s,<w{Zwy,<?~,< [Zwy,   ,   h t+    u+  0B  +  +  0B  +  +    u+   \Zp  /   +  /   +  /   +  0 w|      ,   ,<   ,< v wXBw1B  +  $0B  +  .,<w| x,<w| yZwz,<?~,<   ,<   ,< z \ZwzXB?[?b ]ZwzXB?Z?ZwzXB?+   1,<w} zb {b |,<w} },<w} }Zw{3B   +  4b }Zwz,<?~ ~/  ZwXB8 Z   ,~   3B   +  :Z   +  :Z XB` d  Z` 3B   +  >  ,~   Z` ,~   +    Zw,<   ,<w p[w3B   +    ,< ,<w p[w,<   ,<w, ?+    ,> Q,>   w    Dx  5D K   2`d   5  O p   x     0D  5  H $     5  H,^  /   +           )U  A  :@d FKF,uh E+ 3M(
4"o*C)LPH$                 (HOST . 1)
(TOFILE . 1)
(USER . 1)
(PWD . 1)
(MAILBOX . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 6)
(VARIABLE-VALUE-CELL RESETVARSLST . 183)
(VARIABLE-VALUE-CELL LASTTRACED . 33)
(VARIABLE-VALUE-CELL LOGINPASSWORDS . 45)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 196)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
0
(NIL)
(LINKED-FN-CALL . \INTERNAL/GETPASSWORD)
(NIL)
(LINKED-FN-CALL . \DECRYPT.PWD)
MAIL
OUTPUT
(NIL)
(LINKED-FN-CALL . PUPOPENF)
(NIL)
(LINKED-FN-CALL . OPNJFN)
INPUT
MTPA0007
USER-NAME
USER-PASSWORD
""
MAILBOX
U
(NIL)
(LINKED-FN-CALL . PRINTPUPMARK)
(NIL)
(LINKED-FN-CALL . PRINTPLIST)
(NIL)
(LINKED-FN-CALL . OPENFILE)
BODY
MTP-TEMPORARY.SCRATCH
TEMPORARY
(NIL)
(LINKED-FN-CALL . PACKFILENAME)
BOTH
NEW
DELFILE
(NIL)
(LINKED-FN-CALL . PUPGETMARK)
(NIL)
(LINKED-FN-CALL . READPLIST)
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . SETFILEPTR)
DATE-RECEIVED
","
(NIL)
(LINKED-FN-CALL . PRIN3)
";00000000000"
OPENED
YES
DELETED
(NIL)
(LINKED-FN-CALL . TERPRI)
(NIL)
(LINKED-FN-CALL . COPYBYTES)
(NIL)
(LINKED-FN-CALL . FTPHELP)
S
(NIL)
(LINKED-FN-CALL . PRINTPUPCODE)
(NIL)
(LINKED-FN-CALL . GOBBLECHARS)
(NIL)
(LINKED-FN-CALL . CHECKEOC)
" for mail "
(NIL)
(LINKED-FN-CALL . PUPGETSTRING)
(NIL)
(LINKED-FN-CALL . CONCAT)
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . CLOSEF?)
(NIL)
(LINKED-FN-CALL . CLOSEF)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
" "
(URET2 URET5 FGFPTR KT BHC IUNBOX ASZ ALIST3 ALIST2 CONS LIST2 LIST3 MKN GETHSH CF KNIL BLKENT ENTER5)   G 8       H u   8   U   Q h P X M (   	@ A   $ 0 x f h J p   H   @ 8 @   @ 1    [  0    .     P ` ` p         
   C P: 3  h o 8 ] ( P ` : h /     `    x  h  X  H      (      

PUPFTPA0005 BINARY
     
        
-.          Z   3B   +   Z   B  B  	Z   B  	Z  B  	,~   j   (VARIABLE-VALUE-CELL IN . 9)
(VARIABLE-VALUE-CELL OUT . 11)
(VARIABLE-VALUE-CELL RESETSTATE . 3)
OPNJFN
SENDPUPABORT
CLOSEF?
(KNIL ENTERF)   0      

PUPFTP BINARY
       7   s-.     8    87Z   ,<   @ >  ,~   Z   ,<   ,< ?,< @,<   @ @ ` +  /Z   Z BXB Z   ,<   @ B  `+  -Z   XB   Z   3B   +   0B  +   +   0B  +   Z IXB   +   ,<   ,< I$ JZ   3B J+   2B K+   Z KZ   ,   XB   Z  +   62B K+   Z KZ   ,   XB  Z  +   62B L+   +   63B L+   !2B M+   !+   62B   +   #Z L+   62B   +   %Z M+   62B M+   (Z   XB  Z  +   62B N+   1Z  	,<  ,<   Z   ,<   "  ,   XB   2B   +   /Z   ,~   Z   XB  'Z  '+   6-,   +   4[  0XB  Z  2+   6,< N,<   ,   B OXB  3Z   2B   +   CZ   Z   ,   Z  2B   +   ?Z   Z  9,   Z  2B   +   ?Z  8B OXB  73B   +   C[  ?B PXB   Z  AXB  B,<   Z  >,<  ,< P,< M( QXB   B QXB  +   G   ^+       ,   ,<   Z  D,<   ,< P,< L( QXB   B QXB   Z R,<   Z  M,<   Z  F,<  ,   XB   ,<   ,<   ,   Z  ,   XB  T   H,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6      V,> 6,>   ,< S,< R$ T,       ,^   /         \,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z  NB T0B  +   s   h      ,   ,<   ,< U$ T1B   +   o  UZ  jB VZ  oB V2B   +   t  U+   t  U,< WZ  CXB   ,   ,<   ,< WZ  B2B   +   yZ X,   ,<   Z  --,   +   },< X,<   ,   ,   ,   ,   XB   Z  03B   +  ,< Y,<   ,   ,<   Z  2B I+  ,< YZ  ,<  ,   Z  ~,   +  Z  63B L+  
Z +  ,< ZZ   ,<  ,   Z 	,   ,   XB Z  33B   +  ,<   @ Z  +  Z`  -,   +  +  Z  XB   -,   +  +  ,< \Z ,   Z ,   XB [`  XB`  +  Z` ,~      b,> 6,>   Z 3B N+  2B M+   Z"  +  *3B L+  "2B M+  #Z"   +  *3B K+  %2B L+  &Z"  +  *3B J+  (2B K+  )Z"  +  *  U,<   ,< R$ S,       ,^   /     6   Z ,<   Z D \Z   3B   +  4Z .,<  B QD \  /,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z 2B M+  ^Z  pB T0B  +  \  <      ,   ,<   ,< U$ TXB   Z >B VZ BB V  4,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z  Q,<   ,< ]Z  PF ]Z L,<   ,< ^,< ^& _Z J,<   ,< _Z `F _Z O,<   ,< `Z 
F aZ  R,<   Z aD bZ  z,<   Z  K,<  Z R,<  Z 2,<  ,<   * b,~   0B  +  ]+  	  U+  	2B N+  Z CB T0B  +    _      ,   ,<   ,< U$ TXB AZ aB VZ eB V  D,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z  ),<   Z X,<   "   ,   2B   +  sZ gB c+  +  r,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     s,> 6,>   ,< c,< R$ T,       ,^   /      Z n,<   ,<   Z z,<   "  ,   XB V2B   +   t  ,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   +  +0B  +  +  	  U+  	2B L+  DZ fB T0B  +  ?Z MB dXB YZ 03B   +  Z ,<  D dZ B V  ,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     ,> 6,>   ,< c,< R$ T,       ,^   /        ,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z B T0B  +  >Z ,<   ,< ]Z oF eZ +,<   ,< eZ F eZ ,,<   ,< ^,< ^& _Z -,<   ,< _Z `F _Z 2,<   ,< `Z SF aZ T,<   Z aD bZ ,<   Z W,<  Z 5,<  Z /H b,~     U+  	0B  +  @+  	0B  +  B+   0B  +  C+   t  U+  	2B M+  	Z )B T0B  +  Z ;B dXB <Z 3B   +  LZ H,<  D dZ EB VZ JB f3B   +  l  ",> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     O,> 6,>   ,< c,< R$ T,       ,^   /        U,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z LB T0B  +  kZ G,<   Z MD fZ aB VZ eB T0B  +  jZ fB V+    U+    U+  ,<   " g  [,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     m,> 6,>   ,< c,< R$ T,       ,^   /        s,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z hB T0B  +  +  G0B  +  +  +  U+  0B  +  +  	0B  +  +  (  U  g+  	3B K+  3B L+  3B J+  2B K+  	Z B T0B  +  Z B V+  :0B  +  @ h  +  Z cB dXB dZ :2B L+  Z Z   ,   XB +  zZ   ,<   Z KZ 7   [  Z  Z  1H  +  2D   +  [  Z  B iXB ,\  3B  +  *,< j,<   $ dZ :,<   ,<   $ d,< j,<   $ dZ  ,<   ,<   $ d,< k,<   $ d[ 2B   +  ,Z  ,<   Zp  -,   +  /+  CZp  ,<   @ k   +  BZ -,   +  4B d,~   Z 1Z 7   [  Z  Z  1H  +  92D   +  5[  XB   3B   +  A[ 4Z  ,<   [ ;[  Z  ,<   ,<   & lZ 9,<   ,<   $ l,~   [p  XBp  +  -/   Z 3B J+  F2B K+  xZ B V2B   +  I  UZ D3B J+  N,<   ,<   ,< m,<   ,<   * m2B n+  e  y,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     N,> 6,>   ,< c,< R$ T,       ,^   /        U,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   Z FB T0B  +  dZ aB V+  x  U+  x  Z,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6     e,> 6,>   ,< n,< R$ T,       ,^   /        l,> 6,>   Z"  ,<   ,< R$ S,       ,^   /     6   ,< c,< c,<   & lZ cB T0B  +  |+  0B  +  Z B oZ 0B oZ Z   2B   +   "  +  [  QD   "  ,~     UZ   ,~   ,~   0B  +  +  	  U+  	  U  z      ,   ,<   ,< U$ TXB e1B  +  0B  +  Z 	B VZ B VZ #,<   Z  t3B   +  Z   +  Z   D OXB [ B PXB  wZ XB +   t1B  !+   0B   +  +   0B   +  (Z I2B L+  (Z B V+  +Z 2B o+  (Z 62B p+  (Z 2B L+  (Z pXB !Z B VZ %B V+   tZ 9,<   Z }B qB qD JZ )B oZ ~B o+   .XB   Z   ,~   3B   +  1Z   +  1Z JXB   D rZ 13B   +  5  r,~   Z -,~          (P[[px?w|8FDP :@ #	8a+pLXS	w_>lI#j*0ErLTTa -` 0WjDT0KJ)N)@-[u"*QB\0J_T0K@o7jm&	HhhiS (@k2:K@F	/F	8ajjE*BR-[91k&                  (VARIABLE-VALUE-CELL HOST . 1059)
(VARIABLE-VALUE-CELL FILE . 511)
(VARIABLE-VALUE-CELL ACCESS . 1094)
(VARIABLE-VALUE-CELL USER . 1073)
(VARIABLE-VALUE-CELL PWD . 1071)
(VARIABLE-VALUE-CELL ACCT . 0)
(VARIABLE-VALUE-CELL BYTESIZE . 265)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 171)
(VARIABLE-VALUE-CELL LASTTRACED . 25)
(VARIABLE-VALUE-CELL DELFIELDS . 46)
(VARIABLE-VALUE-CELL DIRFIELDS . 856)
(VARIABLE-VALUE-CELL LOGINPASSWORDS . 120)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 658)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 1130)
(NIL VARIABLE-VALUE-CELL RESETZ . 1125)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(VARIABLE-VALUE-CELL FL . 1104)
(NIL VARIABLE-VALUE-CELL IN . 1110)
(NIL VARIABLE-VALUE-CELL OUT . 1112)
(NIL VARIABLE-VALUE-CELL CODE . 1050)
(NIL VARIABLE-VALUE-CELL IJ . 1101)
(NIL VARIABLE-VALUE-CELL OJ . 995)
(NIL VARIABLE-VALUE-CELL TEM . 895)
(NIL VARIABLE-VALUE-CELL PLIST . 873)
(NIL VARIABLE-VALUE-CELL CLOSEFORM . 623)
(NIL VARIABLE-VALUE-CELL LASTUSER . 234)
(CRLF VARIABLE-VALUE-CELL EOL . 1098)
(TEXT VARIABLE-VALUE-CELL TYPE . 1088)
(NIL VARIABLE-VALUE-CELL DF . 853)
BINARY
"invalid PUP bytesize"
ERROR
DELETE
DELETE?
DIRECTORY
LIST
INPUT
OUTPUT
MAP
MAPSTORE
27
ERRORX
\INTERNAL/GETPASSWORD
\DECRYPT.PWD
FTP
PUPOPENF
OPNJFN
PUPFTPA0005
U
PRINTPUPMARK
1
PRINTPUPCODE
PUPGETMARK
S
FTPHELP
GOBBLECHARS
CHECKEOC
USER-NAME
USER-PASSWORD
""
SERVER-FILENAME
TYPE
BYTE-SIZE
END-OF-LINE-CONVENTION
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 889)
DESIRED-PROPERTY
PRINTPLIST
MATE
PUT
CLOSEALL
NO
WHENCLOSE
BEFORE
CLOSEPUPFTP
EOL
SETFILEINFO
NILL
RPLACA
CHLNM
SENDPUPABORT
0
READPLIST
PRIN1
PUTPROP
PLIST
BROWNIEUSEFILEP
BROWNIEUSEFILE
PRODUCE
HELP
(NIL VARIABLE-VALUE-CELL LASTDIR . 846)
(NIL VARIABLE-VALUE-CELL TEM . 0)
(NIL VARIABLE-VALUE-CELL VAL . 1023)
U-CASE
"{"
"}<"
">
"
(VARIABLE-VALUE-CELL X . 0)
TAB
MAPRINT
"? "
ASKUSER
Y
69
CLOSEF?
TEXT
CRLF
CR
PUPGETSTRING
CONCAT
RESETRESTORE
ERROR!
(COLLCT CONSS1 CONSNL SKNLST ALIST2 BHC IUNBOX LIST3 MKN GETHSH LIST2 SKLST EVCC KT CONS ASZ CF KNIL ENTERF) 3    `  h   `   60. X 8     z h   >xq =8` ;(T 8H /s ,[ *P( $( !( m  : ` h   \   v > j ;pY :0} .xq +xY *8' $ !~  l 8 H f  Z    S    @@ P K    = (   H ( } 
P 6    2     -   / BPz 9XA 7x* 5' 4X# 8 $    X 
`     CP C( Ah ?X| >@h <0] : 1p 0X 0{ -xh ,8] *G (0A ( + $P "  pv  a PF `6 & 8  p j H X      	   4 F0 B` @` @M 9@K 9; 7, 3hm )pJ "@  r    x ( T H A h < 8 8  / h + x " h   p      
READPLIST BINARY
    7    *    5-.           *Z   B  +,<   ,<  +[p  2B   +   ,<p  ,<  ,"  ,,<   @  -   +   ,<  -,<   Z   F  .,<  .,<  /Z  	F  /,<  0,<  0Z  F  /,<  1,<   Z  F  1Z  ,~       ,\   XD  Z   QD  Zp  /   D  2,<   @  2   ,~   Z   ,<   Zp  -,   +   +   )Zp  ,<   @  3   +   'Z   ,<   Z  3B   +   &Z  ,<   ,<  3$  42B   +   &Z  ,<   ,<  3Z  "B  3F  4+   &Z   D  5,~   [p  XBp  +   /   Z  ,~   Ynd 2B4:   (VARIABLE-VALUE-CELL IN . 3)
PUPGETSTRING
((NIL) . 0)
ORIG
COPYREADTABLE
(VARIABLE-VALUE-CELL R . 33)
((40 41) . 0)
SETBRK
'
ESCAPE
SETSYNTAX
%%
OTHER
((32 0) . 0)
SETSEPR
READ
(VARIABLE-VALUE-CELL PLIST . 83)
(VARIABLE-VALUE-CELL PRP . 72)
U-CASE
GETPROP
PUTPROP
RPLACA
(SKNLST BHC KT KNIL ENTERF)               ' (    
  P      
PRINTPLIST BINARY
        -    )    ,-.           )       '   Z   ,<   Zp  -,   +   +   $Zp  ,<   @  *   +   #@  *  +   !Z   ,<   Zp  -,   +   +    Zp  ,<   @  +   +      ,>  (,>           ,^   /      Z"  XB  Z   B  +,   4H       0D  1D  +   1D  +      =h  +   ,>  (,>   $     ,^  /   +   ,~   [p  XBp  +         (   ,~   [p  XBp  +   /      !   (   Z   ,~              ZT!.(H    (VARIABLE-VALUE-CELL L . 6)
(VARIABLE-VALUE-CELL OJ . 74)
(VARIABLE-VALUE-CELL X . 20)
(40 VARIABLE-VALUE-CELL PRE . 40)
(VARIABLE-VALUE-CELL XL . 41)
MKSTRING
(KNIL UPATM ASZ BHC URET1 SKNLST ENTERF)   '            % p           X      
CHECKEOC BINARY
             -.           Z   B  2B   +                  ,   ,<   Z"  ,\  2B  7   7   +   Z"  ,<   ,<  $      $    &      2d$ 0    3Z   ,~       	P0      (VARIABLE-VALUE-CELL IN . 24)
PUPATMARKP
FTPHELP
S
PRINTPUPMARK
(KT ASZ MKN KNIL ENTERF)     
          p           
PUPATMARKP BINARY
             -.                     0B   +               2   ,>  ,>      ABx  ,^   /   1B   +   7   Z   ,~         +    Z   ,~               Y!  (VARIABLE-VALUE-CELL IN . 24)
(KNIL KT BHC ENTERF)    @   8          
GOBBLECHARS BINARY
               -.          Z   3B   +   @    +   ,<  "            ,   XB   0B   +               2   ,>  ,>      ABx  ,^   /   0B   +   Z  B  ,<   Z  D  +   ,~   +      	   5D     2ad   5   Z   ,~               8R    (VARIABLE-VALUE-CELL IN . 39)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 34)
(NIL VARIABLE-VALUE-CELL CH . 31)
S
PUPDEBUGCHECK
CHARACTER
PRIN3
(BHC ASZ MKN KNIL ENTERF)      	          0      
PUPGETSTRING BINARY
              -.          Z   @  D  ,<   @     ,~   Z  B  2B   +   ,<  "  Z   3B   +   Z   ,<  D  Z   3B   +   Z  	B  Z  ,~   EdJ      (VARIABLE-VALUE-CELL IN . 10)
(VARIABLE-VALUE-CELL UCASE . 22)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 16)
DUMMYSTRING
STRINGFROMFILE
(VARIABLE-VALUE-CELL STR . 27)
EOFP
"PLIST too long"
FTPHELP
PRIN3
UCASESTRING
(KNIL ENTERF)           
PUPGETMARK BINARY
             -.           Z   B  2B   +                  ,   ,<   ,<  $  ,<       $    &      2d$ 0    3,\   ,~       	P`  (VARIABLE-VALUE-CELL IJ . 17)
PUPATMARKP
FTPHELP
S
PRINTPUPMARK
(MKN KNIL ENTERF)              
CLOSEPUPFTP BINARY
    4    *    2-.           *Z   ,<   ,<  *$  +,<   Z  B  +,<   @  , @ ,~   Z  ,<   ,<  *$  -Z  ,<   ,<  -$  -Z  	,<   ,<  .$  .3B   +   #    ,>  ),>   Z"  ,<   ,<  /$  /,       ,^   /      )      ,>  ),>   ,<  0,<  /$  0,       ,^   /         ,>  ),>   Z"  ,<   ,<  /$  /,       ,^   /      )   Z   3B   +   (B  1+   (Z   3B   +   (B  .3B   +   (Z  B  1Z  #B  2Z   ,~          M#	8aj@   (VARIABLE-VALUE-CELL FILE . 22)
MATE
GETPROP
OPNJFN
(VARIABLE-VALUE-CELL MATE . 78)
(VARIABLE-VALUE-CELL OJ . 76)
REMPROP
PLIST
OUTPUT
OPENP
U
PRINTPUPMARK
0
PRINTPUPCODE
CLOSEF?
SENDPUPABORT
CLOSEF
(BHC IUNBOX ASZ KNIL ENTERF)     @   h  (   H     ) ` $          
CHLNM BINARY
             -.     (      Z   ,<   ,<  Z   ,<  ,<  Z  Z   7   [  Z  Z  1H  +   	2D   +   [  Z  2B   +   Z   H  ,<   Z   F  ,~   0)      (VARIABLE-VALUE-CELL FILE . 23)
(VARIABLE-VALUE-CELL HOST . 6)
(VARIABLE-VALUE-CELL F1 . 3)
(VARIABLE-VALUE-CELL PLIST . 10)
(VARIABLE-VALUE-CELL OUTFLG . 26)
"{"
"}"
SERVER-FILENAME
PACK*
CHANGEFILENAME
(KNIL ENTERF)         
SENDPUPABORT BINARY
              -.                $      
`d  +    $  
 &    (      ,~   @   (VARIABLE-VALUE-CELL OJ . 3)
(ENTERF)      
PRINTPUPCODE BINARY
              -.          Z   3B   +   Z   B  ,<  "  ,<  Z  D  Z   ,<   Z  D  ,<   ,<  Z  D  ,\   ,<  "  Z  ,~   z0      (VARIABLE-VALUE-CELL CODE . 24)
(VARIABLE-VALUE-CELL FROM . 6)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 19)
PUPDEBUGCHECK
8
RADIX
"<"
PRIN1
PRIN2
"> "
10
(KNIL ENTERF)         
PRINTPUPMARK BINARY
                -.          Z   3B   +   Z   B  ,<  Z  D  Z   Z   7   [  Z  Z  1H  +   
2D   +   [  Z  B  ,<   Z  D  ,<  Z  D  Z  ,~   h      (VARIABLE-VALUE-CELL N . 30)
(VARIABLE-VALUE-CELL FROM . 6)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 28)
(VARIABLE-VALUE-CELL MARKTYPES . 12)
PUPDEBUGCHECK
"["
PRIN1
L-CASE
"]"
(KNIL ENTERF)   (        
PUPDEBUGCHECK BINARY
               -.          Z   3B   +   Z   ,<   Z   XB  ,\  2B  +   Z   ,~   Z   ,<  ,<  Z  F  Z  ,<   Z  	D  ,<  Z  D  ,~   Z   ,~         (VARIABLE-VALUE-CELL WHO . 20)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 25)
(VARIABLE-VALUE-CELL LASTTRACED . 9)
0
TAB
PRIN1
": "
(KT KNIL ENTERF)        x        
(PRETTYCOMPRINT PUPFTPCOMS)
(RPAQQ PUPFTPCOMS ((FNS PUPFTP READPLIST PRINLST PRINTPLIST CHECKEOC COPYCHARS PUPATMARKP GOBBLECHARS PUPGETSTRING PUPGETMARK MTP 
CLOSEPUPFTP CHLNM SENDPUPABORT) (VARS DIRFIELDS DELFIELDS (LASTTRACED)) (* for debugging) (FNS PRINTPUPCODE PRINTPUPMARK 
PUPDEBUGCHECK) (ADDVARS (REMOTEINFOLST (AUTHOR AUTHOR 11) (LENGTH SIZE 9) (SIZE SIZE 9) (WRITEDATE WRITE-DATE 23) (READDATE 
READ-DATE 23) (CREATIONDATE CREATION-DATE 23) (BYTESIZE BYTE-SIZE 9) (TYPE TYPE 10))) (DECLARE: EVAL@COMPILE (VARS MARKTYPES) 
DONTCOPY (PROP MACRO MARK# READMARK MARK CLEARMARK PUTCODE READCODE) DONTEVAL@COMPILE (TEMPLATES MARK# READMARK MARK CLEARMARK 
PUTCODE READCODE)) (MACROS .COERCEUSER.) (BLOCKS (MTP MTP PRINLST COPYCHARS)) (FILES STRINGFNS FTP PUPBSP) (DECLARE: EVAL@COMPILE 
DONTCOPY (FILES (LOADCOMP) FTP))))
(RPAQQ DIRFIELDS ((NAME-BODY 0 0) ";" (VERSION 0 T) (WRITE-DATE 30 1)))
(RPAQQ DELFIELDS ("delete " (NAME-BODY 0 T) ";" (VERSION 0 T)))
(RPAQQ LASTTRACED NIL)
(ADDTOVAR REMOTEINFOLST (AUTHOR AUTHOR 11) (LENGTH SIZE 9) (SIZE SIZE 9) (WRITEDATE WRITE-DATE 23) (READDATE READ-DATE 23) (
CREATIONDATE CREATION-DATE 23) (BYTESIZE BYTE-SIZE 9) (TYPE TYPE 10))
(RPAQQ MARKTYPES ((1 RETRIEVE) (2 STORE) (3 YES) (4 NO) (5 HERE-IS-FILE) (6 EOC) (7 COMMENT) (8 VERSION) (10 DIRECTORY) (11 
HERE-IS-PLIST) (13 ABORT) (14 DELETE) (16 STORE-MAIL) (17 RETRIEVE-MAIL) (18 FLUSH-MAILBOX) (19 MAILBOX-EXCEPTION) (? NEWSTORE)))
(PUTPROPS .COERCEUSER. MACRO ((HOST USER PWD) (COND ((AND (NOT USER) (SETQ USER (OR (CAR (GETHASH HOST LOGINPASSWORDS)) (CAR (
GETHASH NIL LOGINPASSWORDS)) (\INTERNAL/GETPASSWORD HOST)))) (SETQ PWD (\DECRYPT.PWD (CDR USER))) (SETQ USER (CAR USER))))))
(FILESLOAD STRINGFNS FTP PUPBSP)
(PUTPROPS PUPFTP COPYRIGHT ("Xerox Corporation" 1981 1982 1984))
NIL
