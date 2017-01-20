COMMENT /* RFCDEF.D -- Tokens and such specified in domain RFCs.
	 *
	 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
	 *
	 * Note that there is absolutely NO WARRANTY on this software.
	 * See the file COPYRIGHT.NOTICE for details and restrictions.
	 *
	 * See DSYMS.HLP for information on format.
	 *
	 * If you change anything in this file, be sure to increment
	 * RFCVER so that all the code will be able to detect it.
	 *
	 * A few symbol names (*INFO) have been shortened to make
	 * then unique when truncated to six characters.  Ugly but
	 * that's life.
	 */

COMMENT /* Version of this specification file. */
CONST(RFCVER,	3)

COMMENT /* Opcodes */
BTUPLE(op_table)
 TUPLE(OP_QUERY,	0,	"normal query"			)
 TUPLE(OP_IQUERY,	1,	"inverse query"			)
 TUPLE(OP_STATUS,	2,	"status request"		)
ETUPLE
CONST(OP_MAX,		2)

COMMENT /* Error codes */
BTUPLE(er_table)
 TUPLE(ER_OK,		0,	"no error"		)
 TUPLE(ER_FMT,		1,	"format error"		)
 TUPLE(ER_SRV,		2,	"server error"		)
 TUPLE(ER_NAM,		3,	"name error"		)
 TUPLE(ER_NIY,		4,	"not implemented"	)
 TUPLE(ER_REF,		5,	"refused"		)
ETUPLE
CONST(ER_MAX,		5)

COMMENT /* QTYPE */
BTUPLE(qt_table)
 TUPLE(QT_A,		1,	"A"		)
 TUPLE(QT_NS,		2,	"NS"		)
 TUPLE(QT_CNAME,	5,	"CNAME"		)
 TUPLE(QT_SOA,		6,	"SOA"		)
 TUPLE(QT_MB,		7,	"MB"		)
 TUPLE(QT_MG,		8,	"MG"		)
 TUPLE(QT_MR,		9,	"MR"		)
 TUPLE(QT_NULL,		10,	"NULL"		)
 TUPLE(QT_WKS,		11,	"WKS"		)
 TUPLE(QT_PTR,		12,	"PTR"		)
 TUPLE(QT_HINFO,	13,	"HINFO"		)
 TUPLE(QT_MINFO,	14,	"MINFO"		)
 TUPLE(QT_MX,		15,	"MX"		)
 TUPLE(QT_TXT,		16,	"TXT"		)
 TUPLE(QT_AXFR,		252,	"AXFR"		)
 TUPLE(QT_MAILB,	253,	"MAILB"		)
 TUPLE(QT_MAILA,	254,	"MAILA"		)
 TUPLE(QT_ANY,		255,	"*"		)
ETUPLE
CONST(QT_MAX,		15)

COMMENT /* QCLASS */
BTUPLE(qc_table)
 TUPLE(QC_IN,		1,	"IN"		)
 TUPLE(QC_CS,		2,	"CS"		)
 TUPLE(QC_CH,		3,	"CH"		)
 TUPLE(QC_HS,		4,	"HS"		)
 TUPLE(QC_ANY,		255,	"*"		)
ETUPLE
CONST(QC_MAX,		4)

COMMENT /* Maximum lengths of domain name and max length of a label */
CONST(MAXDNM,255)
CONST(MAXLAB,63)

COMMENT /*
	 * Definitions of RDATA fields.  Names are as in RFC883.
	 * Second field is format character as returned by rrfmt() (q.v.).
	 * If an RR format is not class-specific, use QC_ANY for class.
	 */

COMMENT /*
	 * SOA (Start Of Authority) RR.  See RFC883, page 65 for explanation.
	 * Note that SERIAL and MINIMUM were expanded to 32 bits as of RFC973.
	 */
BRDATA(QC_ANY,QT_SOA)
 RDATA(SOA_MNAME,	'd')
 RDATA(SOA_RNAME,	'd')
 RDATA(SOA_SERIAL,	'4')
 RDATA(SOA_REFRESH,	'4')
 RDATA(SOA_RETRY,	'4')
 RDATA(SOA_EXPIRE,	'4')
 RDATA(SOA_MINIMUM,	'4')
ERDATA(SOA_RDATA_LENGTH)

COMMENT /*
	 * CNAME (Cannonical NAME pointer) RR.
	 */
BRDATA(QC_ANY,QT_CNAME)
 RDATA(CNAME_CNAME,	'd')
ERDATA(CNAME_RDATA_LENGTH)

COMMENT /*
	 * NS (Name Server) RR.
	 */
BRDATA(QC_ANY,QT_NS)
 RDATA(NS_NSDNAME,	'd')
ERDATA(NS_RDATA_LENGTH)

COMMENT /*
	 * HINFO (Host INFOrmation) RR.
	 */
BRDATA(QC_ANY,QT_HINFO)
 RDATA(HINFO_CPU,	's')
ARDATA(HINFO_CPU, HINF_CPU )
 RDATA(HINFO_OS,	's')
ARDATA(HINFO_OS,  HINF_OS  )
ERDATA(HINFO_RDATA_LENGTH)

COMMENT /*
	 * MB (Mail Box) RR.
	 * MG (Mail Group) RR.
	 * MR (Mail Rename) RR.
	 */
BRDATA(QC_ANY,QT_MB)
 RDATA(MB_MADNAME,	'd')
ERDATA(MB_RDATA_LENGTH)
BRDATA(QC_ANY,QT_MG)
 RDATA(MG_MGMNAME,	'd')
ERDATA(MG_RDATA_LENGTH)
BRDATA(QC_ANY,QT_MR)
 RDATA(MR_NEWNAME,	'd')
ERDATA(MR_RDATA_LENGTH)

COMMENT /*
	 * MINFO (Mail INFOrmation) RR.
	 */
BRDATA(QC_ANY,QT_MINFO)
 RDATA(MINFO_RMAILBX,		'd')
ARDATA(MINFO_RMAILBX, MINF_RMAILBX )
 RDATA(MINFO_EMAILBX,		'd')
ARDATA(MINFO_EMAILBX, MINF_EMAILBX )
ERDATA(MINFO_RDATA_LENGTH)

COMMENT /*
	 * MD (Mail Drop) RR, superseded by MX RR, removed per RFC1035.
	 * MF (Mail Forwarder) RR, ditto.
	 */

COMMENT /*
	 * MX (Mail eXchange) RR.
	 */
BRDATA(QC_ANY,QT_MX)
 RDATA(MX_PREFERENCE,	'2')
 RDATA(MX_AGENT,	'd')
ERDATA(MX_RDATA_LENGTH)

COMMENT /*
	 * NULL (totally meaningless) RR.  No defined content!
	 */
BRDATA(QC_ANY,QT_NULL)
ERDATA(NULL_RDATA_LENGTH)

COMMENT /*
	 * PTR (PoinTeR) RR.
	 */
BRDATA(QC_ANY,QT_PTR)
 RDATA(PTR_PTRDNAME,	'd')
ERDATA(PTR_RDATA_LENGTH)

COMMENT /*
	 * A (Address) RR, classes IN and CH.
	 */
BRDATA(QC_IN,QT_A)
 RDATA(IN_A_ADDRESS,	'i')
ERDATA(IN_A_RDATA_LENGTH)
BRDATA(QC_CH,QT_A)
 RDATA(CH_A_DNAME,	'd')
 RDATA(CH_A_ADDRESS,	'c')
ERDATA(CH_A_RDATA_LENGTH)

COMMENT /*
	 * WKS (Well Known Service) RR, class IN.
	 * There is such a thing as a class CH WKS RR, but
	 * I haven't been able to find a specification for it.
	 */
BRDATA(QC_IN,QT_WKS)
 RDATA(IN_WKS_ADDRESS,	'i')
 RDATA(IN_WKS_VECTOR,	'w')
ERDATA(IN_WKS_RDATA_LENGTH)

COMMENT /*
	 * Length of WKS RDATA in bytes.
	 * DSYMS format isn't up to doing the arithmetic inline,
	 * so observe the following relationships:
	 *   MAX_BITS     = BITVECTOR_LENGTH * 8;
	 *   TOTAL_LENGTH = PROTOCOL_LENGTH + BITVECTOR_LENGTH.
	 */
CONST(IN_WKS_PROTOCOL_LENGTH,	1)
CONST(IN_WKS_MAX_BITS,		256)
CONST(IN_WKS_BITVECTOR_LENGTH,	32)
CONST(IN_WKS_TOTAL_LENGTH,	33)

COMMENT /*
	 * TXT data isn't supported yet because it's a bear to fit into
	 * our format character scheme.
	 */

COMMENT /*
	 * Largest number of fields in a single RDATA portion.  At present,
	 * the largest is SOA.  This is crosschecked in the rrfmt() code.
	 */
CONST(MAX_RDATA_FIELDS,		7)


COMMENT /* End of RFCDEF.D */
