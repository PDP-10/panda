(FILECREATED "20-Dec-82 17:38:46" ("compiled on " <DONC>WAKEUP..11) (2 . 2) 
tcompl'd in MEVAL dated "18-Oct-82 12:28:53")
(FILECREATED "20-Dec-82 17:33:40" <DONC>WAKEUP..11 1200 changes to: (FNS 
BeforeInput) previous date: "15-Dec-82 09:51:50" <DONC>WAKEUP..10)

AfterInput BINARY
             -.          Z   3B   7   7   +   	Z  2B   +      2B   7   7   +   +   	Z   ,~   ,<  "  XB   ,~   L3  (VARIABLE-VALUE-CELL File . 8)
(VARIABLE-VALUE-CELL LastInputTime . 21)
INPUT
0
CLOCK
(KNIL KT ENTERF)  	  x   @       8        

BeforeInput BINARY
       )    !    (-.           !Z   3B   +   2B   +      #2B   +   ,<  $Zp  -,   +   Zp  Z 7@  7   Z  2B  $+   ,<p  ,<   Z   F  %B  %3B   +   Z   +   Z   /   3B   +       ,>   ,>   ,<  &"  &,   ,>   ,>           ,^   /   /      ,^   /   2"  +      '3B   +   Z   ,~   Z   +   Z   ,~   Z   B  ',~      lAFQZ       (VARIABLE-VALUE-CELL File . 3)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 24)
(VARIABLE-VALUE-CELL WakeUpTime . 35)
(VARIABLE-VALUE-CELL LastInputTime . 43)
(VARIABLE-VALUE-CELL WakeUp . 62)
INPUT
LastInputTime
NOBIND
STKSCAN
RELSTK
0
CLOCK
INREADMACROP
PRIN1
(IUNBOX BHC KNOB SKLA KNIL KT ENTERF)   P              x   p  @    H      x   0      
(PRETTYCOMPRINT WAKEUPCOMS)
(RPAQQ WAKEUPCOMS ((FNS AfterInput BeforeInput) (VARS WakeUp WakeUpTime) (ADVICE
 READ ASKUSER) (P (READVISE READ ASKUSER) (RELINK (QUOTE WORLD)))))
(RPAQQ WakeUp "")
(RPAQQ WakeUpTime 15000)
(PUTPROPS READ ARGNAMES (FILE RDTBL FLG))
(PUTPROPS READ READVICE (NIL (BEFORE NIL (BeforeInput FILE)) (AFTER NIL (
AfterInput FILE))))
(PUTPROPS ASKUSER READVICE (NIL (BEFORE NIL (BeforeInput FILE)) (AFTER NIL (
AfterInput FILE))))
(READVISE READ ASKUSER)
(RELINK (QUOTE WORLD))
NIL
