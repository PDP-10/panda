(FILECREATED "13-AUG-83 11:50:30" ("compiled on " <LISPUSERS>PUP10.;11) 
(2 . 2) recompiled exprs: nothing in READSYS.SAV dated 
"13-AUG-83 09:08:48")
(FILECREATED "13-AUG-83 11:50:01" <LISPUSERS>PUP10.;11 26270 changes to:
 (VARS PUP10COMS) previous date: "13-JUN-83 00:43:17" 
<LISPUSERS>PUP10.;10)
DISCARDPUPS BINARY
               -.           @    ,~   Z   B  XB   2B   +   +    ` ,>  ,>  Z  B  ^"  .Bx  ,^  /  ,   XB` +   Z` ,~     M (VARIABLE-VALUE-CELL SOC . 6)
(VARIABLE-VALUE-CELL DUMMY . 0)
(NIL VARIABLE-VALUE-CELL PUP . 15)
0
GETPUP
RELEASE.PUP
(MKN BHC KNIL ENTERF) 8   0    X      
ETHERPORT BINARY
    K    >    È-.          >@  @  ,~   Z   -,   +   -,   +   Z  -,   +   [  -,   +   Z   3B   +   Z  ,   ,~   Z  
,~   Z  Z   ,   2B   +   ´Z  ,<  ,<  Á,<  B$  ÂXB   Z  ,<  ,<  C"  ÃD  D,      Z  .$  Q$   7       3B   +   3@  Ä   +   3Z  ,<  Z   D  ÆXB   0B   +   +   2   A"  ÿ,>  ½,>     (B{GBx  ,^  /  ,   ,<  Z  ,<     ."  ,   D  Æ,   XB` Z` 3B   +   ­,<  Z` ,   XB` ,\  QB  +   ¯Z` ,   XB` XB`    ¥."  ,   XB  ¯+   Z` ,~   ,<  Z  F  GXB  ¤3B   +   ¹Z  3B   +   ¸Z  ´,~   Z  ·,~   Z   3B   +   ¼,<  ÇZ  D  HZ   ,~     ) ' hL@        (VARIABLE-VALUE-CELL NAME . 119)
(VARIABLE-VALUE-CELL ERRORFLG . 115)
(VARIABLE-VALUE-CELL MULTFLG . 108)
(VARIABLE-VALUE-CELL \ETHERPORTS . 103)
(NIL VARIABLE-VALUE-CELL HOST . 66)
(NIL VARIABLE-VALUE-CELL SOCK . 0)
(NIL VARIABLE-VALUE-CELL LST . 113)
40
FIXP
ARRAY
0
CHARACTER
CONCAT
NIL
NIL
NIL
(1 VARIABLE-VALUE-CELL I . 98)
ELT
PUTHASH
"host not found"
ERROR
(CONSS1 MKN BHC ASZ KT UPATM GETHSH CONSNL KNIL SKI SKLST SKNI ENTERF)     § H   @   h      X   h   p , 8   X ; x 6                          
\LOCALHOSTNUMBER BINARY
            -.           Z   B  Z  ,~       (VARIABLE-VALUE-CELL HOSTNAME . 3)
ETHERPORT
(ENTER0)    
\LOCALPUPNETNUMBER BINARY
             -.               ,   (B|,   ,~       \LOCALHOSTNUMBER
(MKN IUNBOX ENTER0)             
SETUPPUP BINARY
       3    -    ±-.     0     -Z   2B   +      °XB  Z  ,<  ^"     ,\  d  *Z  ,<         ,\  d  ªZ  ,<  Z   2B   +       1"  +   Z"  +      ."  ,   XB  ,   +   ,      ,\  d  +Z  
,<  Z   ,<  ,<   $  1XB  -,   +   Z  ,   +   ,      ,\  d  «Z  -,   +    [  1B   +    [  +    Z   ,<  Z  ,<   wÿ(Bx   ,\  d  ,Z  !,<   wÿA"ÿ   ,\  d  ¬Zp  /  Z   ,~   (@     	  (@ @ (@ 	 "% @@   (VARIABLE-VALUE-CELL PUP . 73)
(VARIABLE-VALUE-CELL DESTHOST . 62)
(VARIABLE-VALUE-CELL DESTSOCKET . 64)
(VARIABLE-VALUE-CELL TYPE . 16)
(VARIABLE-VALUE-CELL ID . 22)
(VARIABLE-VALUE-CELL SOC . 82)
(VARIABLE-VALUE-CELL \PUPCOUNTER . 33)
\CREATE.PUP
ETHERPORT
(BHC SKLST SKNI KT IUNBOX MKN ASZ KNIL ENTERF)     X      p   0  0          p   H        
\FILLPUPSOURCE BINARY
              -.           Z   ,~       (VARIABLE-VALUE-CELL PUP . 0)
(VARIABLE-VALUE-CELL SOCKET . 0)
(KNIL ENTERF)    (      
EXCHANGEPUPS BINARY
      ¯    &    .-.     0     &Z   2B   +   Z   XB  Z   2B   +   Z   XB  Z   B  *Z  ,<  Z   D  ªZ  B  +@  «  ,~   Z  B  -XB   3B   +   Z   3B   +   Z  "  %,>  ¥,>  Z  "  %   ,^  /  2B  +   Z  ,~   Z  B  ­+   £    ,>  ¥,>     .Bx  ,^  /  ."  ,   XB  ,   ,>  ¥,>        ,^  /  3b  +   ¢Z   ,~   Z  B  ++   Z` ,~   	    EDK!      (VARIABLE-VALUE-CELL SOC . 24)
(VARIABLE-VALUE-CELL OUTPUP . 36)
(VARIABLE-VALUE-CELL DUMMY . 0)
(VARIABLE-VALUE-CELL IDFILTER . 29)
(VARIABLE-VALUE-CELL TIMEOUT . 61)
(VARIABLE-VALUE-CELL WAITTIME . 69)
(VARIABLE-VALUE-CELL \ETHERWAIT2 . 6)
(VARIABLE-VALUE-CELL \ETHERWAIT1 . 11)
DISCARDPUPS
SENDPUP
DISMISS
NIL
(0 VARIABLE-VALUE-CELL WAITED . 57)
(NIL VARIABLE-VALUE-CELL INPUP . 45)
GETPUP
RELEASE.PUP
(IUNBOX MKN BHC KNIL ENTERF)  `   P     P   (  h   0      
GETPUP BINARY
       1    '    ¯-.          '   ¨,<  @  )  ,~   Z   2B   +      *B  ª,   ,>  &,>  Z   2B   +      ¦+   ^"      ,^  /  Q"  Z   Q$  C  7       XB   Z   3B   +   2B  ++   Z  3B   +   ,<  «,<   $  ,Z  2B  ++   Z  B  ¬+   ¡Z  B  -+   ¡,<  ­,<   $  ,+   ¡2B  .+   ¡Z  3B   +   Z  ®+    Z  ­,<  ,<   $  ,Z  3B   +   $Z  ,~   Z  #B  /Z   ,~         G M6wO     (VARIABLE-VALUE-CELL SOC . 8)
(VARIABLE-VALUE-CELL WAIT . 16)
(VARIABLE-VALUE-CELL PUPTRACEFLG . 43)
ALLOCATE.PUP
(VARIABLE-VALUE-CELL PUP . 72)
(NIL VARIABLE-VALUE-CELL RESULT . 67)
\GETMISCSOCKET
OPNJFN
LEAF
"\GETPUP:
"
PRIN1
PRINTLEAF
PRINTPUP
-
PEEK
+
RELEASE.PUP
(KT BHC IUNBOX KNIL ENTERF)     X      P    x   ` # h  x   X      
SENDPUP BINARY
      ­    $    ,-.          $Z   2B   +   ,<  ¥"  &Z  ,<  ^"      ,\  d  ¢Z  ,<  ^"      ,\  d  #Z  @  ¦,      ,\  d  £Z   2B   +      'XB  Z  B  §,   Q"  Z  
Q$  C  7       2B   +      (B  &Z   3B   +   2B  ¨+   ,<  ),<   $  ©Z  2B  ¨+   Z  B  *,~   Z  B  ª,~   2B  ++   ¡,<  «,<   $  ©,~   Z   ,~   (@ @ @ ADdO-      (VARIABLE-VALUE-CELL SOC . 31)
(VARIABLE-VALUE-CELL PUP . 58)
(VARIABLE-VALUE-CELL PUPTRACEFLG . 52)
"Pup not supplied to \SENDPUP"
ERROR
ETHERHOSTNUMBER
\GETMISCSOCKET
OPNJFN
ERSTR
LEAF
"\SENDPUP:
"
PRIN1
PRINTLEAF
PRINTPUP
PEEK
!
(KT IUNBOX KNIL ENTERF)  !    H        ¢ P  h        
CLEARPUP BINARY
               -.           Z   Q"º@@  *b  ,~       (VARIABLE-VALUE-CELL PUP . 3)
(ENTERF)     
GETPUPWORD BINARY
                -.           Z   ,>  ,>      (Bÿ."  .Bx  ,^  /  ,<  @     ,~      A"  0B   +   Z   "  ,   ,~   Z  
"  ,   ,~     (@  @  D (VARIABLE-VALUE-CELL PUP . 3)
(VARIABLE-VALUE-CELL WORD# . 16)
(VARIABLE-VALUE-CELL BASE . 24)
(MKN BHC ENTERF)  `            
PUTPUPWORD BINARY
             -.           Z   ,>  ,>      (Bÿ."  .Bx  ,^  /  ,<  @     ,~      A"  0B   +   Z   ,<         ,\  d     ,   ,~   Z  
,<        ,\  d     ,   ,~     (@  @       (VARIABLE-VALUE-CELL PUP . 3)
(VARIABLE-VALUE-CELL WORD# . 16)
(VARIABLE-VALUE-CELL VALUE . 31)
(VARIABLE-VALUE-CELL BASE . 29)
(MKN BHC ENTERF)   0            
GETPUPBYTE BINARY
             -.           Z   ,>  ,>      (B."  .Bx  ,^  /  ,<  @     ,~      A"  ,   0B   +   Z   "  ,   ,~   0B  +   Z  "  ,   ,~   0B  +   Z  "  ,   ,~   0B  +   Z  "  ,   ,~      ,~     8   (         "E@   (VARIABLE-VALUE-CELL PUP . 3)
(VARIABLE-VALUE-CELL BYTE# . 16)
(VARIABLE-VALUE-CELL BASE . 39)
SHOULDNT
(ASZ MKN BHC ENTERF)   8  X      (  H 
           
PUTPUPBYTE BINARY
     '    #    ¥-.           #Z   ,>   ,>      (B."  .Bx  ,^  /  ,<  @  ¤   ,~      A"  ,   0B   +   Z   ,<         ,\  d  !   ,   ,~   0B  +   Z  ,<        ,\  d  ¡   ,   ,~   0B  +   Z  ,<        ,\  d  "   ,   ,~   0B  +   Z  ,<        ,\  d  ¢   ,   ,~      %,~     8   (         !      (VARIABLE-VALUE-CELL PUP . 3)
(VARIABLE-VALUE-CELL BYTE# . 16)
(VARIABLE-VALUE-CELL VALUE . 56)
(VARIABLE-VALUE-CELL BASE . 54)
SHOULDNT
(ASZ MKN BHC ENTERF)   X  (   x  H       h      
GETPUPSTRING BINARY
              -.           Z   ."  ,<  Z   2B   +   Z"   XB  ,<  Z  "  /"  ,>  ,>        ,^  /  /  ,   F  ,~   (@    !  (VARIABLE-VALUE-CELL PUP . 12)
(VARIABLE-VALUE-CELL OFFSET . 17)
\GETSTRING
(MKN BHC ASZ KNIL ENTERF)  @   0    X    H      
PUTPUPSTRING BINARY
              -.           Z   ,<  Z  "  ,>  ,>  Z  ."  ,<  Z  "  /"  ,   ,<  Z   F  ,   .Bx  ,^  /     ,\  d     ,   ,~   (@    A (VARIABLE-VALUE-CELL PUP . 12)
(VARIABLE-VALUE-CELL STR . 17)
\PUTSTRING
(BHC IUNBOX MKN ENTERF)  @   (   h        
\GETSTRING BINARY
     ­    ©    ,-.           ©Z   ,>  ',>      &"  .Bx  ,^  /  XB     &"     ,   XB  ,   Z   ,<  ,<   ,<  + p  ,>  ',>   w   ,^  /  3b  +   +   %Z  0B   +   Z  "  §+   0B  +   Z  "  (+   0B  +   Z  "  ¨+   0B  +   Z  "  )+      «,   /"   ,   Z  0B  +    Z  ."  XB  Z"   +   "   ."  ,   XB    p  ."  ,   XBp  +       ,   /  ,~     8   (           Pk-8@     (VARIABLE-VALUE-CELL BASE . 62)
(VARIABLE-VALUE-CELL OFFSET . 68)
(VARIABLE-VALUE-CELL LENGTH . 18)
1
SHOULDNT
(MKSP UNP1 MKSTR1 IUNBOX ASZ KNIL MKSTRS MKN BHC ENTERF)  ¦    &              `    @             ¤ (     ' p        
\PUTSTRING BINARY
     ´    /    3-.          /Z   ,>  ¬,>      &"  .Bx  ,^  /  XB     &"     ,   XB  Z   ,<  Z   D  1,<  Zp  -,   +   +   ªZp  ,<  @  ±   +   )Z  0B   +   Z  ,<         ,\  d  -+   ¢0B  +   Z  ,<        ,\  d  ­+   ¢0B  +   Z  ,<        ,\  d  .+   ¢0B  +   "Z  ,<        ,\  d  ®+   ¢   2Z  0B  +   ¦Z  ."  XB  $Z"   +   (   ¢."  ,   XB  ¦,~   [p  XBp  +   /  Z  B  ²,~     8   (          R h   (VARIABLE-VALUE-CELL BASE . 74)
(VARIABLE-VALUE-CELL OFFSET . 80)
(VARIABLE-VALUE-CELL STR . 86)
(VARIABLE-VALUE-CELL CHCONLST1 . 19)
DCHCON
(VARIABLE-VALUE-CELL CHAR . 63)
SHOULDNT
NCHARS
(ASZ SKNLST MKN BHC ENTERF)  h $ h  X         ¨    8        
OCTALSTRING BINARY
            -.           Z   ,<  @    ,~   Z   ,<  Z   ,<      A"  ,   F     (Bþ,   XB  1B   +   >  +   Z  0Bÿ+   Z  ,~   Z  ,<  ,<  ,<  ,<  (  B  ,~     R     (VARIABLE-VALUE-CELL N . 27)
(VARIABLE-VALUE-CELL M . 19)
(-1 VARIABLE-VALUE-CELL J . 24)
("000000000000" VARIABLE-VALUE-CELL S . 29)
RPLSTRING
-1
""
SUBSTRING
CONCAT
(ASZ MKN ENTERF)   0            
CREATESOCKET BINARY
                -.          Z   3B   +   ,<  B  ,<  ,<  $  D  +   Z  ,<  ,<  ,<   ,<  ,<  *  ,<  @     ,~   Z   ,<  ,<  ,<  &  Z  Z   ,   XB  Z  ,~   _.C@     (VARIABLE-VALUE-CELL LOCALSOCKET# . 3)
(VARIABLE-VALUE-CELL \PUPSOCKETS . 32)
PUP:
OCTAL
"!A"
CONCAT
PACK*
PUP:!J
BOTH
8
(((MODE 14)) . 0)
OPENFILE
(VARIABLE-VALUE-CELL PACKETFILE . 33)
CLOSEALL
NO
WHENCLOSE
(CONS KNIL ENTERF)      	  0      
FLUSHSOCKET BINARY
               -.          Z   2B   +   ,<   Z   2B   +   Zp  +    Z  B  [  XB  +   ,<  Z  D  3B   +   Z  ,<  Z  	D  XB  Z  B  ,~   Z  ,<  ,<  $  ,~   DF     (VARIABLE-VALUE-CELL SOC . 30)
(VARIABLE-VALUE-CELL \PUPSOCKETS . 26)
CLOSEF
MEMB
DREMOVE
"not an open socket"
ERROR
(URET1 KNIL KT ENTERF)         P            
\GETMISCSOCKET BINARY
      
        -.           Z   3B   +   Z  Z   ,   3B   +   Z  ,~      	XB  ,~   	   (VARIABLE-VALUE-CELL \MISC.SOCKET . 14)
(VARIABLE-VALUE-CELL \PUPSOCKETS . 7)
CREATESOCKET
(FMEMB KNIL ENTER0)    P    X        
ALLOCATE.PUP BINARY
                -.           Z   ,<  [  XB  ,\  2B   +      ,~      (VARIABLE-VALUE-CELL \FREEPUPS . 6)
\CREATE.PUP
(KNIL ENTER0)    P      
\CREATE.PUP BINARY
               -.           ,<  ,<  $  ."  ,~       (VARIABLE-VALUE-CELL DUMMY . 0)
139
ARRAY
(ENTERF)      
RELEASE.PUP BINARY
               -.          Z   3B   +   Z   ,   XB  Z   ,~       (VARIABLE-VALUE-CELL PUP . 3)
(VARIABLE-VALUE-CELL \FREEPUPS . 8)
(CONS KNIL ENTERF)         0      
PUPTRACE BINARY
             -.         Z   ,<  @    ,~       ,>  ,>   `    ,^  /  3b  +   Z` ,~      .wZ  2B   +   Z   B  +      .wZ  ,<  Z  D     ."  ,   XB  +          (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL PUPTRACEFILE . 31)
(0 . 1)
NIL
(1 VARIABLE-VALUE-CELL I . 36)
TERPRI
PRIN1
(MKN KT BHC ENTERF) (   @          
PRINTPUP BINARY
     Ü    Ñ    Z-.           Ñ@  R  ,~   ,<  Ò,<   $  SZ   "  L,   XB   ,   (B|,   ,<  ,<   $  S,<  Ó,<   $  S   A"  ÿ,   ,<  ,<   $  S,<  T,<   $  SZ  "  Ì(B  ,>  M,>  Z  "  ÍGBx  ,^  /  ,   ,<  ,<   $  S,<  Ô,<   $  SZ  "  N,   XB  ,   (B|,   ,<  ,<   $  S,<  U,<   $  S   A"  ÿ,   ,<  ,<   $  S,<  Õ,<   $  SZ  "  Î(B  ,>  M,>  Z  #"  OGBx  ,^  /  ,   ,<  ,<   $  S,<   "  V,<  Ö,<   $  SZ  ¥"  Ï,   ,<  ,<   $  S,<  W,<   $  S,<  ×,<   $  SZ  ¬"  Ï/"  ,   ,<  ,<   $  S,<  X,<   $  S,<   "  V,<  Ø,<   $  SZ  ²"  P,   ,<  ,<   $  S,<  Y,<   $  SZ  :"  Ð,   ,<  ,<   $  S,<   "  VZ  ¾"  Q1B   +   J,<  Ù,<   $  SZ  Â"  Q,   ,<  ,<   $  S,<   "  V,<   "  VZ   ,~   @ (@   @ (@ @ (@ (@     	     (AU 5 h$T6ÐVQT*j*    (VARIABLE-VALUE-CELL PUP . 140)
(NIL VARIABLE-VALUE-CELL PORT . 61)
"From "
PRIN1
"#"
"#"
" to "
"#"
"#"
TERPRI
"Length = "
" bytes"
" (header + "
")"
"Type = "
",   ID = "
"Transport control = "
(KNIL BHC IUNBOX MKN KT ENTERF)  	@          x   	  À @ 5 h )      P   h   	0 J 	 F ( Á h =   ¸ x 6 ( 1 x ¬ 0 * 0 ¡ h     x  0   H      
ETHERHOSTNAME BINARY
     k    Z    h-.          ZZ   -,   +      0"  +   
   Û,   A" ,>  ×,>     GBx  ,^  /  ,   +   Z  +   2B   +      Û+   -,   Z   Z  2B   +   ,<  \Z  
D  Ü@  ]@  Ý,<  @  ^ `,~   Z   ,<  ,<  a,<  á,<  b,<   Z   L  âZ  ,<  Z  "  X."     ,\  d  XZ  ."  XB   ,<         ,\  d  XZ  -,   Z   [  2B   +   £Z"   ,<  Z  ,<   wÿ(Bx   ,\  d  ØZ  $,<   wÿA"ÿ   ,\  d  YZp  /  Z   ,<  ,<   ,<   Z"  XBp   p  ,>  ×,>   w   ,^  /  3b  +   4+   ÎZ  ,<  Z  ,<  ,<   ,<   (  cXB   2B   +   ¹+   LZ  ·"  Ù,   0B  J+   ¾Z  ¹B  ãB  dXB   +   T0B  I+   KZ   3B   +   T3B  ä+   T,<  e,<   $  åZ   ,<  ,<   $  å,<  f,<   $  åZ  <B  ã,<  ,<   $  å,<   "  æ+   TZ  GB  g p  ."  ,   XBp  +   /Z  ¿3B   +   Ó3B  ä+   Ó,<  ç,<   $  å,<   "  æZwÿ/  Z  KB  gZ  5B  gZ  ½,~     (@  @  (@    2\!d" %TzB="@     (VARIABLE-VALUE-CELL PORT . 135)
(VARIABLE-VALUE-CELL \MAXETHERTRIES . 88)
(VARIABLE-VALUE-CELL PUPTRACEFLG . 157)
\LOCALHOSTNUMBER
"ILLEGAL ARG"
LISPERROR
ALLOCATE.PUP
\GETMISCSOCKET
(VARIABLE-VALUE-CELL NETHOST . 60)
(VARIABLE-VALUE-CELL OPUP . 171)
(VARIABLE-VALUE-CELL SOC . 104)
(NIL VARIABLE-VALUE-CELL IPUP . 169)
(NIL VARIABLE-VALUE-CELL RESULT . 173)
(NIL VARIABLE-VALUE-CELL BUF . 79)
0
4
147
SETUPPUP
EXCHANGEPUPS
GETPUPSTRING
MKATOM
%.
"Address lookup error for "
PRIN1
": "
TERPRI
RELEASE.PUP
"Address lookup timed out"
(KT ASZ SKLST KNIL MKN BHC IUNBOX SKI ENTERF)   Ó 
( Ê 	 G X Ã x   x < p $    ¡ `   
  A  7 h . 0 " x  h     N 8 
    U 0 ¬     `    0      
ETHERHOSTNUMBER BINARY
                -.           Z   2B   +      ,~   B  Z  ,~       (VARIABLE-VALUE-CELL NAME . 3)
\LOCALHOSTNUMBER
ETHERPORT
(KNIL ENTERF)   0      
\LOOKUPPORT BINARY
       Ù    J    W-.          J   Ë@  L,<  @  Ì @
,~   Z   ,<  ,<  O,<  Ï,<  P,<   Z   L  ÐZ  ,<  Z   D  QZ   ,<  ,<   ,<   Z"  XBp   p  ,>  Ç,>   w   ,^  /  3b  +   +   ¾Z  ,<  Z  ,<  ,<   ,<   (  ÑXB   2B   +   +   <Z  "  H,   0B  È+   .Z  "  È/"  1b  +   $Z   3B   +   $3B  R+   $,<  Ò,<   $  SZ  ,<  ,<   $  S,<   "  ÓZ  ."  XB   "  È,   ,<  Z  %"  I(B  ,>  Ç,>  Z  '"  ÉGBx  ,^  /  ,   ,   XB   +   D0B  I+   ºZ  3B   +   D3B  R+   D,<  T,<   $  SZ  !,<  ,<   $  S,<  Ô,<   $  SZ  $B  U,<  ,<   $  S,<   "  Ó+   D   ÕZ  ¶B  V p  ."  ,   XBp  +   Z  /3B   +   Ã3B  R+   Ã,<  Ö,<   $  S,<   "  ÓZwÿ/  Z  ;B  VZ  B  VZ  -,~        (@  @  (@  À@MO¢RO#Rtj     (VARIABLE-VALUE-CELL NAME . 102)
(VARIABLE-VALUE-CELL \MAXETHERTRIES . 21)
(VARIABLE-VALUE-CELL PUPTRACEFLG . 125)
ALLOCATE.PUP
\GETMISCSOCKET
(VARIABLE-VALUE-CELL OPUP . 139)
(VARIABLE-VALUE-CELL SOC . 37)
(NIL VARIABLE-VALUE-CELL IPUP . 137)
(NIL VARIABLE-VALUE-CELL RESULT . 141)
(NIL VARIABLE-VALUE-CELL BUF . 83)
0
4
144
SETUPPUP
PUTPUPSTRING
EXCHANGEPUPS
%.
"Multiple response received for "
PRIN1
TERPRI
"Name lookup error for "
": "
GETPUPSTRING
HELP
RELEASE.PUP
"Name lookup timed out"
(CONSS1 MKN KT BHC ASZ KNIL ENTERF)   ­    > P '     8 Â   9 h 5 0 $ 0 ! `   P ¬    p  X     ° h  X  H        
(PRETTYCOMPRINT PUP10COMS)
(RPAQQ PUP10COMS ((E (RESETSAVE (RADIX 8))) (FNS DISCARDPUPS ETHERPORT 
\LOCALHOSTNUMBER \LOCALPUPNETNUMBER SETUPPUP \FILLPUPSOURCE EXCHANGEPUPS
 GETPUP SENDPUP) (COMS (* Accessing a PUP's contents) (FNS CLEARPUP 
GETPUPWORD PUTPUPWORD GETPUPBYTE PUTPUPBYTE GETPUPSTRING PUTPUPSTRING 
\GETSTRING \PUTSTRING OCTALSTRING)) (P (MOVD (QUOTE CREATESOCKET) (QUOTE
 OPENPUPSOCKET)) (MOVD (QUOTE EXCHANGEPUPS) (QUOTE \EXCHANGEPUPS)) (MOVD
 (QUOTE NILL) (QUOTE \SETLOCALHOST?))) (COMS (* Sockets) (FNS 
CREATESOCKET FLUSHSOCKET \GETMISCSOCKET)) (COMS (* PUP allocation) (FNS 
ALLOCATE.PUP \CREATE.PUP RELEASE.PUP) (GLOBALVARS \FREEPUPS) (VARS (
\FREEPUPS)) (DECLARE: DONTCOPY (MACROS BINDPUPS) (PROP INFO BINDPUPS) (
ALISTS (PRETTYPRINTMACROS BINDPUPS)))) (GLOBALVARS \MISC.SOCKET 
\PUPSOCKETS \ETHERPORTS \LOCALHOST \PUPCOUNTER) (DECLARE: DONTCOPY (
RECORDS PUP10 8BITBYTES PUPADDRESS)) (GLOBALVARS \ETHERWAIT1 \ETHERWAIT2
 \MAXETHERTRIES PUPTRACEFLG) (FNS PUPTRACE) (DECLARE: DONTCOPY (
CONSTANTS (\PUPOVLEN 22) (\MAX.PUPLENGTH 532) (\TIME.GETPUP 5)) (
CONSTANTS * PUPCONSTANTS) (RECORDS PORT SOCKET) (MACROS PUPTRACING 
PUPDEBUGGING)) (VARS (PUPTRACEFILE T) (PUPTRACEFLG (QUOTE %.)) (
\ETHERPORTS (LIST (HARRAY 20))) (\PUPSOCKETS) (\MISC.SOCKET) (\LOCALHOST
) (\ETHERWAIT1 15) (\ETHERWAIT2 2000) (\MAXETHERTRIES 4) (\PUPCOUNTER 0)
) (ADDVARS (AFTERSYSOUTFORMS (CLRHASH \ETHERPORTS) (SETQ \PUPSOCKETS (
SETQ \LOCALHOST)))) (FNS PRINTPUP) (COMS (* Raw network facilities) (FNS
 ETHERHOSTNAME ETHERHOSTNUMBER \LOOKUPPORT)) (DECLARE: EVAL@COMPILE 
DONTCOPY (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) CJSYS)) (
DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (
NLAMA) (NLAML) (LAMA PUPTRACE)))))
(MOVD (QUOTE CREATESOCKET) (QUOTE OPENPUPSOCKET))
(MOVD (QUOTE EXCHANGEPUPS) (QUOTE \EXCHANGEPUPS))
(MOVD (QUOTE NILL) (QUOTE \SETLOCALHOST?))
(RPAQQ \FREEPUPS NIL)
(RPAQQ PUPTRACEFILE T)
(RPAQQ PUPTRACEFLG %.)
(RPAQ \ETHERPORTS (LIST (HARRAY 20)))
(RPAQQ \PUPSOCKETS NIL)
(RPAQQ \MISC.SOCKET NIL)
(RPAQQ \LOCALHOST NIL)
(RPAQQ \ETHERWAIT1 15)
(RPAQQ \ETHERWAIT2 2000)
(RPAQQ \MAXETHERTRIES 4)
(RPAQQ \PUPCOUNTER 0)
(ADDTOVAR AFTERSYSOUTFORMS (CLRHASH \ETHERPORTS) (SETQ \PUPSOCKETS (SETQ
 \LOCALHOST)))
(PUTPROPS PUP10 COPYRIGHT ("Xerox Corporation" 1983))
NIL
   