(FILECREATED "17-FEB-83 17:43:15" ("compiled on " <LISPUSERS>ARITHMAC.;9) (2 . 2) recompiled exprs: 
NUMTOAC in WORK dated "10-FEB-83 22:45:37")
(FILECREATED "17-FEB-83 17:42:33" <LISPUSERS>ARITHMAC.;9 10571 changes to: (FNS NUMTOAC) (VARS 
ARITHMACCOMS) previous date: "17-FEB-83 17:24:23" <LISPUSERS>ARITHMAC.;6)
FBIND BINARY
              -.          Z   0B   +      ,   ,~   ,<      ,   XBp  ,<   Zw,<   Z`  ,<   Zp     +   +   ,<   ,<  $  /   ,       ,\    D  ,\   /   ,~        X      (VARIABLE-VALUE-CELL NARGS . 3)
FLOATP
VALUEERROR
(GUNBOX BHC FLOATT KNIL MKFN ASZ ENTERF)   `        
          H    0      
FLOATSETQ BINARY
            -.           Z`  Z 7@  7   Z  "   +   ,<  ,<`  $  ,<   ,<` "  "   +   ,<  ,<`  ,<` "  ,   D  ,   +   ,       ,\    D     ,   ,~   ,T      (VAR . 1)
(VAL . 1)
"FLOATP variable not bound to floating box!"
HELP
EVAL
"Attempt to assign non-floating value to floating variable: "
(MKFN FUNBOX ALIST2 FLOATT KNOB ENTER2)       P   @               
FLOATSETQMAC BINARY
                -.           ,<  ,<  [   Z  B  D  3B   +   Z  +   ,<   "  ,<  ,<   $  Z  ,<   ,<   $  ,<   "  Z  	,<   ,<  ,<  [  Z  ,   ,   ,<   Z  F  ,~   jhS     (VARIABLE-VALUE-CELL ARGS . 28)
((VR VAL) . 0)
FLOATP
DECLOF
COVERS
TERPRI
"Floating SETQ of unknown value: "
PRIN1
PRIN2
the
((ASSEMBLE NIL (CQ (VAG VAL)) (E (NUMTOAC 2 (QUOTE FLOATP))) (VAR (HRRZ 1 , VR)) (MOVEM 2 , 0 (1))) . 
0)
SUBPAIR
(ALIST2 ALIST3 KT KNIL ENTERF)          @              
LARGESETQ BINARY
              -.           Z`  Z 7@  7   Z  ,<   Zp  (B{Z  A"  ."   0B  	+   	Zp  +   	Z   /   2B   +   ,<  ,<`  $  ,<   ,<` "  -,   +   ,<  ,<`  ,<` "  ,   D  ,   +   ,       ,\    D     ,   ,~    (i2     (VAR . 1)
(VAL . 1)
"LARGEP variable not bound to large box!"
HELP
EVAL
"Attempt to assign non-integer value to largep variable: "
(MKN IUNBOX ALIST2 SKNI BHC KNIL ASZ TYPTAB KNOB ENTER2)   h   @             
                          
LARGESETQMAC BINARY
        '        %-.           ,<  [   Z  B  ,<   @     +   ,<   Z   D   3B   +   	Z   ,~   ,<  !Z  D   3B   +   Z  !,~   ,<  !Z  	D   3B   +   Z  !,~   ,<   "  ",<  ",<   $  #Z  ,<   ,<   $  #,<   "  "Z  ,<   ,<  $,<  ![  Z  ,   ,   XB  Z  !,~   Z  ,   ,<   ,<  $&  %,~   -553E`      (VARIABLE-VALUE-CELL ARGS . 54)
((TYPE VR VAL) . 0)
DECLOF
(VARIABLE-VALUE-CELL $$TMP . 26)
SMALLP
COVERS
LARGEP
FIXP
TERPRI
"Large SETQ of unknown value:  "
PRIN1
PRIN2
the
((ASSEMBLE NIL (CQ (VAG VAL)) (E (NUMTOAC 2 (QUOTE TYPE))) (VAR (HRRZ 1 , VR)) (MOVEM 2 , 0 (1))) . 0)
SUBPAIR
(CONS ALIST2 ALIST3 KT KNIL ENTERF) H          X  (      8        
LARGEVAL BINARY
               -.           Z   -,   +   "   +   ,~   Z   ,~   @   (VARIABLE-VALUE-CELL V . 3)
(KNIL SMALLT SKI ENTERF)    X    @    0      
LBIND BINARY
                -.          Z   0B   +      ,   ,~   ,<      ,   XBp  ,<   Zw,<   Z`  ,<   Zp  -,   +   +   ,<   ,<  $  /   ,       ,\    D  ,\   /   ,~     B X      (VARIABLE-VALUE-CELL NARGS . 3)
FIXP
VALUEERROR
(GUNBOX BHC SKI KNIL MKN ASZ ENTERF)       X   (    X    h            

NUMTOAC BINARY
      w    b    t-.          bZ   2B   +   Z"   XB  @  d  ,~   Z   -,   Z   XB   Z  2B  d+   ;[  Z  2B  e+   ^[  XB  Z   3B  e+   2B  f+   ,Z  -,   Z   XB  	Z  2B  f+   ![  [  [  Z  Z  2B  g+   [  XB  Z  ,<  Z  g[  [  [  ,   Z  h,   ,   Z  h,   B  i+   :Z  Z  i,   Z  h,   B  i+   :2B  j+   )[  XB  ",<  hZ  ,<  ,<  h,<  gZ  g[  ,   ^,  ,   B  i+   :Z  #Z  j,   Z  h,   B  i+   :2B  k+   1Z  )Z  k,   Z  l,   B  i+   :2B  l+   9,<  m"  iZ  -Z  m,   Z  n,   B  iZ  3Z  n,   Z  l,   B  i+   :,<  oD  oZ   ,~   2B  p+   CZ  6[  &Z  3B  +   :[  "XB  ?,<  pZ  <,<  ,   B  i+   :2B  p+   KZ  @1B   +   :[  ?XB  E,<  q[  =Z  ,<   Z  D,<   ,   B  i+   :2B  h+   SZ  H[  GZ  3B  +   :[  FXB  NZ  L[  L[  ,   Z  h,   B  i+   :2B  q+   ^[  PB  r,<   @  c   +   \Z  O,<   Z  D  rZ  OB  sZ  q,   ,~   [  Y,   XB  \+   :Z  W1B   +   :Z  s,   Z  h,   B  i+   : GAjy85=/j+f	BzQ`M0       (VARIABLE-VALUE-CELL AC . 188)
(VARIABLE-VALUE-CELL KNOWNTYPE . 177)
(VARIABLE-VALUE-CELL CODE . 186)
(NIL VARIABLE-VALUE-CELL INST . 169)
FASTCALL
GUNBOX
FLOATP
LARGEP
HRRZ
VREF
@
,
MOVE
STORIN
((, 0 (1)) . 0)
LDV
((, 0 (1)) . 0)
SMALLP
((, -2048 (1)) . 0)
HRREI
FIXP
((STE SMALLT) . 0)
((, 0 (1)) . 0)
SKIPA
((, -2048 (1)) . 0)
"UNRECOGNIZED KNOWNTYPE - NUMTOAC"
HELP
LPOPN
LDN
LDN2
ASSEM
REVERSE
NUMTOAC
DREVERSE
((, 1) . 0)
(LIST3 LIST2 ALIST CONSS1 CONS21 CONS SKLST ASZ KNIL ENTERF)   	(   (      @     \ 
0 9 ` 0 @   P     a X R   5 x + x  (         _ X     ;    0      
(PRETTYCOMPRINT ARITHMACCOMS)
(RPAQQ ARITHMACCOMS ((FNS FBIND FLOATSETQ FLOATSETQMAC LARGESETQ LARGESETQMAC LARGEVAL LBIND NUMTOAC) 
(DECLARE: EVAL@COMPILE (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) NOBOX DECL)) (DECLTYPES (
FLOATP BINDFN) (FLOATP SETFN) (LARGEP BINDFN) (LARGEP SETFN)) (MACROS FBIND FLOATSETQ LARGESETQ LBIND 
FLOAT) (PROP (10MACRO DMACRO) FIX) (PROP AMAC VAGFIX) (PROP 10MACRO IBOX FBOX) (PROP DECLOF FBOX IBOX 
FLOATSETQ LARGESETQ) (IGNOREDECL) (DECLARE: DONTEVAL@LOAD DONTCOPY EVAL@COMPILEWHEN (NEQ (COMPILEMODE)
 (QUOTE PDP-10)) (ADDVARS (DONTCOMPILEFNS NUMTOAC))) (DECLARE: EVAL@COMPILE DONTCOPY (PROP (10MACRO 
DMACRO) LARGEVAL) COMPILERVARS (ADDVARS (NLAMA) (NLAML LARGESETQ FLOATSETQ) (LAMA LBIND FBIND)))))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) NOBOX DECL)
(DECLTYPES (FLOATP FLOATP BINDFN FBIND) (FLOATP FLOATP SETFN FLOATSETQ) (LARGEP LARGEP BINDFN LBIND) (
LARGEP LARGEP SETFN LARGESETQ))
(PUTPROPS FBIND MACRO (ARGS (COND (ARGS (LIST (QUOTE FBOX) (LIST (QUOTE the) (QUOTE FLOATP) (CAR ARGS)
))) (T (QUOTE (FBOX))))))
(PUTPROPS FLOATSETQ MACRO (ARGS (FLOATSETQMAC ARGS)))
(PUTPROPS LARGESETQ MACRO (ARGS (LARGESETQMAC ARGS)))
(PUTPROPS LBIND MACRO (ARGS (COND (ARGS (LIST (QUOTE IBOX) (LIST (QUOTE the) (QUOTE FIXP) (CAR ARGS)))
) (T (QUOTE (IBOX))))))
(PUTPROPS FLOAT MACRO (ARGS (COND ((COVERS (QUOTE FLOATP) (DECLOF (CAR ARGS))) (CAR ARGS)) (T (QUOTE 
IGNOREMACRO)))))
(PUTPROPS FIX 10MACRO (ARGS (COND ((COVERS (QUOTE FIXP) (DECLOF (CAR ARGS))) (CAR ARGS)) (T (QUOTE 
IGNOREMACRO)))))
(PUTPROPS FIX DMACRO (ARGS (COND ((COVERS (QUOTE FIXP) (DECLOF (CAR ARGS))) (CAR ARGS)) (T (CONS (
QUOTE IPLUS) ARGS)))))
(PUTPROPS VAGFIX AMAC ((EX R) (* Compiles EX and diddles code to put it right into R) (CQ (VAG (FIX EX
))) (E (NUMTOAC R (QUOTE FIXP)))))
(PUTPROPS IBOX 10MACRO (ARGS (COND ((CAR ARGS) (LIST (QUOTE ASSEMBLE) NIL (LIST (QUOTE VAGFIX) (CAR 
ARGS) 2) (LIST (QUOTE CQ) (KWOTE (IPLUS 100000))) (QUOTE (MOVEM 2 , 0 (1))))) (T (KWOTE (IPLUS 
10000000))))))
(PUTPROPS FBOX 10MACRO (ARGS (COND ((CAR ARGS) (LIST (QUOTE ASSEMBLE) NIL (LIST (QUOTE CQ) (LIST (
QUOTE VAG) (LIST (QUOTE FLOAT) (CAR ARGS)))) (QUOTE (E (NUMTOAC 2 (QUOTE FLOATP)))) (LIST (QUOTE CQ) (
KWOTE (FPLUS 0.0))) (QUOTE (MOVEM 2 , 0 (1))))) (T (KWOTE (FPLUS 0.0))))))
(PUTPROPS FBOX DECLOF FLOATP)
(PUTPROPS IBOX DECLOF LARGEP)
(PUTPROPS FLOATSETQ DECLOF FLOATP)
(PUTPROPS LARGESETQ DECLOF LARGEP)
(PUTPROPS ARITHMAC COPYRIGHT ("Xerox Corporation" 1983))
NIL
