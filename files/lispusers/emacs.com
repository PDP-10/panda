(FILECREATED "23-Apr-84 17:12:45" ("compiled on " 
<LISPUSERS>EMACS.LSP.40423) (2 . 2) tcompl%'d in WORK dated 
"26-SEP-83 03:48:06")
(FILECREATED "23-Apr-84 17:11:15" <LISPUSERS>EMACS.LSP.40423 32551 
changes to: (FNS BytePointer Down DumpLines EMACS EmacsPP 
EmacsTerminalSetup EmacsReturn MapBytes PageOfByte ReadEditResult) 
previous date: " 1-Apr-83 15:09:21" <LISPUSERS>EMACS.LSP.30401)

BinaryMode BINARY
                -.            ^"ß,>  ,>        £   ABx  ,^  /     $,~              (BHC ENTER0)         

BytePointer BINARY
               -.               ,>  ,>  ^"  ,>  ,>      &"        ^"  /  $Bx  ,^  /  ."  (B  ,>  ,>  ^" `GBx  ,^  /  (B  	,>  ,>     &"  GBx  ,^  /  .Bx  ,^  /  ,   ,~     @      (VARIABLE-VALUE-CELL base . 3)
(VARIABLE-VALUE-CELL offset . 29)
(MKN BHC ENTERF)   8   0  X        

CallEmacs BINARY
            -.           @    ,~   Z   ,<  Z   ,<  Z   F  XB   ,<      ,>  ,>  Z  ,      ®+    +    +       ABx  ,^  /  0B   +   Zp  +      <,<  "  Z  ,<  Z  ,<  Z  F  XB  +   /  Z  ,~          ` V
    (VARIABLE-VALUE-CELL process . 6)
(VARIABLE-VALUE-CELL binFlg . 36)
(VARIABLE-VALUE-CELL start . 38)
(NIL VARIABLE-VALUE-CELL proc . 43)
EmacsSubsys
1000
DISMISS
(BHC IUNBOX KNIL ENTERF)   `     
           

ClearScreen BINARY
               -.           Z   ,      "   "      +        ,~       (VARIABLE-VALUE-CELL CLEARSCREEN . 3)
(KNIL UPATM ENTER0)    `    0      

Down BINARY
       (        ¦-.          @    ,~   Z   ,   ,   XB   ,<  ,<   $   ,   ,<  Z   3B   +      "   $   +   Z  	,   ,\   B  Z  ,<  ,<  !$  ¡Z   ,<  ,<   ,<  "&  ¢XB     #   £Z   1B   +   ,<   "  $,<  ¤,<   $  %,<   "  $,<  ¥"  &Z  ,<  ,<   $  ¢XB  +   Z   ,~   @ceW
       (VARIABLE-VALUE-CELL flag . 15)
(VARIABLE-VALUE-CELL emacsTempFile . 26)
(VARIABLE-VALUE-CELL LASTEMACS . 54)
(VARIABLE-VALUE-CELL emacsExtrac . 38)
(NIL VARIABLE-VALUE-CELL temp . 22)
emacsArg
EMACS.LOC
GETPROP
0
SETFILEPTR
START
CallEmacs
ClearScreen
SetEmacsVars
TERPRI
"Illegal exit from EMACS. Use a ^T command.
(The gap is not closed). Returning to EMACS."
PRIN1
3000
DISMISS
(ASZ KT GUNBOX FIXT KNIL IUNBOX MKN FGFPTR ENTERF)          X                  x    P    H      

DumpLines BINARY
       º    ²    ¸-.          ²@  ³  (
,~   Z   B  6XB   Z"   XB   Z  B  ¶XB      ,   XB   ,<      1b   +      ,>  ±,>         ,^  /  3"  +   Zp  +      ,>  ±,>     	   ,^  /         $   @      /"   $   @  Z  Z$  ,   3B   +      ."  ,   XB  +   	/     ."   $   @     ,>  ±,>        ,^  /  /  ,   ,<  @  7  +   °    ,>  ±,>   `    ,^  /  3b  +   +Z` ,~                  2      ¥."  ,   XB  .+   ¥Z   ,~          B *  ! T      (VARIABLE-VALUE-CELL n . 24)
(VARIABLE-VALUE-CELL emacsDribbleFile . 11)
(NIL VARIABLE-VALUE-CELL end . 62)
(NIL VARIABLE-VALUE-CELL lineCount . 55)
(NIL VARIABLE-VALUE-CELL ptr . 65)
(NIL VARIABLE-VALUE-CELL char . 47)
(NIL VARIABLE-VALUE-CELL jfn . 86)
GETEOFPTR
OPNJFN
(0 . 1)
NIL
(1 VARIABLE-VALUE-CELL i . 95)
(EQP FIXT BHC KNIL MKN ASZ ENTERF)        x     © 0  @     ±       0 @             

EnterEmacs BINARY
        $        #-.           Z   ,   ,<  @    ,~   Z   ,<  ,<  $  ,<  Z  D  ,<   "       XB` Z   B  !Z` Z   ,   3B   +   Z   ,~   Z` 2B  ¡+   [` ,<  Zp  -,   +   +   Zp  ,<  ,<p  ,<  "$  ¢/  [p  XBp  +   /  [` ,~   ,<` ,<  "$  ¢Z` ,   ,~   ,Bc0  (VARIABLE-VALUE-CELL emacsTempFile . 14)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 20)
(VARIABLE-VALUE-CELL exp . 23)
NIL
0
SETFILEPTR
"FS TTYINI-1FS PJATY"
PRIN1
Down
EmacsReturn
DumpLines
***Multi***
_
LISPXEVAL
(BHC SKNLST EQUAL KT CONSNL KNIL ENTER0)              	      0   h   (      

EMACS BINARY
              -.          @    ,~   Z   ,<  Z   D        XB   Z   B  Z  Z  ,   2B   +   Z   3B   +   [  
,<  ,<   $  Z  ,<  Z  D  Z  ,<  [  D  [  [  Z  2B  +   Z  B  Z  ,~   B"    (VARIABLE-VALUE-CELL exp . 42)
(VARIABLE-VALUE-CELL fnFlg . 8)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 13)
(VARIABLE-VALUE-CELL EDITCHANGES . 35)
(NIL VARIABLE-VALUE-CELL newExp . 33)
EmacsPP
Down
EmacsReturn
DumpLines
RPLACA
/RPLACA
/RPLACD
FNS
FIXEDITDATE
(KT KNIL EQUAL ENTERF)                  

EmacsPP BINARY
    Ñ    A    O-.          AZ   2B   +   Z   ,<  ,<  D$  ÄZ   ,<  @  E  ,~   Z   ,<  ,<  Æ,<  G,<   @  Ç ` +   :Z   Z  IXB ,<  ÉZ  B  É,   ,   Z  ,   XB  ,<  J"  Ê,<  Z  JZ 7@  7   Z  ,   Z  J,   ,<  Z  JZ   ,   ,\  Z  ,   XB  ,<  K"  Ê,<  Z  KZ 7@  7   Z  ,   Z  K,   ,<  Z  KZ   ,   ,\  Z  ,   XB  ¢,<  Ë"  Ê,<  Z  ËZ 7@  7   Z  ,   Z  Ë,   ,<  Z  ËZ   ,   ,\  Z  £,   XB  ,,<  L,<   "  L,   ,   Z  -,   XB  0Z   3B   +   6Z   ,<  ,<  Ì,<   &  M+   ¸Z  3,<  ,<  Ì,<   &  MXB   Z   ,~   3B   +   <Z   +   ¼Z  ÍXB   D  NZ  ¼3B   +   @   Î,~   Z  ¸,~   2*Á H h@¥L       (VARIABLE-VALUE-CELL form . 108)
(VARIABLE-VALUE-CELL flg . 99)
(VARIABLE-VALUE-CELL samepos . 3)
(VARIABLE-VALUE-CELL emacsTempFile . 27)
(VARIABLE-VALUE-CELL LISPXHIST . 10)
(VARIABLE-VALUE-CELL RESETVARSLST . 98)
0
SETFILEPTR
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 128)
(NIL VARIABLE-VALUE-CELL RESETZ . 123)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
CHANGECHAR
STKSCAN
FONTCHANGEFLG
#RPARS
GCGAG
1
PRINTDEF
ERROR
RESETRESTORE
ERROR!
(KT SET CONS21 CONSS1 KNOB CONS CONSNL ALIST2 CF KNIL ENTERF)     µ    , (     *      ) x     ( h     ± X $ (     °               ? @ ;  3 p «    (        

EmacsSubsys BINARY
       [    È    Ø-.          È@  Ê  ,~   Z   -,   +      LZ  XB      ÌXB      MXB   +   Z  XB  [  [  Z  XB  [  Z  XB  Z  B  Ì,<  @  Í  ,~   ,<  ÌZ   ,<  ,   ,   Z   ,   XB  XB` ,<  Ï,<  P,<   @  Ð ` +   ¿Z   Z  RXB Z  B  M,<  @  Ò  +   ½,<  MZ  ,<  ,   ,   Z  ,   XB  XB` ,<  Ô,<  P,<   @  Ð ` +   ´Z   Z  RXB @  U  +   ²Z   3B   +   ¨   ÕZ  	,<  ,<   ,<   Z   H  V,<  ,<   ,<   ,   XB   [  ­[  @  ÌD  Ö[  .@  MD  ÖZ  0,~   Zw{XB8 Z   ,~   2B   +   ¶Z  WXB   [` XB  ,<  MZ` Z  [  D  ×Z  63B   +   ¼   X,~   Z` ,~   Zw}XB8 Z   ,~   2B   +   ÁZ  WXB  :[` XB  7,<  ÌZ` Z  [  D  ×Z  A3B   +   Ç   X,~   Z` ,~   2P$*+ 5T`@6LD&     (VARIABLE-VALUE-CELL process . 23)
(VARIABLE-VALUE-CELL binaryFlg . 77)
(VARIABLE-VALUE-CELL start . 85)
(VARIABLE-VALUE-CELL RESETVARSLST . 132)
(NIL VARIABLE-VALUE-CELL fork . 81)
(NIL VARIABLE-VALUE-CELL tiw . 26)
(NIL VARIABLE-VALUE-CELL coc . 50)
Enable^CCapability
STIW
SFCOC
(VARIABLE-VALUE-CELL OLDVALUE . 57)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 138)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
(NIL VARIABLE-VALUE-CELL handle . 99)
BinaryMode
SUBSYS
RPLACA
ERROR
APPLY
ERROR!
(KT LIST3 CF KNIL CONS CONSNL LIST2 SKLA ENTERF) x ´    .    ¤    h À 8 µ X - 0 ª   ¢ h          0   h            

EmacsTerminalSetup BINARY
     ·    ª    6-.           ª   )   ©      A"ÿ,   XB      $"  &" X,   ,<  ,<  - wÿ,>  *,>   p     ,^  /  3b  +   Zp  +   Zwÿ/  XB   Z   2B  ­+   Z"  A"  ¿Z   ." Z  B  .XB   ,<  ®,<  /$  ¯,~   2B  0+   ,<  °,<  1,   B  ±B  .XB  ,~   2B  2+   ,<  °,<  ²,   B  ±B  .XB  ,~   2B  3+   ¤,<  °,<  ³,<  4,<  ´,   B  ±B  .XB  ,~   ,<  5,<  5,<  µ,<  4,   B  ±B  .XB  £,~               (
=O3{=@   (VARIABLE-VALUE-CELL type . 30)
(VARIABLE-VALUE-CELL terminalSpeed . 10)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 29)
(VARIABLE-VALUE-CELL FCHARAR . 35)
(VARIABLE-VALUE-CELL CLEARSCREEN . 80)
20
DATAMEDIA-2500
MKSTRING
30
REAL
ECHOCONTROL
TELERAY-1061
27
106
PACKC
HEATH-19
69
CONCEPT-100
112
13
10
126
12
(LIST4 LIST2 ASZ BHC MKN ENTERF)  § 0   X          @    x        

Enable^CCapability BINARY
             -.                        ´,~            @        (ENTER0)      

EmacsReturn BINARY
     k    T    h-.         8 T@  X  ,~       (BwA"ÿ,   XB   0B   +      Y,~   0B  +      YB  ÙXB   ,<  Z   D  Z   ÚZ   B  [,~   0B  +      Y,<  ,<   $  ÛXB  ,<  Z  D  Z   ÚZ  B  [,~   0B  +      Y,<  Z  D  Z   ÚZ  B  [,~   0B  +   Z   ,<  Z  D  Z   ÚZ  B  [,~   0B  +   ¤Z  3B   +   £Z   B  \,<  Ü"  ],~   Z  ,~   0B  +   *,<  Ý,<   $  ^   ÞB  _B  ßZ  B  [,~   0B  +   .   YB  _B  ßZ  ¨B  [,~   0B  +   1   YZ  `,   ,~   0B  +   9   YB  _Z   ,<  ,<  à$  a,<  áZ  3D  ^,<   "  ÚZ  ¬B  [,~   0B  +   Â,<  b,<   ,<   @  â ` +   @Z   Z  dXB    YB  _+    Z  B  äZ  ·B  [,~   0B  +   Í,<  e,<   $  ^   ÞXB   ,<  ,<   ,<   ,<  å(  f2B   +   JZ  æXB   ,<  ,<   $  ßZ  AB  [,~   ,<   "  g,<  ç,<   $  ^Z  ,<  ,<   $  ^,<   "  gZ  £,~   4diMR.itqgTe,S°XS"@      (VARIABLE-VALUE-CELL flg . 152)
(VARIABLE-VALUE-CELL emacsFsexit . 6)
(VARIABLE-VALUE-CELL fnFlg . 55)
(VARIABLE-VALUE-CELL exp . 166)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 66)
(VARIABLE-VALUE-CELL emacsTempFile . 107)
(VARIABLE-VALUE-CELL functionName . 139)
(VARIABLE-VALUE-CELL functionDef . 148)
(NIL VARIABLE-VALUE-CELL arg1 . 160)
(NIL VARIABLE-VALUE-CELL form . 33)
ReadEditResult
CLISPIFY
EmacsPP
Down
EmacsReturn
DWIMIFY
DumpLines
LEDIT
RETFROM
"*"
PRIN1
READ
EVAL
OtherWindow
***Multi***
0
SETFILEPTR
"FS TTYINI-1FS PJATY"
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ScratchBuffer
"Function: "
((NODWIM NOERROR) . 0)
GETDEF
((* Function undefined) . 0)
TERPRI
"Unimplemented return code - "
(CONSNL CF CONS21 KNIL KT ASZ MKN ENTERF)   À    >    1    É 	  Ç @ »    
0 R 
  Î 	@ E x '    8 :   / 0 ¥ x  X              

FixBreakMacros BINARY
    $        #-.           Z  Z   7  [  Z  Z  1H  +   2D   +   ,<  Z  ,   D  Z   Z  7  [  Z  Z  1H  +   2D   +   
,<  Z   ,   D  Z  !Z  	7  [  Z  Z  1H  +   2D   +   ,<  Z  ¡,   D  Z  "Z  7  [  Z  Z  1H  +   2D   +   ,<  Z  ¢,   D  ,~   
X
X0  (VARIABLE-VALUE-CELL BREAKMACROS . 46)
BTV
((BAKTRACE LASTPOS NIL (BREAKREAD (QUOTE LINE)) 1 T) . 0)
RPLACD
BTV+
((BAKTRACE LASTPOS NIL (BREAKREAD (QUOTE LINE)) 5 T) . 0)
BTV*
((BAKTRACE LASTPOS NIL (BREAKREAD (QUOTE LINE)) 7 T) . 0)
BTV!
((BAKTRACE LASTPOS NIL (BREAKREAD (QUOTE LINE)) 47 T) . 0)
(CONSNL KNIL ENTER0)   X  x      H   h      

FlushEmacs BINARY
      .    #    ¬-.          0 #Z   3B   +   Z  B  &Z   XB  ,<  ¦"  '   §Z   B  (3B   +   Z  B  ¨Z   B  (3B   +   Z  B  ¨Z   B  (3B   +      )Z   -,   +   Z   +   "   (Bû      ¢Q$     Z   0B  +      (Bû      ¢Q$     ,<  ©,<   ,<   @  * ` +   !Z   Z  «XB Z  ,   ,<  Z  D  ,Z   ,~   Z   XB  ,~   ÿNU*eDJA      (VARIABLE-VALUE-CELL LASTEMACS . 9)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 17)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 23)
(VARIABLE-VALUE-CELL EMACS.DRIBBLE.FILE . 25)
(VARIABLE-VALUE-CELL ourBlockStart . 67)
(VARIABLE-VALUE-CELL emacsBlockSize . 62)
KFORK
((EDITL) . 0)
UNADVISE
FixBreakMacros
OPENP
CLOSEF
DRIBBLE
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
RELBLK
(KT GUNBOX CF ASZ SKNNM KNIL ENTER0)     p   P   `         (  h     0      

LEDIT BINARY
          
    -.           
@    ,~   Z   ,<  ,<  $  ,<   "  ,<   "  XB   Z   B  Z  B  ,~   5  (VARIABLE-VALUE-CELL emacsTempFile . 6)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 15)
(NIL VARIABLE-VALUE-CELL sexp . 17)
0
SETFILEPTR
Down
EmacsReturn
DumpLines
LISPXEVAL
(KT ENTER0)    `      

Left BINARY
               -.               (BwA"ÿ,   ,~       (VARIABLE-VALUE-CELL word . 3)
(MKN ENTERF)   @      

MapBytes BINARY
        *    £    ¨-.          £Z   B  ¥,<  Z   B  ¥,<  @  & @,~       ,>  #,>   `    ,^  /  3b  +   Z` ,~   Z   ,<  Z  ,<  Z   ,<     ,>  #,>  Z  B  ¥,      ,^  /  2B  +      &" 
    ,   +   Z"   ,<     ,>  #,>  Z  B  ¥,      ,^  /  2B  +      &" 
    ,   +    Z  §J  (   ."  ,   XB   +     Q " CB     (VARIABLE-VALUE-CELL start . 40)
(VARIABLE-VALUE-CELL end . 58)
(VARIABLE-VALUE-CELL LASTEMACS . 23)
(VARIABLE-VALUE-CELL emacsMapFileJfn . 27)
PageOfByte
(0 . 1)
(VARIABLE-VALUE-CELL i . 68)
NIL
2560
MapProcessToFile
(ASZ MKN IUNBOX BHC ENTERF) x   (  h   0      8 
       

MapProcessToFile BINARY
                -.     (               Q$         ,>  ,>         ,^  /  Q"  ,>  ,>        ,^  /  Q$            ,>  ,>  Z   ,   ,<  Z   D  ,   ,>  ,>      ,>  ,>        ,^  /  /     ,^  /  ,^  /     ,~   ÿ          (VARIABLE-VALUE-CELL process . 11)
(VARIABLE-VALUE-CELL page . 8)
(VARIABLE-VALUE-CELL jfn . 25)
(VARIABLE-VALUE-CELL startByte . 39)
(VARIABLE-VALUE-CELL endByte . 36)
(VARIABLE-VALUE-CELL emacsMapBlockPage . 18)
(VARIABLE-VALUE-CELL emacsMapBlock . 28)
BytePointer
(IUNBOX MKN BHC ENTERF)      x     `         

OtherWindow BINARY
     ,    ¢    ª-.          ¢@  $  ,~   Z   ,<  ,<  ¥$  &,<  ¦Z  D  'Z  B  §,<  (Z  D  'Z  B  §Z  	,   ,   XB   ,<  ¨Z  
D  ',<  )Z  D  'Z  ,   ,   XB   Z   ,<  Z   ,<  ,<   &  ©Z  ,   ,   XB   Z  ,<  Z  D  &   ,>  ",>        ,^  /  /  ,   ,<  Z  D  'Z  ,<  Z  D  &,<   "  *Z   ,~     :j        (VARIABLE-VALUE-CELL sexp . 34)
(VARIABLE-VALUE-CELL fnflg . 36)
(VARIABLE-VALUE-CELL emacsTempFile . 60)
(NIL VARIABLE-VALUE-CELL fixPos . 46)
(NIL VARIABLE-VALUE-CELL tecoPos . 62)
(NIL VARIABLE-VALUE-CELL endPos . 48)
0
SETFILEPTR
"FS TTYINI0FO..QWindow 2 Size%"E M(M.M^R Two Windows)'"
PRIN1
TERPRI
"%"#M(M.M^R Other Window)' M(M.MSelect Buffer)W2HK"
"     FYJM(M.M^R Other Window)"
"-1FS PJATY"
EmacsPP
Down
(KNIL BHC KT MKN FGFPTR ENTERF)     @         `  @   X  8      

PageOfByte BINARY
              -.           @    ,~       &"  ,   XB      &"     ,   XB   0B   +   
   ."  +      (Bû,   ,~      (VARIABLE-VALUE-CELL byte . 10)
(NIL VARIABLE-VALUE-CELL quo . 20)
(NIL VARIABLE-VALUE-CELL rem . 14)
(ASZ MKN ENTERF)         x        

ReadAc BINARY
               -.           ,<  [p  2B   +   ,<p  ,<  ,<  $     ,\  XD  Z   QD  Zp  /  ,<  @     ,~       ,>  ,>  Z   ."     ,^  /     ¸Z  ,<      ."  ,   D  ,~     8 @    (VARIABLE-VALUE-CELL process . 22)
(VARIABLE-VALUE-CELL ac . 33)
((NIL) . 0)
16
ARRAY
(VARIABLE-VALUE-CELL acBlock . 31)
ELT
(MKN BHC KT KNIL ENTERF)                8      

ReadEditResult BINARY
               -.          (     ,>  ,>         ,^  /  3b  +   	Z   ,<  Z  D  Z  XB  Z  ,<  Z   D  Z  
,<  Z  D  Z  	,<  Z  D  @    ,~   Z  ,<  Z   D  ,~      D0@    (VARIABLE-VALUE-CELL emacsZ . 24)
(VARIABLE-VALUE-CELL emacsMapFileEof . 17)
(VARIABLE-VALUE-CELL emacsMapFile . 33)
(VARIABLE-VALUE-CELL emacsPt . 28)
(VARIABLE-VALUE-CELL emacsReadTable . 35)
SETFILEPTR
MapBytes
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
(BHC ENTER0)          

Right BINARY
                -.               A"ÿ,   ,~       (VARIABLE-VALUE-CELL word . 3)
(MKN ENTERF)   8      

SFCOC BINARY
              -.                 %   ,   ,<        %   ,   ,   ,<  Z   3B   +   Z  ,   ,>  ,>  [  ,      ,^  /        ¥,\  ,~            (VARIABLE-VALUE-CELL pair . 21)
(BHC IUNBOX KNIL CONSS1 MKN ENTERF)   X   @ 
              @      

STIW BINARY
       
    	    -.           	      ½   ,   ,<  Z   3B   +               >,\  ,~   ý	   (VARIABLE-VALUE-CELL tiw . 11)
(KNIL MKN ENTERF)   X    @      

ScratchBuffer BINARY
        $        #-.          @    ,~   Z   ,<  ,<  $   ,<   Z  D  !Z  ,   ,   XB   ,<  ¡Z  D  !Z  	,   ,   XB   Z   ,<  ,<   ,<   &  "Z  
,   ,   XB   Z  ,<  Z  D      ,>  ,>        ,^  /  /  ,   ,<  Z  D  !Z  ,<  Z  D   ,<   "  ¢Z   ,~     :
 @P  (VARIABLE-VALUE-CELL sexp . 24)
(VARIABLE-VALUE-CELL emacsTempFile . 49)
(NIL VARIABLE-VALUE-CELL fixPos . 35)
(NIL VARIABLE-VALUE-CELL tecoPos . 51)
(NIL VARIABLE-VALUE-CELL endPos . 37)
0
SETFILEPTR
"FS TTYINIM(M.MSelect Buffer)ScratchHK"
PRIN1
"     FYJ"
EmacsPP
Down
(KNIL BHC KT MKN FGFPTR ENTERF) H   h   8  `   x  @      8        

ScratchFile BINARY
               -.           @    ,~   Z   ,<  ,<  $  XB   B  Z  B  XB      Q"           Z  B  Z  
,~   @    5@ (VARIABLE-VALUE-CELL fileName . 6)
(NIL VARIABLE-VALUE-CELL realFileName . 22)
(NIL VARIABLE-VALUE-CELL jfn . 15)
OUTPUT
OPENFILE
CLOSEF
GTJFN
IOFILE
(ENTERF)      

SetEmacsVars BINARY
              -.           Z   ,<  Zp  -,   +   +   Zp  ,<  @     +   Z   ,<  ,<  ,<  $  ,      ,      ,\  ,   ,~   [p  XBp  +   /  Z   ,<  ,<  $  XB   ,~   e F     (VARIABLE-VALUE-CELL emacsVars . 3)
(VARIABLE-VALUE-CELL LASTEMACS . 30)
(VARIABLE-VALUE-CELL emacsFsexit . 34)
(VARIABLE-VALUE-CELL var . 14)
EMACS.LOC
GETPROP
3
ReadAc
(BHC SET MKN IUNBOX SKNLST ENTER0)                         

SetupBreakMacros BINARY
       $        #-.           Z  Z   7  [  Z  Z  1H  +   2D   +   ,<  Z  ,   D  Z   Z  7  [  Z  Z  1H  +   2D   +   
,<  Z   ,   D  Z  !Z  	7  [  Z  Z  1H  +   2D   +   ,<  Z  ¡,   D  Z  "Z  7  [  Z  Z  1H  +   2D   +   ,<  Z  ¢,   D  ,~   
X
X0  (VARIABLE-VALUE-CELL BREAKMACROS . 46)
BTV
((Stack 1) . 0)
RPLACD
BTV+
((Stack 5) . 0)
BTV*
((Stack 7) . 0)
BTV!
((Stack 47) . 0)
(CONSNL KNIL ENTER0) X  x      H   h      

SetupEmacsDribble BINARY
            -.           ,<      XBp  3B   +   XB   +   Z   B  XB  ,<  ,<   ,<   &  Zp  +    T  (VARIABLE-VALUE-CELL emacsDribbleFile . 12)
(VARIABLE-VALUE-CELL EMACS.DRIBBLE.FILE . 10)
DRIBBLEFILE
ScratchFile
DRIBBLE
(URET1 KT KNIL ENTER0)             (      

Stack BINARY
              -.          Z   ,<  ,<  $  Z   ,<  ,<   ,<  "  ,<  Z   ,<  Z  J     Z   B  ,~     (VARIABLE-VALUE-CELL flags . 13)
(VARIABLE-VALUE-CELL emacsTempFile . 15)
(VARIABLE-VALUE-CELL LASTPOS . 7)
(VARIABLE-VALUE-CELL REFRESH.LINE.COUNT . 18)
0
SETFILEPTR
LINE
BREAKREAD
BAKTRACE
Down
DumpLines
(KNIL ENTERF)  X      

StartEmacs BINARY
     1      ,-.          @   ,~   ,< Zp  -,   +   +    Zp  ,<  @    +   ,< Z   ,<  ,< & ,<  ,<   ,<  ,< ,< Zp  -,   +   Zp  Z 7@  7   Z  2B +   ,<p  ,<   Z   F B 3B   +   Z   +   Z   /  3B   +   Z   +   Z XB  ,<  ,< Z  L    ,\  ,   ,~   [p  XBp  +   /    ,< ,< ,< & ,< " Z   B XB   ,<  Z   D    ¿+    +    +    ,   B B XB   3B +   0,< " ,      D+    +    +    ,<  Z   ,<  ,<  & !B ¡Z   B "XB   Z  +3B +   ¹Z  ´B ,      D+    +    +    Z  4,<  ,< ¢$ #XB      »(Bû,> ,>     <."  (Bû   ,^  /  2B  +   ÃZ"  XB   +   ÄZ"  XB  ÂB £,   XB   Z   ,<  @ $  +   ÛZ` -,   +   Ê+   ÚZ  XB   ,<  ,< &    ,> ,>     Å,> ,>  ^" ÿ,> ,>     >ABx  ,^  /  GBx  ,^  /  .Bx  ,^  /  ,   F ¦[` XB`    Ì."  ,   XB  X+   ÈZ` ,~      Q(Bû,> ,>  Z  ¹,      ,^  /  Q"  ,> ,>     N(Bû   ,^  /  Q$       Z  D0B  +   ð   Û(Bû,> ,>         ,^  /  Q"  ,> ,>     á(Bû   ,^  /  Q$         'Z  Ý,   ,> ,>         ,^  /  Q$     B+    +    +    Z   B XB   Z"   XB   Z  øB §XB   ,< (" £XB   (Bû,   XB     ¨B )  ©  *Z  z,<  ,< ª,< +& «Z  ¥,<  ,< ª,< +& «Z   ,~         36 FQ2@ßQ<	é @!L)  B DÀ R ,<s@            (VARIABLE-VALUE-CELL BOUNDPDUMMY . 39)
(VARIABLE-VALUE-CELL EMACS.FILENAME . 53)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 73)
(VARIABLE-VALUE-CELL emacsTempFile . 262)
(VARIABLE-VALUE-CELL MAX.EMACS.INPUT . 77)
(VARIABLE-VALUE-CELL EMACS.INTERMACS.FILE . 97)
(VARIABLE-VALUE-CELL EMACS.EXE.FILE . 102)
(VARIABLE-VALUE-CELL LASTEMACS . 226)
(VARIABLE-VALUE-CELL emacsBufferBlock . 206)
(VARIABLE-VALUE-CELL emacsBlockSize . 203)
(VARIABLE-VALUE-CELL ourBlockStart . 217)
(VARIABLE-VALUE-CELL emacsVars . 140)
(VARIABLE-VALUE-CELL LASTEMACS:FORK . 210)
(VARIABLE-VALUE-CELL emacsRestart . 230)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 239)
(VARIABLE-VALUE-CELL emacsMapFile . 257)
(VARIABLE-VALUE-CELL emacsMapFileEof . 243)
(VARIABLE-VALUE-CELL emacsMapFileJfn . 246)
(VARIABLE-VALUE-CELL emacsMapBlock . 249)
(VARIABLE-VALUE-CELL emacsMapBlockPage . 252)
(NIL VARIABLE-VALUE-CELL temp . 0)
(NIL VARIABLE-VALUE-CELL name . 108)
((MAP TEMP DRIBBLE) . 0)
(VARIABLE-VALUE-CELL x . 56)
EMACS.
.FILE
PACK*
DIRECTORY
DIRECTORYNAME
NAME
EMACS.FILENAME
NOBIND
STKSCAN
RELSTK
EMACS
EXTENSION
PACKFILENAME
FlushEmacs
EDITL
BEFORE
((PROGN (COND ((NULL COMS) (RETURN (RPLACA L (EMACS (CAR L) ATM)))) ((EQ
 (CAR COMS) T) (SETQ COMS NIL)))) . 0)
ADVISE
EDITFBLOCK
RELINK
ScratchFile
SETFILEPTR
SIXBIT
MKATOM
LISP
"EMACS M(M.MLoad Lib)"
"FSEXIT"
CONCAT
WriteRscan
CallEmacs
2
ReadAc
GETBLK
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL var . 150)
(0 VARIABLE-VALUE-CELL i . 179)
EMACS.LOC
PUTPROP
SetEmacsVars
OPNJFN
1
TerminalType
EmacsTerminalSetup
SetupEmacsDribble
SetupBreakMacros
CLOSEALL
NO
WHENCLOSE
(ASZ IUNBOX MKN SET BHC KT KNIL KNOB SKLA SKNLST ENTER0)  z p Ä 0   ( _   ®    þ   W ` ª        õ x ë H à 
h U 
8 Á            `             J  P      

WriteRscan BINARY
              -.          Z   ,   ,>  ,>     Z   ,   "  b  `  `  >   +    "   b  ,^  /     +     "      +        ,~         (VARIABLE-VALUE-CELL string . 8)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 3)
(KNIL BHC UPATM ENTERF)             0      
(PRETTYCOMPRINT EMACSCOMS)
(RPAQQ EMACSCOMS ((FNS * EMACSFNS) (BLOCKS * EMACSBLOCKS) (RECORDS 
PROCESS) (VARS * EMACSVARS) (PROP MACRO Left Right) (LISPXMACROS LEDIT) 
(P (RPAQ emacsReadTable (COPYREADTABLE FILERDTBL)) (SETSYNTAX 3 (QUOTE (
MACRO IMMEDIATE (LAMBDA (FL RDTBL) (ERROR "End of EMACS buffer!")))) 
emacsReadTable)) (ADDVARS (BEFORESYSOUTFORMS (FlushEmacs))) (P (/NCONC 
AFTERSYSOUTFORMS (QUOTE ((EmacsTerminalSetup) (StartEmacs))))) (DECLARE:
 EVAL@COMPILE DONTCOPY (FILES (SYSLOAD FROM LISPUSERS) CJSYS)) (P (
StartEmacs))))
(RPAQQ EMACSFNS (BinaryMode BytePointer CallEmacs ClearScreen Down 
DumpLines EnterEmacs EMACS EmacsPP EmacsSubsys EmacsTerminalSetup 
Enable^CCapability EmacsReturn FixBreakMacros FlushEmacs LEDIT Left 
MapBytes MapProcessToFile OtherWindow PageOfByte ReadAc ReadEditResult 
Right SFCOC STIW ScratchBuffer ScratchFile SetEmacsVars SetupBreakMacros
 SetupEmacsDribble Stack StartEmacs WriteRscan))
(RPAQQ EMACSBLOCKS ((EMACSBLOCK BinaryMode BytePointer CallEmacs 
ClearScreen Down DumpLines EnterEmacs EMACS EmacsPP EmacsReturn 
EmacsSubsys EmacsTerminalSetup Enable^CCapability FlushEmacs Left 
MapBytes MapProcessToFile OtherWindow PageOfByte ReadAc ReadEditResult 
Right SFCOC STIW ScratchBuffer ScratchFile SetEmacsVars 
SetupEmacsDribble StartEmacs WriteRscan (ENTRIES StartEmacs FlushEmacs 
EMACS STIW SFCOC Down EmacsReturn EmacsPP EmacsTerminalSetup DumpLines 
EnterEmacs) (NOLINKFNS . T))))
(RECORD PROCESS (FORK COC TIW))
(RPAQQ EMACSVARS ((SUBSYSRESCANFLG T) (MAX.EMACS.INPUT 896000) (
LASTEMACS NIL) (EMACS.EXE.FILE (QUOTE SYS:EMACS.EXE)) (
EMACS.INTERMACS.FILE (QUOTE <LISPUSERS>INTERMACS)) (emacsVars (QUOTE (
emacsBeg emacsBegv emacsPt emacsGpt emacsZv emacsZ emacsExtrac 
emacsRestart emacsArg emacsModiff)))))
(RPAQQ SUBSYSRESCANFLG T)
(RPAQQ MAX.EMACS.INPUT 896000)
(RPAQQ LASTEMACS NIL)
(RPAQQ EMACS.EXE.FILE SYS:EMACS.EXE)
(RPAQQ EMACS.INTERMACS.FILE <LISPUSERS>INTERMACS)
(RPAQQ emacsVars (emacsBeg emacsBegv emacsPt emacsGpt emacsZv emacsZ 
emacsExtrac emacsRestart emacsArg emacsModiff))
(PUTPROPS Left MACRO (X (LIST (QUOTE LOGAND) (LIST (QUOTE LLSH) (CAR X) 
-18) 262143)))
(PUTPROPS Right MACRO (X (LIST (QUOTE LOGAND) (CAR X) 262143)))
(ADDTOVAR LISPXMACROS (LEDIT (LEDIT)))
(RPAQ emacsReadTable (COPYREADTABLE FILERDTBL))
(SETSYNTAX 3 (QUOTE (MACRO IMMEDIATE (LAMBDA (FL RDTBL) (ERROR 
"End of EMACS buffer!")))) emacsReadTable)
(ADDTOVAR BEFORESYSOUTFORMS (FlushEmacs))
(/NCONC AFTERSYSOUTFORMS (QUOTE ((EmacsTerminalSetup) (StartEmacs))))
(StartEmacs)
NIL
 