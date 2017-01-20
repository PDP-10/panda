(FILECREATED "27-AUG-82 15:09:32" {DSK}GLTEST.LSP;2 8677   

      changes to:  (VARS GLTESTCOMS)

      previous date: "11-Aug-82 16:10:35" {LASSEN}<GSN>GLTEST.LSP;1)


(PRETTYCOMPRINT GLTESTCOMS)

(RPAQQ GLTESTCOMS [(FNS GIVE-RAISE CURRENTDATE VECTORPLUS VECTORDIFF VECTORTIMES VECTORQUOTIENT 
			VECTORMOVE GRAPHICSOBJECTMOVE MGO-ACCELERATE TESTFN1 TESTFN2 DRAWRECT TP 
			IMod7Store IMod7Plus SA SB GROWCIRCLE SQUASH)
	(GLISPOBJECTS EMPLOYEE DATE COMPANY VECTOR GRAPHICSOBJECT MOVINGGRAPHICSOBJECT LISPTREE 
		      PreorderSearchRecord ArithmeticOperator IntegerMod7 CIRCLE)
	(PROP GLRESULTTYPE CURRENTDATE)
	(PROP DRAWFN RECTANGLE)
	(PROP ALL COMPANY1)
	(VARS MYCIRCLE)
	(P (SETQ MYWINDOW
		 (CREATEW (create REGION LEFT _ 400 BOTTOM _ 400 WIDTH _ 400 HEIGHT _ 400)
			  "GraphicsWindow"))
	   (SETQ DSPS (WINDOWPROP MYWINDOW (QUOTE DSP])
(DEFINEQ

(GIVE-RAISE
  (GLAMBDA ((A COMPANY))                                     (* edited: "30-NOV-81 17:05")
	   (FOR EACH ELECTRICIAN WHO IS NOT A TRAINEE
	      DO (SALARY _+(IF SENIORITY > 1
			       THEN 2.5
			     ELSE 1.5))
		 (PRINTOUT NIL (THE NAME OF THE ELECTRICIAN)
			   ,
			   (THE PRETTYFORM OF DATE-HIRED)
			   , MONTHLY-SALARY T))))

(CURRENTDATE
  (GLAMBDA NIL                                               (* edited: "30-NOV-81 16:33")
	   (A DATE WITH YEAR = 1981 , MONTH = 11 , DAY = 30)))

(VECTORPLUS
  (GLAMBDA (V1,V2:VECTOR)
	   (A VECTOR WITH X = V1:X + V2:X , Y = V1:Y + V2:Y)))

(VECTORDIFF
  (GLAMBDA (V1,V2:VECTOR)
	   (A VECTOR WITH X = V1:X - V2:X , Y = V1:Y - V2:Y)))

(VECTORTIMES
  (GLAMBDA (V:VECTOR N:NUMBER)
	   (A VECTOR WITH X = X*N , Y = Y*N)))

(VECTORQUOTIENT
  (GLAMBDA (V:VECTOR N:NUMBER)
	   (A VECTOR WITH X = X/N , Y = Y/N)))

(VECTORMOVE
  (GLAMBDA (V,DELTA:VECTOR)                                  (* edited: "11-JAN-82 12:35")
	   (V:X _+
		DELTA:X)
	   (V:Y _+
		DELTA:Y)))

(GRAPHICSOBJECTMOVE
  (GLAMBDA (self:GRAPHICSOBJECT DELTA:VECTOR)                (* edited: "11-JAN-82 16:07")
	   (_ self ERASE)
	   (START _+
		  DELTA)
	   (_ self DRAW)))

(MGO-ACCELERATE
  (GLAMBDA (SELF: MOVINGGRAPHICSOBJECT ACCELERATION: VECTOR)
	   VELOCITY _+
	   ACCELERATION))

(TESTFN1
  (GLAMBDA NIL                                               (* edited: "11-JAN-82 15:22")
                                                             (* Make a moving graphics object and step across the 
							     screen.)
	   (PROG (MGO N)
	         (MGO _(A MOVINGGRAPHICSOBJECT WITH SHAPE =(QUOTE RECTANGLE)
			  , SIZE =(A VECTOR WITH X = 4 , Y = 3)
			  , VELOCITY =(A VECTOR WITH X = 3 , Y = 4)))
	         (N _ 0)
	         (WHILE (N_+1)
			<100 (_ MGO STEP))
	         (_(the START of MGO)
		   PRINT))))

(TESTFN2
  (GLAMBDA ((A GRAPHICSOBJECT))                              (* edited: " 1-DEC-81 09:46")
	   (LIST SHAPE START SIZE LEFT BOTTOM RIGHT TOP WIDTH HEIGHT CENTER AREA)))

(DRAWRECT
  (GLAMBDA ((A GRAPHICSOBJECT)
	    DSPOP:ATOM)                                      (* edited: "11-JAN-82 12:40")
	   (PROG (OLDDS)
	         (OLDDS _(CURRENTDISPLAYSTREAM DSPS))
	         (DSPOPERATION DSPOP)
	         (MOVETO LEFT BOTTOM)
	         (DRAWTO LEFT TOP)
	         (DRAWTO RIGHT TOP)
	         (DRAWTO RIGHT BOTTOM)
	         (DRAWTO LEFT BOTTOM)
	         (CURRENTDISPLAYSTREAM OLDDS))))

(TP
  [GLAMBDA (:LISPTREE)                                       (* edited: " 4-JAN-82 15:42")
	   (PROG (PSR)
	         (PSR _(A PreorderSearchRecord with Node =(the LISPTREE)))
	         (While Node (If Node is ATOMIC (PRINT Node))
			(_ PSR NEXT])

(IMod7Store
  (GLAMBDA (LHS:IntegerMod7 RHS:INTEGER)                     (* edited: " 7-JAN-82 18:02")
	   (LHS:self __(IREMAINDER RHS Modulus))))

(IMod7Plus
  (GLAMBDA (X,Y:IntegerMod7)                                 (* edited: " 7-JAN-82 17:34")
	   (IREMAINDER (X:self + Y:self)
		       X:Modulus)))

(SA
  (GLAMBDA ((An ArithmeticOperator))                         (* edited: " 7-JAN-82 17:23")
	   (If Precedence>5 (_(the ArithmeticOperator)
		 PRIN1))))

(SB
  [GLAMBDA (X:IntegerMod7)                                   (* edited: " 7-JAN-82 17:37")
	   (PROG (Y)
	         (LIST Modulus Inverse)
	         (If X is Odd or X is Even or X is a Prime then (Y _ 5)
		     (X _ 12)
		     (X _+5])

(GROWCIRCLE
  (GLAMBDA (C:CIRCLE)                                        (* Example of assignment to computed property.)
	   (C:AREA _+
		   100)
	   (PRINT RADIUS)))

(SQUASH
  (GLAMBDA NIL                                               (* Example of elimination of compile-time constants.)
	   (IF 1>3
	       THEN 'AMAZING
	     ELSEIF 6<2
	       THEN 'INCREDIBLE
	     ELSEIF 2+2=4
	       THEN 'OKAY
	     ELSE 'JEEZ)))
)


[GLISPOBJECTS


(EMPLOYEE

   (LIST (NAME STRING)
	 (DATE-HIRED (A DATE))
	 (SALARY REAL)
	 (JOBTITLE ATOM)
	 (TRAINEE BOOLEAN))

   PROP   ((SENIORITY ((THE YEAR OF (CURRENTDATE))
		       -
		       (THE YEAR OF DATE-HIRED)))
	   (MONTHLY-SALARY (SALARY * 174)))

   ADJ    ((HIGH-PAID (MONTHLY-SALARY>2000)))

   ISA    ((TRAINEE (TRAINEE))
	   (GREENHORN (TRAINEE AND SENIORITY < 2)))

   MSG    ((YOURE-FIRED (SALARY _ 0)))  )

(DATE

   (LIST (MONTH INTEGER)
	 (DAY INTEGER)
	 (YEAR INTEGER))

   PROP   ([MONTHNAME ((CAR (NTH ' (January February March April May June July August September 
					    October November December)
				 MONTH]
	   (PRETTYFORM ((LIST DAY MONTHNAME YEAR)))
	   (SHORTYEAR (YEAR - 1900)))  )

(COMPANY

   [ATOM (PROPLIST (PRESIDENT (AN EMPLOYEE))
		   (EMPLOYEES (LISTOF EMPLOYEE]

   PROP   [(ELECTRICIANS ((THOSE EMPLOYEES WITH JOBTITLE = (QUOTE ELECTRICIAN]  )

(VECTOR

   (LIST (X INTEGER)
	 (Y INTEGER))

   PROP   [(MAGNITUDE ((SQRT X^2 + Y^2]

   ADJ    ((ZERO (X IS ZERO AND Y IS ZERO))
	   (NORMALIZED (MAGNITUDE = 1.0)))

   MSG    [(+ VECTORPLUS OPEN T)
	   (- VECTORDIFF OPEN T)
	   (* VECTORTIMES OPEN T)
	   (/ VECTORQUOTIENT OPEN T)
	   (_+ VECTORMOVE OPEN T)
	   (PRIN1 ((PRIN1 "(")
		   (PRIN1 X)
		   (PRIN1 ",")
		   (PRIN1 Y)
		   (PRIN1 ")")))
	   (PRINT ((_ self PRIN1)
		   (TERPRI]  )

(GRAPHICSOBJECT

   (LIST (SHAPE ATOM)
	 (START VECTOR)
	 (SIZE VECTOR))

   PROP   ((LEFT (START:X))
	   (BOTTOM (START:Y))
	   (RIGHT (LEFT+WIDTH))
	   (TOP (BOTTOM+HEIGHT))
	   (WIDTH (SIZE:X))
	   (HEIGHT (SIZE:Y))
	   (CENTER (START+SIZE/2))
	   (AREA (WIDTH*HEIGHT)))

   MSG    ([DRAW ((APPLY* (GETPROP SHAPE 'DRAWFN)
			  self
			  (QUOTE PAINT]
	   [ERASE ((APPLY* (GETPROP SHAPE 'DRAWFN)
			   self
			   (QUOTE ERASE]
	   (MOVE GRAPHICSOBJECTMOVE OPEN T))  )

(MOVINGGRAPHICSOBJECT

   (LIST (TRANSPARENT GRAPHICSOBJECT)
	 (VELOCITY VECTOR))

   MSG    [(ACCELERATE MGO-ACCELERATE OPEN T)
	   (STEP ((_ self MOVE VELOCITY]  )

(LISPTREE

   (CONS (CAR LISPTREE)
	 (CDR LISPTREE))

   PROP   [(LEFTSON ((If self is ATOMIC then NIL else CAR)))
	   (RIGHTSON ((If self is ATOMIC then NIL else CDR]

   ADJ    ((EMPTY (~self)))  )

(PreorderSearchRecord

   (CONS (Node LISPTREE)
	 (PreviousNodes (LISTOF LISPTREE)))

   MSG    [(NEXT ((PROG (TMP)
			(If TMP_Node:LEFTSON then (If Node:RIGHTSON then PreviousNodes+_Node)
			    Node_TMP else TMP-_PreviousNodes Node_TMP:RIGHTSON]  )

(ArithmeticOperator

   (self ATOM)

   PROP   ((Precedence OperatorPrecedenceFn RESULT INTEGER)
	   (PrintForm ((GETPROP self (QUOTE PRINTFORM))
		       or self)))

   MSG    [(PRIN1 ((PRIN1 the PrintForm]  )

(IntegerMod7

   (self INTEGER)

   PROP   [(Modulus (7))
	   (Inverse ((If self is ZERO then 0 else (Modulus - self]

   ADJ    ([Even ((ZEROP (LOGAND self 1]
	   (Odd (NOT Even)))

   ISA    ((Prime PrimetestFn))

   MSG    ((+ IMod7Plus OPEN T RESULT IntegerMod7)
	   (_ IMod7Store OPEN T RESULT IntegerMod7))  )

(CIRCLE

   (LIST (START VECTOR)
	 (RADIUS REAL))

   PROP   ((PI (3.141593))
	   (DIAMETER (RADIUS*2))
	   (CIRCUMFERENCE (PI*DIAMETER))
	   (AREA (PI*RADIUS^2)))  )
]


(PUTPROPS CURRENTDATE GLRESULTTYPE DATE)

(PUTPROPS RECTANGLE DRAWFN DRAWRECT)
  (PUTPROPS COMPANY1 EMPLOYEES (("Cookie Monster" (7 21 1947)
						  12.5 ELECTRICIAN NIL)
				("Betty Lou" (5 14 1980)
					     9.0 ELECTRICIAN NIL)
				("Grover" (6 13 78)
					  3.0 ELECTRICIAN T))
                     PRESIDENT ("Oscar the Grouch" (3 15 1907)
						   88.0 NIL MALE))

(RPAQQ MYCIRCLE ((0 0)
		 0.0))
(SETQ MYWINDOW (CREATEW (create REGION LEFT _ 400 BOTTOM _ 400 WIDTH _ 400 HEIGHT _ 400)
			"GraphicsWindow"))
(SETQ DSPS (WINDOWPROP MYWINDOW (QUOTE DSP)))
(DECLARE: DONTCOPY
  (FILEMAP (NIL (853 4902 (GIVE-RAISE 863 . 1245) (CURRENTDATE 1247 . 1414) (VECTORPLUS 1416 . 1513) (
VECTORDIFF 1515 . 1612) (VECTORTIMES 1614 . 1701) (VECTORQUOTIENT 1703 . 1793) (VECTORMOVE 1795 . 1953
) (GRAPHICSOBJECTMOVE 1955 . 2137) (MGO-ACCELERATE 2139 . 2254) (TESTFN1 2256 . 2801) (TESTFN2 2803 . 
2987) (DRAWRECT 2989 . 3410) (TP 3412 . 3674) (IMod7Store 3676 . 3830) (IMod7Plus 3832 . 3997) (SA 
3999 . 4162) (SB 4164 . 4430) (GROWCIRCLE 4432 . 4606) (SQUASH 4608 . 4900)))))
STOP
