!SNARK:<6.1.UTILITIES>SERVER.CTL.7 23-May-85 16:57:32, Edit by MELOHN
! build by default only the non-pmr, non-debug version
!SNARK:<6.1.UTILITIES>SERVER.CTL.3  3-May-85 20:13:47, Edit by GLINDELL
!build PMR stuff too
!SNARK:<6.1.UTILITIES>SERVER.CTL.2 30-Apr-85 13:42:51, Edit by MELOHN
!only save DDT in DEBUG version of CTERM-SERVER
@DEF LPT: DSK:
@DELETE SERVER.REL,SERVER.LST
@COMPILE/COMPILE/CREF SERVER.MAC
@CREF
@LINK
*SERVER,SERVER/SAVE/GO
@SAVE CTERM-SERVER
@GOTO END::
!
!Build PMR version too
PMR::
@R MACRO
*DSK:SERVER.REL=TTY:,DSK:SERVER.MAC
*FTPMR==:-1
*^Z
*^Z
*DSK:CTDNCN.REL=DSK:CTDNCN.MAC
*^Z
@LOAD SERVER,CTDNCN
@SAVE PMR-CTERM-SERVER
@DDT
*DEBUG/1
@MERGE SYS:SDDT
@SAVE DEBUG-CTERM-SERVER
END::
@DAYTIME


