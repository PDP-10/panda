(FILECREATED "24-Oct-82 13:29:53" ("compiled on " <REID.D>TTYIO..33) (2 
. 2) tcompl'd in AILISP.EXE dated "18-Sep-82 01:57:08")
(FILECREATED "15-OCT-82 10:43:01" {SDR2020}PS:<REID.D>TTYIO.;33 19913 
changes to: (VARS TTYIOCOMS) (FNS ASKITEM ASKITEMS) previous date: 
"14-OCT-82 12:28:44" {SDR2020}PS:<REID.D>TTYIO.;32)

ASKFLE BINARY
       E    �    C-.     0     �Z   2B   +   Z  :XB  �Z   3B   +   Z  �2B  :+   �Z  B  �+   �2B  ;+   Z  B  �+   �Z   XB  �Z   2B   +   �Z  <XB  Z   2B   +   �Z  �-,   3B   7    ,   ,<  �Z  �3B   +   ,<  =,<  �,<  �,   +   �Z  >D  �XB  �,<   Z   2B   +   �Z  ,<  ,<   Z  ,<  ,<  ?(  �Z  2B   +    Z  XB  Z   2B   +   �Z   2B   +   �Z  �3B   +   0,<  @,<   ,<  �H  AXB  �3B   +   0Z  �2B  :+   �Z  'B  �+   �2B  ;+   .Z  *B  �+   �Z   XB  �2B   +   �,<  �"  B   �Z   XB   Z   XB  �3B   +   Zp  /  �Z  3,~   =C\2	6-v     (VARIABLE-VALUE-CELL PROMPT . 53)
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
(BHC LIST3 CONSNL SKLST KNIL ENTERF)   6            �    � 8 �   /  � P �   � H �  �    X   X        

ASKFN BINARY
        �    5    �-.     (     5Z   B  82B   +   �Z   XB  �Z   ,<  �,<   Zw�-,   +   �Zp  Z   2B   +   � "  +   [  QD   "  +   Zw�B  83B   +   �Zw�Zp  ,   XBp  [w�XBw�+   /  XB  �Z   2B   +   Z  �2B   +   Z  �XB  Z   2B   +   Z  9-,   3B   7    ,   ,<  �Z  3B   +   �,<  �,<  �,<  :,   +    Z  �D  ;XB  ,<   Z   2B   +   +Z  �,<  Z  �,<  Z  �2B   +   'Z   ,<  �,<  �(  <Z  2B   +   �Z  �XB  �Z  �B  82B   +   3,<  �Z  +,<  �,<  =&  �   >Z   XB   Z   XB  �3B   +   �Zp  /  �Z  �,~    E
�c kBd,p      (VARIABLE-VALUE-CELL PROMPT . 70)
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
(KT LIST3 CONSNL SKLST BHC COLLCT SKNLST KNIL ENTERF)  x   x   8       H     �    �    3   1 P * h #    ( � ` � h �  �  H �       

ASKINT BINARY
       y    �    �-.     0     �Z   2B   +   Z  iXB  �Z   -,   +   �-,   +   �,   ,   XB  +   �3B   +   �,<  �,<  �,<  j&  �Z   XB  �Z   -,   +   -,   +   ,   ,   XB  �+   3B   +   ,<  k,<  �,<  �&  �Z   XB  Z   -,   +   �-,   +   �,   ,   XB  Z  -,   +      �,>  e,>  �      �,^  �/  �3"  +   %Z  �-,   +   �   �,>  e,>  �      �,^  �/  �3b  +   �Z   XB  �+   �3B   +   �Z   XB  �Z   2B   +   �Z  l-,   3B   7    ,   ,<  �Z  (3B   +   1,<  �,<  �,<  m,   +   �Z  �D  nXB  �,<   Z   2B   +   �Z  2,<  ,<   Z  �,<  ,<  �(  oZ  2B   +   :Z  -XB  3Z  :-,   +   �-,   +   �,<  �-,   +   �,   ,   XB  �D  �Z  -,   +   �   �,>  e,>  �   �   �,^  �/  �3"  +   �Z  "-,   +   c   B,>  e,>  �   �   �,^  �/  �3b  +   c,<  pZ  H,<  �-,   +   PZ  �+   ^Z  �-,   +   �Z  �-,   +   �,<  qZ  P,<  ,<  �,<  �,<  r^"  �,   +   ^Z  �-,   +   �,<  �,<  �,<  s,   +   ^,<  �Z  �,<  ,<  t,   ,<  �,<  �(  �   uZ   XB   Z   XB  M3B   +   3Zp  /  �Z  �,~     �
a�X(P%WQ� 1deY       (VARIABLE-VALUE-CELL PROMPT . 105)
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
   	p   h �    P   8   H L ` � h           �    x   h = x   h   	  B @ � ( � ` �    c   a  � H � h ,   � x & P  H �  0      

ASKITEM BINARY
    J    �    H-.     0     �@  A  ,~   Z   2B   +   �Z  BXB  Z   2B   +   Z   XB  �Z   -,   +   �Z   +   �B  �3B   +   Z   +   �Z  XB   Z  B  �3B   +   Z  +   �Z   XB   ,<   Z   2B   +   Z  ,<  Z  �,<  Z  �,<  ,<  C(  �Z  XB  �Z   3B   +   Z  �3B   +   �Z  2B   +   �Z  �2B   +   �Z  �2B   +   �Z  Z  ,   Z  2B   +   �Z  �,<  �,<  DZ  !F  �2B   +   �Z  �3B   +   ,,<  �Z  �,<   "  �,   2B   +   �Z  ),<  �,<   $  E,<  �,<   $  E,<   "  FXB  ,3B   +   8Z   3B   +   �Z  �,<  ,<  �,   ,<  �,<   $  G2B   +   �Z   XB  �   �Z   XB   3B   +   �Zp  /  �Z  �,~   1T*$A* #))   (VARIABLE-VALUE-CELL RESTRICTION . 32)
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
(BHC LIST2 EVCC FMEMB SKA KT KNIL ENTERF)   P   `   8   (      p � x .     8 �  8 8 2 @ � p �   X  (  0     @ �  p �       

ASKITEMS BINARY
     �    (    0-.     (      (Z   2B   +   Z  �XB  �Z   2B   +   �Z   XB  Z   2B   +   �Z  �,<  Z   -,   +   �Z   +   �B  +3B   +   Z   +   �Z  	,<  �Z  ,<  �,<  �(  ,XB  �,<  �@  �  (+   'Z` �-,   +   �+   &Z  XB   Z  ,<  ,<   ,<   Z   ,<  ,<  �,<   ,  �XB` 2B   +   +   �XB` Z` �3B   +   �,<  �Z` ,   XB` �,\  QB  +   �Z` ,   XB` �XB` [` �XB` �+   �Z` ,~   XB  ,~   !5S 	D    (VARIABLE-VALUE-CELL RESTRICTION . 45)
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
(CONSNL SKNLST SKA KT KNIL ENTERF)   @ !        �      h   p �  � `  8   X        

ASKRL BINARY
       �    o    �-.     0     oZ   2B   +   Z  �XB  �Z   -,   +   �"   +   �,   ,   XB  +   �3B   +   �,<  s,<  �,<  �&  tZ   XB  �Z   -,   +   "   +   ,   ,   XB  �+   3B   +   ,<  �,<  �,<  u&  tZ   XB  Z   -,   +   �"   +   �,   ,   XB  Z  -,   +   %Z  �,<  ,<  �@  � @ +   $Z   ,   ,>  �,>  �Z   ,      �,^  �/  �3b  7   Z   ,~   2B   +   ,Z  �-,   +   �Z  �,   ,>  �,>  �Z  %,      �,^  �/  �3b  +   �Z   XB  �+   �3B   +   �Z   XB  �Z   2B   +   �Z  �-,   3B   7    ,   ,<  �Z  /3B   +   8,<  w,<  �,<  �,   +   �Z  xD  �XB  �,<   Z   2B   +   �Z  9,<  ,<   Z  �,<  ,<  y(  �Z  2B   +   AZ  4XB  :Z  A-,   +   VZ  -,   +   OZ  �,<  ,<  �@  � @ +   NZ  �,   ,>  �,>  �Z  �,      �,^  �/  �3b  7   Z   ,~   2B   +   VZ  �-,   +   �Z  �,   ,>  �,>  �Z  O,      �,^  �/  �3b  +   �,<  zZ  �,<  �-,   +   �Z  �+   �Z  C-,   +   aZ  �-,   +   a,<  {Z  �,<  ,<  �,<  �,<  |^"  �,   +   �Z  ]-,   +   e,<  �,<  �,<  },   +   �,<  �Z  [,<  ,<  ~,   ,<  �,<  �(  t   Z   XB   Z   XB  �3B   +   :Zp  /  �Z  k,~     �
a�X($ $@%�.E G&)dp@         (VARIABLE-VALUE-CELL PROMPT . 119)
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
X � 8 �          T 
  K 	 *   ! p �   �    � p �    � H [ 
 � 0 � ( � ` �    � 8 � 	p �  � 8 � X 3  � h - P � P  H �  0      

ASKYN BINARY
      4    (    �-.           (Z   3B   +   Z   +   �Z   XB  �Z   2B   +   Z  �-,   3B   7    ,   ,<  �,<  +Z  �3B   +   �Z  �+   Z  ,,<  �,<  �,   D  -XB  Z   2B   +   Z  �XB  �,<   Z   2B   +   �Z  ,<  ,<  .Z  �,<  ,<  �(  /Z  2B   +   Z  
3B   +   �Z  �+   Z  0XB  �Z  Z  �,   2B   +   �,<  1"  �   2Z   XB   Z   XB  �3B   +   �Zp  /  �Z  "2B  �+   'Z   ,~   Z   ,~   C=#	'A    (VARIABLE-VALUE-CELL PROMPT . 40)
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
(BHC FMEMB LIST3 CONSNL SKLST KT KNIL ENTERF)   P   h   p          p     ( 8 �   (  @   �  �  P        

DISPLAYHELP BINARY
           �    -.           �@    ,~   Z   -,   +   �Z  2B  �+   �Z  �B  +   �,<  �,<  �Z  ,<  �,<   ,<   ,<   ,  ,<   "  �Z   +   �3B   +   3B   +   ,<  �,<   $  ,<   "  �Z   +   �Z   B  �XB   2B   +   �Z   ,~   Z  ,~   -p*�)    (VARIABLE-VALUE-CELL KEY . 17)
(NIL VARIABLE-VALUE-CELL RESULT . 45)
;
TTYIO/GET-TXT
0
PRINTPARA
TERPRI
PRIN1
CTRLO.NLSETQ
(KT KNIL SKLST ENTERF)  h  x �    � @   � H � 0 �    �       

TTYINC BINARY
       7    +    �-.     H      +@  �  ,~   ,<   Z   3B   +   �   2   �,<   ,<   Z   F  3,<  �Z   ,<  �Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   3B   +   Z  �,<  ,<  �Z   F  �+   Z  ,<  Z  �D  �,<  �Z   P  4,<  �Zw�3B   +   B  �,\  �/  �+   �Z  �,<  Z  �,<  Z  �,<  Z  �,<  Z  �,<  Z  �,<  Z  �,<  Z   P  4XB   Z  �Z  5,   2B   +   �Zp  /  �Z   3B   +   )Z   +   �[  #XB  Z  ),~     b# �P   (VARIABLE-VALUE-CELL PROMPT . 53)
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
(EQUAL BHC KT KNIL ENTERF)   P   p �    �    )   �    p   @      

TTYIO/FILE/GET-TXT BINARY
       	    p   -.         @ p@  �  (
,~   [   Z  XB   -,   +   �-,   +   �Z  -,   +   �[  �-,   +   �Z  ,   $" t,>  �,>  �[  �,   .Bx  ,^  �/  �,   XB  3B   +   �[  [  [  Z  XB   -,   +   �[  �[  [  [  Z  XB   3B   +   �[  [  [  [  [  2B   +   �Z  �Z   3B  +   �   1"   +   �Z  �,<  �,<  x$  �2B   +   �,<  y,<   ,<   @  � ` �+   *Z   Z  {XB Z  ,<  �,<  x$  �XB  �Z   ,~   2B   +   �Z  |XB   ,<  �Z   ,<  ,<  �$  }D  �2B   +   �Z  �,<  �,<   $  ~[  [  [  [  Z  ,<  �,<   $  �,<  ,<   $  ~Z  2,~   ,<  �Z  �,<  �,   ,<  �,<   ,   Z   ,   XB  <Z  9,<  �Z  �D  Z  2B   +   G@ �  �+   �Z  �,<  �Z  �,<  Z   D D �,~   ,~   Z   3B   +   VZ  �Z   3B  +   �Z   3B   +   �+   NZ  �2B +   �Z   B �+   PZ   XB   ,< ,<   ,<   & �Z  P3B   +   VZ   3B   +   VB �Z   3B +   dZ  �Z  I3B  +   d[  �,<  �Z  �,   &" t,   ,<  �Z  �,   &" t   ,   ,   ,\  XB  [  �[  [  [  Z  ]XD  Z  �,<  �Z  c,<  Z  �,<     f,>  �,>  �   �.Bx  ,^  �/  �,   H �Z  �3B   +   �B �Z   ,~   Z  a,~     �
$ $�(aCQ�R hDmI1   0         (VARIABLE-VALUE-CELL X . 221)
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
ENTERF)   �    � @   X   H ;    � x 6   *    &    � P � 
@ R 
 L 	 A @ 0 0 $ 8 " 8     8 ` P �    k p   X           �    �       

TTYIO/GET-TXT BINARY
     �    �    L-.          �@  �   ,~   [   Z  XB   -,   +   �-,   +   �Z  -,   +   �[  �-,   +   �Z  ,   $" t,>  �,>  �[  �,   .Bx  ,^  �/  �,   XB  3B   +   �[  [  [  Z  XB   -,   +   �[  �[  [  [  Z  XB   3B   +   �[  [  [  [  [  2B   +   �   1"   +   �Z  �,<  �,<  �$  F2B   +   /,<  �,<   ,<   @  G ` �+   (Z   Z  �XB Z  ,<  �,<  �$  IXB  �Z   ,~   2B   +   *Z   ,~   ,<  �Z  �,<  �,   ,<  �,<   ,   Z   ,   XB  �Z  �,<  �Z  �D  JZ  /,<  �,<      0,>  �,>  �[  [  Z  ,   .Bx  ,^  �/  �,   ,<  �   �,>  �,>  �   �.Bx  ,^  �/  �.  B,   H  �,<   "  KZ   ,~   [  4B  �Z   ,~     �
$ M� Q       (VARIABLE-VALUE-CELL X . 127)
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
(CONS LIST2 KT CF KNIL MKN BHC IUNBOX SKNM SKLST SKNNM ENTERF)  p   ` �    � x � 0 (    $    �   )   �   �   �    �  �    �       � X           �    �       

TTYIO/PRINT-TXT BINARY
            �    �-.          �Z   @  �,<  �Z   F  ,~   @   (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL DEF . 6)
OUTPUT
TTYIO/FILE/GET-TXT
(ENTERF)      

TTYIO/READ-TXT BINARY
    u    �    �-.          �@  �  H,~   Z   3B   +   Z  2B   +   Z   3B   +   Z   3B   +   Z  B  g2B   +   �Z  �,<  �,<  �$  h,~   Z  	B  �XB   Z  �,   ,   XB   Z  ,<  Z   D  iXB   3B  �+   Z3B  j+   Z3B  �+   Z3B  k+   Z3B  �+   Z3B  l+   Z3B  �+   Z2B  m+   +   Z2B  �+   �Z  ,   ,   XB   +   --,   +   !+   Z2B  �+   �+   -Z   3B   +   �Z   3B   +   �,<  �Z  D  n3B   +   �+   ZZ  B  �3B  j+   Z3B  k+   Z2B  o+   -+   ZZ  �-,   +   �   �."  �,   XB  -Z  �,<     �.  �,   XB   D  �Z  �0B  +   9Z  �,<     3.  �,   XB  �D  �Z  �B  p2B  k+   �Z  9,<  �Z  �D  �Z  ,<  �,<  �$  h,~   Z  ;,   ,   XB   ,   ,>  _,>  �   8   �,^  �/  �/  ,   XB   Z  �,<     A/"  �,   D  �Z  =,<  �,<  �   C&" t,   ,<  �   K&" t   ,   ,   ,<  �   0,>  _,>  �   M   �,^  �/  �/  ,   ,<  �Z  F,<  �Z  �2B   +   X   �^,  �,   D  q,~   Z  V,<  �Z  <D  �Z  �,<  �,<  �$  h,~     �$JL@/B�oy Iq   	@        (VARIABLE-VALUE-CELL FL . 180)
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
@ �    �    �    �    �    U 	x M 	 �  � 8 � p     A h �    	  x   
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
