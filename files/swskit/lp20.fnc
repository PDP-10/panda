


+---------------+
! d i g i t a l !   I N T E R O F F I C E  M E M O R A N D U M
+---------------+

To:  KL-10 Front-End Group

                                        Date:  6 Aug 75

                                        From:  Tom Porcher

                                        Dept:  DEC10 S.E. Dept.

                                        Loc:   MR1-2  Ext: 6788

                                        File:  [DOC-FRONT-END]
                                                LP.SPC


Subj:   LP-20 Driver Functional Specification



This functional specification describes the  interface  to  the
LP-20  from  the KL-10 front end monitor, RSX10-F.  The special
features of the LP-20 are described in the design spec for said
device, and are not described herein.


                 INTER-PROCESSOR COMMUNICATION

All communication between the -10 and  the  LP-20  driver  goes
through  the  DTE-20, using the queued protocol.  the following
is a list of the available functions to tthe LP-20.

From -10 Information

Code    Function

  3     String Data

        This function addresses a specific line-printer and  is
        data  to  be  printed.   The  request  is queued to the
        proper line-printer and the line-printer is started.

  5     Return Device Status

        The current device status is  sent  to  the  -10.   See
        below, Send Device Status

 11     Flush Device Output

        This  clears  any  I/O  that  is  in  progress  on  the
        specified line-printer, and clears the request queue.
TO:  KL-10 Front-End Group                               Page 2
SUBJ: LP-20 Driver Functional Specification



  7     Here is Device Status

        The  LP-20   specific   operations   are   handled   as
        subfunctions  of this function.  The function specifies
        the line-printer to perform the function for,  and  the
        length  of  the  function  block.   This  is similar to
        string data, except that the data is interpreted by the
        driver  and  not  sent to the LP-20.  The first word of
        the function data is the function code.  The  following
        are the functions available:

        Code    Subfunction

         129    Load LP-20

                This function has one argument:   the  name  of
                the  file  on  the RSX-10F File System to load.
                This file  contains  the  Vertical  Format  and
                Translation   RAM.   Blocks  1,  2  and  3  are
                ignored.  Block 4 is the Translation RAM.   The
                first  word  of block 5 gives the length of the
                VF (in bytes), which is the rest of the file.

                These  files  are  set  up   for   the   proper
                processing of the data sent to the LP-20.

          130   Set Page Counter Interrupt

                The  low-order  12  bits  (bits  11-0)  of  the
                argument  are  the  value to be set in the page
                counter.  Bit 15 is set to  enable  page  count
                zero interrupts, clear to disable.

          131   Set device status register.

                This function allows the -10 program to set  or
                clear  the  DELHLD  and  MODE bits in the LP-20
                Status Register.  This is to allow for  testing
                of  the  printer,  as well as special character
                functions.

          2     Continue

                There are no arguments to  this  function.   If
                the  specified  line-printer is stopped, due to
                an error, illegal character interrupt, or  page
                count   reaching  zero,  the  LP-20  output  is
                resumed.

          1     End-of-File

                This clears the checksum, and  also  sends  the
                device status.
TO:  KL-10 Front-End Group                               Page 3
SUBJ: LP-20 Driver Functional Specification





To -10 Information

Code    Function

 15     Acknowledgement

        This is sent whenever there is room for more data to be
        sent  to  the LP-20.  The transmission of this function
        to the -10 indicates that the -10 can send more data.

  7     Here is Device Status

        This is sent on request from the -10, or when the LP-20
        stops for an error.  It is also sent if the LP-20 comes
        on-line.  Page count reaching zero will only  stop  and
        send status if it is enabled, by bit 15 of the Set Page
        Count function.

The format of the status information sent is as follows:

        Word 0 (byte 0)  Current state:

                -5  Device error wait
                -4  VFU error wait
                -3  Page count zero wait
                -2  Illegal character wait
                -1  LP-20 off-line (I/O in progress)
                 0  LP-20 off-line (device idle)
                 1  I/O in progress
                 2  Device idle

        Word 0  (byte 1) Accumulated Checksum

LP-20 Device Registers:

        Word 1   LPCSRA  
        Word 2   LPCSRB
        Word 3   LPBSAD
        Word 4   LPBCTR
        Word 5   LPPCTR
        Word 6   LPRAMD
        Word 7   LPCBUF/LPCCTR
        Word 8   LPCKSM/LPTDAT
TO:  KL-10 Front-End Group                               Page 4
SUBJ: LP-20 Driver Functional Specification



                      QUEUE I/O INTERFACE

All data sent to the LP-20 from tasks running in  the  -11  are
sent  via  the  QUEUE I/O directives.  The LP-20 Driver accepts
the following I/O functions

IO.WLB  Write Logical Block.  Data is entered into the threaded
        output queue for the specified LP.

IO.WVB  Write Virtual Block.  Same as IO.WLB

IO.KIL  Kill all pending requests.  Aborts  all  sending  QUEUE
        I/O requests to the specified LP with I/O status IE.ABO
        (Operation Aborted).

IO.ATT  Attach Device.  Ignored.

IO.DET  Detach Device.  Ignored.

All other functions return IE.IFC (Illegal Function Code).

The following I/O status returns are given by the LP-20  Driver
for a request:

IS.SUC  Successful Completion.  Data has been printed.

IE.DNR  Device Not Ready.  The VFU  has  encountered  an  error
        when printing.

IE.VER  Controller Error.  A non-recoverable error has  occured
        (i.e., parity error).

IE.ABO  Operation Aborted.  Output has been flushed due  to  an
        IO.KIL request or a flush device request from the -10.

IE.IFC  Illegal Function Code.  The specified I/O  function  is
        not  one  of  the set IO.WLB, IO.WVB, IO.KIL, IO.ATT or
        IO.DET.

All device error conditions cause a message to  be  printed  on
the  console.   Any  error  except off-line aborts the request,
while off-line waits for on-line.


                PROGRAM FUNCTIONAL DESCRIPTION

The LP-20 Driver is broken up into several modules:

        LPDATA  Common Database and Parameters
        LPTASK  Task-Level Service
        LPINT   LP-20 Interrupt Service Routine
        LPCOMM  Common Subroutines
TO:  KL-10 Front-End Group                               Page 5
SUBJ: LP-20 Driver Functional Specification


COMMON DATABASE AND PARAMETERS

The number of LP-20's the driver is to service is the value  of
the symbol LPNUM.

All device-specific (i.e.  for each LP) data  is  kept  in  the
device  status  block  for  each device.  This is a table LPTBL
which has an 8-byte block for each LP, starting  with  unit  0.
Throughout the driver, the address of the block for the current
LP is kept in R2.  The size of each  entry  (8  bytes)  is  the
value of the symbol LPSIZE.


LPTBL descriptions:

0       LPTHD   Pointer to threaded output list.  This  is  the
                address  of the first item in the list (next to
                be printed), zero if there is no list.

2       LPEXP   External Page Adddress for this  LP.   This  is
                the  starting  address  of the device registers
                for this device (i.e., the address of  LPCSRA).
                This is normally kept in R3 when it is needed.

4       LPSTS   Status bits:

                LP.HNG  Device hung.  This bit is set every  20
                        seconds when the LP is not idle, and if
                        it  is  not  cleared  in  the  next  20
                        seconds  (by  doing  output)  the LP is
                        assumed to be hung.  The LP is  started
                        going again.

                LP.SST  Send status to -10.  This  bit  is  set
                        whenever  a  change  in  status  (i.e.,
                        off-line)  requires  the  -10   to   be
                        notified.    It  is  set  at  interrupt
                        level, and checked at task level.

                LP.WAT  Device is waiting for -10  to  respond.
                        This occurs on enabled interrupts (page
                        count reaching zero, illegal character,
                        or controller error).

                LP.PZI  Page count zero interrupt enable.  This
                        bit being set causes output to stop and
                        wait for a response from the  -10  when
                        the page count register reaches 0.

                LP.MCH  Multi-character print.  This bit is set
                        when    a    multiple-character   print
                        sequence (i.e.,  'arrow"  mode)  is  in
                        progress.   This  indicates  that  DONE
                        being set means to continue the current
TO:  KL-10 Front-End Group                               Page 6
SUBJ: LP-20 Driver Functional Specification


                        buffer after the character which caused
                        the multi-character print.

                LP.LDF  Load  Load  File.   Set  by   interrupt
                        service if VFUERR is up before starting
                        a transfer or on  encountering  a  Load
                        File  function  in  the  threaded list.
                        File is loaded at task level.

                LP.LIP  Load  in  progress.   Set  by  task  on
                        starting  load,  cleared  by  interrupt
                        service when a Set Mode 0 (Normal mode)
                        function is encountered.

                LP.F10  From  -10  request.   Set  on  any  -10
                        request  (data,  status  or  function).
                        Cleared when threaded  output  list  is
                        emptied.   Used  to determine if status
                        and acknowledgements should be sent  to
                        the -10.

                LP.EOF  End of File.   Set  when  End  of  File
                        function   encountered   by   interrupt
                        service  by  ..SSLP  when  checksum  is
                        cleared.

                LP.UNT  (Bits 1 and 0).  Unit  number  of  this
                        LP.


6       LPITH   Interrupt-level thread pointer.  This points to
                the  thread block in the threaded list which is
                currently being output.   Zero  if  the  LP  is
                stopped or idle.

A parallel table, LPTBL2, has additional  information.   Again,
the entry for each LP is 8 bytes long.  The indexes into LPTBL2
are defined from the start of LPTBL, so that the  same  pointer
(usually  in  R2) can be used for both tables.  The contents of
this table:

0       LPMCB   Multi-character buffer.  This word is a  2-byte
                buffer  for  multi-character  print  operations
                (i.e.  'arrow' mode).

2       LPCSM   Accumulated Checksum (low  byte).   Cleared  by
                End  of  File  function from -10.  High byte is
                trash.

4       LPFID   File-ID of last file loaded to LP-20

6       LPFSQ   File-sequence number of  last  file  loaded  to
                LP-20.
TO:  KL-10 Front-End Group                               Page 7
SUBJ: LP-20 Driver Functional Specification


Another parallel table, LPTBLS, has more information.

0       LPFIL   (4 words) Filename and  extension  of  file  to
                load from -11 file system.

Threaded Output List

All output to each LP is kept in a threaded output queue.   The
current  head of this queue is kept in LPTHD for each LP.  Each
thread block has the following information:

0       T.HRED  Thread word.  Points to next  thread  block  in
                list.  Zero if end of list.

2       T.HBCT  Byte count of thread block and following  data,
                if  any.   This  value  is  used  to return the
                thread block to the free pool.  If this word is
                zero,  it  is a Queue I/O request, and it is an
                extended thread block (length T.HQRS) which has
                more stuff in it.  See definitons below.

4       T.HCAD  Address of data to be printed  (physical).   If
                this is zero, this is not a data request, but a
                special  function  request.   See   definitions
                below.

6       T.CBC   Byte count of data.  If this is  negative,  the
                data  has  been  sent  (or function completed).
                This may be zero.

The size of this thread block is T.HHDS, 8 bytes.

Queue I/O request thread blocks have the  following  additional
information:

10      T.HEMA  Extended Memory address bits.  Bits 5 and 4 are
                the  memory extension bits, bus address bits 17
                and 1  respectively.   In  all  other  requests
                these bits are zero.

12      T.HNAD  Address of Queue I/O request node which invoked
                this  request.   This is needed to complete the
                Queue I/O request and tell the requesting  task
                that his I/O has been done.

The length of this Queue I/O request thread block is T.HQRS, 12
bytes.

Special function thread block entries (T.HCAD zero) specify the
function  to  be  performed in the byte count word T.HCBC.  The
arguments  to  the  function  follow  the  thread   block,   at
T.HHDS+nn.
TO:  KL-10 Front-End Group                               Page 8
SUBJ: LP-20 Driver Functional Specification


The following functions are implemented:

Code    Function

131     Set or clear DELHLD or MODE bits in LP Status  Register
        LPCSRA.   The  argument  is the new bits, in the proper
        positions.  Note that setting mode  0  (normal)  clears
        LP.LIP (Load File complete).

130     Set Page Count in LPPCTR.  The argument is the value to
        set it to.

129     Load File.  Sets LP.LDF and I/O Done to  tell  task  to
        load Load File.

1       End of File.  Clears Checksum and sends current  status
        to -10.


TASK LEVEL CODE

Upon initialization, the LP driver task must first  enable  for
Mark-Time  interrupts  every  20 seconds (for hung check).  The
address of the task's event flags (A.EF of the task header)  is
also  saved so that the interrupt-level routine can set the I/O
done flag EF.LPD.  The LP is reset.

After initialization, the task routine waits  for  someting  to
do,  indicated  by  an  event  flag coming up.  The event flags
waited for are EF.LPD (interrupt-level I/O done), EF.NIR (Queue
I/O request), and EF.LPC (Mark-Time request, every 10 seconds).
They are cleared and checked in that order.


Interrupt-level I/O done (EF.LPD)

LPIOD is dispatched to whenever the event flag EF.LPD  is  set.
This  is  set  by  the  interrupt service when it has completed
transmission of a buffer, or requires the status of an LP to be
sent to the -10 (because of error or such).

Each LP's threaded output list is scanned  for  'done'  buffers
(indicated  by  a  negative  byte  count  T.HCBC).   These  are
returned to the free pool,  and,  in  the  case  of  Queue  I/O
requests,  ..IODN  is called to tell the requestor that his I/O
has been successfully completed.  If a  Queue  I/O  request  is
stopped  in  the  middle  of  a transfer (for error, page count
zero, etc.), an error indication is given to  ..IODN,  and  the
transfer is aborted.  LP.WAT is cleared and the next buffer (if
any) is started.

After the scan of the threaded list, the status of  the  LP  is
sent  to  the  -10 (by calling ..SSTSLP) if the LP.SST flag was
set by the interrupt service.  If data is to  be  printed,  the
TO:  KL-10 Front-End Group                               Page 9
SUBJ: LP-20 Driver Functional Specification


output   is  started  by  calling  TESTLP.   If  a  buffer  was
completed, and the last buffer has been started,  or  there  is
nothing  left  in the list, a request to send more data is sent
to the -10 by calling ..SACK.


Queue I/O requests (EF.NIR)

LPNIR is dispatched to when the event flag EF.NIR is set.  This
occurs  whenever  another  task has requested output on any LP.
All LP's are checked for requests by  calling  ..DQRN  (dequeue
request node), which fails if there is no request.

The request is queued up in the threaded output list  for  this
LP,   using   an   extended   thread   block.   This  block  is
distinguished as a Queue I/o request by the header  byte  count
T.HBCT   being   zero  (the  actual  length  is  T.HQRS).   The
additional information in this thread block is:

        T.HEMA  Extended memory address bits.   Bits  5  and  4
                represent  bits  17  and  16  of  the  physical
                address of the data to be sent.

        T.HNAD  Address of Queue I/O request node which invoked
                this data request.  This is to allow completion
                of  the  request  and   notification   to   the
                requestor that his output has been completed.


Mark-Time requests every 10 seconds (EF.LPC)

LPMKT is dispatched to every time the event flag EF.LPC is set,
which  should  be  every 10 seconds, as requested.  This is the
hung checking routine.

An LP is  assumed  to  be  hung  if  it  has  I/O  in  progress
(indicated  by LPITH non-zero) and the flag LP.HNG has not been
cleared by starting another buffer (..DOLP routine).  If the LP
is  hung,  and  DONE  is  set,  the  next buffer in sequence is
started.  If DONE is not set, output is resumed by setting  GO.
The LPHUNG counter is incremented, for debugging purposes.

In any case, if I/O is in progress, the LP.HNG flag is  set  so
that it can be checked in another 10 seconds.


SSTSLP Send Status to -10.

This routine is called  to  send  the  current  status  of  the
specified  LP  to the -10 in the format described above.  It is
called from task level, either from the  LP  task  or  the  DTE
task,  in request for status from the -10 or a change in status
of the LP.
TO:  KL-10 Front-End Group                              Page 10
SUBJ: LP-20 Driver Functional Specification


The following is the algorithm used to  determine  the  current
state value for the LP.

    1.  If the LP has data to be printed (LPTHD  non-zero),  go
        to  step 2.  Otherwise, return 2 if LP is on-line, 0 if
        not.

    2.  If the LP is in a wait state, indicated by LP.WAT being
        set,  go  to step 4.  If the LP is off-line, go to step
        3.  Otherwise, the LP is on-line, I/O in  progress,  so
        return 1.

    3.  LP off-line, I/O in progress, so return -1.

    4.  LP waiting.  If PAGZRO is set, return -2.  If UNDCHR is
        set,  return -3.  If VFUERR is set, return -4 otherwise
        return -5 for all other errors.

The status block is then sent to the -10 if  LP.F10  (from  -10
request)  is  set.   Otherwise,  error  conditions  (state code
negative) cause an error message to be printed on the console.

        Call:

        R2 --   Pointer to LPTBL entry for this LP.

        Return:

        R1 --   State code


TESTLP Start LP-20 on threaded list if ready

This routine is called to start the LP-20 if it is on-line  and
data  is  to  be  printed.   This  is  called from the I/O DONE
service.  If the VFU needs to  be  reloaded,  as  indicated  by
LP.LDF  or  VFUERR being up, the Load File is loaded by calling
LOADLP.  The LP is started by calling..DOLP.


INTERRUPT SERVICE ROUTINE

$LPINT is the interrupt service routine for all LP's.  The unit
number  of  the interrupting LP is stored in the low-order bits
of the PS, the condition codes, when  $LPINT  is  called.   All
used registers are saved.

If the interrupting LP is idle, the status of the LP is sent to
the  -10  by  setting  LP.SST.  This is incase the LP just came
on-line.

If the LP has I/O in progress, the checksum is accumulated  and
the  following  conditions  are  checked.   Note that if I/O is
stopped for any  reason,  the  currrent  byte  count  and  data
TO:  KL-10 Front-End Group                              Page 11
SUBJ: LP-20 Driver Functional Specification


address  are  stored  back  in  the thread block, in T.HCBC and
T.HCAD repectively.


Undefined character

IF the UNDCHR  bit  is  set  in  LPCSRA,  this  indicates  that
processing  is  required  on  this character.  The RAM data for
this character is used to determine the course of  action.   If
the  RAM  data is less than 100 (octal), I/O is stopped and the
status is sent to the -10, waiting for a response from the -10.
If  the RAM data is greater than or equal to 100, the RAM data,
preceded by an up-arrow, is printed.  This is  accomplished  by
storing  the  up-arrow  and the RAM data in the multi-character
echo buffer LPMCB and starting output there.  The  flag  LP.MCH
is  set so that the next time DONE comes up, the current buffer
is resumed.


Page count reached zero

If the PAGZRO bit is up, the page count has been decremented to
zero.  If the page zero interrupt flag LP.PZI is set the status
is sent to the -10, and waits for  a  response  from  the  -10.
Otherwise,  PAGZRO  is cleared by clearing the page counter and
the current buffer is resumed by caling..DOLP.


Error

Any errors stop I/O and send status to -10, but  just  off-line
does  not  require  a  response  from the -10 to continue.  Any
other error sets  the  flag  LP.WAT  to  indicate  wait  for  a
response.   Note  that the error bit is cleared when the status
is sent at task  level  by  the  ..SSLP  routine.   VFU  errors
require the vfu to be reloaded.


Done

When DONE comes up, the next buffer in  the  threaded  list  is
started,  and  the current buffer marked as done by setting the
byte count word T.HCBC to a negative number.   The  event  flag
EF.LPD  is  set  to indicate to the task that a buffer has been
completed.

However if this DONE  interrupt  is  during  a  multi-character
print  operation  (i.e.   'arrow'  mode), the current buffer is
just continued where it was left off.
TO:  KL-10 Front-End Group                              Page 12
SUBJ: LP-20 Driver Functional Specification




COMMON SUBROUTINES

These routines are called from the LP driver task, other  tasks
(mostly  DTE  task),  and  from  the interrupt service routine.
These are kept in core, with the system common subroutines.

..STLP Start LP-20 Output

This routine is called only from the Queued Protocol Task  with
a  thread block to be output.  The Function code is in the high
byte of T-HCBC, and the subfunction code or byte count of  data
is in the low byte.  ..PTLP is called to queue the thread block
up in the threaded list.

        Call:

        R0 --   Address of thread block.

        R2 --   Pointer to LPTBL entry for this LP.

        Return:

                No registers modified


..PTLP Put thread block in threaded output list

This is a task-level routine to enter a thread block  into  the
end  of  the threaded output list, and start the LP going if it
is idle.  The thread block is assumed to be the new end of  the
list,  so  the thread word of this block is cleared.  Note that
task-switching must be inhibited when the thread block is being
entered in the list.

        Call:

        R0  --  Address of thread block to be added to list and
                output.

        R2 --   Pointer to LPTBL entry for this LP.

        Return:

                No registers modified.

TO:  KL-10 Front-End Group                              Page 13
SUBJ: LP-20 Driver Functional Specification




..SPLP Stop LP-20 Output

This is a  task-level  routine  to  flush  all  output  to  the
specified  LP.   The  LP  is  reset by setting RSTERR.  All the
active thread blocks in the threaded output list are marked  as
DONE  by  setting  T.HCBC negative (just bit 15 on).  The Queue
I/O requests are given IE.ABO by the LP task when the  list  is
scanned.

        Call:

        R2 --   Pointer to LPTBL entry for this LP.

        Return:

                No registers modified.


..DOLP Initiate LP-20 Transfer.


This is an interrupt-level routine to start the LP specified on
a specific entry in the threaded list.

If the thread word specified to start is zero, nothing is  done
and the LP is left idle.

If the data address T.HCAD is zero, this is a special  function
so  it  is performed.  The function code is taken from the byte
count word T.HCBC and the arguments to the function follow  the
thread  block  at  T.HHDS+nn.  See the thread block definitions
above for a description of the functions available.  After  the
function  is performed, the next buffer in the threaded list is
started.

Otherwise, the data is started  to  the  printer  via  DMA,  by
setting  up  the byte count LPBCTR, bus address LPBSAD, and the
extended memory bits 16 and 17  in  LPCSRA.   The  transfer  is
initiated by setting GO, INTENB, and PARENB.

This routine may be entered at ..DOL1 to start the next  buffer
in  sequence,  unless  LP.MCH is set, in which case the current
buffer is resumed.  This is normally called when DONE is set.

In any case, the flags LP.HNG, LP.WAT, and LP.MCH are cleared.

        Call:

        R0  --  Address of thread block  to  start  output  at.
                May be zero if this is end of threaded list.

        R2 --   Pointer to LPTBL entry for this LP.
TO:  KL-10 Front-End Group                              Page 14
SUBJ: LP-20 Driver Functional Specification


        R3  --  External Page address of this  LP  (address  of
                LPCSRA).

        Return:

        R0 --   Address of current thread block being output.

[End of LP.SPC]
