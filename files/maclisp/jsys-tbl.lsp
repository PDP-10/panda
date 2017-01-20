;;; -*-Lisp-*-

;;; JSYS-TBL - Twenex JSYS calls.

(eval-when (eval compile) (setq o-ibase ibase ibase 8.)

	   (setq
	    jsys 0

	    login 1
	    crjob 2
	    lgout 3
	    cacct 4
	    efact 5
	    smon 6
	    tmon 7
	    getab 10
	    erstr 11
	    geter 12
	    gjinf 13
	    time 14
	    runtm 15
	    sysgt 16
	    gnjfn 17
	    gtjfn 20
	    openf 21
	    closf 22
	    rljfn 23
	    gtsts 24
	    ststs 25
	    delf 26
	    sfptr 27
	    jfns 30
	    ffffp 31
	    rddir 32	 ;Obsolete
	    cprtf 33
	    clzff 34
	    rnamf 35
	    sizef 36
	    gactf 37
	    stdir 40	 ;Obsolete
	    dirst 41
	    bkjfn 42
	    rfptr 43
	    cndir 44
	    rfbsz 45
	    sfbsz 46
	    swjfn 47
	    bin 50
	    bout 51
	    sin 52
	    sout 53
	    rin 54
	    rout 55
	    pmap 56
	    rpacs 57
	    spacs 60
	    rmap 61
	    sactf 62
	    gtfdb 63
	    chfdb 64
	    dumpi 65
	    dumpo 66
	    deldf 67
	    asnd 70
	    reld 71
	    csyno 72
	    pbin 73
	    pbout 74
	    psin 75
	    psout 76
	    mtopr 77
	    cfibf 100
	    cfobf 101
	    sibe 102
	    sobe 103
	    dobe 104
	    gtabs 105	 ;Obsolete
	    stabs 106	 ;Obsolete
	    rfmod 107
	    sfmod 110
	    rfpos 111
	    rfcoc 112
	    sfcoc 113
	    sti 114
	    dtach 115
	    atach 116
	    dvchr 117
	    stdev 120
	    devst 121
	    mount 122	 ;Obsolete
	    dsmnt 123	 ;Obsolete
	    inidr 124	 ;Obsolete
	    sir 125
	    eir 126
	    skpir 127
	    dir 130
	    aic 131
	    iic 132
	    dic 133
	    rcm 134
	    rwm 135
	    debrk 136
	    ati 137
	    dti 140
	    cis 141
	    sircm 142
	    rircm 143
	    rir 144
	    gdsts 145
	    sdsts 146
	    reset 147
	    rpcap 150
	    epcap 151
	    cfork 152
	    kfork 153
	    ffork 154
	    rfork 155
	    rfsts 156
	    sfork 157
	    sfacs 160
	    rfacs 161
	    hfork 162
	    wfork 163
	    gfrkh 164
	    rfrkh 165
	    gfrks 166
	    disms 167
	    haltf 170
	    gtrpw 171
	    gtrpi 172
	    rtiw 173
	    stiw 174
	    sobf 175
	    rwset 176
	    getnm 177
	    get 200
	    sfrkv 201
	    save 202
	    ssave 203
	    sevec 204
	    gevec 205
	    gpjfn 206
	    spjfn 207
	    setnm 210
	    ffufp 211
	    dibe 212
	    fdfre 213
	    gdskc 214
	    lites 215	 ;Obsolete
	    tlink 216
	    stpar 217
	    odtim 220
	    idtim 221
	    odcnv 222
	    idcnv 223
	    nout 224
	    nin 225
	    stad 226
	    gtad 227
	    odtnc 230
	    idtnc 231
	    flin 232
	    flout 233
	    dfin 234
	    dfout 235

	    crdir 240
	    gtdir 241
	    dskop 242
	    spriw 243
	    dskas 244
	    sjpri 245
	    sto 246


	    asndp 260
	    reldp 261
	    asndc 262
	    reldc 263
	    strdp 264
	    stpdp 265
	    stsdp 266
	    rdsdp 267
	    watdp 270

	    atnvt 274	 ;Tops20AN
	    cvskt 275	 ;Tops20AN
	    cvhst 276	 ;Tops20AN
	    flhst 277	 ;Tops20AN

	    gcvec 300
	    scvec 301
	    sttyp 302
	    gttyp 303
	    bpt 304	 ;Obsolete
	    gtdal 305
	    wait 306
	    hsys 307
	    usrio 310
	    peek 311
	    msfrk 312
	    esout 313
	    splfk 314
	    advis 315
	    jobtm 316
	    delnf 317
	    swtch 320	 ;Obsolete
	    tfork 321
	    rtfrk 322
	    utfrk 323
	    sctty 324
	    oprfn 326	 ;18 operator function JSYS
	    seter 336

;New (not in BBN Tenex) JSYS's added starting at 500

	    rscan 500
	    hptim 501
	    crlnm 502
	    inlnm 503
	    lnmst 504
	    rdtxt 505	 ;Obsoleted by rdtty and texti
	    setsn 506
	    getji 507
	    msend 510
	    mrecv 511
	    mutil 512
	    enq 513
	    deq 514
	    enqc 515
	    snoop 516
	    spool 517
	    alloc 520
	    chkac 521
	    timer 522
	    rdtty 523
	    texti 524
	    ufpgs 525
	    sfpos 526
	    syerr 527
	    diag 530
	    sinr 531
	    soutr 532
	    rftad 533
	    sftad 534
	    tbdel 535
	    tbadd 536
	    tbluk 537
	    stcmp 540
	    setjb 541
	    gdvec 542
	    sdvec 543
	    comnd 544
	    prarg 545
	    gacct 546
	    lpini 547
	    gfust 550
	    sfust 551
	    acces 552
	    rcdir 553
	    rcusr 554
	    mstr 555
	    stppn 556
	    ppnst 557
	    pmctl 560
	    lock 561
	    boot 562
	    utest 563
	    usage 564
	    
;Hole - slot 565 available

	    vacct 566
	    node 567
	    adbrk 570
	    gtblt 634	 ;6 GETAB BLT JSYS

;Temporary JSYS definitions

	    sndim 750	 ;Tops20AN 
	    rcvim 751	 ;Tops20AN 
	    asnsq 752	 ;Tops20AN 
	    relsq 753	 ;Tops20AN 

	    thibr 770
	    twake 771
	    mrpac 772
	    setpv 773
	    mtaln 774
	    ttmsg 775
	    )
	   (setq ibase o-ibase))
