!*-*-TECO-*-*!
!~Filename~:! !Specify terminal type for EMACS.!
TRMTYP

!& Set Terminal Type:! !C Specify terminal type (as string argument).
To get a list of all terminal types, do M-X List LibraryTRMTYP<cr>.!

    1,fTerminal_Type:_[1
    1,m.m#_TRMTYP_1[2
    q2"e :i*1__Unknown_terminal_type_name fs err'
    m2fstty initw fsWindow(f+)fsWindoww
    

!Init File Set Terminal Type:! !C Give Emacs a terminal type.

The system does not know your terminal type.
EMACS may be able to handle your terminal if you tell
EMACS what type of terminal it is.
Type the EMACS name for your terminal type now.
To see a list of EMACS terminal type names, type ?<CR>.
To continue with EMACS in printing terminal mode, type just <CR>.
If the system does not know the width of a line on your terminal
you should return to the EXEC and use the TERMINAL WIDTH command.!


    < 1,fTerminal_Type:_[1	    !* Return here on errors!
      fq1"e 0'
      f=1 ?"e			    !* ? => list types.!
        m(m.m list_Library)TRMTYP
	!<!>'
      1,m.m#_TRMTYP_1[2	    !* Then get it (if it exists)!
      q2:@;			    !* Exit loop if type is valid.!
      :i*1__Unknown_terminal_type_name fg>
    m2fstty initw  
    f[Window f+

    fs height-24"n fs height:\u1
      ft Your_terminal_height_may_cause_problems.
If_1_is_not_the_proper_height,_use_the_exec
TERMINAL_LENGTH_command_and_restart_EMACS.
Type_space_to_continue.
'
    fs width-79"n fs width:\u1
      ft Your_terminal_width_may_cause_problems.
If_1_is_not_the_correct_width,_use_the_exec
TERMINAL_WIDTH_command_and_restart_EMACS.
Type_space_to_continue.
'
    


!# TRMTYP Printing:! !S Printing terminal!
    0

!# TRMTYP Glass:! !S Stupid display terminal!
    1

!# TRMTYP DM2500:! !S Datamedia Elite 2500!
    2

!# TRMTYP H1500:! !S Hazeltine 1500!
    3

!# TRMTYP VT52:! !S VT52!
    4

!# TRMTYP DM1520:! !S Datamedia Elite 1520!
    5

!# TRMTYP Imlac:! !S MIT Imlac!
    6

!# TRMTYP VT05:! !S DEC VT05!
    7

!# TRMTYP TK4025:! !S Tektronix 4025!
    8

!# TRMTYP VT61:! !S VT61!
    9

!# TRMTYP TL4041:! !S Teleray 4041!
    10

!# TRMTYP Fox:! !S Perkin-Elmer Fox!
    11

!# TRMTYP HP2645:! !S Hewlett-Packard 2645!
    12

!# TRMTYP I400:! !S Infoton 400!
    13

!# TRMTYP TK4023:! !S Tektronix 4023!
    14

!# TRMTYP Ann Arbor:! !S Ann Arbor!
    15

!# TRMTYP C100:! !S HDS Concept-100!
    16

!# TRMTYP IQ120:! !S Soroc IQ 120!
    17

!# TRMTYP VT100:! !S VT100 in ANSI mode!
    18

!# TRMTYP I100:! !S Infoton 100!
    19

!# TRMTYP TL1061:! !S Teleray 1061!
    20

!# TRMTYP HEATH:! !S Heathkit!
    21

!# TRMTYP H19:! !S Heathkit!
    21

!# TRMTYP VC404:! !S Volker-Craig 404!
    22

!# TRMTYP CN-CP:! !S CN-CP losing terminal!
    23

!# TRMTYP TVI912:! !S Televideo 912!
    24

!# TRMTYP Owl:! !S Perkin-Elmer Owl!
    25

!# TRMTYP Bantam:! !S Perkin-Elmer Bantam!
    26

!# TRMTYP DM3045:! !S Datamedia 3045!
    27

!# TRMTYP DM3052:! !S Datamedia 3052!
    28

!# TRMTYP HMOD1:! !S Hazeltine Modular-1!
    29

!# TRMTYP H1510:! !S Hazeltine 1510!
    30

!# TRMTYP ADM3A:! !S ADM3A!
    31

!# TRMTYP VT100V:! !S VT100 in VT52 mode (80 columns, max)!
    32

!# TRMTYP SImlac:! !S Simulated imlac!
    33

!# TRMTYP VT100W:! !S VT100 in VT52 mode outside, ANSI mode inside!
    34

!# TRMTYP VT100X:! !S VT100, ANSI mode outside, VT52 inside (80 col max)!
    35

!# TRMTYP ADM42:! !S ADM 42 (also good for ADM 31)!
    36

!# TRMTYP NIH5200:! !S NIH5200 (modified Delta Data)!
    37

!# TRMTYP V200:! !S Visual 200!
    38

!# TRMTYP PTV:! !S MIT TV system (emulates large-screen VT52).!
    39

!# TRMTYP E19:! !S Edmonds's modified H19!
    40

!# TRMTYP VTS:! !S MIT virtual display terminal (system does conversion).!
    41

!# TRMTYP ACT4:! !S ACT-IV terminal.!
    42

!# TRMTYP IBM3101:! !S IBM 3101 terminal.!
    43

!# TRMTYP GILL:! !S Gill's modified Hazeltine.!
    44

!# TRMTYP DM3025:! !S Datamedia 3025.!
    45

!# TRMTYP AAA:! !# TRMTYP Ambassador:! !S Ann Arbor Ambassador.!
    46

!# TRMTYP Mime52:! !S Mime2a in enhanced VT52 emulation mode.!
    47

!# TRMTYP DG132:! !S Datagraphics 132.!
    48

!# TRMTYP IIMLAC:! !S Imlac with %TOFCI using intelligent terminal protocol.!
    49

!# TRMTYP BUR80:! !S Cal-Tech modified Burroughs TD850.!
    50

!# TRMTYP INTEXT:! !S Intext terminal (supposedly modified OWL, but nothing like one).!
    51

!# TRMTYP VT132:! !S DEC VT132.!
    52

!# TRMTYP Viewpoint:! !S Adds Viewpoint !
    53

!# TRMTYP NIH7000:! !NIH 7000 (modified Delta Data)!
    54

!# TRMTYP BEE2:! !Microbee 2!
    55

!# TRMTYP GIGI:! !DEC GIGI graphics terminal (garbage is garbage inevitably)!
    56

!# TRMTYP FR100:! ! Freedom-100 !
    57

!# TRMTYP ESPRIT:! ! Hazeltine Esprit !
   58

!# TRMTYP FR200:! ! Freedom-200 (faster than Freedom-100) !
   59

!# TRMTYP ANSI:! ! ANSI (is presently a synonym for VT132) !
   60

!# TRMTYP TVI950:! ! TeleVideo 950 (tvi912 -padding +%tolid) !
   61

!# TRMTYP BBN Bitgraph:! !BBN's bitmapped terminal!
   62

!# TRMTYP AVT:! ! HDS Concept AVT !
   63

!# TRMTYP SUN:! ! SUN workstation (SUN code) !
   64

!# TRMTYP AVTX:! ! Experimental type for Concept AVT !
   65

!# TRMTYP AJ510:! ! Anderson Jacobs 510 terminal !
   66

!# TRMTYP VT102:! ! VT102 Terminal (same as ANSI, which same as VT132) !
   67

!# TRMTYP IDEAL:! ! "Ideal" terminal - uses 8 bit code for cursor commands !
   68
