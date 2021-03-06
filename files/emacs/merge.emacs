!* -*-TECO-*-!
!* <GERGELY.NEMACS>MERGE.EMACS.10,  9-Feb-82 12:06:21, Edit by GERGELY!
!~Filename:! !Make changes specified by SRCCOM to a file.!
MERGE

!& Setup Merge Library:! !S Set-up the locals and other required stuff.
    0fo..q MERGE_Setup_Hook[0
    fq0"G :M0' ]0
    

!SRCCOM Update:! !C Update buffer from COMPARE file.
String argument is comparison filename.  The buffer is assumed to correspond
to the first file used in the comparison.  Changes are made to the buffer to
make it identical to the second file.!

    f[DFile				!* Push the default filename!
    f6COMPAREfsDFN2w			!* Make COMPARE the default extension!
    0fsDVersionw			!* The current version number!
    5,4fSRCCOM_file[1		!* Read in a filename!
    q..o[2				!* 2:  The current buffer pointer!
    [3 [4 [5 [6 [7 [8 [9		!* Push temporary registers!
    f[BBind				!* Get a temporary buffer!
    er1 @y				!* Read in the comparison file!
    0f[BothCase			!* Ignore case in searches!
    0,17f=
;COMPARISON_OF_"n			!* First line must contain the!
					!* filenames !
	:i*Format_error_in_comparison_filefsErr'

    17j :fb_AND_"e
	:i*Format_error_in_comparison_filefsErr'

    17,.-5x3				!* 3:  The filename of the original!
					!* file !
    :x4					!* 4:  The filename of the new file!

    l 13 f=;OPTIONS_ARE_"n		!* Next line must contain the options!
	:i*Format_error_in_comparison_filefsErr'

    l :f  "n				!* Next line must be blank!
	:i*Format_error_in_comparison_filefsErr'
    0u7 1l				!* 7:  Current number of character!
					!* different between the compution of!
					!* the position in the old buffer!

    < .-z;				!* For the whole file!
	fq3+12 f=****_FILE_3,_"n	!* First file!
	    :i*Format_error_in_comparison_filefsErr'
	fq3+12c
	\w 0,1a--"n			!* Format is Page - Line number!
	    :i*Format_error_in_comparison_filefsErr'
	c \w				!* Ignore page and line number!
	2 f=_(!)!"n			!* The character position is in ()!
	    :i*Format_error_in_comparison_filefsErr'
	2c \u5				!* 5:  Character position of old!
					!* buffer!
	!(! 3 f=)
	"n				!* Line must terminate with close!
					!* parenthesis!
	    :i*Format_error_in_comparison_filefsErr'
	1C .+2( :s
	    ****_FILE_4,_"e	!* Look for the new file changes!
		:i*Format_error_in_comparison_filefsErr'
	    ),.+fk+2x8			!* 8: Change in old buffer!

	\w 0,1a--"n
	    :i*Format_error_in_comparison_filefsErr'
	c \w
	2 f=_(  !)! "n
	    :i*Format_error_in_comparison_filefsErr'
	2c \u6
	!(!  3 f=)
	"n
	    :i*Format_error_in_comparison_filefsErr'
	1C
!*	q5+q7-q6"n
	    :i*Format_error_in_comparison_filefsErr'!
	.+2(
	    :s
***************

"e					!* Search for terminator to these!
					!* changes !
		:i*Format_error_in_comparison_filefsErr'
	    ),.+fk+2x9			!* 9: Changes in the New file!
	q2[..o				!* Get the buffer here!
	!* Q6J!
	Q5+Q7j				!* Go to the location of the change!
	fq8 f=8f"n  -1C		!* Check if it is really here!
	    :i*Portion_to_change_does_not_match_the_original_filefsErr'
	fq8d g9				!* Delete the old and insert the new!
	q7+fq9-fq8u7			!* Recompute the differences!
	]..o >				!* Pop to differences and continue!


!*
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)MERGEMERGE
1:<M(M.MDelete File)MERGE.COMPRS>W \
/ End: \
!
 