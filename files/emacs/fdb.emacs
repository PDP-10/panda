!* -*-TECO-*-!
!* <GERGELY.EMACS>FDB.EMACS.21, 17-May-81 13:17:51, Edit by GERGELY!
!* <GERGELY.EMACS>FDB..5, 23-Apr-80 08:10:37, Edit by GERGELY!
!~Filename~:! !Functions for reading the FDBs of a file!
FDB

!Get File FDB Reference Count:! !C Gets the reference count for many files.
The listing is put on a separate page appended to the buffer *FDB*.
    The numeric argument is passed on to the JFNS call!
    
    f[dfile 0f[dversion	    !* Push the default file!
    e[ fn e]			    !* Push the input and make sure it!
				    !* is popped when we exit!
    5,2FFile[A		    !* Get the filename!
    [F F[BBIND
    1,111110000001.ezA
    J :XA 1,110000000001.ezA
    J :XA 1K
    J <.-z;
	@I\ 1110000001.,-1M(M.M Get_Reference_Count)\:L 27i 1l>
    HXF f]BBIND
    M(M.M Select_Buffer)*FDB*
    0,fszfsboundarie
    ZJ 0,0a-12"N 12i 13i 10i 9i ga 13i 10i 13i 10i
	IFilename  17,32i IWrite_Date 10,32i
	IRead_Date 11,32I I__#W___#R 13i 10i
	'
    MF
    QPrevious_BufferUA
    M(M.M Select_Buffer)A
    

!Set File FDB Reference Count:! !C Sets the reference count for many files.
The precomma argument is the write count while the post comma is the
read count.  If any argument is left out the original values of
the fdb are used.!
    
    f[dfile 0f[dversion	    !* Push the default file!
    e[ fn e]			    !* Push the input and make sure it!
				    !* is popped when we exit!
    5,2FFile[A		    !* Get the filename!
    :\[B :\[C [D
    FF[E
    QE-2"G :IDB,C'
    QE-2"E :IDB,'
    QE-1"E QCUD'
    QE"E :ID'
    [F F[BBIND
    1,111110000001.ezA
    J <.-z;
	@I\DM(M.M Set_Reference_Count)\:L 27i 1l>
    HXF f]BBIND
    MF
    

!Get Reference Count:! !C Gets the number of file accesses.
A numeric argument implies the result is appended to buffer *FDB*
(negative implies already in *FDB*) else it is returned in the echo
area.  A pre-comma argument specifies the flags to the JFNS call
(Default: 111110000001.)!

    f[dfile 0f[dversion	    !* Push the default file!
    e[ fn e]			    !* Push the input and make sure it!
				    !* is popped when we exit!
    5,FFile[.A [a		    !* Get the filename!

    f[bbind
    1,111110000001.EZ.A J :FXA f]bbind
					    !* right file!
     1:< 1,erA>"N		    !* Open the file without changing!
				    !* the reference date!
	:I*AA_cannot_be_opened_for_read.fsechodisp  !* Output!
				    !* an error message! 
	0fsechoactive		    !* Keep it there!
	'
    
    fsifversionfsdversion
    fsdfileUA

    0,(W14.fsiffdb):fsfdconvert[W
    F~W16-nov-1858_20:00:00"E :IBNever'
    0,(W15.fsiffdb):fsfdconvert[B
    F~B16-nov-1858_20:00:00"E :IBNever'
    W 16.fsiffdb[C [D [E
    :I*18B17,QC M(M.M &_Bit_Decode_Number) UC UD

    FF"N			    !* Given an argument!
	"G M(M.M Select_Buffer)*FDB* !* Get the alternate buffer!
	    0UBuffer_Filenames	    !* Make sure it has no attached!
				    !* buffer filename!
	    ZJ 0,0A-10"N 13i10i'	    !* Add a CRLF if none existent!
	    '
	M.M &_Fast_Indent_With_Tabs[M	    !* QM get the indent macro!
	1,(W FF-1"G ' "#111110000001.')EZA -2d
	Wfshposition,25MM GW Wfshposition,45MM GB
	fshposition,65MM 4,QC\ Wfshposition,70MM 4,QD\ 
	13I 10I	    !* Output the stuff!
	"G QPrevious_Bufferua
	    M(M.M Select_Buffer)A
	    ' '
    "# QC:\UC QD:\UD		    !* Convert the numbers to text!
	:I*CAA_____W=[C]_W____R=[D]_B.(   !* Output the string!
	    )fsechodisp0fsechoactive		    !* in the echoarea and have it wait!
	'
    EC				    !* close the file!
    

!Set Reference Count:! !C Set the files reference count.
The two arguments are write,read count with the defaults being the old
values.!

    f[dfile 0f[dversion	    !* Push the default file!
    e[ fn e]			    !* Push the input and make sure it!
				    !* is popped when we exit!
    5,FFile[.A [a		    !* Get the filename!

    f[bbind
    1,111110000001.EZ.A J :FXA f]bbind
					    !* right file!
     1:< 1,erA>"N		    !* Open the file without changing!
				    !* the reference date!
	:I*CA_cannot_be_opened_for_read.
	fsechodisp		    !* Output an error message!
	0fsechoactive		    !* Keep it there!
	'

    W 16.fsiffdb[C [D [E
    :I*18B17,QC M(M.M &_Bit_Decode_Number) UC UE

    FF F"G -1"guc' ud'
    FF -3"L qeud'

    1:<QC*1000000.+qd,16.fsiffdb>"N
	:I*CInsufficient_Privileges_to_set_these_bits.
	No_action_taken.fsechodisp0fsechoactive
	'
    :I*AA__Set.fsechodisp0fsechoactive
    EC
    


!Get FDB Block:! !C Reads the File Directory Block for the file!
    0f[dversw f[dfile
    fsdfile[a w[b		    !* Push the temporary files!
    40.*5fsqvector[c		    !* QC will get the FDB block!
    [d [e [1			    !* Push another temporary file!
    5,fOpen_Fileub		    !* Get the filename to check!
    fqb :"G qaub'		    !* If nothing is given then make!
				    !* sure the default filename is!
				    !* used.!
    qbu:C(32.)			    !* At least we get to know the filename!
    1:<1,ERB>"N		    !* Open the file for read without!
				    !* updating the reference date.!
	:I*CB_cannot_be_found.
	fsechodisp 0fsechoactive !* Output an error message!
	'			    !* and quit.!
    fsifversfsdvers		    !* Get the right version number!
    fsifileub			    !* QB gets the corrected filename!
    0ud
    31.<qd fs iffdbu:c(qd) %dw>    !* Read the FDB block!
    0,q:c(5.):fs fd convertu:c(5.) !* Convert the times into a!
    0,q:c(13.):fs fd convertu:c(13.)	    !* readable form!
    0,q:c(14.):fs fd convertu:c(14.)
    0,q:c(15.):fs fd convertu:c(15.)
    0,q:c(23.):fs fd convertu:c(23.)
    f~(q:c(5.))16-Nov-1858_20:00:00"E:i*Neveru:C(5.)'
    f~(q:c(13.))16-Nov-1858_20:00:00"E:i*Neveru:C(13.)'
    f~(q:c(14.))16-Nov-1858_20:00:00"E:i*Neveru:C(14.)'
    f~(q:c(15.))16-Nov-1858_20:00:00"E:i*Neveru:C(15.)'
    f~(q:c(23.))16-Nov-1858_20:00:00"E:i*Neveru:C(23.)'
    8[..e
    M(M.M Select_Buffer)*FDB*
    0ubuffer_filenames
    hk w M(M.M ^R_Buffer_Not_Modified)
    ezB 
    m.m&_Fast_Indent_With_Tabsu1 0s,  !* Make things a bit faster.!
    -1@l <:s+1;c> -d 0,0:fm fsshpos,18m1w <:s+1;c> -d
    0,0:fm fsshpos,24m1w
    .,.+11f=16-Nov-1858 "e i_Never_.,(:fb"n.-1'"#:l.')k'
    <:s+1;c> -d 0,0:fm fsshpos,42m1w
    .,.+11f=16-Nov-1858 "e i_Never_.,(:fb"n.-1'"#:l.')k'
				    !* Handle case of file not read!
    :fb"n -d 0,0:fm fsshpos,64m1w'	    !* And allign last writer if there is one!
    @2:l 13i 10i 13i 10i
    IFDB_for_B 13i 10i
    13i 10i
    IWord	Contents
    
    0ud 32.<2,qd\ 9i 13i10i %d>
    0udJ 6l
    :l :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBHDR__-__Header_Word:_qaf"N\ i,,' qb\ 
    :i*6B35,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
    qa"N :l 13i 10i i	__
	iFB%LEN___(77B35= QA\ !)!
	!(!I)_-_Length_of_the_FDB:_10U..E QA\ 8u..E'
    w%d 1:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBCTL__-__Status_Bits:_qaf"N\ i,,' qb\
    qa"N
	:i*1B0,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%TMP___(1B0=1)_-_File_is_temporary:_YES'
	:i*1B1,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%PRM___(1B1=1)_-_File_is_permanent:_YES'
	:i*1B2,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%NEX___(1B2=1)_-_File_does_not_have_a_file_type:_YES'
	:i*1B3,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%DEL___(1B3=1)_-_File_is_deleted:_YES'
	:i*1B4,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%NXF___(1B4=1)_-_File_nonexistent,_first_write_incomplete:_YES'
	:i*1B5,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%LNG___(1B5=1)_-_File_is_longer_than_512_pages:_YES'
	:i*1B6,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%SHT___(1B6=1)_-_Reserved_for_DEC:_ON'
	:i*1B7,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%DIR___(1B7=1)_-_File_is_a_deirectory:_YES'
	:i*1B8,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%NOD___(1B8=1)_-_File_will_not_be_saved_by_backup:_YES'
	:i*1B9,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%BAT___(1B9=1)_-_File_may_contain_bad_pages:_YES'
	:i*1B10,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%SDR___(1B10=1)_-_Directory_has_subdirectories:_YES'
	:i*1B11,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%ARC___(1B11=1)_-_File_has_archive_status:_YES'
	:i*1B12,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%INV___(1B12=1)_-_File_is_invisible:_YES'
	:i*1B13,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%OFF___(1B13=1)_-_File_is_offline:_YES'
	:i*4B17,q:C(QD)M(M.M&_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iFB%FCF___(17B17= qa\ i)_-_File_Class_Field:_
	    qa-1"E iRMS_File' "# iValue_=_ qa\' '
	'w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBEXL__-__Link_to_FDB_of_next_file_type:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBADR__-__Disk_address_of_index_block:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBPRT__-__File_access_bits:_qaf"N\ i,,' qb\
    w%d w2:l
    i.FBCRE__-__Time_of_last_write:_g(q:c(qd))
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBAUT__-__Author_of_file:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBGEN__-__Generation_and_Directory_numbers:_qaf"N\ i,,' qb\
    QA"N  :l 13i 10i i	__
	iFB%GEN___(777777B17= qa\ i)_Generation_Number:_ 10u..e qa\
	8u..e 46i'
    qb"N :i*1b7,q:c(1)M(M.M&_Bit_Decode_Number)uaw
	qa"N:l 13i 10i i	__
	    iFB%DIR__(777777B35= qb\ i)_Directory_Number:_ qb\' '
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBACT__-__Account_Designator:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBBYV__-__File_I/O_information:_qaf"N\ i,,' qb\
    q:C(QD)"N
	:I*6B5,Q:C(QD)M(M.M&_Bit_Decode_Number)UAW
	:l 13i 10i i	__
	IFB%RET___(77B5= QA\I)_Retention_Count:_ 10u..e qa\ 46i 8u..e
	:i*6B11,q:C(QD)M(M.M&_Bit_Decode_Number)uaw
	:l 13i 10i i	__
	iFB%BSZ___(77B11= qa\ i)_File _Byte _Size:_10u..e qa\ 46i
	8u..e
	:i*4B17,q:C(QD)M(M.M&_Bit_Decode_Number)uaw
	:l 13i 10i i	__
	iFB%MOD___(17B17= qa\ i)_Data_Mode_of_Last_Open:_ qa\
	QB"N :l 13i 10i i	__
	    iFB%PGC___(777777B35= qb\ i)_Page_Count_of_File:_10u..e qb\
	    46i 8u..e' '
    w%d w2:l
    I.FBSIZ__-__Number_of_bytes_in_file:_10u..e q:c(qd)\ 46i 8u..e
    w%d w2:l
    i.FBCRV__-__Creation_time_of_file:_g(q:c(qd))
    w%d w2:l
    i.FBWRT__-__Time_of_last_user_write:_g(q:c(qd))
    w%d w2:l
    i.FBREF__-__Time_of_last_nonwrite_access:_g(q:c(qd))
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBCNT__-__Count_of_writes,,references:_ 10u..e qa\ 46i i,, qb\
    46i 8u..e
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBBK0__-__Word_1_for_backup_system:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBBK1__-__Word_2_for_backup_system:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBBK2__-__Word_3_for_backup_system:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBBBT__-__Word_4_for_backup_system:_qaf"N\ i,,' qb\
    qa"N
	:i*1B1,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%RAR___(1B1=1)_-_User_requested_archive:_YES'
	:i*1B2,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%RIV___(1B2=1)_-_System_request_for_involuntary_migration:_YES'
	:i*1B3,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%NDL___(1B3=1)_-_No_delete_contents_on_archival_completion:_YES'
	:i*1B4,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%NAR___(1B4=1)_-_Resist_Involuntary_archiving:_YES'
	:i*1B5,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%EXM___(1B5=1)_-_File_is_exempt_from_involuntary_migration:_YES'
	:i*1B6,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%1ST___(1B6=1)_-_First_pass_of_archival_run_in_progress:_YES'
	:i*1B7,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%RFL___(1B7=1)_-_Restore_failed:_YES'
	:i*1B10,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%WRN___(1B10=1)_-_Offline_expiration_date_is_approaching:_YES'
	:i*3B17,q:c(qd)M(M.M &_Bit_Decode_Number)ua w
	qa"N :l 13i 10i i	__
	    iAR%RSN___(7B17=QA\WI)_B1=File_expired,_B2=Arch._Req.,_B3=Mig._Req.'
	'
    QB"N :l 13i 10i i	__
	iFB%PGC___(777777B35= qb\ i)_Deleted_page_count:_10u..e qb\
	46i 8u..e'
    w%d w2:l
    i.FBNET__-__On-line_expiration_date_and_time:_g(q:c(QD))
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBUSW__-__User_settable_word:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBGNL__-__Address_of_FDB_for_next_generation:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBNAM__-__Pointer_to_filename_block:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBEXT__-__Pointer_to_file_type_block:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FBLWR__-__Last_writer_to_file:_qaf"N\ i,,' qb\
    w%d w2:l
    :i*18b17,Q:C(qd)M(M.M&_Bit_Decode_Number)ua ubW
    i.FB???__-__Length_of_FDB:_qaf"N\ i,,' qb\w%d w2:l
    J :L -fwxe			    !* QE get the author name!
    :S.FBLWR"L !<! :l -fwl \ud :l i_==>_E
	-:S.FBAUT"L :l -fwl
	    \-qd"E !<! :l i_==>_E' ' '
    J


!& Bit Decode Number:! !S Decodes a number.
The first argument (a string in the form <mask>B<bit number>)
specifies how to decode it.  The second argument is the number to
decode.!
    FF-2"L			    !* If we do not have two!
				    !* arguments, then!
	:i*CWrong_Number_of_arguments_were_given.
	fsechodisp		    !* Print error message!
	0fsechoactive '	    !* and exit.!
    [A [B [C [D [E [F		    !* Push the tempory registers.!
    UA UC			    !* QA gets the mask and bit!
				    !* number, while QC gets the!
				    !* number to decode.!
    F[BBIND			    !* Use a temporary buffer.!
    GA J			    !* Recall QA!
    \  UA			    !* Mask goes into QA!
    1:C "E
	:i*CUnexpected_end_of_field_encountered.
	fsechodisp		    !* Print error message!
	0fsechoactive '	    !* and exit.!
    
    \  UB			    !* QB gets the bit number to use.!
    f]BBIND			    !* Kill the temporary buffer.!
    QB"E qc&377777777777.uf
	qc&400000000000.ue
	qf,qe'
    0uf qa+qb-35"E 1uf'
    1ud qa<qd*2ud> qd-1ua
    QB-35"G			    !* If bit location is longer than!
				    !* a word.!
	:i*CBit_Location_is_longer_than_a_word.
	fsaechodisp		    !* Print error message!
	0fsechoactive '	    !* and exit.!
    1ud				    !* QD gets the shift!
    35-qB<qd*2.ud>
    qc&(qd-1)ue			    !* QE gets the remainder of the!
				    !* number to the right.!
    (qa*qd)+(qf*400000000000.)uf
    QC&qfuf
    qf/qd uf			    !* QF gets the information.!
    qf"Lqf-777777000000.uf'
    qe,qf			    !* Return both values!


!& Fast Indent with Tabs:! !S Fast indent subroutine.
Args are current column and column to indent to.  If the current
column is greater than or equal to the goal column than a single
space is put in.  Uses both tabs and spaces.!
    - :"G 32i '
    /8-(/8)f"g ,9i		    !* If can use tabs, use them!
	&7,32i'		    !* Followed by spaces for the rest.!
    "# -,32i'		    !* No tabs =) different way to figure!
				    !* # spaces.!
    
  