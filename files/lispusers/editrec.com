(FILECREATED " 5-May-83 12:32:31" ("compiled on " <DDYER>EDITREC..20) (2 . 2) bcompl'd in WORK dated 
" 5-May-83 01:30:08")
(FILECREATED " 5-MAY-83 12:17:15" /lisp/ddyer/lisp/init/EDITREC.;2 23088 changes to: (RECORDS HARRAYP 
HASHARRAY) previous date: "12-APR-83 12:27:30" /lisp/ddyer/lisp/init/EDITREC)

CompatableRecords BINARY
       4    ,    2-.          ,Z   ,<   @  .  (+   Z`  -,   +   +   Z  XB   [  Z  XB   -,   +   
Z  XB  	Z   ,<  ,<   Z  F  12B   +   +   Z  
XB` Z` 3B   +   ,<   Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [`  XB`  +   Z` ,~   ,<   Z   ,<   ,<   Zw-,   +   !Zp  Z   2B   +    "  +   ![  QD   "  +   +Zw,<   @  1   +   &Z  
,<   Z  D  1,~   3B   +   )ZwZp  ,   XBp  [wXBw+   /  D  2,~   LB
	   (VARIABLE-VALUE-CELL OBJ . 72)
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
(BHC COLLCT CONSNL KNIL SKLST SKNLST ENTERF)  ,    )     0   x  `       	      X      

EDITX BINARY
              -.           Z   ,<   Z   ,<  ,<  &  ,~   `   (VARIABLE-VALUE-CELL OBJECT . 3)
(VARIABLE-VALUE-CELL TYPE . 5)
EDIT
EDITX1
(ENTERF)      

EDITX1 BINARY
    $   
    -.         
@   ,~   Z   2B   +   Z   XB  Z   2B   +   [  Z  XB  ,<   Z  2B +   Z   XB  	+   2B   +   Z  Z   ,   XB  Z   3B   +   +   OZ  2B   +   Z  B XB  2B   +   ,< ,<   $ Z  ,<   ,<   $ ,<   " +   SB 3B   +   3Z  3B +   %B Z  XB   Z  Z ,   3B   +   "Z XB  +   &Z  B XB  Z XB  !+   &Z XB  $Z  B Z  "3B  +   O,< ,<   $ Z  &B ,<   ,<   $ ,<   " ,< ,<   $ Z  ',<   ,<   $ ,<   " +   OZ   ,<   @   +   BZ`  -,   +   7+   AZ  XB   Z  /3B  +   =-,   Z   Z  Z  82B  +   @Z  82B   +   ?Z   XB` +   A[`  XB`  +   5Z` ,~   3B   +   EZ XB  &+   OZ  ;B Z  XB  #3B   +   IZ XB  D+   O,< ,<   $ Z  E,<   ,<   $ ,<   " Z   XB  K+   Z  *,<   Z  N,<  Z  F Zp  /   Z  O,<   Z  P,<  ,   XB  Z  T2B   +   YZ  S,~   Z   2B +   zZ  H2B +   ]Z  XB ,~   2B +   gZ  \,<  Z  V,<  Z  FF XB   Z  ^,<  Z  _,<  ,<   ,< $ ,<   Z  `H ,~   2B +   oZ  b,<  Z  c,<  Z  h,<  Z  iD ,<   ,<   Z  YF F ,~   2B +   yZ  j,<  Z  k,<  Z  fF XB  aZ  p,<  Z  q,<  ,<   ,< $ ,<   Z  rH ,~     ,~   2B +  	Z  Z2B +   Z  t,<  Z  u,<  Z  xF ,~   2B +  Z  },<  Z  ~,<  Z  F ,~   2B +  Z ,<  Z D ,~   Z ,~     ,~   !S"ub5YK"e0A#(ZA Z`@e@F`@e6b      (VARIABLE-VALUE-CELL OBJECT . 273)
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
(LIST2 BHC SKLST SKNLST FMEMB KT GETHSH KNIL ENTERF)   V    T    ;    7         N 	P K x 2  / ` - (           n   O 	  C h ;   P    8 	  p        

EditxRecordChangeA0010 BINARY
              -.          Z   Z   2B  +   Z   ,<  Z   ,<  Z   F  
,~   Z   ,~      (VARIABLE-VALUE-CELL VAL . 3)
(VARIABLE-VALUE-CELL KEY . 7)
(VARIABLE-VALUE-CELL RECNAME . 4)
(VARIABLE-VALUE-CELL OLDNAME . 9)
(VARIABLE-VALUE-CELL PASTTYPES . 11)
/PUTHASH
(KNIL ENTERF)          

EditxRecordChange BINARY
    <    /    :-.          /Z   Z   ,   ,<   @  2  +   %Z   3B   +   $Z  XB   Z  2B  3+   [  [  Z  B  4XB   3B   +   -,   +   Z  	,<  [  [  ,   Z  3,   D  4+   @  5  +   Z  ,<   Z  D  6XB  Z  ,   2B   +   Z`  ,~   ,<  6Z   ,<   ,<  7&  6XB     ."   ,   XB  +   Z  ,<   Z  ,<  Z  F  7Z   ,<   Z  8D  8,<  9"  9,~   Z  ,<   ,<   Z   F  7Z   3B   +   .,<   Z  %,<  Z   ,<  Z   ,<   "  ,   ,~   Z   ,~   RJQLA        (VARIABLE-VALUE-CELL RECNAME . 83)
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
(EVCC MKN CONS21 CONS SKLA KNIL GETHSH ENTERF)   `   `         X   p ) p  H       8      

FetchArrayContents BINARY
        L    A    I-.           AZ   B  A,<   Z  B  B,<   Z  B  B,<   @  C `,~   Z   -,   +      ,>  @,>           ,^   /   2"  +       ,>  @,>      	.Bx  ,^   /   ,   XB   +   Z  2B  E+   Z"XB  +      
,>  @,>      .Bx  ,^   /   ."   ,   XB  Z  B  B,   ,>  @,>   Z  B  B,   .Bx  ,^   /   /"   ,   ,<   Z  B  B,<   @  E @ ,~       ,>  @,>           ,^   /   3b  +   )+   ?Z  $,<   Z  !,<  D  H,<      ,>  @,>      )    ,^   /   2b  +   4Z  *,<   Z  .D  I,   +   4Z   ,   ,   XB` Z` 3B   +   ;,<   Z` ,   XB` ,\  QB  +   =Z` ,   XB` XB`    2."   ,   XB  =+   $Z` ,~      J
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
(CONSS1 KNIL CONSNL IUNBOX ASZ MKN BHC SKI ENTERF)  6 X   x 5    <  4     H   P   p ! (     0      P         

FetchFunctionPointers BINARY
             -.           Z   B  3B   +   Z   ,~   Z   ,~       (VARIABLE-VALUE-CELL FN . 3)
CCODEP
(KNIL ENTERF)     H        

FetchStackVariables BINARY
    "        !-.           Z   B  ,<   Z  B  ,<   @   @0,~   Z` -,   +   +   Z  XB   Z`  -,   +   +   Z  XB   Z   ,<  Z  ,<  ,<   ,   XB` Z` 3B   +   ,<   Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [` XB` [`  XB`     ."   ,   XB  +   Z` ,~   Pa@   (VARIABLE-VALUE-CELL DATUM . 6)
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
(MKN CONSNL KNIL LIST3 SKNLST ENTERF)   (   `             
  x      

GetTypeToEdit BINARY
        C    5    A-.          5@  7  ,~   Z   -,   +   B  8XB   Z  ,<  Zp  -,   +   Zp  Z 7@  7   Z  2B  8+   ,<p  ,<   Z   F  9B  93B   +   Z   +   Z   /   2B   +   ,<  :Z  D  :XB  Z  ,<   Z  ;,   D  ;+    B  <2B   +    Z  B  <XB   3B  =+   3B   +   -,   7   7   +    +   Z   +    Z  ,   XB  ,<   Z  Z   ,   -,   3B   7    ,   ,<   Z   D  =D  ;XB  %B  >,   1b   +   4,<  >Z  ',<   ,<  ?Z  *,<   ,<  ?,   ,<   Z  +,<   Z  .,<   ,<   ,<   (  @H  @-,   3B   7    ,   XB  /Z  4,~   0 c(Q:Z LH      (VARIABLE-VALUE-CELL OBJ . 67)
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
(LIST3 IUNBOX SKLST GETHSH CONSNL BHC KT KNIL KNOB SKLA ENTERF) `      0 $    #    4 X ! h            8 1 H  X      P   (   P   H      

HashTableContentsA0011 BINARY
            -.          Z   ,<   Z   ,<  ,   Z   ,   XB  ,~       (VARIABLE-VALUE-CELL A . 5)
(VARIABLE-VALUE-CELL B . 3)
(VARIABLE-VALUE-CELL X . 10)
(CONS LIST2 ENTERF)             

HashTableContents BINARY
              -.           @    ,~   Z   ,<   Z  D  Z   ,~   0   (VARIABLE-VALUE-CELL H . 6)
(NIL VARIABLE-VALUE-CELL X . 10)
HashTableContentsA0011
MAPHASH
(ENTERF)     

MAKEDTD BINARY
    !         -.           Z   2B   +   Z   B  XB  ,<   @    (,~   Z`  -,   +   +   Z  XB   Z   ,<  ,<   Z   D   ,   XB` Z` 3B   +   ,<   Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [`  XB`     	."   ,   XB  +   Z  ,<   Z  ,<  ,<` ,   ,~   H0@    (VARIABLE-VALUE-CELL OBJECT . 47)
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
(LIST3 MKN CONSNL ALIST2 SKNLST KNIL ENTERF)               P       h        

MAKEREC BINARY
      "        !-.           Z   2B   +   Z   B  Z  XB  B  ,<   @     
,~   Z`  -,   +   	+   Z  XB   ,<   ,<   Z   ,<  Z  ,<  ,<   (  !,   XB` Z` 3B   +   ,<   Z` ,   XB` ,\  QB  +   Z` ,   XB` XB` [`  XB`  +   Z  ,<   Z  ,<  ,<` ,   ,~   JB   (VARIABLE-VALUE-CELL OBJECT . 48)
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
(LIST3 CONSNL ALIST2 SKNLST KNIL ENTERF) 8   `         	      0      

REMAKEDTD BINARY
       $        #-.            Z   2B   +   Z   B  XB  [   [  Z  ,<   @     +   Z`  -,   +   
+   Z  XB   -,   +   [  
Z  ,<   Z  ,<   Z  D  "Z  ,<   Z   D  ",\  ,   2B   +   Z  ,<   Z  D  "Z  ,<   Z  ,<   [  Z  F  #Z   XB   [`  XB`  +   Z  ,~   Z  ,~   A&  (VARIABLE-VALUE-CELL OBJECT . 57)
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
(KT EQUAL SKLST SKNLST KNIL ENTERF)              	      0      

REMAKEREC BINARY
       -    $    +-.            $Z   2B   +   Z   B  &Z  XB  [   [  Z  ,<   @  '   
+   #Z`  -,   +   
+   "Z  XB   -,   +   ![  Z  ,<   Z  ,<   Z   ,<   Z  ,<  ,<  )(  *XB   ,\  ,   2B   +   !,<  *Z  ,<   Z  ,<   Z  ,<  ,<  *Z  ,<  ^"  ,   B  +Z  ,<   Z  ,<   Z  ,<  ,<  *[  Z  J  *Z   XB   [`  XB`  +   Z   ,~   Z  ,~   @S	     (VARIABLE-VALUE-CELL OBJECT . 71)
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
(KT LIST EQUAL SKLST SKNLST KNIL ENTERF)  !                
      0      

RecordType? BINARY
     "        !-.           @    ,~   Z   2B   +   Z   B  Z  XB  3B   +   Z   (B{Z  A"  ."   XB   ,<   Z  B  [  [  Z  ,\  2B  +   Z  2B   +   Z   ,~   Z  2B   +   Z   ,~   Z  3B   +   Z  
,<  Z  ,<  Z  B  [  Z  ,<   Z  ,<   Z  J  !,~   Z   ,~   (@,a  (VARIABLE-VALUE-CELL X . 45)
(VARIABLE-VALUE-CELL TYPE . 52)
(VARIABLE-VALUE-CELL DEC . 54)
(NIL VARIABLE-VALUE-CELL DATATYPE . 43)
SetupInfoRec
DATATYPE
HASHLINK
SimilarP
(KT ASZ TYPTAB KNIL ENTERF)      
    	     X   x        

ReplaceArrayContents BINARY
        #        "-.           Z   ,<   Z   B  ,<   Z  B  ,   ,>  ,>   Z  B  ,   .Bx  ,^   /   ,   ,<   @   `
,~   Z`  -,   +   +   Z  XB   -,   +   +   Z  ,<  Z  ,<   [  Z  F  ![  [  3B   +   Z  ,<   Z  ,<   [  [  Z  F  "[`  XB`  +   Z` ,~      @C@$  (VARIABLE-VALUE-CELL ARR . 44)
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
(KNIL SKNLST MKN BHC IUNBOX ENTERF)   `         
    
      `      

ReplaceFunctionPointers BINARY
                -.           Z   B  3B   +   Z   ,~   Z   ,~       (VARIABLE-VALUE-CELL FN . 3)
(VARIABLE-VALUE-CELL PTRS . 0)
CCODEP
(KNIL ENTERF)    X   8      

ReplaceStackVariables BINARY
     *    #    )-.           #Z   ,<   @  $  ,~   Z`  -,   +   +   "Z  XB   Z  ,<   Z   D  &XB   [  [  Z  3B  +   ,<  'Z  	,<   Z  ,<   Z  	,<  ,   B  'Z  ,<   Z  ,<   [  [  Z  F  'Z  ,<   Z  D  (XB  [  Z  3B  +   !,<  (Z  ,<   Z  ,<   Z  ,<  ,   B  'Z  ,<   Z  ,<   [  Z  F  ([`  XB`  +   Z` ,~   !@ $     (VARIABLE-VALUE-CELL DATUM . 61)
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
(LIST4 SKNLST ENTERF)  X            

SHOWX BINARY
                -.           Z   ,<   Z   ,<  ,<  &  ,~   `   (VARIABLE-VALUE-CELL OBJECT . 3)
(VARIABLE-VALUE-CELL TYPE . 5)
SHOW
EDITX1
(ENTERF)      

SetHashTableContentsA0012 BINARY
          
    -.          
Z   Z   7   [  Z  Z  1H  +   2D   +   2B   +   
Z  ,<   ,<   Z   F  ,~   
B  (VARIABLE-VALUE-CELL A . 0)
(VARIABLE-VALUE-CELL B . 15)
(VARIABLE-VALUE-CELL NEW . 4)
(VARIABLE-VALUE-CELL H . 18)
/PUTHASH
(KNIL ENTERF)      h      

SetHashTableContents BINARY
              -.           Z   ,<   Zp  -,   +   +   Zp  ,<   @     +   [   Z  ,<   Z  Z   ,   ,\  3B  +   Z  ,<   [  Z  ,<   Z  	F  ,~   [p  XBp  +   /   @    ,~   Z  ,<   Z  D  Z  ,~   e  "    (VARIABLE-VALUE-CELL H . 42)
(VARIABLE-VALUE-CELL NEW . 3)
(VARIABLE-VALUE-CELL X . 25)
/PUTHASH
(NIL VARIABLE-VALUE-CELL X . 0)
SetHashTableContentsA0012
MAPHASH
(BHC GETHSH SKNLST ENTERF)       
           

SetupInfoRec BINARY
      M    8    J-.          8Z   3B   +   7Z   ,   ,<   @  9   
+   7Z   2B   +   6Z  B  <XB   Z  3B  <+   3B  =+   3B  =+   2B  >+   Z  >+   !3B  ?+   2B  ?+   Z  @+   !3B  @+   3B  A+   3B  A+   3B  B+   3B  B+   2B  C+   Z   +   !3B  C+   2B  D+   Z  D+   !2B  E+   [  	Z  +   !Z   3B   +    B  E+   !Z   XB   Z  !Z  F,   3B   +   .Z  Z   ,   Z  F,   Z   ,   Z  G,   Z  G,   ,<   ,<  H$  H-,   +   -Z  +   -Z  IXB   Z  $,<   Z  ,<  Z  -,<  Z  !2B  @+   3+   3B  I,   XB  ,<   Z  F  JZ  4,~   ,~   Z   ,~   S{DS,p          (VARIABLE-VALUE-CELL TYPE . 92)
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
(ALIST3 SKLST CONS21 CONS FMEMB KT GETHSH KNIL ENTERF)   4    ,    *  '    ( `   8            8 x % @   x        

SimilarP BINARY
     U    G    R-.     (      GZ   0B  +   9Z   2B  I+   Z   ,<   Z  2B   +   Z   B  J,<   @  J @+   Z`  -,   +   +   Z  XB   -,   +   Z  Z   ,   2B   +   Z   XB` +   [`  XB`  +   
Z` ,~   ,~   2B  L+   &Z  ,<   Z  2B   +   Z  B  J,<   @  M @+   %Z`  -,   +   +   $Z  XB  Z  Z  ,   2B   +   "Z   XB` +   $[`  [  XB`  +   Z` ,~   ,~   2B  O+   1Z  -,   +   /Z  'B  O3B   +   /[  (-,   +   /[  Z  2B  P7   Z   ,~   Z  *,<   Z   D  P,~   2B  Q+   8Z  /Z  02B  +   7Z  2,<   Z  3D  P,~   Z   ,~   Z   ,~   0B   +   DZ  4B  Q,<   Z  5B  Q,\  2B  +   CZ  :B  R,<   Z  ;B  R,\  2B  7   Z   ,~   Z   ,~   2B  O+   FZ   ,~   Z   ,~   a*1BT`$F*$D@R) `     (VARIABLE-VALUE-CELL DATATYPE . 3)
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
(KT FMEMB SKLST SKNLST KNIL ASZ ENTERF)  ` C p        ( `   @  8   p D ( 9   . ( "      p            

SimilarlyConsed BINARY
                -.           Z   -,   +   
Z   -,   +   
Z  ,<   Z  D  3B   +   
[  ,<   [  D  2B   +   Z  -,   +   Z  -,   +   7   Z   ,~   Z   ,~   "E (VARIABLE-VALUE-CELL X . 21)
(VARIABLE-VALUE-CELL Y . 24)
SimilarlyConsed
(KT SKNLST KNIL SKLST ENTERF)        @      (       0      
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
