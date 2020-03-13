
{    *     *      *      *     *   *     *   *     *   *     *   *******      }
{    **   **     * *     **    *   *     *   *     *   **    *      *         }
{    * * * *    *   *    * *   *   *     *   *     *   * *   *      *         }
{    *  *  *   *******   *  *  *   *******   *     *   *  *  *      *         }
{    *     *   *     *   *   * *   *     *   *     *   *   * *      *         }
{    *     *   *     *   *    **   *     *    *   *    *    **      *         }
{    *     *   *     *   *     *   *     *     ***     *     *      *         }
{									      }
{ This is a display terminal game.  See procedure Instruct for a description. }
{ Procedures that may be untransportable are marked with **** in declaration. }
{ A few variables, etc. are also marked.				      }




PROGRAM Manhunt;  { by Paul Kienitz, originally written in BASIC. }




LABEL 9999;  { points to "END."  --use GOTO 9999 for error halt. }




CONST
    copyright = ' Copyright (c) 1981 by Paul Kienitz.  Versions written in BASIC (c) 1979, 1980 by Paul Kienitz. ';
    citysize = 12;			{ length of side of square city, in blocks }
    maxrange = 8;			{ maximum range of a taxi, in blocks; minimum range is 1 }
    maxcops = 9;			{ maximum number of cops; WARNING: see Instruct if > 9 }
    hallrow = 1;			{ row (north/south coordinate) of City Hall }
    hallcol = 1;			{ column of City Hall (upper left [northwest] is 1,1) }
    escaperow = citysize;		{ row of Earth embassy entrance }
    escapecol = citysize;		{ column of Earth embassy entrance }
    playersymbol = '@';			{ character used (italicized) to show player's position }
    copsymbol = '*';			{ character used to show a cop's position }
    hallsymbol = 'H';			{ character used to show City Hall's position when nobody's there }
    escapesymbol = 'E';			{ character used to show Earth embassy entrance's position }
    emptysymbol = ' ';			{ character used to show an empty block }
    pilesymbol = 'X';			{ character used to show a player and a cop on the same block }
    inputwait = 5000;			{ number of milliseconds the player is allowed to input a taxi command }
    maxhallturns = 6;			{ maximum number of consecutive turns the player can stay at City Hall }
    startscramblechance = 0.02;		{ value of (scramblechance) before praise or complaints }
    complaintpower = 2.0;		{ factor by which (scramblechance) changes after praise or complaint }




TYPE
    feature = (directaddr,cleareol,cleareos,clearscreen,lineinsdel,charinsdel,
	       lowercase,italic,blinkmode,blinkfield,multiple,gohome,updownleftright);  { **** terminal features }
    spot = RECORD			{ position in city }
	       row,col: integer END;	{ (not 1..citysize because illegal values are sometimes necessary in LegalMove) }
    direction = (here,north,south,east,west);  { direction of taxi motion (here = no movement) }

VAR
    player: spot;			{ where in the city the player is }
    copcount: 1..maxcops;		{ how many cops are after him }
    cop: ARRAY[1..maxcops] OF spot;	{ where each cop is }
    map: ARRAY[1..citysize,1..citysize]
		    OF 0..maxrange;	{ the ranges of the various taxis (0 means forbidden square-- the embassy entrance) }
    copmap: ARRAY[1..citysize,1..citysize] 
		    OF boolean;		{ quick refrence for whether a cop is here }
    ambushes,blocks,			{ number of ambushes set up / blocks set up }
	openings: 0..4;			{ number of legal moves the player has }
    hallturns: 0..maxhallturns;			{ number of consecutive turns in City Hall }
    scramblechance: real;		{ probability that the board will be scrambled in this turn }
    tailing,warn,			{ a cop is tailing / the player recieves warnings of ambush & tail & surround }
	waiting,win,bust,		{ we are waiting for player move / player has won / cops have caught player }
	playing: boolean;		{ map display is on }
					{ screen }
    jobnumber: integer;			{ **** current job number; needed only at Stanford LOTS }




PROCEDURE SetRandom(seed: integer);  { **** }
{ Gives a seed to the Random function. }
    EXTERN FORTRAN;


PROCEDURE PsiDefine(chan,level: integer; PROCEDURE Server);  { **** }
{ Causes an interrupt on channel (chan) to call the procedure Server. }
    EXTERN;


PROCEDURE PsiEnable(chan: integer);  { **** }
{ Activates interrupt channel (chan), so that it can be used. }
    EXTERN;


PROCEDURE PsiDisable(chan: integer);  { **** }
{ De-activates interrupt channel (chan), so it does nothing. }
    EXTERN;

{ **** The following EXTERN declarations are for the Stanford LOTS }
{ display (dpy) package. }
PROCEDURE DpyInitialize; EXTERN;	{ Sets up dpy (learns terminal type, etc.) and turns on }
PROCEDURE TurnOn; EXTERN;		{ Puts the terminal in binary mode, flushes dpy's output buffer, etc. }
PROCEDURE TurnOff; EXTERN;		{ does DpyOutput, puts terminal in old mode, undefines cursor, etc. }
PROCEDURE DpyOutput; EXTERN;		{ forces out the contents of the dpy output buffer }
PROCEDURE DoCP; EXTERN;			{ clears the terminal screen }
PROCEDURE DoEEOP; EXTERN;		{ clears from cursor to the end of terminal screen }
PROCEDURE SetCursor(col,row: integer); EXTERN;	{ moves the cursor }
PROCEDURE DpyChr(c: char); EXTERN;	{ outputs a character through dpy }
PROCEDURE DpyString(s: string); EXTERN;	{ outputs a string through dpy }
PROCEDURE SetItalic; EXTERN;		{ causes further output to be reverse video, bright, or whatever terminal has }
PROCEDURE ClrItalic; EXTERN;		{ undoes SetItalic }
FUNCTION RCY: integer; EXTERN;		{ current cursor row }
FUNCTION RCX: integer; EXTERN;		{ current cursor column }
FUNCTION RMaxCY: integer; EXTERN;	{ maximum cursor row }
FUNCTION RMaxCX: integer; EXTERN;	{ maximum cursor col }
FUNCTION RBPS: integer; EXTERN;		{ terminal's BAUD rate }
FUNCTION FTest(x: feature): boolean; EXTERN;  { true if the specified terminal feature is supported }
{ End of dpy package declarations. }


PROCEDURE DpyPause(p: integer);	 { **** }
{ does DpyOutput and waits (p) milliseconds }
    BEGIN
    DpyOutput;
    Jsys(167B;p);  { DISMS for p milliseconds }
    END;




PROCEDURE PsiSetKey(chan: integer; key: char);	{ **** }
{ Causes typing character (key) at the terminal to trigger interrupt }
{ channel (chan).  The Pascal implementors neglected this.           }
    BEGIN
    Jsys(137B;key: chan)  { ATI monitor call --associates key with channel }
    END;  { PsiSetKey }




PROCEDURE GetKey(VAR command: char);  { **** }
{ reads one character immediately from the terminal without echoing control }
{ chars.  If the input buffer is empty, waits for a keystroke.              }
    BEGIN
    DpyOutput;
    Jsys(73B;;command);	 { PBIN monitor call --grabs one character instantly from the terminal or it's input buffer }
    IF command > ' ' THEN
	DpyChr(command)
    END;  { GetKey }

FUNCTION KeyHasBeenHit: boolean;  { **** }
{ True if the player has hit a key since the last GetKey.  The key he hit }
{ will be input by the next GetKey.					  }
    VAR
	i: 1..2;
    BEGIN
    Jsys(102B,1,i;100B);  { SIBE monitor call --tells whether terminal input buffer contains a character }
    KeyHasBeenHit := i = 1
    END;  { KeyHasBeenHit }




PROCEDURE ClearTerminalInputBuffer;  { **** }
{ Empties the input buffer that unread keystrokes are stored in.    }
{ KeyHasBeenHit will return false until the player types something. }
    BEGIN
    Jsys(100B;100B)  { CFIBF monitor call --clears input buffer }
    END;  { ClearTerminalInputBuffer }




FUNCTION RandInt(range: integer): integer;
{ Returns a random integer in 1..range. }
    BEGIN
    RandInt := Trunc(Random(0.0) * range) + 1
    END;  { RandInt }




PROCEDURE Move(oldspot: spot; VAR newspot: spot; d: direction);
{ Puts the result of a move from (oldspot) in direction (d) }
{ into (newspot), unless (oldspot) is off the map.  It does }
{ not reject illegal moves.				    }
    BEGIN
    newspot := oldspot;
    IF (oldspot.row >= 1) AND (oldspot.row <= citysize) AND (oldspot.col >= 1) AND (oldspot.col <= citysize) THEN
	CASE d OF
	    here: ;
	    north: newspot.row := newspot.row - map[oldspot.row,oldspot.col];
	    south: newspot.row := newspot.row + map[oldspot.row,oldspot.col];
	    east: newspot.col := newspot.col + map[oldspot.row,oldspot.col];
	    west: newspot.col := newspot.col - map[oldspot.row,oldspot.col] END
    END;  { Move }

FUNCTION LegalMove(place: spot; d: direction; iscop: boolean): boolean;
{ Returns true if the player/cop at (place) can move legally in }
{ direction (d).  (iscop) is true when asking about a cop.      }
    VAR
	newplace: spot;	 { the place where the move, if legal, would end up }
    BEGIN
    Move(place,newplace,d);
    IF (newplace.row >= 1) AND (newplace.row <= citysize) AND (newplace.col >= 1) AND (newplace.col <= citysize) THEN
	LegalMove := NOT (iscop AND (((copmap[newplace.row,newplace.col]) AND (d > here))
			   OR ((newplace.row = escaperow) AND (newplace.col = escapecol))
			   OR ((newplace.row = hallrow) AND (newplace.col = hallcol))))
    ELSE
	LegalMove := false
    END;  { LegalMove }




FUNCTION SameSpot(a,b: spot): boolean;
{ Tests (a) and (b) for equality. }
    BEGIN
    SameSpot := (a.row = b.row) AND (a.col = b.col)
    END;  { SameSpot }




FUNCTION OnHall(a: spot): boolean;
{ True if (a) is coordinates of City Hall. }
    BEGIN
    OnHall := (a.row = hallrow) AND (a.col = hallcol)
    END;  { OnHall }




PROCEDURE Crlf;
{ Moves to the left edge of the next line, blanking it. }
    BEGIN
    DpyChr(Chr(13));
    DpyChr(Chr(10))
    END;  { Crlf }




PROCEDURE DpyInteger(i: integer);
{ Writes an integer in 0..999 through the dpy package. }
    BEGIN
    IF i >= 100 THEN
	DpyChr(Chr(i DIV 100 + Ord('0')));
    IF i >= 10 THEN
	DpyChr(Chr(i MOD 100 DIV 10 + Ord('0')));
    DpyChr(Chr(i MOD 10 + Ord('0')))
    END;  { DpyInteger }

PROCEDURE Instruct(VAR copcount: integer; VAR warn: boolean);
{ Gives the player instructions and determines how many cops }
{ he wants and whether he wants to be warned.		     }
    VAR
	command: char;	{ player's input; a digit or 'Y'/'N' }
    BEGIN
    DpyString('This is the game of Manhunt, by Paul Kienitz.'); Crlf;
    REPEAT
	Crlf; Crlf;
	DpyString('Do you want instructions? [Y or N] ');
	GetKey(command)
    UNTIL command IN ['n','y'];  { covers both cases at SU-LOTS }
    IF (command = 'Y') OR (command = 'y') THEN BEGIN
	DoCP;
	DpyString('You are on the run on Arcturus IV, the home planet of the Lugimen.   You'); Crlf;
	DpyString('must escape  the police,  winning your  way from  the City  Hall to  the'); Crlf;
	DpyString('hidden entrance of  the Earth Embassy.   The only transportation  system'); Crlf;
	DpyString('available to  either you  or the  police is  the city''s  automated  taxi'); Crlf;
	DpyString('system, famed  throughout  the  galaxy  as one  of  the  most  annoying,'); Crlf;
	DpyString('ridiculous, and inefficient transportation systems ever designed.'); Crlf; Crlf;
	DpyString('The city is divided into  a ');
	DpyInteger(citysize);
	DpyString(' by ');
	DpyInteger(citysize);
	DpyString(' grid of squares.  Each square  con-'); Crlf;
	DpyString('tains a taxi, which is labeled with a number from 1 to ');
	DpyInteger(maxrange);
	DpyString('.  You tell  the'); Crlf;
	DpyString('taxi which direction to go, and that number tells the exact distance  it'); Crlf;
	DpyString('will cover,  in squares.  The  taxi cannot  go  less than  it''s  labeled'); Crlf;
	DpyString('distance. As you can probably see, paths from point A to point B tend to'); Crlf;
	DpyString('be long and convoluted.  You can also  tell the taxi to go back to  City'); Crlf;
	DpyString('Hall, which it will do without reguard for it''s labeled distance.'); Crlf; Crlf;
	DpyString('    (Hit any key to continue:) ');
	GetKey(command);
	DoCP;
	DpyString('If a cop manages to land on the square you''re on, you''re dead.  The  one'); Crlf;
	DpyString('exception is  City Hall,  where you  and any  number of  cops can  exist'); Crlf;
	DpyString('simultaneously, because  any  cop there  has  to spend  his  time  doing'); Crlf;
	DpyString('paperwork.  For this reason, the cops  avoid City Hall. You can stay  in'); Crlf;
	DpyString('City Hall for several turns, but after that you''re busted for loitering.'); Crlf; Crlf;
	DpyString('Each taxi contains a map showing the ');
	DpyInteger(Sqr(citysize));
	DpyString(' city squares, with the range of'); Crlf;
	DpyString('the appropriate taxi.  The map shows your position, the positions of all'); Crlf;
	DpyString('the cops, and the  locations of City Hall  and the Earth Embassy  secret'); Crlf;
	DpyString('entrance.  At the start of the game, you are on City Hall.'); Crlf; Crlf;
	DpyString('    (Hit any key to continue:) ');
	GetKey(command);
	DoCP;

	DpyString('If you  choose  to, you  will  get warnings  when  the cops  get  close.'); Crlf;
	DpyString('"Tail!" means that a  cop is following you  one jump behind.   "Ambush!"'); Crlf;
	DpyString('means that one of your possible  moves will result in being  immediately'); Crlf;
	DpyString('jumped on by  a cop.   "You are surrounded!"  means just  what it  says.'); Crlf;
	DpyString('Fortunately, The  cops  do  not  know where  the  Earth  Embassy  secret'); Crlf;
	DpyString('entrance is.  If not  for this, you  wouldn''t have a  chance in hell  of'); Crlf;
	DpyString('making it to the Embassy.'); Crlf; Crlf;
	DpyString('You may use the taxi to complain about the taxi system, or to praise it.'); Crlf;
	DpyString('From time to time, the City Council will attempt to make the taxi system'); Crlf;
	DpyString('more efficient by reorganizing it.  You complaints and praise affect the'); Crlf;
	DpyString('probability of  this  happening.   Remember  that  you  can''t  move  and'); Crlf;
	DpyString('complain in the  same turn,  however, and that  asking the  taxi for  an'); Crlf;
	DpyString('impossible direction  (one that  would  take it  outside the  city),  or'); Crlf;
	DpyString('taking too much time to tell it what to do, also costs you a turn.   How'); Crlf;
	DpyString('much time is too much?  You get about five seconds.') END;
    REPEAT
	Crlf; Crlf;  { WARNING: This loop will lose if maxcops > 9! }
	DpyString('How many cops do you think they''ll need to catch you? [1..');
	DpyInteger(maxcops);
	DpyString('] ');
	GetKey(command);
	copcount := Ord(command) - Ord('0')
    UNTIL (copcount >= 1) AND (copcount <= maxcops);
    REPEAT
	Crlf; Crlf;
	DpyString('Do you want to see warnings when the cops get close? [Y or N] ');
	GetKey(command)
    UNTIL command IN ['n','y'];
    warn := (command = 'Y') OR (command = 'y')
    END;  { Instruct }




PROCEDURE Refresh;
{ Blanks the screen and redraws the map and all the other stuff. }
    VAR
	row,col: 1..citysize;
	i: integer;
    BEGIN
    DoCP;
    DpyString('(Use ^C to halt continuably.  Use ^R to refresh the screen.)');
    FOR row := 1 TO citysize DO BEGIN
	SetCursor(0,row + 1);
	FOR col := 1 TO citysize DO BEGIN
	    IF (row = player.row) AND (col = player.col) THEN BEGIN
		SetItalic;
		IF copmap[row,col] THEN
		    DpyChr(pilesymbol)
		ELSE
		    DpyChr(playersymbol);
		ClrItalic END

	    ELSE
		IF copmap[row,col] THEN
		    DpyChr(copsymbol)
		ELSE
		    IF (row = hallrow) AND (col = hallcol) THEN
			DpyChr(hallsymbol)
		    ELSE
			IF (row = escaperow) AND (col = escapecol) THEN
			    DpyChr(escapesymbol)
			ELSE
			    DpyChr(emptysymbol);
	    IF map[row,col] = 0 THEN
		DpyChr('!')
	    ELSE
		DpyInteger(map[row,col]);
	    DpyChr(' ') END END;
    SetCursor((citysize * 3) + 5,2);
    DpyString('Taxi options:');
    SetCursor((citysize * 3) + 5,3);
    DpyString('=============');
    SetCursor((citysize * 3) + 5,4);
    DpyString('N,8,^ = go north (up)');
    SetCursor((citysize * 3) + 5,5);
    DpyString('S,2,v = go south (down)');
    SetCursor((citysize * 3) + 5,6);
    DpyString('E,6,> = go east (right)');
    SetCursor((citysize * 3) + 5,7);
    DpyString('W,4,< = go west (left)');
    SetCursor((citysize * 3) + 5,8);
    DpyString('B,7 = go back to City Hall');
    SetCursor((citysize * 3) + 5,9);
    DpyString('H,5 = stay here');
    SetCursor((citysize * 3) + 5,10);
    DpyString('P = praise the taxi system (ha!)');
    SetCursor((citysize * 3) + 5,11);
    DpyString('C = complain about the taxi system');
    SetCursor(0,citysize + 3);
    DpyChr('(');
    SetItalic;
    DpyChr(playersymbol);
    ClrItalic;
    DpyString(' is you, ');
    DpyChr(copsymbol);
    DpyString(' is a cop, ');
    DpyChr(hallsymbol);
    DpyString(' is City Hall, ');
    DpyChr(escapesymbol);
    DpyString(' is the Embassy, ');
    SetItalic;
    DpyChr(pilesymbol);
    ClrItalic;
    DpyString(' is you AND a cop)');
    SetCursor(0,citysize + 7);
    IF openings = 0 THEN
	DpyString('You are stuck.    ');
    IF warn THEN BEGIN
	IF NOT OnHall(player) AND tailing THEN
	    DpyString('Tail!    ');
	FOR i := 1 TO ambushes DO
	    DpyString('Ambush!    ');
	IF (openings > 0) AND (openings <= blocks + ambushes) THEN
	    DpyString('You are surrounded!!') END;
    IF waiting THEN BEGIN
	SetCursor(4,citysize + 5);
	DpyString('Taxi: "Which way, sir?" ') END;
    DpyOutput
    END;  { Refresh }

PROCEDURE Pause;  { **** }
{ Blanks the screen and returns to the EXEC.  If the user tells the EXEC to   }
{ CONTINUE, it turns dpy back on and refreshes, then returns to where it was. }
    BEGIN
    DoCP;
    TurnOff;
    Jsys(170B);  { HALTF monitor call --stops program; CONTINUE command will restart at next instruction }
    TurnOn;
    IF playing THEN
	Refresh
    ELSE
	Jsys(114B;100B,Chr(10))	 { STI monitor call --makes as if player hit linefeed }
    END;  { Pause }




PROCEDURE EnforceGamePlayingRulesAtStanfordLOTS;  { **** Throw this away at other sites }
{ Enforces the numberous rules restricting the playing of games at this site. }
    TYPE
	flagnames = (b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,
		     b14,b15,b16,b17,notokay,b19,b20,b21,b22,b23,
		     ptykick,ptywarn,generalkick,generalwarn,
		     daytimekick,daytimewarn,dialinkick,dialinwarn,
		     queuekick,queuewarn,loadkick,loadwarn);
	blk = RECORD
		  blklength: integer;  { size of this block in words (=2) }
		  CASE boolean OF
		      false: (flags: PACKED ARRAY[flagnames] OF boolean);
		      true: (flagsum: integer)
		      END;
	pblk = ^blk;
    VAR
	ppblk: ^pblk;  { pointer to a pointer to a block where flags are returned by GETOK%.  This is WRONG }
		       {  according to the monitor calls manual, but it works. }
	garbage: integer;
    BEGIN
    IF jobnumber = 0 THEN
	Jsys(13B;;garbage,garbage,jobnumber);  { GJINF monitor call --get job number }
    New(ppblk);
    New(ppblk^);
    ppblk^^.blklength := 2;
    ppblk^^.flagsum := 0;
    Jsys(574B,-1;400001B,ppblk,1,jobnumber);  { GETOK% monitor call --get ACJ permission to play games }
    WITH ppblk^^ DO
	IF flags[notokay] THEN
	    IF flags[generalkick] THEN BEGIN
		DoCP;
		Crlf;
		IF playing THEN
		    DpyString('LOTS is now too crowded to permit game playing, so the cops get you.')
		ELSE
		    DpyString('You can''t play games now.');
		Crlf;
		TurnOff;
		GOTO 9999 END

	    ELSE
		IF playing THEN
		     IF flags[loadwarn] THEN BEGIN
			 SetCursor(68,0);
			 SetItalic;
			 DpyString('** Load **');
			 ClrItalic END
		     ELSE
			 IF flags[queuewarn] THEN BEGIN
			     SetCursor(68,2);
			     SetItalic;
			     DpyString('** Queue **');
			     ClrItalic END
			 ELSE  { currently unimplemented warning }
		 ELSE BEGIN
		     DpyString('WARNING== It''s not a good time to play games.');
		     Crlf; Crlf END
    END;  { EnforceGamePlayingRulesAtStanfordLOTS }




PROCEDURE Initialize;  { **** }
{ Sets things up. }
    BEGIN
    Jsys(151B;400000B,0,400000000000B);	 { EPCAP monitor call --enable ability to trap ^C }
    PsiDefine(33,2,Pause);  { set up continuable-halt interrupt }
    PsiDefine(34,2,Refresh);  { set up interrupt to cause screen refreshing }
    PsiSetKey(33,Chr(3));
    PsiSetKey(34,Chr(18));
    PsiEnable(33);
    DpyInitialize;
    DoCP;
    playing := false;
    jobnumber := 0;
{    EnforceGamePlayingRulesAtStanfordLOTS;	}
    SetRandom(Time);
    win := false;
    bust := false;
    waiting := false
    END;  { Initialize }

PROCEDURE Scramble;
{ Randomly organize the taxi ranges, making sure there are several squares }
{ with access to the escape square.					   }
    CONST
	connections = 5;
    VAR
	i,j: integer;
	row,col: 1..citysize;
	path,pathend: spot;
	d: direction;
	drand: RECORD CASE boolean OF  { converter from RandInt(4) to a random direction }
	       false: (i: 1..4);
	       true: (d: direction) END;
    BEGIN
    FOR row := 1 TO citysize DO
	FOR col := 1 TO citysize DO
	    map[row,col] := RandInt(maxrange);
    pathend.row := escaperow;
    pathend.col := escapecol;
    map[escaperow,escapecol] := 0;  { we make a path (connections) steps long, from anywhere to the embassy. }
    FOR i := 1 TO connections DO BEGIN	{ --This greatly increases the probability that there will be a way to win. }
	j := map[pathend.row,pathend.col];  { --(pathend) is where the current path segment will land. }
	REPEAT
	    map[pathend.row,pathend.col] := RandInt(maxrange);
	    drand.i := RandInt(Ord(west))
	UNTIL LegalMove(pathend,drand.d,false);
	Move(pathend,path,drand.d);  { make a connection from (pathend) to some other place, called (path) }
	map[path.row,path.col] := map[pathend.row,pathend.col];	 { reverse the path's direction by moving the correct }
	map[pathend.row,pathend.col] := j;  { ...range to (path) and restoring (pathend)'s original range }
	pathend := path END;  { make the next path segment connect to the beginning of this one }
    openings := 0;
    FOR d := north TO west DO
	IF LegalMove(player,d,false) THEN
	    openings := openings + 1;
    scramblechance := startscramblechance;
    ambushes := 0;
    blocks := 0;
    tailing := false
    END;  { Scramble }

PROCEDURE PutEverythingInPlace;
{ Places the player and cops, sets up the taxis, etc. }
    VAR
	c: 1..maxcops;
	row,col: 1..citysize;
	d: direction;
    BEGIN
    player.row := hallrow;
    player.col := hallcol;
    Scramble;
    hallturns := 1;
    FOR c := 1 TO copcount DO BEGIN
	cop[c].col := RandInt(citysize - 2) + 1;
	cop[c].row := RandInt(citysize - 2) + 1 END;
    FOR row := 1 TO citysize DO
	FOR col := 1 TO citysize DO BEGIN
	    copmap[row,col] := false;
	    FOR c := 1 TO copcount DO
		IF (cop[c].row = row) AND (cop[c].col = col) THEN
		    copmap[row,col] := true END
    END;  { PutEverythingInPlace }




PROCEDURE AskPlayerMove;
{ Ask the player what he wants to do, and do it. }
    VAR
	commandtime: integer;  { time elapsed waiting for a taxi command }
	command: char;	{ the command typed in (a space if time runs out) }
	goodcommand: boolean;  { the command is legal }


    PROCEDURE MovePlayer(d: direction);
    { Moves the player in direction (d). }
	VAR
	    i: integer;
	BEGIN
	IF LegalMove(player,d,false) THEN BEGIN
	    SetCursor(0,citysize + 5);
	    DoEEOP;
	    FOR i := 1 TO map[player.row,player.col] DO BEGIN
		SetCursor(player.col * 3 - 3,player.row + 1);
		IF copmap[player.row,player.col] THEN
		    DpyChr(copsymbol)
		ELSE
		    IF OnHall(player) THEN
			DpyChr(hallsymbol)
		    ELSE
			DpyChr(emptysymbol);
		CASE d OF
		    north: player.row := player.row - 1;
		    south: player.row := player.row + 1;
		    east: player.col := player.col + 1;
		    west: player.col := player.col - 1 END;
		SetCursor(player.col * 3 - 3,player.row + 1);

		SetItalic;
		IF copmap[player.row,player.col] THEN
		    DpyChr(pilesymbol)
		ELSE
		    DpyChr(playersymbol);
		ClrItalic;
		DpyPause(125) END;
	    openings := 0;
	    FOR d := north TO west DO
		IF LegalMove(player,d,false) THEN
		    openings := openings + 1 END
	ELSE BEGIN
	    SetCursor(4,citysize + 5);
	    CASE d OF
		north: DpyString('Taxi: "It is impossible to go north from here, sir."');
		south: DpyString('Taxi: "It is impossible to go south from here, sir."');
		east: DpyString('Taxi: "It is impossible to go east from here, sir."');
		west: DpyString('Taxi: "It is impossible to go west from here, sir."') END;
	    DpyPause(2000) END
	END;  { MovePlayer }


    BEGIN  { AskPlayerMove }
{    EnforceGamePlayingRulesAtStanfordLOTS;	}
    waiting := true;
    SetCursor(4,citysize + 5);
    DpyChr(Chr(7));
    DpyString('Taxi: "Which way, sir?" ');
    DpyOutput;
    ClearTerminalInputBuffer;
    commandtime := 0;
    goodcommand := false;
    WHILE (commandtime <= inputwait) AND NOT goodcommand DO BEGIN
	DpyPause(250);
	commandtime := commandtime + 250;
	IF KeyHasBeenHit THEN BEGIN
	    GetKey(command);
	    goodcommand := (command IN ['2','4'..'8','<','>','b','c','e','h','n','p','s','v','w','^']) OR (command = Chr(27));
	    IF NOT goodcommand THEN BEGIN
		DpyChr(Chr(7));
		command := ' ' END
	    ELSE
		IF command = Chr(27) THEN BEGIN	 { handle arrow-key escape sequence }
		    GetKey(command);
		    IF (command = '?') OR (command = '[') THEN
			GetKey(command);
		    CASE command OF
			'A': command := 'N';
			'B': command := 'S';
			'C': command := 'E';
			'D': command := 'W'
			END END END END;
    waiting := false;
    CASE command OF
	' ': BEGIN
	    SetCursor(4,citysize + 5);
	    DpyString('Taxi: "You are wasting time, sir."');
	    DpyPause(2000) END;

	'P','p': BEGIN
	    SetCursor(0,citysize + 5);
	    DpyString('Your praise is appreciated by the City Council.');
	    DpyPause(3000);
	    scramblechance := scramblechance / complaintpower END;
	'C','c': BEGIN
	    SetCursor(0,citysize + 5);
	    IF scramblechance > 0.4 THEN
		DpyString('The City Council is already too burdened with complaints to notice any more.')
	    ELSE BEGIN
		DpyString('Your complaint has been noted by the City Council.');
		scramblechance := scramblechance * complaintpower END;
	    DpyPause(3000) END;
	'H','h','5': { nothing };
	'B','b','7': BEGIN
	    openings := 2;
	    SetCursor(player.col * 3 - 3,player.row + 1);
	    DpyChr(emptysymbol);
	    player.row := hallrow;
	    player.col := hallcol;
	    SetCursor(hallcol * 3 - 3,hallrow + 1);
	    SetItalic;
	    IF copmap[hallrow,hallcol] THEN
		DpyChr(pilesymbol)
	    ELSE
		DpyChr(playersymbol);
	    ClrItalic;
	    DpyOutput END;
	'N','n','8','^': MovePlayer(north);
	'S','s','2','V','v': MovePlayer(south);
	'E','e','6','>': MovePlayer(east);
	'W','w','4','<': MovePlayer(west) END;
    SetCursor(0,citysize + 5);
    DoEEOP;
    IF OnHall(player) THEN
	hallturns := hallturns + 1
    ELSE BEGIN
	hallturns := 0;
	IF copmap[player.row,player.col] THEN BEGIN
	    bust := true;
	    SetCursor(player.col * 3 - 1,player.row + 1);
	    SetItalic;
	    DpyString('<= You stumbled right onto a cop! ');
	    ClrItalic;
	    DpyPause(4000) END END;
    IF hallturns >= maxhallturns THEN BEGIN
	bust := true;
	SetItalic;
	DpyString('You have loitered around City Hall too long.');
	ClrItalic;
	DpyPause(4000) END
    END;  { AskPlayerMove }

PROCEDURE MoveCops;
{ Moves all the cops.  For each cop, it tries the five moves north, south,   }
{ east, west, and stay-here.  For each move, it sees what the best result    }
{ it can have is.  The best possible result is to pounce on the player.  The }
{ next best is to ambush the player on two sides at once.  The next best is  }
{ to follow the player one jump behind.  After that comes ambushing the      }
{ player from one direction, blocking one of the player's moves, following   }
{ the player two jumps behind, moving to possibly block the player next      }
{ turn, moving at random, and if all else fails, (the cop is stuck) going    }
{ back to city hall, which it will never do unless it has to.  Random moves  }
{ will probably go where there will be the most choices next turn.  For each }
{ cop, it remembers which direction got the best results and moves that way. }
    TYPE
	anaction = (backtohall,randommove,maybeblock,longtail,block,ambush,tail,doubleambush,pounce);  { a cop-movement strategy }
    VAR
	c: 1..maxcops;	{ which cop is moving now }
	action,bestaction: anaction;  { best strategy for cop (c) moving in direction (d) / best strategy for cop (c) }
	goal: spot;  { where cop (c) will end up by going direction (d) }
	goal2,pgoal: ARRAY[north..west] OF spot;  { places cop (c) can reach from (goal) / places player can reach }
	d,d2,bestd,  { direction being tried for cop (c) / direction of possible further move / cop (c)'s best direction }
	    blockd,bestblockd: direction;  { which player move, if any, is blocked by moving in direction (d) / which }
					   { player move is blocked by (bestd) }
	cursorrow,cursorcol: integer;  { place on screen warning line where next word whould be written }
	blocked,legalgoal2: ARRAY[north..west] OF boolean;  { which player moves are blocked / which moves from (goal) are legal }
	tailinglong: boolean;  { one cop is doing a long tail }


    PROCEDURE FindDoubleAmbush;	 { inside MoveCops }
    { Locates any double ambushes.  If it succeeds, it sets (action) and  }
    { sets (blockd) to the counterclockwisemost of the two blocked moves. }
    { The other block will be filled in by procedure MoveThisCop.	  }
	VAR
	    range: 1..maxrange;
	BEGIN
	range := map[player.row,player.col];
	IF map[goal.row,goal.col] = range THEN
	    IF (goal.row + range = player.row) AND (goal.col - range = player.col) 
				    AND NOT blocked[north] AND NOT blocked[east] THEN BEGIN
		blockd := north;
		action := doubleambush END
	    ELSE
		IF (goal.row - range = player.row) AND (goal.col - range = player.col) 
					AND NOT blocked[east] AND NOT blocked[south] THEN BEGIN
		    blockd := east;
		    action := doubleambush END
		ELSE
		    IF (goal.row - range = player.row) AND (goal.col + range = player.col) 
					    AND NOT blocked[south] AND NOT blocked[west] THEN BEGIN
			blockd := south;
			action := doubleambush END
		    ELSE
			IF (goal.row + range = player.row) AND (goal.col + range = player.col)
						AND NOT blocked[west] AND NOT blocked[north] THEN BEGIN
			    blockd := west;
			    action := doubleambush END
	END;  { FindDoubleAmbush }

    PROCEDURE FindTail;	 { inside MoveCops }
    { Locates any tails.  If it succeeds, it sets (action), (tailing), and }
    { if lucky, (blockd).						   }
	BEGIN
	IF NOT tailing THEN BEGIN
	    IF SameSpot(player,goal2[north]) AND legalgoal2[north] THEN BEGIN
		action := tail;
		IF SameSpot(pgoal[south],goal) THEN
		    blocked[south] := true END;
	    IF SameSpot(player,goal2[south]) AND legalgoal2[south] THEN BEGIN
		action := tail;
		IF SameSpot(pgoal[north],goal) THEN
		    blocked[north] := true END;
	    IF SameSpot(player,goal2[east]) AND legalgoal2[east] THEN BEGIN
		action := tail;
		IF SameSpot(pgoal[west],goal) THEN
		    blocked[west] := true END;
	    IF SameSpot(player,goal2[west]) AND legalgoal2[west] THEN BEGIN
		action := tail;
		IF SameSpot(pgoal[east],goal) THEN
		    blocked[east] := true END END
	END;  { FindTail }


    PROCEDURE FindAmbush;  { inside MoveCops }
    { Locates any ambushes.  If it succeeds, it sets (action) and (blockd). }
	VAR
	    d2,playerd: direction;
	BEGIN
	FOR d2 := north TO west DO
	    FOR playerd := north TO west DO
		IF legalgoal2[d2] AND NOT blocked[playerd] AND SameSpot(goal2[d2],pgoal[playerd]) THEN BEGIN
		    action := ambush;
		    blockd := playerd END
	END;  { FindAmbush }


    PROCEDURE FindBlock;  { inside MoveCops }
    { Locates a block.  If it succeeds, it sets (action) and (blockd). }
	VAR
	    playerd: direction;
	BEGIN
	FOR playerd := north TO west DO
	    IF NOT blocked[playerd] AND SameSpot(pgoal[playerd],goal) THEN BEGIN
		action := block;
		blockd := playerd END
	END;  { FindBlock }

    PROCEDURE FindLongTail;  { inside MoveCops }
    { Locates a long tail.  If it succeeds, it sets (action). }
	VAR
	    d2,d3: direction;
	    goal3: spot;
	BEGIN
	IF NOT tailinglong THEN
	    FOR d2 := north TO west DO
		FOR d3 := north TO west DO
		    IF NOT tailing AND LegalMove(goal2[d2],d3,true) THEN BEGIN
			Move(goal2[d2],goal3,d3);
			IF SameSpot(goal3,player) THEN
			    action := longtail END
	END;  { FindLongTail }


    PROCEDURE FindMaybeBlock;  { inside MoveCops }
    { Locates a maybeblock.  If it succeeds, sets (action). }
	VAR
	    playerd,playerd2,d2: direction;
	    pgoal2: spot;
	BEGIN
	FOR playerd := north TO west DO
	    FOR d2 := north TO west DO
		IF legalgoal2[d2] AND NOT blocked[playerd] THEN
		    FOR playerd2 := north TO west DO BEGIN
			Move(pgoal[playerd],pgoal2,playerd2);
			IF SameSpot(pgoal2,goal2[d2]) THEN
			    action := maybeblock END
	END;  { FindMaybeBlock }


    PROCEDURE PickRandomMove;  { inside MoveCops }
    { Decides what direction to move cop (c) when there are no good moves to make. }
	VAR
	    d,d2: direction;
	    goal: spot;
	    bestfreedom,i: integer;  { maximum value in (moves) }
	    moves: ARRAY[north..west] OF integer;  { number of legal moves available next turn in each direction }
	BEGIN
	FOR d := north TO west DO
	    moves[d] := 0;
	FOR d := north TO west DO
	    IF LegalMove(cop[c],d,true) THEN BEGIN
		Move(cop[c],goal,d);
		FOR d2 := north TO west DO
		    IF LegalMove(goal,d2,true) THEN
			moves[d] := moves[d] + 1 END;
	bestfreedom := 0;
	FOR d := north TO west DO
	    IF moves[d] > bestfreedom THEN
		bestfreedom := moves[d];

	IF (bestfreedom = 0) OR ((bestfreedom = 1) AND (Random(0.0) < 0.25)) THEN
	    bestaction := backtohall
	ELSE BEGIN
	    i := RandInt(moves[north] + moves[south] + moves[east] + moves[west]);
	    IF i <= moves[north] THEN
		bestd := north
	    ELSE
		IF i - moves[north] <= moves[south] THEN
		    bestd := south
		ELSE
		    IF i - moves[north] - moves[south] <= moves[east] THEN
			bestd := east
		    ELSE
			bestd := west END
	END;  { PickRandomMove }


    PROCEDURE MoveThisCop;  { inside MoveCops }
    { Move cop (c) in direction (bestd). }
	VAR
	    i: integer;

	PROCEDURE DoCopMovement;
	{ Physically move the cop in the correct direction, and do warnings. }
	    VAR
		i: integer;
	    BEGIN
	    IF warn THEN
		IF bestaction = tail THEN BEGIN
		    tailing := true;
		    IF NOT OnHall(player) THEN
			DpyString('Tail!    ') END
		ELSE
		    IF bestaction = doubleambush THEN
			DpyString('Ambush!    Ambush!    ')
		    ELSE
			IF bestaction = ambush THEN
			    DpyString('Ambush!    ');

	    cursorrow := RCY;
	    cursorcol := RCX;
	    IF bestd > here THEN
		FOR i := 1 TO map[cop[c].row,cop[c].col] DO BEGIN
		    SetCursor(cop[c].col * 3 - 3,cop[c].row + 1);
		    IF SameSpot(cop[c],player) THEN BEGIN
		       SetItalic;
		       IF copmap[player.row,player.col] THEN
			   DpyChr(pilesymbol)
		       ELSE
			   DpyChr(playersymbol);
		       ClrItalic END
		    ELSE
			IF copmap[cop[c].row,cop[c].col] THEN
			    DpyChr(copsymbol)
			ELSE
			    IF OnHall(cop[c]) THEN
				DpyChr(hallsymbol)
			    ELSE
				DpyChr(emptysymbol);
		    CASE bestd OF
			north: cop[c].row := cop[c].row - 1;
			south: cop[c].row := cop[c].row + 1;
			east: cop[c].col := cop[c].col + 1;
			west: cop[c].col := cop[c].col - 1 END;
		    SetCursor(cop[c].col * 3 - 3,cop[c].row + 1);
		    IF SameSpot(cop[c],player) THEN BEGIN
			SetItalic;
			DpyChr(pilesymbol);
			ClrItalic END
		    ELSE
			DpyChr(copsymbol);
		    DpyPause(125) END;
	    SetCursor(cursorcol,cursorrow)
	    END;  { DoCopMovement }

	BEGIN  { MoveThisCop }
	copmap[cop[c].row,cop[c].col] := false;
	IF OnHall(cop[c]) THEN
	    FOR i := 1 TO copcount DO
		IF OnHall(cop[i]) AND (i <> c) THEN
		    copmap[hallrow,hallcol] := true;
	IF bestaction = backtohall THEN BEGIN
	    cursorrow := RCY;
	    cursorcol := RCX;
	    SetCursor(cop[c].col * 3 - 3,cop[c].row + 1);
	    DpyChr(emptysymbol);
	    cop[c].row := hallrow;
	    cop[c].col := hallcol;
	    copmap[hallrow,hallcol] := true;
	    SetCursor(hallcol * 3 - 3,hallrow + 1);
	    IF OnHall(player) THEN BEGIN
		SetItalic;
		DpyChr(pilesymbol);
		ClrItalic END
	    ELSE
		DpyChr(copsymbol);
	    SetCursor(cursorcol,cursorrow) END
	ELSE BEGIN
	    IF bestaction = ambush THEN
		ambushes := ambushes + 1;
	    IF bestaction = block THEN
		blocks := blocks + 1;
	    IF bestaction = longtail THEN
		tailinglong := true;
	    IF (bestaction = block) OR (bestaction = ambush) OR (bestaction = doubleambush) THEN
		blocked[bestblockd] := true;
	    IF bestaction = doubleambush THEN BEGIN
		ambushes := ambushes + 2;
		CASE bestblockd of
		    north: blocked[east] := true;
		    south: blocked[west] := true;
		    east: blocked[south] := true;
		    west: blocked[north] := true END END;
	DoCopMovement;
	copmap[cop[c].row,cop[c].col] := true;
	IF bestaction = pounce THEN BEGIN
	    bust := true;
	    SetCursor(player.col * 3 - 1,player.row + 1);
	    SetItalic;
	    DpyString('<= Scrrreeeeeeecchh!! ');
	    ClrItalic;
	    DpyPause(4000) END END
	END;  { MoveThisCop }

    BEGIN  { MoveCops }
    cursorrow := citysize + 7;
    cursorcol := 0;
    SetCursor(cursorcol,cursorrow);
    ambushes := 0;
    blocks := 0;
    tailing := false;
    tailinglong := false;
    FOR d := north TO west DO
	blocked[d] := NOT LegalMove(player,d,false);
    FOR d := north TO west DO
	IF NOT blocked[d] THEN BEGIN
	    Move(player,pgoal[d],d);
	    IF OnHall(pgoal[d]) THEN
		blocked[d] := true END;
    FOR c := 1 TO copcount DO
	IF NOT bust THEN BEGIN
	    bestaction := randommove;
	    FOR d := here TO west DO
		IF LegalMove(cop[c],d,true) THEN BEGIN
		    Move(cop[c],goal,d);
		    FOR d2 := north TO west DO BEGIN
			legalgoal2[d2] := LegalMove(goal,d2,true);
			IF legalgoal2[d2] THEN
			    Move(goal,goal2[d2],d2) END;
		    action := randommove;
		    IF NOT OnHall(goal) AND SameSpot(player,goal) THEN
			action := pounce
		    ELSE BEGIN
			FindDoubleAmbush;
			IF action < doubleambush THEN BEGIN
			    FindTail;
			    IF action < tail THEN BEGIN
				FindAmbush;
				IF action < ambush THEN BEGIN
				    FindBlock;
				    IF action < block THEN BEGIN
					FindLongTail;
					IF action < longtail THEN
					    FindMaybeBlock END END END END END;
		    IF action > bestaction THEN BEGIN
			bestaction := action;
			bestblockd := blockd;
			bestd := d END END;
	    IF bestaction = randommove THEN
		PickRandomMove;
	    MoveThisCop END;
    IF NOT bust THEN BEGIN
	IF openings = 0 THEN
	    DpyString('You are stuck.');
	IF warn AND (openings > 0) AND (openings <= blocks + ambushes) THEN
	    DpyString('You are surrounded!') END
    END;  { MoveCops }

PROCEDURE Cheer;
{ Gives praise to the winning player. }
    BEGIN
    DoCP;
    IF copcount > 1 THEN BEGIN
	DpyString('                *     *     ***     *     *'); Crlf;
	DpyString('                 *   *     *   *    *     *'); Crlf;
	DpyString('                  * *     *     *   *     *'); Crlf;
	DpyString('                   *      *     *   *     *'); Crlf;
	DpyString('                   *      *     *   *     *'); Crlf;
	DpyString('                   *       *   *     *   * '); Crlf;
	DpyString('                   *        ***       ***  '); Crlf; Crlf; Crlf;
	DpyString('    *     *      *      *****     *******         ***   *******    *'); Crlf;
	DpyString('    **   **     * *     *    *    *                *       *       *'); Crlf;
	DpyString('    * * * *    *   *    *     *   *                *       *       *'); Crlf;
	DpyString('    *  *  *   *******   *     *   ****             *       *       *'); Crlf;
	DpyString('    *     *   *     *   *     *   *                *       *       *'); Crlf;
	DpyString('    *     *   *     *   *    *    *                *       *        '); Crlf;
	DpyString('    *     *   *     *   *****     *******         ***      *       *'); Crlf; Crlf; Crlf;
	DpyString(' !!!  Wow.  You made it past ');
	DpyInteger(copcount);
	DpyString(' cops!') END
    ELSE
	DpyString(' !!!!  You made it!  Past one goddamn cop.  Big shit.  Be real proud.');
    Crlf
    END;  { Cheer }

PROCEDURE FairTrial;
{ Tells a losing player what happens to him. }
    BEGIN
    DoCP;
    Crlf;
    DpyString('You''re busted for ');
    CASE RandInt(24) OF
	1: DpyString('breathing.');
	2: DpyString('disrespect of the Emperor Ra-Lugi.');
	3: DpyString('attempted posession of clean water.');
	4: DpyString('repeatedly standing on two feet.');
	5: DpyString('posession of inported clothing.');
	6: DpyString('digesting.');
	7: DpyString('misuse of the Emperor''s atmosphere.');
	8: DpyString('failing to sporulate on command.');
	9: DpyString('watching TV without a licence.');
	10: DpyString('drooling to excess.');
	11: DpyString('using a public drinking fountain.');
	12: DpyString('exposing non-Lugonian organs.');
	13: DpyString('resisting arrest.');
	14: DpyString('inefficient use of a taxi.');
	15: DpyString('deficiency of bodily hair.');
	16: DpyString('making too much noise.');
	17: DpyString('blowing your nose incorrectly.');
	18: DpyString('using logic on a police officer.');
	19: DpyString('reading forbidden public information.');
	20: DpyString('looking at an officer''s crotch.');
	21: DpyString('staring at an Imperial subject.');
	22: DpyString('mumbling when questioned.');
	23: DpyString('flagrant mental imbalance.');
	24: DpyString('staying up till four AM.') END;
    DpyString('  After a fair');
    Crlf;
    DpyString('trial, you will be shot.'); Crlf; Crlf;
    IF copcount > 1 THEN BEGIN
	DpyString('It took ');
	DpyInteger(copcount);
	DpyString(' cops to get you.') END
    ELSE BEGIN
	Crlf;
	DpyString('Jeeeeeesus Kee-rist!!  You''re the most incredibly inept clodhopper I''ve ever'); Crlf;
	DpyString('seen in all my years in this city!  What a cretinous jackass!  Busted by ONE'); Crlf;
	DpyString('LOUSY GODDAMN COP!!  Gawd, tell me it isn''t true!') END;
    Crlf
    END;  { FairTrial }

BEGIN  { Main }
Initialize;
IF FTest(updownleftright) AND FTest(cleareos) AND (RBPS >= 1200) AND (RMaxCX >= 78) AND (RMaxCY >= citysize + 7) THEN BEGIN 
    Instruct(copcount,warn);
    PutEverythingInPlace;
    Refresh;
    PsiEnable(34);
    playing := true;
    REPEAT
	AskPlayerMove;
	IF (player.row = escaperow) AND (player.col = escapecol) THEN
	    win := true
	ELSE
	    IF NOT (win OR bust) THEN BEGIN
		IF Random(0.0) < scramblechance THEN BEGIN
		    DoCP;
		    DpyString('The local Lugonian City Council, prodded by complaints about the'); Crlf;
		    DpyString('unbelievable inefficiency of the taxi system, are starting a drastic'); Crlf;
		    DpyString('reorganization.  They say the new system will be a model for all'); Crlf;
		    DpyString('Lugonian cities to follow.'); Crlf;
		    DpyPause(9000);
		    Scramble;
		    refresh END;
		MoveCops END
    UNTIL win OR bust;
    PsiDisable(34);
    playing := false;
    IF win THEN
	Cheer
    ELSE
	FairTrial;
    TurnOff END
ELSE BEGIN
    Writeln(ttyoutput,'This terminal can''t handle Manhunt.');
    Writeln(ttyoutput);
    Writeln(ttyoutput,'The terminal must be able to move the cursor and clear from the');
    Writeln(ttyoutput,'cursor to the end of the screen.  It must have at least ',citysize + 7: 1,' lines');
    Writeln(ttyoutput,'of at least 79 characters, and the BAUD rate must be at least 1200.') END;
9999:
END.
