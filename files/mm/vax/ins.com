$ run sys$system:install
sys$mail:mm /priv=(prmgbl,sysprv,sysgbl) /open /header /share
