COMMENT /*
	 * INTERN.D -- Tokens used internally in resolver code.
	 *
	 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
	 *
	 * Note that there is absolutely NO WARRANTY on this software.
	 * See the file COPYRIGHT.NOTICE for details and restrictions.
	 *
	 * This stuff is in DSYMS format to avoid multiple definitions.
	 * Numeric values assigned to tokens are arbitrary, but should
	 * not be reused, just in case you forget to recompile all the
	 * modules that are affected by the change.
	 *
	 * Out-of-band data is represented as an extension of the
	 * existing syntax for $INCLUDE.  General format is:
	 *
	 *	$ <name> <argument(s)>
	 *
	 * In most cases (except $INCLUDE) the argument will be a
	 * number, but the syntax is general enough that this doesn't
	 * matter.
	 *
	 * The following tokens are currently recognized:
	 * 	ZL_DATE:	Date this zone retrieved
	 * 	ZL_RETRY:	Date we last tried to update
	 * 	ZL_CACHE:	Boolean indicating cache-ness
	 * 	ZL_HIDDEN:	Boolean indicating hidden-ness
	 * 	ZL_INCLUDE:	Included zone file
	 *	ZL_ORIGIN:	New origin for this zone file
	 */

BTUPLE(zl_table)
 TUPLE(ZL_DATE,		0,	"ZONE-LOAD-DATE"	)
 TUPLE(ZL_RETRY,	1,	"ZONE-RETRY-DATE"	)
 TUPLE(ZL_CACHE,	2,	"ZONE-IS-CACHE"   	)
 TUPLE(ZL_HIDDEN,	3,	"ZONE-IS-HIDDEN"	)
 TUPLE(ZL_INCLUDE,	4,	"INCLUDE"		)
 TUPLE(ZL_ORIGIN,	5,	"ORIGIN"		)
ETUPLE
CONST(ZL_MAX,		5)

COMMENT /* Resolver configuration file options. */
BTUPLE(cf_table)
 TUPLE(CF_LSEARCH,	0,	"LOCAL-SEARCH-PATH"			)
ATUPLE(CF_LSEARCH,		"LSEARCH"				)
 TUPLE(CF_RSEARCH,	1,	"REMOTE-SEARCH-PATH"			)
ATUPLE(CF_RSEARCH,		"RSEARCH"				)
 TUPLE(CF_DSERVE,	2,	"DEFAULT-NAMESERVER"			)
ATUPLE(CF_DSERVE,		"DSERVE"				)
 TUPLE(CF_RXMT,		3,	"UDP-RETRANSMIT-INTERVAL"		)
ATUPLE(CF_RXMT,			"RXMT"					)
 TUPLE(CF_QRYTMO,	4,	"QUERY-TIMEOUT"				)
ATUPLE(CF_QRYTMO,		"QRYTMO"				)
 TUPLE(CF_MAXTRY,	5,	"MAX-TRIES-PER-SERVER-PER-QUERY"	)
ATUPLE(CF_MAXTRY,		"MAXTRY"				)
 TUPLE(CF_MAXCNAME,	6,	"MAX-CNAMES-PER-QUERY"			)
ATUPLE(CF_MAXCNAME,		"MAXCNAME"				)
 TUPLE(CF_GCPERIOD,	7,	"GC-PERIOD"				)
 TUPLE(CF_ZLOAD,	8,	"LOAD-ZONE"				)
ATUPLE(CF_ZLOAD,		"ZLOAD"					)
 TUPLE(CF_CLOAD,	9,	"PRELOAD-CACHE"				)
ATUPLE(CF_CLOAD,		"CLOAD"					)
 TUPLE(CF_WHOPR,	10,	"AUTHORIZE-USER"			)
ATUPLE(CF_WHOPR,		"WHOPR"					)
 TUPLE(CF_MAXTTL,	11,	"MAX-REASONABLE-TTL"			)
ATUPLE(CF_MAXTTL,		"MAXTTL"				)
ETUPLE
CONST(CF_MAX,		11)

COMMENT /* Transport protocols */
BTUPLE(xp_table)
 TUPLE(XP_CHAOS, 0,	"CHAOS"	)
 TUPLE(XP_TCP,	 1,	"TCP"	)
 TUPLE(XP_UDP,	 2,	"UDP"	)
ETUPLE
CONST(XP_MAX,	 2)

COMMENT /* End of INTERN.D */
