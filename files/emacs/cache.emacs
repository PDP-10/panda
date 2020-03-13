!~FILENAME~:! !Hack to improve speed of M.M-lookups.
Bugs/features to JPERSHING@BBNA.!

CACHE				    !* IVORY source format.!

!& Setup CACHE Library:! !S (Describe this for library information.)

This library maintains a cache of pointers to functions in libraries,
to avoid redundant (and expensive) searches.  The cache lives in
q-register .Z as a binary-searched table.  To avoid creating thousands
of entries, the cache is swept regularly from the clock interrupt.

This library should be loaded AFTER any personal setup has been
completed, to make sure that the personal setup doesn't smash anything
required by this library.  Note that this library only destroys
q-register .M (& Macro Get), although it intercepts calls to other
functions in a benign way.  Also, we snarf q-register .Z for the cache
itself.  The cache is enabled by default when the library is loaded,
although this is controlled by the zeroishness of Cache Enabled.

Various options may be hacked with M-X Alter OptionsCache.!

!* Update History:

21-Aug-80 (101):  Optimization in autoloader (M.A), suggested by Gene, whereby
	we first check to see if the library is loaded before blindly purging.
	Shortened a few doc-strings so that the :EJ file is only 2K.  Creaated
	variable Cache Normalized Interval to get multiply out of the parge
	and sweep routines.  Tweaked output format of List Cache.

30-Jun-80 (100):  Installed, unnanounced, after extensive use and testing by
	John and Gene, and less extensive use by Buz Owen.

CACHE was originally inspired in the early winter of '79 by the increduously
crappy response of BBND when Release 4 of Twenex first came up.  The first
implementation, devised during a late night hack session of Gene Ciccarelli
and John Pershing, consisted of a series of patches consed-up on the spur of
the moment which kept the cache in XX-variables (analogous to MM-variables).
Over the ensuing 6 months or so a "real" implementation took form at the hands
of John, and was subsequently streamlined into its current form.  Many useful
suggestions came from Gene and Earl Killian, who also provided much insight
into the inner obscurities of EMACS and TECO.!

 m(m.m& Declare Load-Time Defaults)
    Cache Enabled,
       * Non-zero enables caching;  Zero disables: 1
    Cache Verbose Mode,
       * Echo-area typage control -- zero=none, pos=some, neg=lots: 0
    Cache Sweep Interval,
       * Seconds between auto-sweeps of the cache: 300
    Cache Normalized Interval,
       Just $Cache Sweep Interval$ in terms of fsUpTime$: 0
    Cache Show Hit Ratio,
       * Non-zero puts hit ratio in mode line: 0
    Cache Cumulative Hits,
       Decaying total of hits: 0
    Cache Cumulative Misses,
       Decaying total of misses: 0
    

 [0[1				    !* scratch registers.!

 4*5fsQVector u.Z		    !* Set up our q-vector...!

 3 u:.Z(0)			    !* Each entry is 3 words long.  First is!
				    !* ..the name, second is the value (no!
				    !* ..surprises), third is the reference!
				    !* ..counter (used for sweeping).  This!
				    !* ..particular entry is the REAL enable!
				    !* ..flag -- 3 means enabled, 0 disabled.!

 :i* u:.Z(1)			    !* Fake entry.  Never [sic] referenced,!
				    !* ..never purged or swept.  Its only!
				    !* ..purpose is to reserve the next two!
				    !* ..slots...!

 0 u:.Z(2)			    !* Counts the number of hits in the cache.!
 0 u:.Z(3)			    !* Counts the number of misses.!

 0 uCache Cumulative Hits	    !* Cumulative totals.!
 0 uCache Cumulative Misses	    !* ...!

 :@i*|!* Non-zero enables caching;  Zero disables!	!* Main VarMacro:!
      :m(m.m& Enable or Disable Cache)   !* Call workhorse routine.!
 | u:..q(:fo..qCache Enabled+2)    !* (install in ..q)!

				    !* Sweep Interval VarMacro:!
 :@i*|!* Seconds between auto-sweeps of the cache!	!* ...!
    fsMachine"E		    !* (this is machine dependent).!
       30'"# 1000'*()uCache Normalized Interval !* Set real variable.!
 | u:..q(:fo..qCache Sweep Interval+2)	!* (install it in ..q)!

				    !* Verbose-mode VarMacro:!
 :@i*|!* Echo-area typage control -- zero=none, pos=some, neg=lots!	!* ..!
      "L m.m& Verbose Cache Macro Get u.M'	!* Negative: verbose version.!
      "# m.m& Cache Macro Get u.M' !* Non-neg: quiet version.!
      q.M m.vMM & Macro Getw	    !* Smash long-name, just in case.!
 | u:..q(:fo..qCache Verbose Mode+2)   !* (install it in ..q)!

 :@i*|!* Non-zero puts hit ratio in mode line!  !* ModeLine VarMacro:!
      :m(m.m& Cache Modeline Hacker)	!* Call workhorse routine.!
 | u:..q(:fo..qCache Show Hit Ratio+2)	!* (install in ..q)!

 m.mLoad Library m.vMM Pre-Cache Load Libraryw    !* Intercept libr loader.!
 m.mCache Load Library m.vMM Load Libraryw	!* ...!

 q.A m.vMM & Pre-Cache Autoloadw   !* Intercept autoloader, too.!
 m.m& Cache Autoload m.vMM & Autoload u.A !*!

 m.mKill Libraries m.vMM Pre-Cache Kill Librariesw	!* Intercept killer.!
 m.mCache Kill Libraries m.vMM Kill Librariesw    !* ...!

 q.M m.vPre-Cache q.Mw		    !* Finally, install our lookup macro.!
 qCache Verbose Mode"L	    !* Depending on verbosity...!
    m.m& Verbose Cache Macro Get'"# m.m& Cache Macro Get'(	!* pick one.!
    )m.vMM & Macro Get u.M	    !* smash it in.!

 qCache Enabledm(m.m& Enable or Disable Cache)   !* Obey the options.!
 qCache Show Hit Ratiom(m.m& Cache Modeline Hacker)	!* ...!
 qCache Sweep IntervaluCache Sweep Interval	!* ...!

 0fo..qCACHE Setup Hookf"N u0 m0 '	!* Call luser hook.!

 fsClkMacrof"Ew :i*' m.vMM & Pre-Cache Clock Macrow    !* If no hook,!
 m.m& Cache Real-Time Interrupt fsClkMacrow		    !* ..install!
 fsClkInterval"E 4*3600fsClkIntervalw '		    !* ..our clock.!

 0

!& Kill CACHE Library:! !S Try to separate our tentacles from EMACS.!

 m(m.m& Declare Load-Time Defaults)
    Cache Enabled,
       * Non-zero enables caching;  Zero disables: 1
    Cache Sweep Interval,
       * Seconds between auto-sweeps of the cache: 300
    Cache Verbose Mode,
       * Echo-area typage control -- zero=none, pos=some, neg=lots: 0
    Cache Show Hit Ratio,
       * Non-zero puts hit ratio in mode line: 0
    

 [1				    !* Scratch register.!

 m.mKill Variable[K		    !* Reduce typage.!

 0[Cache Show Hit Ratio	    !* Remove mode-line hook.!
 0[Cache Enabled		    !* Turn off the cache.!

 0fo..qCACHE Kill Hookf"N [0 m0 '"#w	!* Call un-hook.!
    m.m& Pre-Cache Clock MacrofsClkMacrow !* Or get rid of our clock.!
    mKMM & Pre-Cache Clock Macro ' !* ..!

 qPre-Cache q.M m.vMM & Macro Get u.M    !* Kill, kill.!
 mKPre-Cache q.Mw		    !* ..!
 qMM Pre-Cache Kill Libraries m.vMM Kill Librariesw	!* ..!
 mKMM Pre-Cache Kill Librariesw    !* ..!
 qMM & Pre-Cache Autoload m.vMM & Autoload u.A   !* ..!
 mKMM & Pre-Cache Autoloadw	    !* ..!
 qMM Pre-Cache Load Library m.vMM Load Libraryw  !* ..!
 mKMM Pre-Cache Load Libraryw	    !* ..!
 :i:..q(:fo..qCache Enabled+2)* Non-zero enables caching;  Zero disables
 :i:..q(:fo..qCache Sweep Interval+2)* Seconds between auto-sweeps of the cache
 :i:..q(:fo..qCache Verbose Mode+2)* Echo-area typage control -- zero=none, pos=some, neg=lots
 :i:..q(:fo..qCache Show Hit Ratio+2)* Non-zero puts hit ratio in mode line
 q.ZfsBKill 0u.Z		    !* ..!

 0

!Enable Cache:! !C Defunct: Cache is controlled by variable Cache Enabled.!

 m(m.m& Declare Load-Time Defaults)
    Cache Enabled,
       * Non-zero enables caching;  Zero disables: 1
    

 -1uCache Enabled		    !* Turn on the flag.!
 0

!Disable Cache:! !C Defunct: Cache is controlled by variable Cache Enabled.!

 m(m.m& Declare Load-Time Defaults)
    Cache Enabled,
       * Non-zero enables caching;  Zero disables: 1
    

 0uCache Enabled		    !* Just what it sez, folks...!
 0

!& Enable or Disable Cache:! !S VarMacro for Cache Enabled.!

 f"Nw 3'u:.Z(0)		    !* Set enable-flag.!
 fsModeChange"E qCache Show Hit Ratio"N 1fsModeChangew ''	!* Maybe a new!
								!* ..modeline.!
 "N 1,':m(m.mPurge Cache)	    !* Just in case any garbage laying!
				    !* ..around.!

!Sweep Cache:! !C Eliminate entries which have not been used recently.!
!*
One pass is made through the cache:  any entry with a reference count
of zero is eliminated;  all others have their reference counts set to
zero.  This is a no-op if the cache is disabled.!

 m(m.m& Declare Load-Time Defaults)
    Cache Normalized Interval,
       Just $Cache Sweep Interval$ in terms of fsUpTime$: 0
    Cache Next Sweep Time,
       In terms of fsUpTime: 0
    Cache Verbose Mode,
       * Echo-area typage control -- zero=none, pos=some, neg=lots: 0
    

 q:.Z(0)"E 0'			    !* No-op if cache disabled.!

 [0[1				    !* Save some registers.!

 qCache Verbose Mode"N	    !* User wants some verbiage.!
    fq.Z-20/15:\u1		    !* 1:  number of entries, as a string.!
    !<! @ft[Sweep 1-> '	    !* Type starting size.!

 q.Z[..O			    !* Select the cache.!
 30:j"Ezj'			    !* Goto first REAL reference count,!
				    !* ..skipping over initial, fake entry.!

 < .-z;				    !* Sweep:!
    .fsWord"E -10c 15d 10:c;'	    !* Unreferenced:  kill it.!
    "# 0,.fsWordw 15:c;' >	    !* Referenced:  spare it, but zero ref.!

 fsUpTime+qCache Normalized IntervaluCache Next Sweep Time
				    !* Set timer for next auto-sweep.!

 20.f?				    !* Close gap if huge.!

 qCache Verbose Mode"N	    !* User wants some verbiage.!
    fq.Z-20/15:\u1		    !* 1:  number of entries, as a string.!
    @ft1] 0fsEchoActivew'	    !* Type ending size.!

 0

!Purge Cache:! !C Eliminate all entries in the cache.!
!*
This must be called whenever the list of loaded libraries is altered,
due to either a load or a kill.  Unless a non-zero pre-comma arg is
given, the gap is closed.  Always purges, even if cache is disabled.!


 m(m.m& Declare Load-Time Defaults)
    Cache Normalized Interval,
       Just $Cache Sweep Interval$ in terms of fsUpTime$: 0
    Cache Next Sweep Time,
       In terms of fsUpTime: 0
    Cache Verbose Mode,
       * Echo-area typage control -- zero=none, pos=some, neg=lots: 0
    

 [1				    !* Save a register.!

 qCache Verbose Mode"N	    !* User wants some verbiage.!
    fq.Z-20/15:\u1		    !* 1:  number of entries, as a string.!
    !<! @ft[Purge 1-> '	    !* Type starting size.!

 q.Z[..O			    !* Yank in the cache.!
 20,zk				    !* Purge it.!

 fsUpTime+qCache Normalized IntervaluCache Next Sweep Time
				    !* Set timer for next auto-sweep.!

 "E 1f?'			    !* Maybe close gap.!

 qCache Verbose Mode"N	    !* Maybe sign off.!
    @ft0] 0fsEchoActivew '	    !* Type ending size.!

 

!& Cache Macro Get:! !S M.M: returns macro for given name (string arg).!
!*
If no numeric arg, then we check for an MM-variable and then search
    all loaded libraries in order.  A cache of recently looked-up
    functions is kept in Q.Z
The second argument, if nonzero, is a pointer to the library to load
    from.
The first argument, if nonzero, means return 0 for an undefined or
    ambiguous name, instead of causing a TECO error.!


 :I*[0			    !* Get string arg.!

 "E 0FO..QMM 0F"N 'w	    !* If no libr-ptr given, then check for!
				    !* ..MM-var.!
    q:.Z(0)"N @:fo.Z0F"G u0	    !* If cache is enabled, then check it.!
	  q:.Z(%0)( %:.Z(%0)w%:.Z(2)w )'w''	!* Win: bump ref- and!
						!* ..hit-count, and return!
						!* ..value.!

 fs:EJPage*12000.+400000000000.[1  !* Pointer to topmost library.!
 "N U1'			    !* If arg, use it as libr ptr, instead.!
 Q0,Q1M(Q1+4)U1			    !* Invoke the search...!

 "E Q1"N			    !* If no explicit lib ptr, and we won...!

       q:.Z(0)"N		    !* Then if cache is enabled...!
	  <0:g0-32:@;1,fq0:g0u0>    !* then strip leading blanks from name,!
	  q.Z[..O		    !* select the cache,!
	  :@fo.Z0,0 *5j	    !* move to insertion location,!
	  1f[NoQuit		    !* (make sure we are not disturbed),!
	  .(15,0i)j		    !* make some space,!
	  q0,.fsWordw 5c	    !* stick in entry name,!
	  q1,.fsWordw 5c	    !* its value,!
	  1,.fsWordw		    !* and set the touched-bit.!
	  %:.Z(3)w'		    !* Tally this probe as a miss.!

       q1''			    !* In any case, return found function.!

 "#				    !* We had a libr-ptr as an arg...!
     Q1"L +FQ()+4-Q1"L 0U1''    !* If function was in a deeper library,!
				    !* ..then pretend to have not found it.!
     Q1F"L ''			    !* If something found, return it.!

 "N 0'			    !* Nothing found:  if pre-comma arg, then!
				    !* ..merely return zero.!

 :I*0  Undefined or ambiguous macro nameFSERR !* Complain.!

!& Verbose Cache Macro Get:! !S M.M: returns macro for given name (string arg).!
!*
If no numeric arg, then we check for an MM-variable and then search
    all loaded libraries in order.  A cache of recently looked-up
    functions is kept in Q.Z.  Adding an entry to the cache echoes
    a "+";  hitting an existing cache entry echoes a "."
The second argument, if nonzero, is a pointer to the library to load
    from.
The first argument, if nonzero, means return 0 for an undefined or
    ambiguous name, instead of causing a TECO error.!


 :I*[0			    !* Get string arg.!

 "E 0FO..QMM 0F"N '	    !* If no libr-ptr given, then check for!
				    !* ..MM-var.!
    q:.Z(0)"N @:fo.Z0F"G u0	    !* If cache is enabled, then check it.!
	  @ft. 0fsEchoActivew	    !* Win:  make a bit of noise,!
	  q:.Z(%0)( %:.Z(%0)w%:.Z(2)w )'w''	!* bump ref- and hit-count,!
						!* ..and return value.!

 fs:EJPage*12000.+400000000000.[1  !* Pointer to topmost library.!
 "N U1'			    !* If arg, use it as libr ptr, instead.!
 Q0,Q1M(Q1+4)U1			    !* Invoke the search...!

 "E Q1"N			    !* If no explicit lib ptr, and we won...!

       q:.Z(0)"N		    !* Then if cache is enabled...!
	  <0:g0-32:@;1,fq0:g0u0>    !* then strip leading blanks from name,!
	  q.Z[..O		    !* select the cache,!
	  :@fo.Z0,0 *5j	    !* move to insertion location,!
	  1f[NoQuit		    !* (make sure we are not disturbed),!
	  .(15,0i)j		    !* make some space,!
	  q0,.fsWordw 5c	    !* stick in entry name,!
	  q1,.fsWordw 5c	    !* its value,!
	  1,.fsWordw		    !* and set the touched-bit.!
	  @ft+ 0fsEchoActivew	    !* Indicate what we have done,!
	  %:.Z(3)w'		    !* and tally this probe as a miss.!

       q1''			    !* In any case, return found function.!

 "#				    !* We had a libr-ptr as an arg...!
     Q1"L +FQ()+4-Q1"L 0U1''    !* If function was in a deeper library,!
				    !* ..then pretend to have not found it.!
     Q1F"L ''			    !* If something found, return it.!

 "N 0'			    !* Nothing found:  if pre-comma arg, then!
				    !* ..merely return zero.!

 :I*0  Undefined or ambiguous macro nameFSERR !* Complain.!

!Cache Load Library:! !C Purge cache, then call MM Pre-Cache Load Library!

 q:.Z(0)"N			    !* If cache enabled,!
    1,m(m.mPurge Cache)w'	    !* then clear it out.!

 f:m(m.mPre-Cache Load Library)  !* Goto previous version of macro.!

!Cache Kill Libraries:! !C Disable cache, then call MM Pre-Cache Kill Libraries!

 0[Cache Enabled		    !* Forcibly disable cache.!

 f:m(m.mPre-Cache Kill Libraries)	!* Transfer to old killer.!

!& Cache Autoload:! !S Call MM & Pre-Cache Autoload, then purge cache.!
!*
(Note that the previous autoloader will call MM Load Library, which
we also intercept.)  The autoloader macro sets things up so that the
library will (maybe) go away automagically when the calling
environment pops the q-register pdl.  We must purge the cache at this
time;  otherwise, the cache may contain pointers into empty space
(where the library used to be).  Q-register ..N is just the hook
(hack?) we need.!

 fsQPPtr( :i*( :i*[2 )[1 )[0 :i*[3	!* 3 will collect macro which!
						!* ..invokes real autoloader.!

 q:.Z(0)"N			    !* If cache is enabled,!
    1,m(m.m& Get Library Pointer)1"E  !* and library not already loaded,!
       @:i3\@fn|1,m(m.mPurge Cache)|\''    !* then will need to purge when!
					    !* ..done.!

 @:i3|3 fm(m.m& Pre-Cache Autoload)12:|  !* Call to real!
							    !* ..autoloader.!

 f:m(q3(q0fsQPUnwindw))	    !* Macro the collected works, after first!
				    !* ..unwinding our pushes from the PDL.!

!& Cache Real-Time Interrupt:! !S Maybe sweep cache some of the time.!
!*
This macro gets hooked in ahead of the extant clock macro.  It calls
& Maybe Sweep Cache, which will cause a sweep no more frequently than
every Cache Sweep Interval seconds.  We also decay the hit-ratio
statistics.!

 m(m.m& Declare Load-Time Defaults)
    Cache Cumulative Hits,
       Decaying total of hits: 0
    Cache Cumulative Misses,
       Decaying total of misses: 0
    

 [1				    !* Save a register.!

 q:.Z(0)"N			    !* If cache is enabled...!
    5*3600/(fsClkInterval) u1	    !* Determine expt decay factor.!
    q1-2:"G 2u1'		    !* (but no smaller than 2)!
    qCache Cumulative Hits*(q1-1)+q:.Z(2)+(q1/2)/q1(	!* Decay, decay.!
       ) uCache Cumulative Hits 0u:.Z(2)  !* ..!
    qCache Cumulative Misses*(q1-1)+q:.Z(3)+(q1/2)/q1(    !* ..!
       ) uCache Cumulative Misses 0u:.Z(3)	!* ..!
    fsModeChangeqCache Show Hit Ratio fsModeChangew   !* Maybe set!
							    !* ..modeline.!
    m(m.m& Maybe Sweep Cache)w'    !* then maybe sweep.!

 f:m(m.m& Pre-Cache Clock Macro) !* Goto the original clock macro.!

!& Maybe Sweep Cache:! !S Sweep cache if it has been a while.!
!*
If it has been longer than Cache Sweep Interval seconds since the
last sweeping, then the cache is swept.!

 m(m.m& Declare Load-Time Defaults)
    Cache Next Sweep Time,
       In terms of fsUpTime: 0
    

 q:.Z(0)"N			    !* If cache is enabled...!
    fsUpTime-qCache Next Sweep Time"G    !* and its been a while,!
       :m(m.mSweep Cache)''	    !* then clear out excess baggage.!

 

!& Cache Set Mode Line Hook:! !S See option Cache Show Hit Ratio.!
!*
Hit-ratio-into-mode-line hook.  This is most easily installed by
setting the option Cache Show Hit Ratio non-zero.!

 ( 1:< q:.Z(0)"N i H/R= m(m.m& Hit Ratio)\ i% ' >w )	!* Insert percentage.!

!& Cache Modeline Hacker:! !S Add or remove our mode line hook.!

 [1				    !* Save a scratch register.!

 f[BBind gSet Mode Line Hook bj  !* Yank mode hook into temp buffer.!
 m.m& Cache Set Mode Line Hook u1  !* Grab our hook.!

 "N				    !* Make sure our hook is installed...!
    :s1"N '		    !* Yup -- no-op.!
    zj g1 '			    !* Nope -- install it.!

 "#				    !* Alternatively, make sure its NOT!
				    !* ..there.!
    :s1"E '		    !* Nope -- not there.!
    fkd '			    !* Yup -- erase it.!

 hxSet Mode Line Hook		    !* Install modified mode hook.!
 1fsModeChangew		    !* Recompute mode line.!
 

!& Hit Ratio:! !S Returns current hit-ratio (as a percentage).!
!*
Or -1 if cache is disabled.!

 m(m.m& Declare Load-Time Defaults)
    Cache Cumulative Hits,
       Decaying total of hits: 0
    Cache Cumulative Misses,
       Decaying total of misses: 0
    

 q:.Z(0)"E -1'		    !* Return -1 if disabled.!

 [0[1[2				    !* Save some registers.!

 q:.Z(2)+qCache Cumulative Hitsu1 !* 1: Total hits (sort of).!
 q:.Z(3)+qCache Cumulative Missesu2	!* 2: Similarly for misses.!
 q1+q2f"Ew 1'u0			    !* Watch out for zerodivide.!
 q1*100/q0			    !* Return the percentage.!


!List Cache:! !C Print sizeof and contents of cache.!

 q:.Z(0)"E ft[Cache is disabled]
 0 '				    !* Nothing to report...!

 [0[1[2[3[f			    !* Save some registers.!

 m.m& Maybe Flush Output uf	    !* f:  & Maybe Flush Output!

 fq.Z-20/15 u2			    !* 2:  number of entries.!
 q.Z[..O fsZ+fsGapLen+39u1 ]..O   !* 1:  accumulated byte count.!
				    !* (data plus gap plus overhead)!

 q2:\u3 ftCache contains 3 entries, 	!* ..!

 4u3 q2< fq:.Z(q3)+4+q1u1 q3+3u3 >  !* Determine string overhead.!

 q1+4/5:\u3 ftoccupying 3 words (including the gap).
				    !* ..!

 q1+(q2/2)/q2+4/5:\u3 ft(Approx 3 words per entry)

Hits	Contents
				    !* ..!

 4u3 q2< 3,q:.Z(q3+2):\u0 q:.Z(q3)u1 ft0	1
 q3+3u3 mfw0; >		    !* List.!

 ftDone.

 0

!What Hit Ratio:! !C Type current cache hit-ratio in echo area.!

 m(m.m& Declare Load-Time Defaults)
    Cache Show Hit Ratio,
       * Non-zero puts hit ratio in mode line: 0
    

 [1				    !* Save some registers.!

 m(m.m& Hit Ratio)u1		    !* Get ratio.!

 q1"L @ft
[Cache is disabled] '		    !* Cache not enabled.!

 "# q1:\u1 @ft
Hit Ratio = 1% '		    !* Enabled:  type percentage.!

 qCache Show Hit Ratio"N	    !* If mode-hook is installed,!
    1fsModeChangew '		    !* then update value in mode line.!

 0fsEchoActivew		    !* Defeat auto-flushage.!
 0				    !* Nothing in buffer is changed.!  