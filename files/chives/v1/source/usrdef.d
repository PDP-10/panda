COMMENT /* USRDEF.D -- User interface definitions.
	 *
	 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
	 *
	 * Note that there is absolutely NO WARRANTY on this software.
	 * See the file COPYRIGHT.NOTICE for details and restrictions.
	 *
         * See DSYMS.HLP for information about the format of this file.
         *
         * Two rules should be observed when making changes:
         *
         *      1) If you change -anything- in this file,
         *         increment USRVER.
         *
         *      2) The first  word of the page header format
         *         must always be the version number.  At present this
         *         consists of two halfwords containing the version
         *         numbers of the user protocol and the domain
         *         protocol (as defined by USRVER and RFCVER).  No
         *         matter what changes are made to this protocol, it
         *         should be possible to determine whether or not the
         *         two participants agree on the protocol version by
         *         doing a fullword comparision against the first word
         *         of the message page.
         *
         * These two assumptions should suffice to allows the C code
         * and the assembler code to be sure they are running the same
         * version of the message protocol.
         */


COMMENT /* Constant definitions */

    COMMENT /* Protocol version number */
    CONST(USRVER, 3)

    COMMENT /* Special "QCLASS" to signal CTL operation */
    CONST(QC_CTL, 0177777)

    COMMENT /* States: Query, Response, Error, Wait */
    CONST(US_QRY, 066601)
    CONST(US_RSP, 066602)
    CONST(US_ERR, 066603)
    CONST(US_WAI, 066604)

    COMMENT /* Query flags:
             *  LDO = Local data only
             *  MBA = Must be authoritative
             *  EMO = Exact match only (don't use search rules)
             *  RBK = Resolve in background
             */
    CONST(UF_LDO,   0000001)
    CONST(UF_MBA,   0000002)
    CONST(UF_EMO,   0000004)
    CONST(UF_RBK,   0000010)

    COMMENT /* Flag values returned:
             *  AKA = CNAMEs were found, QNAME is a nickname
             */
    CONST(UF_AKA,   0400000)

    COMMENT /* Response error codes:
             *  OK  = No error.
             *  NAM = Name does not exist (authoritative answer)
             *  NRR = No RRs match name (authoritative answer)
             *  SYS = System error.
             *  NIY = Not Implemented Yet.
             *  TMO = Timeout while resolving query.
             *  RBK = Resolving in background.
             *  TMC = Too Many CNAMEs.
             *  ACK = ACKnowledgement (CTL messages only).
             *  ARG = Arguments invalid.
             *  DNA = Data Not Available.
             *  NOP = An error the resolver ignores (internal use only).
             *  ADM = Operation administratively forbidden.
             */
    CONST(UE_OK,   0)
    CONST(UE_NAM,  1)
    CONST(UE_NRR,  2)
    CONST(UE_SYS,  3)
    CONST(UE_NIY,  4)
    CONST(UE_TMO,  5)
    CONST(UE_RBK,  6)
    CONST(UE_TMC,  7)
    CONST(UE_ACK,  8)
    CONST(UE_ARG,  9)
    CONST(UE_DNA,  10)
    CONST(UE_NOP,  11)
    CONST(UE_ADM,  12)
    CONST(UE_MAX,  12)

    COMMENT /* CTL operations (QTYPE field); not all implemented yet:
             *  AYT = Are you there?  Just pings the server.
             *  ZON = New zone version. QNAME is zone name.
             *  BUT = Requests server to reboot itself.
             *  KIL = Requests server to suicide without reboot.
             *  INF = Requests server to write statistics file.
             *  CHK = Requests server to write checkpoint file.
             */
    CONST(UC_AYT,  1)
    CONST(UC_ZON,  2)
    CONST(UC_BUT,  3)
    CONST(UC_KIL,  4)
    CONST(UC_INF,  5)
    CONST(UC_CHK,  6)
    CONST(UC_MAX,  6)


COMMENT /* Structure definitions */

COMMENT /* Page header format */
BSTRUCT(u_page_header)
    DHALF ( verrfc	)
    DHALF ( verusr	)
    DWORD ( state       )
    DHALF ( pag_count   )
    DHALF ( pag_this    )
    DWORD ( stmp1       )
    DWORD ( stmp2       )
ESTRUCT(u_page_header,U_PHSIZE)

COMMENT /* Message header format (page 0 only) */
BSTRUCT(u_data_header)
    DHALF ( flags       )
    DHALF ( qname       )
    DHALF ( qtype       )
    DHALF ( qclass      )
    DHALF ( rcode       )
    DHALF ( rname       )
    DWORD ( count       )
ESTRUCT(u_data_header,U_DHSIZE)


COMMENT /* Message RR header format */
BSTRUCT(u_rr_header)
    DWORD ( length      )
    DHALF ( type        )
    DHALF ( class       )
    DWORD ( ttl         )
ESTRUCT(u_rr_header,U_RHSIZE)

COMMENT /* End of USRDEF.D */
