!* -*-TECO-*-!
!* <EMACS>NCOLUMNS.EMACS.6, 23-Feb-83 12:08:39, Edit by GERGELY!
!* <GERGELY.EMACS>COLUMNS..55,  5-May-80 14:54:22, Edit by GERGELY!
!~Filename~:! !* Makes columnar charts !
NCOLUMNS

!Make Columns Chart:! !C Breaks a file into pages of ABS(arg) columns/page 
Can take two arguments in the following format

	<Columns>,<Key length> MM Make Columns Chart$<Page Width>
with
<Columns> being the number of columns to put on a page.
	>0 puts the columns in equal width padding out to the appropriate
width if necessary.
	=0 finds the number of columns optimally in order to fit the
maximum width of the text.
	<0 as if positive but does not pad out short columns to full width.

<Key> being the length of the keys for which to find definitions.
	>0 assumes that there is at the start of each line a key of
length as given.
	=0 implies there are no keys.

<Page width> being the width of the page to put the columns on.  The default is
132 columns.

If the user gives only one argument in the following form, the argument is
assumed to be <Key> with <Columns> being defaulted to 0.

	<Key> MM Make Columns Chart$    !

0,fszM(m.M &_Save_For_Undo) Column_Creation
[0 [1				    !* Push the argument registers, Q0= no. of!
				    !* columns, Q1=key length!
FF-1F"G -1"G U0   U1'	    !* Two arguments!
	      "# U0 0U1' '	    !* Pre-comma argument then Q1=0!
         "#   "E 0U0   U1'	    !* One argument then Q1=0!
	      "# 0U0 0U1' '	    !* No argument then Q0=0 and Q1=0!
J I 0L W\[5 0K		    !* Q5 gets the page width, if any!
Q5-2F"GU5' "#W130U5'		    !* 132 is the default page width!
Q5-Q1-(Q0*5):"G			    !* Check to see if we have enough of a !
  1FS ECHO FLUSH		    !* page width to do as requested.!
  FG				    !* Ring bell signifying an error!
  :I*CPage_width_is_too_small_for_requested_columns_chart.
FS ECHO DISPLAY		    !* Display the message!
  0FS ECHO ACTIVE		    !* Don't erase it so fast!
  '				    !* RETURN!
wzj 0a-12"n			    !* The file must end with CRLF FF!
  0A-10"N 13I10I'		    !* Check for Linefeed, if not insert CRLF!
  12I'				    !* Check for FF, if not insert it.!
Q0"E 12I'
J
0@m(m.m^R_Buffer_Graph)w	    !* Return no values.!
0[C <:S; %C W>		    !* QC gets the number of pages in the file!
QC-(Q0  )"L Q0"L -QCU0' "# QCU0'' !* If ABS(q0) > qc then q0=qC!
[A				    !* QA holds the vector of column positions!
(QC+1)*5 FSQVECTOR UA		    !* and should be of length (QC+1)*5!
Q0 "N (Q5-(2*Q1))/Q0 [2	    !* Given q0.NE.0 ,Q2 gets column width!
    J 0[I			    !* QI gets the current page number!
    (QC-1)/(Q0  )+1 < 0UI	    !* Find the number of pages to be created!
				    !* and for each.... !
      J .,(			    !* Keep the current location for later use!
	Q0  < :S
;      R			    !* For each column to be formed find end!
				    !* of the page!
	  B,. FSBOUNDARIES	    !* Close the bounds to be only this page!
	  Q2,Q1 M(M.M &_Adjust_Columns_in_Region)  !* Pad each line in the!
				    !* page to a width of q2+q1 using spaces!
	  QI"E 0U:A(QI) '	    !* qA(qI) holds the starting column for!
	    "# QB+Q:A(QI-1)U:A(QI)' !* the qI+1 th column!
	  %I			    !* Increment Page Number!
	  WZJ .-FSZ"E R' .+1,FSZFSBOUNDARIES >   !* Open bounds to be the!
				    !* next page to the end of the file!
	QB+Q:A(QI-1)U:A(QI)	    !* Get full width!
	900000U:A(QC)		    !* Last entry is infinity!
	0,FSZFSBOUNDARIES	    !* Open bounds to full!
	.-Z"E 0A-12"E -D' '	    !* If at EOF delete the FF, if any!
	   "# R'
	.)F  FSBOUNDARIES	    !* Make current bounds be only the!
				    !* processed part of the file!
      0M(M.M &_Columnate_Key_Definitions)  !* Make the columns!
      .-FSZ"E R' .+1,FSZFSBOUNDARIES > ' !* Make the current bounds be the!
				    !* unprocessed part of the file!


    "# (Q5-(2*Q1))[2		    !* If q0=0, then q2 gets page width!
      0[I			    !* qI is the current page number!
      J QC<:S
;				    !* Search for the pagemark!
	R WB,. FSBOUNDARIES	    !* Set bounds to current page!
	0,Q1 M(M.M &_Adjust_Columns_in_Region)	    !* Find width of longest!
				    !* line and pad all other lines to this!
				    !* width!
	QI"E QB[3 0U:A(QI)'	    !* qA(qI) gets the starting position of!
	  "# Q3+Q:A(QI-1)U:A(QI) QBU3'	    !* the qI+1 th column!
	%I			    !* Increment page number!
	WZJ .-FSZ"E -D R' .,FSZFSBOUNDARIES >    !* Open bounds to be the!
				    !* Next page to the end of the file!
      QB+Q:A(QI-1)U:A(QI)	    !* Get full width!
      900000U:A(QC)		    !* Make sure not to go past the last col.!
      0,FSZFSBOUNDARIES	    !* Open bounds to full!
      J				    !* Go to the top of the file!
      0UI 0[J 0[K 0[L		    !* Initialize the necessary registers!
      <QI-QC; .-FSZ;		    !* Stop processing after last col. or EOF!
	Q:A(QI+1)-Q2:"L		    !* If Starting Column >= Page width, then!
	  J .,(QJ F"G :S
 "NR' "#ZJ' ' "# WZJ'	    !* Find the last page to use, or the EOF!
	  .)F FSBOUNDARIES	    !* Close the bounds to this processed area!
	  QLM(M.M &_Columnate_Key_Definitions)	    !* Make the columns!
	  Q:A(QI)UJ QIUK	    !* Update the remaining starting positions!
	  <QK-QC-1;		    !* For all K=QI to QC!
	    Q:A(QK)-QJ U:A(QK)	    !* Subtract last used starting position!
	    %K>			    !* Increment K!
	  QI-QC+1;
	  0UJ QIUL WZJ		    !* Go to the end of the current buffer!
	  .-FSZ"E 0A-12"E-D' R '   !* Set new bounds to be the next page!
	  .+1,FSZFSBOUNDARIES '   !* to the end of the file!
	"# %I W%J' > '		    !* If start column < pg. width increment!
				    !* the page number and the number of pages!
				    !* to use!
0,FSZFSBOUNDARIES		    !* Set bounds to full!
WZJ 2<0A-12"E-D'>		    !* If file ends with a FF then delete it!
j M(M.M&_Fix_Control_Characters)
j <.-z; :L W M(M.M ^R_Delete_Horizontal_Space) W 1l>	!* Delete extra space!
0@m(m.m^R_Buffer_Graph)w	    !* Return no values.!
J 				    !* Back to the top of the file and quit!

!& Fix Control Characters:! !S Replaces control characters by ^ character.
The character position is also adjusted at the first space!
[2 f[bbind
    32< IZU..2 >                   !* MAKE AN F^A DISPATCH TO STOP ON CTL!
				    !* CHARS.!
    95*5,32I
    IZU..2                         !* RUBOUT COUNTS AS CTL CHAR.!
    15.*5F_____                  !* CR, LF, TAB, FF AND ALTMODE DO NOT.!
    12.*5F_____
    11.*5F_____
    14.*5F_____
    33.*5F_____
    HFX2                            !* STORE WHOLE THING IN Q2!
    f]bbind
    J < .,ZF2 .-Z;                !* SKIP TO NEXT CTL CHAR TO CONVERT!
         0A(-D I^)#100.I	    !* CONVERT CONTROL-MUMBLE TO TILDA AND!
				    !* MUMBLE.!
	 .( 1:fB_"L -d')j>
    J 0S
 <:S; R-DI^M>      !* CONVERT STRAY CARRIAGE RETURNS!
    J 0S
 <:S; -DI^J>     !* CONVERT STRAY LINE FEEDS.!
    J <:S; -DI$>               !* CONVERT ALTMODES TO DOLLAR SIGNS.!
    J <:S
; -DI^L>	    !* CONVERT NON FIRST CHAR FF ON A LINE!



!& Adjust Columns in Region:! !S Fills each line to a certain width
(defined by the first argument if not zero) in the current region.  If
the first argument is negative, and if  the true width of a column  is
less than the  absolute value of  the argument, the  argument will  be
changed to the true width.  The second argument gives the width of the
key to be  taken into  account of  during the  filling procedure.  The
first line is treated specially in that if the line width is less than
the key width it is not deleted.!

[0 [1			    !* q0 gets the column width, 1st arg!
				    !* q1 gets the key width, 2nd arg !
 @m(m.m^R_Buffer_Graph)w	    !* Return no values.!
J W-.+(:L.)-Q1-1F"L+1  +1,32I'    !* If the first line is less than the!
				    !* key width then pad it out to that width!
J Q0:"G -(0L.)+(:L.)UB L	    !* If q0>=0 then skip this part, otherwise!
				    !* take the line width of the first line!
				    !* as the starting maximum line width!
  <.-Z;				    !* For the rest of the buffer, Do..!
    -.+(:L.)-Q1+1F"G-1 -QBF"G +QBUB'	    !* Find the maximum width not!
				    !* counting the key length!
      1L'			    !* skip to the next line!
    "# -1  +1,32I 1L' >	    !* If width was less than the key, pad out!
  Q0"N				    !* If q0 was not zero then check the width!
    QB+Q0"G Q0  UB' '		    !* in case it is less than asked for!
  "# QB+1U0' '			    !* Otherwise, add one for a space to width!


Q0  UB			    !* QB contains the current width to use!
J QB-1+.-(:L.)F"G+1,32I' "#D 32I' 1L	    !* Pad out the first line, if!
				    !* necessary!
<.-Z;				    !* For the rest of the current buffer!
  -.+(:L.)-Q1"L :L Q1,32I 0L'	    !* Pad out if necessary, or otherwise!
  0l Q1C QB-1+.-(:L.)F"G+1,32I'   !* delete to get desired width !
    "#D 32I'
    1L>				    !* Next line!


!& Columnate Key Definitions:! !S Gets the other definitions for the keys
in the region.  The only argument is the starting index for the QVECTOR A.
The necessary Q-register are assumed to be defined previously.
They are: Q1 QI and the qvector QA of maximum length QC*5. !
0f[bothcase 0f[^Pcase
  [L			    !* The argument goes into qL!
 @m(m.m^R_Buffer_Graph)w	    !* Return no values.!
[P [D [E [I [J [K [M [B		    !* Push the necessary registers!
J Q1"G IKey Q1-3,32I 13I10I	    !* If keys exist then put in a column!
  -1L Q1 FXM K			    !* title to say so and call it KEY!
  0L GM 32I'			    !* Make sure there is a space after it!
:L .UD				    !* Go to the EOL and store loc. in QD!
QLUI				    !* QI holds the current page number!
<:S
;R %I			    !* Column title is on same line as FF!
  :L.-2( 0L			    !* Keep current position to return later!
    C W:FXE			    !* Pick it up and store it in QE!
    QDJ				    !* Go back to the title line!
    0L Q1F"N-1'C		    !* Beginning of line and over the key!
    .-(:L.)+Q:A(QI)+1 F"G-1,32I'    !* Make sure in the proper position!
    "#D 32I'			    !* Either pad out or delete to it!
    GE .UD			    !* Restore the title and location!
  )J >				    !* Back down to where we left!
J 1L 13I 10I			    !* Put a blank line after the title line!
.,Z FSBOUNDARIES		    !* Close bounds to exclude these two lines!
Q1"N				    !* Given the fact that we have keys, do..!
QLUI W<.-Z;			    !* Starting at given page & for each line!
  1A-12"E %I WK OEND'		    !* If a FF, then increment page no. and!
				    !* delete the line !
  Q1+.-(:L.)"G 0L WK OEND'	    !* If line width is less than key then!
				    !* delete the line as well!
  0L 0UJ Q1<%JA-32:@;>		    !* If the whole line is nothing but spaces!
  Q1-QJ"E 0L WK OEND'		    !* then get rid of it!

  Q1C 0XB 32I			    !* QB gets the key with a space after it!
  Q:A(QI),32I			    !* Fill to the proper column start!
  :L .UD			    !* over the definition and keep location!
				    !* in the register qD!
  QIUJ				    !* QJ keeps the definition page number!
  <:S

B ;			    !* If new page, increment or find next key!
				    !* definition!
    0A-12"E %J'
    "# FKD W:FXE		    !* Delete the key and put definition in qE!
      QDJ			    !* Back up to the key line!
      0L Q1C			    !* Beginning of line and over the key!
      .-(:L.)+Q:A(QJ) F"G+1,32I'    !* Make sure the new definition goes in!
				    !* proper place by either padding or!
        "#D 32I'		    !* deleting to the proper position!
      GE .UD			    !* Put in the definition and keep loc.!
      QIUJ' >			    !* Reset the definition page number!
  QDJ 1L			    !* Back up and go to the next line!
  !END!>

 J W0L:L1L			    !* Sort the key definitions!
 J 0,Q1 M(M.M &_Adjust_Columns_in_Region)  !* Pad the smallest possible width!
 J 0,ZFSBOUNDARIES		    !* Set bounds full!
 -2L 1A-12"E C' .,ZFSBOUNDARIES    !* Include the two prev. lines and close!
				    !* boundaries up again!
 J<.-Z;				    !* For the whole buffer.  ...!
    .-(:L.)+Q1 :"G		    !* Insert the key in the last column !
    0L				    !* as well, so it can be referenced from!
    Q1 XD			    !* either end.  QD gets the key!
    0L.-(:L.)+QB+Q1-1 F"G,32I'	    !* Make sure in the proper column!
      "#-1D 32i' GD'
    1L>				    !* Next line!
    WZJ'			    !* Go to the end of the buffer!


"# QLUI				    !* With no key length given, then do...!
    QI+1-QC"L Q:A(QI+1)-Q:A(QI)F"G,32I'W 13I10I'    !* Push first column down!
    0[Q 0UP WZJ W12I		    !* Push Temporary registers and make!
				    !* sure buffer terminates in a FF!
    J <.-Z;			    !* Find the maximum page length!
      1A-12 "N %Q W1L'		    !* Count lines!
      "# QQ-QPF"G +QPUP' W0UQ W1C'> !* Pagemark, then find if maximum!
    J 0UQ %P			    !* Add one for good measure!
    <.-Z;			    !* Make each page contain qP lines!
      1A-12 "N %Q W1L'		    !* padded out to proper width!
      "# QP-QQ<			    !* For each line!
	  QI-QC+1"LQ:A(QI+1)-Q:A(QI)F"G,32I' '	    !* Pad out with column!
				    !* width spaces!
	  13I 10I>		    !* Add a CRLF!
	%I W1C W0UQ' >		    !* Increment page no., skip FF, reset QQ!
    ZJ-D QLUI			    !* Get rid of last FF and reset QI!
    J W<.-Z;
    1A-12"E %I W1D'		    !* If FF then increment page number and!
				    !* delete the formfeed!
    "# Q:A(QI)F"G,32I' W:L .UD	    !* Make sure in the right column!
    QIUJ 0UK			    !* QJ get the temporary page number and!
				    !* QK is a special fudge!
    <:S
; R %J			    !* Go to next page and get the definition!
      0UP <.+QP-Z; %PA-12@:; W%J>
      QP-1F"G D'
      .(W:FXE K			    !* get the definition and make sure we can!
				    !* return to this location!
      QDJ GE .UD		    !* Back up and deposit the definition!
      )+FQEJ			    !* and go to the last location searched!
      .-Z; 1A-12"E		    !* If at end, quit.  Otherwise if next!
	QJ-1UJ %K		    !* character is a FF modify the temporary!
				    !* page number and the fudge.!
	-1L'>			    !* Go back up one line!
    QDJ 1L'  >			    !* Back to the top and skip a line!
  J WK WZJ'			    !* Kill blank line at top!


!^R Buffer Graph:! !^R Show a scale schematic of buffer in echo area.
Draws something like the following in the echo area:
|----B-----==[==--]---Z------------------------------------------|
     1      2     3      4      5     6      7      8     9
The |--...--| indicates the whole buffer, numbers approx tenths.
=== indicates the region.
B indicates the virtual buffer beginning.
Z indicates the virtual buffer end.
[---] indicates the window.!
     [.5
 [.0[.1[.2[.3[.4
 :f				    !* Ensure a valid window. *!
 .u.3 fnq.3j			    !* .3, ..N: Point, restored autoly. *!
 fs window+bj			    !* Go to top of window. *!
 fs lines f"E fs height-(fs echolines+1)' u.0    !* .0: Height of window. *!
 1:< q.0-1,0 :fm :l >		    !* Go to end of last screen line. *!
 .u.4				    !* .4: Window bottom. *!
 Q.5"E:i*C fs echo displayw'    !* Clear the echo area *!
 fsz"E				    !* Special case empty buffer. *!
    :I*CFS ECHO DISPLAYW
    @ft|mere corroborative padding intended to give artistic verisimilitude
 to an otherwise bald and unconvincing buffer|
    1 ^v 0f[help macrow	    !* Allow HELP to get help here. *!
         :fi-4110."E :i*C fs echo displayw
		     @ft(Semi-quote from "The Mikado", by Wm. Gilbert)

		     0fs echo activew
		     :ft !''!'
    w 1 '
    Q.5"N :I*TFS ECHO DISPLAYW'
 m.m&_Buffer_Dashes[D		    !* D: Dash macro.  Uses qregs:  *!
				    !*    .0: dash. *!
				    !*    .1: hpos. *!
				    !*    .2: last buffer pointer. *!
				    !*    .3: point. *!
 :i.0-				    !* .0: Start with - as dash. *!
 0u.1				    !* .1: Start hpos = 0. *!
 -1u.2				    !* .2: Start last ptr at beginning. *!

 @ft|				    !* Print buffer beginning. *!
 fs vb mD @ftB		    !* Dash and print virt buffer begin. *!
 fs window+b mD @ft[		    !* Dash and print window start. *!
 q.4 mD @ft]			    !* Dash and print window end. *!
 fsz-(fs vz) mD @ftZ		    !* Dash and print virt buffer end. *!
 fsz mD @ft|			    !* Dash and print buffer end. *!
 Q.5"E @FT

 0u.1				    !* .1: 0, echo area hpos. *!
 0u.0				    !* .0: 0, tenth number. *!
 9< fs width-3*%.0/10-q.1f(+q.1+1u.1)< @ft_ > q.0^:= >    !* Print tenths. *!
 @FT
 0fs echo activew'
 w 1 

!& Buffer Dashes:! !S === or --- whether in region or not.
ARG = pointer in buffer.
Uses global qregs:
    .0: Dash to print, - or =.
    .1: Last echo area hpos.
    .2: Last buffer pointer.
    .3: Point in buffer.!
 -1[p				    !* p: Maybe point.!
 -1[m				    !* m: Maybe mark.!
 :+1"G :-(fsz)-1"L		    !* Only indicate region if valid MARK.!
    q.3-q.2"G q.3--1"L q.3up''    !* .p: Point is in our range now.!
    :-q.2"G :--1"L :um''''  !* .m: Mark is in our range now.!
 qp,qmf umup			    !* Ensure p less than m.!

 qp+1"G fs width-8*qp/fsz-q.1f(<@ft.0> !* Dash to point.!
         )+q.1u.1		    !* .1: Hpos of point.!
	.0-="E :i.0-'"# :i.0='	    !* .0: Switch -/=.!
	'			    !* Done point.!

 qm+1"G fs width-8*qm/fsz-q.1f(<@ft.0>   !* Dash to mark.!
         )+q.1u.1		    !* .1: Hpos of mark.!
	.0-="E :i.0-'"# :i.0='	    !* .0: Switch -/=.!
	'			    !* Done mark.!

 fs width-8*/fsz-q.1f(<@ft.0>	    !* Dash to ARG.!
    )+q.1u.1			    !* .1: Hpos of ARG.!
 u.2				    !* .2: Update last ptr.!
 

!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)NCOLUMNSNCOLUMNS
1:<M(M.MDelete File)NCOLUMNS.COMPRS>W \
/ End: \
!    