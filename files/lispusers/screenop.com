(FILECREATED "12-May-83 18:38:34" ("compiled on " <DDYER>SCREENOP..52) (2 . 2) bcompl'd in WORK dated 
" 5-May-83 13:37:29")
(FILECREATED " 8-APR-83 09:46:42" /lisp/ddyer/lisp/init/SCREENOP.;3 68825 changes to: (RECORDS 
SCREENDRIVER) previous date: " 1-APR-83 10:44:11" /lisp/ddyer/lisp/init/SCREENOP.;2)

BUILDDRIVER BINARY
          s   -.          sZ   2B   +   Z   ,<  @  u  ,~   Z   2B   +   Z   ,~   Z  B  wXB   3B   +   Z  ÷Z  	7  [  Z  Z  1H  +   2D   +   [  Z  B  xZ  2B   +      øXB   Z  Z   ,   Z  y,   Z  ,   XB   ,<  ùZ  ,<  ,<  z&  úXB  ,<  ,<  {@  û  +   ß,<  ü"  },<  Z  üZ 7@  7   Z  ,   Z  ü,   Z   ,   XB  ¢XB   ,<  ý,<  ~,<   @  þ ` +   ×Z   Z  XB Z  üZ   ,   @   0+   WZ` -,   +   .+   VZ  XB   [  ®Z  Z  7  [  Z  Z  1H  +   ´2D   +   1XB   2B   +   9[  /[  XB  ´2B   +   @+   Ô[  72B   +   ½Z   ,   XB  92B   +   @+   Ô[  »XB  ½2B   +   @+   ÔZ  6,<  Z  >,<  ,< Z   3B   +   Ç,< Z  Â[ ,<  Z  @F +   HZ   F Z   ,   Z ,   Z   ,   ,   Z ,   XB` Z` 3B   +   Ò,<  Z` ,   XB` ,\  QB  +   ÔZ` ,   XB` XB` [` XB` +   ,Z` ,~   +    XB   Z  üZ  $[  [  ,   [  ØXB  £Z  ×3B   +   ^Z  Û,~     Z   ,~   ,<  Z  Z   ,   Z ,   Z   ,   Z ,   Z ,   D Z  {,   Z 	,   Z   ,   Z ,   Z   ,   Z 
,   F Z  ,<  ,< ,<   & Z  ì,<  ,< $ Z  o,   B  x,~   !	@Raft5)& !F	CH! "ZJ2        (VARIABLE-VALUE-CELL TERMCAP . 16)
(VARIABLE-VALUE-CELL RESETVARSLST . 182)
(VARIABLE-VALUE-CELL PROTOTYPEDRIVER . 83)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 137)
(VARIABLE-VALUE-CELL ORIG . 39)
(NIL VARIABLE-VALUE-CELL PARSED . 96)
(NIL VARIABLE-VALUE-CELL INFO . 192)
(NIL VARIABLE-VALUE-CELL TYPE . 226)
PARSETERMCAP
TYPE
EVAL
MKATOM
TERMCAP
Create
Driver
PACK*
SCREENDRIVER
(NIL VARIABLE-VALUE-CELL MACROX . 181)
(NIL VARIABLE-VALUE-CELL MACROY . 186)
CURRENTSCREEN
STKSCAN
((DUMMY) . 0)
((QUOTE INTERNAL) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(((TYPELIST TYPE) (XSIZE co 80) (YSIZE li 24) (CLEAR cl) (CLEARLINE ce) (CLEARREST cd) (INSERT im) (
INSERTLINE al) (DELETE dc) (DELETELINE dl) (SETHIGHLIGHT so NIL) (CLEARHIGHLIGHT se NIL) (SETLOCK ml 
NIL) (CLEARLOCK mu NIL) (SETCURSOR cm) (OVERSTRIKEP os NIL)) . 0)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL SPEC . 140)
(NIL VARIABLE-VALUE-CELL ENTRY . 130)
PROGRAM
GETHANDLER
SCREENOPCOMPILED
SUBST
FUNCTION
SETQ
ERROR!
QUOTE
_
\INFOALIST
APPEND
CREATE
((* this driver generated automatically from termcap information) . 0)
LAMBDA
PUTDEF
SCREENDRIVERS
MARKASCHANGED
FNS
UNMARKASCHANGED
(CONSNL KT SKNLST SET CF CONSS1 KNOB CONS21 CONS KNIL ENTERF)   ò   T 
 <    o 8   X   0 +    ¨    Ì        H ë ( è x f P c 	X K 0     é @ b 	@ J @  X   0 i 8 á x ] 	p Ë 	 È @ ¿ P º  6 H ¦ P  x      @        

CHECKIFSCREENDRIVER BINARY
             -.           Z   Z   3B  +   Z  2B  +   [  Z  2B  +   [  [  Z  Z 7@  7   Z  +   [  +   Z   ,<  @     ,~   Z   2B   +   Z   3B   +   7   Z   ,~   -,   +   ,<  Z  D  ,~   2B   +   Z  ,~   Z  Z  ,   3B   +   Z   ,~   3 R		  (VARIABLE-VALUE-CELL COM . 22)
(VARIABLE-VALUE-CELL NAME . 48)
(VARIABLE-VALUE-CELL TYPE . 7)
FNS
*
(VARIABLE-VALUE-CELL NAMEIT . 49)
INTERSECTION
(FMEMB SKLST KT KNIL KNOB ENTERF)           (      p              

COMPILESCREENOP BINARY
        :    0    8-.           0Z   ,<  [  Z  ,<  @  ° @,~   Z   -,   Z   Z  2B  2+   /[  Z  ,<  ,<  ²"  3XB      ,\  ,   2B   +   Z  [  Z  ,<  ,<  ³,   B  4Z  ´,~   [  Z  2B  5+    Z   -,   Z   Z  2B  2+    [  Z  Z  ,   3B   +    ,<  µ,<  6,<  ¶,<  ²[  Z  ,   ,<  ,<  6,   ,   ,~   ,<  µ,<  6,<  7[  Z  3B   +   §3B   +   §-,   +   §,<  2,<  ,   ,<  ,<  ¶,<  ²[  "Z  ,   ,<  ,<  6,   ,   ,<  [  D  ·,   ,~   Z  ´,~    1A¸,0B       (VARIABLE-VALUE-CELL X . 90)
(VARIABLE-VALUE-CELL OP . 82)
(VARIABLE-VALUE-CELL ARG1 . 57)
(NIL VARIABLE-VALUE-CELL FIELDNAMES . 49)
QUOTE
SCREENDRIVER
RECORDFIELDNAMES
"IS NOT A DEFINED SCREENOP"
COMPERRM
IGNOREMACRO
GETHANDLER
AND
CURRENTSCREEN
FFETCH
SCREENOPCOMPILED
NCONC
(SKNNM KT ALIST3 LIST3 ALIST2 LIST2 FMEMB KNIL SKLST ENTERF)   `   P   p -    H      + h          X   @  h   x   `        

CSPEED BINARY
               -.               
         +    +    +       A"ÿ,   ,<  Zp  0B   +   Z  +    +                     2400
(URET1 ASZ MKN ENTER0)   ( 
               

DELAYFOR BINARY
             -.          Z   3B   +   ,<  Z  [ ,<      ,>  ,>     ,   $Bx  ,^  /  &" %@,   F  ,~   Z   ,~       (VARIABLE-VALUE-CELL N . 10)
(VARIABLE-VALUE-CELL PROPORTIONAL . 0)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 7)
PAD
CSPEED
SCREENOPCOMPILED
(MKN BHC IUNBOX KNIL ENTERF) (          @        

DISPLAYTERMP BINARY
      ë    Y    è-.         H YZ   B  ^XB   @  Þ  ,~   Z   ,<  @  `  +   $Z` -,   +   	+   ¡Z  XB   3B   +    Z   2B  +   +    XB   Z  ,<  Z  3B   +   ,<  áZ  [ D  b+   Z   ,\  1B  +   -,   +   *  ,   2B   7       3B   +    Z   ,<  Zp  -,   +   +   Zp  B  â[p  XBp  +   /  Z  ,~   [` XB` +   Z   XB  XB  XB   ,~   XB   2B   +   /Z  2B   +   ¨Z   3B   +   *Z   XB  $+   /   cXB  '3B   +   .,<  ã"  d   ä+   /Z   XB  )Z  ®3B   +   Z  ¢3B   +   W,<  eZp  -,   +   <Zp  Z 7@  7   Z  2B  å+   ;,<p  ,<   Z   F  fB  æ3B   +   <Z   +   ¼Z   /  3B   +   LZ   -,   +   L1B   +   LZ  "3B   +   L,<  gZ  À[ D  b3B   +   LZ  Â3B   +   É,<  gZ  E[ D  b,   +   ÊZ   ,   /"  ,   XB  >Z  G3B   +   V,<  çZ  LZ D  b3B   +   VZ  N3B   +   Ô,<  çZ  ÐZ D  b+   UZ   XB   B  hZ  °,~   Z   XB  ÒZ` ,~   LEH&>	H1T%&PS      (VARIABLE-VALUE-CELL DIRECTEDTYPE . 75)
(VARIABLE-VALUE-CELL DISPLAYTERMTYPE . 172)
(VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 9)
(VARIABLE-VALUE-CELL PROTOTYPEDRIVER . 22)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 175)
(VARIABLE-VALUE-CELL DISPLAYTERMPFORMS . 50)
(VARIABLE-VALUE-CELL DISPON . 70)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 113)
(VARIABLE-VALUE-CELL \#DISPLAYLINES . 151)
(VARIABLE-VALUE-CELL TTYLINELENGTH . 170)
DISPLAYTERMTYPE
NIL
(NIL VARIABLE-VALUE-CELL TRIED . 94)
(NIL VARIABLE-VALUE-CELL NEWDRIVER . 85)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 19)
TYPELIST
SCREENOPCOMPILED
EVAL
BUILDDRIVER
"..Built a screen driver from TERMCAP info"
PRIN1
TERPRI
\#DISPLAYLINES
NOBIND
STKSCAN
RELSTK
YSIZE
XSIZE
LINELENGTH
(MKN IUNBOX ASZ SKI KNOB SKLA BHC KT FMEMB SKLST KNIL SKNLST ENTERF)   L    K 	      x   h   @   X     < p ©     p   X     Õ 
  Ð 	X Ê h E   > P ;  2  ,  ' X ¢   x               

DISPLAYTERMTYPE BINARY
              -.          Z   2B   +               á+    +    +       ,   ,<  @     ,~   Z   Z   7  [  Z  Z  1H  +   2D   +   [  2B   +   Z  XB  -,   +   B  XB  Z  ,~          ÿ`È@    (VARIABLE-VALUE-CELL DIRECTEDTYPE . 3)
(VARIABLE-VALUE-CELL SYSTEMTERMTYPES . 20)
(VARIABLE-VALUE-CELL TYPE . 38)
EVAL
(SKLST MKN KNIL ENTERF)            h        

GETSCREENOPHANDLER BINARY
             
-.          Z   3B   +   Z   ,<  ,<  ,<  ,<  	(  ,~   Z   ,~      (VARIABLE-VALUE-CELL ACTION . 6)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 3)
((ARRAYBLOCK SCREENDRIVER (TYPELIST XSIZE YSIZE CLEAR CLEARLINE CLEARREST INSERT INSERTLINE DELETE 
DELETELINE SETHIGHLIGHT CLEARHIGHLIGHT SETLOCK CLEARLOCK SETCURSOR READCURSOR OVERSTRIKEP OTHERINFO 
OTHERFUNCTIONS \INFOALIST GETHANDLER SETINFO PAD PRINT) (CREATE (PROG ((TMP DATUM)) (DECLARE (
LOCALVARS TMP)) (push SYSTEMSCREENDRIVERS TMP) (RETURN TMP))) TYPELIST _ (FUNCTION NILL) OVERSTRIKEP _
 (FUNCTION NILL) SETLOCK _ (FUNCTION NILL) CLEARLOCK _ (FUNCTION NILL) SETHIGHLIGHT _ (FUNCTION NILL) 
CLEARHIGHLIGHT _ (FUNCTION NILL) OTHERINFO _ (FUNCTION GETSCREENOPINFO) OTHERFUNCTIONS _ (FUNCTION 
NILL) SETINFO _ (FUNCTION SETSCREENOPINFO) \INFOALIST _ (CONS (CONS (QUOTE CREATED) (DATE))) PAD _ (
FUNCTION (LAMBDA (N) (RPTQ N (\SCREENPUT 0)))) PRINT _ (FUNCTION \SCREENPUT) GETHANDLER _ (FUNCTION 
GETSCREENOPHANDLER)) . 0)
FETCH
RECORDACCESS
(KNIL ENTERF)    x        

GETSCREENOPINFO BINARY
                -.          Z   ,<  Z   3B   +   Z  Z +   Z      ,\  7  [  Z  Z  1H  +   2D   +   ,~   H@ (VARIABLE-VALUE-CELL DATUM . 3)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 8)
(KNIL ENTERF)    h        

KNOWNTERMTYPES BINARY
    $        #-.           @    ,~   @    +   Z   ,<  @    (+   Z` -,   +   	+   Z  XB   XB   3B   +   ,<  "Z  
[ D  ¢+   Z   -,   Z   XB   2B   +   +   XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB` +   Z` ,~   XB   ,~   Z  ,~   %3  (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 9)
(NIL VARIABLE-VALUE-CELL KNOWN . 57)
(NIL VARIABLE-VALUE-CELL CURRENTSCREEN . 24)
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 19)
(NIL VARIABLE-VALUE-CELL Y . 31)
TYPELIST
SCREENOPCOMPILED
(CONSNL SKLST KNIL SKNLST ENTER0)              p            

PARSECHARSEQUENCE BINARY
      ú    c    w-.           cZ   B  ã,<  @  d  (,~   @  g  +   "Z  ,<  Z   D  h-,   +   +      ."  ,   XB  +   Z  1B  +   Z  ,<  ,<  è   /"  ,   F  iXB   Z  ,<  Z  ,<  ,<  é&  jXB  Z  3B   +   !Z  ,<  ,<  è$  h2B  ê+   Z  Z  k,   Z  ë,   XB  Z  B  l+   !Z  Z   ,   Z  ë,   XB  Z` ,~   Z  -,   +   [B  lXB   2B   +   &+   [2B  ì+   ÎZ  "B  lXB  $3B  ì+   ª2B  m+   «B  í+   S3B  n+   ­2B  î+   ®Z"  +   S3B  o+   °2B  ï+   ±Z"  +   S3B  p+   ³2B  ð+   ´Z"  +   S3B   +   ¶2B  q+   ·Z"  +   S3B  ñ+   ¹2B  r+   ºZ"  +   S3B  ò+   ¼2B  s+   ½Z"  +   S-,   +   K,<   Z  ',<  ,<  è$  h-,   +   CZp  +   ÉZ  ?B  l,   ,>  â,>     ($"  .Bx  ,^  /  ,   XB  Å+   ?/  Z  È+   S,<  ó,<  ì,<  Z  CF  tD  ô+   S2B  m+   ÒZ  ÌB  u,   A"  ,   +   SB  íXB` Z` 3B   +   Ø,<  Z` ,   XB` ,\  QB  +   ÚZ` ,   XB` XB` +   ",<  õ,<` "  vB  ã,   ,   XB` Z   3B   +   á,<` ,   D  öZ` ,~     ,"'T1_}{õ_>QU OQD6@       (VARIABLE-VALUE-CELL X . 159)
MKSTRING
(VARIABLE-VALUE-CELL X . 0)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL CHAR . 148)
(NIL VARIABLE-VALUE-CELL DELAY . 189)
NIL
(1 VARIABLE-VALUE-CELL I . 37)
NTHCHAR
1
SUBATOM
-1
SUBSTRING
*
((T) . 0)
DELAYFOR
GNC
\
^
CHCON1
E
e
n
N
R
r
t
B
b
F
f
"ILLEGAL \ SEQUENCE IN STRING, STARTING AT "
PACK*
ERROR
GNCCODE
\SCREENPUT
PACKC
NCONC
(ALIST2 CONSNL BHC IUNBOX SKI KT SKSTP CONS21 CONS KNIL ASZ MKN SKNI ENTERF)  ^    á h Z 
p   	( È    Ñ P   h   X   8          8     U x ¥ x     ½ ( · H ± h     Ò 	  8     	       

PARSECURSORPOS BINARY
   ¨      £-.          Z   B ,<  ,< " ,<  @  @0,~   Z   B XB   2B   +   	+  2B +   _Z  B XB  2B +   Z"   XB   Z XB   +   a0B  +   Z"  XB  Z XB  +   a0B  +   Z"  XB  Z XB  +   a2B +   Z XB  +   a2B +   !Z   ,<  Z  
B ,<  Z  Z   ,   ,   Z ,   D Z XB  +   a2B +   1Z  ,<  Z  ",<  Z  B Z   ,   ,   Z ,   ,<  Z  $B ,<  Z  #Z   ,   ,   Z ,   Z   ,   ,   Z ,   Z ,   D +   a2B +   4Z  ©B XB  2+   a2B +   @Z  3,<  Z  5Z   ,   Z ,   D [  6Z  3B   +   a[  9,<  [  ;Z  Z   ,   Z ,   D +   a2B +   ÃB Z   ,   XB  Á+   a2B +   ÏZ  <,<  Z  ÄZ   ,   Z$  0,   Z ,   D [  Å,<  [  ÉZ  Z   ,   Z$  0,   Z ,   D +   a2B +   ÝZ  Ê,<  Z  ÐZ ,   Z ,   ,<  Z  ÑZ ,   Z ,   Z   ,   Z$  ,   Z ,   Z   ,   ,   Z ,   D +   a,< D  +   aB Z  Â,   XB  ßZ   3B   +  Z  à3B   +   jB B  B Z   ,   Z ,   Z   ,   XB  çZ   XB  âZ  a2B +   ùZ  0B   +   pZ  ÔZ   ,   Z !,   +   ÷Z ¡,   Z ",   Z   ,   Z ¢,   ,<  Z  mZ   ,   ,   Z ,   Z  è,   XB  ÷+   ÿ2B +   Z  ôZ   ,   Z ,   Z  ø,   XB  }+   ÿ  #[  úXB  ÿZ   XB  j+   Z  é3B   +  3B   +  B B  B Z   ,   Z ,   Z  ~,   XB Z   XB Z 	B ,~   QY)R{D8"!/.
c@Pq"Axd"h@CD0Kd           (VARIABLE-VALUE-CELL STR . 3)
MKSTRING
((Y X) . 0)
APPEND
(VARIABLE-VALUE-CELL X . 80)
(VARIABLE-VALUE-CELL ORDINATE . 256)
NIL
(NIL VARIABLE-VALUE-CELL EMITFLG . 258)
(0 VARIABLE-VALUE-CELL WIDTH . 215)
(NIL VARIABLE-VALUE-CELL OUTPUTCHRS . 276)
(NIL VARIABLE-VALUE-CELL CHR . 22)
(NIL VARIABLE-VALUE-CELL PROGRAM . 277)
GNC
%%
d
PRINTNUM
%.
\SCREENPUT
+
GNCCODE
IPLUS
RPLACA
>
IGREATERP
(((T (CAR ORDINATE))) . 0)
COND
r
DREVERSE
i
ADD1
CHCON1
n
LOGXOR
B
((10) . 0)
IREMAINDER
((10) . 0)
IQUOTIENT
ITIMES
"UNSUPPORTED CURSOR CODE"
ERROR
PACKC
PRIN3
((NIL T) . 0)
FIX
QUOTE
SHOULDNT
(CONS21 CONSS1 CONS ASZ KNIL ENTERF)  X x H ò   h P Ú  × 
H O 	` É 	 ¿  ° P ( x   p \ h , p     x þ H y h ó  o  g  Û  Ö 
8 M x C h 8 x . 8 ¦ `   P Y 	X H H    X   ( H  | ` s h j h d ( [   Ì p > 0 · X + `        

PARSETERMCAP BINARY
   K   ª   Å-.          ªZ   2B   +   Z   XB  3B   +  ©,<  ,< +$ «,<  @ ,  +  )Z   ,<  ,< .$ «XB   Z  2B   +   ,< ®" /,<  Z  D ¯2B   +   ,< 0" /Z  ,   XB  Z  ,<  ,<  ,<   Zwÿ-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   ¢Zwÿ,<  @ °   +   Z   B 1B ±,~   Zp  ,   XBp  [wÿXBwÿ+   /  D 2XB  Z   ,   Z ²,   Z   ,   Z 3,   XB  £[  ,<  ,<   Zwÿ-,   +   °Zp  Z   2B   +   ® "  +   0[  QD   "  +   bZwÿ,<  @ °   +   _Z  B ³,<  Z"  ,\  2B  +   ¹Z  3,<  ,< 4,< ´& 5XB  ¶Z  9,<  ,< µ,< 4& 5,<  Z  ¹,<  ,< 6$ ¶2B   +   ÀZ   +   ^2B 7+   EZ  ¼,<  ,< ·,< ´& 5,   +   ^2B 8+   ÉZ  Á,<  ,< ·,< ´& ¸B 9+   ^3B ¹+   Ë2B :+   OZ  F,<  ,< 6,< ´& ¸B 9+   ^1B   +   Y1B  +   Y1B  +   Y1B  +   Y1B  +   Y1B  +   Y1B  +   Y1B  +   Y1B  +   Y0B  +   ÜZ  Ë,<  ,< 6,< ´& 5,   +   ^,< ºZ  YD ;,   ,~   Zp  ,   XBp  [wÿXBwÿ+   */  XB   Z »Z  â7  [  Z  Z  1H  +   h2D   +   äXB   3B   +   o,<  [  hZ  [  Z  B <,<  [  j[  D ¼D =@ ½  +  'Z ¾Z  ã7  [  Z  Z  1H  +   õ2D   +   r3B   +   ÷Z ?+  Z ¿Z  q7  [  Z  Z  1H  +   ü2D   +   yXB   3B   +  [  üZ  [  Z  B @+  Z ÀXB  ~Z AZ  x7  [  Z  Z  1H  +  2D   +  2B   +  Z Á,<  Z D ¼+   @ B   +  Z` -,   +  +  Z  XB  ]Z Z 7  [  Z  Z  1H  +  2D   +  XB   3B   +  Z 2B   +  Z   XB` +  [` XB` +  Z ,~   XB   3B   +  [ Z  [  Z  B @+   Z DXB Z 	,<  D ¼XB  B ÄZ   ,   Z E,   Z ,   XB %,~   Z  (Z &,   ,~   ,~   Z   ,~   S. E	, E	(N5g¹*U*v@$G0p +I¸$         (VARIABLE-VALUE-CELL TCAP . 22)
:
SEGMENTSTRING
(VARIABLE-VALUE-CELL FORMS . 81)
(NIL VARIABLE-VALUE-CELL TYPE . 334)
(NIL VARIABLE-VALUE-CELL VARS . 335)
(NIL VARIABLE-VALUE-CELL CPOS . 218)
"|"
"TERM"
GETENV
MEMBER
"TERM"
(VARIABLE-VALUE-CELL X . 299)
MKATOM
DISPLAYTERMTYPE
UNION
QUOTE
TYPE
CHCON1
2
-1
SUBATOM
1
3
NTHCHAR
#
4
=
SUBSTRING
PARSECHARSEQUENCE
^
\
"Uninterpretable TERMCAP capability string"
ERROR
cm
PARSECURSORPOS
APPEND
RPLACD
(NIL VARIABLE-VALUE-CELL BACKSPACE . 324)
(NIL VARIABLE-VALUE-CELL CLEARNEXT . 320)
bs
((8) . 0)
bc
CHCON
((8) . 0)
os
((32) . 0)
((dc ce cd) . 0)
NIL
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL VARIABLE-VALUE-CELL Y . 308)
((32) . 0)
PACKC
DELETENEXT
(KT CONSS1 CONSNL ASZ CONS21 BHC COLLCT SKNLST CONS KNIL ENTERF)      p   H E    Y   W 
` U 
@ S 
  Q 
  µ   ¥  ¦    c 8    !    8    ) h¤ x ¥ (   ($ H X   ` ü h õ  h  ¿ X - ( ' P  x      P   0      

PREPAREDELETENEXT BINARY
    =    ²    ;-.           ²Z   3B   +   ,<  3Z  Z ,<  ,<  ³&  4+   Z   ,<  @  ´   ,~   [   Z  XB  	3B   +   1B  5,<  @  µ   
+   1Z` -,   +   +   ,Z  XB      ,>  2,>  ^"     ,^  /  2"  +   Z  B  8+   Z   3B  ¸+   Z  0B  ¿+      G"  @,   XB     ,>  2,>  ^"     ,^  /  2"  +   ¢Z  ,<  ,<  ¸$  8Z   XB` Z` 3B   +   ¨,<  Z` ,   XB` ,\  QB  +   ªZ` ,   XB` XB` [` XB` +   ,<  9,<` "  ¹XB  ¢D  :,<  ºZ  ­D  :Z` ,~   Z   ,~      56 @L  5P      (VARIABLE-VALUE-CELL CURRENTSCREEN . 7)
OTHERINFO
DELETENEXT
SCREENOPCOMPILED
(VARIABLE-VALUE-CELL N . 20)
CHCON
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 94)
ECHOCONTROL
REAL
1STCHDEL
PACKC
DELETECONTROL
NTHCHDEL
(CONSNL MKN ASZ BHC SKNLST KNIL ENTER0)  * p   @                 2 P  8   0      

SCREENOP BINARY
        »    «    ¹-.            «Z   3B   +   ªZ   ,<  @  ¯  +   *Z   ,<  ,<  1,<  ±,<   @  2 ` +   #Z   Z  ³XB ,<  4Z   B  4,   ,   Z  ,   XB  ,<  ´,<  5"  ´,   ,   Z  ,   XB  Z   ,<  Z  ,<  ,<  µ,<  6(  ¶,<  @  7   +   ¡Z   3B   +   ,<  Z   ,<  Z   ,<  Z   ,<   "  ,   ,~   ,<  ·Z  D  8Z   ,~   XB   Z   ,~   3B   +   %Z   +   ¥Z  8XB   D  ¸Z  ¥3B   +   )   9,~   Z  ¡,~   ,~   Z   ,~   )U(j À4`        (VARIABLE-VALUE-CELL ACTION . 63)
(VARIABLE-VALUE-CELL ARG1 . 53)
(VARIABLE-VALUE-CELL ARG2 . 55)
(VARIABLE-VALUE-CELL ARG3 . 57)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 40)
(VARIABLE-VALUE-CELL LISPXHIST . 6)
(VARIABLE-VALUE-CELL RESETVARSLST . 37)
(VARIABLE-VALUE-CELL DISPLAYTERM . 23)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 82)
(NIL VARIABLE-VALUE-CELL RESETZ . 77)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SETTERMTABLE
RADIX
10
((ARRAYBLOCK SCREENDRIVER (TYPELIST XSIZE YSIZE CLEAR CLEARLINE CLEARREST INSERT INSERTLINE DELETE 
DELETELINE SETHIGHLIGHT CLEARHIGHLIGHT SETLOCK CLEARLOCK SETCURSOR READCURSOR OVERSTRIKEP OTHERINFO 
OTHERFUNCTIONS \INFOALIST GETHANDLER SETINFO PAD PRINT) (CREATE (PROG ((TMP DATUM)) (DECLARE (
LOCALVARS TMP)) (push SYSTEMSCREENDRIVERS TMP) (RETURN TMP))) TYPELIST _ (FUNCTION NILL) OVERSTRIKEP _
 (FUNCTION NILL) SETLOCK _ (FUNCTION NILL) CLEARLOCK _ (FUNCTION NILL) SETHIGHLIGHT _ (FUNCTION NILL) 
CLEARHIGHLIGHT _ (FUNCTION NILL) OTHERINFO _ (FUNCTION GETSCREENOPINFO) OTHERFUNCTIONS _ (FUNCTION 
NILL) SETINFO _ (FUNCTION SETSCREENOPINFO) \INFOALIST _ (CONS (CONS (QUOTE CREATED) (DATE))) PAD _ (
FUNCTION (LAMBDA (N) (RPTQ N (\SCREENPUT 0)))) PRINT _ (FUNCTION \SCREENPUT) GETHANDLER _ (FUNCTION 
GETSCREENOPHANDLER)) . 0)
FETCH
RECORDACCESS
(VARIABLE-VALUE-CELL OPR . 49)
"UNDEFINED SCREENOP - "
ERROR
RESETRESTORE
ERROR!
(KT EVCC CONS CONSNL ALIST2 CF KNIL ENTERF) 0   p   0      `            «   % @ ¡     0      

SCREENOPCOMPILED BINARY
     ¯    "    .-.     (     "Z   ,<  @  &  ,~   Z   ,<  ,<  §,<  (,<   @  ¨ ` +   Z   Z  *XB ,<  ªZ   B  ª,   ,   Z  ,   XB  ,<  +,<  «"  +,   ,   Z  ,   XB  Z   3B   +   ,<  Z   ,<  Z   ,<  Z   ,<   "  ,   +   ,<  ,Z   D  ¬XB   Z   ,~   3B   +   Z   +   Z  ¬XB   D  -Z  3B   +   !   ­,~   Z  ,~   *A` Bi@     (VARIABLE-VALUE-CELL ACTION . 49)
(VARIABLE-VALUE-CELL ARG0 . 35)
(VARIABLE-VALUE-CELL ARG1 . 39)
(VARIABLE-VALUE-CELL ARG2 . 41)
(VARIABLE-VALUE-CELL ARG3 . 43)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL DISPLAYTERM . 20)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 66)
(NIL VARIABLE-VALUE-CELL RESETZ . 61)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SETTERMTABLE
RADIX
10
"UNDEFINED SCREENOP - "
ERROR
RESETRESTORE
ERROR!
(KT EVCC CONS CONSNL ALIST2 CF KNIL ENTERF)  0             H         	      P  0        

SEGMENTSTRING BINARY
     ¯    §    .-.           §@  ¨  0,~   ,<   Z   XB   Z  ,<  Z   ,<  Z   ,<  F  «XB  ,\  3B  +   +      ,>  ',>  Z  B  ,,   .Bx  ,^  /  ,   XB  +   Z  /  2B   +   +   !Z  ,<  Z  ,<     /"  ,   F  ¬XB   2B   +   +    XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +    Z` ,   XB` XB` +   ,<` Z  ,<  Z  ,<  ,<  -&  ¬,   D  ­XB` Z` ,~      #$` P    (VARIABLE-VALUE-CELL STR . 67)
(VARIABLE-VALUE-CELL PAT . 24)
NIL
NIL
NIL
(1 VARIABLE-VALUE-CELL POS . 42)
(NIL VARIABLE-VALUE-CELL START . 69)
(NIL VARIABLE-VALUE-CELL VAL . 46)
STRPOS
NCHARS
SUBATOM
-1
NCONC
(CONSNL MKN BHC IUNBOX KNIL ENTERF)   X   P   p      x   `   0  (        

SETSCREENOPINFO BINARY
                
-.          Z   ,<  Z   ,<  Z   3B   +   Z  Z +   Z   F  ,~   @  (VARIABLE-VALUE-CELL DATUM . 3)
(VARIABLE-VALUE-CELL VAL . 5)
(VARIABLE-VALUE-CELL CURRENTSCREEN . 10)
PUTASSOC
(KNIL ENTERF)   x        

\SCREENPUT BINARY
        +    &    ©-.           &Z   -,   +   
Z  2B   +   ^"   +   ,      %   %   +    +    +    ,   ,~   -,   +   B  ¦,<  @  '  +       ,>  ¥,>   `    ,^  /  3b  +   Z` ,~   Z  ,<  Z  D  ¨2B   +   ^"   +   ,      %   %   +    +    +       ."  ,   XB  +   ,~   Z  B  )2B   +    ^"   +   !,      %   %   +    +    +    ,   ,~          + jÀV JX     (VARIABLE-VALUE-CELL CHR . 59)
NCHARS
(0 . 1)
NIL
(1 VARIABLE-VALUE-CELL I . 56)
NTHCHARCODE
MKSTRING
(BHC SKSTP MKN IUNBOX KNIL SKI ENTERF)          % H 
    ¡        `            

CreatePrototypeDriver BINARY
       9    ¨    7-.           ¨,<  ),<  ©$  *Z  ªQD Z  +XD Z  «QD Z  ,XD Z  ¬QD Z  -XD Z  ­QD Z  .XD Z  ®QD Z  /XD Z  ¯QD Z  0XD Z  °QD Z  1XD Z  ±QD Z  2XD Z  ²QD Z  3QD ,<  Z  ³   ,\  XD ,<  Z  4   ,\  XD ,<  Z  ´   ,\  QD @  5Z  µ,   ,      ,\  XD ,<  Z  6   ,\  QD ,<  Z  ¶   ,\  XD ,<  Zp  Z   ,   XB  &Zp  +    *U*UTB`!          (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 78)
12
0
ARRAY
((LAMBDA NIL (* return a list of terminal types (as processed by DISPLAYTERMTYPE and DISPLAYTERMP that
 this is a driver for)) NIL . PROGRAM) . 0)
((LAMBDA NIL (* return the width of the screen in characters) . PROGRAM) . 0)
((LAMBDA NIL (* return the number of lines on the screen.) . PROGRAM) . 0)
((LAMBDA NIL (* home, unlock, and clear the whole screen) . PROGRAM) . 0)
((LAMBDA NIL (* clear the rest of the current line) . PROGRAM) . 0)
((LAMBDA NIL (* clear the rest of the current line) . PROGRAM) . 0)
((LAMBDA NIL (* set insert mode) . PROGRAM) . 0)
((LAMBDA (N) (* insert a new line before the current line) (RPTQ (OR N 1) . PROGRAM)) . 0)
((LAMBDA (N) (* delete N characters at the current cursor position) (RPTQ (OR N 1) . PROGRAM)) . 0)
((LAMBDA (N) (* delete this line and the next N-1 lines, scrolling up the bottom of the screen) (RPTQ 
(OR N 1) . PROGRAM)) . 0)
((LAMBDA NIL (* set some sort of highlight mode) . PROGRAM) . 0)
((LAMBDA NIL (* clear the highlight mode) . PROGRAM) . 0)
((LAMBDA NIL (* set a memory lock, to prevent the lines above the cursor from rolling off the screen. 
If your terminal can't support this, a nop will probably be ok) . PROGRAM) . 0)
((LAMBDA NIL (* clear the memory lock. a nop is ok if set lock is not supported) . PROGRAM) . 0)
((LAMBDA (X Y) (* position the cursor to X,Y) . PROGRAM) . 0)
((LAMBDA NIL (* read the current cursor position) . PROGRAM) . 0)
((LAMBDA NIL (* return T if this terminal overstrikes rather than superceeds) . PROGRAM) . 0)
((LAMBDA (N) (* output N pad characters, called by DELAYFOR after computing the correct number) (RPTQ 
N . PROGRAM)) . 0)
\SCREENPUT
SETSCREENOPINFO
GETSCREENOPHANDLER
DATE
CREATED
NILL
GETSCREENOPINFO
(URET1 CONS CONSNL CONS21 ENTER0)    x   p   h      

Create2621k45DriverA0012 BINARY
               -.            Z  ,~       ((2621k45 h3 HP hp2621k45 k45) . 0)
(ENTER0)    

Create2621k45DriverA0013 BINARY
               -.            Z"  (,~       (ASZ ENTER0)         

Create2621k45DriverA0014 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

Create2621k45DriverA0015 BINARY
            -.            ,<  "  ,~       "HJ"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0016 BINARY
               -.            ,<  "  ,<  "  ,~       "K"
\SCREENPUT
8
DELAYFOR
(ENTER0)     

Create2621k45DriverA0017 BINARY
               -.            ,<  "  ,<  "  ,~       "J"
\SCREENPUT
8
DELAYFOR
(ENTER0)     

Create2621k45DriverA0018 BINARY
               -.            ,<  "  ,~       "Q"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0019 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +    `@ (VARIABLE-VALUE-CELL N . 3)
"L"
\SCREENPUT
38
DELAYFOR
(URET2 MKN ASZ KNIL ENTERF)   H   (    @    P        

Create2621k45DriverA0020 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +    `@ (VARIABLE-VALUE-CELL N . 3)
"P"
\SCREENPUT
2
DELAYFOR
(URET2 MKN ASZ KNIL ENTERF)                0      

Create2621k45DriverA0021 BINARY
               -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"M"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

Create2621k45DriverA0022 BINARY
            -.            ,<  "  ,~       "&dD"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0023 BINARY
               -.            ,<  "  ,~       "&d@"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0024 BINARY
               -.            ,<  "  ,~       "l"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0025 BINARY
            -.            ,<  "  ,~       "m"
\SCREENPUT
(ENTER0)      

Create2621k45DriverA0026 BINARY
            -.           ,<  	"  Z   B  
,<  "  Z   B  
,<  "  ,<  "  ,~   o@  (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL Y . 9)
"&a"
\SCREENPUT
PRIN3
"c"
"Y"
2
DELAYFOR
(ENTERF)    

Create2621k45DriverA0027 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

Create2621k45DriverA0028 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

Create2621k45Driver BINARY
    Î    ¾    L-.           ¾,<  ?,<  ¿$  @,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD ,<  Z  Â   ,\  QD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  XD ,<  Z  Å   ,\  QD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  QD ,<  Z  G   ,\  XD ,<  Z  Ç   ,\  QD ,<  Z  H   ,\  QD Z  ÈXD ,<  Z  I   ,\  XD ,<  Z  É   ,\  QD ,<  Z  J   ,\  XD ,<  Z  Ê   ,\  QD ,<  Z  K   ,\  QD ,<  Z  Ë   ,\  XD ,<  Zp  Z   ,   XB  <Zp  +    B!!BBH!!         (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 122)
12
0
ARRAY
Create2621k45DriverA0012
Create2621k45DriverA0013
Create2621k45DriverA0014
Create2621k45DriverA0015
Create2621k45DriverA0016
Create2621k45DriverA0017
Create2621k45DriverA0018
Create2621k45DriverA0019
Create2621k45DriverA0020
Create2621k45DriverA0021
Create2621k45DriverA0022
Create2621k45DriverA0023
Create2621k45DriverA0024
Create2621k45DriverA0025
Create2621k45DriverA0026
Create2621k45DriverA0027
(((TERMCAP 
"h3|2621k45|hp2621k45|k45:kb=^H:ku=\EA:kd=\EB:kl=\ED:kr=\EC:kh=\Eh:ks=\E&s1A:ke=\E&s0A:pc=\200:is=@:bt=2\Ei:cm=2\E&a%%r%%dc%%dY:dc=2\EP:ip=2:kn#8:k1=\Ep\r:k2=\Eq\r:k3=\Er\r:k4=\Es\r:k5=\Et\r:k6=\Eu\r:k7=\Ev\r:k8=\Ew\r:ta=2^I:if=/usr/lib/tabset/std:al=38\EL:am:bs:cd=8\EJ:ce=8\EK:ch=8\E&a%%dC:cl=\EH\EJ:co#80:cv=\E&a%%dY:da:db:dl=\EM:ei=\ER:im=\EQ:li#24:mi:ml=\El:mu=\Em:nd=\EC:pt:se=\E&d@:so=\E&dD:us=\E&dD:ue=\E&d@:up=\EA:xs"
) (TYPE (QUOTE (2621k45 h3 HP hp2621k45 k45))) (DELETENEXT %% %) (kb (\SCREENPUT "")) (ku (
\SCREENPUT "A")) (kd (\SCREENPUT "B")) (kl (\SCREENPUT "D")) (kr (\SCREENPUT "C")) (kh (
\SCREENPUT "h")) (ks (\SCREENPUT "&s1A")) (ke (\SCREENPUT "&s0A")) (pc (\SCREENPUT "")) (is (
\SCREENPUT "@")) (bt (\SCREENPUT "i") (DELAYFOR 2)) (cm (\SCREENPUT "&a") (PRIN3 X) (\SCREENPUT "c"
) (PRIN3 Y) (\SCREENPUT "Y") (DELAYFOR 2)) (dc (\SCREENPUT "P") (DELAYFOR 2)) (ip (\SCREENPUT "") (
DELAYFOR 2)) (kn 8) (k1 (\SCREENPUT "p")) (k2 (\SCREENPUT "q")) (k3 (\SCREENPUT "r")) (k4 (
\SCREENPUT "s")) (k5 (\SCREENPUT "t")) (k6 (\SCREENPUT "u")) (k7 (\SCREENPUT "v")) (k8 (
\SCREENPUT "w")) (ta (\SCREENPUT "	") (DELAYFOR 2)) (if (\SCREENPUT "/usr/lib/tabset/std")) (al (
\SCREENPUT "L") (DELAYFOR 38)) (am) (bs) (cd (\SCREENPUT "J") (DELAYFOR 8)) (ce (\SCREENPUT "K")
 (DELAYFOR 8)) (ch (\SCREENPUT "&a%%dC") (DELAYFOR 8)) (cl (\SCREENPUT "HJ")) (co 80) (cv (
\SCREENPUT "&a%%dY")) (da) (db) (dl (\SCREENPUT "M")) (ei (\SCREENPUT "R")) (im (\SCREENPUT "Q"
)) (li 24) (mi) (ml (\SCREENPUT "l")) (mu (\SCREENPUT "m")) (nd (\SCREENPUT "C")) (pt) (se (
\SCREENPUT "&d@")) (so (\SCREENPUT "&dD")) (us (\SCREENPUT "&dD")) (ue (\SCREENPUT "&d@")) (up
 (\SCREENPUT "A")) (xs)) . 0)
\SCREENPUT
Create2621k45DriverA0028
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)  ?    ½       

CreateAAdriverA0029 BINARY
            -.            Z  ,~       ((ANNARBOR) . 0)
(ENTER0)      

CreateAAdriverA0030 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

CreateAAdriverA0031 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateAAdriverA0032 BINARY
            -.            ,<  "  ,~       %[H%[J
PRIN3
(ENTER0)    

CreateAAdriverA0033 BINARY
               -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
%[K
PRIN3
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreateAAdriverA0034 BINARY
            -.            ,<  "  ,~       %[J
PRIN3
(ENTER0)      

CreateAAdriverA0035 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +    `@ (VARIABLE-VALUE-CELL N . 3)

PRIN3
M
(URET2 MKN ASZ KNIL ENTERF)  H   (    @    P        

CreateAAdriverA0036 BINARY
            -.            ,<  "  ,~       %[7m
PRIN3
(ENTER0)     

CreateAAdriverA0037 BINARY
            -.            ,<  "  ,~       %[0m
PRIN3
(ENTER0)     

CreateAAdriverA0038 BINARY
        	    -.           	,<  
"      ."  ,   B  ,<  "      ."  ,   B  ,<  "  ,~   8p  (VARIABLE-VALUE-CELL X . 11)
(VARIABLE-VALUE-CELL Y . 5)
%[
PRIN3
;
H
(MKN ENTERF)   x        

CreateAAdriverA0039 BINARY
            -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateAAdriver BINARY
    K    ½    È-.           ½,<  >,<  ¾$  ?,<  Z  ¿   ,\  QD ,<  Z  @   ,\  XD ,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD Z   QD Z   XD Z   QD ,<  Z  Â   ,\  XD ,<  Z  C   ,\  QD ,<  Z  Ã   ,\  XD ,<  Z  D   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD Z   XD ,<  Z  E   ,\  XD ,<  Z  Å   ,\  QD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  QD @  GZ  Ç,   ,      ,\  XD ,<  Z  D   ,\  QD ,<  Z  H   ,\  XD ,<  Z  D   ,\  QD ,<  Zp  Z   ,   XB  ;Zp  +    B! B!!0         (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 120)
12
0
ARRAY
CreateAAdriverA0029
CreateAAdriverA0030
CreateAAdriverA0031
CreateAAdriverA0032
CreateAAdriverA0033
CreateAAdriverA0034
CreateAAdriverA0035
CreateAAdriverA0036
CreateAAdriverA0037
NILL
CreateAAdriverA0038
\SCREENPUT
CreateAAdriverA0039
SETSCREENOPINFO
GETSCREENOPHANDLER
DATE
CREATED
GETSCREENOPINFO
(URET1 CONS CONSNL CONS21 KNIL ENTER0)  `   H         P  @        

CreateD2DriverA0040 BINARY
            -.            Z  ,~       ((D2 dm2500 datamedia2500 2500) . 0)
(ENTER0)      

CreateD2DriverA0041 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

CreateD2DriverA0042 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateD2DriverA0043 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)     

CreateD2DriverA0044 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD2DriverA0045 BINARY
               -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD2DriverA0046 BINARY
               -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +    `@ (VARIABLE-VALUE-CELL N . 3)
"
"
\SCREENPUT
15
DELAYFOR
(URET2 MKN ASZ KNIL ENTERF)   H   (    @    P        

CreateD2DriverA0047 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  ,<   $  XBp   wÿ/"  ,   XBwÿ+   Zp  +    P  (VARIABLE-VALUE-CELL N . 3)
""
\SCREENPUT
10
DELAYFOR
(URET2 MKN KT ASZ KNIL ENTERF) P   0       @    P        

CreateD2DriverA0048 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  ,<   $  XBp   wÿ/"  ,   XBwÿ+   Zp  +    P  (VARIABLE-VALUE-CELL N . 3)
""
\SCREENPUT
10
DELAYFOR
(URET2 MKN KT ASZ KNIL ENTERF)   P   0       @    P        

CreateD2DriverA0049 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD2DriverA0050 BINARY
               -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateD2DriverA0051 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateD2DriverA0052 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateD2DriverA0053 BINARY
               -.           ,<  "  ^"  0,>  ,>      FBx  ,^  /  ,   B  ^"  0,>  ,>      FBx  ,^  /  ,   B  ,~        (VARIABLE-VALUE-CELL X . 8)
(VARIABLE-VALUE-CELL Y . 17)
""
\SCREENPUT
(MKN BHC ENTERF)    p   0        

CreateD2DriverA0054 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateD2DriverA0055 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateD2Driver BINARY
    Ë    <    I-.           <,<  ¼,<  =$  ½,<  Z  >   ,\  QD ,<  Z  ¾   ,\  XD ,<  Z  ?   ,\  QD ,<  Z  ¿   ,\  XD ,<  Z  @   ,\  QD ,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD ,<  Z  Â   ,\  QD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  QD Z  ÅXD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  QD ,<  Z  G   ,\  XD ,<  Z  Ç   ,\  QD ,<  Z  H   ,\  QD ,<  Z  È   ,\  XD ,<  Zp  Z   ,   XB  ¹Zp  +    B!!BB!          (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 117)
12
0
ARRAY
CreateD2DriverA0040
CreateD2DriverA0041
CreateD2DriverA0042
CreateD2DriverA0043
CreateD2DriverA0044
CreateD2DriverA0045
CreateD2DriverA0046
CreateD2DriverA0047
CreateD2DriverA0048
CreateD2DriverA0049
CreateD2DriverA0050
CreateD2DriverA0051
CreateD2DriverA0052
CreateD2DriverA0053
CreateD2DriverA0054
(((TERMCAP 
"D2|dm2500|datamedia2500|2500:al=15^P\n^X^]^X^]:bs:ce=^W:cl=^^^^\177:cm=^L%%r%%n%%.%%.:co#80:dc=10*\b:dl=10*^P^Z^X^]:dm=^P:ed=^X^]:ei=10\377\377^X^]:ho=^B:ic10*^\:im=^P:li#24:nc:nd=^\:pc=\377:so=^N:se=^X^]:up=^Z"
) (TYPE (QUOTE (D2 dm2500 datamedia2500 2500))) (DELETENEXT %% %) (al (\SCREENPUT "
") (DELAYFOR 15)) (bs) (ce (\SCREENPUT "")) (cl (\SCREENPUT "")) (cm (\SCREENPUT "") 
(\SCREENPUT (LOGXOR 96 X)) (\SCREENPUT (LOGXOR 96 Y))) (co 80) (dc (\SCREENPUT "") (DELAYFOR 10 T)) 
(dl (\SCREENPUT "") (DELAYFOR 10 T)) (dm (\SCREENPUT "")) (ed (\SCREENPUT "")) (ei (
\SCREENPUT "") (DELAYFOR 10)) (ho (\SCREENPUT "")) (ic 10*^\) (im (\SCREENPUT "")) (li 24) (
nc) (nd (\SCREENPUT "")) (pc (\SCREENPUT "")) (so (\SCREENPUT "")) (se (\SCREENPUT "")) (up (
\SCREENPUT ""))) . 0)
\SCREENPUT
CreateD2DriverA0055
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)   ¼    ;       

CreateV2DriverA0056 BINARY
            -.            Z  ,~       ((V2 vi200 visual) . 0)
(ENTER0)      

CreateV2DriverA0057 BINARY
               -.            Z"  (,~       (ASZ ENTER0)         

CreateV2DriverA0058 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateV2DriverA0059 BINARY
            -.            ,<  "  ,~       "v"
\SCREENPUT
(ENTER0)      

CreateV2DriverA0060 BINARY
            -.            ,<  "  ,<  ,<   $  ,~   @   "x"
\SCREENPUT
8
DELAYFOR
(KT ENTER0)         

CreateV2DriverA0061 BINARY
            -.            ,<  "  ,~       "y"
\SCREENPUT
(ENTER0)      

CreateV2DriverA0062 BINARY
            -.            ,<  "  ,~       "i"
\SCREENPUT
(ENTER0)      

CreateV2DriverA0063 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  ,<   $  XBp   wÿ/"  ,   XBwÿ+   Zp  +    P  (VARIABLE-VALUE-CELL N . 3)
"L"
\SCREENPUT
4
DELAYFOR
(URET2 MKN KT ASZ KNIL ENTERF) P   0       @    P        

CreateV2DriverA0064 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  ,<   $  XBp   wÿ/"  ,   XBwÿ+   Zp  +    P  (VARIABLE-VALUE-CELL N . 3)
"O"
\SCREENPUT
8
DELAYFOR
(URET2 MKN KT ASZ KNIL ENTERF) P   0       @    P        

CreateV2DriverA0065 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  ,<   $  XBp   wÿ/"  ,   XBwÿ+   Zp  +    P  (VARIABLE-VALUE-CELL N . 3)
"M"
\SCREENPUT
8
DELAYFOR
(URET2 MKN KT ASZ KNIL ENTERF) P   0       @    P        

CreateV2DriverA0066 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateV2DriverA0067 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateV2DriverA0068 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateV2DriverA0069 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateV2DriverA0070 BINARY
               -.           ,<  "  ^"  ,>  ,>      .Bx  ,^  /  ,   B  ^"  ,>  ,>      .Bx  ,^  /  ,   B  ,~        (VARIABLE-VALUE-CELL X . 17)
(VARIABLE-VALUE-CELL Y . 8)
"Y"
\SCREENPUT
(MKN BHC ENTERF)   8       h      

CreateV2DriverA0071 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateV2DriverA0072 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateV2Driver BINARY
    Î    ¾    L-.           ¾,<  ?,<  ¿$  @,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD ,<  Z  Â   ,\  QD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  XD ,<  Z  Å   ,\  QD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  QD ,<  Z  G   ,\  XD ,<  Z  Ç   ,\  QD ,<  Z  H   ,\  QD Z  ÈXD ,<  Z  I   ,\  XD ,<  Z  É   ,\  QD ,<  Z  J   ,\  XD ,<  Z  Ê   ,\  QD ,<  Z  K   ,\  QD ,<  Z  Ë   ,\  XD ,<  Zp  Z   ,   XB  <Zp  +    B!!BBH!!         (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 122)
12
0
ARRAY
CreateV2DriverA0056
CreateV2DriverA0057
CreateV2DriverA0058
CreateV2DriverA0059
CreateV2DriverA0060
CreateV2DriverA0061
CreateV2DriverA0062
CreateV2DriverA0063
CreateV2DriverA0064
CreateV2DriverA0065
CreateV2DriverA0066
CreateV2DriverA0067
CreateV2DriverA0068
CreateV2DriverA0069
CreateV2DriverA0070
CreateV2DriverA0071
(((TERMCAP 
"V2|vi200|visual:al=4*\EL:am:bs:cd=\Ey:ce=8*\Ex:cl=\Ev:cm=\EY%%+\040%%+\040:co#80:dc=8*\EO:dl=8*\EM:ho=\EH:is=\E3\Eb\Ej\E\\\El\EG\Ed\Ek:ks=\E=:ke=\E>:im=\Ei:ei=\Ej:ic=\Ei\040\b\Ej:k0=\E?p:k1=\E?q:k2=\E?r:k3=\E?s:k4=\E?t:k5=\E?u:k6=\E?v:k7=\E?w:k8=\E?x:k9=\E?y:kl=\ED:kr=\EC:ku=\EA:kd=\EB:kh=\EH:li#24:nd=\EC:pt:sr=\EI:up=\EA:vs=\Ed:ve=\Ec"
) (TYPE (QUOTE (V2 vi200 visual))) (DELETENEXT %% %) (al (\SCREENPUT "L") (DELAYFOR 4 T)) (am) (
bs) (cd (\SCREENPUT "y")) (ce (\SCREENPUT "x") (DELAYFOR 8 T)) (cl (\SCREENPUT "v")) (cm (
\SCREENPUT "Y") (\SCREENPUT (IPLUS 32 Y)) (\SCREENPUT (IPLUS 32 X))) (co 80) (dc (\SCREENPUT "O") 
(DELAYFOR 8 T)) (dl (\SCREENPUT "M") (DELAYFOR 8 T)) (ho (\SCREENPUT "H")) (is (\SCREENPUT 
"3bj\lGdk")) (ks (\SCREENPUT "=")) (ke (\SCREENPUT ">")) (im (\SCREENPUT "i")) (
ei (\SCREENPUT "j")) (ic (\SCREENPUT "i j")) (k0 (\SCREENPUT "?p")) (k1 (\SCREENPUT "?q"))
 (k2 (\SCREENPUT "?r")) (k3 (\SCREENPUT "?s")) (k4 (\SCREENPUT "?t")) (k5 (\SCREENPUT "?u")) (
k6 (\SCREENPUT "?v")) (k7 (\SCREENPUT "?w")) (k8 (\SCREENPUT "?x")) (k9 (\SCREENPUT "?y")) (kl
 (\SCREENPUT "D")) (kr (\SCREENPUT "C")) (ku (\SCREENPUT "A")) (kd (\SCREENPUT "B")) (kh (
\SCREENPUT "H")) (li 24) (nd (\SCREENPUT "C")) (pt) (sr (\SCREENPUT "I")) (up (\SCREENPUT "A")
) (vs (\SCREENPUT "d")) (ve (\SCREENPUT "c"))) . 0)
\SCREENPUT
CreateV2DriverA0072
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0) p   X      

CreatekbDriverA0073 BINARY
               -.            Z  ,~       ((kb h19 heath h19b heathkit) . 0)
(ENTER0)     

CreatekbDriverA0074 BINARY
               -.            Z"  (,~       (ASZ ENTER0)         

CreatekbDriverA0075 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreatekbDriverA0076 BINARY
            -.            ,<  "  ,~       "E"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0077 BINARY
            -.            ,<  "  ,~       "K"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0078 BINARY
            -.            ,<  "  ,~       "J"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0079 BINARY
            -.            ,<  "  ,~       "@"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0080 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"L"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreatekbDriverA0081 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"N"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreatekbDriverA0082 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"M"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreatekbDriverA0083 BINARY
            -.            ,<  "  ,~       "p"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0084 BINARY
            -.            ,<  "  ,~       "q"
\SCREENPUT
(ENTER0)      

CreatekbDriverA0085 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreatekbDriverA0086 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreatekbDriverA0087 BINARY
               -.           ,<  "  ^"  ,>  ,>      .Bx  ,^  /  ,   B  ^"  ,>  ,>      .Bx  ,^  /  ,   B  ,~        (VARIABLE-VALUE-CELL X . 17)
(VARIABLE-VALUE-CELL Y . 8)
"Y"
\SCREENPUT
(MKN BHC ENTERF)   8       h      

CreatekbDriverA0088 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreatekbDriverA0089 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreatekbDriver BINARY
    Î    ¾    L-.           ¾,<  ?,<  ¿$  @,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD ,<  Z  Â   ,\  QD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  XD ,<  Z  Å   ,\  QD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  QD ,<  Z  G   ,\  XD ,<  Z  Ç   ,\  QD ,<  Z  H   ,\  QD Z  ÈXD ,<  Z  I   ,\  XD ,<  Z  É   ,\  QD ,<  Z  J   ,\  XD ,<  Z  Ê   ,\  QD ,<  Z  K   ,\  QD ,<  Z  Ë   ,\  XD ,<  Zp  Z   ,   XB  <Zp  +    B!!BBH!!         (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 122)
12
0
ARRAY
CreatekbDriverA0073
CreatekbDriverA0074
CreatekbDriverA0075
CreatekbDriverA0076
CreatekbDriverA0077
CreatekbDriverA0078
CreatekbDriverA0079
CreatekbDriverA0080
CreatekbDriverA0081
CreatekbDriverA0082
CreatekbDriverA0083
CreatekbDriverA0084
CreatekbDriverA0085
CreatekbDriverA0086
CreatekbDriverA0087
CreatekbDriverA0088
(((TERMCAP 
"kb|h19|heath|h19b|heathkit:al=\EL:am:bs:cd=\EJ:ce=\EK:cl=\EE:cm=\EY%%+\040%%+\040:co#80:dc=\EN:dl=\EM:dn=\EB:ei=\EO:ho=\EH:im=\E@:li#24:mi:nd=\EC:as=\EF:ae=\EG:ms:pt:se=\Eq:so=\Ep:up=\EA:vs=\Ex4:ve=\Ey4:kb=^h:ku=\EA:kd=\EB:kl=\ED:kr=\EC:kh=\EH:kn#8:k1=\ES:k2=\ET:k3=\EU:k4=\EV:k5=\EW:l6=blue:l7=red:l8=white:k6=\EP:k7=\EQ:k8=\ER"
) (TYPE (QUOTE (kb h19 heath h19b heathkit))) (DELETENEXT %% %) (al (\SCREENPUT "L")) (am) (bs) 
(cd (\SCREENPUT "J")) (ce (\SCREENPUT "K")) (cl (\SCREENPUT "E")) (cm (\SCREENPUT "Y") (
\SCREENPUT (IPLUS 32 Y)) (\SCREENPUT (IPLUS 32 X))) (co 80) (dc (\SCREENPUT "N")) (dl (\SCREENPUT "M"
)) (dn (\SCREENPUT "B")) (ei (\SCREENPUT "O")) (ho (\SCREENPUT "H")) (im (\SCREENPUT "@")) (li
 24) (mi) (nd (\SCREENPUT "C")) (as (\SCREENPUT "F")) (ae (\SCREENPUT "G")) (ms) (pt) (se (
\SCREENPUT "q")) (so (\SCREENPUT "p")) (up (\SCREENPUT "A")) (vs (\SCREENPUT "x4")) (ve (
\SCREENPUT "y4")) (kb (\SCREENPUT "")) (ku (\SCREENPUT "A")) (kd (\SCREENPUT "B")) (kl (
\SCREENPUT "D")) (kr (\SCREENPUT "C")) (kh (\SCREENPUT "H")) (kn 8) (k1 (\SCREENPUT "S")) (k2 
(\SCREENPUT "T")) (k3 (\SCREENPUT "U")) (k4 (\SCREENPUT "V")) (k5 (\SCREENPUT "W")) (l6 (
\SCREENPUT "blue")) (l7 (\SCREENPUT "red")) (l8 (\SCREENPUT "white")) (k6 (\SCREENPUT "P")) (k7 (
\SCREENPUT "Q")) (k8 (\SCREENPUT "R"))) . 0)
\SCREENPUT
CreatekbDriverA0089
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)  p   X      

CreateHP2640DriverA0090 BINARY
                -.            Z  ,~       ((HP2640) . 0)
(ENTER0)     

CreateHP2640DriverA0091 BINARY
                -.            Z"  (,~       (ASZ ENTER0)         

CreateHP2640DriverA0092 BINARY
             -.            Z"  ,~       (ASZ ENTER0)         

CreateHP2640DriverA0093 BINARY
             -.           Z   3B   +   ,<  Z  Z D  	,<  "  
Z   B  
,~      (VARIABLE-VALUE-CELL CURRENTSCREEN . 7)
(VARIABLE-VALUE-CELL RUBOUTS . 12)
CLEARLOCK
SCREENOPCOMPILED
HJ
PRIN3
(KNIL ENTER0)         

CreateHP2640DriverA0094 BINARY
             -.          Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  Z   B  XBp   wÿ/"  ,   XBwÿ+   Zp  +     @ (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL RUBOUTS . 14)
K
PRIN3
(URET2 MKN ASZ KNIL ENTERF)   H   (    @    P        

CreateHP2640DriverA0095 BINARY
             -.           ,<  "  Z   B  ,~       (VARIABLE-VALUE-CELL RUBOUTS . 5)
J
PRIN3
(ENTER0)     

CreateHP2640DriverA0096 BINARY
                -.          Z   2B   +   Z"  ,<  ,<    wÿ1b   +   ,<  "  ,<  "  Z   B  XBp   wÿ/"  ,   XBwÿ+   Zp  +    h (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL RUBOUTS . 16)

PRIN3
M
(URET2 MKN ASZ KNIL ENTERF) X   8    @    P        

CreateHP2640DriverA0097 BINARY
             -.           ,<  "  Z   B  ,~       (VARIABLE-VALUE-CELL HPENHANCECHAR . 5)
&d
PRIN3
(ENTER0)      

CreateHP2640DriverA0098 BINARY
             -.           ,<  "  Z   B  ,~       (VARIABLE-VALUE-CELL RUBOUTS . 5)
&d@
PRIN3
(ENTER0)      

CreateHP2640DriverA0099 BINARY
             -.            ,<  "  ,~       l
PRIN3
(ENTER0)     

CreateHP2640DriverA0100 BINARY
                -.            ,<  "  ,~       m
PRIN3
(ENTER0)     

CreateHP2640DriverA0101 BINARY
                
-.           ,<  "  Z   B  ,<  	"  Z   B  ,<  "  ,~   n   (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL Y . 9)
&a
PRIN3
c
R
(ENTERF)     

CreateHP2640DriverA0102 BINARY
                -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
127
\SCREENPUT
(URET2 MKN KNIL ENTERF)           8      

CreateHP2640Driver BINARY
        L    ½    É-.           ½,<  >,<  ¾$  ?,<  Z  ¿   ,\  QD ,<  Z  @   ,\  XD ,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  XD Z   QD Z   XD Z   QD ,<  Z  Â   ,\  XD ,<  Z  C   ,\  QD ,<  Z  Ã   ,\  XD ,<  Z  D   ,\  QD ,<  Z  Ä   ,\  XD ,<  Z  E   ,\  QD Z   XD ,<  Z  Å   ,\  QD ,<  Z  F   ,\  XD ,<  Z  Æ   ,\  XD ,<  Z  G   ,\  QD @  ÇZ  H,   ,      ,\  XD ,<  Z  È   ,\  QD ,<  Z  I   ,\  XD ,<  Z  È   ,\  QD ,<  Zp  Z   ,   XB  ;Zp  +    B! B!!0         (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 120)
12
0
ARRAY
CreateHP2640DriverA0090
CreateHP2640DriverA0091
CreateHP2640DriverA0092
CreateHP2640DriverA0093
CreateHP2640DriverA0094
CreateHP2640DriverA0095
CreateHP2640DriverA0096
CreateHP2640DriverA0097
CreateHP2640DriverA0098
CreateHP2640DriverA0099
CreateHP2640DriverA0100
CreateHP2640DriverA0101
CreateHP2640DriverA0102
\SCREENPUT
SETSCREENOPINFO
GETSCREENOPHANDLER
DATE
CREATED
NILL
GETSCREENOPINFO
(URET1 CONS CONSNL CONS21 KNIL ENTER0)   `   H         P  @        

CreateSDDriverA0103 BINARY
            -.            Z  ,~       ((SD supdup) . 0)
(ENTER0)     

CreateSDDriverA0104 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

CreateSDDriverA0105 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateSDDriverA0106 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateSDDriverA0107 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateSDDriverA0108 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateSDDriverA0109 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
""
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF) 8       @    P        

CreateSDDriverA0110 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
""
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF) 8       @    P        

CreateSDDriverA0111 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateSDDriverA0112 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)      

CreateSDDriverA0113 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateSDDriverA0114 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateSDDriverA0115 BINARY
               -.           ,<  "  Z   B  Z   B  ,~       (VARIABLE-VALUE-CELL X . 7)
(VARIABLE-VALUE-CELL Y . 5)
""
\SCREENPUT
(ENTERF)     

CreateSDDriverA0116 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateSDDriverA0117 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateSDDriver BINARY
    H    ¹    F-.           ¹,<  :,<  º$  ;,<  Z  »   ,\  QD ,<  Z  <   ,\  XD ,<  Z  ¼   ,\  QD ,<  Z  =   ,\  XD ,<  Z  ½   ,\  QD ,<  Z  >   ,\  XD ,<  Z  ¾   ,\  XD ,<  Z  ?   ,\  XD ,<  Z  ¿   ,\  QD ,<  Z  @   ,\  XD ,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  QD Z  ÂXD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  QD ,<  Z  Å   ,\  XD ,<  Zp  Z   ,   XB  7Zp  +    B!!BDB!     (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 112)
12
0
ARRAY
CreateSDDriverA0103
CreateSDDriverA0104
CreateSDDriverA0105
CreateSDDriverA0106
CreateSDDriverA0107
CreateSDDriverA0108
CreateSDDriverA0109
CreateSDDriverA0110
CreateSDDriverA0111
CreateSDDriverA0112
CreateSDDriverA0113
CreateSDDriverA0114
CreateSDDriverA0115
CreateSDDriverA0116
(((TERMCAP 
"SD|supdup:co#80:li#24:am:vb=\177\23:nd=\177\20:cl=\177\22:so=\177\31:se=\177\32:pt:ce=\177\05:ec=\177\06:cd=\177\04:bs:up=\177\15:cm=\177\21%%.%%.:al=\177\25\01:dl=\177\26\01:ns"
) (TYPE (QUOTE (SD supdup))) (DELETENEXT %% %) (co 80) (li 24) (am) (vb (\SCREENPUT "")) (nd (
\SCREENPUT "")) (cl (\SCREENPUT "")) (so (\SCREENPUT "")) (se (\SCREENPUT "")) (pt) (ce (
\SCREENPUT "")) (ec (\SCREENPUT "")) (cd (\SCREENPUT "")) (bs) (up (\SCREENPUT "")) (cm (
\SCREENPUT "") (\SCREENPUT Y) (\SCREENPUT X)) (al (\SCREENPUT "")) (dl (\SCREENPUT "")) (
ns)) . 0)
\SCREENPUT
CreateSDDriverA0117
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)           

Created1DriverA0118 BINARY
               -.            Z  ,~       ((d1 vt100 vt-100 pt100 pt-100) . 0)
(ENTER0)      

Created1DriverA0119 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

Created1DriverA0120 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

Created1DriverA0121 BINARY
            -.            ,<  "  ,<  "  ,~       "[;H[2J"
\SCREENPUT
50
DELAYFOR
(ENTER0)      

Created1DriverA0122 BINARY
            -.            ,<  "  ,<  "  ,~       "[K"
\SCREENPUT
3
DELAYFOR
(ENTER0)    

Created1DriverA0123 BINARY
               -.            ,<  "  ,<  "  ,~       "[J"
\SCREENPUT
50
DELAYFOR
(ENTER0)      

Created1DriverA0124 BINARY
            -.            ,<  "  ,<  "  ,~       "[7m"
\SCREENPUT
2
DELAYFOR
(ENTER0)      

Created1DriverA0125 BINARY
            -.            ,<  "  ,<  "  ,~       "[m"
\SCREENPUT
2
DELAYFOR
(ENTER0)    

Created1DriverA0126 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

Created1DriverA0127 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

Created1DriverA0128 BINARY
               -.           ,<  "  ,<      ."  ,   D  ,<  "  ,<      ."  ,   D  ,<  "  ,<  "  ,~     (VARIABLE-VALUE-CELL X . 13)
(VARIABLE-VALUE-CELL Y . 6)
"["
\SCREENPUT
((FIX . 15032909834) . 0)
PRINTNUM
";"
((FIX . 15032909834) . 0)
"H"
5
DELAYFOR
(MKN ENTERF)     P      

Created1DriverA0129 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

Created1DriverA0130 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

Created1Driver BINARY
    B    ´    @-.           ´,<  5,<  µ$  6,<  Z  ¶   ,\  QD ,<  Z  7   ,\  XD ,<  Z  ·   ,\  QD ,<  Z  8   ,\  XD ,<  Z  ¸   ,\  QD ,<  Z  9   ,\  XD ,<  Z  ¹   ,\  QD ,<  Z  :   ,\  XD ,<  Z  º   ,\  QD ,<  Z  ;   ,\  XD ,<  Z  »   ,\  QD ,<  Z  <   ,\  QD Z  ¼XD ,<  Z  =   ,\  XD ,<  Z  ½   ,\  QD ,<  Z  >   ,\  XD ,<  Z  ¾   ,\  QD ,<  Z  ?   ,\  QD ,<  Z  ¿   ,\  XD ,<  Zp  Z   ,   XB  2Zp  +    B!!BB       (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 102)
12
0
ARRAY
Created1DriverA0118
Created1DriverA0119
Created1DriverA0120
Created1DriverA0121
Created1DriverA0122
Created1DriverA0123
Created1DriverA0124
Created1DriverA0125
Created1DriverA0126
Created1DriverA0127
Created1DriverA0128
Created1DriverA0129
(((TERMCAP 
"d1|vt100|vt-100|pt100|pt-100:co#80:li#24:am:cl=50\E[;H\E[2J:bs:cm=5\E[%%i%%2;%%2H:nd=2\E[C:up=2\E[A:ce=3\E[K:cd=50\E[J:so=2\E[7m:se=2\E[m:us=2\E[4m:ue=2\E[m:is=\E>\E[?3l\E[?4l\E[?5l\E[?7h\E[?8h:ks=\E[?1h\E=:ke=\E[?1l\E>:if=/usr/lib/tabset/vt100:ku=\EOA:kd=\EOB:kr=\EOC:kl=\EOD:kh=\E[H:k1=\EOP:k2=\EOQ:k3=\EOR:k4=\EOS:pt:sr=5\EM"
) (TYPE (QUOTE (d1 vt100 vt-100 pt100 pt-100))) (DELETENEXT %% %) (co 80) (li 24) (am) (cl (
\SCREENPUT "[;H[2J") (DELAYFOR 50)) (bs) (cm (\SCREENPUT "[") (PRINTNUM (QUOTE (FIX 2 NIL T)) (
ADD1 Y)) (\SCREENPUT ";") (PRINTNUM (QUOTE (FIX 2 NIL T)) (ADD1 X)) (\SCREENPUT "H") (DELAYFOR 5)) (nd
 (\SCREENPUT "[C") (DELAYFOR 2)) (up (\SCREENPUT "[A") (DELAYFOR 2)) (ce (\SCREENPUT "[K") (
DELAYFOR 3)) (cd (\SCREENPUT "[J") (DELAYFOR 50)) (so (\SCREENPUT "[7m") (DELAYFOR 2)) (se (
\SCREENPUT "[m") (DELAYFOR 2)) (us (\SCREENPUT "[4m") (DELAYFOR 2)) (ue (\SCREENPUT "[m") (
DELAYFOR 2)) (is (\SCREENPUT ">[?3l[?4l[?5l[?7h[?8h")) (ks (\SCREENPUT "[?1h=")) (ke (
\SCREENPUT "[?1l>")) (if (\SCREENPUT "/usr/lib/tabset/vt100")) (ku (\SCREENPUT "OA")) (kd (
\SCREENPUT "OB")) (kr (\SCREENPUT "OC")) (kl (\SCREENPUT "OD")) (kh (\SCREENPUT "[H")) (k1 (
\SCREENPUT "OP")) (k2 (\SCREENPUT "OQ")) (k3 (\SCREENPUT "OR")) (k4 (\SCREENPUT "OS")) (pt) (
sr (\SCREENPUT "M") (DELAYFOR 5))) . 0)
\SCREENPUT
Created1DriverA0130
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)   5    ³       

CreateD0DriverA0131 BINARY
            -.            Z  ,~       ((D0 dm1520 1520) . 0)
(ENTER0)     

CreateD0DriverA0132 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

CreateD0DriverA0133 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateD0DriverA0134 BINARY
            -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD0DriverA0135 BINARY
               -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD0DriverA0136 BINARY
               -.            ,<  "  ,~       ""
\SCREENPUT
(ENTER0)    

CreateD0DriverA0137 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateD0DriverA0138 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateD0DriverA0139 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateD0DriverA0140 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateD0DriverA0141 BINARY
           	    -.           	,<  
"  ^"  ,>  ,>      .Bx  ,^  /  ,   B  Z   B  ,~        (VARIABLE-VALUE-CELL X . 8)
(VARIABLE-VALUE-CELL Y . 14)
""
\SCREENPUT
(MKN BHC ENTERF)             

CreateD0DriverA0142 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateD0DriverA0143 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateD0Driver BINARY
    B    ´    @-.           ´,<  5,<  µ$  6,<  Z  ¶   ,\  QD ,<  Z  7   ,\  XD ,<  Z  ·   ,\  QD ,<  Z  8   ,\  XD ,<  Z  ¸   ,\  QD ,<  Z  9   ,\  XD ,<  Z  ¹   ,\  QD ,<  Z  :   ,\  XD ,<  Z  º   ,\  QD ,<  Z  ;   ,\  XD ,<  Z  »   ,\  QD ,<  Z  <   ,\  QD Z  ¼XD ,<  Z  =   ,\  XD ,<  Z  ½   ,\  QD ,<  Z  >   ,\  XD ,<  Z  ¾   ,\  QD ,<  Z  ?   ,\  QD ,<  Z  ¿   ,\  XD ,<  Zp  Z   ,   XB  2Zp  +    B!!BB       (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 102)
12
0
ARRAY
CreateD0DriverA0131
CreateD0DriverA0132
CreateD0DriverA0133
CreateD0DriverA0134
CreateD0DriverA0135
CreateD0DriverA0136
CreateD0DriverA0137
CreateD0DriverA0138
CreateD0DriverA0139
CreateD0DriverA0140
CreateD0DriverA0141
CreateD0DriverA0142
(((TERMCAP 
"D0|dm1520|1520:am:bs:cd=^K:ce=^]:cl=^L:cm=^^%%r%%+\040%%.:co#80:ho=^Y:ku=^_:kd=^J:kl=^H:kr=^\:kh=^Y:li#24:nd=^\:up=^_:xn:ma=^\\040^_^P^YH:pt"
) (TYPE (QUOTE (D0 dm1520 1520))) (DELETENEXT %% %) (am) (bs) (cd (\SCREENPUT "")) (ce (
\SCREENPUT "")) (cl (\SCREENPUT "")) (cm (\SCREENPUT "") (\SCREENPUT (IPLUS 32 X)) (\SCREENPUT Y
)) (co 80) (ho (\SCREENPUT "")) (ku (\SCREENPUT "
")) (kd (\SCREENPUT "
")) (kl (\SCREENPUT "")) (kr (\SCREENPUT "")) (kh (\SCREENPUT "")) (li 24) (nd (\SCREENPUT "")
) (up (\SCREENPUT "
")) (xn) (ma (\SCREENPUT " 
H")) (pt)) . 0)
\SCREENPUT
CreateD0DriverA0143
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)   P   8      

CreateH8DriverA0144 BINARY
               -.            Z  ,~       ((H8 h1520) . 0)
(ENTER0)      

CreateH8DriverA0145 BINARY
            -.            Z"  (,~       (ASZ ENTER0)         

CreateH8DriverA0146 BINARY
            -.            Z"  ,~       (ASZ ENTER0)         

CreateH8DriverA0147 BINARY
            -.            ,<  "  ,~       "~"
\SCREENPUT
(ENTER0)      

CreateH8DriverA0148 BINARY
            -.            ,<  "  ,~       "~"
\SCREENPUT
(ENTER0)      

CreateH8DriverA0149 BINARY
            -.            ,<  "  ,~       "~"
\SCREENPUT
(ENTER0)      

CreateH8DriverA0150 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"~"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreateH8DriverA0151 BINARY
            -.           Z   2B   +   Z"  ,<  ,<    wÿ1b   +   
,<  "  XBp   wÿ/"  ,   XBwÿ+   Zp  +      (VARIABLE-VALUE-CELL N . 3)
"~"
\SCREENPUT
(URET2 MKN ASZ KNIL ENTERF)  8       @    P        

CreateH8DriverA0152 BINARY
            -.            ,<  "  ,~       "~
"
\SCREENPUT
(ENTER0)     

CreateH8DriverA0153 BINARY
            -.            ,<  "  ,~       "~"
\SCREENPUT
(ENTER0)      

CreateH8DriverA0154 BINARY
            -.            Z   ,~       (KNIL ENTER0)    (      

CreateH8DriverA0155 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateH8DriverA0156 BINARY
       	        -.           ,<  "  Z   B  Z   B  ,<  "  ,~   8   (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL Y . 7)
"~"
\SCREENPUT
""
(ENTERF)      

CreateH8DriverA0157 BINARY
               -.            Z   ,~       (KNIL ENTER0)    (      

CreateH8DriverA0158 BINARY
               -.           Z   ,<  ,<    wÿ1b   +   ,<  
"  XBp   wÿ/"  ,   XBwÿ+   Zp  +    8  (VARIABLE-VALUE-CELL N . 3)
0
\SCREENPUT
(URET2 MKN KNIL ENTERF)  
               

CreateH8Driver BINARY
    H    ¹    F-.           ¹,<  :,<  º$  ;,<  Z  »   ,\  QD ,<  Z  <   ,\  XD ,<  Z  ¼   ,\  QD ,<  Z  =   ,\  XD ,<  Z  ½   ,\  QD ,<  Z  >   ,\  XD ,<  Z  ¾   ,\  XD ,<  Z  ?   ,\  XD ,<  Z  ¿   ,\  QD ,<  Z  @   ,\  XD ,<  Z  À   ,\  QD ,<  Z  A   ,\  XD ,<  Z  Á   ,\  QD ,<  Z  B   ,\  QD Z  ÂXD ,<  Z  C   ,\  XD ,<  Z  Ã   ,\  QD ,<  Z  D   ,\  XD ,<  Z  Ä   ,\  QD ,<  Z  E   ,\  QD ,<  Z  Å   ,\  XD ,<  Zp  Z   ,   XB  7Zp  +    B!!BDB!     (VARIABLE-VALUE-CELL SYSTEMSCREENDRIVERS . 112)
12
0
ARRAY
CreateH8DriverA0144
CreateH8DriverA0145
CreateH8DriverA0146
CreateH8DriverA0147
CreateH8DriverA0148
CreateH8DriverA0149
CreateH8DriverA0150
CreateH8DriverA0151
CreateH8DriverA0152
CreateH8DriverA0153
CreateH8DriverA0154
CreateH8DriverA0155
CreateH8DriverA0156
CreateH8DriverA0157
(((TERMCAP 
"H8|h1520:al=~^Z:am:bs:cd=~^X:ce=~^O:cl=~\034:cm=~^Q%%r%%.%%.\200:co#80:dl=~^S:do=~^K:hz:li#24:nd=^P:se=~^Y:so=~\037:up=~^L:ho=~^R"
) (TYPE (QUOTE (H8 h1520))) (DELETENEXT %% %) (al (\SCREENPUT "~")) (am) (bs) (cd (\SCREENPUT "~"
)) (ce (\SCREENPUT "~")) (cl (\SCREENPUT "~")) (cm (\SCREENPUT "~") (\SCREENPUT X) (\SCREENPUT Y
) (\SCREENPUT "")) (co 80) (dl (\SCREENPUT "~")) (do (\SCREENPUT "~")) (hz) (li 24) (nd (
\SCREENPUT "")) (se (\SCREENPUT "~")) (so (\SCREENPUT "~
")) (up (\SCREENPUT "~")) (ho (\SCREENPUT "~"))) . 0)
\SCREENPUT
CreateH8DriverA0158
SETSCREENOPINFO
GETSCREENOPHANDLER
NILL
GETSCREENOPINFO
(URET1 CONS ENTER0)            
(PRINT (QUOTE SCREENOPCOMS) T T)
(RPAQQ SCREENOPCOMS ((FILES EDITHIST) (FILEPKGCOMS * SCREENOPFILEPKGCOMS) (FNS * SCREENOPFNS) (ADDVARS
 (CURRENTDRIVER) (SYSTEMSCREENDRIVERS) (AFTERSYSOUTFORMS (SETQ DISPLAYTERMP (DISPLAYTERMP))) (
DISPLAYTERMPFORMS (PREPAREDELETENEXT))) (INITVARS (SYSTEMTERMTYPES (SELECTQ (SYSTEMTYPE) (TENEX (QUOTE
 ((10 COND ((ILEQ (CSPEED) 2400) (QUOTE HP2640)) (T (QUOTE HP))) (14 . h1520e) (21 . ANNARBOR)))) (
TOPS20 (QUOTE ((6 COND ((ILEQ (CSPEED) 2400) (QUOTE HP2640)) (T (QUOTE HP))) (15 . h1520e) (21 . h1520
) (24 . ANNARBOR) (25 . HEATHKIT)))) (VAX (QUOTE ((hp . HP) (2621 . HP) (2621k45 . HP) (2640 . HP2640)
))) NIL))) (GLOBALVARS CURRENTSCREEN DISPLAYTERM DISPON) (P (PROG ((I 0)) (SETQ DISPLAYTERM (
COPYTERMTABLE (QUOTE ORIG))) (RPTQ 32 (ECHOCONTROL I (QUOTE REAL) DISPLAYTERM) (SETQ I (ADD1 I))))) (
EDITHIST * SCREENOPEDITHIST) (EXPORT (MACROS * SCREENOPMACROS) (DECLARE: EVAL@COMPILE DONTCOPY (FNS 
COMPILESCREENOP)) (RECORDS * SCREENOPRECORDS)) (SCREENDRIVERS CreatePrototypeDriver) (SCREENDRIVERS * 
SCREENOPS) (VARS (PROTOTYPEDRIVER (CreatePrototypeDriver)) (\SPEEDBLOCK (CREATE SGTTYB)) (
HPENHANCECHAR (QUOTE B)) (RUBOUTS (PACKC (QUOTE (127 127 127 127 127))))) (P (DISPLAYTERMP))))
(FILESLOAD EDITHIST)
(RPAQQ SCREENOPFILEPKGCOMS (SCREENDRIVERS))
(PUTDEF (QUOTE SCREENDRIVERS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (FNS . X) (PROP SCREENDRIVERS 
. X) (P (MAPCAR (QUOTE X) (FUNCTION (LAMBDA (A) (AND (GETD A) (APPLY* A))))))) CONTENTS 
CHECKIFSCREENDRIVER) (TYPE DESCRIPTION "Screen Drivers" GETDEF (LAMBDA (A) (AND (GETPROP A (QUOTE 
SCREENDRIVERS)) (GETDEF A (QUOTE FNS) 0 (QUOTE ("NO DEF"))))) PUTDEF (LAMBDA (A B C) (PUTDEF A (QUOTE 
FNS) C) (PUTPROP A (QUOTE SCREENDRIVERS) T)) EDITDEF (LAMBDA (A) (EDITDEF A (QUOTE FNS))) DELDEF (
LAMBDA (A) (DELDEF A (QUOTE FNS)))))))
(RPAQQ SCREENOPFNS (BUILDDRIVER CHECKIFSCREENDRIVER COMPILESCREENOP CSPEED DELAYFOR DISPLAYTERMP 
DISPLAYTERMTYPE GETSCREENOPHANDLER GETSCREENOPINFO KNOWNTERMTYPES PARSECHARSEQUENCE PARSECURSORPOS 
PARSETERMCAP PREPAREDELETENEXT SCREENOP SCREENOPCOMPILED SEGMENTSTRING SETSCREENOPINFO \SCREENPUT))
(ADDTOVAR CURRENTDRIVER)
(ADDTOVAR SYSTEMSCREENDRIVERS)
(ADDTOVAR AFTERSYSOUTFORMS (SETQ DISPLAYTERMP (DISPLAYTERMP)))
(ADDTOVAR DISPLAYTERMPFORMS (PREPAREDELETENEXT))
(RPAQ? SYSTEMTERMTYPES (SELECTQ (SYSTEMTYPE) (TENEX (QUOTE ((10 COND ((ILEQ (CSPEED) 2400) (QUOTE 
HP2640)) (T (QUOTE HP))) (14 . h1520e) (21 . ANNARBOR)))) (TOPS20 (QUOTE ((6 COND ((ILEQ (CSPEED) 2400
) (QUOTE HP2640)) (T (QUOTE HP))) (15 . h1520e) (21 . h1520) (24 . ANNARBOR) (25 . HEATHKIT)))) (VAX (
QUOTE ((hp . HP) (2621 . HP) (2621k45 . HP) (2640 . HP2640)))) NIL))
(PROG ((I 0)) (SETQ DISPLAYTERM (COPYTERMTABLE (QUOTE ORIG))) (RPTQ 32 (ECHOCONTROL I (QUOTE REAL) 
DISPLAYTERM) (SETQ I (ADD1 I))))
(RPAQQ SCREENOPEDITHIST (SCREENDRIVER))
(RPAQQ SCREENOPMACROS (SCREENOP))
(PUTPROPS SCREENOP MACRO (X (COMPILESCREENOP X)))
(RPAQQ SCREENOPRECORDS (SCREENDRIVER SGTTYB))
(ARRAYBLOCK SCREENDRIVER (TYPELIST XSIZE YSIZE CLEAR CLEARLINE CLEARREST INSERT INSERTLINE DELETE 
DELETELINE SETHIGHLIGHT CLEARHIGHLIGHT SETLOCK CLEARLOCK SETCURSOR READCURSOR OVERSTRIKEP OTHERINFO 
OTHERFUNCTIONS \INFOALIST GETHANDLER SETINFO PAD PRINT) (CREATE (PROG ((TMP DATUM)) (DECLARE (
LOCALVARS TMP)) (push SYSTEMSCREENDRIVERS TMP) (RETURN TMP))) TYPELIST _ (FUNCTION NILL) OVERSTRIKEP _
 (FUNCTION NILL) SETLOCK _ (FUNCTION NILL) CLEARLOCK _ (FUNCTION NILL) SETHIGHLIGHT _ (FUNCTION NILL) 
CLEARHIGHLIGHT _ (FUNCTION NILL) OTHERINFO _ (FUNCTION GETSCREENOPINFO) OTHERFUNCTIONS _ (FUNCTION 
NILL) SETINFO _ (FUNCTION SETSCREENOPINFO) \INFOALIST _ (CONS (CONS (QUOTE CREATED) (DATE))) PAD _ (
FUNCTION (LAMBDA (N) (RPTQ N (\SCREENPUT 0)))) PRINT _ (FUNCTION \SCREENPUT) GETHANDLER _ (FUNCTION 
GETSCREENOPHANDLER))
(ARRAYBLOCK SGTTYB ((ISPEED BITS 8) (OSPEED BITS 8) (ERASE BITS 8) (KILL BITS 8) (FLAGS BITS 16)) (
ACCESSFNS ((OUTPUTSPEED (SELECTQ (FETCH (SGTTYB OSPEED) OF DATUM) (1 50) (2 75) (3 110) (4 134) (5 150
) (6 200) (7 300) (8 600) (9 1200) (10 1800) (11 2400) (12 4800) (13 9600) NIL)))))
(PUTPROPS CreatePrototypeDriver SCREENDRIVERS T)
(MAPCAR (QUOTE (CreatePrototypeDriver)) (FUNCTION (LAMBDA (A) (AND (GETD A) (APPLY* A)))))
(RPAQQ SCREENOPS (Create2621k45Driver CreateAAdriver CreateD2Driver CreateV2Driver CreatekbDriver 
CreateHP2640Driver CreateSDDriver Created1Driver CreateD0Driver CreateH8Driver))
(PUTPROPS Create2621k45Driver SCREENDRIVERS T)
(PUTPROPS CreateAAdriver SCREENDRIVERS T)
(PUTPROPS CreateD2Driver SCREENDRIVERS T)
(PUTPROPS CreateV2Driver SCREENDRIVERS T)
(PUTPROPS CreatekbDriver SCREENDRIVERS T)
(PUTPROPS CreateHP2640Driver SCREENDRIVERS T)
(PUTPROPS CreateSDDriver SCREENDRIVERS T)
(PUTPROPS Created1Driver SCREENDRIVERS T)
(PUTPROPS CreateD0Driver SCREENDRIVERS T)
(PUTPROPS CreateH8Driver SCREENDRIVERS T)
(MAPCAR (QUOTE (Create2621k45Driver CreateAAdriver CreateD2Driver CreateV2Driver CreatekbDriver 
CreateHP2640Driver CreateSDDriver Created1Driver CreateD0Driver CreateH8Driver)) (FUNCTION (LAMBDA (A)
 (AND (GETD A) (APPLY* A)))))
(RPAQ PROTOTYPEDRIVER (CreatePrototypeDriver))
(RPAQ \SPEEDBLOCK (CREATE SGTTYB))
(RPAQQ HPENHANCECHAR B)
(RPAQ RUBOUTS (PACKC (QUOTE (127 127 127 127 127))))
(DISPLAYTERMP)
NIL
 