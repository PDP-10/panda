!~Filename~:! !Hacks to go into Stanlib!
STAN

!Insert Switches:! !C Insert MACRO assembly switches around current line
Puts IFE's and IFN's around selected code.  Accepts bits in
arg as follows: 1 = LOTSW, 2 = GSBSW, 4 = SCORSW,
8=FAIRSW.  1000 (octal) bit set means also put STANSW around the
whole thing.  A negative argument means use IFE, the argument
is then made positive and the bits looked at. Precomma arg
is how many lines to surround with switches!

    [0[1[2[3
    [4 :i0IFN  :i1!		!* 0: IFN or IFE, 1: excl or * (OR or AND) !
    q4"l :i0IFE  -q4u4 :i1*'	!* 4: abs. val. of arg !
    :i2			!* q2 will accumulate sites!
    q4&1"n :I221LOTSW'
    q4&2"n :I221GSBSW'	!* Put in sites with excl or *!
    q4&4"n :I221SCORSW'	!* before each!
    q4&8"n :I221FAIRSW'
    FQ2 "n1,FQ2:G2U2'		!* get rid of first character!

    0l q4&1000."n g0 iSTANSW,<
'				!* Put in stansw if wanted!
    fq2"n g0 g2 i,<
'				!* put in switches he wants!
    L fq2"n i>; g0 g2 i
'				!* Skip lines, put close!
    q4&1000."n i>; g0 iSTANSW
'				!* close stansw if wanted!


!Double insert switches:! !C insert IFN's and IFE's both
Calls Insert Switches with 0,<our 2nd arg>, then with
<our 1st arg>,-<our 2nd arg>!
0,m(m.m Insert Switches)
,-m(m.m Insert Switches)

!^R Insert Switches:! ! Insert switches for ^R mode
Explicit argument is flag bits for Insert Switches (q.v.), if
preceeded by ^U then argument is negated.  Default arg is
given by qMacro Switch Default, which should contain the
bits for the machine code is normally written for.  If no such
variable exists, then you get just STANSW.!
[0[1[2
FS ^R ARGP&2"n FS ^R ARGu0'	!* Get explicit arg if any!
"# 1000.fo..qMacro Switch Defaultu0'	!* Get default!
FS  EXPT"n w-q0u0'		!* if ^U then negate!
q0m(m.m Insert Switches)
