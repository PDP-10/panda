!*-*- Teco -*-*!

!~Filename~:! !Macros for supporting Emacs TAGS file setup!
TAGGEN

!Generate Tags File:! !S Make updates to an existing TAGS file as needed
Reads a string argument of a TAGS file to be updated. The file must be in
standard tags file format... eg,
   <filename1>
   <digits>,<language>
   <optional-outdated-tags-text-which-may-extend-over-more-than-one-line>
   <control-underscore>
   <filename2>
   <digits>,<language>
   <optional-outdated-tags-text-which-may-extend-over-more-than-one-line>
   <control-underscore>
   ...etc...
!

  f[dfile			    !* Bind Teco Default File		!
  f[bbind			    !* Bind temp buffer			!
  fsmsnamefsdsname		    !* Default file uses working dir	!
  et FOO_TAGS 			    !* Default fn1,fn2 is FOO TAGS	!
  5,fTags_File[F		    !* Get filename in qF		!
  etF			    !* Use defaults			!
  e?"n :i*NSF	No_Such_Filefserr' !* Err if no such file	!
  er @y			    !* Yank file			!

				    !* Purge stale data if any		!

  <.-z;2l.,(sr.)kl>j		    !* Delete cruft			!

				    !* Process new tags stuff		!


  [T[F[N[L[P[X			    !* qT = Main Tags Table Buffer	!
				    !* qF = Temp Filehacking Buffer	!
				    !* qN = Filename being hacked	!
				    !* qL = Language being hacked	!
				    !* qP = Point of file data start	!
				    !* qX = Random Temporary		!

	    q..OuT		    !* Current buffer is qT		!
  f[bbindw q..OuF		    !* Make new buffer for qF		!
  qTu..O			    !* Get back tags buffer		!
  <.-z; .uP			    !* Stop at end of tags buffer	!
   1:xN				    !* Get filename into qN		!
   l 1a"d \w 1a-,"e oGoodSyntax''
     :i*SYN	Illegal_Syntax_in_Tags_File fserr
   !GoodSyntax!			    !* Come here if syntax correct	!
   d 0k i00000,		    !* Insert 5 digits			!
   1:xL				    !* Get language in qL		!
   l				    !* Put cursor in position		!
   qFu..O			    !* Get filehacking buffer		!
   f[dfile			    !* Bind default file		!
     e?N"n :i*FNF	File_Not_Foundfserr'
     er@y			    !* Yank file into buffer		!
   f]dfile			    !* Unbind default file		!
   1,m.m &_Tags_Process_L_Bufferf"n[0
     qT m0 w ]0'		    !* Macro hook if exists		!
   "#w :i*UTL	Unknown_TAGS_Language:_"L"!''!fserr'
   hk qTu..O			    !* Get Tags buffer back		!
   l .( .-qP:\uX fqX-5"g :i*FTL	File_Too_Largefserr'
        qPj l 5d 5-fqX,0i gX	    !* Insert Number of chars to jump	!
      )j			    !* Return where we started		!
  >				    !* Loop getting more files		!
  ew hp ef			    !* Write it out			!
  qFu..O			    !* Set up for unwinding		!
  				    !* Pop the world			!

!& Tags Default Snarf:! !& Snarf start of line to point into arg buffer
with a precomma arg, get arg1,point into arg2 buffer !

  g( .(				    !* Get point			!
     g( ff&2"n,.'"#0'x*(	    !*  ... but first preceding cruft	!
        [..O ))		    !*   ... but first change buffer    !
     i			    !*  ... and insert rubout		!
     )) i 
 w		    !* Return				!


!& Tags Process LSPDOC Buffer:! !& Process tags for a buffer of Lisp doc !

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
<:sBegin-Entry:;		    !* Find entry starts		!
 :l mS			    !* Snarf data			!
>				    !* Loop				!
				    !* Return				!

!& Tags Process MAXDOC Buffer:! !& Process tags for a buffer of Macsyma doc !

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
:<:s&;			    !* Search for & not preceded by ^Q  !
  fk+1+.,(@fll)mS		    !* Snarf data			!
 >				    !* Loop				!
				    !* Return				!

!& Tags Process BLISS Buffer:! !& Process tags for a buffer of BLISS code !

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
:<:S routine;		    !* Search for `routine`		!
    fk+1+.,(fwl)mS>		    !* Snarf the data, looping		!
				    !* Return				!

!& Tags Process Macsyma Buffer:! !& Process tags for a buffer of Macsyma code !

!*                                                                           *!
!*   In MACSYMA code, a function definition is recognized when there is      *!
!* a symbol at the beginning of a line, terminated with a "(" or "[",        *!
!* and there is a ":" later on in the line.  If the symbol itself is         *!
!* terminated with a ":", a variable definition is recognized.               *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* S: Useful tagging macro		!

[1				    !* 1: Temp for holding old position	!
< .u1				    !* q1 remembers this place		!
  :s;$"\/*;!'!;	    !* Search for interesting chars	!
  0a-*   "e   s*/       oEnd'   !* Ignore comments			!
  0a-"!'!"e r s\" !'! oEnd'   !* Ignore strings			!
  0a-\   "e c            oEnd'   !* Ignore \'d stuff			!
  !<!				    !* Fake out Teco looper		!
  q1,.( .u1 ):fb ::=:::==:=:=>"l
				    !* Finally, find label for line	!
    :l mS			    !*  if it is there, snarf it	!
    q1j'			    !* Move to end of field		!
  !End! >			    !* End of loop			!
				    !* Return				!

!& Tags Process LISP Buffer:! !& Process tags for a buffer of LISP code !

m.m &_Tags_Default_Snarf [S	    !* S: Useful tagging macro		!
			0 [0	    !* 0: Temp				!
      :i*
(DEF
(SETQ [1	    !* 1: Kinds of defs we seek		!
				    !*					!
j < :s(@DEFINE;		    !* Search for other stuff		!
   -@fll .-1,( 2@fll ),mS	    !* Index that, too, just for fun	!
   -@flx0 :i11
(0	    !* Get new @DEFINE thing to find	!
  >				    !* Loop				!
				    !*					!
j < :s1;			    !* Search for one of these		!
    -@fll 2@fll mS >		    !*  and index it if found		!
				    !*					!
				    !* Return				!


!& Tags Process SCHEME Buffer:! !& Process tags for a buffer of Scheme code !

f:m(m.m &_Tags_Process_Lisp_Buffer)   !* Go where we shoulda been	!


!& Tags Process TJ6 Buffer:! !& Process tags for a buffer of TJ6 code !

!*                                                                           *!
!*   In TJ6 text, any line which starts with .C TAG starts a tag.  The       *!
!* name of the tag is whatever follows the spaces which should follow the    *!
!* "C TAG", up to the next space or the end of the line.                     *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
<:s
.C_TAG_;			    !* Find tags			!
 @f_l :fb_"e :l' mS	    !* Snarf data			!
>				    !* Loop				!
				    !* Return				!


!& Tags Process MUDDLE Buffer:! !& Process tags in a buffer full of MDL code!

!*                                                                           *!
!*   In MUDDLE code, a tag is identified by a line that starts with          *!
!* "<DEFINE " or "<DEFMAC ", followed by a symbol.                           *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				    !
<:s
<DEFINE_
<DEFMAC_;	    !* Look for canonical definers	    !
 @fll mS			    !* Hop across the symbol and gobble tag !
>				    !* Loop				    !
				    !* Return				    !


!& Tags Process TECO Buffer:! !& Process tags in a buffer full of Teco code!

!*                                                                           *!
!*   In TECO code, a tag starts with an exclamation mark and ends with a     *!
!* colon followed by an exclamation mark. There may be any number of tags    *!
!* on a line, but the first one must start at the beginning of a line.       *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				    !
<:s
!;	    !* Search for ^L<return><excl>	    !
 <:fb:!;		    !* Search for <excl><colon>		    !
  :fb!"e :l 0; '>		    !* Hop across any number of tags	    !
 mS > 			    !* Snarf, Loop, Return		    !


!& Tags Process R Buffer:! !& Process tags in a buffer full of R code!

!*   In R code, any line which starts with ".de" or ".am" or ".rtag"         *!
!* defines a tag.  The name of the tag is what follows, up to the second     *!
!* run of spaces or the end of the line.  There is no ".rtag" in R;          *!
!* define it to be a null macro, if you like, and use it to put in tags      *!
!* for chapters, or anything else.  Any macro whose name starts with "de"    *!
!* or "am" or "rtag", such as ".define" or ".amplify", also defines a        *!
!* tag.                                                                      *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				    !
< :s
.de
.am
.rtag;	    !* Find the tags			    !
  -fwl @fll @f_	l	    !* Skip spaces			    !
  :fb_"e :l '			    !* Find next spaces set or end of line  !
   mS				    !* Snarf the tag			    !
> 				    !* Loop and return			    !


!& Tags Process MIDAS Buffer:! !& Process tags for buffer of MIDAS or MACRO-10!

!*                                                                           *!
!*   In MIDAS code, a tag is any symbol that occurs at the beginning         *!
!* of a line and is terminated with a colon or =.  Thus, MIDAS mode is       *!
!* good for MACRO-10 also.                                                   *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
<:s
; r fwl		    !* Go over first token		!
 1af:=:"l c  mS'		    !* If token ends in : or =, take it	!
>				    !* Loop				!
				    !* Return				!


!& Tags Process FAIL Buffer:! !& Process tags for buffer of MIDAS or MACRO-10!

!*                                                                           *!
!*   FAIL code is like MIDAS code, except that one or two 's or "^"'s      *!
!* are allowed before a tag, and spaces are allowed between the tag name     *!
!* and the colon or =, and _ is recogniized as equivalent to =.              *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				    !
<:s


^;		    !* Look for Linefeed + ^A, ^ or alpha   !
 r @f^ l @fll @f_	l  !* Go over first token		    !
 1af:=_:"l c mS'	    !* If it ends in a :, _, or =, take it  !
>				    !* Loop				    !
				    !* Return				    !


!& Tags Process TEXT Buffer:! !& Process tags in a buffer full of text!

!* Text buffers have no tags, BUT they are useful to have in tags tables for *!
!* Emacs Tags Search mapping harmlessly through them ...		     *!

				    !* Just return			!


!& Tags Process PALX Buffer:! !& Process tags in a buffer full of PALX code!

!*                                                                           *!
!*   PALX code is like MIDAS code, except that spaces are allowed between    *!
!* a tag and the following colon or equals, and local tags such as "10$"     *!
!* are ignored.                                                              *!
!*                                                                           *!

m.m &_Tags_Default_Snarf[S	    !* Get temp				!
<:s
; r fwl		    !* Go over first token		!
 0a-$"n			    !* If not a $ tag			!
  @f_	l		    !* Go over any whitespace		!
  1af:=:"l c  mS''		    !* If token ends in : or =, take it	!
> 				    !* Loop and return			!

