(FILECREATED "26-Aug-84 01:07:06" ("compiled on " <LISPUSERS>PUPFTP..11) (2 . 2) brecompiled changes: PUPFTP in 
"INTERLISP-10  24-Aug-84 ..." dated "24-Aug-84 01:43:38")
(FILECREATED "26-Aug-84 01:06:47" <LISPUSERS>PUPFTP..11 22682 changes to: (FNS PUPFTP) previous date: "25-JUL-84 00:44:50" 
<LISPUSERS>PUPFTP..10)
MTPA0007 BINARY
     �        
-.          Z   3B   +   �,<` "  �B  	,<` �"  �,<` "  �,~   j   (IN . 1)
(OUT . 1)
(VARIABLE-VALUE-CELL RESETSTATE . 3)
OPNJFN
SENDPUPABORT
CLOSEF?
(KNIL ENTER2)    0      
MTP BINARY
    
   R   �-.     (     R-.     (�   WZ   ,<  �@ W  �+  ?Z   ,<  �,< �,< Y,<   @ � ` +  8Z   Z [XB ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,< �Z   XB   Zw�Z?2B   +    Z?~Z   ,   Z  2B   +   �Z   Z  �,   Z  2B   +   �Zw�,<?~ \Zw�XB?3B   +    [?b ]Zw�XB?�Z?Zw�XB?,<   ,<?~,< ^,< � _XBw�b `XBw| w|   �+       �,   ,<  �Zwz,<?~,< ^,< a _XBw}b `XBw�Z �,<  �,<w�,<w�,   XBw~,<  �,<   ,   Z  �,   XB  �,< bZwzZ?XBw�,   ,<  �,< �Zw�Z?�2B   +   7Z c,   ,<  �,< �ZwyZ8  2B   +   ;Z?,   ,   XBw� w|,> Q,>  �Z"  �,<  �,< d �,      �,^  �/  �  �   �,<w�,<w� �Z   3B   +   �,<w�b `d � w|,> Q,>  �Z"  ,<  �,< d �,      �,^  �/  �  �   �Zw�Z?�3B   +   �,<  �,< � �Zw�XB?�,< �,< h,< �,<    i,<  �,< j,< � �XBw�,< k,<  �,   ,<  �,<   ,   Z  �,   XB  �,<   ,<w| �0B  �+  � w�."  �,   XBw�,<w� �XBw~Z  �3B   +   �,<w~d �,<w| �0B  �+  �,<w{,< � �,<w|,<w� `,<  �, GZ �Zw~7  �[  Z  Z  1H  +   �2D   +   l[  ,<  �Zw�,<?�, �,< pZw�,<?� �Zw{,   ,   ,<  �Zw�,<?� �,< �Zw�,<?� �Z rZw~7  �[  Z  Z  1H  +   �2D   +   {[  Z  2B �+  �^"  �+  ^"   ,> Q,>  �Z sZw~7  �[  Z  Z  1H  +  2D   +  �[  Z  2B �+  ^"  +  �^"   .Bx  ,^  �/  �,   ,<  �Zw�,<?� �Zwz,<?� �,<w{Zw�,<?�,< �Zw�,   ,   h �+    �+  0B  �+  +  0B  +  �+    �+   �Zp  /  �+  /  �+  /  �+  0 w�      ,   ,<  �,< � wXBw�1B  +  $0B  �+  .,<w� x,<w� yZw�,<?~,<   ,<   ,< z \Zw�XB?[?b ]Zw�XB?�Z?Zw�XB?+   1,<w} �b �b �,<w} �,<w� �Zw�3B   +  4b �Zw�,<?� �/  ZwXB8 Z   ,~   3B   +  :Z   +  �Z �XB` �d  Z` �3B   +  >  ,~   Z` ,~   +    Zw�,<  �,<w� �[w�3B   +    ,< ,<w� �[w�,<  �,<w�, �+    ,> Q,>   w�    Dx  5D �   �`d   5  � p   x     �0D  �5  H $     �5  H,^  /  �+      �    �)U  A  :@d FKF,uh E+ 3M(
4"o*C�LPH$                 (HOST . 1)
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
(URET2 URET5 FGFPTR KT BHC IUNBOX ASZ ALIST3 ALIST2 CONS LIST2 LIST3 MKN GETHSH CF KNIL BLKENT ENTER5)   � 8       H �   8   U   Q h P X � (   	@ A   $ 0 x � h J p   H   @ 8 @   @ 1    [  0    .   � P ` � p         �   C P: �  h � 8 ] ( P ` � h �  �   `    x  h  X  H      (      

PUPFTPA0005 BINARY
     �        
-.          Z   3B   +   �Z   B  �B  	Z   B  �Z  B  �,~   j   (VARIABLE-VALUE-CELL IN . 9)
(VARIABLE-VALUE-CELL OUT . 11)
(VARIABLE-VALUE-CELL RESETSTATE . 3)
OPNJFN
SENDPUPABORT
CLOSEF?
(KNIL ENTERF)   0      

PUPFTP BINARY
    �   7   s-.     8    87Z   ,<  �@ >  ,~   Z   ,<  �,< �,< @,<   @ � ` �+  /Z   Z BXB Z   ,<  �@ �  `+  �Z   XB   Z   3B   +   0B  �+   +   0B  +   �Z IXB   +   ,<  �,< �$ JZ   3B �+   �2B K+   �Z �Z   ,   XB   Z  +   �2B �+   �Z �Z   ,   XB  Z  �+   �2B L+   +   �3B �+   !2B M+   �+   �2B   +   �Z �+   �2B   +   �Z M+   �2B �+   �Z   XB  �Z  �+   �2B N+   �Z  �,<  ,<   Z   ,<   "  ,   XB   2B   +   �Z   ,~   Z   XB  'Z  �+   �-,   +   �[  �XB  Z  �+   �,< �,<  �,   B OXB  �Z   2B   +   �Z   Z   ,   Z  2B   +   �Z   Z  9,   Z  2B   +   �Z  �B �XB  73B   +   �[  �B PXB   Z  AXB  �,<   Z  �,<  ,< �,< M( QXB   B �XB  +   �   �+       �,   ,<  �Z  D,<  �,< �,< �( QXB   B �XB   Z R,<  �Z  �,<  �Z  �,<  ,   XB   ,<  �,<   ,   Z  ,   XB  �   H,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �   V,> 6,>  �,< �,< �$ T,      �,^  �/  �   �   �,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z  �B �0B  +   �   �      ,   ,<  �,< U$ T1B  �+   �  �Z  �B VZ  �B �2B   +   t  �+   t  �,< WZ  CXB   ,   ,<  �,< �Z  B2B   +   yZ X,   ,<  �Z  --,   +   �,< �,<  �,   ,   ,   ,   XB   Z  03B   +  ,< Y,<  �,   ,<  �Z  2B I+  �,< �Z  ,<  ,   Z  �,   +  Z  �3B �+  
Z +  ,< ZZ   ,<  ,   Z 	,   ,   XB Z  33B   +  �,<  �@ �  �+  �Z` �-,   +  �+  �Z  XB   -,   +  +  ,< \Z ,   Z �,   XB �[` �XB` �+  �Z` ,~      b,> 6,>  �Z �3B N+  �2B M+  �Z"  +  *3B �+  �2B �+  �Z"  �+  *3B �+  �2B L+  �Z"  +  *3B �+  �2B K+  �Z"  +  *  �,<  �,< �$ S,      �,^  �/  �  �   �Z �,<  �Z �D �Z   3B   +  4Z �,<  B �D �  �,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z 2B M+  �Z  �B �0B  �+  \  <      ,   ,<  �,< U$ TXB   Z >B VZ BB �  4,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �Z  Q,<  �,< ]Z  PF �Z L,<  �,< ^,< �& _Z �,<  �,< �Z `F _Z �,<  �,< �Z �F aZ  �,<  �Z �D bZ  z,<  �Z  K,<  Z R,<  Z 2,<  ,<   * �,~   0B  +  �+  �  �+  �2B N+  Z CB �0B  �+  �  �      ,   ,<  �,< U$ TXB �Z �B VZ �B �  D,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �Z  �,<  �Z �,<   "  �,   2B   +  �Z �B c+  +  r,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �  �,> 6,>  �,< �,< �$ T,      �,^  �/  �   �Z n,<  �,<   Z z,<   "  ,   XB �2B   +   t  ,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �+  +0B  +  +  �  �+  �2B �+  �Z �B �0B  �+  ?Z MB dXB �Z �3B   +  �Z ,<  D �Z B �  �,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �  �,> 6,>  �,< �,< �$ T,      �,^  �/  �   �  ,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z �B �0B  �+  >Z ,<  �,< ]Z oF eZ +,<  �,< �Z F eZ �,<  �,< ^,< �& _Z �,<  �,< �Z `F _Z �,<  �,< �Z �F aZ �,<  �Z �D bZ ,<  �Z �,<  Z 5,<  Z /H �,~     �+  �0B  +  �+  �0B  �+  B+   0B  +  �+   t  �+  �2B �+  	Z )B �0B  �+  �Z �B dXB �Z �3B   +  LZ �,<  D �Z �B �Z �B f3B   +  l  �,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �  O,> 6,>  �,< �,< �$ T,      �,^  �/  �   �  �,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z LB �0B  �+  kZ �,<  �Z MD �Z �B VZ �B �0B  �+  jZ �B V+  �  �+  �  �+  �,<   " g  [,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �  m,> 6,>  �,< �,< �$ T,      �,^  �/  �   �  �,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z �B �0B  �+  +  �0B  +  �+  +  �+  0B  +  +  �0B  �+  �+  (  �  �+  �3B �+  3B L+  3B �+  2B K+  	Z �B �0B  �+  �Z B V+  �0B  �+  �@ h  �+  Z �B dXB �Z �2B L+  �Z Z   ,   XB �+  zZ   ,<  �Z �Z 7  �[  Z  Z  1H  +  �2D   +  [  Z  B �XB �,\  3B  +  �,< j,<   $ �Z �,<  �,<   $ �,< �,<   $ �Z  ,<  �,<   $ �,< k,<   $ �[ 2B   +  �Z  ,<  �Zp  -,   +  /+  �Zp  ,<  �@ �   +  BZ �-,   +  4B �,~   Z �Z 7  �[  Z  Z  1H  +  92D   +  �[  XB   3B   +  �[ 4Z  ,<  �[ ;[  Z  ,<  �,<   & lZ �,<  �,<   $ �,~   [p  XBp  +  -/  �Z �3B �+  �2B K+  xZ B �2B   +  I  �Z D3B �+  �,<   ,<   ,< m,<   ,<   * �2B n+  �  y,> 6,>  �Z"  �,<  �,< �$ S,      �,^  �/  �  �   �  �,> 6,>  �,< �,< �$ T,      �,^  �/  �   �  U,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �Z �B �0B  �+  �Z aB V+  x  �+  x  �,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �  �,> 6,>  �,< �,< �$ T,      �,^  �/  �   �  l,> 6,>  �Z"  ,<  �,< �$ S,      �,^  �/  �  �   �,< �,< �,<   & lZ cB �0B  �+  �+  0B  +  �Z B oZ 0B oZ �Z   2B   +  � "  +  [  QD   "  ,~     �Z   ,~   ,~   0B  +  +  �  �+  �  �  z      ,   ,<  �,< U$ TXB e1B  +  �0B  �+  �Z �B VZ �B �Z �,<  �Z  �3B   +  Z   +  �Z   D �XB �[ B PXB  wZ �XB +   t1B  !+   0B  �+  +   0B   +  (Z I2B L+  (Z �B V+  +Z �2B �+  (Z �2B p+  (Z 2B �+  (Z �XB �Z �B VZ �B �+   tZ �,<  �Z �B qB �D JZ )B oZ �B o+   �XB   Z   ,~   3B   +  1Z   +  �Z JXB   D rZ �3B   +  5  �,~   Z �,~     �    �(P[[px?w|8FDP :@ #	8a+pLXS	�_>l�#j*0ErLTTa -�` 0�jDT0�J�N)@-�u"*QB\0J_T0K�o7�jm&	HhhiS (@k2:K@F	/F	8ajjE*BR�-[91k&                  (VARIABLE-VALUE-CELL HOST . 1059)
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
(COLLCT CONSS1 CONSNL SKNLST ALIST2 BHC IUNBOX LIST3 MKN GETHSH LIST2 SKLST EVCC KT CONS ASZ CF KNIL ENTERF) 3    `  h   `   60� X 8     z h   >x� =8� ;(� 8H /s ,[ *P� $(� !(� �  : ` h   \   v > j ;pY :0� .x� +x� *8' $ !~  l � H �  �    S    @� P K    � (   H� ( � 
P �    �   �  �   / BPz 9X� 7x� 5' 4X� 8 �    X� 
` �    CP� C(� Ah� ?X| >@h <0] :� 1p 0X 0� -x� ,8� *� (0� ( + $P "�  pv  � P� `� � 8� p � H �  �    	   4 F0 B` @`� @M 9@� 9; 7, 3hm )p� "@�  r  �  � ( � H A h � 8 �  � h � x � h   p      
READPLIST BINARY
    7    �    �-.           �Z   B  +,<  �,<  �[p  2B   +   ,<p  ,<  ,"  �,<  �@  -   +   �,<  �,<   Z   F  .,<  �,<  /Z  �F  �,<  0,<  �Z  �F  �,<  1,<   Z  �F  �Z  �,~      �,\  �XD  Z   QD  Zp  /  �D  2,<  �@  �   ,~   Z   ,<  �Zp  -,   +   �+   )Zp  ,<  �@  3   �+   �Z   ,<  �Z  3B   +   &Z  ,<  �,<  �$  42B   +   �Z  �,<  �,<  �Z  �B  �F  �+   �Z   D  5,~   [p  XBp  +   �/  �Z  �,~   Ynd 2B�:   (VARIABLE-VALUE-CELL IN . 3)
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
(SKNLST BHC KT KNIL ENTERF)       �        ' ( �   
  P      
PRINTPLIST BINARY
        �    )    ,-.           )       �   �Z   ,<  �Zp  -,   +   +   �Zp  ,<  �@  *   +   #@  �  �+   !Z   ,<  �Zp  -,   +   +    Zp  ,<  �@  +   +   �   �,>  (,>  �       �,^  �/  �   �Z"  XB  Z   B  �,   4H     �  �0D  1D  �+   �1D  �+   �   �=h  �+   ,>  (,>   $  �   �,^  /  �+   ,~   [p  XBp  +      �   �   �,~   [p  XBp  +   /  �   !   �   �Z   ,~         �    �ZT!.(H    (VARIABLE-VALUE-CELL L . 6)
(VARIABLE-VALUE-CELL OJ . 74)
(VARIABLE-VALUE-CELL X . 20)
(40 VARIABLE-VALUE-CELL PRE . 40)
(VARIABLE-VALUE-CELL XL . 41)
MKSTRING
(KNIL UPATM ASZ BHC URET1 SKNLST ENTERF)   �    �    �    � p �    �    �  X      
CHECKEOC BINARY
         �    -.           �Z   B  2B   +      �   �      �   �,   ,<  �Z"  ,\  2B  7   7   +   �Z"  ,<  �,<  $  �    $    &      �d$ 0    3Z   ,~       �P0      (VARIABLE-VALUE-CELL IN . 24)
PUPATMARKP
FTPHELP
S
PRINTPUPMARK
(KT ASZ MKN KNIL ENTERF)     
          p    �       
PUPATMARKP BINARY
             �-.                     0B   +      �   �   �   �   ,>  ,>  �   �ABx  ,^  �/  �1B   +   7   Z   ,~         +    Z   ,~          �    Y!  (VARIABLE-VALUE-CELL IN . 24)
(KNIL KT BHC ENTERF)   � @   8          
GOBBLECHARS BINARY
       �        �-.          Z   3B   +   �@    +   ,<  �"            ,   XB   0B   +   �   �   �   �   �   ,>  ,>  �   �ABx  ,^  �/  �0B   +   �Z  �B  �,<  �Z  �D  +   �,~   +   �   	   5D     �ad   5   �Z   ,~          �    8�R    (VARIABLE-VALUE-CELL IN . 39)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 34)
(NIL VARIABLE-VALUE-CELL CH . 31)
S
PUPDEBUGCHECK
CHARACTER
PRIN3
(BHC ASZ MKN KNIL ENTERF)      	        �  0      
PUPGETSTRING BINARY
          �    -.          �Z   @  D  �,<  �@     ,~   Z  �B  �2B   +   ,<  "  �Z   3B   +   Z   ,<  D  Z   3B   +   �Z  �B  �Z  �,~   EdJ      (VARIABLE-VALUE-CELL IN . 10)
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
(KNIL ENTERF)  �         
PUPGETMARK BINARY
             �-.           Z   B  �2B   +         �   �   �   �,   ,<  �,<  �$  ,<  �    $    &      �d$ 0    3,\  �,~       �P`  (VARIABLE-VALUE-CELL IJ . 17)
PUPATMARKP
FTPHELP
S
PRINTPUPMARK
(MKN KNIL ENTERF)       �       
CLOSEPUPFTP BINARY
    4    *    �-.           *Z   ,<  �,<  �$  +,<  �Z  �B  �,<  �@  , @ ,~   Z  ,<  �,<  �$  -Z  ,<  �,<  �$  -Z  	,<  �,<  .$  �3B   +   #    ,>  ),>  �Z"  �,<  �,<  /$  �,      �,^  �/  �   �   �   ,>  ),>  �,<  0,<  /$  �,      �,^  �/  �   �   �,>  ),>  �Z"  ,<  �,<  /$  �,      �,^  �/  �   �   �Z   3B   +   (B  1+   (Z  �3B   +   (B  �3B   +   (Z  B  �Z  #B  2Z   ,~     �    �M#	8aj@   (VARIABLE-VALUE-CELL FILE . 22)
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
(BHC IUNBOX ASZ KNIL ENTERF)     @   h � (   H �    ) ` �          
CHLNM BINARY
     �    �    �-.     (      �Z   ,<  �,<  Z   ,<  ,<  �Z  Z   7  �[  Z  Z  1H  +   �2D   +   [  Z  2B   +   Z   H  �,<  �Z   F  ,~   0)      (VARIABLE-VALUE-CELL FILE . 23)
(VARIABLE-VALUE-CELL HOST . 6)
(VARIABLE-VALUE-CELL F1 . 3)
(VARIABLE-VALUE-CELL PLIST . 10)
(VARIABLE-VALUE-CELL OUTFLG . 26)
"{"
"}"
SERVER-FILENAME
PACK*
CHANGEFILENAME
(KNIL ENTERF)  �       
SENDPUPABORT BINARY
      �    �    -.           �     $      
`d  +    $  � &    (      �,~   @   (VARIABLE-VALUE-CELL OJ . 3)
(ENTERF)      
PRINTPUPCODE BINARY
      �        �-.          Z   3B   +   Z   B  �,<  "  �,<  Z  �D  �Z   ,<  �Z  �D  ,<  �,<  �Z  �D  �,\  �,<  "  �Z  �,~   z0      (VARIABLE-VALUE-CELL CODE . 24)
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
        �        �-.          Z   3B   +   Z   B  ,<  �Z  �D  Z   Z   7  �[  Z  Z  1H  +   �2D   +   [  Z  B  �,<  �Z  �D  ,<  Z  �D  Z  �,~   h      (VARIABLE-VALUE-CELL N . 30)
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
       �        �-.          Z   3B   +   Z   ,<  �Z   XB  ,\  2B  +   �Z   ,~   Z   ,<  �,<  �Z  �F  Z  ,<  �Z  	D  �,<  Z  D  �,~   Z   ,~         (VARIABLE-VALUE-CELL WHO . 20)
(VARIABLE-VALUE-CELL FTPDEBUGFLG . 25)
(VARIABLE-VALUE-CELL LASTTRACED . 9)
0
TAB
PRIN1
": "
(KT KNIL ENTERF)  �      x        
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
