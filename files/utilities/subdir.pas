(* <UTILITIES>SUBDIR.PAS.6, 10-Jan-84 20:03:09, Edit by MRC *)
(* Changes for Stanford operation *)

{Program for creating subdirectories.  It is sufficiently hard to get
  all the crazy parameters right that our users need to be led through
  by the hand this way.  This has some dependencies on our accounting
  structure, so it may not be appropriate for you.}

{this is an old program. I would now use PASCMD for the command scanning.
  Also the string handling code is grungy.  I would now use the string
  routines in STRING, though nothing will make string handling pleasant
  in Pascal.  Have you ever thought of using SAIL?}

TYPE
  STR = PACKED ARRAY[1:40]OF CHAR;
  array14 = packed array[1:14]of char;
  GRP = ARRAY[0:30]OF INTEGER;
  STRPT = ^ STR;
  GRPPT = ^ GRP;
VAR
DIRBLK,SUBDIRBLK:PACKED RECORD   (* argument block for CRDIR  *)
		{DIRBLK is the main one, used for reading
			the main directory and creating the subdir.
		SUBDIRBLK is used to remember the old parameters
			if the subdir existed before}
  LEN:INTEGER;	        (* i.e. directory attributes *)
  passpt:integer;	(* password - not used here *)
  WORK:INTEGER;		(* working quota *)
  CAP:INTEGER;		(* capabilities *)
  MODE:INTEGER;		(* files-only or not *)
  PERM:INTEGER;		(* perm. quota *)
  DIRNO:INTEGER;	(* direct. no to use (unused) *)
  DEFFILE:INTEGER;  	(* default file prot. *)
  DIRPROT:INTEGER;   	(* protection of direcotry *)
  GENS:INTEGER;		(* no. of generations to keep *)
  DATE:INTEGER;		(* date last logged in *)
  dum1:0..777777B;USERL:GRPPT;
  DUM2:0..777777B;DIRL:GRPPT;	(* list of user groups allowed to access *)
  SUBDIRS:INTEGER;	(* how many subdirectories he can have *)
  dum3:0..777777B;SUBUSL:GRPPT;	(* list of user groups he can put his sfd's in *)
  DEFACCT:integer;	(* defalt acct. for login *)
  END;
BITS:SET OF 0..35;	(* standard word to put bits from jsys in *)
CURDIR,CURUSER,I,J:INTEGER;
   (* curdir, curuser are index of current user and dir in dirl, userl *)
mainused,subused: integer;
   (* disk space actually used in main dir and (for old subdirs) the subdir *)
dirno36,uniquegroup:integer;
   (* dirno36 is 36-bit dir. no. of this user.  uniquegroup is group
	no. unique to each user, to give him access to his SFD's,
	etc.  It is a group that looks the same in decimal as his
	directory number in octal *)
olddir:Boolean;
S,DIRNAME:PACKED ARRAY[1:80]OF CHAR;  (* the guy we're worrying about *)
DIRLEN: INTEGER;  (* length of directory name *)

PROCEDURE QUIT; EXTERN;

function getyn:Boolean;
   var ch:char;
  begin
  loop
  write(TTY,'[Y or N] :');
  readln(tty); read(tty,ch);
  exit if ch in ['Y','N'];
  writeln(tty,'You must type Y or N');
  end;
  getyn := ch = 'Y'
  end;

function getnum(ub:integer):integer;
   var n:integer;
  begin
  loop
    write(tty,'Type ');
    for n := 1 to ub-1 do
      write(tty,n:0,', ');
    write(tty,'or ',ub:0,' :');
    readln(tty); read(tty,n);
   exit if (not eof(tty)) and (n >= 1) and (n <= ub);
    reset(tty,'',true,0,0,5);
    writeln(tty,'You must type a number between 1 and ',ub:0);
  end;
  getnum := n
  end;

function getint(lb,ub:integer):integer;
   var n:integer;
  begin
  loop
    readln(tty); read(tty,n);
   exit if (not eof(tty)) and (n >= lb) and (n <= ub);
    reset(tty,'',true,0,0,5);
    writeln(tty,'You must type a number between ',lb:0,' and ',ub:0);
    write(tty,'Please try again: ');
  end;
  getint := n
  end;

procedure getowndir;  (* gets data from main directory *)
    var place:array[1:1]of integer;
	ret:integer;
  begin
  jsys(507B%getji\,2,ret;-1,-1:place,17B%logged in dir\);
  if ret = 1
    then begin
    writeln(tty,'? Can''t find your logged in directory - lose big');
    quit
    end;
  dirno36 := place[1];
  jsys(241B%gtdir\;place[1],dirblk,0);
  jsys(305B%gtdal\;place[1];mainused,mainused);
  if dirblk.subdirs <= 0
    then begin
    writeln(tty,'? Your quota for subdirectories is exhausted');
    quit
    end
  end;

PROCEDURE GETNAME;  (* reads directory name and makes sure it 
        		exists.  If not,create him with default attr's.
			This is because we need the dir. no. in order to
			make the unique group no., so he must exist *)
    VAR ret,i,slen:INTEGER; S:PACKED ARRAY[1:6]OF CHAR; sdir:packed array[1:40]of char;
  BEGIN
  jsys(41B%dirst\,2,ret;dirname,dirno36);
  if ret = 1
    then begin
    writeln(tty,'? Can''t translate directory number - lose big');
    quit
    end;
  for i := 1 to 45 do
    if dirname[i] = chr(0)
      then goto 2;
2:dirlen := i-1;
  dirname[dirlen] := '.';
  writeln(tty);
1:WRITE(TTY,'Subdirectory to create:  ',dirname:dirlen);
{Begin Stanford deletion
  READLN(TTY);
 End Stanford deletion}
  READ(TTY,sdir:slen);
  if slen > 39
    then begin writeln(tty,'Name is too long'); goto 1 end;
  if sdir[slen] # '>'
    then begin slen := slen+1; sdir[slen] := '>' end;
  if dirlen+slen+1 > 80
    then begin writeln(tty,'Name is too long'); goto 1 end;
  for i := 1 to slen do
    dirname[dirlen+i] := sdir[i];
  DIRNAME[DIRLEN+slen+1] := chr(0);
  JSYS(553B,-3,I;1:0,DIRNAME,0;BITS,dirno36,dirno36);
     (* rcdir - see if he exists.  If so get the direct. no. *)
  if i > 2
    then begin
    jsys(11B,3;101B,400000B:-1,0);  (* print error msg *)
    writeln(tty);
    writeln(tty,'Please fill in the subdirectory name after the dot');
    goto 1
    end;
  olddir := not (3 in bits);   {nonexistent?}
  if olddir
    then begin
	 write(tty,'Directory already exists.  Do you want to redefine its parameters? ');
         if not getyn
           then begin
           writeln(tty,'OK, then we won''t do that one.');
	   goto 1
	   end;
	 jsys(305B%gtdal\;dirno36;subdirblk.work,subused,subdirblk.perm);
	 end
    else begin
	 subused := 0;
	 subdirblk.work := 0;
	 subdirblk.perm := 0
	 end;
  end;

procedure setunique;
  begin
  STRWRITE(OUTPUT,S); WRITE(dirblk.dirno:6:O);  (* get right 6 digits *)
  STRSET(INPUT,S); READ(uniquegroup);  (* and make into decimal no. *)
{Begin Stanford addition}
  uniquegroup := uniquegroup + 10000;
{End Stanford addition}
     (*that, then is the "unique group" to identify just him *)
  END;

procedure setgroups;
  begin
  writeln(tty);
  writeln(tty,'What group of users do you want to have special rights over');
  writeln(tty,'files in the subdirectory?');
  writeln(tty,'  1 - you');
  writeln(tty,'  2 - other people in your group (as defined for the directory');
  writeln(tty,'      you are currently logged into)');
  writeln(tty,'  3 - both of the above');
  with dirblk do
  case getnum(3) of
    1: begin dirl^[0] := 2; dirl^[1] := uniquegroup end;
    2: if dirl^[0] >= 31
         then writeln(tty,'% Warning: too many people in your group - first 30 used');
    3: begin
       if dirl^[0] >= 30
	 then begin
         writeln(tty,'% Warning: too many people in your group - first 29 used');
	 dirl^[0] := 30;
         end;
       dirl^[dirl^[0]] := uniquegroup;
       dirl^[0] := dirl^[0] +1
       end;
   end;
  end;

procedure setrights;
  begin
  writeln(tty);
  writeln(tty,'What rights do you want this group to have?');
  writeln(tty,'  1 - to be treated completely as owners');
  writeln(tty,'  2 - to have complete rights over most existing files');
  writeln(tty,'  3 - to have read access to most files');
  writeln(tty,'By "most files" I means files that you have not ');
  writeln(tty,'specifically assigned a non-default protection to');
  with dirblk do
  case getnum(3) of
    1: begin dirprot := 777740B; deffile := 777700B end;
    2: begin dirprot := 774040B; deffile := 777700B end;
    3: begin dirprot := 774040B; deffile := 775200B end;
    end;
  end;

procedure setotherrights;
  begin
  writeln(tty);
  writeln(tty,'What rights do you want all other users to have?');
  writeln(tty,'  1 - to have read access to most files');
  writeln(tty,'  2 - to have no access to most files');
  with dirblk do
  case getnum(2) of
    1: deffile := deffile + 52B;
    2: ;
    end;
  end;

procedure writequotas(perm,work:integer);
  begin
  writeln(tty,'  Permanent: ',perm:0);
  writeln(tty,'  Working: ',work:0);
  end;

procedure setquotas;
    var permlb,permub,worklb,workub: integer;
  begin
  with dirblk do
    begin
    writeln(tty);
    permlb := subused;
    worklb := subused;
    permub := subdirblk.perm + dirblk.perm - mainused;
    workub := subdirblk.work + dirblk.work - mainused;
    writeln(tty,
'Here is what you can do to the quotas for this subdirectory:');
    writeln(tty,
'  Permanent:  Minimum: ',permlb:0,', Maximum: ',permub:0,', Current: ',
			  subdirblk.perm:0);
    writeln(tty,
'  Working:  Minimum: ',worklb:0,', Maximum: ',workub:0,', Current: ',
			  subdirblk.work:0);
    writeln(tty,
'[Note that any increase in quota from current will result in taking');
    writeln(tty,
' quota away from the main directory]');
    writeln(tty);
{Begin Stanford deletion
    writeln(tty,
'What quotas would you like to assign to the subdirectory?');
    write(tty,
'  Permanent: '); perm := getint(permlb,permub);
    write(tty,
'  Working: '); work := getint(worklb,workub);
 End Stanford deletion}
{Begin Stanford addition}
    write(tty,
'What disk allocation would you like to assign to the subdirectory?');
    perm := getint(permlb,permub); work := perm;
{End Stanford addition}
    end;
  end;

BEGIN
reset(tty,'',true,0,0,5);  (* map lower case, handle data errors *)
writeln(tty,'Program to create subdirectories.  If you don''t understand');
writeln(tty,'about assigning disk space and directory groups, please type');
writeln(tty,'^C this program and type HELP SUBDIR.');
writeln(tty);
writeln(tty,'If none of the alternatively provided seems quite right,');
writeln(tty,'choose the closest to what you want.  Details can be adjusted');
writeln(tty,'with the BUILD command.');
WITH DIRBLK DO
 BEGIN
 dum1 := 0; DUM2 := 0; dum3 := 0; passpt := 0; defacct := 0;
 LEN := 20B;
 NEW(DIRL); dirl^[0] := 30;
 new(userl); userl^[0] := 0;
 new(subusl); subusl^[0] := 0;
 getowndir;
 setunique;
 getname;
 CAP := 0;  (* capabilities irrelevant on files-only *)
 MODE := 402000000000B;  (* files-only bit *)
 DATE := 0;  (* irrelevant *)
 SUBDIRS := 0;  (* no nested sfd's *)
 passpt := 0; (* null password *)
 dirno := 0;  (* don't try to specify dir. no *)
 userl^[0] := 1;  (* not a user *)
 subusl^[0] := 1;
 defacct := 0;
 setgroups;
 setrights;
 setotherrights;
 setquotas;
{Begin Stanford deletion
 JSYS(240B%crdir\,-3,i; DIRNAME,773774B:DIRBLK,0);
 End Stanford deletion}
{Begin Stanford addition}
 JSYS(240B%crdir\,-3,i; DIRNAME,733774B:DIRBLK,0);
{End Stanford addition}
 if i > 2
   then begin
   writeln(tty,'? Couldn''t create the directory.  There is probably');
   writeln(tty,'  something odd about the name you typed, but here is');
   writeln(tty,'  what the monitor complained about:');
   jsys(11B,3;101B,400000B:-1,0);  (* print error msg *)
   quit
   end;
 writeln(tty,'[Done]');
 writeln(tty);
 END
END.
