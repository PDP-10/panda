!* -*-TECO-*-!
!* <EMACS>BUFED.EMACS.36,  7-Dec-81 11:49:33, Edit by GERGELY!
 
!~Filename~:! !Edit a list of all active Buffers in recursive ^R.!
BUFED

!<ENTRY>:! !C Major entry point is BUFED.!
    F:M(M.M BUFED)		    !* [PJG] To help the autoloading!

!Bufed:! !C Display information about all buffers.
A recursive ^R is entered on a list of all buffers.  On exit the buffer on the
current line is selected.  Point is initially on line of current buffer and
space is bound to exit ^R mode, so this is very much like MM List Buffers.

Symbols preceding the buffer number are:

    D - Buffer has been marked for deletion.
    F - Buffer can be changed, but the file is readonly.
    R - Both buffer and the file are readonly.
    * - Buffer has been modified (or so marked).

The following are the commands available:

    D - Mark <arg> Buffers for Deletion on exit.
    E - Examine (View) Buffer.
    M - Toggle Buffer's Modified Flag.
    Q - Quit, delete buffers marked, select buffer on current line.
    R - Toggle Buffer's Read only Flag (- Arg. = File read only,
					0      = Not read only
					+ Arg. = Buffer and File Read Only).
    S - Save Buffer's File.
    U - Undelete <arg> Buffers, Remove deletion marker.
    W - Write Buffer's File.
    ? - Type out this message.
    Space - Same as Q
    RubOut - Backward undelete <arg> Buffers.
    !

    [9 FN
    fsQPPtr[8			    !* 8: point to unwind before!
				    !* selecting a different buffer!
    [0[1[2[3[4[5[6[7[.6		    !* save regs!
    f[BBind			    !* get us a buffer!
    i_____Buffers_in_this_ gEditor_Name i
    _____#_Buffer____(Mode)_________Filename
    i
      QNext_Bfr_Number+1*5 FS Q Vector u9	    !* 9: State table!
    2u7				    !* 7: line count!
    0u4 fq.b/5u5		    !* 4: .B index, 5: stopping point!
    < q4-q5;			    !* Go thru buffer table; stop at end!
	q:.b(q4+4!*bufbuf!)[..o	    !* [PJG] make the buffer current so can!
				    !* check modified, readonly, etc.!
	Q:.B(Q4+12!*bufnwr!)U1	    !* [PJG] Check if read only!
	fsModifiedu2		    !* 2: nonzero if modified!
	fsZu3			    !* 3: no. of characters in buffer!
	]..o			    !*back to listing buffer!
	.u0			    !* 0: start address of this line!
	q:.b(q4+7!*bufnum!)u6 1u:9(q6)	    !* [PJG] 6: buffer index!
	q2"n i* q:9(q6)2 u:9(q6)'	    !* indicate if modified!
	"# i_'
	q1 f"n "L IF'		    !* [PJG] -: Buffer can be changed, but not!
				    !* the file!
	       "# iR'		    !* [PJG] Both cannot be changed!
	    q:9(q6)4 u:9(q6)'	    !* indicate if readonly!
	"# Wi_'
	6-(.-q0),q:.b(q4+7!*bufnum!)\	    !* [PJG] Type the buffer's number!
	i_ g:.b(q4+1!*bufnam!)	    !* [PJG] Type buffer's name,!
	17-(.-q0):f"gw 1',32i	    !* move to column 17!
	q:.b(q4+3!*bufmod!)u1	    !* [PJG] 1: buffer's major mode!
	qBuffer_Index-q4"e	    !* if current buffer!
	    qModeu1 q0u.6'	    !* then use current mode, and save .!
	i(1)			    !* Type major mode!
	32-(.-q0):f"gw 1',32i	    !* move to column 32!
	Q:.B(Q4+2!*bufvis!)U1 Q1"N  !* [PJG] Get the visited file if any!
	    G1			    !* [PJG] Insert it!
	    ET1		    !* [PJG] Set the default!
	Q:.B(Q4+9!*bufver!)U1	    !* [PJG] and actual version number.!
	FS D VERS:"G FS D VERS+1"N
	  I_(
	  FQ1"L Q1\' "# I1'
	  I)'''
	"# q3\ i__Characters'	    !* No filename, type the size!

	i
	     %7w		    !* add CRLF, increment line count!
	q:.b(q4)+q4u4		    !* advance past this buffer!
	>
    q.6"n q.6j'			    !* goto line with current buffer!
    fsLinesu6 q6"e fsHeight-(fsEchoLines)-1u6'   !* 6: current fsLines!
    q7+2-q6"l q7+2f[Lines'	    !* set fsLines so that only the amount!
				    !* of screen needed is used, reducing!
				    !* redisplay of rest of buffer.!
    0f[Window			    !* start display at top!
    1f[ Read Only		    !* Don't let him change it!
    m.m^R_BUFED_Delete[D	    !* Set up our functions!
    m.m^R_BUFED_Undelete[U	    !* !
    m.m^R_BUFED_Back_Undelete[ !* !
    m.m^R_BUFED_Toggle_Modified[M	    !* !
    m.m^R_BUFED_Toggle_R/O[R	    !* !
    m.m^R_BUFED_Save[S	    !* !
    m.m^R_BUFED_Write[W	    !* !
    m.m^R_BUFED_Examine[E	    !* !
    m.m^R_BUFED_Help[?	    !* !
    33. FS^R Init [_		    !* !
    33. FS^R Init [Q		    !* !
    m.m^R_BUFED_Help f[Help Mac   !* !
    :i*BUFED[..j		    !* use reasonable mode line!
    0[..F			    !* dont let user screw himself!
!^R! 				    !* let user see buffer, and move!
				    !* around!
    0l @f_*RFDl \u1		    !* get buffer number!
    q:9(q1)&9-1 "N		    !* If not legal!
	-1u0 fq9/5 u1 0u2	    !* Look for one that is!
	< %0-q1;		    !*!
	    q:9(q0)&9-1"E	    !* If we find one!
		1u2 0;'>	    !* Make note!
	q2 "N @FG o^R'		    !* If found, ring bell and try again!
	@FTDelete_All_Buffers_	    !* Else wants to kill everything!
	1m(m.m&_Yes_or_No) "E	    !* Get conformation!
	    o^R'		    !* No conformation - don't do it!
	1,:I*Main m(m.m&_Find_Buffer) u0  !* Look for Main!
	q0 :"L			    !* If it exists!
	    :I:.b(q0+1)XMain---XMain'	    !* Give it a random name!
	:I*Main m(m.m&_Create_Buffer)	    !* Make a new main!
	:@I..n\:IPrevious_BufferMain\    !* !
	fq9/5 u1'		    !* Get it's number,fall through!
    q1(q8fsQPUnwind)m(m.mSelect_Buffer)  !* select one he wants!
    -1[0 fq9/5 [1		    !* Kill the ones he said!
    < %0-q1;			    !* Stop at end!
	q:9(q0)&8 "N		    !* Marked for delete?!
	    q0 m(m.mKill_Buffer)'> !* Get rid of it!
    1 FSMode Change		    !* Just in case!
    


!^R BUFED Delete:! !^R Mark Buffer for deletion.!

    0 f[Read Only
    < 0@l @F_*$DJ \[0	    !* Get buffer number!
	q0 "N q:9(q0)8 u:9(q0)    !* Mark it!
	    0@l 2C D ID .-1,. F'
	1@l >
    0


!^R BUFED Undelete:! !^R Remove Deletion mark.!

    0 f[Read Only
    < 0@l @F_*$DJ \[0	    !* Get buffer number!
	q0 "N q:9(q0)&7 u:9(q0)	    !* Unmark it!
	    @0l 2C D I_ .-1,.F'
	1@l >
    0


!^R BUFED Back Undelete:! !^R Upline then undelete.!

    -1@l F@m(m.m^R_BUFED_Undelete) -1@l 0


!^R BUFED Toggle Modified:! !^R Toggle Modified Flag.!

    @0l @F_*$DJ \[0		    !* Get buffer number!
    Q0 "N 1,q0m(m.m&_Find_Buffer)[1	    !* Get its index!
	q1 "L '		    !* Something wrong here!
	q:9(q0)&2 "E 1'"# 0'[2	    !* Which way we are going!
	2*q2(13&q:9(q0)) u:9(q0)  !* Set flag!
	q:.b(q1+4)[..o		    !* select buffer!
	q2 fsModified		    !* Mark it!
	q2 fsX Modified
	]..o			    !* Back to list buffer!
	0 f[Read Only
	@0l D q2 "E I_'"# I*'
	.-1,.'
    0


!^R BUFED Toggle R/O:! !^R Toggle Read only flag.!

    @0l @F_*FRDJ \[0		    !* Get buffer number!
    q0 "N 1,q0m(m.m&_Find_Buffer)[1	    !* Get its index!
	q1 "L '		    !* Something wrong here!
	FF"N [2'
	"#q:9(q0)&4 "E 1'"# 0' [2'  !* [PJG] Which way?!
	q:9(q0)&11(4*(q2  )) u:9(q0)  !* Set flag!
	Q2 U:.b(q1+12)		    !* [PJG] Set the variable in the buffer!
	0 f[Read Only
	@0l C D q2 F"E WI_'"# "L IF' "# IR''
	.-1,.'
    0


!^R BUFED Save File:! !^R Save the buffer's File.!

    0@l @F_*$DJ \[7		    !* Get buffer number!
    q7 "E 0'			    !* no buffer!
    FSQP Ptr [8
    1,q7m(m.m&_Find_Buffer)[5	    !* Get its index!
    q:.b(q5+4)[..o		    !* select it!

!* The rest mostly stolen from ^R Save File.!

    FS MODIF"N 1FS X MODIF'	    !* If want real save,!
				    !* Make FS X MODIF nonzero if we need a real save.!
    q:.b(q5+2)[0		    !* Q0 gets appropriate filenames to save as.!
    Q0F"E W'F[D FILE
    FS DD FAST"L		    !* If disk or other device fast to open,!
	1:< ER FS IF CDATE[4 EC   !* See if date of existing file matches when we last!
	    Q:.B(Q5+8)[3	    !* read or wrote the file.!
	    Q4"N Q3"N Q4-Q3"N	    !* If not, warn user he may be losing.!
		      :I*A FS ECHO DIS
		      @FT This_file_has_been_changed_on_disk_since_you_last_read_or_wrote_it.
		      
		      FS X MODIF"N @FT Should_I_write_it_anyway
			1M(M.M &_Yes_or_No)"E 0''
		      "# @FT There_are_no_changes_in_core.__Use_Revert_File_to_read_the_version_off_disk.
			0FS ECHO ACT'
		      ''' >'
    FS X MODIFIED"E		    !* If don't need to write since no changes,!
	@FT			    !* tell the user so.!
	(No_changes_need_to_be_written)
	0FS ECHO ACT'
    Q0"E
	@:m(m.m^R_BUFED_Write_File)'
    FS OS TECO"N		    !* On Twenex,!
	fs xjname [j
	f~jSNDMSG"n		    !* Unless from cretinous Twenex mail program!
	    0FS D VERS"N	    !* always save as new version,!
		FS D FILEU0
		Q0U:.B(Q5+2)	    !* and permanently clobber visited version to 0.!
		1FS MODE CH'''
    1,M(M.M Write_File)0 u:.b(q5+8)

    Q8 FSQP Unwind		    !* Back to listing buffer!
    0 f[Read Only
    @0l D I_ q:9(q7)&13 u:9(q7)    !* No longer modified!
    .-1,.



!^R BUFED Write File:! !^R Write out Buffer.!

    0@l @F_*$DJ \[0		    !* Get buffer number!
    Q0 "E 0'			    !* No such buffer!
    1,Q0m(m.m&_Find_Buffer)[1	    !* Get its index!
    Q1 "L 0'			    !* Something wrong!
    Q:.b(Q1+2) f[D File	    !* Default to same name!
    Q:.b(Q1+4)[..o		    !* Select it!
    @m(m.mWrite_File) u:.b(Q1+8)   !* Write it out!
    QBuffer_Index-Q1 "N
	FSD File u:.b(Q1+2)'	    !* Change visited filenames!
    "# FSD File uBuffer_Filenames'	    !* One way or other!
    ]..o			    !* Back to list buffer!
    0 f[Read Only
    0@l D I_ q:9(q0)&13 u:9(q0)    !* Not modified!
    .-1,. 


!^R BUFED Examine:! !^R View Buffer contents!

    @0l @F_*$DJ \[0		    !* Get buffer number!
    Q0 "E 0'			    !* No buffer!
    1,Q0m(m.m&_Find_Buffer)[1	    !* Get its index!
    Q:.b(Q1+1) u1		    !* And its name!
    0 f[Lines			    !* Use the whole screen!
    m(m.mView_Buffer)1	    !* View it!
    0


!^R BUFED Help:! !^R Types out Help message.!

    0 f[Lines
    m(m.mDescribe)Bufed 

!*
/ Local Modes: \
/ MM Compile: 1:<M(M.M^R Date Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)BUFEDBUFED
1:<M(M.MDelete File)BUFED.COMPRS>W \
/ End: \
!
    