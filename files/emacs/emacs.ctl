@TE NVT
! assemble TECO and build a new EMACS
@enable

! define logical names to point to where <EMACS> will live
! change these if it lives elsewhere
@define emacs: <emacs165>
@define info: <info>
! emacs: must be at the front of sys: in this file to hide any DEC TECO.EXE.
! if this is not run under batch, you should be sure that MIT TECO is invoked.
@define sys: emacs:,sys:

! when TECO starts up, it must run TECO.INIT from <EMACS>, so connect there.
@connect emacs:

!@vdirectory sys:midas.exe,teco.mid,teco.init
!@vdirectory info:emacs.init,teach-emacs.init,teach-emacs.txt

@nmidas
*temp_teco
! Now start up the new TECO, and dump out the environment the init file creates.
@nddt
*;ytemp
*purifyg
*mmrunpurifydumpnemacs.exe
*mmruneinit? document
!
! Make a stand-alone INFO
@teco
*er info:emacs.init@y m(hfx*)
@reset
!
! Make TEACH-EMACS.EXE
@teco
*er emacs:teach-emacs.init@y m(hfx*)

!@vdirectory teco.exe,tecpur.exe,nemacs.exe,emacs.doc,emacs.chart
!@vdirectory ninfo.exe,teach-emacs.tutorial,teach-emacs.exe


