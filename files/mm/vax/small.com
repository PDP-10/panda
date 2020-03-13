$link smtpfork,mail/lib,smtp_bsmtp/lib
$link bsmtpfork,mail/lib,smtp_bsmtp/lib
$link maiser,mail/lib
$cop smtpfork.exe tcp$prod:
$cop bsmtpfork.exe sys$mail:
$cop maiser.exe sys$mail:
