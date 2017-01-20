type
(* type declaration needed for getpages *)
  mempage=array[0:777B] of integer;
  pagept=^mempage;
(* type declaration needed for getsections *)
(* Note - we declare MEMSEC as HALF a section, since the compiler wont
   currently allow any data structure over 128K words *)
  memsec=array[0..377776B] of integer;
  secptr=^memsec;

(* external declarations for procedures built into the runtimes *)

function erstat(var f:file):integer;extern;

procedure quit; extern;

procedure analys(var f:file);extern;

procedure clreof(var f:file);extern;

procedure psidefine(ch,lev:integer;procedure proc); extern;

procedure psienable(ch:integer); extern;

procedure psidisable(ch: integer); extern;

function to6(a:alfa):integer; extern;

procedure from6(i:integer;var a:alfa); extern;

function curjfn(var f:file):integer; extern;

procedure setjfn(var f:file;i:integer); extern;

procedure entercrit; extern;

procedure leavecrit; extern;

(* note - the next two routines are obsolete *)

procedure newpage(var p:integer;var d:pagept); extern; (* use GETPAGES *)

procedure retpage(p:integer); extern; (* use RELPAGES *)

procedure getpages(numpgs: integer; var pagnum:integer;var d:pagept); extern;

procedure relpages(numpgs, pagnum:integer); extern;

procedure getsections(numsec: integer; var secnum: integer; var sec: secptr); extern;

procedure relsections(numsec: integer; secnum: integer); extern;

function lstrec(var f:file):integer; extern.
