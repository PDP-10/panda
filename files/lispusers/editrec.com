(FILECREATED " 5-May-83 12:32:31" ("compiled on " <DDYER>EDITREC..20) (2 . 2) bcompl'd in WORK dated 
" 5-May-83 01:30:08")
(FILECREATED " 5-MAY-83 12:17:15" /lisp/ddyer/lisp/init/EDITREC.;2 23088 changes to: (RECORDS HARRAYP 
HASHARRAY) previous date: "12-APR-83 12:27:30" /lisp/ddyer/lisp/init/EDITREC)

CompatableRecords BINARY
       4    ¬    ²-.          ¬Z   ,<  @  .  (+   Z` -,   +   +   Z  XB   [  Z  XB   -,   +   Z  XB  Z   ,<  ,<  Z  F  12B   +   +   Z  
XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB` +   Z` ,~   ,<  Z   ,<  ,<   Zwÿ-,   +   ¡Zp  Z   2B   +    "  +   ![  QD   "  +   +Zwÿ,<  @  ±   +   ¦Z  ,<  Z  D  1,~   3B   +   ©ZwÿZp  ,   XBp  [wÿXBwÿ+   /  D  2,~   LB
	   (VARIABLE-VALUE-CELL OBJ . 72)
(VARIABLE-VALUE-CELL USERRECLST . 3)
(VARIABLE-VALUE-CELL OldTypes . 51)
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 74)
(NIL VARIABLE-VALUE-CELL N . 29)
RecordType?
(VARIABLE-VALUE-CELL X . 0)
UNION
(BHC COLLCT CONSNL KNIL SKLST SKNLST ENTERF)  ,    ©     0   x  `             X      

EDITX BINARY
              -.           Z   ,<  Z   ,<  ,<  &  ,~   `   (VARIABLE-VALUE-CELL OBJECT . 3)
(VARIABLE-VALUE-CELL TYPE . 5)
EDIT
EDITX1
(ENTERF)      

EDITX1 BINARY
    ¤       -.         @   ,~   Z   2B   +   Z   XB  Z   2B   +   [  Z  XB  ,<   Z  2B +   Z   XB  	+   2B   +   Z  Z   ,   XB  Z   3B   +   +   ÏZ  2B   +   Z  B XB  2B   +   ,< ,<   $ Z  ,<  ,<   $ ,<   " +   SB 3B   +   3Z  3B +   ¥B Z  XB   Z  Z ,   3B   +   ¢Z XB  +   ¦Z  B XB  Z XB  ¡+   ¦Z XB  ¤Z  B Z  ¢3B  +   O,< ,<   $ Z  ¦B ,<  ,<   $ ,<   " ,< ,<   $ Z  §,<  ,<   $ ,<   " +   OZ   ,<  @   +   ÂZ` -,   +   ·+   ÁZ  XB   Z  ¯3B  +   =-,   Z   Z  Z  ¸2B  +   @Z  82B   +   ?Z   XB` +   Á[` XB` +   µZ` ,~   3B   +   EZ XB  &+   OZ  »B Z  XB  £3B   +   ÉZ XB  D+   O,< ,<   $ Z  E,<  ,<   $ ,<   " Z   XB  K+   Z  ª,<  Z  Î,<  Z  F Zp  /  Z  Ï,<  Z  Ð,<  ,   XB  Z  Ô2B   +   YZ  Ó,~   Z   2B +   úZ  È2B +   ÝZ  XB ,~   2B +   çZ  \,<  Z  Ö,<  Z  ÆF XB   Z  Þ,<  Z  ß,<  ,<  ,< $ ,<  Z  àH ,~   2B +   ïZ  b,<  Z  c,<  Z  è,<  Z  éD ,<  ,<   Z  YF F ,~   2B +   ùZ  ê,<  Z  ë,<  Z  fF XB  áZ  ð,<  Z  ñ,<  ,<  ,< $ ,<  Z  òH ,~     ,~   2B +  Z  Ú2B +  Z  t,<  Z  u,<  Z  xF ,~   2B +  Z  },<  Z  ~,<  Z  F ,~   2B +  Z ,<  Z D ,~   Z ,~     ,~   !S"ub5YK"e0A#¨ZA Z`@e@F`@e6b      (VARIABLE-VALUE-CELL OBJECT . 273)
(VARIABLE-VALUE-CELL TYPE . 270)
(VARIABLE-VALUE-CELL ACTION . 219)
(VARIABLE-VALUE-CELL LASTEDITX . 172)
(VARIABLE-VALUE-CELL PASTTYPES . 163)
(VARIABLE-VALUE-CELL FILEPKGTYPES . 102)
(NIL VARIABLE-VALUE-CELL MADEREC . 231)
(NIL VARIABLE-VALUE-CELL DESCRIPTORS . 263)
(NIL VARIABLE-VALUE-CELL DESCRIPTORTYPE . 247)
?
GetTypeToEdit
"Sorry, no type info is available for "
PRIN1
TERPRI
TYPENUMBERFROMNAME
LISTP
SetupInfoRec
((DATATYPE BLOCKRECORD ACCESSFNS) . 0)
RECORD
GETDESCRIPTORS
DATATYPE
TYPENAME
"Warning! the object is of type "
"but you are using it as "
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 122)
FILEPKGTYPE
"I can't find a descriptor for type "
PUTHASH
EDIT
EDITE
MAKEDTD
((-1 TTY:) . 0)
REMAKEDTD
GETDEF
EDITX1
PUTDEF
MAKEREC
((-1 TTY:) . 0)
REMAKEREC
SHOULDNT
SHOW
(LIST2 BHC SKLST SKNLST FMEMB KT GETHSH KNIL ENTERF)   Ö    T    ;    7         N 	P K x ²  ¯ ` - (           n   O 	  Ã h »   P    8   p        

EditxRecordChangeA0010 BINARY
              -.          Z   Z   2B  +   Z   ,<  Z   ,<  Z   F  ,~   Z   ,~      (VARIABLE-VALUE-CELL VAL . 3)
(VARIABLE-VALUE-CELL KEY . 7)
(VARIABLE-VALUE-CELL RECNAME . 4)
(VARIABLE-VALUE-CELL OLDNAME . 9)
(VARIABLE-VALUE-CELL PASTTYPES . 11)
/PUTHASH
(KNIL ENTERF)          

EditxRecordChange BINARY
    <    /    :-.          /Z   Z   ,   ,<  @  2  +   %Z   3B   +   ¤Z  XB   Z  2B  ³+   [  [  Z  B  4XB   3B   +   -,   +   Z  	,<  [  [  ,   Z  ³,   D  ´+   @  5  +   Z  ,<  Z  D  6XB  Z  ,   2B   +   Z` ,~   ,<  ¶Z   ,<  ,<  7&  6XB     ."  ,   XB  +   Z  ,<  Z  ,<  Z  F  ·Z   ,<  Z  8D  ¸,<  9"  ¹,~   Z  ,<  ,<   Z   F  ·Z   3B   +   .,<  Z  %,<  Z   ,<  Z   ,<   "  ,   ,~   Z   ,~   RJQLA        (VARIABLE-VALUE-CELL RECNAME . 83)
(VARIABLE-VALUE-CELL RECFIELDS . 85)
(VARIABLE-VALUE-CELL OLDFLG . 87)
(VARIABLE-VALUE-CELL EditRecInfo . 77)
(VARIABLE-VALUE-CELL PASTTYPES . 67)
(VARIABLE-VALUE-CELL PreviousRecordChangeFn . 79)
(VARIABLE-VALUE-CELL OLDINFO . 63)
({old} VARIABLE-VALUE-CELL OLDNAME . 61)
(NIL VARIABLE-VALUE-CELL RD . 29)
DATATYPE
TYPENAMEFROMNUMBER
RPLACA
NIL
(1 VARIABLE-VALUE-CELL N . 59)
PACK*
"{old-"
"}"
/PUTHASH
EditxRecordChangeA0010
MAPHASH
((OldTypes (CONS OLDNAME OldTypes)) . 0)
SAVESETQ
(EVCC MKN CONS21 CONS SKLA KNIL GETHSH ENTERF)   `   `         X   p ) p  H       8      

FetchArrayContents BINARY
        L    A    É-.           AZ   B  Á,<  Z  B  B,<  Z  B  Â,<  @  C `,~   Z   -,   +      ,>  À,>         ,^  /  2"  +       ,>  À,>     	.Bx  ,^  /  ,   XB   +   Z  2B  E+   Z"ÿXB  +      ,>  À,>     .Bx  ,^  /  ."  ,   XB  Z  B  Â,   ,>  À,>  Z  B  B,   .Bx  ,^  /  /"  ,   ,<  Z  B  B,<  @  Å @ ,~       ,>  À,>         ,^  /  3b  +   ©+   ¿Z  ¤,<  Z  ¡,<  D  È,<     ,>  À,>     ©   ,^  /  2b  +   4Z  ª,<  Z  .D  I,   +   ´Z   ,   ,   XB` Z` 3B   +   ;,<  Z` ,   XB` ,\  QB  +   =Z` ,   XB` XB`    2."  ,   XB  =+   ¤Z` ,~     J
@Y $(       (VARIABLE-VALUE-CELL ARR . 98)
ARRAYTYP
ARRAYORIG
ARRAYSIZE
(VARIABLE-VALUE-CELL TYPE . 37)
(VARIABLE-VALUE-CELL ORIG . 46)
(VARIABLE-VALUE-CELL SIZE . 43)
(NIL VARIABLE-VALUE-CELL SETDLIMIT . 89)
DOUBLEPOINTER
(VARIABLE-VALUE-CELL $$TEM3 . 76)
(VARIABLE-VALUE-CELL I . 125)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL TMP . 0)
ELT
ELTD
(CONSS1 KNIL CONSNL IUNBOX ASZ MKN BHC SKI ENTERF)  6 X   x 5    ¼  4     H   P   p ¡ (     °      P         

FetchFunctionPointers BINARY
             -.           Z   B  3B   +   Z   ,~   Z   ,~       (VARIABLE-VALUE-CELL FN . 3)
CCODEP
(KNIL ENTERF)     H        

FetchStackVariables BINARY
    ¢        ¡-.           Z   B  ,<  Z  B  ,<  @   @0,~   Z` -,   +   +   Z  XB   Z` -,   +   +   Z  XB   Z   ,<  Z  ,<  ,<  ,   XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB` [` XB`    ."  ,   XB  +   Z` ,~   Pa@   (VARIABLE-VALUE-CELL DATUM . 6)
STKARGS
VARIABLES
(0 . 1)
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 26)
(NIL VARIABLE-VALUE-CELL Y . 23)
(1 VARIABLE-VALUE-CELL Z . 52)
(MKN CONSNL KNIL LIST3 SKNLST ENTERF)   (   `               x      

GetTypeToEdit BINARY
        C    µ    A-.          µ@  7  ,~   Z   -,   +   B  8XB   Z  ,<  Zp  -,   +   Zp  Z 7@  7   Z  2B  ¸+   ,<p  ,<   Z   F  9B  ¹3B   +   Z   +   Z   /  2B   +   ,<  :Z  D  ºXB  Z  ,<  Z  ;,   D  »+    B  <2B   +    Z  B  ¼XB   3B  =+   3B   +   -,   7   7   +    +   Z   +    Z  ,   XB  ,<  Z  Z   ,   -,   3B   7    ,   ,<  Z   D  ½D  »XB  ¥B  >,   1b  +   ´,<  ¾Z  ',<  ,<  ?Z  *,<  ,<  ¿,   ,<  Z  «,<  Z  .,<  ,<   ,<   (  @H  À-,   3B   7    ,   XB  /Z  4,~   0 c¨Q:Z LH      (VARIABLE-VALUE-CELL OBJ . 67)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 25)
(VARIABLE-VALUE-CELL PASTTYPES . 68)
(NIL VARIABLE-VALUE-CELL TYPES . 105)
(NIL VARIABLE-VALUE-CELL TN . 63)
TYPESOF
NOBIND
STKSCAN
RELSTK
VARS
DREMOVE
ATOM
NCONC
CompatableRecords
TYPENAME
**DEALLOC**
LDIFFERENCE
LENGTH
20
"which type in"
"should I use"
MAKEKEYLST
ASKUSER
(LIST3 IUNBOX SKLST GETHSH CONSNL BHC KT KNIL KNOB SKLA ENTERF) `      0 $    £    ´ X ! h            8 1 H  X      P   (   P   H      

HashTableContentsA0011 BINARY
            -.          Z   ,<  Z   ,<  ,   Z   ,   XB  ,~       (VARIABLE-VALUE-CELL A . 5)
(VARIABLE-VALUE-CELL B . 3)
(VARIABLE-VALUE-CELL X . 10)
(CONS LIST2 ENTERF)             

HashTableContents BINARY
              -.           @    ,~   Z   ,<  Z  D  Z   ,~   0   (VARIABLE-VALUE-CELL H . 6)
(NIL VARIABLE-VALUE-CELL X . 10)
HashTableContentsA0011
MAPHASH
(ENTERF)     

MAKEDTD BINARY
    ¡         -.           Z   2B   +   Z   B  XB  ,<  @    (,~   Z` -,   +   +   Z  XB   Z   ,<  ,<  Z   D   ,   XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB`    ."  ,   XB  +   Z  ,<  Z  ,<  ,<` ,   ,~   H0À    (VARIABLE-VALUE-CELL OBJECT . 47)
(VARIABLE-VALUE-CELL TYPE . 49)
(VARIABLE-VALUE-CELL TYPEDEF . 8)
GETDESCRIPTORS
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 18)
(1 VARIABLE-VALUE-CELL I . 45)
FFETCHFIELD
(LIST3 MKN CONSNL ALIST2 SKNLST KNIL ENTERF)               P       h        

MAKEREC BINARY
      ¢        ¡-.           Z   2B   +   Z   B  Z  XB  B  ,<  @     
,~   Z` -,   +   +   Z  XB   ,<  ,<  Z   ,<  Z  ,<  ,<   (  !,   XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB` +   Z  ,<  Z  ,<  ,<` ,   ,~   JB   (VARIABLE-VALUE-CELL OBJECT . 48)
(VARIABLE-VALUE-CELL TYPE . 50)
(VARIABLE-VALUE-CELL TYPEDEF . 25)
SetupInfoRec
RECORDFIELDNAMES
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 20)
FETCH
RECORDACCESS
(LIST3 CONSNL ALIST2 SKNLST KNIL ENTERF) 8   `         	      0      

REMAKEDTD BINARY
       ¤        £-.            Z   2B   +   Z   B  XB  [   [  Z  ,<  @     +   Z` -,   +   
+   Z  XB   -,   +   [  Z  ,<  Z  ,<  Z  D  "Z  ,<  Z   D  ¢,\  ,   2B   +   Z  ,<  Z  D  "Z  ,<  Z  ,<  [  Z  F  #Z   XB   [` XB` +   Z  ,~   Z  ,~   A&  (VARIABLE-VALUE-CELL OBJECT . 57)
(VARIABLE-VALUE-CELL TYPE . 6)
(VARIABLE-VALUE-CELL NEWOBJECT . 9)
(VARIABLE-VALUE-CELL TYPEDEF . 39)
GETDESCRIPTORS
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 47)
(NIL VARIABLE-VALUE-CELL RV . 55)
NTH
FFETCHFIELD
/REPLACEFIELD
(KT EQUAL SKLST SKNLST KNIL ENTERF)                    0      

REMAKEREC BINARY
       -    ¤    «-.            ¤Z   2B   +   Z   B  ¦Z  XB  [   [  Z  ,<  @  '   
+   £Z` -,   +   +   ¢Z  XB   -,   +   ![  Z  ,<  Z  ,<  Z   ,<  Z  ,<  ,<  ©(  *XB   ,\  ,   2B   +   !,<  *Z  ,<  Z  ,<  Z  ,<  ,<  ªZ  ,<  ^"  ,   B  +Z  ,<  Z  ,<  Z  ,<  ,<  ª[  Z  J  *Z   XB   [` XB` +   Z   ,~   Z  ,~   @S	     (VARIABLE-VALUE-CELL OBJECT . 71)
(VARIABLE-VALUE-CELL TYPE . 6)
(VARIABLE-VALUE-CELL NEWOBJECT . 10)
(VARIABLE-VALUE-CELL TYPEDEF . 58)
SetupInfoRec
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 61)
(NIL VARIABLE-VALUE-CELL RV . 69)
(NIL VARIABLE-VALUE-CELL OLDVAL . 49)
FETCH
RECORDACCESS
REPLACE
UNDOSAVE
(KT LIST EQUAL SKLST SKNLST KNIL ENTERF)  !                
      0      

RecordType? BINARY
     ¢        ¡-.           @    ,~   Z   2B   +   Z   B  Z  XB  3B   +   Z   (BûZ  A"  ."   XB   ,<  Z  B  [  [  Z  ,\  2B  +   Z  2B   +   Z   ,~   Z  2B   +   Z   ,~   Z  3B   +   Z  
,<  Z  ,<  Z  B  [  Z  ,<  Z  ,<  Z  J  !,~   Z   ,~   (@,a  (VARIABLE-VALUE-CELL X . 45)
(VARIABLE-VALUE-CELL TYPE . 52)
(VARIABLE-VALUE-CELL DEC . 54)
(NIL VARIABLE-VALUE-CELL DATATYPE . 43)
SetupInfoRec
DATATYPE
HASHLINK
SimilarP
(KT ASZ TYPTAB KNIL ENTERF)               X   x        

ReplaceArrayContents BINARY
        £        ¢-.           Z   ,<  Z   B  ,<  Z  B  ,   ,>  ,>  Z  B  ,   .Bx  ,^  /  ,   ,<  @   `
,~   Z` -,   +   +   Z  XB   -,   +   +   Z  ,<  Z  ,<  [  Z  F  ¡[  [  3B   +   Z  ,<  Z  ,<  [  [  Z  F  "[` XB` +   Z` ,~     @C@$  (VARIABLE-VALUE-CELL ARR . 44)
(VARIABLE-VALUE-CELL NEWVAL . 3)
ARRAYORIG
ARRAYSIZE
(0 . 1)
(VARIABLE-VALUE-CELL ORIG . 0)
(VARIABLE-VALUE-CELL END . 0)
NIL
(NIL VARIABLE-VALUE-CELL X . 48)
/SETA
/SETD
(KNIL SKNLST MKN BHC IUNBOX ENTERF)   `             
      `      

ReplaceFunctionPointers BINARY
                -.           Z   B  3B   +   Z   ,~   Z   ,~       (VARIABLE-VALUE-CELL FN . 3)
(VARIABLE-VALUE-CELL PTRS . 0)
CCODEP
(KNIL ENTERF)    X   8      

ReplaceStackVariables BINARY
     ª    £    )-.           £Z   ,<  @  ¤  ,~   Z` -,   +   +   ¢Z  XB   Z  ,<  Z   D  ¦XB   [  [  Z  3B  +   ,<  'Z  ,<  Z  ,<  Z  	,<  ,   B  §Z  ,<  Z  ,<  [  [  Z  F  'Z  ,<  Z  D  (XB  [  Z  3B  +   !,<  ¨Z  ,<  Z  ,<  Z  ,<  ,   B  §Z  ,<  Z  ,<  [  Z  F  ¨[` XB` +   Z` ,~   !@ $     (VARIABLE-VALUE-CELL DATUM . 61)
(VARIABLE-VALUE-CELL NEWVALUE . 3)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 63)
(NIL VARIABLE-VALUE-CELL OLDVAL . 55)
STKARG
SETSTKARG
UNDOSAVE
STKARGNAME
SETSTKARGNAME
(LIST4 SKNLST ENTERF)  X            

SHOWX BINARY
                -.           Z   ,<  Z   ,<  ,<  &  ,~   `   (VARIABLE-VALUE-CELL OBJECT . 3)
(VARIABLE-VALUE-CELL TYPE . 5)
SHOW
EDITX1
(ENTERF)      

SetHashTableContentsA0012 BINARY
              -.          Z   Z   7  [  Z  Z  1H  +   2D   +   2B   +   
Z  ,<  ,<   Z   F  ,~   
B  (VARIABLE-VALUE-CELL A . 0)
(VARIABLE-VALUE-CELL B . 15)
(VARIABLE-VALUE-CELL NEW . 4)
(VARIABLE-VALUE-CELL H . 18)
/PUTHASH
(KNIL ENTERF)      h      

SetHashTableContents BINARY
              -.           Z   ,<  Zp  -,   +   +   Zp  ,<  @     +   [   Z  ,<  Z  Z   ,   ,\  3B  +   Z  ,<  [  Z  ,<  Z  	F  ,~   [p  XBp  +   /  @    ,~   Z  ,<  Z  D  Z  ,~   e  ¢    (VARIABLE-VALUE-CELL H . 42)
(VARIABLE-VALUE-CELL NEW . 3)
(VARIABLE-VALUE-CELL X . 25)
/PUTHASH
(NIL VARIABLE-VALUE-CELL X . 0)
SetHashTableContentsA0012
MAPHASH
(BHC GETHSH SKNLST ENTERF)                  

SetupInfoRec BINARY
      M    ¸    Ê-.          ¸Z   3B   +   ·Z   ,   ,<  @  ¹   
+   7Z   2B   +   6Z  B  <XB   Z  3B  ¼+   3B  =+   3B  ½+   2B  >+   Z  ¾+   !3B  ?+   2B  ¿+   Z  @+   !3B  À+   3B  A+   3B  Á+   3B  B+   3B  Â+   2B  C+   Z   +   !3B  Ã+   2B  D+   Z  Ä+   !2B  E+   [  	Z  +   !Z   3B   +    B  Å+   !Z   XB   Z  !Z  F,   3B   +   .Z  Z   ,   Z  Æ,   Z   ,   Z  G,   Z  Ç,   ,<  ,<  H$  È-,   +   -Z  +   ­Z  IXB   Z  $,<  Z  ,<  Z  ­,<  Z  ¡2B  @+   3+   ³B  É,   XB  ,<  Z  F  JZ  4,~   ,~   Z   ,~   Sÿ{ÄS,ð          (VARIABLE-VALUE-CELL TYPE . 92)
(VARIABLE-VALUE-CELL EditRecInfo . 106)
(VARIABLE-VALUE-CELL INFO . 108)
(NIL VARIABLE-VALUE-CELL INST . 88)
(NIL VARIABLE-VALUE-CELL DEC . 94)
(NIL VARIABLE-VALUE-CELL TYP . 98)
(NIL VARIABLE-VALUE-CELL SAMPLE . 96)
RECLOOK
RECORD
TYPERECORD
PROPRECORD
ASSOCRECORD
LISTP
HASHLINK
HASHRECORD
HARRAYP
ACCESSFN
ACCESSFNS
CACCESSFNS
ATOMRECORD
BLOCKRECORD
SYNONYM
ARRAYRECORD
ARRAYBLOCK
ARRAYP
DATATYPE
TYPENAME
((LISTP ARRAYP) . 0)
CREATE
INST
SETQ
NOBREAK
ERRORSET
NO
TYPENUMBERFROMNAME
PUTHASH
(ALIST3 SKLST CONS21 CONS FMEMB KT GETHSH KNIL ENTERF)   ´    ,    *  '    ( `   8            ¸ x ¥ @   x        

SimilarP BINARY
     U    G    Ò-.     (      GZ   0B  +   9Z   2B  É+   Z   ,<  Z  2B   +   Z   B  J,<  @  Ê @+   Z` -,   +   +   Z  XB   -,   +   Z  Z   ,   2B   +   Z   XB` +   [` XB` +   
Z` ,~   ,~   2B  Ì+   &Z  ,<  Z  2B   +   Z  B  J,<  @  M @+   ¥Z` -,   +   +   ¤Z  XB  Z  Z  ,   2B   +   ¢Z   XB` +   ¤[` [  XB` +   Z` ,~   ,~   2B  O+   ±Z  -,   +   /Z  'B  Ï3B   +   /[  ¨-,   +   /[  Z  2B  P7   Z   ,~   Z  ª,<  Z   D  Ð,~   2B  Q+   8Z  /Z  02B  +   7Z  ²,<  Z  3D  Ð,~   Z   ,~   Z   ,~   0B  +   DZ  ´B  Ñ,<  Z  µB  Ñ,\  2B  +   CZ  :B  R,<  Z  »B  R,\  2B  7   Z   ,~   Z   ,~   2B  Ï+   FZ   ,~   Z   ,~   a*1BT`$F*$D@R) `     (VARIABLE-VALUE-CELL DATATYPE . 3)
(VARIABLE-VALUE-CELL X . 124)
(VARIABLE-VALUE-CELL SAM . 127)
(VARIABLE-VALUE-CELL TYPE . 49)
(VARIABLE-VALUE-CELL DEC . 88)
ASSOCRECORD
RECORDFIELDNAMES
(0 . 1)
(VARIABLE-VALUE-CELL NAMES . 62)
(NIL VARIABLE-VALUE-CELL ITEM . 61)
T
PROPRECORD
(0 . 1)
(VARIABLE-VALUE-CELL NAMES . 0)
(NIL VARIABLE-VALUE-CELL ITEM . 0)
T
RECORD
HARRAYP
HASHARRAY
SimilarlyConsed
TYPERECORD
ARRAYSIZE
ARRAYTYP
(KT FMEMB SKLST SKNLST KNIL ASZ ENTERF)  ` C p        ¨ `   @  8   p D ( 9   ® ( "      p            

SimilarlyConsed BINARY
                -.           Z   -,   +   Z   -,   +   Z  ,<  Z  D  3B   +   [  ,<  [  D  2B   +   Z  -,   +   Z  -,   +   7   Z   ,~   Z   ,~   "E (VARIABLE-VALUE-CELL X . 21)
(VARIABLE-VALUE-CELL Y . 24)
SimilarlyConsed
(KT SKNLST KNIL SKLST ENTERF)        @      (       0      
(PRINT (QUOTE EDITRECCOMS) T T)
(RPAQQ EDITRECCOMS ((ADDVARS (OldTypes)) (FILES EDITHIST) (FNS * EDITRECFNS) (EDITHIST * 
EDITRECEDITHIST) (ADDVARS (LASTEDITX)) (RECORDS * EDITRECRECORDS) (VARS * EDITRECVARS) (DECLARE: 
DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML) (LAMA))) (IFPROP HELP 
EDITX SHOWX)))
(ADDTOVAR OldTypes)
(FILESLOAD EDITHIST)
(RPAQQ EDITRECFNS (CompatableRecords EDITX EDITX1 EditxRecordChange FetchArrayContents 
FetchFunctionPointers FetchStackVariables GetTypeToEdit HashTableContents MAKEDTD MAKEREC REMAKEDTD 
REMAKEREC RecordType? ReplaceArrayContents ReplaceFunctionPointers ReplaceStackVariables SHOWX 
SetHashTableContents SetupInfoRec SimilarP SimilarlyConsed))
(RPAQQ EDITRECEDITHIST (EDITREC.LISP))
(ADDTOVAR LASTEDITX)
(RPAQQ EDITRECRECORDS (ARRAYP CODEP HARRAYP STACKP HASHARRAY (HASHLINK (EditRecInfo EditRecInfo) (
SUBRECORD EditRecInfo)) (RECORD EditRecInfo (RecordDef Sample DataType) (ACCESSFNS EditRecInfo ((
SAMPLE (fetch (EditRecInfo Sample) of (SetupInfoRec DATUM))) (DATATYPE (fetch (EditRecInfo DataType) 
of (SetupInfoRec DATUM))) (RECLOOK (fetch (EditRecInfo RecordDef) of (SetupInfoRec DATUM)))))) (
HASHLINK (PASTTYPES PASTTYPES))))
(ACCESSFNS ARRAYP ((Size ARRAYSIZE) (Type ARRAYTYP) (Origin ARRAYORIG) (Contents FetchArrayContents 
ReplaceArrayContents)))
(ACCESSFNS CODEP ((NumberOfArgs NARGS) (FunctionType FNTYP) (CodeLength (IDIFFERENCE (fetch (SEQUENCE 
LENGTH) of DATUM) (fetch (SEQUENCE OFFSET) of DATUM))) (FunctionPointers (FetchFunctionPointers DATUM)
 (ReplaceFunctionPointers DATUM NEWVALUE))))
(ACCESSFNS HARRAYP ((Size (HARRAYSIZE DATUM)) (Contents (HashTableContents DATUM) (
SetHashTableContents DATUM NEWVALUE))))
(ACCESSFNS STACKP ((FrameName STKNAME SETSTKNAME) (NumberOfArgs (STKNARGS DATUM)) (Arguments 
FetchStackVariables ReplaceStackVariables) (AccessLink (STKNTHNAME 1 DATUM)) (ControlLink (STKNTHNAME 
-1 DATUM)) (Blips (GETBLIPS DATUM)) (RealFramep? (REALFRAMEP DATUM)) (InterpFramep? (REALFRAMEP DATUM 
T))))
(RECORD HASHARRAY (HARRAYP . GROWTH) (ACCESSFNS ((Size (HARRAYSIZE (fetch (HASHARRAY HARRAYP) of DATUM
))) (Contents (fetch (HARRAYP Contents) of (fetch (HASHARRAY HARRAYP) of DATUM)) (replace (HARRAYP 
Contents) of (fetch (HASHARRAY HARRAYP) of DATUM))))) (TYPE? (AND (LISTP DATUM) (HARRAYP (fetch (
HASHARRAY HARRAYP) OF DATUM)) (NLISTP (fetch (HASHARRAY GROWTH) OF DATUM)))))
(HASHLINK (EditRecInfo EditRecInfo) (SUBRECORD EditRecInfo))
(RECORD EditRecInfo (RecordDef Sample DataType) (ACCESSFNS EditRecInfo ((SAMPLE (fetch (EditRecInfo 
Sample) of (SetupInfoRec DATUM))) (DATATYPE (fetch (EditRecInfo DataType) of (SetupInfoRec DATUM))) (
RECLOOK (fetch (EditRecInfo RecordDef) of (SetupInfoRec DATUM))))))
(HASHLINK (PASTTYPES PASTTYPES))
(RPAQQ EDITRECVARS ((PreviousRecordChangeFn (QUOTE CHANGERECORD)) (RECORDCHANGEFN (QUOTE 
EditxRecordChange))))
(RPAQQ PreviousRecordChangeFn CHANGERECORD)
(RPAQQ RECORDCHANGEFN EditxRecordChange)
(PUTPROPS EDITX HELP (allows you to edit most any object usig the standard LISP editor. Optional TYPE 
lets you specify how to represent the object, otherwise the resonable choices are presented. TYPE can 
be a DATATYPE, RECORD name or FILEPKGTYPE.))
(PUTPROPS SHOWX HELP (similar to EDITX but just returns the record that would have been edited.))
NIL
