(FILECREATED " 8-JAN-83 13:28:10" ("compiled on " <LISPUSERS>DOCTOR.;1) (2 . 2) bcompl'd in WORK dated
 "30-DEC-82 00:01:56")
(FILECREATED " 8-JAN-83 00:04:15" <FLIP>DOCTOR.;9 30265 changes to: (FNS MAKESENTENCE DOCTOR) (VARS 
DOCTORCOMS) previous date: " 6-JAN-83 23:53:20" <FLIP>DOCTOR.;8)

DOCTOR BINARY
      l    N    i-.           NZ   2B   +   Z   XB   Z   ,<   @  Q  ,~   Z   ,<   ,<  R,<  S,<   @  S ` +   GZ   Z  UXB ,<  U   U,   ,   Z  ,   XB     V@  V,<   @  W @
+   E,<  Y,<   Z   F  Z,<  Z,<   Z  F  [,<   Z   D  [,<  \Z  B  \,   ,   Z  ,   XB  ,<  \Z  B  \,   ,   Z  ,   XB  Z"   XB      ,   XB   ,<  ],<   $  ]   ^,<  ^"  _,<  _,<   ,<   @  S ` +   ,Z   Z  UXB    `XB   Z   ,~   3B   +   $Z  *2B   +   /+   $[  -XB   Z  /XB  0Z  0Z  `,   3B   +   D,<  a,<  a   b,   ,>  N,>      "    ,^   /   /  ,   XB  6,<   ,<  b$  c,<   ,<  cZ  9,<   ,<  d$  d,<   ,<  e$  c,   B  eZ  f,   D  f,<   ,<   $  ],~      g+   $XB   Z   ,~   3B   +   IZ   +   IZ  gXB   D  hZ  I3B   +   M   h,~   Z  E,~      5,f&A y*	A 6i04`        (VARIABLE-VALUE-CELL FLG . 3)
(VARIABLE-VALUE-CELL MEMSTACK . 7)
(VARIABLE-VALUE-CELL LISPXHIST . 8)
(VARIABLE-VALUE-CELL RESETVARSLST . 63)
(VARIABLE-VALUE-CELL FLIPFLOP . 65)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 154)
(NIL VARIABLE-VALUE-CELL RESETZ . 149)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
GCGAG
COPYREADTABLE
COPYTERMTABLE
(VARIABLE-VALUE-CELL RDTBL . 49)
(VARIABLE-VALUE-CELL TTBL . 57)
(NIL VARIABLE-VALUE-CELL KEYSTACK . 95)
(NIL VARIABLE-VALUE-CELL SENTENCE . 98)
(NIL VARIABLE-VALUE-CELL TIMON . 121)
((%  %
 %
) . 0)
SETSEPR
((%. , ? ! - %( %) ; : #) . 0)
SETBRK
CONTROL
SETREADTABLE
SETTERMTABLE
((TELL ME YOUR PROBLEMS. PLEASE TERMINATE INPUT WITH A PERIOD OR A QUESTION MARK %.) . 0)
RECONSTRUCT
SETNONE
"
*"
PRIN1
((DUMMY) . 0)
MAKESENTENCE
((GOODBYE) . 0)
((IT'S BEEN MY PLEASURE, THAT'S) . 0)
$
CLOCK
10000
QUOTIENT
%.
10000
REMAINDER
100
PACK
((PLEASE %.) . 0)
APPEND
ANALYZE
ERROR
RESETRESTORE
ERROR!
(ALIST4 BHC IUNBOX EQUAL MKN ASZ KT CONS CONSNL ALIST2 CF KNIL ENTERF)         `   0     "    !    G @ , @     B    x   p  h   h  `        L 	 H 8 . P ' p  @ 	  @        

MAKESENTENCE BINARY
      U    G    R-.            G@  I   ,~   Z   ,   XB   Z   ,   XB      KXB   -,   +   
,<  K,<   ,   B  LXB  Z   2B  +      L,~   ,<   Z   D  M3B   +      LZ  ,<   Z  D  M,~   Z  
,<   Z   D  M3B   +   )[  2B   +   +      NXB   2B   +   Z   ,~   [  [  3B   +   &[  ,<   ,<  N$  O,   ,>  F,>   [  [  ,<   ,<  N$  O,       ,^   /   2b  +   &Z   ,~   Z  ,<   Z  D  M,~   Z  &,<   Z  ,<  ,<  O$  P2B   +   -Z  *D  PZ  -,<   ,<  Q$  PXB  %3B   +   3,<   Z   D  QXB  2Z  .,<   ,<  N$  PXB  03B   +   B[  '3B   +   B   5,>  F,>   [  7,<   ,<  N$  O,       ,^   /   3b  +   BZ  :,<   [  ?[  3,   D  M+   Z  83B   +   [  @,<   Z  @D  R+      2XA j2#%     (VARIABLE-VALUE-CELL RUBOUT . 21)
(VARIABLE-VALUE-CELL TRMLIS . 27)
(VARIABLE-VALUE-CELL PCTLIS . 39)
(VARIABLE-VALUE-CELL MEMSTACK . 102)
(NIL VARIABLE-VALUE-CELL FLAG . 133)
(NIL VARIABLE-VALUE-CELL WORD . 136)
(NIL VARIABLE-VALUE-CELL SENTENCE . 82)
(NIL VARIABLE-VALUE-CELL KEYSTACK . 138)
RATOM
*
PACK
TERPRI
MEMB
RPLACD
MAKESENTENCE
PRIORITY
LISTGET1
TRANSLATION
GETP
TCONC
MEMR
APPEND
BCONC
(CONS BHC IUNBOX LIST2 SKNM CONSNL KNIL ENTER0)       h %    = 8     
          H   @ 8 p 1 P  (  p  x   @      

ANALYZE BINARY
    9    -    7-.           -@  /  ,~   ,<  0^"  ,>  -,>       "   .Bx  ,^   /   ,   XB  0B   +   
Z  1+   Z  1D  2,<   Z   D  2[  XB  Z  ,<   ,<  3$  3XB   Z  3B   +   Z  2B  4+   Z  XB  +   Z  -,   +   Z  ,<   ,<  3$  2XB  +   Z   ,   XB   Z  Z  ,<   Z   D  42B   +    [  XB  +   Z  B  5Z  XB   Z  XB   -,   +   Z  "2B  5+   )[  $Z  B  6XB  [  %[  XB  !+   Z  ',<   ,<   $  6   6Z   ,~       d2&@) 2`       (VARIABLE-VALUE-CELL FLIPFLOP . 16)
(VARIABLE-VALUE-CELL KEYSTACK . 40)
(VARIABLE-VALUE-CELL SENTENCE . 78)
(NIL VARIABLE-VALUE-CELL RULES . 81)
(NIL VARIABLE-VALUE-CELL PARSELIST . 53)
(NIL VARIABLE-VALUE-CELL CR . 83)
NONE
MEM
LASTRESORT
GETP
BCONC
RULES
LISTGET1
NEWKEY
TEST
ADVANCE
PRE
RECONSTRUCT
MEMORY
(KT SKLST CONSNL SKNLST KNIL ASZ MKN BHC ENTER0)   +    $            - h                   

TEST BINARY
       >    6    <-.          6@  8  ,~   [   XB   Z   2B   +   	Z   3B   +   +   1Z  XB  Z   ,~   Z  XB   0B   +   +   %Z  2B   +   +   1Z  
-,   +   Z  ,<  Z  D  9Z  ,<   Z  D  9XB  3B   +   1+   #-,   +   Z  3B  +   !+   1Z  3B   +   Z  ,<   Z  D  :2B   +   !+   1Z  ,<   [  D  :2B   +   !+   1Z  ,<   Z  D  9[  "XB  #[  	XB  $+   Z  !,<   Z  #D  9[  $XB  '2B   +   +Z  %XB  )+   Z  (,<   Z  &D  ;3B   +   .+   [  ,XB  .3B   +   1+   +Z  *,<   Z  3B   +   5,<   ,<   $  ;D  ;Z   ,~   	@3&"bb	     (VARIABLE-VALUE-CELL D . 86)
(VARIABLE-VALUE-CELL S . 94)
(VARIABLE-VALUE-CELL PARSELIST . 98)
(NIL VARIABLE-VALUE-CELL CD . 61)
(NIL VARIABLE-VALUE-CELL PSV . 100)
TCONC
NTH
MEMBER
TEST4
TEST
RPLACD
(SKNLST SKNM ASZ KT KNIL ENTERF)   h   x   8      h 5 8 0 ` )      X   X      

TEST4 BINARY
          	    
-.           	Z   ,<   Z   D  
3B   +   Z   ,~   [  XB  3B   +   +   Z   ,~    `  (VARIABLE-VALUE-CELL CS . 3)
(VARIABLE-VALUE-CELL L . 12)
GETP
(KT KNIL ENTERF)      	  x        

ADVANCE BINARY
              -.           Z   [  ,<   Z  [  Z  [  2B   +   Z  [  [  +   
Z  [  Z  [  D  ,~   !  (VARIABLE-VALUE-CELL RULES . 16)
RPLACA
(KNIL ENTERF)  `      

RECONSTRUCT BINARY
     =    2    ;-.          2@  4  0,~   Z   2B   +   Z   ,   XB   Z   2B   +   Z  3B   +   Z   2B   +   ,<  7"  8   8Z  ,~   Z  XB   -,   +   +    Z  3B   +   Z  ,<  Z   D  93B   +   Z  B  8Z   XB  	+   Z   3B   +   ,<  9"  :+      8Z   XB  Z  B  8+   Z  ,<  Z  D  :[  XB  +   Z   ,<   Z  D  ;XB  !Z  XB   [  "Z  XB   Z  #Z  $2B  +   '+   Z  3B   +   /Z  3B   +   ,,<  9"  :+   -   8Z   XB  )Z  %B  8+   1Z  ,<  Z  -D  :[  0XB  1+   % Ip2*'c	qD@     (VARIABLE-VALUE-CELL RULE . 62)
(VARIABLE-VALUE-CELL PF . 79)
(VARIABLE-VALUE-CELL TRMLIS . 36)
(VARIABLE-VALUE-CELL PARSELIST . 64)
(NIL VARIABLE-VALUE-CELL SENT . 94)
(NIL VARIABLE-VALUE-CELL CR . 71)
(NIL VARIABLE-VALUE-CELL V1 . 99)
(NIL VARIABLE-VALUE-CELL V2 . 75)
(NIL VARIABLE-VALUE-CELL TPF . 90)
(NIL VARIABLE-VALUE-CELL QMF . 43)
?
PRIN1
TERPRI
MEMBER
1
SPACES
TCONC
NTH
(KT SKNM CONSNL KNIL ENTERF)   X  `   p    `   ( )     
    X        

MEMORY BINARY
               -.           @    ,~   Z   2B   +   Z   ,~   Z   ,   XB   Z  Z  ,<   Z   D  3B   +   ,<  ,<  $  [  Z  Z  [  XB   ,<   Z  ,<   Z  B  Z  Z  B  Z  [  ,   ,   D  [  XB  +    pB    (VARIABLE-VALUE-CELL MEMSTACK . 43)
(VARIABLE-VALUE-CELL SENTENCE . 17)
(NIL VARIABLE-VALUE-CELL PARSELIST . 13)
(NIL VARIABLE-VALUE-CELL X . 37)
TEST
NONE
MEM
GETP
ADVANCE
RECONSTRUCT
RPLACA
(CONSS1 CONS CONSNL KNIL ENTER0) P   H    p   (   X        

BCONC BINARY
                -.           Z   2B   +   Z   Z   ,   XB      ,   ,~   Z  2B   +   Z  ,<   ,<   Z   Z  ,   D  [  D  ,~   Z  ,<   Z  ,<   Z  Z  
,   ,<   ,<   $  D  Z  D  ,~     ( P    (VARIABLE-VALUE-CELL WHAT . 31)
(VARIABLE-VALUE-CELL LIST . 30)
RPLACD
RPLACA
(CONS KNIL ENTERF)    h      (   @        

RPLQQ BINARY
                -.          Z   [  QD  [  ,~       (VARIABLE-VALUE-CELL RPLQ . 4)
(ENTERF)    

SETNONE BINARY
            -.            @    ,~      XB   ,<   ,<  ,<  $  ,\  QB  ,<  ,<  ,<  Z"   ,   ,<   Z   ,   ,<   Z  ,<   ,   ,   ,   F  Z   ,~   p @     (NIL VARIABLE-VALUE-CELL A . 23)
GENSYM
NONE
LASTRESORT
GETP
MEM
RULES
PUT
(ALIST2 LIST3 KNIL CONSNL ASZ ENTER0) h   X   x      8 
    	       

DOCTORSYS BINARY
    2    !    0-.         ( !@  $  ,~   ,<  %Z   ,<   ,   B  %Z   XB  Z   XB   Z   XB   ,<  &Z   D  &,<  '"  '   (,<  (   )XB   ,<   ,<  )^"  ,>   ,>   ,<  *Z  ,<   ,<  *&  +,   .Bx  ,^   /   ,   F  +,<   ,<  ,&  ,XB   B  -Z   2B   +   Z  -B  .Z  ,<   ,<   $  .,<   "  /,<   "  /   /,<   "  0Z   ,~      y)ibZ      (VARIABLE-VALUE-CELL SYS . 47)
(VARIABLE-VALUE-CELL GREETHIST . 12)
(VARIABLE-VALUE-CELL SYSOUTGAG . 14)
(VARIABLE-VALUE-CELL FIRSTNAME . 16)
(VARIABLE-VALUE-CELL DOCARM . 18)
(VARIABLE-VALUE-CELL HERALDSTRING . 52)
(NIL VARIABLE-VALUE-CELL TEM . 32)
(NIL VARIABLE-VALUE-CELL LISPXHIST . 0)
SIDE
UNDOLISPX2
INTERRUPT
ADVISE
100
GCTRP
GCGAG
"
DOCTOR  "
DATE
1
-
4
STRPOS
SUBSTRING
" ..."
CONCAT
HERALD
DOCTOR.SAV
SYSOUT
PRIN1
TERPRI
GREET0
DOCTOR
(MKN BHC IUNBOX KT KNIL LIST2 ENTERF) P   H   0   `  @       x              
(PRETTYCOMPRINT DOCTORCOMS)
(RPAQQ DOCTORCOMS ((FNS * DOCTORFNS) (VARS TRMLIS PCTLIS RUBOUT DOCARM) (VARS WDLIST) (IFPROP (
PRIORITY RULES TRANSLATION BELIEF MEMR EMOTION LASTRESORT FAMILY PERSON) * (PROGN WDLIST)) (DECLARE: 
DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA RPLQQ) (NLAML) (LAMA)))))
(RPAQQ DOCTORFNS (DOCTOR MAKESENTENCE ANALYZE TEST TEST4 ADVANCE RECONSTRUCT MEMORY BCONC RPLQQ 
SETNONE DOCTORSYS))
(RPAQQ TRMLIS (%. ! ?))
(RPAQQ PCTLIS (, ; %( %) :))
(RPAQQ RUBOUT #)
(RPAQQ DOCARM (COND ((EQ INTYPE 3) (PRIN1 (QUOTE "

...EXCUSE ME FOR JUST A MINUTE.
") T) (RECLAIM) (COND ((STKPOS (QUOTE MAKESENTENCE)) (PRIN1 (QUOTE 
"SORRY TO HAVE INTERRUPTED YOU, PLEASE CONTINUE...

") T)) (T (PRIN1 (QUOTE "NOW, WHERE WERE WE...OH YES,
") T))) (SETQ INTYPE -1))))
(RPAQQ WDLIST (SORRY DONT CANT WONT REMEMBER IF DREAMT DREAMED DREAM DREAMS HOW WHEN ALIKE SAME 
CERTAINLY FEEL THINK BELIEVE WISH MY NONE PERHAPS MAYBE NAME DEUTSCH FRANCAIS SVENSKA ITALIANO ESPANOL
 HELLO COMPUTER MACHINE MACHINES COMPUTERS AM ARE YOUR WAS WERE ME YOU'RE I'M MYSELF YOURSELF MOTHER 
MOM DAD FATHER SISTER BROTHER WIFE CHILDREN I YOU XXYYZZ YES NO CAN IS WHERE WHAT XXWHAT BECAUSE WHY 
EVERYONE EVERYBODY NOBODY NOONE ALWAYS LIKE DIT OH EVERY DO GIRLS WOMEN BOY GIRL MAN WOMAN SEXY SEXUAL
 SEX FRIENDLY FRIEND CRY LAUGH LOVE HATE DISLIKE))
(PUTPROPS SORRY PRIORITY 2)
(PUTPROPS REMEMBER PRIORITY 5)
(PUTPROPS IF PRIORITY 3)
(PUTPROPS DREAMT PRIORITY 4)
(PUTPROPS DREAMED PRIORITY 4)
(PUTPROPS DREAM PRIORITY 3)
(PUTPROPS DREAMS PRIORITY 3)
(PUTPROPS HOW PRIORITY 0)
(PUTPROPS WHEN PRIORITY 0)
(PUTPROPS ALIKE PRIORITY 10)
(PUTPROPS SAME PRIORITY 3)
(PUTPROPS CERTAINLY PRIORITY 0)
(PUTPROPS MY PRIORITY 0)
(PUTPROPS PERHAPS PRIORITY 0)
(PUTPROPS MAYBE PRIORITY 0)
(PUTPROPS NAME PRIORITY 15)
(PUTPROPS DEUTSCH PRIORITY 0)
(PUTPROPS FRANCAIS PRIORITY 0)
(PUTPROPS SVENSKA PRIORITY 0)
(PUTPROPS ITALIANO PRIORITY 0)
(PUTPROPS ESPANOL PRIORITY 0)
(PUTPROPS HELLO PRIORITY 0)
(PUTPROPS COMPUTER PRIORITY 0)
(PUTPROPS MACHINE PRIORITY 0)
(PUTPROPS MACHINES PRIORITY 0)
(PUTPROPS COMPUTERS PRIORITY 0)
(PUTPROPS AM PRIORITY 0)
(PUTPROPS ARE PRIORITY 0)
(PUTPROPS YOUR PRIORITY 0)
(PUTPROPS WAS PRIORITY 2)
(PUTPROPS WERE PRIORITY 0)
(PUTPROPS YOU'RE PRIORITY 0)
(PUTPROPS I'M PRIORITY 0)
(PUTPROPS I PRIORITY 0)
(PUTPROPS YOU PRIORITY 0)
(PUTPROPS YES PRIORITY -1)
(PUTPROPS NO PRIORITY -1)
(PUTPROPS CAN PRIORITY 0)
(PUTPROPS IS PRIORITY 0)
(PUTPROPS WHERE PRIORITY 0)
(PUTPROPS WHAT PRIORITY 0)
(PUTPROPS BECAUSE PRIORITY 0)
(PUTPROPS WHY PRIORITY 0)
(PUTPROPS EVERYONE PRIORITY 2)
(PUTPROPS EVERYBODY PRIORITY 2)
(PUTPROPS NOBODY PRIORITY 2)
(PUTPROPS NOONE PRIORITY 2)
(PUTPROPS ALWAYS PRIORITY 1)
(PUTPROPS LIKE PRIORITY 3)
(PUTPROPS OH PRIORITY 10)
(PUTPROPS EVERY PRIORITY 0)
(PUTPROPS DO PRIORITY 0)
(PUTPROPS GIRLS PRIORITY 3)
(PUTPROPS WOMEN PRIORITY 3)
(PUTPROPS BOY PRIORITY 3)
(PUTPROPS GIRL PRIORITY 3)
(PUTPROPS MAN PRIORITY 3)
(PUTPROPS WOMAN PRIORITY 3)
(PUTPROPS SEXY PRIORITY 5)
(PUTPROPS SEXUAL PRIORITY 5)
(PUTPROPS SEX PRIORITY 5)
(PUTPROPS FRIENDLY PRIORITY 0)
(PUTPROPS FRIEND PRIORITY 1)
(PUTPROPS CRY PRIORITY 2)
(PUTPROPS LAUGH PRIORITY 2)
(PUTPROPS SORRY RULES (((0) (NIL) (APOLOGIES ARE NOT NECESSARY %.) (WHAT FEELINGS DO YOU HAVE WHEN YOU
 APOLOGIZE))))
(PUTPROPS REMEMBER RULES (((REMEMBER 0) (NIL) (PRE (DO I REMEMBER 2) REMEMBER)) ((YOU REMEMBER 0) (NIL
) (DO YOU OFTEN THINK OF 3) (WHAT ELSE DOES THINKING OF 3 BRING TO MIND) (WHAT ELSE DO YOU REMEMBER) (
WHY DO YOU REMEMBER 3 JUST NOW) (WHAT IN THE PRESENT SITUATION REMINDS YOU OF 3) (WHAT I^@THE 
CONNECTION BETWEEN ME AND 3)) ((DO I REMEMBER 0) (NIL) (WHY DID YOU THINK I WOULD FORGET 4) (WHY DO 
YOU THINK I SHOULD RECALL 4 NOW) (WHAT ABOUT 4))))
(PUTPROPS IF RULES (((0 IF 0) (NIL) (DO YOU THINK ITS LIKELY THAT 3) (DO YOU WISH THAT 3) (WHAT DO YOU
 THINK ABOUT 3) (REALLY "," IF 3))))
(PUTPROPS DREAMT RULES (((0 YOU DREAMT 0) (NIL) (REALLY 4) (HAVE YOU EVER FANTASIED 4 WHILE YOU WERE 
AWAKE) (HAVE YOU DREAMT 4 BEFORE) DREAM NEWKEY)))
(PUTPROPS DREAMED RULES (DREAMT))
(PUTPROPS DREAM RULES (((0 YOU DREAM (OF ABOUT) 0) (NIL) (WHAT MIGHT 5 REPRESENT) (WHAT DOES 5 SUGGEST
 TO YOU) (HOW DOES THAT DREAM RELATE TO YOUR PROBLEM)) ((0) (NIL) (WHAT DO YOU DREAM ABOUT) (WHAT 
PERSONS APPEAR IN YOUR DREAMS) (WHAT MAY DREAMS HAVE TO DO WITH YOUR PROBLEM) NEWKEY)))
(PUTPROPS DREAMS RULES (DREAM))
(PUTPROPS HOW RULES (WHAT))
(PUTPROPS WHEN RULES (((WHEN (DO DID DOES WILL) 0) (NIL) XXWHAT) ((0) (NIL) (IS THERE ANY OTHER TIME) 
(WHY THEN "," DO YOU SUPPOSE))))
(PUTPROPS ALIKE RULES (DIT))
(PUTPROPS SAME RULES (DIT))
(PUTPROPS CERTAINLY RULES (YES))
(PUTPROPS MY RULES (((0 YOUR 0 (NIL FAMILY) 0) (NIL) (TELL ME MORE ABOUT YOUR FAMILY %.) (WHO ELSE IN 
YOUR FAMILY 5) (YOUR 4) (WHAT ELSE COMES TO MIND WHEN YOU THINK OF YOUR 4)) ((YOUR 2 0) (NIL) (IS IT 
IMPORTANT TO YOU THAT YOUR 2 3) (DO YOU SUPPOSE ANYONE ELSE'S 2 3) (WHAT MAKES YOU THINK YOUR 2 3) (
SUPPOSE I DIDN'T BELIEVE THAT YOUR 2 3 %.)) ((0 YOUR 1) (NIL) (YOUR 3) (WHY DO YOU SAY YOUR 3) (WHO 
ELSE KNOWS ABOUT YOUR 3) (WHY DO YOU MENTION YOUR 3 JUST NOW) (WHY IS YOUR 3 IMPORTANT TO YOU) (DO YOU
 OFTEN DISCUSS YOUR 3))))
(PUTPROPS PERHAPS RULES (((0) (NIL) (YOU DON'T SEEM QUITE CERTAIN %.) (WHY THE UNCERTAIN TONE) (CAN'T 
YOU BE MORE POSITIVE) (YOU AREN'T SURE) (DON'T YOU KNOW))))
(PUTPROPS MAYBE RULES (PERHAPS))
(PUTPROPS NAME RULES (((0) (NIL) (I AM NOT INTERESTED IN NAMES %.) (I'VE TOLD YOU BEFORE I DON'T CARE 
ABOUT NAMES - PLEASE CONTINUE %.))))
(PUTPROPS DEUTSCH RULES (((0) (NIL) (I AM SORRY "," I SPEAK ONLY ENGLISH))))
(PUTPROPS FRANCAIS RULES (DEUTSCH))
(PUTPROPS SVENSKA RULES (DEUTSCH))
(PUTPROPS ITALIANO RULES (DEUTSCH))
(PUTPROPS ESPANOL RULES (DEUTSCH))
(PUTPROPS HELLO RULES (((0) (NIL) (HOW DO YOU DO %.))))
(PUTPROPS COMPUTER RULES (((0) (NIL) (DO COMPUTERS WORRY YOU) (WHY DO YOU MENTION COMPUTERS) (WHAT DO 
YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM) (DON'T YOU THINK COMPUTERS CAN HELP PEOPLE))))
(PUTPROPS MACHINE RULES (COMPUTER))
(PUTPROPS MACHINES RULES (COMPUTER))
(PUTPROPS COMPUTERS RULES (COMPUTER))
(PUTPROPS AM RULES (((ARE YOU 0) (NIL) (DO YOU BELIEVE YOU ARE 3) (WOULD YOU WANT TO BE 3) (YOU WISH I
 WOULD TELL YOU YOU ARE 3 %.) (WHAT WOULD IT MEAN IF YOU WERE 3) XXWHAT) ((0) (NIL) (WHY DO YOU SAY 
'AM') (I DON'T UNDERSTAND THAT))))
(PUTPROPS ARE RULES (((THERE (ARE IS) (NO NOT) 0) (NIL) (WHAT IF THERE WERE 4) (DID YOU THINK THERE 
MIGHT BE 4) (PRE (THERE 2 4) ARE)) ((THERE (ARE IS) 0) (NIL) (2 THERE REALLY 3) (WHY 2 THERE 3) (HOW 3
 THE 4 RELATED TO YOU)) ((ARE I 0) (NIL) (WHY ARE YOU INTERESTED IN WHETHER I AM 3 OR NOT) (WOULD YOU 
PREFER IF I WEREN'T 3) (PERHAPS I AM 3 IN YOUR FANTASIES %.) (DO YOU SOMETIMES THINK I AM 3) XXWHAT) (
(ARE 0) (NIL) XXWHAT) ((0 1 (ARE IS) NOT 0) (NIL) (POSSIBLY THAT IS FOR THE BETTER %.) (WHAT IF 2 WERE
 5) (WHAT DO YOU REALLY KNOW ABOUT 2)) ((0 (ARE IS) 0) (NIL) (SUPPOSE 1 WERE NOT 3 %.) (POSSIBLY 1 
REALLY 2 NOT 3 %.) (TELL ME MORE ABOUT 1 %.) (DID YOU THINK 1 MIGHT NOT BE 3) (1 PERHAPS 2 3 %.))))
(PUTPROPS YOUR RULES (((0 MY 1) (NIL) (WHY ARE YOU CONCERNED OVER MY 3) (WHAT ABOUT YOUR OWN 3) (ARE 
YOU WORRIED ABOUT SOMEONE ELSES 3) (REALLY "," MY 3)) ((MY 0) (NIL) (PERHAPS YOUR OWN 2 %.) (ARE YOU 
WORRIED THAT MY 2))))
(PUTPROPS WAS RULES (((WAS YOU 0) (NIL) (WHAT IF YOU WERE 3) (DO YOU THINK YOU WERE 3) (WERE YOU 3) (
WHAT WOULD IT MEAN IF YOU WERE 3) XXWHAT) ((YOU WAS 0) (NIL) (WERE YOU REALLY) (WHY DO YOU TELL ME YOU
 WERE 3 NOW) (PERHAPS I ALREADY KNEW YOU WERE 3 %.)) ((WAS I 0) (NIL) (WOULD YOU LIKE TO BELIEVE I WAS
 3) (WHAT SUGGESTS THAT I WAS 3) (WHAT DO YOU THINK) (PERHAPS I WAS 3 %.) (WHAT IF I HAD BEEN 3))))
(PUTPROPS WERE RULES (WAS))
(PUTPROPS YOU'RE RULES (((0 I'M 0) (NIL) (PRE (I ARE 3) YOU))))
(PUTPROPS I'M RULES (((0 YOU'RE 0) (NIL) (PRE (YOU ARE 3) I))))
(PUTPROPS I RULES (((0 YOU (WANT NEED) 0) (NIL) (WHAT WOULD IT MEAN TO YOU IF YOU GOT 4) (WHY DO YOU 
WANT 4) (WHAT WOULD GETTING 4 MEAN TO YOU)) ((0 YOU ARE 0 (SAD UNHAPPY DEPRESSED SICK ILL) 0) (NIL) (I
 AM SORRY TO HEAR YOU ARE 5 %.) (DO YOU THINK COMING HERE WILL HELP YOU NOT TO BE 5) (CAN YOU EXPLAIN 
WHAT MADE YOU 5)) ((0 YOU ARE 0 (HAPPY ELATED GLAD BETTER) 0) (NIL) (HOW HAVE I HELPED YOU TO BE 5) (
HAS YOUR TREATMENT MADE YOU 5) (WHAT MAKES YOU 5 JUST NOW)) ((0 YOU (NIL BELIEF) YOU 0) (NIL) (DO YOU 
REALLY THINK SO) (BUT YOU ARE NOT SURE YOU 5) (DO YOU REALLY DOUBT YOU 5)) ((0 YOU 0 (NIL BELIEF) 0 I 
0) (NIL) (PRE (6 7) YOU)) ((0 YOU ARE 0) (NIL) (IS IT BECAUSE YOU ARE 4 THAT YOU CAME TO ME) (HOW LONG
 HAVE YOU BEEN 4) (DO YOU BELIEVE IT NORMAL TO BE 4) (DO YOU ENJOY BEING 4)) ((0 YOU (CAN'T CANNOT) 0)
 (NIL) (HOW DO YOU KNOW YOU CAN'T 4) (HAVE YOU TRIED) (PERHAPS YOU COULD 4 NOW %.) (DO YOU REALLY WANT
 TO BE ABLE TO 4)) ((0 YOU (DON'T WON'T) 0) (NIL) (DON'T YOU REALLY 4) (WHY DON'T YOU 4) (DO YOU WISH 
YOU DID 4) (DOES THAT TROUBLE YOU)) ((0 YOU FEEL 0) (NIL) (TELL ME MORE ABOUT SUCH FEELINGS %.) (DO 
YOU OFTEN FEEL 4) (DO YOU ENJOY FEELING 4) (OF WHAT DOES FEELING 4 REMIND YOU)) ((YOU 0 I) (NIL) (
PERHAPS IN YOUR FANTASY WE 2 EACH OTHER %.) (DO YOU WISH TO 2 ME) (YOU SEEM TO NEED TO 2 ME %.) (DO 
YOU 2 ANYONE ELSE)) ((0 YOU (NIL EMOTION) 0) (NIL) (WHAT ELSE DO YOU 3) (TELL ME MORE ABOUT 4 %.) (WHY
 DO YOU 3 4) (I DOUBT THAT YOU REALLY 3 4 %.)) ((0 YOU 1 O) (NIL) (YOU SAY 2 3 4) (CAN YOU ELABORATE 
ON THAT) (DO YOU SAY 2 3 4 FOR SOME SPECIAL REASON) (TELL ME MORE ABOUT YOURSELF) (OH? 2 3 4) (THAT'S 
QUITE INTERESTING %.))))
(PUTPROPS YOU RULES (((0 I REMIND YOU OF 0) (NIL) DIT) ((0 I ARE 0) (NIL) (WHAT MAKES YOU THINK I AM 4
) (DOES IT PLEASE YOU TO BELIEVE I AM 4) (PERHAPS YOU WOULD LIKE TO BE 4 %.) (DO YOU SOMETIMES WISH 
YOU WERE 4)) ((0 I 0 YOU) (NIL) (WHY DO YOU THINK I 3 YOU) (YOU LIKE TO THINK I 3 YOU - DON'T YOU) (
WHAT MAKES YOU THINK I 3 YOU) (REALLY? I 3 YOU) (DO YOU WISH TO BELIEVE I 3 YOU) (SUPPOSE I DID 3 YOU 
- WHAT WOULD THAT MEAN) (DOES SOMEONE ELSE BELIEVE I 3 YOU)) ((0 I 1 0) (NIL) (SUPPOSE YOU 3 4 %.) (
OH? I 3 4) (WHAT MAKES YOU THINK I 3 4) (WHO ARE YOU REALLY TALKING ABOUT))))
(PUTPROPS XXYYZZ RULES (((0) (NIL) (IS THERE SOMETHING BOTHERING YOU) (CAN YOU BE MORE INFORMATIVE) (
PERHAPS YOU'D RATHER TALK ABOUT SOMETHING ELSE %.) (PLEASE TELL ME MORE %.))))
(PUTPROPS YES RULES (((0) (NIL) XXYYZZ (WHY ARE YOU SO SURE) (I SEE %.) (I UNDERSTAND %.))))
(PUTPROPS NO RULES (((0 NO (BODY ONE) 0) (NIL) NOBODY) ((0) (NIL) XXYYZZ (VERY WELL %.) (WHY NOT) (WHY
 'NO'))))
(PUTPROPS CAN RULES (((CAN I 0) (NIL) (YOU BELIEVE I CAN 3 DON'T YOU) XXWHAT (YOU WANT ME TO BE ABLE 
TO 3 %.) (PERHAPS YOU WOULD LIKE TO BE ABLE TO 3 YOURSELF %.)) ((CAN YOU 0) (NIL) (WHETHER OR NOT YOU 
CAN 3 DEPENDS ON YOU MORE THAN ON ME %.) (DO YOU WANT TO BE ABLE TO 3) (PERHAPS YOU DON'T WANT TO 3 %.
) XXWHAT)))
(PUTPROPS IS RULES (((IS 0) (NIL) XXWHAT) ARE))
(PUTPROPS WHERE RULES (WHAT))
(PUTPROPS WHAT RULES ((((HOW WHERE WHAT WHY) 0) (NIL) XXWHAT)))
(PUTPROPS XXWHAT RULES (((0) (NIL) (WHY DO YOU ASK) (WHY DOES THAT QUESTION INTEREST YOU) (WHY ARE 
SUCH QUESTIONS ON YOUR MIND) (WHAT ANSWER WOULD PLEASE YOU MOST) (WHAT DO YOU THINK) (WHEN HAVE YOU 
ASKED SUCH QUESTIONS BEFORE) (WHO ELSE HAVE YOU ASKED))))
(PUTPROPS BECAUSE RULES (((0) (NIL) (IS THAT THE REAL REASON) (I SEE %.) (DON'T ANY OTHER REASONS COME
 TO MIND) (DOES THAT REASON SEEM TO EXPLAIN ANYTHING ELSE) (AND WHAT DOES THAT SUGGEST) (WHAT OTHER 
REASONS MIGHT THERE BE))))
(PUTPROPS WHY RULES (((0 WHY (DON'T WON'T) I 0) (NIL) (DO YOU BELIEVE I DON'T 5) (PERHAPS I WILL 5 IN 
GOOD TIME %.) (SHOULD YOU 5 YOURSELF) (YOU WANT ME TO 5 %.) WHAT) ((0 WHY CAN'T YOU 0) (NIL) (DO YOU 
THINK YOU SHOULD BE ABLE TO 5) (DO YOU WANT TO BE ABLE TO 5) (DO YOU BELIEVE THIS WILL HELP YOU TO 5) 
(HAVE YOU ANY IDEA WHY YOU CAN'T 5) WHAT) WHAT))
(PUTPROPS EVERYONE RULES (((0) (NIL) (CAN YOU THINK OF ANYONE IN PARTICULAR) (WHO "," FOR EXAMPLE) (
YOU ARE THINKING OF A VERY SPECIAL PERSON %.) (YOU HAVE A PARTICULAR PERSON IN MIND "," DON'T YOU))))
(PUTPROPS EVERYBODY RULES (EVERYONE))
(PUTPROPS NOBODY RULES (((0) (NIL) (SURELY SOMEONE "...") (PERHAPS YOU JUST DON'T KNOW OF ANYONE %.)))
)
(PUTPROPS NOONE RULES (NOBODY))
(PUTPROPS ALWAYS RULES (((0) (NIL) (CAN YOU THINK OF A SPECIFIC EXAMPLE) (WHEN) (WHAT INCIDENT ARE YOU
 THINKING OF) (REALLY "," ALWAYS))))
(PUTPROPS LIKE RULES (((0 (AM IS ARE WAS) 0 LIKE 0) (NIL) DIT)))
(PUTPROPS DIT RULES (((0) (NIL) (IN WHAT WAY) (WHAT RESEMBLANCE DO YOU SEE) (WHAT DOES THAT SIMILARITY
 SUGGEST TO YOU) (WHAT OTHER CONNECTIONS DO YOU SEE) (WHAT IS THE CONNECTION "," DO YOU SUPPOSE) (HOW)
)))
(PUTPROPS OH RULES (((0 YOUR OH YOUR 0) (NIL) (PRE (1 MY-OH-MY 5) NEWKEY)) ((0 OH YOUR 0) (NIL) (PRE (
1 OH-MY 4) NEWKEY))))
(PUTPROPS EVERY RULES (((0 EVERY (ONE BODY) 0) (NIL) EVERYONE) ((0 EVERY TIME 0) (NIL) ALWAYS)))
(PUTPROPS DO RULES (((DO I 0) (NIL) (PRE (I 3) YOU) XXWHAT) ((DO YOU 0) (NIL) (PRE (YOU 3) I) XXWHAT))
)
(PUTPROPS GIRLS RULES (((0 (GIRLS WOMEN) 0) (NIL) (PRE (1 2 S 3) BOY))))
(PUTPROPS WOMEN RULES (GIRLS))
(PUTPROPS BOY RULES (((0 (NIL PERSON) FRIEND 0) (NIL) (I WOULD LIKE TO MEET YOUR 2 FRIEND %.) (PRE (1 
FRIEND 4) FRIEND) (SUPPOSE THE FRIEND WERE NOT A 2 %.)) ((0 (NIL PERSON) 0) (NIL) (WHY DO YOU SAY A 2)
 (WHAT 2 ARE YOU THINKING OF) NEWKEY) ((0 (NIL PERSON) S 0) (NIL) (WHAT GROUP OF 2 ARE YOU THINKING OF
) (I EXPECTED THAT YOU WOULD WANT TO TALK ABOUT 2 %.) (DO YOU KNOW MANY 2))))
(PUTPROPS GIRL RULES (BOY))
(PUTPROPS MAN RULES (BOY))
(PUTPROPS WOMAN RULES (BOY))
(PUTPROPS SEXY RULES (SEX))
(PUTPROPS SEXUAL RULES (SEX))
(PUTPROPS SEX RULES (((0 YOU 0 SEX 0) (NIL) (ARE YOU SURE YOU REALLY 3 IT 5) (DO YOU REALLY WANT TO 
DISCUSS SEX) (PERHAPS YOU ARE WORRIED THAT YOU 3 IT 5) NEWKEY) ((0) (NIL) (WHAT ARE YOUR REAL FEELINGS
 ABOUT SEX) (DO YOU EVER DREAM ABOUT SEX) (WHY DO YOU MENTION SEX) (COULD SEX BE PART OF YOUR PROBLEM)
 NEWKEY)))
(PUTPROPS FRIENDLY RULES (FRIEND))
(PUTPROPS FRIEND RULES (((0 YOUR FRIEND 0) (NIL) (WHAT ELSE CAN YOU TELL ME ABOUT YOUR FRIEND) (WHAT 
MIGHT YOUR FRIENDS HAVE TO DO WITH YOUR PROBLEM)) ((0) (NIL) (DO YOU THINK FRIENDS ARE IMPORTANT) (
WHAT DO YOU THINK ABOUT YOUR FRIENDS))))
(PUTPROPS CRY RULES (LAUGH))
(PUTPROPS LAUGH RULES (((0 (LAUGH CRY) 0) (NIL) (WHAT WOULD MAKE YOU 2) (REALLY 2) (WOULD YOU LIKE TO 
LAUGH) NEWKEY)))
(PUTPROPS DONT TRANSLATION DON'T)
(PUTPROPS CANT TRANSLATION CAN'T)
(PUTPROPS WONT TRANSLATION WON'T)
(PUTPROPS DREAMED TRANSLATION DREAMT)
(PUTPROPS DREAMS TRANSLATION DREAM)
(PUTPROPS MY TRANSLATION YOUR)
(PUTPROPS AM TRANSLATION ARE)
(PUTPROPS YOUR TRANSLATION MY)
(PUTPROPS WERE TRANSLATION WAS)
(PUTPROPS ME TRANSLATION YOU)
(PUTPROPS YOU'RE TRANSLATION I'M)
(PUTPROPS I'M TRANSLATION YOU'RE)
(PUTPROPS MYSELF TRANSLATION YOURSELF)
(PUTPROPS YOURSELF TRANSLATION MYSELF)
(PUTPROPS MOM TRANSLATION MOTHER)
(PUTPROPS DAD TRANSLATION FATHER)
(PUTPROPS I TRANSLATION YOU)
(PUTPROPS YOU TRANSLATION I)
(PUTPROPS FEEL BELIEF T)
(PUTPROPS THINK BELIEF T)
(PUTPROPS BELIEVE BELIEF T)
(PUTPROPS WISH BELIEF T)
(PUTPROPS MY MEMR (((YOUR 2 0) (NIL) (LETS DISCUSS FURTHER WHY YOUR 2 3 %.) (EARLIER YOU SAID YOUR 2 3
 %.) (BUT YOUR 2 3 %.) (DOES THAT HAVE ANYTHING TO DO WITH THE FACT THAT YOUR 2 3)) ((0 YOUR 1) (NIL) 
(WOULD YOU LIKE TO DISCUSS YOUR 3) (PERHAPS THAT CONCERNS YOUR 3 %.) (TELL ME MORE ABOUT YOUR 3 %.))))
(PUTPROPS I MEMR (((0 YOU ARE 0) (NIL) (ARE YOU STILL 4) (EARLIER YOU SAID YOU WERE 4 %.) (MAYBE NOW 
WE CAN DISCUSS WHY YOU ARE 4 %.) (DID YOU TELL ME YOU WERE 4))))
(PUTPROPS SEX MEMR (((0 YOU 0 SEX 0) (NIL) (EARLIER YOU SAID YOU 3 4 5 %.) (TELL ME AGAIN WHY YOU 3 4 
5 %.) (DO YOU SAY THAT BECAUSE YOU 3 4 5))))
(PUTPROPS LIKE EMOTION T)
(PUTPROPS LOVE EMOTION T)
(PUTPROPS HATE EMOTION T)
(PUTPROPS DISLIKE EMOTION NIL)
(PUTPROPS NONE LASTRESORT (RULES (((0) (NIL) (I AM NOT SURE I UNDERSTAND YOU FULLY %.) (PLEASE GO ON %.
) (WHAT DOES THAT SUGGEST TO YOU) (WHAT ELSE WOULD YOU LIKE TO DISCUSS) (WHY DO YOU SAY THAT JUST NOW)
))))
(PUTPROPS MOTHER FAMILY T)
(PUTPROPS MOM FAMILY T)
(PUTPROPS DAD FAMILY T)
(PUTPROPS FATHER FAMILY T)
(PUTPROPS SISTER FAMILY T)
(PUTPROPS BROTHER FAMILY T)
(PUTPROPS WIFE FAMILY T)
(PUTPROPS CHILDREN FAMILY T)
(PUTPROPS BOY PERSON T)
(PUTPROPS GIRL PERSON T)
(PUTPROPS MAN PERSON T)
(PUTPROPS WOMAN PERSON T)
(PUTPROPS DOCTOR COPYRIGHT (NONE))
NIL
