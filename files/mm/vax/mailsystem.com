$ define /system sys$mailq ps:<mail.queue>
$ define /system sys$mail ps:<mail>
$ define /system sys$bboard ps:<mail.bboard>
$ run/process=bsmtpfork/uic=[1,6] sys$mail:bsmtpfork
$ run/process=jmailer/uic=[1,6] ps:<subsys>jmailer
$submit/nolog/noprint/user:mailer sys$mail:maiserout
$ run sys$system:install
sys$mail:mm /priv=(prmgbl,sysprv,sysgbl) /open /header /share
$ exit
