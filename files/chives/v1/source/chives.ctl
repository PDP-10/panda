; Build CHIVES system.
;
; Force restart from begining of file, get logical name frobs.
%fin::
@set default take echo
@take -dirs-.cmd
;
; Compile DOMSYM and UGTDOM library
;
@compile @domsym.cmd
@compile gtdom.usr+gtdom.mac ugtdom.rel
;
; Make GTSTST.EXE
;
@compile gtdtst.mac
@link
*@gtdtst.ccl
;
; Make RELIQ.EXE
;
@midas reliq.mid
;
; Make RSVCTL.EXE
;
@load rsvctl.mac
;
; Link the resolver
;
@ccx -q -x=macro -o=RESOLV -i -
@ -DDEBUG -DDBFLG_INITIAL=-1 -DDUMP_P=1 -DUDP_PACKET_LOGGING -
@   bug20x cdump crit fil20x gc gtable gtoken inaddr insert ipc20x load -
@   lookup makqry match memory names resolv rpkt rrfmt rrtoa sio20x skipws -
@   tables tblook tim20x trees udp20x usr20x zzz20x
;
; Link the zone transfer client
;
@ccx -q -x=macro -o=ZT -i=extend+psect -
@ -DDEBUG -DDBFLG_INITIAL=-1 -DDUMP_P=1 -DUDP_PACKET_LOGGING -
@   bug20x crit fil20x gtable gtoken inaddr insert ipc20x load makqry -
@   match memory names net20x rpkt rrfmt rrtoa sio20x skipws tables -
@   tblook tim20x trees zt
;
; That's all, folks.
