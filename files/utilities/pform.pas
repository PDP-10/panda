(*&D+*)         (* pform switch -- use Denny Brown formatting style *)
(*$c+*)         (* pascal switch -- perform runtime checks *)

(*Contents*)

(*Page   description*)

(*01*)
(*02*)                          (* Title page *)
(*03*)  (*Description and history*)
(*04*)  (*Valid switches*)
(*05*)  (*Start of program*)
(*06*)  (*Var*)
(*07*)     (*Initialization:*)  (*Initprocedures,hash,find_sy,firstdef,reinitialize,initialize*)
(*08*)     (*Ccl scanner:*)     (*Getdirectives[setswitch]*)
(*09*)     (*Page control:*)    (*Newpage*)
(*10*)     (*Output procs:*)    (*Block[error,writeline,vardef,procdef,popoff*)
(*11*)        (*Scanner:*)      (*Insymbol[readbuffer[readline],resword,proccall*)
(*12*)           (*Parenthese,docomment[nextchar,options]*)
(*13*)           (*] Insymbol*)
(*14*)        (*Parsing of declarations:*)      (*Recdef[casedef,parenthese]*)
(*15*)        (*Parsing of statements:*)        (*Statement[endedstatseq,compstat,casestat,loopstat,ifstat,labelstat,repeatstat]*)
(*16*)        (*] Block*)
(*17*)     (*Main program*)


(*02*)                          (*Title page*)

(**********************************************************************
 *
 *
 *                      P f o r m
 *                      ---------
 *
 *       Reformats (prettyprints) a pascal source program.
 *
 *       Input:  pascal source file.      (oldsource)
 *       Output: reformatted source file. (newsource)
 *
 *       Default input extension: none.
 *       Default output extension: .new
 *       Default output file name: same as the input name, with extension .new
 *
 *       Machine dependency: uses features supported by the pascal/passgo
 *       compilers for DEC-10, DEC-20, as implemented by Armando R. Rodriguez
 *       at Stanford University.
 *
 *       Implementor: Armando R. Rodriguez
 *                    P.O. Box 5771
 *                    Stanford, CA 94305
 *                    U.S.A.
 *
 *       Distributor: J. Q. Johnson
 *                    LOTS computer facility
 *                    Stanford University
 *                    Stanford, CA 94305
 *                    U.S.A.
 *
 *       From an original cross-reference processor written by
 *       Manuel Mall, University of Hamburg (1974) and distributed
 *       with the Hamburg compiler for DEC-10, DEC-20 computers, by Decus.
 *
 *
 *       Part  of  the  developement  effort  applied  to  this  programs  was
 *       performed as  part  of  the effort  in  developement  of  programming
 *       languages and compilers at  Stanford University, under a  subcontract
 *       from LawrenceLivermore Laboratory to the computer science department,
 *       principal investigarors  Profs.  Forest  Baskett and  John  Hennessy,
 *       contract no.  ...  LLL PO9628303.  The S-1 work hardware  development
 *       has been supported by the department of the navy via office of  naval
 *       research   order  numbers   00014-76-F-0023,  N00014-77-F-0023,   and
 *       N00014-78-F-0023 to the University  of California Lawrence  Livermore
 *       Laboratory (which  is operated  for  the  U.S. Department  of  Energy
 *       under contract no.   W-7405-ENG-48), from the  computations group  of
 *       the  Stanford  Linear  Accelerator  Center  (supported  by  the  U.S.
 *       Department of Energy under  contract no.  EY-76-C-03-0515), and  from
 *       the  Stanford  Artificial  Intelligence  Laboratory  (which  receives
 *       support from the  Defense Advanced Research  Projects Agency and  the
 *       National Science Foundation).
 *
 (**********************************************************************


(*03*)           (*Description and history*)

(**********************************************************************
 *
 *	Mar-80. Richard J. Beigel
 *		+ fix some bugs
 *		+ make save-comment visible
 *		+ stop adding page marks every 4000 lines
 *
 *      Jan-81. Richard J. Beigel
 *              + fix bug in reading tabs
 *              + add the save-comment switch
 *
 *      Sep-80  Richard J. Beigel
 *              + modify to run under Pascal 20
 *
 *      May-80. Richard J. Beigel
 *              + implement capitalization of procedure names
 *              + fix newpage to not eat the first page mark
 *              + change some defaults
 *
 *      Apr-80. Richard J. Beigel
 *              + add the super, quiet, and bar switches
 *              + fix indention algorithm (mostly)
 *              + improve docomment (no longer capitalize i.e., e.g., p.o.,
 *                                   and the like)
 *              + implement runtime switches
 *
 *      Feb-80. Richard J. Beigel
 *              + fix bugs in docomment and recdef
 *              + add the capitalize, setcom, and denny switches
 *
 *      Jul-79. Armando R. Rodriguez.
 *              + separate it into pform and pcref
 *              + adapt it for the lineprinter at sail.
 *              + improve the implementation of statement counts.
 *              + fix bugs
 *
 *      Mar-79. Armando R. Rodriguez
 *              + implement statement counts.
 *
 *      Dec-78. Armando R. Rodriguez (Stanford)
 *              + speed up and cleanning of the code.
 *              + fix small bugs.
 *
 *      Jul-78. Armando R. Rodriguez (Stanford).
 *              + improve the cross reference listing.
 *              + listing of proc-func call nesting.
 *              + report the line numbers of begin and end of body of procedures.
 *
 *      Mar-78. Armando R. Rodriguez (Stanford).
 *              + a new set of switch options.
 *              + some new errors are reported.
 *
 *      Date unknown. Larry Paulson (Stanford).
 *              + make the files of type text
 *              + not as many forced newlines.
 *              + the report on procedure calls was cancelled.
 *
 *
 (**********************************************************************)


(*04*)          (*Valid switches*)

(*---------------------------------------------------------------------
 !
 !  Valid switches are:                     brackets indicate optional.
 !                                          <n> stands for an integer number.
 !  (defaults in parens are at SAIL)        <l> stands for a letter.
 !
 !  Switch          meaning                                         default.
 !
 !           Files.
 !   /Version:<n>    behave as if conditionally compiling %<n>
 !                     comments.                                    -1
 !
 !           Page and line format
 !   /Indent:<n>     indentation between levels.                    4
 !
 !   /Preserve       preserves your own indentation                 Off
 !
 !   /Save-comment   if set, causes indentation of comments to be
 !                     preserved.  Otherwise, they will be
 !                     indented like statements.                    Off
 !
 !   /Rigid-comment  like save-comment, but the first line of
 !		       a comment is indented like a statement
 !		       and the indentation of the remaining lines
 !		       is preserved relative to it.		    Off
 !	
 !   /Bar            [*] causes comments
 !                    *  like this one
 !                    *  to be indented correctly.
 !                   [*] (with parentheses of course)
 !
 !           Statement format
 !   /Begin:[-]<n>   if the [-] is not there, the contents of a
 !                     begin..end block is indented n spaces further.
 !                   If it is there, the block will not be indented,
 !                     but the begin and end statements will be
 !                     exdented n spaces.                           -2
 !                                        (or as specified by /indent)
 !
 !   /Force      forces newline in standard places. (Before and
 !                     after begin, end, then, else, repeat, etc.)  Off
 !
 !   /Super      forces newline after semicolon and sets force
 !                     (no need to specify the /force option)       off
 !
 !   /Denny      puts programs into denny brown's format.
 !                     it is not compatible with /begin:.
 !
 !                     It sets endexd to -feed overriding /begin.
 !                     It also prevents the /force
 !                     option from causing newline after do, else, or
 !                     then.  Also puts reserved words into lower case,
 !                     unless you specify otherwise.                Off
 !
 !           Upper and lower case
 !                          Note: the possible values for <l> are:
 !                                  U means upper case.
 !                                  L means lower case.
 !                                  C means capitalize where appropriate.
 !                                  S means same case -- unchanged
 !
 !   /Res:<l>        case used for reserved words.                  U
 !   /Nonres:<l>     case for non-reserved words.                   L
 !   /Comm:<l>       case for comments.                             S
 !   /Str:<l>        case for strings.                              S
 !   /Proc:<l>       case for procedures                            C
 !   /Case:<l>       resets all the defaults to <l>.                Off
 !
 !
 !   If set, the c switch will capitalize sentences in comments, put
 !   strings  in  all-capitals, and  capitalize  reserved words  and
 !   identifers.
 !
 !              Miscellaneous switches.
 !   /Quiet    suppress runtime progress reports.
 !
 +--------------------------------------------------------------------*)

(*05*)

program Pform;

    include 'p:pascmd.pas','p:string.pas';

const
    ht = 9;
    nul = 0;

    version = 'PFORM/LOTS 2.1.2 6-JAN-80';
    verlength = 10;
    backslash = '\';
    linsize = 600;                 (*Maximum size of an input line*)
    linsiz1plus = 601;             (*Linsize + 1*)
    linsizplus2 = 602;             (*Linsize + 2*)
    blanks = '          ';         (*For initializing strings*)
    maxinc = maxint;               (*Maximum allowable line number*)
				   (* used to be 4000, but why? *)
    linnumsize = 5;
    tablesize = 996;               (* For hash table of procedure names *)
    oneplustablesize = 997;

    undefined = 0;
    uppercase = 1;
    samecase = 2;
    lowercase = 3;
    capitalize = 4;



type

    casetype = undefined..capitalize;

    pack6 = packed array[1..6] of char;
    pack9 = packed array[1..9] of char;
    pack15 = packed array[1..15] of char;

    errkinds = (begerrinblkstr,missgend,missgthen,missgof,missgexit,
		missgrpar,missgquote,missgmain,missgpoint,linetoolong,
		missgrbrack,missguntil,missgcommentend);

    symbol = (labelsy,constsy,typesy,varsy,programsy,             (*Decsym*)
	      functionsy,proceduresy,initprocsy,                  (*Prosym*)
	      endsy,untilsy,elsesy,thensy,exitsy,ofsy,dosy,eobsy, (*Endsymbols*)
	      beginsy,casesy,loopsy,repeatsy,ifsy,                (*Begsym*)
	      recordsy,forwardsy,gotosy,othersy,intconst,ident,strgconst,externsy,(*Langsy,*)forsy,whilesy,
	      (* Langsy is unnecessary: 'fortran' translates to externsy *)
	      rbracket,rparent,semicolon,comma,point,lparent,lbracket,colon,eqlsy,otherssy(*Delimiter*));

    linenrty = 0..maxint;
    pagenrty = 0..maxint;

    stacktype = packed record
			   top: boolean;
			   next: ^stacktype;
		       end;

    entry = packed record (* A linked list (for procedure names) *)
		       string: alfa;
		       next: ^entry;
		       stack: ^stacktype;
		   end;

    list = ^entry;

    tableindex = 0..tablesize;


    (*06*)          (* Variable declarations *)

var
    pm: char;
    rtime: integer;
    definitions: integer;
    proctable, baretable: array[tableindex] of list;

    (*                  (*Input control*)
    (*                  (***************)

    bufflen,                              (*Length of the current line in the input buffer*)
    buffmark,                             (*Length of the already printed part of the buffer*)
    bufferptr,                            (*Pointer to the next character in the buffer*)
    syleng: integer;                      (*Length of the last read identifier or label*)

    (*                  (*Nesting and matching control*)
    (*                  (******************************)

    level,                                (*Nesting depth of the current procedure*)
    variant_level,                        (*Nesting depth of variants*)
    errcount: integer;                     (*Counts the errors encountered*)

    (*                  (*Formatting*)
    (*                  (************)

    indentbegin,                          (*Indentation after a begin*)
    begexd,                               (*Exdentation for begin*)
    endexd,                               (* Exdentation for end *)
    feed,                                 (*Indentation by procedures and blocks*)
    spacepreserve,                        (* Number of spaces at the beginning
					   of a line. *)
    nextspaces,                           (* Indentation for the next line
					   as computed so far *)
    presentspaces,                        (* Indentation for current line *)
    goodversion,                          (*Keeps the value of the version option*)
    pagecnt,                              (*Counts the file pages*)
    line500,                              (*To give a tty message every 500 lines*)
    linecnt : integer;                    (*Counts the lines  per file page*)

    tabs: array [1:17] of char;           (* A string of tabs for formatting*)

    lower, upper: array [char] of char;     (* for changing cases *)


    (*                  (*Scanning*)
    (*                  (**********)

    buffer  : array [-1..linsizplus2] of char;   (*Input buffer*)
    (*         Buffer has 2 extra positions on the left and one on the right*)

    linenb : packed array [1..5] of char; (*Sos-line number*)
    prog_name: alfa;                      (*Name of current program*)
    sy      : alfa;                       (*Last symbol read*)
    syty    : symbol;                     (*Type of the last symbol read*)

    (*                  (*Version system*)
    (*                  (****************)

    (*                  (*Switches*)
    (*                  (**********)

    savecom,                              (* Set if comments get indentation preserved *)
    rigidcom,				  (* Set if comments are to be indented rigidly (each line the same amount) *)
    elseifing,                            (*Set if the sequence else if should stay in one line*)
    (*    Debugging, (not implemented) *)     (*Set if the unprinted counts are to be reported*)
    forcing,                              (*Set if then, else, do, repeat, etc. Will force newline*)
    super,                                (*Forcing and putting newline after semicolon*)
    preserving,                           (* Preserving indentation *)
    dennying,                             (* Denny brown's format *)
    barring,                              (*) Comments set up
					   *  like this comment *)
    (*                                    (*)
    quiet,                                (* Don't give runtime progress
					   reports (doesn't affect format) *)
    counting,                             (*Counting functions and procedures*)
    anyversion: boolean;                  (*Set if goodversion > 9*)


    (* The following switches tell whether to capitalize, make all upper case
     or make all lower case the following:                *)
    rescase,                        (* Reserved words *)
    nonrcase,                       (* Nonreserved words *)
    comcase,                        (* Comments *)
    proccase,                       (* Procedure calls *)
    strcase                         (* Strings *)
    : casetype;


    (*                  (*Other controls*)
    (*                  (****************)

    comment_at_boln,                     (* Comment is at beginning of line:
					  required for constant indentation *)
    notokenyet,                           (*Set in each line until the first token is scanned*)
    thenbeginning,                        (* Removing crlf from between then
					   and begin for /denny *)
    endelseing,                           (* Removing crlf from between end
					   and else for /denny *)
    thendo,                               (*Set whenever 'nextspaces := nextspaces+dofeed' is executed*)
    elsehere,                             (*Set while an else token is to be printed*)
    fwddecl,                              (*Set true by block after 'forward', 'extern'*)
    oldspaces,                            (*Set when presentspaces should be used -- usually means beginnning of line*)
    eoline,                               (*Set at end on input line*)
    programpresent,                       (*Set after program encountered*)
    nobody,                               (*Set if no main body is found*)
    invars,                               (*While parsing var and type declarations*)
    eob     : boolean;                    (*Eof-flag*)
    errmsg : packed array[errkinds,1..40] of char;      (*Error messages*)
    ch : char;                           (*Last read character*)

    (*                  (*Sets*)
    (*                  (******)

    delsy : array [char] of symbol;       (*Type array for delimiter characters*)
    resnum: array['A'..'['] of integer;   (*Index of the first keyword beginning with the indexed letter*)
    reslist : array [1..46] of alfa;      (*List of the reserved words*)
    ressy   : array [1..46] of symbol;    (*Type array of the reserved words*)
    alphanum,                             (*Characters from 0..9 and a..z*)
    digits : set of char;                 (*Characters from 0..9*)
    openblocksym,                         (*Symbols after which a basic block starts*)
    relevantsym,                          (*Start symbols for statements and procedures*)
    prosym,                               (*All symbols which begin a procedure*)
    decsym,                               (*All symbols which begin declarations*)
    begsym,                               (*All symbols which begin compound statements*)
    endsym  : set of symbol;              (*All symbols which terminate  statements or procedures*)


    (*                  (*Pointers and files*)
    (*                  (********************)

    old_name: pack9;
    oldsource: text;
    oldfilename: packed array[1..50] of char;

    newsource: text;
    newfilename: packed array[1..50] of char;

    (*07*)  (*Initialization:*)  (*Initprocedures,reinitialize,initialize*)

initprocedure;
begin (*Reserved words*)
    resnum['A'] :=  1;    resnum['B'] :=  3;    resnum['C'] :=  4;
    resnum['D'] :=  6;    resnum['E'] :=  9;    resnum['F'] := 13;
    resnum['G'] := 18;    resnum['H'] := 19;    resnum['I'] := 19;
    resnum['J'] := 22;    resnum['K'] := 22;    resnum['L'] := 22;
    resnum['M'] := 24;    resnum['N'] := 25;    resnum['O'] := 27;
    resnum['P'] := 30;    resnum['Q'] := 33;    resnum['R'] := 33;
    resnum['S'] := 35;    resnum['T'] := 36;    resnum['U'] := 39;
    resnum['V'] := 40;    resnum['W'] := 41;    resnum['X'] := 43;
    resnum['Y'] := 43;    resnum['Z'] := 43;    resnum['['] := 43;

    reslist[ 1] :='AND       '; ressy [ 1] := othersy;
    reslist[ 2] :='ARRAY     '; ressy [ 2] := othersy;
    reslist[ 3] :='BEGIN     '; ressy [ 3] := beginsy;
    reslist[ 4] :='CASE      '; ressy [ 4] := casesy;
    reslist[ 5] :='CONST     '; ressy [ 5] := constsy;
    reslist[ 6] :='DO        '; ressy [ 6] := dosy;
    reslist[ 7] :='DIV       '; ressy [ 7] := othersy;
    reslist[ 8] :='DOWNTO    '; ressy [ 8] := othersy;
    reslist[ 9] :='END       '; ressy [ 9] := endsy;
    reslist[10] :='ELSE      '; ressy [10] := elsesy;

    reslist[11] :='EXIT      '; ressy [11] := exitsy;
    reslist[12] :='EXTERN    '; ressy [12] := externsy;
    reslist[13] :='FOR       '; ressy [13] := forsy;
    reslist[14] :='FILE      '; ressy [14] := othersy;
    reslist[15] :='FORWARD   '; ressy [15] := forwardsy;
    reslist[16] :='FUNCTION  '; ressy [16] := functionsy;
    reslist[17] :='FORTRAN   '; ressy [17] := externsy;
    reslist[18] :='GOTO      '; ressy [18] := gotosy;
    reslist[19] :='IF        '; ressy [19] := ifsy;
    reslist[20] :='IN        '; ressy [20] := othersy;

    reslist[21] :='INITPROCED'; ressy [21] := initprocsy;
    reslist[22] :='LOOP      '; ressy [22] := loopsy;
    reslist[23] :='LABEL     '; ressy [23] := labelsy;
    reslist[24] :='MOD       '; ressy [24] := othersy;
    reslist[25] :='NOT       '; ressy [25] := othersy;
    reslist[26] :='NIL       '; ressy [26] := othersy;
    reslist[27] :='OR        '; ressy [27] := othersy;
    reslist[28] :='OF        '; ressy [28] := ofsy;
    reslist[29] :='OTHERS    '; ressy [29] := otherssy;
    reslist[30] :='PACKED    '; ressy [30] := othersy;

    reslist[31] :='PROCEDURE '; ressy [31] := proceduresy;
    reslist[32] :='PROGRAM   '; ressy [32] := programsy;
    reslist[33] :='RECORD    '; ressy [33] := recordsy;
    reslist[34] :='REPEAT    '; ressy [34] := repeatsy;
    reslist[35] :='SET       '; ressy [35] := othersy;
    reslist[36] :='THEN      '; ressy [36] := thensy;
    reslist[37] :='TO        '; ressy [37] := othersy;
    reslist[38] :='TYPE      '; ressy [38] := typesy;
    reslist[39] :='UNTIL     '; ressy [39] := untilsy;
    reslist[40] :='VAR       '; ressy [40] := varsy;

    reslist[41] :='WHILE     '; ressy [41] := whilesy;
    reslist[42] :='WITH      '; ressy [42] := othersy;
end (*Reserved words*);


initprocedure;
begin (*Sets*)
    digits := ['0'..'9'];
    alphanum := ['0'..'9','A'..'Z'] (*Letters or digits*);
    decsym := [labelsy,constsy,typesy,varsy,programsy];
    prosym := [functionsy..initprocsy];
    endsym := [functionsy..eobsy];      (*Prosym or endsymbols*)
    begsym := [beginsy..ifsy];
    relevantsym := [labelsy..initprocsy (*Decsym or prosym*),beginsy,forwardsy,externsy,eobsy];
    openblocksym := [thensy,elsesy,dosy,loopsy,repeatsy,intconst,colon,exitsy]
end (*Sets*);


initprocedure;
begin (*Error messages*)
    errmsg[begerrinblkstr] := 'Error in block structure: BEGIN expected';
    errmsg[missgend      ] := 'Missing   ''END''  statement              ';
    errmsg[missgthen     ] := 'Missing   ''THEN''   for   ''IF''           ';
    errmsg[missgof       ] := 'Missing    ''OF''   in    ''CASE''          ';
    errmsg[missgexit     ] := 'Missing   ''EXIT''   in   ''LOOP''          ';
    errmsg[missgrpar     ] := 'Missing right parenthesis               ';
    errmsg[missgquote    ] := 'Missing closing quote on this line      ';
    errmsg[missgmain     ] := 'WARNING: This file has no main body     ';
    errmsg[missgpoint    ] := 'Missing closing point at end of program.';
    errmsg[linetoolong   ] := 'Line too long. I''m gonna get confused.  ';
    errmsg[missguntil    ] := 'Missing  ''UNTIL''  for  ''REPEAT''         ';
    errmsg[missgrbrack   ] := 'Missing right bracket                   ';
    errmsg[missgcommentend]:= 'Missing close comment at end of program.';
end (*Error messages*);

procedure Quit;
    extern;

function Min(a,b: integer): integer;
begin
    if a <= b then
	Min := a
    else Min := b;
end; (* min *)

function Max(a,b: integer): integer;
begin
    if a >= b then
	Max := a
    else Max := b;
end; (* max *)

    (*08*)

procedure Startfiles;

    const
	casescount = 4;
	optioncount = 20;
	swversion = 1;
	swtas = 2;
	swsuper = 3;
	swstr = 4;
	swsave_comment = 5;
	swrigid_comment = 19;
	swres = 6;
	swquiet = 7;
	swproc = 8;
	swpreserve = 9;
	swnonres = 10;
	swindent = 11;
	swforce = 12;
	swelseif = 13;
	swcount = 14;
	swcase = 15;
	swbegin = 16;
	swbar = 17;
	swcomm = 18;

    var
	help,cases,options,calltable: table;
	i: integer;
	eachcase: casetype;
	rescanning: boolean;

    procedure Defineoptions;
	const
	    invisible = 1;
	var
	    rstring: packed array[1..1] of char;
    begin
	calltable := tbmak(4);
	tbadd(calltable,1,'START',0);
	tbadd(calltable,1,'RUN',0);
	tbadd(calltable,1,'ERUN',0);
	rstring[1] := 'R';
	tbadd(calltable,1,rstring,0);
	help := tbmak(1);
	tbadd(help,1,'HELP',0);
	cases := tbmak(casescount);
	tbadd(cases,uppercase,'UPPERCASE',0);
	tbadd(cases,samecase,'SAMECASE',0);
	tbadd(cases,lowercase,'LOWERCASE',0);
	tbadd(cases,capitalize,'CAPITALIZE',0);
	options := tbmak(optioncount);
	tbadd(options,swversion,'VERSION:',0);
	tbadd(options,swtas,'TASMANIAN',0);
	tbadd(options,swsuper,'SUPER',0);
	tbadd(options,swstr,'STRING-CASE:',0);
	tbadd(options,swsave_comment,'SAVE-COMMENT',0);
	tbadd(options,swrigid_comment,'RIGID-COMMENT',0);
	tbadd(options,swres,'RESERVED-CASE:',0);
	tbadd(options,swquiet,'QUIET',invisible);
	tbadd(options,swproc,'PROCEDURE-CASE:',0);
	tbadd(options,swpreserve,'PRESERVE',invisible);
	tbadd(options,swnonres,'NONRESERVED-CASE:',0);
	tbadd(options,swindent,'INDENT:',0);
	tbadd(options,swforce,'FORCE',0);
	tbadd(options,swelseif,'ELSEIF',0);
	tbadd(options,swtas,'DENNY',invisible);
	tbadd(options,swcount,'COUNT',invisible);
	tbadd(options,swcomm,'COMMENT-CASE:',0);
	tbadd(options,swcase,'CASE:',0);
	tbadd(options,swbegin,'BEGIN:',0);
	tbadd(options,swbar,'BAR',0);
    end; (* defineoptions *)

    procedure Setdefaults;
    begin
	goodversion := -1;
	anyversion := false;
	dennying := false;
	super := false;
	strcase := samecase;
	rigidcom := false;
	savecom := false;
	rescase := uppercase;
	quiet := false;
	proccase := capitalize;
	preserving := false;
	nonrcase := lowercase;
	feed := 4;
	forcing := false;
	elseifing := false;
	counting := false;
	comcase := samecase;
	eachcase := undefined;
	indentbegin := 0;
	begexd := 0;
	endexd := 0;
	barring := false;
    end; (* setdefaults *)

    procedure Getoptions;
    begin
	if goodversion > 9 then begin
	    goodversion := -1;
	    anyversion := true;
	end;
	if feed < 0 then begin
	    feed := 4;
	end;

	if indentbegin < 0 then begin
	    begexd := -indentbegin;
	    endexd := begexd;
	    indentbegin := 0;
	end else begin
	    begexd := 0;
	    endexd := 0;
	end;

	if dennying then begin
	    begexd := feed;
	    indentbegin := 0;
	    endexd := feed;
	    rescase := lowercase;
	end;

	if eachcase <> undefined then begin
	    rescase := eachcase;
	    nonrcase := eachcase;
	    comcase := eachcase;
	    strcase := eachcase;
	    proccase := eachcase;
	end;
    end; (* getoptions *)

    procedure Errcheck;
    begin
	if cmerr then begin
	    cmerrmsg;
	    Quit;
	end;
    end;

    procedure Startold;
    begin
	gjgen(100000000000B);   (* get an input file *)
	cmauto(false);          (* turn off automatic error handling *)
	gjext('PAS');           (* try a file with pas extension *)
	cmfil(oldsource);
	if cmerr then begin     (* try pgo extension *)
	    gjext('PGO');
	    cmfil(oldsource);
	end;
	if not rescanning then begin
	    cmauto(true);
	end;
	if cmerr then begin     (* OK, any old extension *)
	    cmifi(oldsource);
	end;
	Errcheck;
    end; (* Startold *)

    procedure Readrescanned;

	const
	    rscan = 500B;
	    rljfn = 23B;

    begin
	cmauto(false);          (* error handling off *)
	jsys(rscan; 0; i);      (* read the rscan buffer *)
	rescanning := i > 0;    (* any characters in buffer *)
	if rescanning then begin
	    (*          rescanning := cmkey(calltable)=0; (* not called via "run", etc. *)
	end;
	if rescanning then begin
	    (* Note:  From pascal this is the preferred way to parse a field*)
	    (* The next three lines get and release a jfn on the filespec   *)
	    (* PFORM *)
	    gjgen(40000000B);        (* get a fake jfn on PFORM *)
	    cmfil(oldsource);        (* not really the source, just a dummy *)
	    jsys(rljfn,2; 0:oldsource); (* release the jfn *)

	    cmcfm;
	    rescanning := cmerr;     (* cmerr means something is left *)
	end;
    end; (* readrescanned *)

    procedure Startnew;

	const
	    jfns = 30B;
	    fieldlength = 39;
	    flplus5 = 44;

	var
	    oldname: packed array[1..fieldlength] of char;
	    newname: packed array[1..flplus5] of char;
	    ptr: integer;

    begin
	jsys(jfns; oldname,0:oldsource,[8]); (* find the name of oldsource *)
	if rescanning then begin (* construct the name of newsource by hand *)
	    ptr := 1;
	    while (oldname[ptr] <> Chr(0)) and (ptr < 39) do begin
		newname[ptr] := oldname[ptr];
		ptr := ptr + 1;
	    end;
	    if oldname[ptr] <> Chr(0) then begin
		ptr := ptr + 1;
	    end;
	    newname[ptr] := '.';
	    newname[ptr+1] := 'n';
	    newname[ptr+2] := 'e';
	    newname[ptr+3] := 'w';
	    newname[ptr+4] := Chr(0);
	    Rewrite(newsource, newname);
	end else begin (* use comnd to find out the name of newsource *)
	    cmini('Newsource? '); (* prompt for newsource *)
	    gjgen(400000000000B); (* newsource will be an output file *)
	    gjext('NEW');         (* with default extension .NEW *)
	    gjnam(oldname);       (* with default name the same as oldsource's *)
	    cmfil(newsource);     (* now that we have the defaults set, get the name*)
	    cmcfm;                (* wait for CRLF *)
	    Rewrite(newsource);   (* open newsource *)
	end;

    end; (* Startnew *)

begin (* Startfiles *)
    Defineoptions;
    cmini('');
    Readrescanned;
    if not rescanning then begin
	cmini('Oldsource? ');
    end;
    Startold;
    if not rescanning then begin
	cmauto(true);
    end;
    Setdefaults;
    loop
	cmmult;                     (* two possibilities *)
	{1}    cmcfm;                   (* CRLF *)
	{2}    i := cmswi(options);     (* a switch *)
	i := cmdo;                  (* now do the comnd *)
    exit if i = 1; (* done if CRLF *)
	Errcheck;
	case cmint of (* otherwise evaluate the switch value returned *)
	    -swversion: goodversion := cmnum;
	    swtas: begin
		cmnoi('FORMAT');
		dennying := true;
	    end;
	    swsuper: super := true;
	    -swstr: begin
		strcase := cmkey(cases);
	    end;
	    swsave_comment: begin
		cmnoi('INDENTATION');
		savecom := true;
	    end;
	    swrigid_comment: begin
		cmnoi('INDENTATION');
		rigidcom := true;
	    end;
	    -swres: begin
		rescase := cmkey(cases);
	    end;
	    swquiet: quiet := true;
	    -swproc: begin
		proccase := cmkey(cases);
	    end;
	    swpreserve: begin
		cmnoi('INDENTATION');
		preserving := true;
	    end;
	    -swnonres: begin
		nonrcase := cmkey(cases);
	    end;
	    -swindent: feed := cmnum;
	    swforce: begin
		cmnoi('NEWLINES IN STANDARD PLACES');
		forcing := true;
	    end;
	    swelseif: elseifing := true;
	    swcount: begin
		cmnoi('PROCEDURE AND FUNCTION DECLARATIONS');
		counting := true;
	    end;
	    -swcomm: begin
		comcase := cmkey(cases);
	    end;
	    -swcase: eachcase := cmkey(cases);
	    -swbegin: indentbegin := cmnum;
	    swbar: begin
		cmnoi('FORMAT FOR COMMENTS');
		barring := true;
	    end;
	end;
    end;
    Errcheck;
    Reset(oldsource,'','/E');
    Getoptions;
    Startnew;
end; (* Startfiles *)

function Hash(var sy: alfa): tableindex;

    var
	hack: record case boolean of
			  true: (int1: integer;
				 int2: integer);
			  false: (alf: alfa);
	      end;

begin
    hack.alf := sy;
    Hash := Abs(Abs(hack.int1) - Abs(hack.int2)) mod oneplustablesize;
end; (* Hash *)

function Find_sy: list;

    var
	pointer: list;      (* Runs through proctable looking for sy*)
	found  : boolean;   (* Did we find sy? *)

begin
    pointer := proctable[Hash(sy)];
    found := false;
    while (pointer <> nil) and not found do         (* Look for sy *) begin
	if pointer^.string = sy then
	    found := true
	else pointer := pointer^.next;
    end;
    if found then
	Find_sy := pointer
    else Find_sy := nil;
end; (* Find_sy *)

procedure Firstdef(sy: alfa);

    var
	pointer : list; (* Runs through proctable looking for sy *)
	pos     : tableindex;

begin
    definitions := definitions + 1;
    pos := Hash(sy);
    New(pointer); New(pointer^.stack);
    pointer^.string := sy;
    pointer^.stack^.top := true;
    pointer^.stack^.next := nil;
    pointer^.next := proctable[pos];
    proctable[pos] := pointer;
end; (* Firstdef *)

procedure Reinitialize;

begin (*Reinitialize*)
    proctable := baretable;
    bufflen := 0;               buffmark := 0;                  errcount := 0;
    bufferptr := 2;             variant_level := 0;             level := 0;
    line500 := 0;               linecnt :=0;                    pagecnt := 1;
    eoline := true;             notokenyet := true;
    programpresent := false;    oldspaces := false;
    sy := blanks;               prog_name := blanks;
end; (* Reinitialize *)

procedure Initialize;

    var
	i: integer;

begin
    thenbeginning := false;
    elsehere := false;
    eob := false;
    nobody := false;

    for i := 0 to tablesize do proctable[i] := nil;
    Firstdef('GET       '); Firstdef('GETLN     ');
    Firstdef('PUT       '); Firstdef('PUTLN     ');
    Firstdef('RESET     '); Firstdef('REWRITE   ');
    Firstdef('READ      '); Firstdef('READLN    ');
    Firstdef('BREAK     '); Firstdef('WRITE     ');
    Firstdef('WRITELN   '); Firstdef('PACK      ');
    Firstdef('UNPACK    '); Firstdef('NEW       ');
    Firstdef('GETLINENR '); Firstdef('PAGE      ');
    Firstdef('PROTECTION'); Firstdef('CALL      ');
    Firstdef('DATE      '); Firstdef('TIME      ');
    Firstdef('DISPOSE   '); Firstdef('HALT      ');
    Firstdef('GETSEG    '); Firstdef('PUTSEG    ');
    Firstdef('MESSAGE   '); Firstdef('LINELIMIT ');
    Firstdef('REALTIME  '); Firstdef('ABS       ');
    Firstdef('SQR       '); Firstdef('ODD       ');
    Firstdef('ORD       '); Firstdef('CHR       ');
    Firstdef('PRED      '); Firstdef('SUCC      ');
    Firstdef('EOF       '); Firstdef('EOLN      ');
    Firstdef('CLOCK     '); Firstdef('CARD      ');
    Firstdef('LOWERBOUND'); Firstdef('UPPERBOUND');
    Firstdef('EOS       '); Firstdef('MIN       ');
    Firstdef('MAX       '); Firstdef('FIRST     ');
    Firstdef('LAST      '); Firstdef('COS       ');
    Firstdef('EXP       '); Firstdef('SQRT      ');
    Firstdef('LN        '); Firstdef('ARCTAN    ');
    Firstdef('LOG       '); Firstdef('SIND      ');
    Firstdef('COSD      '); Firstdef('SINH      ');
    Firstdef('COSH      '); Firstdef('TANH      ');
    Firstdef('ARCSIN    '); Firstdef('ARCCOS    ');
    Firstdef('RANDOM    '); Firstdef('SIN       ');
    Firstdef('ROUND     '); Firstdef('EXPO      ');
    Firstdef('OPTION    '); Firstdef('TRUNC     ');
    Firstdef('LENGTH    '); Firstdef('GETCHAR   ');
    Firstdef('POS       '); Firstdef('STRLT     ');
    Firstdef('STRLE     '); Firstdef('STREQ     ');
    Firstdef('STRGE     '); Firstdef('STRGT     ');
    Firstdef('STRNE     '); Firstdef('GETFILENAM');
    Firstdef('GETOPTION '); Firstdef('GETSTATUS ');
    Firstdef('ASKFILENAM'); Firstdef('STARTFILE ');
    Firstdef('GETPARAMET'); Firstdef('GETNEXTCAL');
    Firstdef('FILNAM    '); Firstdef('REENTER   ');
    Firstdef('SETTIME   '); Firstdef('TIMEREPORT');
    Firstdef('RUNTIME   '); Firstdef('ELAPSEDTIM');
    Firstdef('PUTCHAR   '); Firstdef('ASSIGN    ');
    Firstdef('SUBSTR    '); Firstdef('CONCAT    ');
    Firstdef('SETRAN    ');
    definitions := 0;
    baretable := proctable;
    for ch := chr(0B) to chr(177B) do delsy[ch] := othersy;
    (* default is othersy *)
    delsy['('] := lparent;
    delsy[')'] := rparent;
    delsy['['] := lbracket;
    delsy[']'] := rbracket;
    delsy[';'] := semicolon;
    delsy[','] := comma;
    delsy['.'] := point;
    delsy[':'] := colon;
    delsy['='] := eqlsy;
    for i := -1 to 201 do buffer [i] := ' ';            (* easier to debug *)
    for i := 1 to 17 do tabs [i] := Chr(ht);        (* Ht is horizontal tab *)
    for ch := Chr(nul) to '@' do begin
	lower[ch] := ch;
	upper[ch] := ch;
    end;
    for ch := 'A' to 'Z' do begin
	lower[ch] := Chr (Ord(ch) + 40B);
	upper[ch] := ch;
    end;
    for ch := '[' to '`' do begin
	lower[ch] := ch;
	upper[ch] := ch;
    end;
    for ch := 'a' to 'z' do begin
	lower[ch] := ch;
	upper[ch] := Chr (Ord(ch) - 40B);
    end;
    for ch := '{' to Chr(177B) do begin
	lower[ch] := ch;
	upper[ch] := ch;
    end;
    Reinitialize;
end (*Initialize*);

procedure Setcase(whichcase: casetype);
    var
	j: integer;
begin
    case whichcase of
	uppercase: begin
	    for j := bufferptr - syleng - 1 to bufferptr-2 do buffer[j] := upper[buffer[j]];
	end;
	lowercase: begin
	    for j := bufferptr - syleng - 1 to bufferptr-2 do buffer[j] := lower[buffer[j]];
	end;
	capitalize: begin
	    buffer[bufferptr-syleng-1] := upper[ buffer[bufferptr-syleng-1] ];
	    for j := bufferptr - syleng to bufferptr - 2 do buffer[j] := lower[buffer[j]];
	end;
    end; (* Case *)
end; (* Setcase *)


    (*09*)    (*Page control:*)    (*Newpage*)

procedure Newpage;
begin (*Newpage*)
    pagecnt := pagecnt + 1;
    linecnt := 0;
    line500 := 0;
    if (prog_name <> blanks) and not quiet then
	Write(tty, pagecnt: 3, '..');
    (* Break(tty); *)
    Page(newsource);
end (*Newpage*);


    (*10*)    (*Output procs:*)    (*Block[error,writeline]*)

procedure Block;

    type
	poplist = record
		      pointer: list;
		      next: ^poplist;
		  end;

    var
	i: integer;
	whattopop: ^poplist;

    procedure Skipcomment;
	forward;

    procedure Error (errnr : errkinds);
    begin (*Error*)
	errcount := errcount+1;
	Write (newsource, '(*??* ');
	case errnr of
	    begerrinblkstr: Write(newsource, sy, errmsg[begerrinblkstr]);
	    missgend,  missgthen, missguntil,
	    missgexit     : Write(newsource, errmsg[errnr]);
	    others        : Write(newsource, errmsg[errnr]);
	end;

	Writeln(newsource,' *??*)');
	Writeln(tty);
	Write (tty, 'ERROR AT ');
	if (linenb = '-----') or (linenb = '     ') then begin
	    Write(tty,linecnt: linnumsize)
	end else begin
	    Write(tty, linenb);
	end;
	Write(tty, '/', pagecnt:2,': ');

	case errnr of
	    begerrinblkstr: Write(tty, sy, errmsg[begerrinblkstr]);
	    missgend,  missgthen, missguntil,
	    missgexit     :
		Write(tty, errmsg[errnr]);
	    others        : Write(tty, errmsg[errnr]);
	end;
	Writeln(tty);
	(* Break(tty); *)
    end (*Error*) ;

    procedure Writeline(position (*Letztes zu druckendes zeichen im puffer*): integer);
	var
	    i, j : integer;    (*Markiert erstes zu druckENDes zeichen*)

    begin (*Writeline*)
	position := position - 2;
	if position > 0 then begin
	    i := buffmark + 1;                                  (* 1. Discard blanks at both ends *)
	    while (buffer [i] = ' ') and (i <= position) do i := i + 1;
	    buffmark := position;
	    while (buffer [position] = ' ') and (i < position) do
		position := position - 1;

	    if i <= position then                               (* 2. If anything left, write it. *) begin
		if not oldspaces then
		    presentspaces := nextspaces;

		if preserving then
		    presentspaces := spacepreserve;

		if thenbeginning then begin
		    Write(newsource,' ');
		    thenbeginning := false;
		end else begin
		    Write(newsource,tabs:presentspaces div 8);
		    if presentspaces mod 8 > 0 then
			Write(newsource,' ':presentspaces mod 8);
		end;
		for j := i to position do begin
		    newsource^ := buffer[j];
		    Put(newsource);
		end;

		if dennying and (syty in [endsy,thensy,elsesy,dosy])then begin
		    if syty = endsy then begin
			endelseing := true
		    end else begin
			thenbeginning := true
		    end;
		end else begin
		    Writeln(newsource);
		end;

		(*                                                 3. Reset pointers and flags *)
		while (buffmark+1 < bufflen) and (buffer[buffmark+1]=' ') do begin
		    buffmark := buffmark + 1; (* Move buffmark past space *)
		end;
		if buffmark > bufflen then begin
		    if (linenb = '     ') or (linecnt >= maxinc) then begin
			Newpage;
		    end;
		end;
	    end  (* If i <= position *);
	end  (* If position > 0 *);
	presentspaces := nextspaces;
	oldspaces := false;
	thendo := false;
	elsehere := false;
    end (*Writeline*) ;

    procedure Vardef;

	var
	    pointer: list;
	    s: ^stacktype;
	    p: ^poplist;

    begin
	pointer := Find_sy;
	if pointer <> nil then
	    if pointer^.stack^.top then begin
		New(s);
		s^.top := false;
		s^.next := pointer^.stack;
		pointer^.stack := s;
		New(p);
		p^.pointer := pointer;
		p^.next := whattopop;
		whattopop := p;
	    end;
    end; (* Vardef *)

    procedure Procdef;
	var
	    pointer: list;
	    s: ^stacktype;
	    p: ^poplist;
    begin
	pointer := Find_sy;
	if pointer = nil then begin
	    Firstdef(sy);
	    New(p);
	    p^.pointer := Find_sy;
	    p^.next := whattopop;
	    whattopop := p;
	end else if not pointer^.stack^.top then begin
	    New(s);
	    s^.top := true;
	    s^.next := pointer^.stack;
	    pointer^.stack := s;
	    New(p);
	    p^.pointer := pointer;
	    p^.next := whattopop;
	    whattopop := p;
	end;
    end; (* Procdef *)

    procedure Popoff;
	var
	    p: ^poplist;
    begin
	p := whattopop;
	while p <> nil do begin
	    if p^.pointer^.stack^.next = nil then
		p^.pointer^.stack^.top := false  (* Almost as good as new *)
	    else p^.pointer^.stack := p^.pointer^.stack^.next; (* Pop stack *)
	    p := p^.next;
	end;
    end; (* Popoff *)


	(*11*) (*Scanner:*)     (*Insymbol[readbuffer[readline],resword*)

    procedure Readbuffer;

	(*Reads a character from the input buffer*)

	procedure Readline;
	    (*Handles leading blanks and blank lines, reads next nonblank line
	     (without leading blanks) into buffer*)

	    var
		i, pos: integer;

	    function Tabstop: integer;
		(* Calculates the position that a tab will take you to in the *)
		(* buffer. *)
	    begin
		Tabstop := 8 * (1 + (bufflen+spacepreserve) div 8) - spacepreserve;
	    end; (* Tabstop *)

	begin (*Readline*)
	    (*Entered at the beginning of a line*)
	    spacepreserve := 0;
	    loop
		while Eoln (oldsource) and not Eof (oldsource) do begin
		    (*Is this a page mark?*)
		    Getlinenr(oldsource,linenb);
		    if oldsource^ = Chr(15B) then begin
			Get(oldsource);
			if oldsource^ = Chr(14B) then begin
			    linenb := '     ';
			end;
			if Eoln(oldsource) then begin
			    Readln(oldsource);
			end;
		    end else begin
			if oldsource^ = Chr(14B) then begin
			    linenb := '     ';
			end;
			Readln(oldsource);
		    end;
		    if linenb = '     ' then begin
			Newpage
		    end else begin (*Handle blank line*)
			line500 := line500 + 1;
			linecnt := linecnt + 1;
			if line500 = 500 then begin
			    line500 := 0;
			    if not quiet then begin
				if linenb = '-----' then begin
				    Write(tty, '(', linecnt: 4, ')')
				end else begin
				    Write(tty, '(', linenb, ')');
				end;
				(* Break(tty); *)
			    end;
			end;
			Writeln(newsource);
			if linecnt >= maxinc then begin
			    Newpage;
			end;
		    end (*Handle blank line*);
		    spacepreserve := 0;
		end (*While eoln(oldsource)...*);
	    exit if not (oldsource^ in [' ',Chr(ht)]) or Eof(oldsource);
		if oldsource^ = ' ' then begin
		    spacepreserve := spacepreserve + 1;
		end else begin (* oldsource^ is a tab *)
		    spacepreserve := 8 * (1 + spacepreserve div 8);
		end;
		Get(oldsource);
	    end (*Loop*);
	    bufflen := 0;
	    (*Read in the line*)
	    while not Eoln(oldsource) do begin
		if oldsource^ = Chr(ht) then begin
		    pos := Min(Tabstop, linsiz1plus);
		    for i := bufflen+1 to pos do begin
			buffer[i] := ' ';
		    end;
		    bufflen := pos;
		end else begin
		    bufflen := Min( bufflen + 1 , linsiz1plus );
		    buffer [bufflen] := oldsource^;
		end;
		Get(oldsource);
	    end;
	    if bufflen > linsize then begin
		Error(linetoolong);
		bufflen := linsize;
	    end else begin
		buffer[bufflen+1]:=' '; (*So we can always be one char ahead*)
		buffer[bufflen+2] := ' ';
	    end;
	    if not Eof (oldsource) then begin
		Getlinenr(oldsource,linenb);
		if oldsource^ = Chr(15B) then begin
		    Get(oldsource);
		    if oldsource^ = Chr(14B) then begin
			linenb := '     ';
		    end;
		    if Eoln(oldsource) then begin
			Readln(oldsource);
		    end;
		end else begin
		    if oldsource^ = Chr(14B) then begin
			linenb := '     ';
		    end;
		    Readln(oldsource);
		end;
		linecnt := linecnt + 1;
		line500 := line500 + 1;
		if line500 = 500 then begin
		    line500 := 0;
		    if not quiet then begin
			if (linenb = '-----') or (linenb = '     ') then begin
			    Write(tty, '(', linecnt: 4, ')')
			end else begin
			    Write(tty, '(', linenb, ')');
			end;
			(* Break(tty); *)
		    end;
		end;
	    end;
	    bufferptr := 1;
	    buffmark := 0;
	    notokenyet := true;
	end (*Readline*) ;

    begin (*Readbuffer*)
	(*If reading past the extra blank on the END, get a new line*)
	if eoline then begin
	    Writeline(bufferptr);
	    ch := ' ';
	    if Eof (oldsource) then begin
		eob := true
	    end else begin
		Readline;
	    end;
	end else begin
	    ch := upper[ buffer[bufferptr] ];
	    bufferptr := bufferptr + 1;
	end;
	eoline := bufferptr >= bufflen + 2;
    end (*Readbuffer*) ;

    procedure Docomment(final_ch: char);

	var
	    at_first_word_of_sentence: boolean;
	    oldspacesmark: integer;
	    previous_preserve: integer; (* indentation of first comment line *)
	    comment_shift: integer; (* how far to shift over body of *)
				    (* multi-line comments *)

	procedure Nextchar;
	begin
	    if rigidcom and (bufferptr = 1) then begin
		nextspaces := presentspaces + spacepreserve-previous_preserve;
		presentspaces := nextspaces;
		previous_preserve := spacepreserve;
	    end else if savecom and (bufferptr = 1) then begin
		presentspaces := spacepreserve;
		nextspaces := spacepreserve;
	    end;

	    case comcase of
		lowercase:
		    buffer[bufferptr] := lower[buffer[bufferptr]];
		capitalize:
		    if at_first_word_of_sentence then begin
			buffer[bufferptr] := upper[buffer[bufferptr]]
		    end else begin
			buffer[bufferptr] := lower[buffer[bufferptr]];
		    end;
		uppercase:
		    buffer[bufferptr] := upper[buffer[bufferptr]];
	    end; (* Case *)

	    Readbuffer;
	    if ((bufferptr-1 = bufflen)
		or (buffer[bufferptr] in ['"', '''' , ')' , ']' , '*' , ' ']))
		and (ch in ['.' , '?' , '!'])
	    then
		at_first_word_of_sentence := true
	    else if not (ch in ['/','"','''',')','(' , '[' , ']' , '*' , ' '])
	    then
		at_first_word_of_sentence := false;
	end; (* Nextchar *)

	procedure Options;

	    var
		och     : char;
		oswitch : boolean;
		ovalue  : integer;
		ocase   : casetype;

	begin (* Options *)
	    repeat
		ovalue := 0;
		oswitch := true;
		ocase := capitalize;
		Readbuffer;
		och := ch;
		if ch <> '*' then begin
		    Readbuffer;
		    buffer[bufferptr-1] := lower[buffer[bufferptr-1]];
		end;
		if ch in ['U','C','L','M','S'] then (* Get a case *) begin
		    if ch = 'U' then
			ocase := uppercase
		    else if ch = 'C' then
			ocase := capitalize
		    else if ch = 'L' then
			ocase := lowercase
		    else if ch = 'S' then
			ocase := samecase;
		    Readbuffer;
		end else begin (* Get a plus, a minus, or an integer *)
		    if ch in ['+','-'] then begin
			oswitch := ch = '+';
			Readbuffer;
		    end;
		    if ch in ['0'..'9'] then begin
			repeat
			    ovalue := ovalue * 10 + (Ord(ch)-Ord('0'));
			    Readbuffer;
			until not (ch in digits);
			if not oswitch then (* Ch was '-' *) begin
			    oswitch := true;
			    ovalue := -ovalue;
			end;
		    end;
		end; (* Get a plus, a minus, or an integer *)
		case och of
		    'V':
			if ovalue > 9 then begin
			    goodversion := -1; (* Impossible version *)
			    anyversion := true;
			end else begin
			    goodversion := ovalue;
			    anyversion := false;
			end;
		    'C':
			savecom := oswitch;
		    'H':
		        rigidcom := oswitch;
		    'I':
			if ovalue >= 0 then begin
			    feed := ovalue;
			    begexd := feed div 2;
			    indentbegin := 0;
			    if dennying then
				endexd := feed
			    else endexd := feed div 2;
			end;
		    'G':
			if ovalue < 0 then begin
			    begexd := -ovalue;
			    endexd := begexd;
			    indentbegin := 0;
			end else begin
			    begexd := 0;
			    endexd := 0;
			    indentbegin := ovalue;
			end;
		    'D': begin
			dennying := true;
			begexd := feed;
			indentbegin := 0;
			endexd := feed;
			rescase := lowercase;
		    end;
		    'S': begin
			super := oswitch;
			forcing := forcing or oswitch;
		    end;
		    'F': forcing := oswitch;
		    'B': barring := oswitch;
		    'Q': quiet := oswitch;
		    'E': elseifing := oswitch;
		    'P': preserving := oswitch;
		    'R': rescase := ocase;
		    'N': nonrcase := ocase;
		    'M': comcase := ocase;
		    'Z': strcase := ocase;
		    'X': proccase := ocase;
		    'A': begin
			proccase := ocase;
			nonrcase := ocase;
			rescase := ocase;
			strcase := ocase;
			comcase := ocase;
		    end; (* Other options may cause conflicts *)
		end; (* Case *)
	    until ch <> ',';
	end; (* Options *)

    begin (* Docomment *)
	at_first_word_of_sentence := true;
	oldspacesmark := nextspaces;
	if not oldspaces then begin
	    presentspaces := nextspaces;
	    oldspaces := true;
	end;

	if barring then begin
	    comment_shift := 0;
	end else begin
	    comment_shift := 2;
	end;

	if savecom and comment_at_boln then begin
	    nextspaces := spacepreserve;
	    presentspaces := spacepreserve;
	end else if rigidcom then begin
	    previous_preserve := spacepreserve;
	end else begin
	    nextspaces := presentspaces + bufferptr - buffmark - 2 + comment_shift;
	end;

	if final_ch in [')','/'] then begin
	    Nextchar;
	    if ch = '&' then begin
		Options;
	    end;
	    repeat
		Nextchar;
	    until ((ch = final_ch) and (buffer[bufferptr-2] = '*')) or eob;
	    if eob then begin
		Error(missgcommentend);
	    end;
	end else begin
	    while (ch <> final_ch) and not eob do begin
		Nextchar;
	    end;
	    if eob then begin
		Error(missgcommentend);
	    end;
	end;

        if barring and (bufflen = 3) then begin
	    nextspaces := nextspaces - 1 - comment_shift; (* align bottom of the bar *)
	end else if (bufflen = 2) and not (savecom or rigidcom) then begin
	    nextspaces := nextspaces - comment_shift; (* align close-comment *)
	end;
	
	repeat
	    Readbuffer;
	until (ch <> ' ') or eoline;
	if eoline and notokenyet then
	    Readbuffer;
	nextspaces := oldspacesmark;
	if not oldspaces then
	    presentspaces := nextspaces;
    end (* Docomment *);

    procedure Insymbol;
	label
	    1,111;
	var
	    i: integer;
	    incondcomp: boolean;

	function Resword: boolean ;
	    (*Determines if the current identifier is a reserved word*)
	    var
		i,j: integer;
		local: boolean;

	begin (*Resword*)
	    local:= false;
	    i := resnum[sy[1]];
	    while (i < resnum[Succ(sy[1])]) and not local do begin
		if reslist[i] = sy then begin
		    local := true;
		    syty := ressy[i];
		    Setcase(rescase);
		end else begin
		    i := i + 1;
		end;
	    end;
	    Resword := local;
	end (*Resword*) ;

	function Proccall: boolean;

	    var
		pointer: list;      (* Runs through proctable looking for sy*)
		found  : boolean;   (* Did we find sy? *)

	begin
	    if invars or (syty = point) then begin
		Proccall := false
	    end else begin (* Not (invars or ... *)
		pointer := Find_sy;
		Proccall := false;
		if pointer <> nil then begin
		    if pointer^.stack^.top then begin
			Proccall := true;
			Setcase(proccase);
		    end;
		end;
	    end; (* Not (invars or ... *)
	end; (* Proccall *)

	    (*12*)    (*Parenthese*)

	procedure Parenthese (which: symbol);
	    (*Handles the formatting of parentheses, except those in variant parts of records*)
	    var
		oldspacesmark : integer;        (*Alter zeichenvorschub bei formatierung von klammern*)
	begin (*Parenthese*)
	    oldspacesmark := nextspaces;
	    if not oldspaces then begin (* i.e., at beginning of line *)
		oldspaces := true;
		presentspaces := nextspaces;
	    end;
	    nextspaces := presentspaces + bufferptr - buffmark - 2;
	    repeat
		Insymbol;
		if syty in [functionsy,proceduresy] then begin
		    Insymbol;
		    if syty = ident then
			Procdef;
		end else if invars and (syty = ident) then begin
		    Vardef;
		end;
	    until syty in [which,externsy..whilesy,labelsy..typesy,initprocsy..exitsy,dosy..forwardsy];
	    nextspaces := oldspacesmark;
	    oldspaces := true;
	    if syty = which then
		Insymbol
	    else if which = rparent then
		Error(missgrpar)
	    else Error(missgrbrack);
	end (*Parenthese*) ;


	    (*13*)    (*] Insymbol*)

    begin (*Insymbol*)
	111:
	syleng := 0;
	while (ch in ['/','_','(',' ','$','?','@','%',backslash,'!','{']) and not eob do begin
	    case ch of
		'/': begin
		    Readbuffer;
		    if ch = '*' then begin
			comment_at_boln := bufferptr = 3;
			Docomment('/');
		    end;
		end;
		'(': begin
		    Readbuffer;
		    if ch = '*' then begin
			comment_at_boln := bufferptr = 3;
			Docomment(')')
		    end else begin
			syty := lparent;
			if variant_level = 0 then begin
			    Parenthese(rparent);
			end;
			goto 1;
		    end;
		end;
		'%': begin
		    comment_at_boln := bufferptr = 2;
		    incondcomp := false;
		    Readbuffer;
		    if not anyversion then
			while ch in digits do begin
			    if Ord(ch) - Ord('0') = goodversion then begin
				incondcomp := true;
			    end;
			    Readbuffer;
			end;
		    if not (incondcomp or anyversion) then begin
			Docomment(backslash)
		    end;
		end;
		'{': Docomment('}');
		others: begin
		    Readbuffer;
		end;
	    end; (* case *)
	end; (* while *)
	case ch of
	    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
	    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
	    'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
	    'Z': begin
		syleng := 0;
		sy := '          ';
		repeat
		    syleng := syleng + 1;
		    if syleng <= 10 then
			sy [syleng] := ch;
		    Readbuffer;
		until not (ch in (alphanum + ['_']));
		if not Resword then begin
		    if not Proccall then begin
			if syty in[proceduresy,functionsy,programsy]then begin
			    Setcase(proccase)
			end else begin
			    Setcase(nonrcase);
			end;
		    end;
		    syty := ident;
		end;
	    end; (* 'A'..'Z' *)
	    '0', '1', '2', '3', '4', '5', '6', '7', '8',
	    '9': begin
		repeat
		    syleng := syleng + 1;
		    Readbuffer;
		until not (ch in digits);
		syty := intconst;
		if ch = 'B' then begin
		    Readbuffer;
		end else begin
		    if ch = '.' then begin
			repeat
			    Readbuffer
			until not (ch in digits);
			syty := othersy;
			syleng := 0; (*Reals can't be labels*)
		    end;
		    if ch = 'E' then begin
			Readbuffer;
			if ch in ['+','-'] then begin
			    Readbuffer;
			end;
			while ch in digits do begin
			    Readbuffer;
			end;
			syty := othersy;
			syleng := 0; (*Reals can't be labels*)
		    end;
		end;
	    end; (* digits *)
	    '''': begin
		syleng := 1;
		syty := strgconst;
		repeat
		    repeat
			if strcase = lowercase then begin
			    buffer[bufferptr] := lower[buffer[bufferptr]];
			end else if strcase = uppercase then begin
			    buffer[bufferptr] := upper[buffer[bufferptr]];
			end;
			Readbuffer;
			syleng := syleng + 1;
		    until (ch = '''') or eob or eoline;
		    if ch <> '''' then begin
			Error(missgquote);
		    end;
		    Readbuffer;
		    syleng := syleng + 1;
		until ch <> '''';
	    end;
	    '"': begin
		repeat
		    Readbuffer
		until not (ch in  (digits + ['A'..'F']));
		syty := intconst;
	    end;
	    ' ': syty := eobsy;   (* end of file *)
	    ':': begin
		Readbuffer;
		if ch = '=' then begin
		    syty := othersy;
		    Readbuffer;
		end else begin
		    syty := colon;
		end;
	    end;
	    '\': begin
		Readbuffer;
		if incondcomp then begin
		    incondcomp := false;
		    goto 111;
		end else begin
		    syty := othersy;
		end;
	    end;
	    '[': begin
		syty := lbracket;
		Readbuffer;
		Parenthese(rbracket);
	    end;
	    ';': begin
		syty := semicolon;
		Readbuffer;
		if super then begin
		    Skipcomment;
		    Writeline(bufferptr);
		end;
	    end;
	    others: begin
		syty := delsy[ch];
		Readbuffer;
	    end;
	    end (* Case ch of *);
	1:
	notokenyet := false;

	if thenbeginning then begin
	    if not oldspaces then begin
		if syty <> beginsy then begin
		    Writeln(newsource);             (* put back the CRLF *)
		    thenbeginning := false;
		end;
	    end;
	end;

	if endelseing then begin
	    endelseing := false;
	    if syty = elsesy then begin
		thenbeginning := true (* To suppress crlf after else *)
	    end else begin
		Writeln(newsource); (* Put back the crlf after the end *)
	    end;
	end;
    end (*Insymbol*) ;


	(*14*)  (*Parsing of declarations:*)    (*Recdef[casedef,parenthese]*)

    procedure Recdef;
	var
	    oldspacesmark  : integer;         (*Alter zeichenvorschub bei formatierung von records*)


	procedure Casedef;
	    var
		oldspacesmark  : integer;       (*Alter zeichenvorschub bei formatierung von variant parts*)


	    procedure Parenthese;
		(*Handles the formatting of parentheses inside variant parts*)
		var
		    oldspacesmark : integer;      (*Saved value of 'nextspaces'*)
	    begin (*Parenthese*)
		oldspacesmark := nextspaces;
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := nextspaces;
		end;
		nextspaces := nextspaces + bufferptr - 2;
		Insymbol;
		repeat
		    case syty of
			casesy  :
			    Casedef;
			recordsy :
			    Recdef;
			rparent: ;
			others :
			begin
			    if syty = ident then
				Vardef;
			    Insymbol;
			end;
		    end;
		    (*Until we apparently leave the declaration*)
		until syty in [strgconst..whilesy,rparent,labelsy..exitsy,dosy..beginsy,
			       loopsy..ifsy,forwardsy];
		nextspaces := oldspacesmark;
		oldspaces := true;
		if syty = rparent then
		    Insymbol
		else Error(missgrpar);
	    end (*Parenthese*) ;

	begin (*Casedef*)
	    variant_level := variant_level+1;
	    oldspacesmark := nextspaces;
	    if not oldspaces then begin
		oldspaces := true;
		presentspaces := nextspaces;
	    end;
	    nextspaces := bufferptr - buffmark + presentspaces - syleng + 3;
	    Insymbol; Vardef;
	    repeat
		if syty = lparent then
		    Parenthese
		else begin
		    if syty = ident then
			Vardef;
		    Insymbol;
		end;
	    until syty in [untilsy..exitsy,labelsy..endsy,rparent,dosy..beginsy];
	    nextspaces := oldspacesmark;
	    variant_level := variant_level-1;
	end (*Casedef*) ;

    begin (*Recdef*)
	oldspacesmark := nextspaces;
	if not oldspaces then begin
	    oldspaces := true;
	    presentspaces := nextspaces;
	end;
	nextspaces := bufferptr - buffmark + presentspaces - syleng - 2 + feed;
	Insymbol;
	while not (syty in [untilsy..exitsy,labelsy..endsy,dosy..beginsy]) do
	    case syty of
		casesy   : Casedef;
		recordsy : Recdef;
		others   :
		begin
		    Vardef;
		    repeat
			Insymbol;
		    until syty in [untilsy..exitsy,labelsy..endsy,dosy..beginsy,semicolon,casesy,recordsy];
		    if syty = semicolon then
			Insymbol;
		end;
	    end; (* Case *)
	if not oldspaces then begin
	    presentspaces := nextspaces - feed;
	    oldspaces := true;
	end;
	nextspaces := oldspacesmark;
	if syty = endsy then
	    Insymbol
	else Error(missgend);
    end (*Recdef*) ;


	(*15*)           (*Parsing of statements:*)
	(*Statement[endedstatseq,compstat,casestat,loopstat,ifstat,labelstat,repeatstat]*)


    procedure Statement;
	var
	    oldspacesmark,           (*Nextspaces at entry of this procedure*)
	    curblocknr : integer;     (*Current blocknumber*)


	procedure Endedstatseq(endsym: symbol);
	begin
	    Statement;
	    while syty = semicolon do begin
		Insymbol;
		Statement;
	    end;
	    while not (syty in [endsym,eobsy,proceduresy,functionsy]) do begin
		Error(missgend);
		if not (syty in begsym) then
		    Insymbol;
		Statement;
		while syty = semicolon do begin
		    Insymbol;
		    Statement;
		end;
	    end;
	    if forcing then
		Writeline(bufferptr-syleng);
	    if endelseing then begin
		endelseing := false;
		Writeln(newsource);
	    end;
	end (*ENDedstatseq*);


	procedure Compstat;
	begin (*Compstat*)

	    if not oldspaces then begin
		oldspaces := true;
		presentspaces := Max (0, nextspaces - begexd - indentbegin);
		(* Subtract begexd to exdent the begin and subtract
		 indentbegin to undo the extra indentation for the block *)
	    end;

	    Insymbol;
	    if (forcing or dennying) then
		Writeline(bufferptr-syleng);
	    Endedstatseq(endsy);
	    if syty = endsy then begin
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max(0,nextspaces - endexd - indentbegin);
		    (* Subtract endexd to exdent the end and subtract
		     indentbegin to undo the extra indentation for the block*)
		end;
		Insymbol;
		if forcing then begin
		    if syty = semicolon then
			Skipcomment;
		    Writeline(bufferptr-syleng);
		end;
	    end else Error(missgend)
	end (*Compstat*) ;

	procedure Casestat;
	    var
		oldspacesmark : integer; (*Saved value of 'nextspaces'*)

	begin (*Casestat*)
	    if not oldspaces then begin
		oldspaces := true;
		presentspaces := Max (0,nextspaces-feed);
	    end;
	    Insymbol;
	    Statement;
	    if syty = ofsy then
		if forcing then begin
		    Skipcomment;
		    Writeline(bufferptr);
		end else
	    else
		Error (missgof);
	    loop
		repeat
		    repeat
			Insymbol;
		    until syty in [colon, functionsy .. eobsy];
		    if syty = colon then begin
			oldspacesmark := nextspaces;
			presentspaces := nextspaces;
			nextspaces := nextspaces + feed;
			(* Nextspaces := bufferptr - buffmark + nextspaces - 4; *)
			oldspaces := true;
			thendo := true;
			Insymbol;
			Statement;
			if syty = semicolon then
			    Insymbol;
			nextspaces := oldspacesmark;
		    end;
		until syty in endsym;
	    exit if syty in [endsy,eobsy,proceduresy,functionsy];
		Error (missgend);
	    end; (* Loop *)
	    if forcing then
		Writeline(bufferptr-syleng);
	    if syty = endsy then begin
		Insymbol ;
		if dennying then
		    nextspaces := nextspaces - feed;
		if forcing then begin
		    if syty = semicolon then
			Skipcomment;
		    Writeline(bufferptr-syleng);
		end;
	    end else Error (missgend);
	end (*Casestat*) ;


	procedure Loopstat;
	begin (*Loopstat*)
	    if not oldspaces then begin
		oldspaces := true;
		presentspaces := Max (0,nextspaces - feed);
	    end;
	    Insymbol;
	    Statement;
	    while syty = semicolon do begin
		Insymbol;
		Statement;
	    end;
	    if syty = exitsy then begin
		Writeline(bufferptr-syleng);
		oldspaces := true;
		presentspaces := nextspaces-feed;
		Insymbol; Insymbol;
	    end else Error(missgexit);
	    Endedstatseq(endsy);
	    if syty = endsy then begin
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max(0,nextspaces - feed - indentbegin);
		    (* Subtract feed to exdent the END and subtract
		     indentbegin to undo the extra indentation for the block*)
		end;
		Insymbol ;
		if forcing then begin
		    if syty = semicolon then
			Skipcomment;
		    Writeline(bufferptr-syleng);
		end;
	    end else Error(missgend);
	end (*Loopstat*) ;


	procedure Ifstat;
	    var
		oldspacesmark: integer;

	begin  (*Ifstat*)
	    oldspacesmark := nextspaces;
	    if not elsehere then begin
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max (0,nextspaces - feed);
		end;
		(*Make 'then' and 'else' line up with 'if' unless on same line*)
		nextspaces := presentspaces + bufferptr - buffmark + feed - 4;
	    end (*If not elsehere*);
	    Insymbol;
	    Statement; (*Will eat the expression and stop on a keyword*)
	    if syty = thensy then begin
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max (0,nextspaces-feed);
		end;
		if forcing (*and not dennying*) then begin
		    Skipcomment;
		    Writeline(bufferptr);
		end else
		    thendo:=true; (*Suppress further indentation from a 'do'*)
		Insymbol;
		Statement;
	    end else Error (missgthen);
	    if syty = elsesy then begin (*Parse the else part*)
		Writeline(bufferptr-syleng);
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max (0,nextspaces-feed);
		end;
		if forcing and not (elseifing (*or dennying*)) then begin
		    Skipcomment;
		    Writeline(bufferptr);
		end else
		    thendo := true;
		elsehere := true;
		Insymbol;
		Statement;
	    end;
	    oldspaces := true; (* Preserve indentation of statement *)
	    if syty = semicolon then
		Skipcomment;
	    Writeline(bufferptr-syleng);
	    nextspaces := oldspacesmark;
	end (*Ifstat*) ;


	procedure Labelstat;
	begin (*Labelstat*)
	    presentspaces := level * feed;
	    oldspaces := true;
	    Insymbol;
	    if forcing then
		Writeline(bufferptr-syleng);
	end (*Labelstat*) ;


	procedure Repeatstat;
	begin
	    if not oldspaces then begin
		oldspaces := true;
		presentspaces := Max (0,nextspaces - feed);
	    end;
	    Insymbol;
	    if (forcing or dennying) then
		Writeline(bufferptr-syleng);
	    Endedstatseq(untilsy);
	    if syty = untilsy then begin
		if not oldspaces then begin
		    oldspaces := true;
		    presentspaces := Max(0,nextspaces - feed);
		end;
		Insymbol;
		Statement;
		if forcing then begin
		    if syty = semicolon then
			Skipcomment;
		    Writeline(bufferptr-syleng);
		end;
	    end else Error(missguntil);
	end (*Repeatstat*) ;

    begin (*Statement*)
	oldspacesmark := nextspaces; (*Save the incoming value of nextspaces to be able to restore  it*)
	if syty = intconst then begin
	    Insymbol;
	    if syty = colon then
		Labelstat;
	end;
	if syty in begsym then begin
	    if not thendo then begin
		if forcing then
		    Writeline(bufferptr-syleng);
		if (syty <> beginsy) then
		    nextspaces := nextspaces + feed
		else nextspaces := nextspaces + indentbegin;
	    end;
	    case syty of
		beginsy : Compstat;
		loopsy  : Loopstat;
		casesy  : Casestat;
		ifsy    : Ifstat;
		repeatsy: Repeatstat;
	    end;
	end else begin
	    if forcing then
		if syty in [forsy,whilesy] then
		    Writeline(bufferptr-syleng);
	    while not (syty in [semicolon,functionsy..recordsy]) do Insymbol;
	    if syty = dosy then begin
		if not thendo then begin
		    oldspaces := true;
		    presentspaces := nextspaces;
		    nextspaces := nextspaces + feed;
		    if dennying or not forcing then
			thendo := true;
		end;
		Insymbol;
		Statement;
		if syty = semicolon then
		    Skipcomment;
		Writeline(bufferptr-syleng);
	    end;
	end;
	nextspaces := oldspacesmark;
    end (*Statement*) ;

    procedure Skipcomment;
	var
	    last_ch: char;
    begin
	while not eoline and (ch = ' ') do begin
	    Readbuffer;
	end;
	if (ch in ['(','/','{']) and not eoline and (buffer[bufferptr] = '*') then begin
	    if ch = '(' then begin
		last_ch := ')';
		Readbuffer;
	    end else if ch = '/' then begin
		last_ch := '/';
		Readbuffer;
	    end else begin
		last_ch := '}';
	    end;
	    Docomment(last_ch);
	end;
    end; (* Skipcomment *)


	(*16*)          (*]Block*)

begin (*Block*)
    invars := true;
    whattopop := nil;
    repeat
	Insymbol;
    until syty in relevantsym;
    level := level + 1;
    nextspaces := level * feed;
    repeat
	fwddecl := false;
	if syty = programsy then begin
	    Writeline(bufferptr-syleng);
	    oldspaces := true;
	    presentspaces := Max(0,nextspaces-feed);
	    programpresent := true;
	    Insymbol;
	    prog_name := sy;
	    Writeln(tty);
	    Write(tty, version:verlength, ': ', old_name:6
		  , ' [ ', prog_name, ' ]');
	    if not quiet then begin
		Write(tty,' PAGE');
		for i := 1 to pagecnt do Write (tty, i:3, '..');
	    end;
	    (* Break(tty); *)
	    repeat
		Insymbol;
	    until syty in relevantsym;
	end; (* Syty = programsy *)

	while syty in decsym do                 (*Declarations: labels, types, vars*) begin
	    Writeline(bufferptr-syleng);
	    oldspaces := true;
	    presentspaces := Max(0,nextspaces-feed);
	    if forcing then begin
		Skipcomment;
		Writeline(bufferptr);
	    end;
	    Insymbol;
	    while not (syty in relevantsym) do begin
		loop
		    Vardef;
		    Insymbol;
		exit if syty <> comma;
		    Insymbol;
		end; (* Loop *)
		while not (syty in [semicolon] + relevantsym) do if syty = recordsy then
								     Recdef
								 else Insymbol;
		Insymbol;
	    end;
	end; (* While syty in decsym *)
	invars := false;
	while syty in prosym do                 (*Procedure and function declarations*) begin
	    Writeline(bufferptr-syleng);
	    oldspaces := true;
	    presentspaces := Max(0,nextspaces-feed);
	    if syty <> initprocsy then begin
		Insymbol;
		if syty = ident then
		    Procdef; (*Put the symbol in proctable*)
	    end;
	    Block;
	    if syty = semicolon then
		Insymbol;
	end (*While syty in prosym*)        (*Forward and external declarations may come before 'var', etc.*)
    until not fwddecl;
    if forcing then
	Writeline(bufferptr-syleng);
    level := level - 1;
    nextspaces := level * feed;
    if not (syty in [beginsy,forwardsy,externsy,eobsy(*,langsy*)]) then begin
	if (level = 0) and (syty = point) then
	    nobody := true
	else Error (begerrinblkstr);
	while not (syty in [beginsy,forwardsy,externsy,eobsy,(*Langsy,*)point]) do Insymbol
    end;
    if syty = beginsy then
	Statement
    else if not nobody then begin
	fwddecl := true;
	Insymbol;
    end;
    if level = 0 then begin
	if programpresent then begin
	    if nobody then begin
		Error (missgmain);
		errcount := errcount - 1;
	    end;
	    if syty <> point then
		Error(missgpoint);
	    Writeln(tty);
	    Writeln(tty,errcount:4,' ERROR(S) DETECTED');
	    (* Break(tty); *)
	end; (* If programpresent *)
	Writeline(bufflen+2);
    end; (* Level = 0 *)
    Popoff;
end; (*Block*)


    (*17*)    (*Main program*)

begin
rtime := Runtime;
Startfiles;
Initialize;

ch := ')'; (* Hack -- forces first character to be read *)

loop
    Block;
exit if not programpresent or (syty = eobsy);
    Reinitialize;
end;


while not Eof(oldsource) do (* Otherwise you can lose half a program *) begin
    while not Eoln(oldsource) do begin
	newsource^ := oldsource^;
	Get(oldsource);
	Put(newsource);
    end;
    Readln(oldsource);
    Writeln(newsource);
end;

if counting then begin
    Writeln(tty,definitions:6,' procedure and function definitions');
end;
rtime := Runtime - rtime;
Write(tty,'RUNTIME: ',(rtime div 60000):0,':');
rtime := rtime mod 60000;
if rtime div 1000 < 10 then begin
    Write(tty,'0');
end;
Write(tty,(rtime div 1000):0,'.');
rtime := rtime mod 1000;
if rtime < 100 then begin
    if rtime < 10 then begin
	Write(tty,'00');
    end else begin
	Write(tty,'0');
    end;
end;
Writeln(tty,rtime:0)
end (* Pform *).
