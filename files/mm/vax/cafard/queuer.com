$ Open/Read/Error=Nohost Hosttxt Hostname.Txt
$ Read Hosttxt OurHost
$ Read Hosttxt RemoteHost
$ Close Hosttxt
$ Write Sys$Output "[Looking for mail for ''OurHost' from ''RemoteHost']"
$ cafrcv :== $ Pony$Images:Cafardrcv.Exe cafrcv
$Loop:
$ Env = F$Search("cafard_new_*.env",3)
$ If Env.EQS."" Then $ Goto Done
$ Name = F$Parse(Env,,,"NAME") + ".msg"
$ Msg = F$Search(Name,1)
$ On Error Then $ Goto Loop
$ cafrcv 'RemoteHost' 'Env' 'Msg'
$ Goto Loop
$NoHost:
$ Write Sys$Output "? Can't tell what host this is.  Need Hostname.Txt"
$Done:
$ Exit
