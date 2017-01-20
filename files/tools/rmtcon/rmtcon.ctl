!  RMTCON.CTL	To build RMTCON

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!				!
! Files needed to build RMTCON	!
!				!
! .MAC files			!
!	RMTCNM.MAC		!
!	RMTCNP.MAC		!
!	RMTCNT.MAC		!
!				!
! .REL files			!
!	KCSUB.REL		!
!	KCNO10.REL		!
!				!
! .UNV files			!
!	KCUNV.UNV		!
!	MONSYM.UNV		!
!				!
! .KCM files			!
!	RELOC.KCM		!
!	STOR.KCM		!
!				!
! Misc files			!
!	RMTCON.RNO		!
!	RMTCON.HLP		!
!				!
! Submit  RMTCON.CTL		!
!				!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

@TAK BATCH.CMD
@EXP
@IF (ERROR) @GOTO SKIP

@MACRO
*rmtcnT,rmtcnT/C=rmtcnT,RELOC.KCM,STOR.KCM	! .REL,.CRF = .MAC
*rmtcnP,rmtcnP/c=rmtcnP
*rmtcnM,rmtcnM/C=rmtcnM

@R CREF
*rmtcnT=rmtcnT					! .LST = .CRF
*rmtcnM=rmtcnM
*rmtcnP=rmtcnP
@
LINK::
!LINKING  
!
! .SAV,.MAP = .REL (if omit .SAV, default out = .EXE)
! .SAV is more compact because zeros are compressed out but takes longer
! to load because zeros have to be put back in.
! rmtcnT has .REQ rmtcnP & M
! Use LINK to produce .EXE files, and DLINK to produce .SAV files
! This is because LINK doesnt know how to handle compressed zero pointers.

!@RUN DLINK
!*rmtcon.SAV/SAV,rmtcon/MAP:end=rmtcnT,KCSUB.REL,KCNO10.REL/GO

@LINK
*RMTCON.EXE/SAVE=RMTCNT.REL,KCSUB.REL,KCNO10.REL/GO

@
!CONVERT  produce .A10 file so the PDP11 front end can read in & pass to PDP10

!@CONVRT			; in = .SAV, out = .A10
!*rmtcon

@APPEND rmtcnP.LST,rmtcnM.LST rmtcnT.LST
@RENAME rmtcnT.LST rmtcon.LST
!@DELETE *.REL
@DELETE *.LST

!NI SERVICES FUNCTIONAL SPEC
!
! This portion of the file is used to generate the MEM file (RMTCON.MEM) from
! the file RMTCON.RNO.  When done, the temporary files used for table of
! contents are deleted.
!
! The first line is necessary because RMTCON.RNO has .REQ RMTCON.RNT
! & since it doesnt exist yet, it would result in an error.
!
!				IN		OUT
!				--		---
@COPY NUL: RMTCON.RNT
@RUNOFF				; .RNO		.BTC  &  .MEM	
*RMTCON/CONTENTS
@TOC				; .BTC		.RNT
*RMTCON
*Y
*N
*99
*99
*N
*Y
@RUNOFF				; .RNT		.MEM
*RMTCON

@RENAME RMTCON.MEM RMTCND.TXT	; .TXT reqd by release engineering
@DELETE RMTCON.BTC,RMTCON.RNT
