@COMPILE /COMPILE MACSYM.MAC
@COMPILE /COMPILE REL1.MAC+MACSYM.MAC MACREL.REL
@COMPILE /COMPILE SITE.MAC+REL1.MAC+MONSYM.MAC
@COMPILE /COMPILE /NOBIN SITE.MAC+MONSYM.MAC
@EXECUTE /COMPILE SITE.MAC+ERBLD.MAC+REL1.MAC+MONSYM.MAC ERBLD.REL
@DELETE ERBLD.REL
@COMPILE /COMPILE ACTSYM.MAC
    