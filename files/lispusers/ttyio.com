(FILECREATED "24-Oct-82 13:29:53" ("compiled on " <REID.D>TTYIO..33) (2 
. 2) tcompl'd in AILISP.EXE dated "18-Sep-82 01:57:08")
(FILECREATED "15-OCT-82 10:43:01" {SDR2020}PS:<REID.D>TTYIO.;33 19913 
changes to: (VARS TTYIOCOMS) (FNS ASKITEM ASKITEMS) previous date: 
"14-OCT-82 12:28:44" {SDR2020}PS:<REID.D>TTYIO.;32)

ASKFLE BINARY
       E    6    C-.     0     6Z   2B   +   Z  :XB  Z   3B   +   Z  2B  :+   Z  B  :+   2B  ;+   Z  B  ;+   Z   XB  	Z   2B   +   Z  <XB  Z   2B   +   Z  <-,   3B   7    ,   ,<   Z  3B   +   ,<  =,<   ,<  =,   +   Z  >D  >XB  ,<   Z   2B   +    Z  ,<  ,<   Z  ,<  ,<  ?(  ?Z  2B   +    Z  XB  Z   2B   +   #Z   2B   +   4Z   3B   +   0,<  @,<   ,<  @H  AXB  #3B   +   0Z  2B  :+   +Z  'B  :+   .2B  ;+   .Z  *B  ;+   .Z   XB  ,2B   +   4,<  A"  B   BZ   XB   Z   XB  .3B   +   Zp  /   Z  3,~   =C\2	6-v     (VARIABLE-VALUE-CELL PROMPT . 53)
(VARIABLE-VALUE-CELL MODE . 81)
(VARIABLE-VALUE-CELL DEFAULT . 63)
(VARIABLE-VALUE-CELL HELP . 56)
(VARIABLE-VALUE-CELL NULFLG . 68)
(VARIABLE-VALUE-CELL FILE . 107)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 100)
INPUT
INFILEP
OUTPUT
OUTFILEP
"Please type the name of a file."
"File: "
"["
"] ** "
(("** ") . 0)
APPEND
FILE
TTYINC
VERSION
BODY
PACKFILENAME
"Bad response. Please try again."
WRITE
CLEARBUF
(BHC LIST3 CONSNL SKLST KNIL ENTERF)   6                4 8 2   /  & P #    H       X   X        

ASKFN BINARY
        @    5    >-.     (     5Z   B  82B   +   Z   XB  Z   ,<   ,<   Zw-,   +   Zp  Z   2B   +   
 "  +   [  QD   "  +   ZwB  83B   +   ZwZp  ,   XBp  [wXBw+   /  XB  Z   2B   +   Z  2B   +   Z  8XB  Z   2B   +   Z  9-,   3B   7    ,   ,<   Z  3B   +   ,<  9,<   ,<  :,   +    Z  :D  ;XB  ,<   Z   2B   +   +Z   ,<  Z  ,<  Z  2B   +   'Z   ,<   ,<  ;(  <Z  2B   +   *Z  XB  !Z  *B  82B   +   3,<  <Z  +,<   ,<  =&  =   >Z   XB   Z   XB  -3B   +   !Zp  /   Z  1,~    E
@c kBd,p      (VARIABLE-VALUE-CELL PROMPT . 70)
(VARIABLE-VALUE-CELL DEFAULT . 84)
(VARIABLE-VALUE-CELL HELP . 74)
(VARIABLE-VALUE-CELL SPLST . 72)
(VARIABLE-VALUE-CELL FN . 104)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 97)
FNTYP
"Please enter the name of a function."
"Function: "
"["
"] ** "
(("** ") . 0)
APPEND
((COMMAND STRING READ) . 0)
TTYINC
"Sorry, "
" is not a function. Please try again."
WRITE
CLEARBUF
(KT LIST3 CONSNL SKLST BHC COLLCT SKNLST KNIL ENTERF)  x   x   8       H             3   1 P * h #    (  `  h 	    H        

ASKINT BINARY
       y    e    u-.     0     eZ   2B   +   Z  iXB  Z   -,   +   -,   +   ,   ,   XB  +   3B   +   ,<  i,<   ,<  j&  jZ   XB  Z   -,   +   -,   +   ,   ,   XB  +   3B   +   ,<  k,<   ,<  k&  jZ   XB  Z   -,   +   &-,   +   ,   ,   XB  Z  -,   +      ,>  e,>          ,^   /   3"  +   %Z  -,   +   (   ,>  e,>          ,^   /   3b  +   (Z   XB   +   (3B   +   (Z   XB  %Z   2B   +   *Z  l-,   3B   7    ,   ,<   Z  (3B   +   1,<  l,<   ,<  m,   +   1Z  mD  nXB  (,<   Z   2B   +   :Z  2,<  ,<   Z  ,<  ,<  n(  oZ  2B   +   :Z  -XB  3Z  :-,   +   L-,   +   @,<  o-,   +   ?,   ,   XB  :D  jZ  -,   +   F   ?,>  e,>      @    ,^   /   3"  +   LZ  "-,   +   c   B,>  e,>      F    ,^   /   3b  +   c,<  pZ  H,<   -,   +   PZ  p+   ^Z  C-,   +   WZ  I-,   +   W,<  qZ  P,<  ,<  q,<   ,<  r^"  ,   +   ^Z  S-,   +   [,<  r,<   ,<  s,   +   ^,<  sZ  Q,<  ,<  t,   ,<   ,<  t(  j   uZ   XB   Z   XB  M3B   +   3Zp  /   Z  a,~      
a"X(P%WQ 1deY       (VARIABLE-VALUE-CELL PROMPT . 105)
(VARIABLE-VALUE-CELL DEFAULT . 115)
(VARIABLE-VALUE-CELL HELP . 108)
(VARIABLE-VALUE-CELL LB . 175)
(VARIABLE-VALUE-CELL UB . 184)
(VARIABLE-VALUE-CELL NUMB . 200)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 193)
"Please enter an integer."
"WARNING! Invalid lower bound, "
", has been reset to -Infinity."
WRITE
"WARNING! Invalid upper bound, "
", has been reset to +Infinity."
"Integer: "
"["
"] ** "
(("** ") . 0)
APPEND
((COMMAND STRING) . 0)
TTYINC
"Truncated to integer: "
"Sorry, "
" is NOT an Integer. "
" is NOT within the range [ "
" .. "
" ]. "
" is NOT within the range [ "
" to Infinity ]. "
" is NOT within the range [ -Infinity to "
" ]. "
"Please try again."
CLEARBUF
(LIST SKI SKNNM LIST3 CONSNL SKLST BHC MKN IUNBOX SKNI SKNM KNIL ENTERF) 
x    S 
   	p   h [    P   8   H L ` $ h           ?    x   h = x   h   	  B @   (  `     c   a  6 H 3 h ,   ( x & P  H 	  0      

ASKITEM BINARY
    J    =    H-.     0     =@  A  ,~   Z   2B   +   Z  BXB  Z   2B   +   Z   XB  Z   -,   +   
Z   +   B  B3B   +   Z   +   Z  XB   Z  B  B3B   +   Z  +   Z   XB   ,<   Z   2B   +   Z  ,<  Z  ,<  Z  ,<  ,<  C(  CZ  XB  Z   3B   +   Z  3B   +   ;Z  2B   +    Z  2B   +    Z  2B   +   0Z  Z  ,   Z  2B   +   0Z   ,<   ,<  DZ  !F  D2B   +   0Z  3B   +   ,,<   Z  #,<   "   ,   2B   +   0Z  ),<   ,<   $  E,<  E,<   $  E,<   "  FXB  ,3B   +   8Z   3B   +   ;Z  0,<  ,<  F,   ,<   ,<   $  G2B   +   ;Z   XB  3   GZ   XB   3B   +   Zp  /   Z  8,~   1T*$A* #))   (VARIABLE-VALUE-CELL RESTRICTION . 32)
(VARIABLE-VALUE-CELL PROMPT . 40)
(VARIABLE-VALUE-CELL HELP . 44)
(VARIABLE-VALUE-CELL CONFIRMFLG . 100)
(VARIABLE-VALUE-CELL DEFAULT . 121)
(VARIABLE-VALUE-CELL NULFLG . 50)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 116)
(NIL VARIABLE-VALUE-CELL SPLST . 74)
(NIL VARIABLE-VALUE-CELL FN . 78)
"Item: "
FNTYP
((COMMAND STRING NORAISE) . 0)
TTYINC
70
FIXSPELL
PRIN1
" is an invalid response. Please try again."
TERPRI
"OK?"
ASKYN
CLEARBUF
(BHC LIST2 EVCC FMEMB SKA KT KNIL ENTERF)   P   `   8   (      p 0 x .     8 :  8 8 2 @ ( p #   X  (  0     @ 
  p        

ASKITEMS BINARY
     1    (    0-.     (      (Z   2B   +   Z  *XB  Z   2B   +   Z   XB  Z   2B   +   Z  ,<  Z   -,   +   Z   +   B  +3B   +   Z   +   Z  	,<   Z  ,<   ,<  +(  ,XB  ,<   @  ,  (+   'Z`  -,   +   +   &Z  XB   Z  ,<  ,<   ,<   Z   ,<  ,<   ,<   ,  /XB` 2B   +   +   $XB` Z` 3B   +   ",<   Z` ,   XB` ,\  QB  +   $Z` ,   XB` XB` [`  XB`  +   Z` ,~   XB  ,~   !5S 	D    (VARIABLE-VALUE-CELL RESTRICTION . 45)
(VARIABLE-VALUE-CELL PROMPT . 16)
(VARIABLE-VALUE-CELL HELP . 30)
(VARIABLE-VALUE-CELL CONFIRMFLG . 49)
(VARIABLE-VALUE-CELL DEFAULTS . 78)
"Items: "
FNTYP
((NORAISE) . 0)
TTYIN
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL DEFAULT . 44)
NIL
ASKITEM
(CONSNL SKNLST SKA KT KNIL ENTERF)   @ !        
      h   p    `  8   X        

ASKRL BINARY
           o    -.     0     oZ   2B   +   Z  rXB  Z   -,   +   "   +   ,   ,   XB  +   3B   +   ,<  s,<   ,<  s&  tZ   XB  Z   -,   +   "   +   ,   ,   XB  +   3B   +   ,<  t,<   ,<  u&  tZ   XB  Z   -,   +   -"   +   ,   ,   XB  Z  -,   +   %Z  ,<  ,<   @  u @ +   $Z   ,   ,>  n,>   Z   ,       ,^   /   3b  7   Z   ,~   2B   +   ,Z  -,   +   /Z  ,   ,>  n,>   Z  %,       ,^   /   3b  +   /Z   XB  &+   /3B   +   /Z   XB  ,Z   2B   +   1Z  v-,   3B   7    ,   ,<   Z  /3B   +   8,<  w,<   ,<  w,   +   8Z  xD  xXB  /,<   Z   2B   +   AZ  9,<  ,<   Z  ,<  ,<  y(  yZ  2B   +   AZ  4XB  :Z  A-,   +   VZ  -,   +   OZ  A,<  ,<   @  u @ +   NZ  ,   ,>  n,>   Z  ,       ,^   /   3b  7   Z   ,~   2B   +   VZ  (-,   +   lZ  D,   ,>  n,>   Z  O,       ,^   /   3b  +   l,<  zZ  P,<   -,   +   YZ  z+   gZ  C-,   +   aZ  R-,   +   a,<  {Z  Y,<  ,<  {,<   ,<  |^"  ,   +   gZ  ]-,   +   e,<  |,<   ,<  },   +   g,<  }Z  [,<  ,<  ~,   ,<   ,<  ~(  t   Z   XB   Z   XB  V3B   +   :Zp  /   Z  k,~      
a"X($ $@%.E G&)dp@         (VARIABLE-VALUE-CELL PROMPT . 119)
(VARIABLE-VALUE-CELL DEFAULT . 129)
(VARIABLE-VALUE-CELL HELP . 122)
(VARIABLE-VALUE-CELL LB . 194)
(VARIABLE-VALUE-CELL UB . 203)
(VARIABLE-VALUE-CELL NUMB . 219)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 212)
"Please enter a floating point number."
"WARNING! Invalid lower bound, "
", has been reset to -Infinity."
WRITE
"WARNING! Invalid upper bound, "
", has been reset to +Infinity."
(VARIABLE-VALUE-CELL X . 147)
(VARIABLE-VALUE-CELL Y . 143)
"Number: "
"["
"] ** "
(("** ") . 0)
APPEND
((COMMAND STRING) . 0)
TTYINC
"Sorry, "
" is NOT a Number. "
" is NOT within the range [ "
" .. "
" ]. "
" is NOT within the range [ "
" to Infinity ]. "
" is NOT within the range [ -Infinity to "
" ]. "
"Please try again."
CLEARBUF
(LIST SKNNM LIST3 CONSNL SKLST KT BHC MKFN FUNBOX FLOATT SKNM KNIL 
ENTERF)         e     @   (   	` $    n 
X L 8 "          T 
  K 	 *   ! p         p     b H [ 
 D 0 & (  `     l 8 j 	p M  = 8 : X 3  / h - P # P  H 	  0      

ASKYN BINARY
      4    (    2-.           (Z   3B   +   Z   +   Z   XB  Z   2B   +   Z  *-,   3B   7    ,   ,<   ,<  +Z  3B   +   Z  ++   Z  ,,<   ,<  ,,   D  -XB  Z   2B   +   Z  -XB  ,<   Z   2B   +   Z  ,<  ,<  .Z  ,<  ,<  .(  /Z  2B   +   Z  
3B   +   Z  /+   Z  0XB  Z  Z  0,   2B   +   #,<  1"  1   2Z   XB   Z   XB  3B   +   Zp  /   Z  "2B  /+   'Z   ,~   Z   ,~   C=#	'A    (VARIABLE-VALUE-CELL PROMPT . 40)
(VARIABLE-VALUE-CELL DEFAULT . 50)
(VARIABLE-VALUE-CELL HELP . 43)
(VARIABLE-VALUE-CELL RESPONSE . 73)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 66)
"Confirm: "
" ["
YES
NO
"] ** "
APPEND
"Please respond with YES or NO."
(((YES . Y) (NO . N)) . 0)
((COMMAND STRING) . 0)
TTYINC
Y
N
((Y N NIL) . 0)
"Bad response. Please try again."
TTYOUT
CLEARBUF
(BHC FMEMB LIST3 CONSNL SKLST KT KNIL ENTERF)   P   h   p          p     ( 8 "   (  @       P        

DISPLAYHELP BINARY
               -.           @    ,~   Z   -,   +   Z  2B  +   Z  B  +   ,<  ,<  Z  ,<   ,<   ,<   ,<   ,  ,<   "  Z   +   3B   +   3B   +   ,<   ,<   $  ,<   "  Z   +   Z   B  XB   2B   +   Z   ,~   Z  ,~   -p*R)    (VARIABLE-VALUE-CELL KEY . 17)
(NIL VARIABLE-VALUE-CELL RESULT . 45)
;
TTYIO/GET-TXT
0
PRINTPARA
TERPRI
PRIN1
CTRLO.NLSETQ
(KT KNIL SKLST ENTERF)  h  x      @    H  0 
           

TTYINC BINARY
       7    +    5-.     H      +@  1  ,~   ,<   Z   3B   +      2   2,<   ,<   Z   F  3,<   Z   ,<   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   3B   +   Z  ,<  ,<   Z   F  3+   Z  ,<  Z  D  3,<   Z   P  4,<   Zw3B   +   B  4,\   /   +   "Z  ,<  Z  	,<  Z  
,<  Z  ,<  Z  ,<  Z  ,<  Z  ,<  Z   P  4XB   Z  "Z  5,   2B   +   Zp  /   Z   3B   +   )Z   +   )[  #XB  Z  ),~     b# P   (VARIABLE-VALUE-CELL PROMPT . 53)
(VARIABLE-VALUE-CELL SPLST . 55)
(VARIABLE-VALUE-CELL HELP . 57)
(VARIABLE-VALUE-CELL OPTIONS . 59)
(VARIABLE-VALUE-CELL ECHOTOFILE . 61)
(VARIABLE-VALUE-CELL TABS . 63)
(VARIABLE-VALUE-CELL UNREADBUF . 65)
(VARIABLE-VALUE-CELL RDTBL . 67)
(VARIABLE-VALUE-CELL NOSTOREFLG . 77)
(VARIABLE-VALUE-CELL TTYIN-COMMAND-LINE . 83)
(VARIABLE-VALUE-CELL READBUF . 14)
(VARIABLE-VALUE-CELL EOL . 40)
(VARIABLE-VALUE-CELL READTBL . 43)
(NIL VARIABLE-VALUE-CELL LINE . 84)
LINBUF
SYSBUF
CLBUFS
CONCAT
TTYIN
BKBUFS
((IGNORE) . 0)
(EQUAL BHC KT KNIL ENTERF)   P   p         )   %    p   @      

TTYIO/FILE/GET-TXT BINARY
       	    p   -.         @ p@  u  (
,~   [   Z  XB   -,   +   -,   +   nZ  -,   +   n[  -,   +   nZ  ,   $" t,>  o,>   [  	,   .Bx  ,^   /   ,   XB  3B   +   n[  [  [  Z  XB   -,   +   n[  [  [  [  Z  XB   3B   +   n[  [  [  [  [  2B   +   nZ  Z   3B  +   n   1"   +   nZ  ,<   ,<  x$  x2B   +   =,<  y,<   ,<   @  y ` +   *Z   Z  {XB Z  ,<   ,<  x$  {XB  &Z   ,~   2B   +   8Z  |XB   ,<   Z   ,<  ,<  |$  }D  }2B   +   7Z  +,<   ,<   $  ~[  [  [  [  Z  ,<   ,<   $  ~,<  ,<   $  ~Z  2,~   ,<  Z  (,<   ,   ,<   ,<   ,   Z   ,   XB  <Z  9,<   Z  D  Z  2B   +   G@    +   FZ  7,<   Z  =,<  Z   D D ,~   ,~   Z   3B   +   VZ  ?Z   3B  +   LZ   3B   +   O+   NZ  J2B +   OZ   B +   PZ   XB   ,< ,<   ,<   & Z  P3B   +   VZ   3B   +   VB Z   3B +   dZ  HZ  I3B  +   d[  B,<   Z  W,   &" t,   ,<   Z  Z,   &" t   ,   ,   ,\  XB  [  Y[  [  [  Z  ]XD  Z  C,<   Z  c,<  Z  >,<     f,>  o,>      .Bx  ,^   /   ,   H Z  R3B   +   mB Z   ,~   Z  a,~      
$ $l(aCQ R hDmI1   0         (VARIABLE-VALUE-CELL X . 221)
(VARIABLE-VALUE-CELL DESTFL . 202)
(VARIABLE-VALUE-CELL DEF . 142)
(VARIABLE-VALUE-CELL LISPXHIST . 89)
(VARIABLE-VALUE-CELL RESETVARSLST . 122)
(VARIABLE-VALUE-CELL FILERDTBL . 137)
(VARIABLE-VALUE-CELL TTY . 176)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 153)
(VARIABLE-VALUE-CELL DEFAULTFONT . 156)
(VARIABLE-VALUE-CELL COMMENTFONT . 168)
(VARIABLE-VALUE-CELL TTYIO-TXT-FLG . 172)
(NIL VARIABLE-VALUE-CELL ST . 206)
(NIL VARIABLE-VALUE-CELL NC . 209)
(NIL VARIABLE-VALUE-CELL FL . 200)
(NIL VARIABLE-VALUE-CELL STR . 215)
(NIL VARIABLE-VALUE-CELL TEM . 96)
INPUT
OPENP
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OPENFILE
"can't find file "
*LISPXPRINT*
LISTGET1
MEMB
LISPXPRIN1
LISPXPRIN2
" - text items lost"
CLOSEF?
SETFILEPTR
(T VARIABLE-VALUE-CELL TTYIO-TXT-FLG . 0)
READ
/RPLNODE2
ALL
CHANGEFONT
0
ENDLINE1
DONTUPDATE
COPYBYTES
(CONSS1 FGFPTR CONS LIST2 KT CF KNIL MKN BHC IUNBOX SKNM SKLST SKNNM 
ENTERF)   `    ^ @   X   H ;    R x 6   *    &    n P U 
@ R 
 L 	 A @ 0 0 $ 8 " 8     8 ` P     k p   X                      

TTYIO/GET-TXT BINARY
     N    B    L-.          B@  C   ,~   [   Z  XB   -,   +   -,   +   ?Z  -,   +   ?[  -,   +   ?Z  ,   $" t,>  A,>   [  	,   .Bx  ,^   /   ,   XB  3B   +   ?[  [  [  Z  XB   -,   +   ?[  [  [  [  Z  XB   3B   +   ?[  [  [  [  [  2B   +   ?   1"   +   ?Z  ,<   ,<  E$  F2B   +   /,<  F,<   ,<   @  G ` +   (Z   Z  HXB Z  ,<   ,<  E$  IXB  $Z   ,~   2B   +   *Z   ,~   ,<  IZ  &,<   ,   ,<   ,<   ,   Z   ,   XB  -Z  *,<   Z  D  JZ  /,<   ,<      0,>  A,>   [  [  Z  ,   .Bx  ,^   /   ,   ,<      2,>  A,>      .Bx  ,^   /   .  B,   H  J,<   "  KZ   ,~   [  4B  KZ   ,~      
$ MJ Q       (VARIABLE-VALUE-CELL X . 127)
(VARIABLE-VALUE-CELL RESETVARSLST . 93)
(NIL VARIABLE-VALUE-CELL ST . 113)
(NIL VARIABLE-VALUE-CELL NC . 116)
(NIL VARIABLE-VALUE-CELL FL . 98)
(NIL VARIABLE-VALUE-CELL TEM . 0)
INPUT
OPENP
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OPENFILE
CLOSEF?
SETFILEPTR
COPYBYTES
TERPRI
WRITE
(CONS LIST2 KT CF KNIL MKN BHC IUNBOX SKNM SKLST SKNNM ENTERF)  p   ` ,    A x > 0 (    $    -   )   !          =      <       6 X                      

TTYIO/PRINT-TXT BINARY
                -.          Z   @  ,<   Z   F  ,~   @   (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL DEF . 6)
OUTPUT
TTYIO/FILE/GET-TXT
(ENTERF)      

TTYIO/READ-TXT BINARY
    u    _    q-.          _@  b  H,~   Z   3B   +   Z  2B   +   Z   3B   +   Z   3B   +   Z  B  g2B   +   Z  ,<   ,<  g$  h,~   Z  	B  hXB   Z  ,   ,   XB   Z  ,<  Z   D  iXB   3B  i+   Z3B  j+   Z3B  j+   Z3B  k+   Z3B  k+   Z3B  l+   Z3B  l+   Z2B  m+   +   Z2B  m+   Z  ,   ,   XB   +   --,   +   !+   Z2B  g+   "+   -Z   3B   +   (Z   3B   +   (,<   Z  D  n3B   +   (+   ZZ  B  n3B  j+   Z3B  k+   Z2B  o+   -+   ZZ  -,   +   0   ."   ,   XB  -Z  (,<     ..  ^,   XB   D  oZ  0B  +   9Z  0,<     3.  ^,   XB  6D  oZ  5B  p2B  k+   ?Z  9,<   Z  1D  oZ  ,<   ,<  g$  h,~   Z  ;,   ,   XB   ,   ,>  _,>      8    ,^   /   /  ,   XB   Z  ?,<     A/"   ,   D  oZ  =,<   ,<  g   C&" t,   ,<      K&" t   ,   ,   ,<      0,>  _,>      M    ,^   /   /  ,   ,<   Z  F,<   Z  F2B   +   X   p^,  ,   D  q,~   Z  V,<   Z  <D  oZ  I,<   ,<  g$  h,~      $JL@/B|oy Iq   	@        (VARIABLE-VALUE-CELL FL . 180)
(VARIABLE-VALUE-CELL RDTBL . 36)
(VARIABLE-VALUE-CELL LST . 184)
(VARIABLE-VALUE-CELL TTYIO-TXT-FLG . 15)
(VARIABLE-VALUE-CELL CLISPFLG . 69)
(VARIABLE-VALUE-CELL CLISPCHARRAY . 72)
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL VARIABLE-VALUE-CELL START . 163)
(NIL VARIABLE-VALUE-CELL END . 143)
(NIL VARIABLE-VALUE-CELL NCHARS . 170)
(NIL VARIABLE-VALUE-CELL POS . 182)
(NIL VARIABLE-VALUE-CELL TEM . 76)
(NIL VARIABLE-VALUE-CELL FL1 . 0)
(NIL VARIABLE-VALUE-CELL N . 104)
(NIL VARIABLE-VALUE-CELL STRINGSTART . 160)
RANDACCESSP
;
TCONC
POSITION
RATOM
%(
%)
%[
%]
'
%.
DECLARATIONS:
E
%"
STRPOSL
PEEKC
_
SETFILEPTR
SKREAD
INPUT
LCONC
(ALIST CONSS1 BHC IUNBOX ASZ SKNNM SKNM MKN FGFPTR KT KNIL ENTERF)    
    
@ E    B    5    .         U 	x M 	 F  8 8 0 p     A h     	  x   
x ( X $ 0   H      
(PRETTYCOMPRINT TTYIOCOMS)
(RPAQQ TTYIOCOMS ((ADDVARS (GLOBALVARS EOL TTYIN-COMMAND-LINE 
TTYIO-TXT-FLG)) (VARS (TTYIN-COMMAND-LINE) (TTYIO-TXT-FLG T)) (INITVARS 
(EOL (CHARACTER (CHARCODE EOL)))) (RECORDS TXTBOX) (FNS * TTYIOFNS) (
ADDVARS (GLOBALVARS TTYIN-COMMAND-LINE TTYIO-TXT-FLG) (PRETTYPRINTMACROS
 (; . TTYIO/PRINT-TXT))) (P (SETSYNTAX (QUOTE ;) (QUOTE (INFIX ALONE 
NOESC TTYIO/READ-TXT)) FILERDTBL)) (USERMACROS GET;) (ADVISE SPRINTT)))
(ADDTOVAR GLOBALVARS EOL TTYIN-COMMAND-LINE TTYIO-TXT-FLG)
(RPAQQ TTYIN-COMMAND-LINE NIL)
(RPAQQ TTYIO-TXT-FLG T)
(RPAQ? EOL (CHARACTER (CHARCODE EOL)))
(RECORD TXTBOX (HEAD START OFFSET NCHARS FILE . REST) HEAD _ (QUOTE ;))
(RPAQQ TTYIOFNS (ASKFLE ASKFN ASKINT ASKITEM ASKITEMS ASKRL ASKYN 
DISPLAYHELP TTYINC TTYIO/FILE/GET-TXT TTYIO/GET-TXT TTYIO/PRINT-TXT 
TTYIO/READ-TXT))
(ADDTOVAR GLOBALVARS TTYIN-COMMAND-LINE TTYIO-TXT-FLG)
(ADDTOVAR PRETTYPRINTMACROS (; . TTYIO/PRINT-TXT))
(SETSYNTAX (QUOTE ;) (QUOTE (INFIX ALONE NOESC TTYIO/READ-TXT)) 
FILERDTBL)
(ADDTOVAR USERMACROS (GET; NIL (BIND (IF (NEQ (SETQ #1 (
TTYIO/FILE/GET-TXT (##))) (##)) ((I : #1) 1) NIL))))
(PUTPROPS SPRINTT READVICE (NIL (AROUND NIL (PROG ((X (EVALV (CAR (
ARGLIST (QUOTE SPRINTT)))))) (RETURN (COND ((AND (LISTP X) (EQ (CAR X) (
QUOTE ;))) (DISPLAYHELP X)) (T *)))))))
(READVISE SPRINTT)
NIL
