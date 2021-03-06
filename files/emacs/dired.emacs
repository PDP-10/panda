!* -*-TECO-*- *!
!* [MIT-OZ]PS:<EMACS>DIRED.EMACS.51,  2-Mar-83 09:32:17, Edit by SHSU!
!* Archive commands: RET, ARCH, DEL ARCH, CAN ARCH, SET INV, SET VIS!
!* Command Characters: R, A, D, -A, I, -I!
!* Move R (reverse sort) to -S!
!* Enter DIRED with < 0 arg -- do only offline files, archive requests,!
!* and invisible files !

!~FILENAME~:! !Directory Editor Subsystem!
DIRED

!& DIRED Delete File:! !S Delete current file.!
    0@l "L .-qb'"#.-z' "e fg 1 ' !* Barf at end of buffer.!
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
        1a-32"e fD '		    !* Mark one file as deleted.!
	"g @l ' >
    -f  			    !* Mark these lines as changed.!

!& DIRED Help:! !S Type our help msg.!
 m(m.mdescribe)&_DIRED 

!& DIRED Next Hog:! !S Move to the next file of which there are more than two (or arg) copies.!
 [5[6[7[8 .[9			    !* Q7 will point after last file in grp!
 @:i*|.+2f(j2<<:s.+1;c>>),.|[1 !* Q1 is string to get file.ext!
    0@l 1x5			    !* Skip current file and all with same FN1.!
    < @l .-z; 1f=5:@;>
    < 0@l .u8 .-z; 1x5 0@l	    !* FN1 to Q5, line location to Q8!
	-(ff"n ' "# 2' fo..q File_Versions_Kept)u6
	< @l .u7 .-z;    	    !* Look at files following this one!
	  1f=5:@; %6w >	    !* Count files with matching FN1!
        q6; >			    !* Stop if saw more than 2 (QFile Versions Kept) copies.!
  q8-z"E q9j fg 1  '		    !* Beep and exit if nothing found!
  
!* Q8 points at first file of group, q7 at last.  Both point at beginning of file's line.!
!* Now make sure, if possible, that entire group is on screen.!

 10f[%center fswindow"l :f'	    !* If window unknown, choose one putting point near top!
 f[^rvpos
 q7j @L 1f[reread 0@v		    !* Find out vpos of where Q7 points.!
 f]rereadw
 fs ^r vpos-(FSLINESF"EW FSHEIGHT-(FSECHOLINES)-1' "#-(FS TOPLIN)')(
   f]^r vpos
   )"G q8j 1:F'		    !* Won't fit in existing window => start on line 1.!
 q8j 0

!& DIRED Automatic Delete:! !S Put D's next to versions of the current file that need it. 
With an argument, the entire directory is processed, not just the current file.
Obeys File Versions Kept!

 FF"E :m( m.m &_DIRED_Automatic_One_File ) '   !* With no argument, use routine below!
 J2@L < .-z;			    !* Otherwise, iterate over the whole directory!
       m( m.m &_DIRED_Automatic_One_File ) R >
 J2@L 				    !* Go to front of directory and redisplay all!

!& DIRED Automatic One File:! !S Put D's next to deletable versions of one file.!

 0@L [0 2fo..Q File_Versions_Kept[2 !* Q2 gets number of versions to keep!
 @:i*|.+2,(2<<:s.+1;c>>.)|[1   !* Q1 is string to get file.ext!
 .-z"E fg 1  '		    !* Barf if at end (no file)!
 .f[VB 1x0 1[3		    !* Set buffer boundaries around files with this name!
 < @L .-z; 1f=0:@; %3>	    !* This puts . at start of first different line!
fsz-.f[VZ
 ZJ q3-q2"G			    !* If enough of this file!
 -Q2-1@L < FD b-.; -@L > '	    !* Mark all previous versions for deletion!
 QTemp_File_FN2_Listu0	    !* Mark all "temp" versions!
 J<.-z; <:s.+1;c>.,(<:s.+1;c>.):FB0"L 0@l FD' @L>
 J H 				    !* Exit with point at first file in group!

!& DIRED Undelete:! !S Undo the effect of a previous D command.!
    0@l "L .-qb'"#.-z' "e fg 1 ' !* Barf at end of buffer.!
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l qb-.; -@l '
	1a-D"e		    !* If this file is marked deleted,!	  di_ !<!		    !* remove the mark,!
	  18c 1:fb_=>_"n fkc:k'    !* and remove names of linked-to file to delete, if any.!
	  0@l'
	"g @l'>
    -f 			    !* Mark these lines as changed.!

!& DIRED Reverse Undelete:! !S Move up one line and undo a D.!
   -@l 1m(m.m &_DIRED_Undelete) (-@l)

!& DIRED View File:! !S Enter View File on the current file!
   [1 [2 f[D File		    !* Get out of magic dired environment!
   f[Window
   0@l "L .-qb'"#.-z' "e fg 1 '	    !* Barf at end of buffer.!
     < .-z;			    !* Iterate |arg| times, stop at end!
     "L qb-.; -@L '
     .+2,(2c <:s_	+2;c> .-1)x2 et2    !* Get file name,!
     m(m.m View_File)		    !* view file.!
     "G L ' >
   "G -L ' 			    !* Leave cursor on last file processed, full redisp!

!& DIRED Examine File:! !S Enter recursive ^R on the current file!
 [2 f[D File f[ Window 0[..F	    !* Get out of magic dired environment!
 0@l "L .-qb'"#.-z' "e fg 1 '   !* Barf at end of buffer.!
   < .-z;			    !* Iterate |arg| times, stop at end!
   "L qb-.; -@L '
   .+2,(2c <:s_	+2;c> .-1)x2 er2
   0fs d versw fs d fileu2
   0@L f[B Bind		    !* Get buffer!
   ^y				    !* But read in file the guy said!
   :I* [DIRED_Examine_Mode:__2_][..J FR !* Fix mode line!
   				    !* Enter ^R on it!
   "G @L ' >
 "G -@L ' 			    !* Leave cursor on last file processed, full redisp!

!& DIRED ..F:! !S ..F macro to make ^R understand DIRED commands.
It reads DIRED commands and executes them.  When a control- or
meta- character is typed, it is left for ^R to execute.!
    FS ^R MODE"E '		    !* Don't be confused if called when exiting DIRED ^R!
				    !* because DIRED was called from outside all ^R's.!
    [0 [1 [2 0 @V
    < 2,M.I @:FI:FCU0		    !* Read input with no prompting.!
      Q0F _XQUN?DKEHRSCVU1	    !* Is it a DIRED command that isn't a control-char?!
      Q0-200. F aaaaaaDK F"G U1' !* Is it ^D or ^K?  They are equivalent to D and K.!
      Q1+1"G FI			    !* Yes => run it.!
	FS ^R ARGP&2"N
	  FS ^R ARG' "# 1' U2	    !* Compute the arg like ^R.!
	FS ^R EXPT< Q2*4U2>
	FS ^R ARGP"N Q2' @M:DIRED_Dispatch(Q1)  !* Run the command.
!	( 0 FS ^R ARGPW  0 FS ^R ARGW  0 FS ^R EXPTW
	  -1FS ^R PREVW	    !* Flush the ^R arg we gave it.!
	 ) @V !<!>'		    !* Hand its values back to ^R.!
      @:FIU0 Q0&177.-137."G Q0-40.U0'	    !* Is it a ^R command?  Get 9-bit uppercase.!
      Q0 @FS ^R CMAC-( 32 FS ^R INIT)"E
	FG FI!<!>'		    !* Don't run anything self-inserting.!
      0;> 0			    !* Any other ^R command => return so ^R can gobble it.!

!& DIRED ^R Enter:! !S FS ^R ENTER for DIRED.
Puts & DIRED ..F into ..F so that this ^R becomes
a DIRED command loop.!
    0 F[ ^R ENTER		    !* Don't screw any recursive ^R's (eg minibuffer).!
    M.M &_DIRED_..F [..F
    1F[ ^R MDLY W 0F[ ^R MCNT
    M.V DIRED_Dispatch		    !* Make sure variable exists.!
    [ DIRED_Dispatch
    15*5 FS Q VECTOR[0
    Q0 U DIRED_Dispatch	    !* Create the dispatch table for DIRED commands.!
		    !* Note that the 15 slots correspond to the characters!
		    !* <space>XQUN<question>DKE<rub>HSRCV !
		    !* via the F in & DIRED ..F.!
    -1[1	    !* So fill the slots with appropriate macros.!
     FS ^R INIT U:0(%1)	    !* Space moves down a line.!
    27 FS ^R INIT U:0(%1)	    !* X exits the DIRED ^R.!
    27 FS ^R INIT U:0(%1)	    !* Q exits the DIRED ^R.!
    M.M &_DIRED_Undelete U:0(%1)   !* U takes away a delete-mark.!
    M.M &_DIRED_Next_Hog U:0(%1)   !* N finds next file with >2 versions.!
    M.M &_DIRED_Help U:0(%1)	    !* ? prints documentation.!
    M.M &_DIRED_Delete_File U:0(%1)	    !* D deletes this file.!
    Q:0(Q1) U:0(%1)		            !* So does K.!
    M.M &_DIRED_Examine_File U:0(%1)	    !* E edits!
    M.M &_DIRED_Reverse_Undelete U:0(%1)   !* Rubout undeletes backwards.!
    M.M &_DIRED_Automatic_Delete U:0(%1)   !* H puts in D's appropriately!
    M.M &_DIRED_Reverse_Sort U:0(%1)	    !* R does reverse sorting.!
    M.M &_DIRED_Sort U:0(%1)	            !* S does forward sorting.!
    M.M &_DIRED_SRCCOM_File U:0(%1)	    !* C calls SRCCOM!
    M.M &_DIRED_View_File U:0(%1)          !* V views the file.!
    ]1 ]0 0_			    !* No  so don't pop qDIRED Dispatch!

!<ENTRY>:! !& DIRED:! !& DIRED Enter:! !C Edit a directory.
The string argument may contain the filespec (with wildcards of course)
	Enters ^R mode with the directory in the buffer.
	D deletes the file which is on the current line. (also K,^D,^K)
	U undeletes the current line file.
	Rubout undeletes the previous line file.
	H puts D's by files that seem to need them.  ^UH does whole dir.
	Space is like ^N - moves down a line.
	N moves to the next file of which there are more than 2 copies.
	  (n M.VFile Versions Kept to find more than n copies).
	E edit the file in a recursive ^R.
        V calls View File on the current file.
	S sorts files according to size, read or write date.
	R does a reverse sort.
	C calls srccom on the current file.
	? types this cruft.
	Q lists files to be deleted and asks for confirmation:
	  Typing YES deletes them; X aborts; N resumes DIRED.
The D,U,E commands repeat if given an argument, backwards if negative.!

 f[ B Bindw f[ D File[0 f[ S Stringw 1f[ Fnam Syntax 0f[ %Center
 m.m&_DIRED_^R_Enter f[^R enter	    !* Make next ^R be a DIRED-command loop.!
 qBuffer_Filenamef"n fsdfile'w   !* Buffer filenames are default filenames.!
 et*.* -3fs dversionw		    !* set default for reading filename!
 5,2fDirectory_[1 et1	    !* Read filenames wanted.!
 fs osteco-2"e
    g1 j <:s;u1 q1+1; c>
    '
 "# g1 j <:s.u1 q1+1; c>
    q1"n <:s.u1 q1+1; c>''
 q1"e -3fsdversionw'
 fsdfileu1 hk ez1
 j 9i g(fs d dev)
 i:< g(fs d snam) i>
_
				    !* Put in name of directory!
 m.m&_Indent_Carefullyu1 0s,  !* Make things a bit faster.!
 < .-z; 2,32i <:s+1;c> -d 20m1w <:s+1;c> -d
   26m1w <:s+1;c> -d 46m1w
   .,.+11f=16-Nov-1858 "e i---.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not read!
   :fb"n -d fsxunameuJ	    !* Save user for compare!
   .u3 (:l.)u4 q3J (q4-q3) X2	    !* Save author for compare!
   (q4-q3)"E i--- -3c'#	    !* If there's no author, say so!
      f~J2"E q3J :k'' 66m1w'	    !* Flush author if it's us!
				    !* Allign last writer!
   :l fs width - (fs h pos) f"l d'	    !* Prevent continuation lines!
 @l> j 2@l
 ET GAZONK_.DEL		    !* Make sure writing it out doesn't clobber anything.!
 F[WINDOW
 10F[% Center 0fs modif
 [..J :I..J DIRED

 f<!DIRED-loop!
    f[ d file			    !* Don't let user clobber directory name within dired!
    0u..h 			    !* ^R mode to edit the direc!
    f] d file 		    !* Now can munge it.!
    J 2:@L :S
D"E  '			    !* If no files deleted, split!
    f[bbindw g(-1fsqpslot)	    !* copy the edited dir!
    ZJ <-@L .+2-Z:; K>		    !* Flush all blank lines from end.!
    j2@l < .-z; 1a-D"e @l '"# k'>   !* Kill lines not marked for deletion.!
    j 0s <:s;  c>	    !* Make sure things are quoted!
				    !* This changes all the ^Vs to ^Qs.!
    [.6 0[3 [2			    !* 3 is maximum length found so far!
    :i*[1 j2k			    !* 1 is string to check names against.!
    < .-z; 2d .u2		    !* 2 is start of this file.!
      <:s_	+2;c> r:k
      fsosteco-2"n 0@l2<<:s.+1;c>>r'   !* Move past filename and extension.!
		 "# -@:f;r'	    !* ...!
      q2,.f=1"e		    !* If names the same, ...!
        q2-2,.-1k f,		    !* Make one longer line.!
	'"# q2,.x1'		    !* Else get new string to use.!
      :@l 0,0:fm		    !* Make sure know where we are.!
      fs ^r hpos, q3 f  u3	    !* Keep track of the longest line so far.!
      @l > j
    fs width / (q3+1) u2	    !* Get number per line.!
    fs width / q2 u3		    !* Get rounded size for them.!
    < 0u1
      q2< :@l 0,0:fm .+2-z;
          %1-q2"n q3*q1 - (fs ^r hpos) , 40.i 2d'
	  > 2:c; >
    ]1]2]3
    z"e  '			    !* nothing to delete => return.!
    f<!ask! ftDeleting_the_following_files:
       ht ftOk?		    !* list files to delete, ask if ok!
        :i.6			    !* answer will go here!
	< fii -1 f(t)@fc	    !* input letter, echo, and capitalize!
	  0a-?"E -d 1;'	    !* print some help, reask!
	  0a-X"E f+ '	    !* exit, no deleting!
	  0a-N"E -d f;ask'	    !* no, re-edit directory!
	  -1  @fx.6		    !* add letter to .6!
	  f=.6YES"E f;DIRED-loop' !* ok, delete the files!
	  fq.6-2"G 1;'		    !* bad answer, give help!
	  >
				    !* print some help!
	f+ ft Choices_are:
	      YES	delete_the_files
	      X	exit_immediately
	      N	go_back_to_edit_mode
	      
	      			    !* now go back, reask!
	>
    ].6 f]bbindw		    !* Here if answer is N - pop to DIRED-loop level!
    >				    !* and go back and edit directory again.!

!*** Here after exiting DIRED-loop:  delete the files!
ft
Deleting_files...

 0u..h			    !* Unless something goes wrong, let ^R redisplay immediately.!
 [1 j 2@l
 < .-z;
   1 f=D"e 2c .,(<:s_	+2;c> r .)x1
	     1:<ED1>"N
		 FT_Delete_of_1_failed
		 ''
   @l >
 

!Reap File:! !C Delete old versions of a file.
Takes a filename as a string argument.
Offers to delete (and expunge) all but the most recent
versions of the file.
The number of versions kept is the numeric argument,
or File Versions Kept if no argument (usually 2).
If there are more than that many versions, you are told
about the excess and asked whether to delete them.!

    [1 [2 [6 [7 0F[CASE
    -F[FNAM SYN F[B BIND F[S STRING
    U6 FF"E 2FO..Q File_Versions_Kept U6
				    !* Q6 gets numeric arg, or File Versions Kept, or 2.!
                  Q6"E @FEAOR FS ERR''    !* Keeping 0 versions illegal unless explicit!
    Q6"L @FEAOR FS ERR'	    !* Negative # versions to keep is illegal,!
    0FO..Q Buffer_FilenamesF"E W' F[ D File'

    5,FFile_to_reapu7
    ET7			    !* Set default to spec'd filename.!
    -3fs dversW FSDFILEU7
    EZ7			    !* yank in a directory listing!
    J				    !* back to beginning to prettify!
    m.m&_Indent_Carefullyu1 0s,	    !* Make things a bit faster.!
    < .-z; <:S+1;c> -d 20m1w <:s+1;c> -d
      26m1w <:s+1;c> -d 46m1w		    !* Make it look nicer.!
      .,.+11f=16-Nov-1858 "e :ki---.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not read!
      :fb"n -d 66m1w'		    !* And allign last writer if there is one!
    @l>
    
    Z"E :I*No_files_named_7 FS ERR'

    j				    !* back to beginning!
    fs osteco-2"n @:i2|.(2<<:s.+1;c>>r),.|'   !* Q2: to get file.ext!
		"# @:i2|.(<:s.+1;c> <:s;+1;c> r),.|'
    < .-Z;			    !* Loop over FN1's.!
      2X1			    !* Q1 gets this FN1.!
      < @L .-Z;			    !* Find all files with this FN1.!
	2F=1"N 0@L 0;'>	    !* Stop after the last one.!
      FSZ-.FS VZ		    !* Set bounds around files with same FN1.!
      Q6M(M.M&_Reap_File_List)	    !* Ask about deleting some, if appropriate!
      0FS VZ >			    !* Lines were killed.  Consider next FN1.!
    30:			    !* Give user a chance to read printout,!
    0U..H			    !* then flush it.!
    

!& Reap File List:! !S Delete some of the files listed in the buffer.
The buffer should contain a part of a directory listing,
containing all the versions of a given file.  The number of
versions to keep should be given as a numeric argument.
This subroutine figures out which files ought to be deleted,
asks the user about them, and then deletes them after confirmation.
The buffer contents are all killed.  The virtual boundaries
are respected. Precomma argument causes these files not to be
mentioned at all if there are no files to delete (nothing is
typed out).

If a file matches Q$Temp File FN2 List$, this routine offers
to delete it.!

    F[D FILE [1 [2 [3 [4 [5 [F

!* Offer to delete each individual file that has FN2 in Q$Temp File FN2 List$.!

   :I*fo..QTEMP_File_FN2_Listu4
   bj
   <.-Z;			    !* loop over all files!
    :s.;			    !* Look for second filename.!
    .,(:S.w).-1:FB4"L	    !* And see if it's in the TEMP list.!
    !foo!
    0L .U2			    !* Beginning of filename!
    :s	_w	    !* Filename terminted by space or tab!
    .-1uF			    !* End of filename!
    FT Delete:_
    Q2,QFT FT_(Y_or_N):_
	     FSFLUSH"N F+ oFOO'  !* If not all output made it, try printing again.!
	     FIu5 Q5-"E	   !* ^L means redisplay screen and ask again.!
	       F+ oFOO'
	     FT5
	     Q5FYy+1"G	    !* Y means delete it.!
	       Q2,QFX5 1:<ED5>
	       FT_[OK]

	       0LK  !<!>'"# ft_[Saved]
''
    @L	 >			    !* Skip the rest of this line, since -GZ!
				    !*  might contain .s 		 -GZ!

				    !* Check for versions to delete.!

    "N J @L .-Z"E HK ''	    !* If have 2nd arg, and no files to delete!
				    !* just return - don't mention this file.!

    fs osteco-2"e		    !* 10X gives dir list backwards, so!
	zj .u2 <-@l .(1f (zj)g..o)j b-.; > b,q2k'  !* reverse it.!

!* delete all but last <arg> names from list.  default is 2!

    ZJ -@L .U2		    !* to end, back up over files to save!
 !Redisp!			    !* 2: below=save, above=delete!
    Q2J
    0FSFLUSHEDU3 Q3"N :FT'
    FTSaving_these_files:

    < .-Z; .,(@L). T>		    !* Type names of saved files.!
    
    Q2-B"E FT
...and_no_other_files_to_delete.

    HK '

    FT Delete_these_files?


    Q2J < B-.; .,(-@L).:  T 0@L>
    FT (Y_or_N)?_
    Q3"E FSFLUSHED"N FIW F+ O Redisp''    !* If flushed once, redisplay.!
	    !* Flushed twice => no use to redisplay.  We started at screen top this time.!
    FIU1 Q1-"E  F+ O Redisp'   !* ^L means "ask me again".!
    FT1
    Q2,ZK			    !* Once user answers, flush names of saved files.!

    Q1:FC-Y"N			    !* Don't delete any of these files!
				    !* unless user says "Y"!
	FT_[Saved]

	HK '

!* delete the files!
    J <.-Z; .,(<:s_	+2;c>).-1X1 1:<ED1>W @L>

    FT_[OK]

    HK 

!& DIRED Reverse Sort:! !S Sort the files in the buffer in reverse.!

    -:m(m.m&_DIRED_Sort)

!& DIRED Sort:! !S Sort files in the buffer by size, read- or write-date.!

    [0 [1 [2 :i*C fs echo disp  !* Clear echo area.!
    "l @ft Reverse_' @ft Sort_by_
    2,m.i < fi:fcu0
      q0-F"e @ft Filename :i1  :i2  1;'
      :i1 -2s-$ -@:f_ $@l  :i2 fs fdconv$
      q0-R"e @ft Read_date 1;'
      :i1 2< 1 >
      q0-W"e @ft Write_date 1;'
      :i1 1 -fw@l :i2 \ 
      q0-S"e @ft Size 1;'
      q0-?"e @ft (F_Filename,_S_Size,_R_Read_date,_W_write_date)_ !<!>'
      fg 0 >
    "l :i2 -(2)() '
    j 2@l .f[ vb
     c :@l 1 2  @l  

!& DIRED SRCCOM File:! !S Call up SRCCOM on the current file.!
  0l "L .-qb'"#.-z' "e fg 1 '   !* Barf at end of buffer.!
  0fo..qSRCCOM_switchesf"ew :i*/e/y'[2  !* get switches!
  [1   < .-z;		    !* Iterate |arg| times, stop at end!
    "L qb-.; -L '
   .+2,(2c <:s_	+2;c> .-1)x1   !* Extract filename!
   et1 fs dfileu1		    !* Make a complete filename!
   :i*12fs fork jcl	    !* Setup jcl!
   f+ ft -(fz SYS:SRCCOM.EXE)fz  !* Call up SRCCOM!
    "G L' >
  0

!Clean Directory:! !C Try to reap the specified directory.
Takes the directory name as a string argument;  default is visited one.
Does (essentially) MM Reap File on each file in the directory,
which finds the excess versions and offers to delete them.
A numeric arg specifies the number of versions to keep.!

    [0 [1 [2 [3 [6 F[B BIND F[S STRING f[ D FILE
    qBuffer_Filenamef"n fsdfile'w	    !* Buffer filenames are default filenames.!
    et*.* -3fs dversionw		    !* set default for reading filename!
    5,2fDirectory_u1 et1	    !* Read filenames wanted.!
    -3fsdversionw fsdfileu0
    EZ0
    U3 "E 2FO..Q File_Versions_KeptU3' !* Q3 has # versions to keep.!
    Q3:\U1			    !* Q1 has that number as a string.!
    J G(FS D DEV) I:< G(FS D SNAM) >I B,.FX6 J
    [..J :I..JChecking_6_for_files_with_more_than_1_versions... FR
    m.m&_Indent_Carefullyu1 0s,	    !* Make things a bit faster.!
    < .-z; <:S+1;c> -d 20m1w <:s+1;c> -d
      26m1w <:s+1;c> -d 46m1w		    !* Make it look nicer.!
      .,.+11f=16-Nov-1858 "e :ki---.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not read!
      :fb"n -d 66m1w'		    !* And allign last writer if there is one!
    @l> j
    fs osteco-2"n @:i2|.(2<<:s.+1;c>>r),.|'   !* Q2 is string to get file.ext!
		"# @:i2|.(<:s.+1;c> <:s;+1;c> r),.|'
    < .-Z;			    !* Loop over FN1's.!
      2X1			    !* Q1 gets this FN1.!
      < @L .-Z;			    !* Find all files with this FN1.!
	2F=1"N 0@L 0;'>	    !* Stop after the last one.!
      FSZ-.FS VZ		    !* Set bounds around files with same FN1.!
      1,Q3M(M.M&_Reap_File_List)   !* Ask about deleting some, if appropriate.!
      0FS VZ >			    !* Lines were killed.  Consider next FN1.!
    0U..H 			    !* Return no value, so screen will redisplay!

!& Indent Carefully:! !S Indent to specified column.
The argument should be the desired column.
Uses tabs and spaces;  deletes all tabs and spaces around
point before indenting.  Returns the range of buffer changed.!
    [0 [2
    @f_	k		    !* Delete all tabs/spaces after point.!
    @-f_	k		    !* Delete all tabs/spaces before point.!
!*    9i			       Ensure at least one tab.!
    fs hpos u0
    .(  /8-(q0/8)f"g ,9i          !* If can use tabs, use them!
                   &7,32i'        !* Followed by spaces for the rest.!
              "# -q0 :f"g w 1' ,32i'	    !* No tabs =) different way to figure # spaces.!
       ),.			    !* Return stuff good for giving to ^R.!


!*
 * local modes:
 * comment column: 36
 * compile command: m(m.mGenerate library)emacs:diredemacs:dired.emacs
 *
 * end:
 *!
   