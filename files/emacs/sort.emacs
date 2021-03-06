!* -*-TECO-*- !

!~Filename~:! !Commands for sorting the buffer.!
SORT

!Sort Lines:! !C Sort the region alphabetically line by line.
Numeric arg means sort into reverse order.
Use M-X Undo to undo the sort.!

    :I*sortm(m.m &_Save_Region_and_Query)f"e '
    :,.f [0f[vb		    !* Put B at start of region, point at end.!
    q0j 0@f  "n :@l .-z"e i	    !* Move to a line-start.  If no CRLF, make one.!
' "# 2c''
    fsz-.f[vz			    !* Now set Z, making sure it's after a CRLF.!
    -1F[ ^Pcase
    ff"n :' l
    

!Sort Pages:! !C Sort the region alphabetically page by page.
You should put a page separator after the last page before sorting.
If you don't, one will be made automatically.  It will not be
deleted automaticaly afterward.  Use M-X Undo to undo the sort.
Numeric arg means sort into reverse order.!


    :I*sortm(m.m &_Save_Region_and_Query)f"e '
    f[vb f[vz :,.f fsbound
    zj 0@l QPage_Delimiter[0
    :s0w
    0@f  "n .-z"e O Win'' !* If there's a page delimiter at the end already, fine.!
    zj 0@f  "n i
'				    !* Otherwise, insert a CRLF if not one already!
    g0 fkc :s"l r.,zk'	    !* and insert a page delimiter.!
  !win!
    m.m ^R_Next_Page[1
    -1F[ ^Pcase
    ff"n :'  @f 
_r  1m1w     !* Do the sort.!
   

!Sort Paragraphs:! !C Sort the region alphabetically paragraph by paragraph.
Numeric arg means sort into reverse order.
Use M-X Undo to undo the sort.!

    :I*sortm(m.m &_Save_Region_and_Query)f"e '
    -1F[ ^Pcase
    :,.f [0f[vb		    !* Put B at start of region, point at end.!
    q0j 0@f  "n :@l .-z"e i	    !* Move to a line-start.  If no CRLF, make one.!
' "# 2c''
    fsz-.f[vz			    !* Now set Z, making sure it's after a CRLF.!
    m.m ^R_Forward_Paragraph[1
    ff"n :'  @f
 _r1m1w
    

!Make Page Permutation Table:! !C Specify how to reorder the pages.
Leaves you in buffer *Permutation Table* editing
the first lines of all pages in the buffer you were in.
You can permute these lines and then have that translate to the real
buffer with Permute Pages From Table.!

 [1[2[3[F 0fsVBw 0fsVZw j		!* Top of open buffer.!
 :i1					!* 1: Collects table.!
 :ft					!* Typeout from screen top.!
 m.m&_Maybe_Flush_Outputuf		!* F: Typeahead checker.!

 <  !* Now at 1st line of page.!
    .:\u2				!* 2: Point of page 1st line.!
    @f
	_l .-z;			!* Forward past whitespace.!
    :l fsSHPOS-(fsWidth)+8f"gr'w 0x3	!* 3: First (nonblank) line.!
    :i112	3
					!* 1: Accumulate 1st lines.!
    ft2	3
					!* Tell user our progress --!
					!* this isnt wasted either!
					!* since we will redisplay!
					!* this when done.!
    mf1;				!* Done if any typeahead.!
    :s;			!* To next page.!
    >					!* And repeat on it too.!

 m(m.mSelect_Buffer)*Permutation_Table*	!* To table buffer.!
 hk g1 j				!* Empty it (virtual) and get!
					!* the new table.!
 

!Permute Pages From Table:! !C Permutes current buffer into another.
Creates a new file, in the buffer *Permuted Buffer*, which is constructed
by taking pages from the current buffer in the order specified by the
table in the buffer *Permutation Table*.  (You can make such a table to
permute with the function Make Page Permutation Table.)!
 
 [1[2[3[4[5 0fsVBw 0fsVZw		!* Wide bounds.!
 q..ou1					!* 1: Buffer to be permuted!
 m(m.mSelect_Buffer)*Permutation_Table* q..ou2 j	!* 2: table!
					!* buffer.!
 m(m.mSelect_Buffer)*Permuted_Buffer* hk q..ou3	!* 3: Destination!
					!* buffer, where sorted stuff!
					!* goes.!
 [..o					!* Ensure return to this!
					!* buffer, even if get an!
					!* error.!

 <  q2u..o				!* To sort table buffer.!
    @f
	_l .-z;			!* Past any whitespace user!
					!* may have left.!
    1af0123456789"l :i*No_number_herefsErr'	!* Check.!
    \u4					!* 4: Point for next page.!
    l					!* Past that sort table line.!
    q1u..o				!* To buffer to be sorted.!
    q4:j"e q4:\u4 :i*Cannot_find_point_4_in_buffer_to_permutefsErr'
					!* At page start.!
    ."g					!* Page start not top of!
					!* buffer.!
      0a-14."n q4:\u4 :i*Point_4_not_at_page_startfsErr'	!* ...!
      2 f~
     "e 2c''				!* ^L CR LF is page separator.!
    .,(:s"l r'"# zj').x5	!* 5: The whole page.!
    q3u..o				!* To destination buffer.!
    g5 i
					!* Copy the page there.  Will!
					!* clean up extra, final ^L CR!
					!* LF at end.!
    >					!* Go get more pages.!

 q3u..o					!* To destination buffer.!
 zj -3 f=
"e -3d'				!* Delete extra page separator.!
 j					!* Leave user at top.!
 
  