(FILECREATED "16-Aug-84 00:22:33" ("compiled on " <NEWLISP>BRKDWN..160) (2 . 2) bcompl'd in 
"INTERLISP-10  14-Aug-84 ..." dated "14-Aug-84 00:36:23")
(FILECREATED "14-Aug-84 19:27:15" {ERIS}<LISPCORE>SOURCES>BRKDWN.;5 19006 changes to: (FNS BREAKDOWN) 
previous date: "13-Aug-84 11:58:48" {ERIS}<LISPCORE>SOURCES>BRKDWN.;4)
(ADDTOVAR NOSWAPFNS BRKDWN2)

BRKDWNTIME BINARY
            -.     (      "}   /   Z   *  /  Z   .b  ^"Z` .b  Z  XB` Z` XB  ,<`    XB` Z` 1B   +   >` +   	Z  ,<  Z` XB  ,\   XB`  "}   /   Z  *  /  Z` .b  Z` ,~          (BDEXP . 1)
(BDX . 1)
(BDN . 1)
(BDY . 1)
(BDZ . 1)
(VARIABLE-VALUE-CELL BDLST . 35)
(VARIABLE-VALUE-CELL BDPTR . 29)
(NIL)
(LINKED-FN-CALL . EVAL)
(ASZ GCTIM ENTER5) @            

BRKDWNCONSES BINARY
              -.     (        ,   Z   *  /  Z   .b  ^"Z` .b  Z  XB` Z` XB  ,<`    XB` Z` 1B   +   >` +   Z  ,<  Z` XB  ,\   XB`    ,   Z  *  /  Z` .b  Z` ,~    (     (BDEXP . 1)
(BDX . 1)
(BDN . 1)
(BDY . 1)
(BDZ . 1)
(VARIABLE-VALUE-CELL BDLST . 33)
(VARIABLE-VALUE-CELL BDPTR . 28)
(NIL)
(LINKED-FN-CALL . CONSCOUNT)
(NIL)
(LINKED-FN-CALL . EVAL)
(ASZ IUNBOX ENTER5)   8           

BRKDWNBOXES BINARY
               -.     (         Z   *  /  Z   .b  ^"Z` .b  Z  XB` Z` XB  ,<`    XB` Z` 1B   +   >` +   Z  ,<  Z` XB  ,\   XB`     Z  *  /  Z` .b  Z` ,~    P      (BDEXP . 1)
(BDX . 1)
(BDN . 1)
(BDY . 1)
(BDZ . 1)
(VARIABLE-VALUE-CELL BDLST . 31)
(VARIABLE-VALUE-CELL BDPTR . 27)
(NIL)
(LINKED-FN-CALL . EVAL)
(ASZ IBOXCN ENTER5)         (      

BREAKDOWN BINARY
      W      M-.         -.    (   #,<p   #XBp    $Z   ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   $Zw,<   Zp  b %,<   ,<p   &3B   +   [p  [  Z  Z  3B '+   Zp  3B   +   Zp  [w[  [  Z  ,   3B   +   Zw,<   ,<w} '2B   +   7   Z   +   Z   /  3B   +   "ZwZp  ,   XBp  [wXBw+   /  XB  Z   3B   +   ', ,< ( )Z   ,<       ."   ,   d *Z   XB   Zp  3B   +   N,< +,<wZp  -,   +   0+   MZp  ,<   Zp  -,   +   4XBw+   K,<   ,<   ,<   ,< ' +,<   Zp  -,   +   9+   KZp  ,<   Zp  -,   +   >,<   ,<   ,<    ,+   IZ  $,<  ,<   ,<   b %,<      )."   ,   ,<      A."   ,   d -."  ,<   ,<w{,  d,   ,   d .XB  >/   [p  XBp  +   7/   /   [p  XBp  +   ./  Z  H,<   Zp  -,   +   Q+   WZp  ,<   [p  Z  ,<      C."   ,   d */   [p  XBp  +   O/   Z  N,<   ,<   Zw-,   +   `Zp  Z   2B   +   ^ "  +   _[  QD   "  +    ZwZ  Zp  ,   XBp  [wXBw+   Y[w[  Z  ,<   ,<w,<w,   ,<   Z   3B   +  
,< /,<    0,< /Zw},<   [w}Z  ,<   ,< 1[   [  [  ,<   ,< 1Z   ,<   ,< 2,< 2Zwz1B   +   w,< 3,<   [wzZ  ,   +   x[w{Z  ,   ,<   Zwz3B   +   ~3B   +   ~-,   +   ~,< 3,<   ,   ,<   , U,   ,   ,   ,<   , u,<w},< / %d 0,< /,<    0,<p  ,<w} %,   d .,<p  Zw},   d .+  [w,<   ,<w 4Zp  +    Z  %-,   +  ,   ,<   ,<   ,<   ,<   Z 5Zw~,   b 5XBp  b %2B   +  ,<p  ,< 6Z  n,<   ,< 7,<w|,< 7[ Z  ,<   , U,   ,<   , u,< ',<w %,<   ,<    0,<w~ 8XBw,   ,> ,>      S    ,^   /   3b  +  DZ  X,<   Zp  -,   +  (+  DZp  ,<    w~."   ,   ,<    w}."   ,   d -."  ,<   [w[  [  3B   +  ;,<wZw,<   Zw~,<   [w~[  [  [  Z  d 0,<   ,<w~[w}[  Z  ,<   ,  dd 4+  @Zwb %[  [  Z  [  [  ,<   ,<w 9[w,<   ,<w 9/  [p  XBp  +  &/   ,<w~ :XB  qb 8XB "Z Eb :Z   ,   XB     F."   ,   ,<     I."   ,   d -."  XB  (  K."   ,   ,<     N."   ,   d -."  XB  +Z   XB Z   +    Z   ,   ,<   Z   ,   ,<   ,< +,<w}Zp  -,   +  [+  nZp  ,<   ,<p  Z   d ;[  Z  ,<   Zp  2B   +  b,<w,< <$ <,<w},< =,< =,< >,<w|,<w}^"  ,   d >,<w~,< =,< ?,< >,<w|,<w}^"  ,   d >:w~/  [p  XBp  +  Y/   ,< @Z @Zw~,   ,<   Z @Zw~,   ,<   ,<w|,<w|^"  ,   +    Z   ,<   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   ,<  @ @  +  Z   ,<   @ A  ,~   Z   ,<   ,< B,< C,<   @ C ` +  Z   Z EXB Z   3B   +  Z   ,<  d E+  	Z ,<   @ F  0+  Zw,<?,<8  ,<    J,~   Zw~XB8 Z   ,~   3B   +  Z   +  Z KXB` d KZ` 3B   +    L,~   Z` ,~   +       P"D%@"H@A(Fa "B"@  +^JB	*(M    	H @ #8.X@  $Q!i@                 (FNS . 1)
(VARIABLE-VALUE-CELL BRKDWNLST . 331)
(VARIABLE-VALUE-CELL BRKDWNTYPE . 424)
(VARIABLE-VALUE-CELL BDLST . 412)
(VARIABLE-VALUE-CELL BRKDWNLENGTH . 417)
(VARIABLE-VALUE-CELL BDSINK . 422)
(VARIABLE-VALUE-CELL BDPTR . 87)
(VARIABLE-VALUE-CELL BRKDWNCOMPFLG . 208)
(VARIABLE-VALUE-CELL BRKDWNARGS . 306)
(VARIABLE-VALUE-CELL BRKDWNLABELS . 398)
(VARIABLE-VALUE-CELL BRKDWNTOTLST . 402)
(VARIABLE-VALUE-CELL BRKDWNTYPES . 442)
(VARIABLE-VALUE-CELL NLAMA . 491)
(VARIABLE-VALUE-CELL NLAML . 493)
(VARIABLE-VALUE-CELL LAMS . 495)
(VARIABLE-VALUE-CELL LAMA . 497)
(VARIABLE-VALUE-CELL NOFIXFNSLST . 499)
(VARIABLE-VALUE-CELL NOFIXVARSLST . 501)
(VARIABLE-VALUE-CELL LISPXHIST . 506)
(VARIABLE-VALUE-CELL RESETVARSLST . 511)
(VARIABLE-VALUE-CELL LOCALVARS . 522)
(VARIABLE-VALUE-CELL SYSLOCALVARS . 529)
(NIL)
(LINKED-FN-CALL . NLAMBDA.ARGS)
(NIL)
(LINKED-FN-CALL . BRKDWNINIT)
(NIL)
(LINKED-FN-CALL . GETD)
(NIL)
(LINKED-FN-CALL . EXPRP)
BRKDWN2
(NIL)
(LINKED-FN-CALL . MEMB)
0
(NIL)
(LINKED-FN-CALL . CONSCOUNT)
(NIL)
(LINKED-FN-CALL . BRKDWNCLEAR)
1
(NIL)
(LINKED-FN-CALL . BREAK0)
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . ARRAY)
(NIL)
(LINKED-FN-CALL . NCONC)
BRKDWNFN
(NIL)
(LINKED-FN-CALL . PUTD)
PROG
RETURN
SETQ
BDY
RPTQ
QUOTE
(NIL)
(LINKED-FN-CALL . RPLACD)
BRKDWN
(NIL)
(LINKED-FN-CALL . PACK)
NLAMBDA
((DECLARE (LOCALVARS . T)) . 0)
((PROG NIL BDLP (SETQ BDY (EVAL BDEXP)) (COND ((NEQ BDN 1) (SUB1VAR BDN) (GO BDLP)))) . 0)
(NIL)
(LINKED-FN-CALL . LENGTH)
(NIL)
(LINKED-FN-CALL . RPLACA)
(NIL)
(LINKED-FN-CALL . APPEND)
(NIL)
(LINKED-FN-CALL . ASSOC)
"not found"
HELP
BRKDWNINCA
BDPTR
BDLST
(NIL)
(LINKED-FN-CALL . TCONC)
BDZ
BRKDWNMACRO
PROGN
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL)
(LINKED-FN-CALL . UNION)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(NIL VARIABLE-VALUE-CELL LCFIL . 0)
(NIL VARIABLE-VALUE-CELL LAPFLG . 0)
(T VARIABLE-VALUE-CELL STRF . 0)
(NIL VARIABLE-VALUE-CELL SVFLG . 0)
(T VARIABLE-VALUE-CELL LSTFIL . 0)
(T VARIABLE-VALUE-CELL SPECVARS . 0)
(NIL)
(LINKED-FN-CALL . COMPILE1)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(URET2 CF LIST URET4 CONS21 IUNBOX ALIST4 CONS URET6 ALIST2 SKNNM ALIST3 ASZ LIST2 URET3 CONSNL CONSS1
 SKLST SKNM MKN COLLCT BHC KT EQP SKNLST KNIL BLKENT ENTER1)   #     H   Xk p   `          @   0q 8   `        }     y x   H   p h    `   X p   	   	    8   0   (P XK X+ 
X E 0 +    b (   pm PC P X 
h N 	H L 	  %     "   h @ = P 5 `      0( p [ 
 8       "   (a  V XT 1 X  X { 0 i P \   6 X &   h      
             

BRKDWNRESULTS BINARY
    e   B   ^-.          B-.     0B   E,<   ,< E,< F FZ   ,<   Zp  -,   +   +   ,<   ,<p  ,< F G/   [p  XBp  +   /   Z   ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   Zp  ,   ,<   [wZ  ,<   [w[  Z  ,<   ,  s/   Zp  ,   XBp  [wXBw+   /  XBwZw3B   +   "Zw+    Z   b H,<   @ I   +   r,< KZ   ,<   ,   ,   Z   ,   XB  'XB` ,< L,< L,<   @ M ` +   iZ   Z NXB Z   ,<   Zp  -,   +   1Z   +   fZp  ,<   ,<    O[  ,<   Zw~ 8      ,\   5d  9    Z   ,   +   :[  2B   =d  9Z  ,<   ,<wZ   d P[  [  Z  ,<   ,< Q,<    Q,<w,<    Q,< R,<   ,<    S,< T,<    Q,< T,<   ,<    S,< U,<    Q,< U,<   ,<    S,< V,<    QZw},<?Zp  -,   +   O+   _Zp  ,<   Zp  ,<   [w[  ,<   Zw{ 8      ,\   5d  X    Z   ,   +   Y[  2B   =d  WZ  ,<   [wZ  ,<   ,<w},<w}, /   [p  XBp  +   M/   ,< V,<wZ  3,<   ,<w~,<w~, /  Zw~:8  /   [p  XBp  +   //   ZwXB8 Z   ,~   2B   +   kZ WXB   [` XB  (,< KZ` Z  [  d WZ  j3B   +   q  X,~   Z` ,~   Z   +    Z  `,<   ,<w~,< F,<   ,<w},<wZw,> @,>    p  .Bx  ,^   /      ,   /  ,   "   ,   XBp  ,<w~Zw~,<   Zw}1B   +  Zw~0B   +  Zw+  Zw,   ,> @,>   Zw},       ,^   /     ,   d Yd G[w-,   +  [wXBw,<   ,<w G+  ,<wZw,   XBw~d Z[w~XBw~3B   +  :w+   uZw}+    Zp  3B   +  ,<   ,<w~ "   ,   +  Zw~,<   ,<w},<   ,<    [,< \,<   ,<    S,<p  ,<   ,<    [,< ],<   ,<    S,<w~,<   ,<    [,< ],<   ,<    SZp  ,   ,> @,>   Zw~,       ,^   /     ,   ,<   ,<   ,<    [,< ^,<   ,<    SZw}3B V+  >  A,> @,>     A,> @,>   Zw~,   ,> @,>   Zw,       ,^   /     Bx  ,^   /   Bx  ,^   /   ,   ,   ,<   ,<   ,<    [,<    OZ   +           !y   pfD "0T
"!Y3!@D`  R dE2 ev              (RETURNVALUESFLG . 1)
(VARIABLE-VALUE-CELL BRKDWNTOTLST . 230)
(VARIABLE-VALUE-CELL BRKDWNLST . 25)
(VARIABLE-VALUE-CELL BRKDWNFLTFMT . 68)
(VARIABLE-VALUE-CELL RESETVARSLST . 215)
(VARIABLE-VALUE-CELL BRKDWNLABELS . 92)
(VARIABLE-VALUE-CELL BRKDWNTYPES . 120)
1
0
(NIL)
(LINKED-FN-CALL . CONSCOUNT)
(NIL)
(LINKED-FN-CALL . RPLACA)
(NIL)
(LINKED-FN-CALL . FLTFMT)
(VARIABLE-VALUE-CELL OLDVALUE . 75)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 221)
FLTFMT
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL)
(LINKED-FN-CALL . LISPXTERPRI)
(NIL)
(LINKED-FN-CALL . ASSOC)
"FUNCTIONS     "
(NIL)
(LINKED-FN-CALL . LISPXPRIN1)
23
(NIL)
(LINKED-FN-CALL . LISPXTAB)
"# CALLS"
33
"PER CALL"
46
"%%
"
TOTAL
ERROR
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL)
(LINKED-FN-CALL . ERROR!)
(NIL)
(LINKED-FN-CALL . PLUS)
(NIL)
(LINKED-FN-CALL . RPLACD)
(NIL)
(LINKED-FN-CALL . LISPXPRIN2)
14
26
34
45
(URET6 FLTFX EVCC URET7 SKLST MKFN FUNBOX ASZ IUNBOX MKN KT CF CONS LIST2 URET3 COLLCT CONSNL BHC 
SKNLST KNIL BLKENT ENTER1)     H      P   0   8	   7 P) p H         |   = X {   ? h> p- H% 8#  p 8  L 	0 I x E @ B  3    -    W  )    '    s (   P     ( p   @: *   | ( g X d   ^ x  P     O    x   . P! P ( v 0 p   Y 
p J p C ( 8  +      @    (      

BRKDWNINIT BINARY
              -.            Z   3B   +   Z   ,~   Z   Z"   XB   ,<  ,<  $  ."  XB   ,<  ,<  $  ."  XB   XB  ,~     (VARIABLE-VALUE-CELL BDPTR . 21)
(VARIABLE-VALUE-CELL BRKDWNLENGTH . 10)
(VARIABLE-VALUE-CELL BDLST . 15)
(VARIABLE-VALUE-CELL BDSINK . 20)
1
ARRAY
(ASZ KT KNIL ENTER0)   X    P    @        

BRKDWNFBOXES BINARY
              -.     (         Z   *  /  Z   .b  ^"Z` .b  Z  XB` Z` XB  ,<`  "  XB` Z` 1B   +   >` +   Z  ,<  Z` XB  ,\   XB`     Z  *  /  Z` .b  Z` ,~    P      (BDEXP . 1)
(BDX . 1)
(BDN . 1)
(BDY . 1)
(BDZ . 1)
(VARIABLE-VALUE-CELL BDLST . 31)
(VARIABLE-VALUE-CELL BDPTR . 27)
EVAL
(ASZ FBOXCN ENTER5) 0            

RESULTS BINARY
              -.           Z   B  ,~       (VARIABLE-VALUE-CELL RETURNVALUESFLG . 3)
BRKDWNRESULTS
(ENTERF)      

BRKDWNCLEAR BINARY
               -.           Z   ,<   @     ,~   Z   1B   +   >  Z   ,>  ,>      .Bx  ,^   /       ^"    B  +   Z   ,~      	   (VARIABLE-VALUE-CELL PTR . 12)
(VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL I . 15)
(KNIL BHC ASZ ENTERF)      
           
(PRETTYCOMPRINT BRKDWNCOMS)
(RPAQQ BRKDWNCOMS ((DECLARE: FIRST (ADDVARS (NOSWAPFNS BRKDWN2))) (FNS BREAKDOWN BRKDWNINIT 
BRKDWNSETUP BRKDWN1 BRKDWNFORM BRKDWNCOMPILE2 BRKDWNTIME BRKDWNCONSES BRKDWNBOXES BRKDWNFBOXES RESULTS
 BRKDWNRESULTS BRKDWNRESULTS1 BRKDWNRESULTS2 BRKDWNCLEAR) (DECLARE: EVAL@COMPILE (MACROS BRKDWNMACRO 
BRKDWNINCA) (MACROS BRKDWNADDTOA BRKDWNDIFFA CPUTIME IBOXCOUNT FBOXCOUNT BRKDWNELT BRKDWNSETA 
BRKDWNARRAY)) (VARS (BRKDWNLENGTH 0) (BRKDWNCOMPFLG NIL) BRKDWNARGS BRKDWNTYPES (BRKDWNFLTFMT (
NUMFORMATCODE (QUOTE (FLOAT 7 3 NIL NIL 10))))) (VARS (BRKDWNTYPE (QUOTE TIME)) (BRKDWNLABELS) (
BRKDWNLST)) (GLOBALVARS BRKDWNARGS BRKDWNLABELS BRKDWNLENGTH BRKDWNLST BRKDWNTOTLST BDLST BDSINK BDPTR
) (BLOCKS (NIL BRKDWNTIME BRKDWNCONSES BRKDWNBOXES (LINKFNS . T)) (BREAKDOWN BREAKDOWN BRKDWNSETUP 
BRKDWN1 BRKDWNFORM BRKDWNCOMPILE2 (GLOBALVARS NOSWAPFLG)) (BRKDWNRESULTS BRKDWNRESULTS BRKDWNRESULTS1 
BRKDWNRESULTS2)) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA 
BREAKDOWN) (NLAML BRKDWNFBOXES BRKDWNBOXES BRKDWNCONSES BRKDWNTIME) (LAMA)))))
(DECLARE: EVAL@COMPILE (PUTPROPS BRKDWNMACRO MACRO ((FORM1 FORM2 SETFORM PTR) (PROGN FORM1 (
BRKDWNADDTOA PTR 0 -1) (SETQ BDZ BDPTR) (SETQ BDPTR PTR) SETFORM (SETQ BDZ (PROG1 BDPTR (SETQ BDPTR 
BDZ))) FORM2 BDY))) (PUTPROPS BRKDWNINCA MACRO ((PTR LST I VAL) (BRKDWNADDTOA PTR I (BRKDWNDIFFA LST I
 VAL)))))
(DECLARE: EVAL@COMPILE (PUTPROPS BRKDWNADDTOA 10MACRO ((PTR I VAL) (LOC (ASSEMBLE NIL (CQ (VAG (FIX 
VAL))) (C (COND ((AND (LITATOM (QUOTE PTR)) (NUMBERP (QUOTE I))) (QUOTE (ASSEMBLE NIL (CQ2 PTR) (ADDB 
1 , I (2))))) (T (QUOTE (ASSEMBLE NIL (PUSHN) (CQ (VAG (IPLUS I (LOC PTR)))) (MOVE 2 , 1) (POPN 1) (
ADDB 1 , 0 (2))))))))))) (PUTPROPS BRKDWNADDTOA DMACRO ((PTR I VAL) (* BOXIPLUS a little faster) (
\BOXIPLUS (BRKDWNELT PTR I) VAL))) (PUTPROPS BRKDWNADDTOA MACRO (OPENLAMBDA (PTR I VAL) (SETA PTR (
ADD1 I) (IPLUS (ELT PTR (ADD1 I)) VAL)))) (PUTPROPS BRKDWNDIFFA 10MACRO ((PTR I VAL) (LOC (ASSEMBLE 
NIL (CQ (VAG (FIX VAL))) (C (COND ((AND (LITATOM (QUOTE PTR)) (NUMBERP (QUOTE I))) (QUOTE (ASSEMBLE 
NIL (CQ2 PTR) (EXCH 1 , I (2)) (SUB 1 , I (2))))) (T (QUOTE (ASSEMBLE NIL (PUSHN) (CQ (VAG (IPLUS I (
LOC PTR)))) (MOVE 2 , 1) (POPN 1) (EXCH 1 , 0 (2)) (SUB 1 , 0 (2))))))))))) (PUTPROPS BRKDWNDIFFA 
DMACRO (OPENLAMBDA (PTR I VAL) (PROG1 (IDIFFERENCE (BRKDWNELT PTR I) VAL) (BRKDWNSETA PTR I VAL)))) (
PUTPROPS BRKDWNDIFFA MACRO (OPENLAMBDA (PTR I VAL) (IDIFFERENCE (ELT PTR (ADD1 I)) (SETA PTR (ADD1 I) 
VAL)))) (PUTPROPS CPUTIME 10MACRO (NIL (LOC (ASSEMBLE NIL (MOVEI 1 , -5) (JSYS 13) (SUB 1 , GCTIM)))))
 (PUTPROPS CPUTIME MACRO (NIL (CLOCK 2))) (PUTPROPS IBOXCOUNT 10MACRO (NIL (LOC (ASSEMBLE NIL (MOVE 1 
, IBOXCN))))) (PUTPROPS IBOXCOUNT MACRO (NIL (BOXCOUNT))) (PUTPROPS FBOXCOUNT 10MACRO (NIL (LOC (
ASSEMBLE NIL (MOVE 1 , FBOXCN))))) (PUTPROPS FBOXCOUNT MACRO (NIL (BOXCOUNT (QUOTE FLOATP)))) (
PUTPROPS BRKDWNELT 10MACRO (LAMBDA (PTR I) (OPENR (IPLUS (LOC PTR) I)))) (PUTPROPS BRKDWNELT MACRO ((
ARR I) (ELT ARR (ADD1 I)))) (PUTPROPS BRKDWNELT DMACRO (= . ELT)) (PUTPROPS BRKDWNSETA 10MACRO ((PTR I
 VAL) (CLOSER (IPLUS (LOC PTR) I) VAL))) (PUTPROPS BRKDWNSETA DMACRO ((ARR I VAL) (\PUTBASEFIXP (
BRKDWNELT ARR I) 0 VAL))) (PUTPROPS BRKDWNSETA MACRO ((ARR I VAL) (SETA ARR (ADD1 I) VAL))) (PUTPROPS 
BRKDWNARRAY 10MACRO ((N) (VAG (IPLUS (LOC (ARRAY N N)) 2)))) (PUTPROPS BRKDWNARRAY DMACRO ((N) (PROG (
(BLOCK (ARRAY (ADD1 N) (QUOTE POINTER) NIL 0))) (for I from 0 to N do (SETA BLOCK I (NCREATE (QUOTE 
FIXP)))) (RETURN BLOCK)))) (PUTPROPS BRKDWNARRAY MACRO ((N) (ARRAY N N))))
(RPAQQ BRKDWNLENGTH 0)
(RPAQQ BRKDWNCOMPFLG NIL)
(RPAQQ BRKDWNARGS (BDEXP BDX BDN BDY BDZ))
(RPAQQ BRKDWNTYPES ((TIME (CPUTIME) (LAMBDA (X) (FQUOTIENT X 1000))) (CONSES (CONSCOUNT)) (PAGEFAULTS 
(PAGEFAULTS)) (BOXES (IBOXCOUNT)) (FBOXES (FBOXCOUNT))))
(RPAQ BRKDWNFLTFMT (NUMFORMATCODE (QUOTE (FLOAT 7 3 NIL NIL 10))))
(RPAQQ BRKDWNTYPE TIME)
(RPAQQ BRKDWNLABELS NIL)
(RPAQQ BRKDWNLST NIL)
(PUTPROPS BRKDWN COPYRIGHT ("Xerox Corporation" T 1982 1983 1984))
NIL
