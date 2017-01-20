/*	CCSYM.H - Declarations for KCC type and symbol table structures
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.126, 24-Sep-1987
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.8, 8-Aug-1985
**
** Original version split from cc.h / David Eppstein / 23 May 85
*/

#ifndef EXT
#define EXT extern
#endif

/* Must define these together here since they need each other */
#define SYMBOL struct symbol
#define TYPE struct type

/* Constant - # words in a symbol identifier */
#define IDENTWDS ((IDENTSIZE+sizeof(int)-1)/sizeof(int))

/* SYMBOL - Symbol table entry
**	All symbols have a name (Sname) and a "symbol class" (Sclass) which
**	determines the meaning of the rest of the structure.
*/
SYMBOL {
  struct {
    int s_class;		/* Symbol class - a SC_ value */
    int s_flags;		/* Symbol flags (SF_) */
    union {
	char s_ch[IDENTSIZE];	/* Symbol identifier string */
	int s_int[IDENTWDS];
    } Sid;			/* Copyable contents */

    union {		/* Use depends on Sclass */
	int s_int;		/* symbol value, misc uses */
	SYMBOL *s_sym;		/* symbol for label,static */
	struct {		/* Handy values for macro defs (SC_MACRO) */
	    signed char svm_npar;	/* # params (< 0 for special macs) */
	    unsigned char svm_parl;	/* # chars of param names in body */
	    unsigned short svm_len;	/* # total chars in body string */
	} sv_mac;
    } s_val;
    union {		/* Use depends on Sclass */
	TYPE *s_type;		/* C type pointer */
	int s_rwkey;		/* reserved word key */
	char *s_macptr;		/* macro pointer */
    } s_var;
  } Scontents;		/* Copyable contents (for struct assigns) */

    /* Primarily used for SC_TAG/SC_UTAG and SC_MEMBER/SC_ENUM;
    ** also used for linking SC_ARG/SC_RARG parameter lists.
    */
    SYMBOL *Ssmnext;		/* next structure member */
    union {
	SYMBOL *s_sym;		/* tag of structure that member belongs to */
	TYPE *s_typ;		/* Hidden prototype list */
    } s_tag;

    SYMBOL *Sprev;		/* ptr to prev symbol on glob/local list */
    SYMBOL *Snext;		/* ptr to next symbol on ditto */
    int Srefs;			/* # times referenced since created */
    SYMBOL *Snhash;		/* ptr to next sym on this hash chain */
};

/* Defs providing external access to structure fields, depending on
 * the kind of symbol.  No "s_" member should ever be referenced directly.
 */

/* Every symbol class uses these fields */
#define Sclass Scontents.s_class	/* Symbol class */
#define Sflags Scontents.s_flags	/* Symbol flags */
#define Sname Scontents.Sid.s_ch	/* Symbol name string */
#define Sidwds Scontents.Sid.s_int	/*        name in wds for speed */

/* Many (but not all) symbol classes use these fields */
#define Stype Scontents.s_var.s_type	/* C type of symbol */
#define Svalue Scontents.s_val.s_int	/* Misc uses */

/* Sclass == SC_UNDEF
**	When the lexer returns an identifier, it also points "csymbol" 
** to an entry in the symtab.  If the symbol did not already exist, it is
** created with class SC_UNDEF.
**	Only Sname and Sclass will be set.
**	Stype will be NULL and Svalue zero.
** Normally the parser changes this quickly to something else, or gets
** rid of the symbol.  The only known usages which keep SC_UNDEF symbols
** around are:
**	- A pair of dummy symbols at the start of the global & local sym lists.
**	- References to structures/unions that have not yet been defined.
**		Stype should indicate either TS_STRUCT or TS_UNION.
*/

/* Sclass == SC_RW (reserved word)
**	Stoken holds the token code to return when the lexer finds this word.
**	Skey contains a reserved-word token type key, one of the TKTY_ values.
*/
#define Stoken Scontents.s_val.s_int
#define Skey  Scontents.s_var.s_rwkey

/* Sclass == SC_MACRO (preprocessor macro definition)
**	Smacptr points to the macro body (a dynamically allocated string).
**		This may be NULL for special types of macros.
**	Smacnpar says how many arguments it takes, or (if < 0) indicates
**		a special built-in macro.  See CCPP for details.
**	Smacparlen is the # chars of param-names at start of body, if any.
**	Smaclen is the total # chars in the macro body string.
**		Smacparlen and Smaclen are 0 if Smacptr is NULL.
*/
#define Smacptr Scontents.s_var.s_macptr
#define Smacnpar   Scontents.s_val.sv_mac.svm_npar
#define Smacparlen Scontents.s_val.sv_mac.svm_parl
#define Smaclen    Scontents.s_val.sv_mac.svm_len

/* Sclass == SC_TAG, SC_UTAG - Structure, union, or enum tag
** Sclass == SC_MEMBER - Structure or union member (component)
** Sclass == SC_ENUM - Enum list member
**	See the discussion of structure tags and members farther on
**	for a thorough explanation.
*/
#define Ssmoff Svalue		/* Offset of member in struct/union */
#define Ssmtag s_tag.s_sym	/* Tag of entity that member belongs to */

/* Sclass == SC_TYPEDEF
**	This symbol is a "typedef name" and is lexically considered a
** type-specifier keyword.
**	Stype points to the C type which this symbol represents.
*/

/* Sclass == SC_EXTDEF, SC_EXTREF, SC_XEXTREF, SC_EXLINK
**	All of these classes refer to objects or functions with external
**	linkage.
** SC_EXTDEF - the obj or fun has been defined (file-scope only)
** SC_EXTREF - the obj or fun has been declared (file or block scope).
** SC_XEXTREF - same, but declaration has gone out of scope.
** SC_EXLINK - this file-scope object (never function) has been
**		declared with a "tentative definition".  If no definition
**		has been seen by end of the file, a zero initializer def is
**		generated for it.
**
**	Stype specifies the symbol's C type.
**	Smaplab specifies the actual label to use for this object/function
**		when emitting code.  Currently this is a SIXBIT value.
**	Shproto (SC_EXTDEF functions only) points to a hidden funct prototype.
**
** When parsing top-level declarations, SC_EXLINK is the default storage class
** when no explicit storage class is specified, as opposed to SC_EXTREF
** which indicates that "extern" was seen.  This allows KCC
** to distinguish between "extern" that is assumed, and "extern" that
** is stated.  See H&S 4.3.1 and 4.8.
**	In the assembler output file, SC_EXTDEF causes the generation
** of an INTERN, and SC_(X)EXTREF an EXTERN.  (SC_EXLINK should never be
** seen by that point).
**
** If the function was defined with an old-style declaration and no
** prototype already existed, then "Shproto" will be set to point to a
** "hidden" prototype constructed from the parameter declarations for the
** function.  This is used for comparison if a later prototype declaration
** for the function is seen, and for optional validity checking on calls.
*/
#define Smaplab Svalue		/* Mapped label name for assembler output */
#define Shproto	s_tag.s_typ	/* "Hidden" prototype for old-style fn def */

/* Sclass == SC_INTDEF, SC_INTREF, SC_INLINK
**	All of these classes refer to file-scope objects or functions
**	with internal linkage.
** SC_INTDEF - the obj or fun has been defined (file-scope "static").
** SC_INTREF - the funct (never obj) has been declared (file-scope "static").
** SC_INLINK - the object (never funct) is a tentative definition, just
**		as for SC_EXLINK.
**
**	The object (var or fun) has static extent and the symbol is not
** exported to the linker.  This can only happen if "static" is explicitly
** stated, and only at top-level (file scope).
**	Stype specifies the symbol's C type.
**	Smaplab is used for object/function labels just as for SC_EX*.
**	Shproto is used for functions just as for SC_EXTDEF.
*/

/* Sclass == SC_ISTATIC
**	This class is used for objects (never functions) that have
** static extent, block scope and no linkage.
**	Stype specifies the symbol's C type.
**	Smaplab someday will be used as for SC_IN* and SC_EX*.
**	Ssym points to a uniquely generated internal label symbol.
*/
#define Ssym   Scontents.s_val.s_sym

/* Sclass == SC_ARG, SC_RARG	- Function parameters
**	Stype specifies the parameter's C type.
**	Spmnext is a symbol pointer to the next parameter (or null if last one)
**	Svalue contains stack offset, similar to SC_AUTO except that it is
**		a positive number (if all args are 1 word, this is same as
**		argument number) and thus needs to be inverted for an actual
**		stack reference.
** The use of Spmnext overlays that of Ssmnext, but there is no conflict
** since tag and member idents can never be parameters.
** Note that Spmhead is not used in the symbol table, only in the temporary
** syms that CCDECL uses to parse declarators, and only for function type
** declarators in order to properly manage the scope of prototypes.
*/
#define Spmnext Ssmnext	/* Pointer to next parameter */
#define Spmhead	Ssmtag	/* Saved start of local sym block for params */

/* Sclass == SC_REGISTER
**	This isn't really used anywhere.  For the time being,
** the classes SC_RAUTO and SC_RARG remember whether the "register" keyword
** was specified with auto vars or function parameters.  This could be used
** to help the optimizer.
**	Someday this may be changed to use a SF_REGISTER flag and flush
** the use of SC_RARG and SC_RAUTO as distinct classes.
*/


/* Sclass == SC_AUTO, SC_RAUTO, SC_XAUTO, SC_XRAUTO
**  SC_AUTO describes an "auto" variable, within a block.  This is the
**	default storage class when parsing declarations within a block.
**  SC_RAUTO is the same but indicates that the "register" storage class
**	was given in the declaration.
**  SC_XAUTO and SC_XRAUTO are what SC_AUTO and SC_RAUTO are turned
**	into when parsing has left the block within which the variable
**	was declared.  That is, the declaration is no longer active.
**
**	Stype specifies the symbol's C type.
**	Svalue holds the stack offset value, in words.
*/


/* Sclass == SC_LABEL, SC_ULABEL (goto labels)
**
**	Ssym is used just as for SC_ISTATIC; it points to a label symbol
**		generated for use by goto statements.
*/
#define Ssym   Scontents.s_val.s_sym

/*	OVERLOADING CLASSES or NAME SPACES
**
** Certain types of symbols have a prefix character in their names
** as a hack to provide for "overloading classes" or "name spaces"
** [Ref H&S 4.2.4] [dpANS 3.1.2.3]
** These prefixes (none of which are legal as part of an input
** identifier) are:
**	+ - Structure member symbols	("component names")
**	^ - Structure/enum tag symbols	("struct, union, and enum tags")
**	@ - Goto label symbols		("statement labels")
** The other two name classes ("preprocessor macro names" and "other names")
** do not need a prefix, because the former are handled during preprocessing
** prior to compilation, and the latter are normal.  For reference, here
** is a list of the overloading classes as defined in H&S, with a code:
**   OC=	Overloading Class
**	M	Preprocessor macro names
**	L	Statement labels
**	T	Struct/union/enum tags
**	*	Structure component names (unique class for each structure)
**	-	Normal
*/

#define SPC_SMEM ('+')		/* * Structure/union members */
#define SPC_TAG  ('^')		/* T Structure/union/enum tags */
#define SPC_LABEL ('@')		/* L Statement labels */
#define SPC_MACDEF ('?')	/* Special for hiding the "defined" macro */
#define SPC_IDQUOT ('`')	/* Special for hiding quoted idents */
#define SPC_IAUTO ('<')		/* Special for hiding internal auto vars */

/* Symbol Classes (some relationship to "storage classes") */
			/* OC-----> Overloading Class */
			/*   vf --> v=var object, f=function */
enum symbolspec {
	SC_UNDEF,	/*	Undefined  - should be zero */
	SC_MACRO,	/* -	Macro name */
	SC_RW,		/* -	Reserved Word */
	SC_TYPEDEF,	/* -	Typedef name */
	SC_TAG,		/* T	Struct/union/enum tag */
	SC_UTAG,	/* T	Undefined struct/union/enum tag */
	SC_MEMBER,	/* * v	Struct/union member */
	SC_ENUM,	/* - v	Enumeration constant "member" */

			/*	Extent	Linkage	Scope	Def/Ref	*/
	SC_XEXTREF,	/* - vf	static	extern	-	reference */
	SC_EXTREF,	/* - vf	static	extern	file	reference */
	SC_INTREF,	/* - vf	static	intern	file	reference */
	SC_EXTDEF,	/* - vf	static	extern	file	definition */
	SC_INTDEF,	/* - vf	static	intern	file	definition */
	SC_EXLINK,	/* - v	static	extern	file	tentative def */
	SC_INLINK,	/* - v	static	intern	file	tentative def */
	SC_ISTATIC,	/* - v	static	-	block	definition */
	SC_ARG,		/* - v	auto	param	block	def		*/
	SC_RARG,	/* - v	auto	param	block	def (register)	*/
	SC_AUTO,	/* - v	auto	-	block	def		*/
	SC_RAUTO,	/* - v	auto	-	block	def (register)	*/
	SC_REGISTER,	/* - v	auto	-	block	def (register)	*/

	SC_LABEL,	/* L	Goto label */
	SC_ULABEL,	/* L	Undefined goto label */
	SC_ILABEL	/* L	Internal ($xxx) label. Not used in symtab. */
};

/* Symbol flags */
#define SF_LOCAL	01	/* Local symbol (not file scope) */
#define SF_XLOCAL	02	/* Local symbol no longer active */
#define SF_PROTOTAG	04	/* SC_TAG or SC_UTAG only: prototype scope */
#define SF_PARAMDECL	010	/* SC_ARG only: parameter declaration seen */
#define SF_SIDEFF	020	/* Side-effect (tag or enum) during parsing.
				** This flag is only set by CCDECL's pbase()
				** for dummy "base" symbol structures
				** and only used to detect null declarations.
				*/
#define SF_MACEXP	0100	/* SC_MACRO only: macro being expanded.
				** This is used to detect and suppress
				** recursive expansions.
				*/
#define SF_MACSHADOW	0200	/* Any class, indicates this symbol is
				** shadowed by a macro symbol (ie has the
				** same identifier).
				*/
#define SF_MACRO	040	/* SC_MACRO only: overloading class flag */
#define SF_MEMBER	01000	/* SC_MEMBER only: overloading class flag */
#define SF_TAG		02000	/* SC_TAG/SC_UTAG only: ditto */
#define SF_LABEL	04000	/* SC_LABEL/SC_ULABEL only: ditto */
#define SF_OVCLS (SF_MACRO|SF_MEMBER|SF_TAG|SF_LABEL)	/* All ov classes */


#if 0
#define SF_REGIS	02	/* User declared this as "register" */
#endif

/*
** Global vs Local symbols
**	Local symbols are kept on the "locsymbol" list and global ones on
** the "symbol" list.  Local symbols can have the following classes:
**	SC_ARG, SC_RARG			(function parameters)
**	SC_AUTO, SC_RAUTO, SC_ISTATIC	(auto, register, static)
**	SC_TAG, SC_UTAG, SC_ENUM, SC_MEMBER (struct/union/enum tags,enums,mems)
**	SC_LABEL, SC_ULABEL, SC_ILABEL	(goto labels)
**
**	When parsing enters a scope block, "beglsym()" is called to set
** a pointer to the start of the list of symbols local to that block.
** All symbols before this pointer will belong to outer blocks; all symbols
** after this pointer will belong to this block or inner blocks.
**	When parsing leaves a block, the symbols local to that block are
** still retained so that code generation can refer to them, but they are
** rendered inactive by setting the SF_XLOCAL (ex-local) flag.  This is
** done by having "compound()" call "endlsym()".  The findsym
** routine will never return a symbol which has this flag set.
** Thus, at any time, the symbols defined within any specific block (and
** not outer or inner ones) are represented by all of the local symbols
** following this remembered "head pointer" which do NOT have SF_XLOCAL set.
**
**	All local symbols -- ie everything on the locsymbol list -- are
** flushed completely when the code generator has finished dealing with
** a function's parse tree.  "ridlsym()" is the function called to do this.
** Note that SC_ARG and SC_RARG are active over the entire body of
** a function.
**
**	Note that SC_ILABEL symbols are never found in the symbol table
** itself.  These are generated by CCLAB and kept on a separate label list.
** Certain symbols may point to these "label symbols", however.
*/

/* TYPE - Type table entry
*/

TYPE {
    int Tspec;			/* Type specifier, set to a TS_ value */
    int Tflag;			/* Flags, plus size in bits (mask 0777) */
    union {
	int t_int;		/* Size in words, or # elements. */
	TYPE *t_subt;		/* Ptr to parameter list, if function */
    } t_v0;
    union {
	int t_int;
	TYPE *t_subt;		/* Subtype if not a basic type */
	SYMBOL *t_sym;		/* or tag name of struct or union */
    } t_v1;
    TYPE *Tnhash;		/* Pointer to next in hash chain */
};

/* Define generally used members for public consumption.
** Code should never refer to "t_" members directly.
*/
#define Tsize  t_v0.t_int	/* Size (in wds or elems) - all but TS_FUNCT */
#define Tsubt  t_v1.t_subt	/* Subtype - TS_FUNCT, TS_ARRAY, TS_PTR */

/* For all types:
**
** Tspec is set to a TS_ value.  These are specified by the "alltypemacro"
**	definition on the next page.
** Tflag is used to hold both TF_ flags as well as the # of bits occupied
**	by an object of scalar type.  The flags are set from:
**		(1) the flags specified in the "alltypemacro" definition, plus
**		(2) TF_CONST or TF_VOLATILE if so declared, plus
**		(3) TF_BYTE if the object is a bitfield OR is smaller than
**		 a word.  (This is the only machine-dependent flag).
**	Note that the size in bits is only meaningful for objects of
**	scalar type, and is only really used for objects of integral type.
** Tnhash serves to chain together all types which hash to the same
**	value.
**
** The other two members of a TYPE struct have varied uses which depend on
** the TS_ value in Tspec.  The most common usages are:
**
**	Tsize - normally represents the size of the object in terms of words.
**	Tsubt - holds pointer to a subtype, if any.
*/

/* Tspec == TS_VOID
**	Tflag == 0 (may be qualified)
**	Tsize == 0	(unused)
**	Tsubt == NULL	(unused)
*/

/* TS_FUNCT - Function returning Tsubt.
**	Tflag == 0 (cannot be qualified)
**	Tsubt - type of return value.
**	Tproto - if NULL, no prototype exists.  Otherwise, points to
**		the first node of a parameter list.
** Note that Tproto occupies the space normally used for Tsize; the latter
** interpretation is meaningless for a function.
** Functions without prototypes may still have a "hidden prototype" if
** an old-style definition was seen prior to any prototype declaration; this
** prototype list will be pointed to by Shproto of the identifier's symbol.
** See SC_EXTDEF.
*/
#define Tproto t_v0.t_subt	/* Ptr to prototype param list, if any */

/* TS_PARxxx - Parameter List "types"
**	The Tspec values TS_PARVOID, TS_PARINF, and TS_PARAM
** are not real types; they are used to link together parameter lists for
** function prototypes.
** 
**	Tspec - a TS_PARxxx value.
**	Tflag - 0 (unused).
**	Tproto - points to next node in parameter list. (reusing Tsize)
**	Tsubt - NULL for TS_PARVOID and TS_PARINF; otherwise (for TS_PARAM)
**		points to the unqualified type for this parameter.
**
** TS_PARVOID, if it exists, should be the only thing in a prototype list;
**	it indicates that the function takes no arguments.
** TS_PARINF, if it exists, should be the last thing in a prototype list;
**	it represents ellipsis terminator (",...")
** TS_PARAM is used for all normal parameters.
**	Note that the type pointed to is unqualified even if the parameter
**	identifier has a qualified type.  This is because all operations on
**	function prototypes (comparison, casting) use the unqualified type;
**	this does not prevent a function definition from using type
**	qualifiers on a parameter, because any reference to that parameter's
**	identifier within the function body will be given the qualified type
**	that the ident's Stype points to.
*/


/* TS_ARRAY - Array of Tsubt.
**	Tsubt - type of an array element.  This may be an array too.
**	Tsize is the # of elements (objects) in the array, each of which has
** the given subtype.  So the total size is Tsize times the size of
** the subtype.
**	If Tsize is 0, then the size of the array is unknown.  This can
** happen when the user declares something like "int foo[];"
** However, only the first dimension of a (possibly multi-dimensional)
** array can be left unspecified in this way, and obviously it will not
** work to do a sizeof on this array.
*/

/* TS_STRUCT, TS_UNION, TS_ENUM - Structure/Union/Enum of Tsmtag.
**	Tsmtag - points to the tag symbol for this type.  This re-uses the
**		space of "Tsubt".
**	Tsize is # of words in object.  If a struct/union is not yet
**		defined (i.e. Tsmtag->Sclass == SC_UTAG) then Tsize is 0
**		since the size is unknown.
** See the detailed description on the next page.
*/
#define Tsmtag t_v1.t_sym	/* TS_STRUCT or TS_UNION - tag pointer */

/* TS_PTR - Pointer to Tsubt.
**	Tsubt - type of object pointed to.
**	Tsize == 1 always (# wds in a pointer).
**
** It used to be the case that a type of TS_PTR used Tsize as an array
** indicator.  THIS IS NO LONGER TRUE, but for reference:
**	If Tsize 0, this was a normal TS_PTR to some object and the pointer
**		had the size PTRSIZE.
**	If Tsize non-zero, then this was a hybrid type that represented an
**		array name coerced into a pointer.  Tsize and Tsubt
**		were the same as the Tsize and Tsubt of the array in question.
**		The array type itself could be found by doing a findtype
**		of TS_ARRAY with the given Tsize and Tsubt.
** To repeat: TS_PTR is now just a normal type, and its Tsize always
** represents the pointer size (1 word).
*/

/* All arithmetic types (floating point and integral):
**	Tflag == Low-order bits have size in bits.  Many TF_ flags.
**	Tsize == size in words (if less than 1, is 1).
**	Tsubt == NULL (unused).
*/

/* Structure/Union/Enum tags and members
**
** If a type has Tspec TS_STRUCT, TS_UNION, or TS_ENUM, then it has no subtype
** pointer.  Instead, t_var is interpreted as "Tsmtag" - that is, a pointer
** to a tag symbol (Sclass SC_TAG).  In the following discussion, the word
** "structure" is understood to mean both "struct" and "union".
**
** Struct/Union/Enum types:
**	Tspec - TS_STRUCT, TS_UNION, or TS_ENUM.
**	Tsize - size of the structure, in words.  0 if structure not yet
**			defined.  INTSIZE if an enum type.
**	Tsmtag - pointer to the tag symbol for this type.
**
** Tag symbols:
**	Sclass - SC_TAG (or SC_UTAG if not yet defined).
**	Sname - the tag name, prefixed with SPC_TAG.  This will be
**		a unique internal name if the structure or enum list was
**		not named with a tag at definition time.
**	Stype - pointer to the C type.  This is in effect a backpointer
**		to the type specification described above.
**	Ssmnext - pointer to the first component symbol of this object.
**		This will be NULL if the tag is still undefined (SC_UTAG).
**		For a structure, the components are structure members
**		with Sclass SC_MEMBER.  For an enum, the components are
**		enum constants with Sclass SC_ENUM.
**
** Structure member symbols:
**	Each component of a structure is represented by an unique
** symbol table entry.  The members are linked together in order of
** definition.
**	Sclass - SC_MEMBER
**	Stype - C type of this member.
**	Ssmoff - offset from beginning of structure.
**		If positive, it is a word offset from start of struct.
**		If negative, it is a bitfield.  After making it positive again,
**			the low 12 bits are the P+S fields of a byte pointer,
**			and the remaining high bits are the word offset.
**	Ssmnext - pointer to next member (NULL if this is last one).
**	Ssmtag - pointer back to "parent" structure tag symbol.
**		The sole reason for the existence of Ssmtag is so that
**		it is possible to find out very quickly whether an
**		arbitrarily selected SC_MEMBER symbol does in fact
**		belong to a specific structure.
**
** Enum constant symbols:
**	Each component of an enum list is represented by an unique
** symbol table entry, linked together in order of definition.
** These are almost the same as SC_MEMBERs except that Svalue is used
** instead of Ssmoff.
**	Sclass - SC_ENUM
**	Stype - C type (always "int" for now).
**	Svalue - integer value of this enum constant.
**	Ssmnext - pointer to next component (NULL if this is last one).
**	Ssmtag - pointer back to "parent" tag symbol.
**		This is not really used at the moment but is kept for
**		consistency with SC_MEMBER and (someday) error messages.
**
** Tag, enum constant, and structure member symbols are treated just as
** regular variable symbols are.  They can be made global or local, and in
** particular can be "shadowed" by structure definitions in inner blocks,
** through use of the global/local symbol lists and the SF_XLOCAL flag.
**	Note that each structure member always has its own symbol cell, even
** though the identifier may duplicate that of a another structure's
** member.  They are distinguished by checking the "Ssmtag" pointer,
** which indicates the structure enclosing any particular member.
**	Enum constant symbols likewise are all unique to a particular tag,
** even though the language does not require this (in fact it requires
** that enum constant identifiers be treated in the same overloading class
** as regular variable identifiers!)  This is so the list structure won't
** be screwed up by redefinitions.  However, error messages will be
** generated whenever a duplicate enum constant definition is seen.
**
** There is a special situation where a struct/union definition might still
** be needed even after the tag (explicit or internal) would ordinarily
** have been flushed from the symbol table.  This is for a def within a
** function prototype (either def or ref), which
** results in a parameter "type" that cannot ever match another type in
** any function call or prototype comparison once the prototype scope is left.
** In order to do this, tags defined within prototype scope are flagged
** with SF_PROTOTAG, and ridlsym() avoids flushing those symbols; instead
** it hides them with SF_XLOCAL and moves them to the global list, there to
** reside forever (until a new file compilation is started).  It does not
** bother preserving the members of such tags, however, and sets Ssmnext
** to NULL.  This ensures that the TYPE node's Tsmtag reference will remain
** valid and unique for the rest of the file.
**
**	K&R "global" structure members are no longer allowed, as per H&S
** and ANSI.
*/

/* Type Specifiers */

/* Define moby macro defining all type specs.
**	typespec(enum_name, string, size_in_bits, flags)
**
**	The size_in_bits for TS_BITF (bitfields) is 1 here only so that
**	the tables will be initialized properly and the TF_BYTE flag set
**	for them.  In actuality their size varies (and the same is possible
**	for char).
**	The TF_BYTE flag is automatically set on startup for all types
**	that are valid objects smaller than a word.  It is also set
**	specially for TS_VOID, so that (void *) will be recognized as having
**	a byte-pointer representation even tho it has a zero size!
**
** WARNING!!!  If the ordering of this macro is changed, the values in
** the CONVTAB table in CCTYPE must also be changed!!!
*/
#define alltypemacro \
 /* Misc types (keep TS_VOID as zero for elegance) */\
    typespec(TS_VOID, "void",	 0,TF_BYTE)	/* (void) */\
    typespec(TS_FUNCT,"function",0,0)		/* Function (rets subtype) */\
 /* Aggregate types */\
    typespec(TS_ARRAY, "array",  0,0)		/* Array (of a subtype) */\
    typespec(TS_STRUCT,"struct", 0,TF_STRUCT)	/* Structure */\
    typespec(TS_UNION, "union",  0,TF_STRUCT)	/* Union */\
 /* Scalar misc types */\
    typespec(TS_PTR, "pointer",TGSIZ_PTR, TF_SCALAR)	/* Ptr (to subtype) */\
    typespec(TS_ENUM,"enum",   TGSIZ_ENUM,TF_SCALAR)	/* Enum */\
 /* Scalar Arithmetic types - Floating-point */\
    typespec(TS_FLOAT, "float", TGSIZ_FLOAT, TF_FLOAT) /* (float) */\
    typespec(TS_DOUBLE,"double",TGSIZ_DOUBLE,TF_FLOAT) /* (double) */\
    typespec(TS_LNGDBL,"lngdbl",TGSIZ_LNGDBL,TF_FLOAT) /* (long double) */\
 /* Scalar Arithmetic types - Integral */\
    typespec(TS_BITF, "bitf",    1,          TF_INTEG+TF_BITF)	/* bitfield */\
    typespec(TS_CHAR, "char",    TGSIZ_CHAR, TF_INTEG+TF_CHAR)	/* char  */\
    typespec(TS_SHORT,"short",   TGSIZ_SHORT,TF_INTEG)		/* short */\
    typespec(TS_INT,  "int",     TGSIZ_INT,  TF_INTEG)		/* int   */\
    typespec(TS_LONG, "long",    TGSIZ_LONG, TF_INTEG)		/* long  */\
    typespec(TS_UBITF,"u_bitf",  1,          TF_UINTEG+TF_BITF) \
    typespec(TS_UCHAR,"u_char",  TGSIZ_CHAR, TF_UINTEG+TF_CHAR) \
    typespec(TS_USHORT,"u_short",TGSIZ_SHORT,TF_UINTEG) \
    typespec(TS_UINT, "u_int",   TGSIZ_INT,  TF_UINTEG) \
    typespec(TS_ULONG,"u_long",  TGSIZ_LONG, TF_UINTEG)

/* Define values for Tspec */

enum typespecs {
#define typespec(ts,str,bsiz,fl) ts,
	alltypemacro		/* Expand */
#undef typespec
	TS_MAX,			/* # types; 1st non-existent typespec index */
	/* Additional Tspec vals for fn prototypes */
	TS_PARVOID=TS_MAX,	/* fn(void) - only at beg of proto list */
	TS_PARINF,		/* ", ..." - only at end of proto list */
	TS_PARAM		/* Normal parameter */
};


/* Definitions for Tflag - note that bitsize and flags must not overlap. */
#define tbitsize(t) ((t)->Tflag&0777)	/* Get size in bits for a type */
#define TF_CONST	01000	/* Type is a "const" object */
#define TF_VOLATILE	02000	/* Type is a "volatile" object */

#define TF_INTEG	010000	/* Integral type */
#define TF_FLOAT	020000	/* Floating-point type */
#define TF_SCALAR	040000	/* Scalar type */
#define TF_UNSIGN	0100000	/* Unsigned type */
#define TF_CHAR		0200000 /* Char type */
#define TF_BITF		0400000 /* Bitfield type */
#define TF_STRUCT	01000000 /* Struct or Union type */
#define TF_BYTE		02000000 /* Byte (non-word) type (MACH DEPENDENT) */

#define TF_SICONST	04000000  /* Struct/union with inner "const" */
#define TF_SIVOLAT	010000000 /* Struct/union with inner "volatile" */
#if SYS_CSI
#define TF_FORTRAN      0100000000 /* fortran attribute for functions */
#define TF_BLISS        0200000000 /* bliss   attrubute for functions */
#endif

/* Combos */
#define TF_QUALS (TF_CONST|TF_VOLATILE)	/* Type qualifiers */
#define TF_SIQUALS (TF_SICONST|TF_SIVOLAT)	/* Type qualifiers in struct */
#define TF_UINTEG (TF_INTEG+TF_UNSIGN)	/* to save space in alltypemacro */

/* Quick-check macros.  Try to avoid directly using the TF_ macros. */
#define tisqualif(t) ((t)->Tflag&TF_QUALS)
#define tisconst(t)  ((t)->Tflag&TF_CONST)
#define tisvolatile(t) ((t)->Tflag&TF_VOLATILE)
#define tisstructiconst(t) ((t)->Tflag&TF_SICONST)
#define tisstructivolat(t) ((t)->Tflag&TF_SIVOLAT)
#define tisanyvolat(t) ((t)->Tflag&(TF_VOLATILE|TF_SIVOLAT))
#define tisinteg(t)  ((t)->Tflag&TF_INTEG)
#define tisfloat(t)  ((t)->Tflag&TF_FLOAT)
#define tisarith(t)  ((t)->Tflag&(TF_INTEG+TF_FLOAT))
#define tisscalar(t) ((t)->Tflag&(TF_INTEG+TF_FLOAT+TF_SCALAR))
#define tischar(t)   ((t)->Tflag&TF_CHAR)
#define tisbitf(t)   ((t)->Tflag&TF_BITF)
#define tisunsign(t) ((t)->Tflag&TF_UNSIGN)
#define tissigned(t) (!tisunsign(t))
#define tisstruct(t) ((t)->Tflag&TF_STRUCT)	/* struct or union */
#define tisbyte(t)   ((t)->Tflag&TF_BYTE)	/* Byte (non-word) object */

/* Similar functions too complex for macros */
#define tischarpointer tischp	/* External name disambiguation */
#define tisbytepointer tisbyp
#define tischararray tischa
#define tisbytearray tisbya
extern int tischarpointer(), tisbytepointer(), tischararray(), tisbytearray();
extern int tispure();

/* Same macros, but with a Tspec argument. */
#define tspisinteg(ts)  (tfltab[ts]&TF_INTEG)
#define tspisfloat(ts)  (tfltab[ts]&TF_FLOAT)
#define tspisarith(ts)  (tfltab[ts]&(TF_INTEG+TF_FLOAT))
#define tspisscalar(ts) (tfltab[ts]&(TF_INTEG+TF_FLOAT+TF_SCALAR))
#define tspischar(ts)   (tfltab[ts]&TF_CHAR)
#define tspisunsigned(ts) (tfltab[ts]&TF_UNSIGN)

extern int tfltab[];	/* Flag table, kept in CCDATA */

/* Cast (Type Conversion) types (NODE.Ncast) */

#define allcastmacro \
    /* General-purpose cast types */\
	castspec(CAST_ILL,"ill")	/* convtab[] only: Illegal cast */\
	castspec(CAST_TRIV,"triv")	/* convtab[] only: types must be == */\
	castspec(CAST_NONE,"none")	/* No actual conversion needed */\
    /* Casts to Integer Type */\
	castspec(CAST_IT_IT,"it_it")	/* from Integer Type */\
	castspec(CAST_FP_IT,"fp_it")	/* from Floating-Point type */\
	castspec(CAST_EN_IT,"en_it")	/* from ENumeration type */\
	castspec(CAST_PT_IT,"pt_it")	/* from Pointer Type */\
    /* Casts to Floating-Point type */\
	castspec(CAST_FP_FP,"fp_fp")	/* from Floating-Point type */\
	castspec(CAST_IT_FP,"it_fp")	/* from Integer Type */\
    /* Casts to ENum type */\
	castspec(CAST_EN_EN,"en_en")	/* from ENumeration type */\
	castspec(CAST_IT_EN,"it_en")	/* from Integer Type */\
    /* Casts to Pointer Type */\
	castspec(CAST_PT_PT,"pt_pt")	/* from Pointer Type */\
	castspec(CAST_IT_PT,"it_pt")	/* from Integer Type */\
    /* Misc casts */\
	castspec(CAST_AR_PA,"ar_pa")	/* Array -> Ptr to 1st element */\
	castspec(CAST_FN_PF,"fn_pf")	/* Function -> Pointer to Function */\
	castspec(CAST_VOID,"void")	/* Any type to void type (discard) */


enum castspecs {
#define castspec(op,str) op,
	allcastmacro		/* Expand */
#undef castspec
	CAST_MAX		/* # of cast types */
};

/* Macro to generate a unique index for every possible type cast combo */
#define castidx(from,to) (((to)*TS_MAX)+(from))


/*
** Misc shared storage
*/

EXT SYMBOL
    *symbol,		/* Global symbol table head ptr */
    *csymbol,		/* Current symbol */
    *minsym;		/* minimum variable ptr (CC, CCSYM) */
EXT SYMBOL bytsym;	/* Symbol for $BYTE */

extern SYMBOL *htable[];	/* Symbol hash table (CCSYM, CCDATA) */
extern TYPE *ttable[];		/* Type hash table (CCSYM, CCDATA) */
extern TYPE types[];	/* Table of type structs (CCDUMP, CCSYM, CCDATA) */
			/* Eventually make this dynamic */
