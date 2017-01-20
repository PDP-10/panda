$!	Compile the necessary programs.
$!
$!	Smtpfork runs under Tektronix tcpacp for Incoming TCP/IP Mail
$!
$macro smtpfork/cross/list
$!
$!	Bsmtpfork runs detached for Incoming Bitnet Mail
$!
$macro bsmtpfork/cross/list
$!
$!	Maiser runs either detached or is run by MM, Smtpfork, Bsmtpfork
$!	for outgoing mail
$!
$macro maiser/cross/list
$!
$!	MM is the user interface to the mail system
$!
$macro mm/cross/list
$!
$!	Mail is the General Library
$!
$macro mail/cross/list
$!
$!	Parse is the Command/Argument Parser Library
$!
$macro parse/cross/list
$!
$!	Smtp_bsmtp is the Smtp and Bsmtp General Library
$!
$macro smtp_bsmtp/cross/list
$!
$!
$!	Create the necessary Libraries
$!
$library/create/object mail mail
$library/create/object parse parse
$library/create/object smtp_bsmtp smtp_bsmtp
$library/create/help mm mm
$library/create/help rmm rmm
$library/create/help smm smm
$!
$!
$!	Link the necessary programs.
$!
$link smtpfork,mail/lib,smtp_bsmtp/lib
$link bsmtpfork,mail/lib,smtp_bsmtp/lib
$link/notrace mm,mail/lib,parse/lib
$link maiser,mail/lib
$!
$!
$!	Create the following directories or equivalents.
$!
$!	Directory DUA0:<SYS0.MAIL.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:RWD, World:R
$!	
$!	Directory PS:<MAIL.BBOARD.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:R, World:R
$!	
$!	Directory PS:<MAIL.QUEUE.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:RWD, World:W
$!
$crea/dir ps:<mail>/prot=(s:rewd,o:rewd,g:rwd,w:r)-
/own=[system,mailer]/ver=0
$crea/dir ps:<mail.queue>/prot=(s:rewd,o:rewd,g:r,w:r)-
/own=[system,mailer]/ver=0
$crea/dir ps:<mail.bboard>/prot=(s:rewd,o:rewd,g:rwd,w:w)-
/own=[system,mailer]/ver=0
$!
$!	Define the directories
$!
$ define /system sys$mail ps:<mail>
$ define /system sys$mailq ps:<mail.queue>
$ define /system sys$bboard ps:<mail.bboard>
$!
$!	Copy the programs to the appropiate directories.
$!
$!	The help files, edtini file, domains.txt and mailing_lists.txt
$!	must be in sys$mail:  The exe(s) can be anywhere you wish.
$!
$copy *.hlb sys$mail:
$copy edtini.edt sys$mail:
$copy domains.txt sys$mail:
$copy mailing_lists.txt sys$mail:
$copy *.exe sys$mail:
$!
$!
$!	DO THE REST OF THIS BY HAND!
$!
$!	Build the account mailer with the following parameters.  If you do
$!	disk quota checking, make sure mailer does not get hit!
$!
$!	Username: MAILER  Owner:  MAILER  UIC:  [1,6] ([SYSTEM,MAILER])
$!	Default:  DUA0:<SYS0.MAIL>  Authorized Privileges:   SETPRV
$!
$!	Modify domains.txt and mailing_lists.txt to reflect your site.
$!
$!	Install MM as a known image.  Use the command line(s):
$!	run sys$system:install
$!	sys$mail:mm /priv=(prmgbl,sysprv,sysgbl) /open /header /share
$!
$!	Later you will want to modify the system dcltables.  For now
$!	modify the process dcltables use the command line:
$!	set command mm.cld
$!	
$!	Submit the maiserout batch job.  This must be done from 
$!	the account MAILER.  Or whatever you use for your registered 
$!	bitnet mail system name.
$!
$!	Run bsmtpfork as a detached process.  The command line is:
$!	run/uic=[1,6]/proc=bsmtpfork sys$mail:bsmtpfork
$!
$!	Copy smtpfork.exe so that the local networking software knows 
$!	where to find it.
$!
$!	If you are not running Tektronix version of TCP/IP then you
$!	must define tcp$prod: to point to the directory where your
$!	hosts.txt file will reside.
