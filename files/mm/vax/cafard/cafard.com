$ Comp = 0
$ Obj = "''F$File_Attributes("CAFARD.OBJ","RDT")'"
$ Src = "''F$File_Attributes("CAFARD.C","RDT")'"
$ If Src.LES.Obj Then $ Goto Cafdir
$ Comp = 1
$ Write Sys$Output "[Cafard]"
$ CC Cafard
$Cafdir:
$ Obj = "''F$File_Attributes("CAFDIR.OBJ","RDT")'"
$ Src = "''F$File_Attributes("CAFDIR.C","RDT")'"
$ If Src.LES.Obj Then $ Goto Cafpro
$ Comp = 1
$ Write Sys$Output "[Cafdir]"
$ CC Cafdir
$Cafpro:
$ Obj = "''F$File_Attributes("CAFPRO.OBJ","RDT")'"
$ Src = "''F$File_Attributes("CAFPRO.C","RDT")'"
$ If Src.LES.Obj Then $ Goto Cafio
$ Comp = 1
$ Write Sys$Output "[Cafpro]"
$ CC Cafpro
$Cafio:
$ Obj = "''F$File_Attributes("CAFIO.OBJ","RDT")'"
$ Src = "''F$File_Attributes("CAFIO.C","RDT")'"
$ If Src.LES.Obj Then $ Goto Linker
$ Comp = 1
$ Write Sys$Output "[Cafio]"
$ CC Cafio
$Linker:
$ If Comp.NE.1 Then $ Exit
$ link cafard,cafpro,cafio,cafdir,-
    'CLibrary'
$ Purge/K=3
$ Exit
