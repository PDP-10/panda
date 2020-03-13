!* -*- TECO -*-		Library created and maintained by KMP@MC !

!~Filename~:! !Macros for hacking more than one column!
COLUMN

!& Setup COLUMN Library:! !& Initialize the world
Init qTwo Column Margin if necessary!

0fo..Q Two_Column_Margin"e	    !* If no setting for margin, ...	  !
  3 M.V Two_Column_Margin'	    !* make it 3 wide			  !


!Make 2 Columns:! !S Make this long, skinny file into a short, fat one
Take the text following the cursor and join it to the stuff following the
cursor making two columns. 

With no arg, Uses qTwo Column Margin (Default=3) as the amount
of space to leave between the columns at their narrowest point.
With an arg, uses the argument as the size of the margin.

A pre-comma arg menas it is being called from a macro and should not 
do an MM & Setup for Undo!

FF"n "l			    !* Check for negative arg		  !
 :i*NEG	Negative_arg_not_allowedfs err''
ff&2"e			    !* If no precomma arg		  !
 qEmacs_Version-132"g		    !* Maybe save info about change	  !
   h m(m.m &_Save_for_Undo) Make_2_Columns ''
f m(m.m &_Make_Two_Columns)[0    !* Do it and put changes in effect	  !
j g0 zk				    !* Make changes to buffer		  !
				    !* Return				  !


!& Make Two Columns:! !& Helper for ^R Make 2 Columns !

[0[1[2[3[4[5			    !* Bind scratch qregs		  !
				    !*					  !
b,. x1				    !* Put preceding stuff in q1	  !
.,z x2				    !* Put following stuff in q2	  !
				    !*					  !
f[bbind			    !* Bind buffer			  !
				    !*					  !
g1 j				    !* Get preceding stuff		  !
				    !*					  !
0u3				    !* q3 counts max line length	  !
				    !*					  !
<.-z;				    !* stop at end of buffer		  !
 .-(:lw.)u4			    !* Get minus line length in q4	  !
 q4+q3"l -q4u3'			    !* q3 := max(q3,-q4)		  !
 l >				    !* Loop				  !
				    !*					  !
q3+(ff&1"e qTwo_Column_Margin '"#  ' )u3    !* Add in margin	  !
				    !*					  !
0u0 fn q0f"nfsbkill'w 	    !* Kill buffer in q0 when we return	  !
				    !*					  !
fsbconsu0			    !* Put spare buffer in q0		  !
				    !*					  !
q..Ou5    j			    !* Put current buffer in q5		  !
				    !*					  !
q0u..O g2 j			    !* Setup spare buffer		  !
				    !*					  !
< q0u..O			    !* Get temp buffer			  !
  -z;				    !* Stop at end of file		  !
  1:fx4 k			    !* Transfer a line into q4, kill <CR> !
  q5u..O			    !* Unbind buffer			  !
  q3+(.-(:lw.)),40.i		    !* Insert right number of spaces	  !
  g4				    !* Get back from q4 into buffer	  !
  .-(l.)"e  i 
i'	    !* Get a new line			  !
>				    !* Loop				  !
				    !*					  !
q5u..O				    !* Restore proper buffer		  !
				    !*					  !
hfx* 				    !* Return				  !


!Make 1 Column:! !S Make long, skinny buffer out of short, fat one
Starting from the horizontal position, assume rest of line is column 2.
Move rest of all lines (column 2) into second buffer, flushing trailing
spaces on each column 1 that is left showing. Then yank back other buffer.!

qEmacs_Version-132"g		    !* Maybe save info about change	  !
  h m(m.m &_Save_for_Undo) Make_1_Column '
				    !*					  !
[0[1[2				    !* Create some scratch qregs	  !
				    !*					  !
m.m &_Move_Column_2_to_Other_Bufferu1 !* Efficiency			  !
				    !*					  !
0u2 fn q2f"nfsbkill'w 	    !* Kill buffer in q0 when we return	  !
				    !*					  !
fsbconsu2			    !* Cons up a buffer in q2		  !
				    !*					  !
.-(0l.)u0			    !* Put column 1 width in q0		  !
				    !*					  !
zj .-(0l.)"n zj i 
i'  	    !* Make file end in <CR>		  !
				    !*					  !
j <.-z;				    !* Loop through whole buffer	  !
   q0,q2 m1			    !* Move text to other buffer 	  !
   l>				    !* Go back a line and loop		  !
				    !*					  !
zj g( q2[..O hfx*( ]..O ) )	    !* Jump to end and yank other buffer  !
				    !*					  !
				    !* Return				  !

!& Move Column 2 to Other Buffer:! !& Move end of line to end of buffer.
Use arg1 as width of column 1. Move to column 2, snarf rest of line flushing
trailing whitespace in column 1. Jump to other buffer (arg 2) and yank back 
text. Return to beginning of line we started on.!

[0[1				    !* Get scratch qregs		  !
0l .u0				    !* Save starting point in q0	  !
:l				    !* Jump to end of line		  !
.-q0-"g q0+j 1:fx1'"#:i1'	    !* Put remaining text in q1		  !
-@f_	k		    !* Flush white space backward	  !
[..O g1 i 
i ]..O	    !* Put text in other buffer		  !
0l 				    !* Go to head of line and pop stack   !


!Flush Trailing Whitespace:! !S Flush whitespace at end of each line
Does this from point to end of buffer!
.:\[0 fn0j
<.-z;:l -@f_	kl>	    !* Flush whitespace at end of each line !



!Flush Extra CRs:! !S Flush redundant carriage returns
Does this from point to end of buffer!
.:\[0 fn0j			    !* Remember entry point		      !
<:s


; -2d 4r >			    !* Search for and delete half double cr   !
				    !* Return popping stack		      !


!Make Blocks:! !S Separate text into blocks of same number of lines!

FF&2"e			    !* If no precomma arg, ...		      !
 qEmacs_Version-132"g		    !* Maybe save info about change	      !
   h m(m.m &_Save_for_Undo) Make_Blocks ''
				    !*					      !
[0[1				    !* Set aside scratch storage	      !
				    !*					      !
j m(m.m Flush_Trailing_Whitespace) !* Flush dangling whitespace on each line !
j m(m.m Flush_Extra_CRs)	    !* Flush redundant carriage returns	      !
				    !*					      !
@f
_	k			    !* Kill leading whitespace in buffer      !
				    !*					      !
j 0u1				    !* Init q1 to 0			      !
				    !*					      !
< 0U0				    !* Loop, init q0 to 0		      !
  < ,1a-"e 0;' l %0 >	    !* Loop, counting number of lines in block!
  q0-q1"g q0u1'			    !* Maxify q1			      !
  :s;0l >			    !* Find next non-whitespace and loop      !
				    !*					      !
j				    !* Jump to head of buffer		      !
				    !*					      !
< 0U0				    !* Init q0 to 0			      !
  <				    !* Loop				      !
    ,1a-"e		    !* If on a blank line		      !
      q1-q0<i
             >			    !* Insert enough <CR>'s to make size      !
      0;'			    !* And exit inner loop		      !
    l %0			    !* Go down a line and increment counter   !
  >				    !* Loop				      !
  :s;r			    !* Search for next non-whitespace	      !
 >				    !* Loop				      !
				    !*					      !
b,z				    !* Return area changed		      !

!Make Two Column Blocks:! !Like MM Make Blocks but for 1->2 column format
A pre-comma arg menas it is being called from a macro and should not 
do an MM & Setup for Undo!

qEmacs_Version-132"g		    !* Maybe save info about change	      !
  h m(m.m &_Save_for_Undo) Make_Two_Column_Blocks '
				    !*					      !
[0				    !* Get scratch qreg			      !
j 1, m(m.m Make_Blocks)	    !* Make everything even length	      !
zj -@f
        k			    !* Flush trailing CR's in file	      !
i
 				    !* Replace with a single CR		      !
ff"n			    !* If an explicit arg is given	      !
    j 0u0 < %0 w l .-z; >	    !* Count lines in buffer		      !
    j (q0/2-2)l			    !* Go to buffer midpoint		      !
    :s
    
      				    !* Search back for a double-<CR>	      !
    sr'			    !* Search for next non-whitespace	      !
"#				    !* Else ...				      !
    j m(m.m &_Split_Blocks)'	    !* Split every other block to column 2    !
1,@m(m.m Make_2_Columns)	    !* Put it in two-column format	      !
j m(m.m Flush_Trailing_Whitespace) !* Kill losing blank space in column 1    !
j m(m.m Flush_Extra_CRs)	    !* Flush extra blank lines		      !
b,z				    !* Return region changed		      !


!& Split Blocks:! !& Helper for Make Two Column Blocks!

[0[1[2[3			    !* Save scratch qreg		      !
				    !*					      !
j				    !* Start at top			      !
0u0 <,1a- @; l %0 >	    !* Count number of lines in block	      !
    <,1a-:@; l %0 >	    !* Count number of lines of gap	      !
				    !*					      !
0u1 fn q1"n q1fsbkill' 	    !* Set up to kill q1 buffer		      !
fsbconsu1			    !*					      !
				    !*					      !
q..Ou2				    !* Put real buffer in q2		      !
				    !*					      !
j <.-z;				    !* Exit at end of buffer		      !
   q0l				    !* Jump down one block		      !
   q0fx3 q1u..O g3 q2u..O	    !* Take a block into q1 buffer	      !
  >				    !* Loop				      !
				    !*					      !
q1u..O hfx3 q2u..O g3 fkc	    !* Transfer text from other buffer	      !
				    !*					      !
				    !* Return				      !
