(FILECREATED "10-OCT-78 15:56:22" ("compiled on " <LISPUSERS>TIME.;10) (2 . 2))
(FILECREATED "10-OCT-78 15:56:04" <LISPUSERS>TIME.;10 6949 changes to: TIMEPRINT1 
previous date: "28-SEP-78 02:09:54" <LISPUSERS>TIME.;9)
(ADDTOVAR NOSWAPFNS INSTRS)

TIMEPRINT MAXC
        w   -.           w-.      ø    z-.     zZ` ,<  [` ,<  @  { @ ,~   Z` 2B   5   Z` 2B   5   ,<     ~Z   ,~   2B   5   ,<     ~,<  ,<     ÿ,< ,<` ,<    ,< ,<    Z   XB` 5   Z` ,<  ,< ,<` ,  ,3B   5   Z   XB` Z` ,<  [` XB` ,\  5   Z` ,<  [` XB` ,\  5   M` 0L   5   Z` ,<  ,< ,<` ,  ,3B   5   &Z   XB` 5   )Z` ,<  [` XB` ,\  5   Z` ,<  [` XB` ,\  5   Z   ,<  ,<   ,<   ZwL  1L   5   °5   ¶Z  XBp  [p  Zwý3B  5   45   5Zp  5   7[wXBw5   .Zwÿ/  ,<  ,<wþZ   -.  Pfy`  ,<  ,<   Zwÿ3B   5   A[wÿ[  [  Z  XBp  [wÿ[  Z  XBwÿZw2B   5   ÃZ   5    Zwÿ3B   5   Ç,<  ,<wþ "  ,   XBw    1B  5   [Zw-,   5   U w,>  ö,>     Ç   ,^  /  &     0B   5   U w,>  ö,>     L   ,^  /  &  ,   5   ÚZw,   ,>  ö,>  Z  Ñ,      ,^  /    ,   XBwZwZ$   ,   3B   5   ^5   Â,<w~,<   ,<    Zwþ3B   5   ã,<  ,<     ÿ5   e,< ,<    ZwL  0L   5   î,       "   3b  5   l,< ,<wþ,<    5   ð,< ,<wþ,<    5   ð,< ,<  ,<    ,< ,<    Zp  2B   5   tZwý,<  ,<     ÿZ   5      B	"ìR*%H @  % (@DNDN4D       (VARIABLE-VALUE-CELL PAIRS . 88)
(FILE . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL PAIRS . 0)
(VARIABLE-VALUE-CELL BRKDWNTYPES . 113)
(VARIABLE-VALUE-CELL CNT . 174)
*TIMEPRINT*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL PAIRS . 0)
(VARIABLE-VALUE-CELL CNT . 0)
(0 . 1)
((INSTRS TIME REALTIME GCTIME LOADAV) . 0)
"Speed: "
((CONSES BOXES FBOXES PAGEFAULTS) . 0)
"Space: "
(NIL)
(LINKED-FN-CALL . TERPRI)
"load av="
(NIL)
(LINKED-FN-CALL . PRIN1)
((FLOAT . 553668800) . 0)
(NIL)
(LINKED-FN-CALL . PRINTNUM)
1
(NIL)
(LINKED-FN-CALL . SPACES)
37
(NIL)
(LINKED-FN-CALL . TAB)
7
((FLOAT . 553656704) . 0)
((FLOAT . 553668800) . 0)
((FIX . 10739777546) . 0)
(FLOATT EQP ASZ MKFN FUNBOX MKN SKI EVCC URET6 BHC LISTT KNIL KT BINDB BLKENT 
ENTERF)  p   P   H   0     Ø 
h   
P   	(   x   p D    Z 
@ Î       !    ó  ß X E 8 Â H » h . X ¤   X  (   h õ   ð ` ë P c    8     8 	               
PDP10INSTR MAXC
               -.            Z  Z 7@  7   Z  2B   5   B  ,   ,~   Z"   ,~      BYTELISPFLG
(ASZ MKN KT KNOB ENTER0)                     
TIME MBYTE
               d  ` vv}_(FORM . CNT)
(INSTRS)
()  

INSTRS MAXC
    D    >    B-.           >,<   ,<   Z` 2B   5   Z"  XB` ,   5   ,   ,>  ½,>  ,>  ,>  ,>  ,>  ,>  ,>  ,>  ,>     ?,    B|   ¿,    Bü     B}     Bý     B~    Bþ "ý   /    BB  /    Bÿ x  4b  ,<` "  @XBp  >`x  5   B  /   /Bÿ "ý   /   /B   /Bþ    /B~    /Bý    /B}   ¿,   /Bü   ?,   /B|Z  À $   ÿZ  Z    F   [   Z  Z    F   [   þZ  Z    F   [   ~Z  Z    F   [   ýZ  Z    F   [   }Z  Z    F   [   üZ  Z    F   [   |Z  Z    F   [  /  ,<  ,<   ,<`    A,   F  ÁZp  5      E   @ @     
   (FORM . 1)
(CNT . 1)
CONSCOUNT
PAGEFAULTS
EVAL
(((1000000 . INSTRS) (1000000 . TIME) (1000000 . REALTIME) (1000000 . BOXES) (
1000000 . FBOXES) (1000000 . GCTIME) (1000000 . PAGEFAULTS) (1000000 . CONSES)) . 0
)
LOADAV
LISPXTIMEPRINT
(URET2 CONSS1 KT BHC GCINST IBOXCN FBOXCN GCTIM IUNBOX ASZ KNIL ENTER2) `   H   0       0               ! P  x   @ ¢ h   p           0        
(PRETTYCOMPRINT TIMECOMS)
(RPAQQ TIMECOMS ((DECLARE: FIRST (ADDVARS (NOSWAPFNS INSTRS))) (P (MOVD (QUOTE 
USERLISPXPRINT) (QUOTE LISPXTIMEPRINT))) (LOCALVARS . T) (FNS PDP10INSTR INSTRS 
TIME TIMEPRINT TIMEPRINT1) (BLOCKS (TIMEPRINT TIMEPRINT TIMEPRINT1 (LOCALFREEVARS 
PAIRS CNT) (GLOBALVARS BRKDWNTYPES) (NOLINKFNS EVAL)) (NIL PDP10INSTR TIME INSTRS (
LOCALVARS . T))) (DECLARE: EVAL@COMPILE (PROP OPD RICTR) (PROP MACRO PDP10INSTR 
DOTIMING) (ALISTS (BRKDWNTYPES INSTRS GCTIME REALTIME TIME CONSES PAGEFAULTS BOXES 
FBOXES))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (
NLAMA) (NLAML TIME) (LAMA))) (PROP ARGNAMES DOTIMING)))
(MOVD (QUOTE USERLISPXPRINT) (QUOTE LISPXTIMEPRINT))
(PUTPROPS RICTR OPD 261120)
(PUTPROPS PDP10INSTR MACRO (X (COND (BYTELISPFLG (QUOTE (LOC (ASSEMBLE NIL (RICTR 1
 , 7) (SUB 1 , GCINST))))) (T 0))))
(PUTPROPS DOTIMING MACRO (X (PROG ((TYPELST (CADDR X)) FN NN I) (SETQ I (
IDIFFERENCE -1 (SETQ NN (LENGTH TYPELST)))) (RETURN (NCONC (LIST (QUOTE ASSEMBLE) 
NIL (LIST (QUOTE CQ) (LIST (QUOTE VAG) (LIST (QUOTE FIX) (CADR X)))) (CONS (QUOTE 
PUSHNN) (CONS (QUOTE (1)) (MAPCAR TYPELST (FUNCTION (LAMBDA (TYPE) (QUOTE (1)))))))
) (MAPCONC TYPELST (FUNCTION (LAMBDA (TYPE) (LIST (LIST (QUOTE CQ) (LIST (QUOTE VAG
) (LIST (QUOTE FIX) (CADR (ASSOC TYPE BRKDWNTYPES))))) (LIST (QUOTE NREF) (LIST (
QUOTE MOVEM) 1 (QUOTE ,) (SETQ I (ADD1 I)))))))) (APPEND (QUOTE ((NREF (MOVE 1 , 0)
) (JUMPLE 1 , DONE) LP)) (LIST (LIST (QUOTE CQ) (CAR X))) (QUOTE ((NREF (SOSLE 0)) 
(JRST LP) DONE)) NIL) (MAPCONC (SETQ TYPELST (REVERSE TYPELST)) (FUNCTION (LAMBDA (
TYPE) (LIST (LIST (QUOTE CQ) (LIST (QUOTE VAG) (LIST (QUOTE FIX) (CADR (ASSOC TYPE 
BRKDWNTYPES))))) (LIST (QUOTE NREF) (LIST (QUOTE SUBM) 1 (QUOTE ,) (PROG1 I (SETQ I
 (SUB1 I))))))))) (LIST (LIST (QUOTE CQ) (KWOTE (MAPCAR TYPELST (FUNCTION (LAMBDA (
TYPE) (CONS (IPLUS 1000000) TYPE)))))) (QUOTE (MOVEI 2 , 0 (1)))) (PROGN (SETQ I 0)
 (MAPCONC TYPELST (FUNCTION (LAMBDA (TYPE) (LIST (LIST (QUOTE NREF) (LIST (QUOTE 
MOVE) 3 (QUOTE ,) (SETQ I (SUB1 I)))) (QUOTE (HRRZ 4 , 0 (2))) (QUOTE (HRRZ 4 , 0 (
4))) (QUOTE (MOVEM 3 , 0 (4))) (QUOTE (HLRZ 2 , 0 (2)))))))) (LIST (LIST (QUOTE 
POPNN) (ADD1 NN))))))))
(ADDTOVAR BRKDWNTYPES (INSTRS (PDP10INSTR) (LAMBDA (X) (FQUOTIENT X 1000)) 
"K PDP10 instrs") (GCTIME (LOC (ASSEMBLE NIL (MOVE 1 , GCTIM))) (LAMBDA (X) (
FQUOTIENT X 1000)) "gc time") (REALTIME (LOC (ASSEMBLE NIL (JSYS 12))) (LAMBDA (X) 
(FQUOTIENT X 1000)) "real seconds") (TIME (CPUTIME) (LAMBDA (X) (FQUOTIENT X 1000))
 "CPU seconds") (CONSES (CONSCOUNT) NIL "conses") (PAGEFAULTS (PAGEFAULTS) NIL 
"page faults") (BOXES (IBOXCOUNT) NIL "large integers") (FBOXES (FBOXCOUNT) NIL 
"floating numbers"))
(PUTPROPS DOTIMING ARGNAMES (FORM REPEATCOUNT TIMETYPES))
NIL
   