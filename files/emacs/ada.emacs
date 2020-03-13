!* -*-TECO-*- *!

!~FILENAME~:! !Functions for editing Ada code.!
ADA

!Ada Mode:! !& Ada Mode:! !C Set up for editing Ada code.
Tab indents for next Ada statement.  Meta-I is ^R Indent Relative.
M-O is ^R Ada Template, which inserts a template for the statement started.
^R Backward Sexp and ^R Forward Sexp move over Ada objects;
^R Kill Sexp and ^R Backward Kill Sexp delete them.
An Ada object is an identifier, string, or parenthesized expression.!
 m(m.m& Init Buffer Locals)		!* flush previous mode!
 1,(:i*--)m.lComment Start		!* set comment variables!
 1,(:i*-- )m.lComment Begin		!* ...!
 1,40m.lComment Column			!* ...!
 1,(m.m^R Ada Indent)m.qI		!* Tab: indent under previous line!
 1,(m.m^R Indent Relative)m.q..I	!* M-I: indent under previous line!
 1,(m.m^R Ada Template)m.q..O	!* M-O: template hack!
 1,q(1,q.m.qw)m.q.	!* tab hacking rubout!
 !* now create a ..D with Lisp syntax appropriate for Ada!
 m.q..D				!* local ..D!
 0fo..qAda ..Df"nu..d'"#		!* if already exists, use it!
    :g..du..d				!* otherwise copy previous one!
    -1u1 0<%1*5+1:f..d >		!* [NUL,0) are breaks!
    10<%1*5+1:f..dA>			!* [0,9] are constituents!
    A-9-1<%1*5+1:f..d >		!* (9,A) are breaks!
    26<%1*5+1:f..dA>			!* [A,Z] are constituents!
    a-Z-1<%1*5+1:f..d >		!* (Z,a) are breaks!
    26<%1*5+1:f..dA>			!* [a,z] are constituents!
    128-z-1<%1*5+1:f..d >		!* (z,DEL] are breaks!
    _*5+1:f..dA			!* underscore is a constituents!
    (*5+1:f..d(			!* parentheses are parentheses!
    )*5+1:f..d)			!* ...!
    "*5+1:f..d| !'!		!* quote for strings!
    \*5+1:f..d/			!* backslash is quote!
    q..dm.vAda ..Dw'
 1m(m.m& Set Mode Line)Ada 		!* set mode line, run hook, etc.!

!^R Ada Indent:! !^R Move to column for next Ada statement.
Does not work properly if you put multiple statements per line.!

 m(m.m& Declare Load-Time Defaults)
    Ada => Indentation,: 4
    Ada begin Indentation,: 4
    Ada declare Indentation,: 4
    Ada do Indentation,: 4
    Ada else Indentation,: 4
    Ada exception Indentation,: 4
    Ada is Indentation,: 4
    Ada loop Indentation,: 4
    Ada private Indentation,: 4
    Ada record Indentation,: 4
    Ada select Indentation,: 4
    Ada then Indentation,: 4


 !* Note: could use @:fwl to move over tokens until end of line or comment
    start instead a simple search.  Wins in face of comment start in strings. *!

 .[1[2[3[4				!* 1: where we started!
 -@f	 l 10,0a-10"n q1j f:m(m.m^R Indent Relative)'
					!* if not at beginning of line, do!
					!* indent relative instead!
 !* Find first nonblank line (not including comments).!
 <  b-.; -l				!* exit if beginning of buffer, else try!
					!* previous line!
    :f :fb--: -@f	 l		!* find first nonblank before comment!
    0,0a-10@:;				!* exit if not at beginning of line,!
    0l >				!* i.e. there's text before the comment!
 ;,0a-;"e 0u2'			!* 2: extra indentation of 0 for!
					!* beginning of buffer or semicolon!
 "# !<!-2 f==>"e !<!qAda => Indentationu2'
    "# -@fwx3				!* get last identifier of line!
       2fo..qAda 3 Indentationu2''	!* 2: extra indentation, use 2 if not!
					!* known (i.e. if in middle of!
					!* statement)!
 !* Find start of this statement by moving backward until end of previous!
 !* statement.!
 .u4					!* 4: first nonblank line of this!
					!* statement!
 <  -l b-.;				!* previous line, exit if beginning!
    :f :fb--: -@f	 l		!* find first nonblank before comment!
    0a-;@;				!* semicolon, exit!
    !<!-2 f==>"e 0;'			!* exit if when terminator!
    0a"c -@fwx3 -1fo..qAda 3 Indentation;'	!* exit if known keyword!
    0a-10"n .u4'			!* if nonblank line, remember it!
    >
 q4j 0l @f	 l fsSHpos+q2u2	!* 2: total indentation!
 q1j fsSHposu1				!* 1: indentation where we started!
 q1-q2"l q2:m(m.m& Indent)'		!* before indent point, move there!
 f:m(m.m^R Indent Relative)		!* past indent point, indent relative!

!^R Ada Template:! !^R Insert template for keyword just typed.!
 .[1[2[3				!* 1: where we started!
 -@:fwl -@fwf(l)x2			!* 2: keyword!
 1,m.m# Ada 2u3			!* 3: function for keyword!
 q3"n :m3'				!* goto function!
 :i*No template for 2fsErr		!* give error!

!# Ada while:! !# Ada for:! !S Insert template for WHILE and FOR!
 0[4					!* 4: loop label if any!
 -@f	 l 0,0a-10"e -l :f :fb--: -@f	 l'
					!* move back to previous token!
 0,0a-:"e r -@fwx4'			!* if colon, then pick up loop label!
 q1j 0l @f	 l fsSHposu3 q1j i loop
 0,q3m(m.m& XIndent)w iend loop
 q4"n 32i g4' i;
 q1,.(q1j)

!# Ada if:! !S Insert template for IF!
 fsSHposu3 q1j i then
 0,q3m(m.m& XIndent)w iend if;
 q1,.(q1j)

!# Ada case:! !S Insert template for CASE!
 m(m.m& Declare Load-Time Defaults)
    Ada case Indentation,: 4

 fsSHposu3 q1j i is
 0,q3+qAda case Indentationm(m.m& XIndent)w iwhen others =>
 0,q3m(m.m& XIndent)w iend case;
 q1,.(q1j)

!# Ada begin:! !S Insert template for BEGIN!
 0[4					!* 4: loop label if any!
 -@f	 l 0,0a-10"e -l :f :fb--: -@f	 l'
					!* move back to previous token!
 0,0a-:"e r -@fwx4'			!* if colon, then pick up loop label!
 q1j 0l @f	 l fsSHposu3 q1j i
 0,q3+qAda loop Indentationm(m.m& XIndent)w .u2 i
 0,q3m(m.m& XIndent)w iend
 q4"n 32i g4' i;
 q1,.(q2j) 

!# Ada loop:! !S Insert template for LOOP!
 0[4					!* 4: loop label if any!
 -@f	 l 0,0a-10"e -l :f :fb--: -@f	 l'
					!* move back to previous token!
 0,0a-:"e r -@fwx4'			!* if colon, then pick up loop label!
 q1j 0l @f	 l fsSHposu3 q1j i
 0,q3+qAda loop Indentationm(m.m& XIndent)w .u2 i
 0,q3m(m.m& XIndent)w iend loop
 q4"n 32i g4' i;
 q1,.(q2j) 

!# Ada declare:! !S Insert template for DECLARE!
 0[4					!* 4: loop label if any!
 -@f	 l 0,0a-10"e -l :f :fb--: -@f	 l'
					!* move back to previous token!
 0,0a-:"e r -@fwx4'			!* if colon, then pick up loop label!
 q1j 0l @f	 l fsSHposu3 q1j i
 0,q3+qAda declare Indentationm(m.m& XIndent)w .u2 i
 0,q3m(m.m& XIndent)w ibegin
 0,q3m(m.m& XIndent)w iend
 q4"n 32i g4' i;
 q1,.(q2j) 

!# Ada record:! !S Insert template for RECORD!
 0l @f	 l fsSHposu3 q1j i
 0,q3+qAda loop Indentationm(m.m& XIndent)w .u2 i
 0,q3m(m.m& XIndent)w iend record;
 q1,.(q2j) 

!*
 * Local Modes:
 * Comment Column:40
 * End:
 *!
