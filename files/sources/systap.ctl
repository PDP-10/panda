! Obtain a tape drive
@MOUNT TAPE TAPE:/WRITE/LABEL:UNLABELED

!Systems not using Tape Drive Allocation must replace the
!@MOUNT TAPE command with @ASSIGN MTA0: and @DEFINE TAPE:
!(AS) MTA0: commands.

@ENABLE (CAPABILITIES)
@REWIND (DEVICE) TAPE:

! Save the monitor
@GET (PROGRAM) PS:<SYSTEM>MONITR.EXE
@SAVE (ON FILE) TAPE:

! Save the TOPS-20 Command Language Interpreter
@GET (PROGRAM) SYSTEM:EXEC.EXE
@SAVE (ON FILE) TAPE:

! Save the DLUSER program
@GET (PROGRAM) SYS:DLUSER.EXE
@SAVE (ON FILE) TAPE:

! Run the same DLUSER program, saving the directory structure on tape
@START
*DUMP (TO FILE) TAPE:
*EXIT

! Save DUMPER
@GET (PROGRAM) SYS:DUMPER.EXE
@SAVE (ON FILE) TAPE:

! Run the same DUMPER, saving SYSTEM: and SYS:
@START
*TAPE (DEVICE) TAPE:
*LIST (LOG INFORMATION ON FILE) SYSTAP.LPT
*SSNAME SYSTEM-FILES
*SAVE (DISK FILES) PS:<NEW-SYSTEM>,PS:<SYSTEM>
*SSNAME SUBSYS-FILES
*SAVE (DISK FILES) PS:<NEW-SUBSYS>,PS:<SUBSYS>
*EXIT

! Print the DUMPER log file
@PRINT SYSTAP.LPT/NOTE:"BACKUP TAPE"

@DISMOUNT TAPE:

!Systems not using Tape Drive Allocation must replace the
!@DISMOUNT TAPE: command with @UNLOAD (DEVICE) TAPE: and
!@DEASSIGN TAPE: commands.
