!* -*- Teco -*-		Library created and maintained by KMP@MC !

!~Filename~:! !Compatibility support for LispM mice!
EMOUSE

!& Setup EMOUSE Library:! !& Set up compatibility for LispM EMACS-MOUSE library!

 m.m^R_Mouse_L u.l		    !* c-sh-L: Mouse Left		!
 m.m^R_Mouse_M u.m		    !* c-sh-M: Mouse Middle		!
 m.m^R_Mouse_R u.r		    !* c-sh-R: Mouse Right		!

 m.m &_Mouse_Select      fo..Q Mouse_L_Action m.v Mouse_L_Action
 m.m &_Mouse_Undefinedf( fo..Q Mouse_M_Action m.v Mouse_M_Action
                        ) fo..Q Mouse_R_Action m.v Mouse_R_Action
 				    !* Return				!


!& Mouse Args:! !S Macro which gobbles mouse args (postfix) via Tyi from terminal!

 :i*[X :i*[Y			    !* X,Y: Horizontal and vertical position  !
 <fiu0 q0f0123456789:; :iXX0>
 <fiu0 q0f0123456789:; :iYY0>
 mX,(mY)			    !* Return X,Y			      !


!& Mouse Undefined:! !S Macro to run when mouse action not defined!

 q..0 & 137.  100. [C		    !* C: Mouse char name		!
 :i*Cfsechodisplay		    !* Clear echo area and grump...	!
 @ftMouse-C_is_not_defined_here.
 0fsechoactive			    !* Pretend no typeout done		!
 0				    !* Return				!


!^R Mouse L:! !^R Handler for Mouse-Left!

 m(m.m &_Mouse_Args)mMouse_L_Action


!^R Mouse M:! !^R Handler for Mouse-Middle!

 m(m.m &_Mouse_Args)mMouse_M_Action


!^R Mouse R:! !^R Handler for Mouse-Right!

 m(m.m &_Mouse_Args)mMouse_R_Action


!& Mouse Select:! !^R Select a point with the mouse!

 fm(m.m &_Mouse_Move)	    !* Move, then maybe do something	!
 0fo..QMouse_Select_Hookf"n[0 m0 '


!& Mouse Move:! !S Move to a point given by the mouse!

!* Args (X,Y) are given as args.
   Jumps to hpos X, vpos Y ... or as close as it can get. 
   Just beeps on meaningless input.
   Clicking the line immediately below buffer (the separator in top window of
   two window mode, otherwise the mode line) will scroll the buffer a half screen.

*!


 [0 [X [Y
 fstopline[T			    !* T: Top line			    !
 fsheight-(fsecholines)[H	    !* H: Height			    !
 fslinesf"e qH'"#+qT'[B	    !* B: Bottom line			    !

!* For debugging... ! 

!*

 :i*Cfsechodisplay
 qX@:= @ft, qY-qT@:=  @ft=( qY@:= @ft- qT@:= @ft) 0fsechoactive

*!

 qT"g    qT-qY-1"e fg 0''	    !* Lose - specified divider line	    !
 qY-qH"g fg 0'		    !* Lose - mode line or echo area	    !
 qT-qY"g @m(m.m^R_Other_Window)'   !* Specified other window		    !
 qB-qY"l @m(m.m^R_Other_Window)'   !* Ditto				    !
 fstoplineuT			    !* Update T, it might be out of date    !
 fswindow+bj			    !* Jump to corner			    !
 1:< qY-qT,qX:FM >		    !* Give it a shot			    !
 0				    !* Return no change to buffer	    !
