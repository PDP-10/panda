#define ESC	chr(27)
#define LF	chr(10)
#define	BS	chr(8)
#define BELL	chr(7)
#define	GP	'!'
#define	NULL	0
#define	BRIGHT	1
#define	REVERSE	7
#define	DARK	30
#define	RED	31
#define	GREEN	32
#define	YELLOW	33
#define	BLUE	34
#define	MAGENTA	35
#define	CYAN	36
#define WHITE	37
#define initfonts	write(tty, ESC, '(B', ESC, ')0')
#define	shiftin		write(tty, chr(17B))
#define	shiftout	write(tty, chr(16B))
#define	savecur		write(tty, ESC, '7');
#define	oldcur		write(tty, ESC, '8');
#define frontcol(col)	write(tty, ESC, '[', col:0, 'm')
#define backcol(col)	write(tty, ESC, '[', col + 10:0, 'm')
#define	putchar(c, col)	write(tty, ESC, '[', col:0, 'm', c)
#define	moveto(i, j)	write(tty, ESC, '[', i:0, ';', j:0, 'H')
#define	up(n)		write(tty, ESC, '[', n:0, 'A')
#define	right(n)	write(tty, ESC, '[', n:0, 'C')
#define	down(n)		write(tty, ESC, '[', n:0, 'B')
#define	left(n)		write(tty, ESC, '[', n:0, 'D')
#define	clscreen	write(tty, ESC, '[', '2J')
#define	clline		write(tty, ESC, '[', '2K')
#define clfrmbol	write(tty, ESC, '[', '1K')
#define	message(i, j, col, txt)	    begin moveto(i, j); \
	    frontcol(col); shiftin; write(tty, txt); shiftout end
{----------------------------------------------------------------------------}
#define	RFMOD 	107B
#define	PRIOU	101B
#define	STPAR	217B
#define	GTTYP	303B
#define getmode(m)	jsys(RFMOD;PRIOU;m,m)
#define	setmode(m)	jsys(STPAR;PRIOU,m)
#define	gettype(t)	jsys(GTTYP;PRIOU;t,t)
{----------------------------------------------------------------------------}
#define	PBIN	73B
#define DISMS	167B
#define CFIBF	100B
#define PRIIN	PRIOU
#define getbyte(c)	jsys(PBIN;;c)
#define	wait(time)	jsys(DISMS;time)
#define	clearbuf	jsys(CFIBF;PRIIN)
{----------------------------------------------------------------------------}
#define ON	TRUE
#define OFF	FALSE
#define ECHOBIT 24
#define SFMOD	110B
#define echo(toggle)	begin modeword.a[ECHOBIT] := toggle; \
			    jsys(SFMOD;PRIOU,modeword.i) end
{----------------------------------------------------------------------------}
#define	ifelse(c, s1, s2)   If (c) then s1 Else s2
#define	move(dir)	ifelse((dir = EAST) or (dir = SOUTH), \
	    write(tty, ESC, '[', chr(ord('B') + dir mod 2)), \
	    write(tty, ESC, '[', chr(ord('A') + dir)))
{----------------------------------------------------------------------------}
