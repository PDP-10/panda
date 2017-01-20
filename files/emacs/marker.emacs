!* -*-TECO-*- library written by Ethan Bradford <Bradford at SU-Sierra>!

!~Filename~:! !Provides TECO end of implementing updating marks.!
MARKER

!& Setup MARKER Library:! !S Run MARKER Setup Hook or set ^@ and ^X^X (undone on kill library).!
   
 0FO..q MARKER_Setup_Hookf"n [0 m0'	    !* Run setup hook if any!

 Q.@ M.v MARKER_Save_^@
 m.m^R_Set/Pop_Updating_MarkU.@
 Q:.x() M.v MARKER_Save_^X^X
 m.m^R_Exchange_Point_and_Updating_MarkU:.x()
 

!& Kill MARKER Library:! !S Run MARKER Kill Hook or undo definitions of ^@ and ^X^X!

 0FO..q MARKER_Kill_Hookf"n [0 m0'	    !* Run kill hook if any!

 0FO..q MARKER_Save_^@ F"N U.@'
 0FO..q MARKER_Save_^X^X F"N U:.x()'
 

!Make Marker:! !C Creates a new marker in the current buffer.
 The variable containing the marker should be passed as a string parameter
 to the routine; it cannot be register 1.
 The first numeric parameter should be the position of the marker.
 If omitted, point will be used.  Markers should be exclusively local
 variables since accessing them outside of their own buffers causes failure.!

 FS TopBuf-Q..O"N :i*W
   :I*NTB	Not_in_Top_Level_BufferFS Err '
 FS NewCng
 
 1,FMarker_Register:_[1	    !* Q1 contains our var name.!


 FF&1"E . '"#  '(		    !* Argument, defaulting to . !
 FS CngBuf[..o			    !* Get change buffer for point and Z!
 ) * Z / 10 (			    !* Shift left position value!
 ) + (. / 10) U1		    !* and combine with point as ptr value!
 

!Access Marker:! !C Get the current value of the marker.
 Variable name passed the same as for Make Marker; it can't be regs 1, 2, or 3.
 If called from ^R, jumps to Marker's position; otherwise returns position.!

 FS TopBuf-Q..o"N :i*W
   :I*NTB	Not_in_Top_Level_BufferFS Err '
 FS NewCng 

 [2 [3
 1,FMarker_Register:_[1	    !* Q1 contains our var name.!

 FS CngBuf[..o			    !* Access change buffer (last reg pushed)!

 Q1 * 10 / Z U3		    !* Q3 is old position!
 (Q1 - (Q3 * Z / 10)) * 10 U2	    !* Q2 is pointer to changes.!

 < Q2 - . @;			    !* Stop when back at current write ptr.!
   Q2 + 5 FS Word - Q3 F"L (	    !* If we see a change before this pos,!
     ) - (Q2 FS Word) F"G(	    !*    then if old pt. in deleted text!
       )*(-1) + Q3 U3		    !*      update pt to start of deleted txt!
     '"#
       Q3 + (Q2 FS Word) U3	    !*    otherwise, just add in change.!
     'W'W
   Q2 + 10 - Z F"N + Z' U2	    !* Upd ptr to next pair of words, wrapping!
   >
   Q3 * Z / 10 + (. / 10) U1	    !* Update our mark for next time.!

   ]..o
   :F"L Q3J '		    !* If called from ^R, jump to new point!
       "# Q3	'		    !* else return the new point.!


!^R Set/Pop Updating Mark:! !^R Sets or pops an updating mark.
Also affects the TECO Mark for the sake of routines which check that.
With no ^U's, pushes . as the mark.
With one ^U, pops the mark into .
With two ^U's, pops the mark and throws it away.!

      FF"E .: .M(M.M Push_Mark) 0' !* No arg sets mark.!
      -4"E .:W .M(M.M Push_Mark)	    !* ^U => Pop mark = push !
         2:< W M(M.M Pop_Mark)J> 0'    !* and then pop twice.!
      -15"G .(1:<W M(M.M Pop_Mark)W> )J 0' !* ^U^U => pop but stay.!

!^R Exchange Point and Updating Mark:! !^R Jump to updating mark after
settting updating mark at point.  If given an argument, it jumps to the TECO
mark instead.  Thus ^R Universal Argument ^R Exchange Point and Updating Mark
^R Exchange Point and Updating Mark will set the updating mark to the TECO mark 
and ^R Exchange Point and Updating Mark ^R Exchange Point and Updating Mark
will set the TECO mark to the updating mark.!

    . (W  W) F(:W) (
    FF"E M(M.M Pop_Mark)J') M(M.M Push_Mark)
    0

!Push Mark:! !C Push argument onto the updating mark stack.
If no argument is supplied, push point.  Error if not in top level buffer.!

 [x
 FF"E .'"# ' M(M.m Make_Marker)x
 0@FO..q Mark_StackF"E W 10*5 FS B CONS F(M.L Mark_StackW)'[..o
 Qx,. FS WordW .+5-Z F"L + Z' J    !* Write value & update pointer.!
 

!Pop Mark:! !C Pop from updating mark stack.
If called from ^R, jump to position popped, else return it.
Error if not in top level buffer.!

 [x [y [z
 0@FO..q Mark_Stack[x Qx"E 0'    !* Get Mark Stack; quit if none.!
 Qx[..o  .-5 F"L +Z' J ./5 Uz ]..o  !* Get point from the Mark Stack.!
 M(M.M Access_Marker):x(Qz) Uy
 :F "L QyJ  '
      "# Qy   '
