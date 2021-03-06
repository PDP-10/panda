!* -*-TECO-*-!
!* <EMACS>BSHACK.EMACS.4,  8-Jan-83 14:48:39, Edit by GERGELY!
!~Filename~:! !Backspace hack.!
BSHACK

!Unbackspacify:! !C Convert ^Hs in the buffer to bare CRs and spaces.!

0,fszM(m.M &_Save_For_Undo)Unbackspacify
    [1 [2 [3 [4 [5 j		    !* Start at beginning of buffer.!
    <:s ;			    !* Find the next one.!
      :i* u1 0u3		    !* And init the new line.!
    !next!
      r ^ f f( f(   u5	    !* Get size of area to do.!
        ) k ) fx2		    !* Delete the ^Hs and get the other guys.!
      .,. f			    !* Report what we've munged.!
      fs hpos-q3-q5 ,32 : i4	    !* Get enough spaces to move over.!
      :i1 1 4 2	    !* Now put them all together.!
      fs hpos u3		    !* Update where we are.!
      :fb "l onext '	    !* More this line?!
      :l .,( i1 .) f	    !* Insert new stuff and report changes.!
    >				    !* More lines?!
    0				    !* Already reported damage.!

!Transpose Overwritten Line:! !C Command to transpose overwritten lines
created by M-X Unbackspacify, so that underlines come before letters.!

0,fszM(m.M &_Save_For_Undo) Transposing_Overwritten

J <:S
;			    !* FIND ALL SOLITARY CR!
   R -D W :FXA			    !* PICK UP REST OF LINE DELETING CR!
   0L GA 13I> 		    !* PUT AT BEGINNING AND REPLACE CR!

!^R Overprint Line:! !^R Overprint current line with itself.
This makes it print darker on a LPT.!

.,(:s"Ezj'.)M(m.M &_Save_For_Undo)Overprint
[a
.(0l .,(:s "l fkc'.)xa
:l fqa"G <13i ga>' )j


!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)BSHACKBSHACK
1:<M(M.MDelete File)BSHACK.COMPRS>W \
/ End: \
!  