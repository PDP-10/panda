!This command file will startup the necessay Batch Streams, Printers,
! and allows all messages to appear on the console.
! The objects all will use system default limits which can be changed
! by adding various Set commands.
! If you wish to suppress Job Messages for all objects insert the following
! command into this file.
!
! DISABLE OUTPUT-DISPLAY ALL-MESSAGES /JOB
!
!
SET	BATCH-STREAM 0:3 TIME-LIMIT 11000
SET	BATCH-STREAM 0:3 PRIORITY-LIMITS 1:63
START	BATCH-STREAM 0:2
START	BATCH-STREAM 3
SET	PRINTER 0 PAGE-LIMIT 10000
SET	PRINTER 1 PAGE-LIMIT 20000
START	PRINTER 0:1
