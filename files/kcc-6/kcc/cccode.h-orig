/*	CCCODE.H - Pseudo-code opcode definitions
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.46, 24-May-1987
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.17, 8-Aug-1985
**
** Original version by David Eppstein / Stanford University / 24 May 85
*/

/*
** This file is used to define the PDP-10 pseudo-code instructions
** that KCC generates from a parse tree and stores in the peephole
** buffer.  It consists only of calls to the "opcode" macro;
** the macro arguments are:
**		opcode(iname, oname, flags)
**	where:
**		iname - Internal name of the opcode.  Always P_xxx.
**		oname - Output name; what CCOUT emits to the assembly language
**			file for this pseudo-code instruction.  This is also
**			what is shown in the .PHO debugging output, which is
**			why all codes have a string here even if they do
**			not correspond to an actual PDP-10 instruction.
**
**	The including program is responsible for defining "opcode" in an
** appropriate manner.  Currently CCGEN.H uses this to define all P_xxx
** symbols as enums, and CCDATA generates the various tables that the
** P_ values are used to index.
**
** The opcodes are in approximately alphabetical order, but note that
** any newly added ones should go at the end of the list unless
** everything using these definitions is recompiled.
**
** The PF_ flags and PRC_ values are defined in CCGEN.H.
** Note that PF_OPIMB is the sum of PF_OPI,PF_OPM,PF_OPB and is a common
** combination for most arithmetic/logical instructions.
*/


opcode(P_NOP,	"--", 0, PRC_ILL, b, c, d)	/* Keep this as zero */
opcode(P_CVALUE,"", 0, PRC_ILL, b, c, d)

opcode(P_ADD,	"ADD",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_ADJBP,	"ADJBP", 0,		PRC_RCHG, b, c, d)
opcode(P_ADJSP,	"ADJSP",PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_AND,	"AND",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_AOJ,	"AOJ",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_AOS,	"AOS",	PF_MEMCHG,	PRC_RSET, b, c, d)
opcode(P_ASH,	"ASH",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_ASHC,	"ASHC",	PF_EIMM,	PRC_DCHG, b, c, d)
opcode(P_CAI,	"CAI",	PF_EIMM,	PRC_RSAME, b, c, d)
opcode(P_CAM,	"CAM",	0,		PRC_RSAME, b, c, d)
opcode(P_DFAD,	"DFAD",	0,		PRC_DCHG, b, c, d)
opcode(P_DFDV,	"DFDV",	0,	PRC_DCHG, b, c, d)
opcode(P_DFIX,	"DFIX",	0,	PRC_DSET, b, c, d) /* Simop (clobbers A+1) */
opcode(P_DFMP,	"DFMP",	0,	PRC_DCHG, b, c, d)
opcode(P_DFSB,	"DFSB",	0,	PRC_DCHG, b, c, d)
opcode(P_DMOVE,	"DMOVE",0,		PRC_DSET, b, c, d)
opcode(P_DMOVEM,"DMOVEM",PF_MEMCHG,	PRC_DSAME, b, c, d)
opcode(P_DMOVN,	"DMOVN",0,		PRC_DSET, b, c, d)
opcode(P_DPB,	"DPB",	PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_DSNGL,	"DSNGL",0,	PRC_DSET, b, c, d) /* Simop (clobbers A+1) */
opcode(P_EQV,	"EQV",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_FADR,	"FADR",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_FDVR,	"FDVR",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_FIX,	"FIX",	0,		PRC_RSET, b, c, d)
opcode(P_FLTR,	"FLTR",	0,		PRC_RSET, b, c, d)
opcode(P_FMPR,	"FMPR",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_FSBR,	"FSBR",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_FSC,	"FSC",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_HLRE,	"HLRE",	0,		PRC_RSET, b, c, d)
opcode(P_HLRZ,	"HLRZ",	0,		PRC_RSET, b, c, d)
opcode(P_HRLM,	"HRLM",	PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_HRRE,	"HRRE",	0,		PRC_RSET, b, c, d)
opcode(P_HRRM,	"HRRM",	PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_HRRZ,	"HRRZ",	0,		PRC_RSET, b, c, d)
opcode(P_IBP,	"IBP",	PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_IDIV,	"IDIV",	PF_OPIMB,	PRC_DCHG_RSAME, b, c, d)
opcode(P_IDPB,	"IDPB",	PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_IFIW,	"IFIW",	0,		PRC_ILL, b, c, d)
opcode(P_ILDB,	"ILDB",	PF_MEMCHG,	PRC_RSET, b, c, d)
opcode(P_IMUL,	"IMUL",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_IOR,	"IOR",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_JRST,	"JRST",	PF_EIMM,	PRC_RSAME, b, c, d)
opcode(P_JUMP,	"JUMP",	PF_EIMM,	PRC_RSAME, b, c, d)
opcode(P_LDB,	"LDB",	0,		PRC_RSET, b, c, d)
opcode(P_LSH,	"LSH",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_LSHC,	"LSHC",	PF_EIMM,	PRC_DCHG, b, c, d)
opcode(P_MOVE,	"MOVE",	PF_OPI,		PRC_RSET, b, c, d)
opcode(P_MOVEM,	"MOVEM",PF_MEMCHG,	PRC_RSAME, b, c, d)
opcode(P_MOVM,	"MOVM",	PF_OPI,		PRC_RSET, b, c, d)
opcode(P_MOVN,	"MOVN",	PF_OPI,		PRC_RSET, b, c, d)
opcode(P_MOVS,	"MOVS",	PF_OPI,		PRC_RSET, b, c, d)
opcode(P_MUL,	"MUL",	PF_OPIMB,	PRC_DCHG_RSAME, b, c, d)
opcode(P_ORCM,	"ORCM",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_POP,	"POP",	PF_MEMCHG,	PRC_RCHG, b, c, d)
opcode(P_POPJ,	"POPJ",	0,		PRC_RCHG, b, c, d)
opcode(P_PTRCNV,"PTRCNV",0,		PRC_RCHG, b, c, d)	/* Simop */
opcode(P_PUSH,	"PUSH",	0,		PRC_RCHG, b, c, d)
opcode(P_PUSHJ,	"PUSHJ",PF_MEMCHG,	PRC_UNKNOWN, b, c, d)
opcode(P_ROT,	"ROT",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_SETCM,	"SETCM",PF_OPIMB,	PRC_RSET, b, c, d)
opcode(P_SETM,	"SETM",	PF_OPIMB,	PRC_RSET, b, c, d)
opcode(P_SETO,	"SETO",	PF_OPIMB,	PRC_RSET, b, c, d)
opcode(P_SETZ,	"SETZ",	PF_OPIMB,	PRC_RSET, b, c, d)
opcode(P_SKIP,	"SKIP",	0,		PRC_RSET, b, c, d)
opcode(P_SMOVE,	"SMOVE",PF_MEMCHG,	PRC_RSAME, b, c, d)	/* Simop */
opcode(P_SOJ,	"SOJ",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_SOS,	"SOS",	PF_MEMCHG,	PRC_RSET, b, c, d)
opcode(P_SUB,	"SUB",	PF_OPIMB,	PRC_RCHG, b, c, d)
opcode(P_SUBBP,	"SUBBP",0,	PRC_DCHG_RSAME, b, c, d) /* Simop (uses A+1) */
opcode(P_TDC,	"TDC",	0,		PRC_RCHG, b, c, d)
opcode(P_TDN,	"TDN",	0,		PRC_RSAME, b, c, d)
opcode(P_TDO,	"TDO",	0,		PRC_RCHG, b, c, d)
opcode(P_TDZ,	"TDZ",	0,		PRC_RCHG, b, c, d)
opcode(P_TLC,	"TLC",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TLN,	"TLN",	PF_EIMM,	PRC_RSAME, b, c, d)
opcode(P_TLO,	"TLO",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TLZ,	"TLZ",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TRC,	"TRC",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TRN,	"TRN",	PF_EIMM,	PRC_RSAME, b, c, d)
opcode(P_TRO,	"TRO",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TRZ,	"TRZ",	PF_EIMM,	PRC_RCHG, b, c, d)
opcode(P_TSC,	"TSC",	0,		PRC_RCHG, b, c, d)
opcode(P_UFLTR,	"UFLTR",0,		PRC_RCHG, b, c, d) /* Simop */
opcode(P_UIDIV,	"UIDIV",PF_OPI,		PRC_DCHG_RSAME, b, c, d) /* Simop */
opcode(P_XMOVEI,"XMOVEI",PF_EIMM,	PRC_RSET, b, c, d)	/* Unused?? */
opcode(P_XOR,	"XOR",	PF_OPIMB,	PRC_RCHG, b, c, d)
