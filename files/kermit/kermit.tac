10-Apr-85 02:38:32-EST,1551;000000000001
Return-Path: <@COLUMBIA-20.ARPA:MRC@SIMTEL20.ARPA>
Received: from COLUMBIA-20.ARPA by CU20B.ARPA with TCP; Wed 10 Apr 85 02:38:26-EST
Received: from SU-SCORE.ARPA by COLUMBIA-20.ARPA with TCP; Wed 10 Apr 85 02:38:46-EST
Received: from SIMTEL20.ARPA by SU-SCORE.ARPA with TCP; Tue 9 Apr 85 23:29:11-PST
Date: Wed 10 Apr 85 00:28:55-MST
From: Mark Crispin <MRC@SIMTEL20.ARPA>
Subject: IAC doubling: the saga continues
To: TOPS-20@SU-SCORE.ARPA

     There have been several messages about a correct
implementation of IAC doubling on TVT's to prevent a binary '377
character being output causing spurious interpretation of network
protocol.  Unfortunately, none of the previously published
patches are perfect.  Typically, the problems are paths which can
cause a non-doubled '377 to go through or paths which could cause
many '377s to go through.

     This solution seems to resolve these problems.

     In TTYSRV, rewrite TCOU6 to look like:

TCOU6:	CAIE T1,377		;OUTPUT BYTE = IAC?
	 JRST TCOU6B
	TDCALL D,<<TV,TCOU6A>>	;YES, DO TCOU6A TWICE IF A TVT
	JRST TCOU6B

TCOU6A:	SAVEAC <T1,T2>
TCOU6B:	LOAD 3,TOMAX,(2)	;CAPACITY OF OUTPUT BUFFERS
	...etc...

     At TCOU5-1, replace JRST TCOU3 with JRST TCOU6B

     In TTANDV, rewrite TCOBN to look like:

TCOBN:	SAVELN			;SAVE LINE NUMBER
	TXZE T1,.LHALF		;WANTS IT LITERALLY?
	 JRST TCOU6B		;YES, NO IAC DOUBLING PLEASE
	ANDI T1,377		;8 BITS OF CHARACTER
	CALL TCOU6		;GO OUTPUT THE CHARACTER WITHOUT ADDING
				; PARITY OR DOING LINKS
	RET			;RETURN
-------
