@make [Manual]

@commandstring(InstrSection = "@tabclear@tabset[.5 in, 3.0 in]")
@form(Instr = "@*@\@Parm[name]@\")
@form(BInstr ="@*@\@Parm[name]@+[*]@\")

@titlepage[
Title = "Revised@ Internal@ Design@ of@ Spice@ Lisp",
Author = "Skef@ Wholey
Scott@ E.@ Fahlman
Joseph@ Ginder",
Cruft = "@Begin(Heading)
DRAFT
@End(Heading)",
Number = "S026 [Revised]",
Index = "Lisp",
File = "CMUC::<Wholey.Australia>Revguts.Mss"
]

@heading [Acknowledgments]

The following people have been contributors to this and earlier versions of the
design of the Spice Lisp instruction set: Guy L. Steele Jr., Gail E. Kaiser,
Walter van Roggen, Neal Feinberg, Jim Large, and Rob MacLachlan.  The original
instruction set was loosely based on the MIT Lisp Machine instruction set.

The FASL file format was designed by Guy L. Steele Jr. and Walter van Roggen,
and the appendix on this subject is their document with very few modifications.

@chapter [Introduction]

@section [Scope and Purpose]

NOTE: This document describes a new implementation of Spice Lisp as it is to be
implemented on the PERQ, running the Spice operating system, Accent.  This new
design is undergoing rapid change, and for the present is not guaranteed to
accurately describe any past, present, or future implementation of Spice Lisp.
All questions and comments on this material should be directed to Skef Wholey
(Wholey@@CMU-CS-C).

This document specifies the instruction set and virtual memory architecture of
the PERQ Spice Lisp system.  This is a working document, and it will change
frequently as the system is developed and maintained.  If some detail of the
system does not agree with what is specified here, it is to be considered a
bug. 

Spice Lisp will be implemented on other microcodable machines, and
implementations of Common Lisp based on Spice Lisp exist for conventional
machines with fixed instructions sets.  These other implementations are very
different internally and are described in other documents.

@section [Notational Conventions]
@index [Bit numbering]
@index [Byte numbering]
Spice Lisp objects are 32 bits long.  The low-order bit of each word is
numbered 0; the high-order bit is numbered 31.  If a word is broken into
smaller units, these are packed into the word from right to left.  For example,
if we break a word into bytes, byte 0 would occupy bits 0-7, byte 1 would
occupy 8-15, byte 2 would occupy 16-23, and byte 3 would occupy 24-31.  In
these conventions we follow the conventions of the VAX; the PDP-10 family
follows the opposite convention, packing and numbering left to right.

All Spice Lisp documentation uses decimal as the default radix; other radices
will be indicated by a subscript (as in 77@-[8]) or by a clear statement of
what radix is in use.

@chapter [Data Types and Object Formats]

@section [Lisp Objects]
@index [Lisp objects]

Lisp objects are 32 bits long.  They come in 32 basic types, divided
into three classes: immediate data types, pointer types, and
forwarding pointer types.  The storage formats are as follows:

@index [Immediate object format]
@index [Pointer object format]
@begin [verbatim, group]

@b[Immediate Data Types:]
 31           27 26                                                   0
------------------------------------------------------------------------
| Type Code (5) |              Immediate Data (27)                     |
------------------------------------------------------------------------

@b[Pointer and Forwarding Types:]
 31           27 26            25 24                     1            0
------------------------------------------------------------------------
| Type Code (5) | Space Code (2) |    Pointer (24)        | Unused (1) |
------------------------------------------------------------------------
@end [verbatim]

@section [Table of Type Codes]
@index [Type codes]

@begin [verbatim, group]

Code	Type		Class		Explanation
----    ----            -----           -----------
0	Misc		Immediate	Trap object, stacks, system tables
1	Bit-Vector	Pointer		Vector of bits
2	Integer-Vector	Pointer		Vector of integers
3	String		Pointer		Character string
4	Bignum		Pointer		Bignum
5	Long-Float	Pointer		Long float
6	Complex		Pointer		Complex number
7	Ratio		Pointer		Ratio
8	General-Vector	Pointer		Vector of Lisp objects
9	Function	Pointer		Compiled function header
10	Array		Pointer		Array header
11	Symbol		Pointer		Symbol
12	List		Pointer		Cons cell
13-15	Unused
16	+ Fixnum	Immediate	Fixnum >= 0
17	- Fixnum	Immediate	Fixnum < 0
18	+ Short-Float	Immediate	Short float >= 0
19	- Short-Float	Immediate	Short float < 0
20	Character	Immediate	Character object
21	Values-Marker	Immediate	Multiple values marker
22	Call-Header	Immediate	Control stack call frame header
23	Catch-Header	Immediate	Control stack catch frame header
24	Catch-All	Immediate	Catch-All object
25	GC-Forward	Forward		Object in newspace of same type
26-31	Unused
@end [verbatim]

@section [Table of Space Codes]
@index [Space codes]

@begin [verbatim, group]

Code	Space		Explanation
----    -----           -----------
0	Dynamic-0	Storage normally garbage collected, space 0.
1	Dynamic-1	Storage normally garbage collected, space 1.
2	Static		Permanent objects, never moved or reclaimed.
3	Read-Only	Objects never moved, reclaimed, or altered.
@end [verbatim]

@section [Immediate Data Type Descriptions]

@begin [description]
@index [Misc type codes]
@begin [multiple]
Misc@\Reserved for assorted internal values.  Bits 25-26 specify a sub-type
code.

@begin [description]
@index [Misc-Trap]
@index [Trap code]
0 Trap @\Illegal object trap.  If you fetch one of these, it's an error
except under very specialized conditions.  Note that a word of all zeros
is of this type, so this is useful for trapping references to
uninitialized memory.  This value also is used in symbols to flag an
undefined value or definition.

@index [Misc-Control-Stack-Pointer]
@index [Control-Stack pointer]
1 Control-Stack-Pointer @\The low 25 bits are a pointer into the control stack.
This is a word pointer that points to the proper virtual memory address.
Pointers of this form are returned by certain system routines for use by
debugging programs.

@index [Misc-Binding-Stack-Pointer]
@index [Binding-Stack pointer]
2 Binding-Stack-Pointer @\The low 25 bits are a pointer into the binding stack.
This is a word pointer that points to the proper virtual memory address.
Pointers of this form are returned by certain system routines for use by
debugging programs.

@index [Misc-System-Table-Pointer]
@index [System table pointer]
@index [System table space]
@index [Accent message space]
3 System-Table-Pointer @\The low 25 bits are a pointer into an area of memory
used for system tables.  This is a word pointer into an area of the address
space reserved for data sent and received in Accent messages.
@end[description]
@end[multiple]

@index [Fixnum format]
Fixnum@\A 28-bit two's complement integer.  The sign bit is stored as part of
the type code.

@index [Short-Float format]
@index [Flonum formats]
@index [Floating point formats]
Short-Float@\As with fixnums, the sign bit is stored as part of the type code.
The format of short floating point number can be viewed as follows:
@begin [verbatim, group]
 31           28     27     26        19 18               0
------------------------------------------------------------
| Type code (4) | Sign (1) |  Expt (8)  |   Mantissa (19)  |
------------------------------------------------------------
@end [verbatim]
The sign of the mantissa is moved to the left so that these flonums can
be compared just like fixnums.  The exponent is the binary two's
complement exponent of the number, plus 128; then, if the mantissa is
negative, the bits of the exponent field are inverted.  The mantissa is
a 21-bit two's complement number with the sign moved to bit 27 and the
leading significant bit (which is always the complement of the sign bit
and hence carries no information) stripped off.  The short flonum
representing 0.0 has 0's in bits 0 - 27.  It is illegal for the sign bit
to be 1 with all the other bits equal to 0.  This encoding gives a range
of about 10@+[-38] to 10@+[+38] and about 6 digits of accuracy.  Note
that long-flonums are available for those wanting more accuracy, but
they are less efficient to use because they generate garbage that must be
collected later.

@index [Character object]
Character@\A character object holding a character code, control bits, and font
in the following format:
@begin [verbatim, group]
 31           27 26        24 23      16 15       8 7        0
---------------------------------------------------------------
| Type code (5) | Unused (3) | Font (8) | Bits (8) | Code (8) |
---------------------------------------------------------------
@end [verbatim]

@index [Values-Marker]
Values-Marker@\Used to mark the presence of multiple values on the stack.  The
low 16 bits indicate how many values are being returned.  Note then, that only
65535 values can be returned from a multiple-values producing form.  These are
pushed in order, then the Values-Marker is pushed.

@index [Call Header format]
@index [Call-Header]
@begin [multiple]
Call-Header@\Marks the start of each call frame on the control stack.  The
low-order 27 bits are used as a place to stash information for certain special
kinds of calls.

For a normal function call, as created by the CALL or CALL-0
instruction, the low 27 bits are always 0.

Bit 22, if 1, indicates an ``escape to macro'' call frame, created when a
macro-instruction cannot be completed entirely within the microcode.  In
this case, bits 16-17 indicate where the result is supposed to go (see section
@ref[Escape]).

Bit 21, if 1, indicates a call frame that will accept multiple values to
be returned.  Such frames are created by Call-Multiple, and cause Return
to take certain special actions.  See section @ref [return] for details.

Bits 22 and 21 are mutually exclusive.  It is undefined what
happens when both of these are on at once.
@end [multiple]

@index [Catch-Frame]
@index [Catch header format]
Catch-Header@\Marks a catch frame on the control stack.  If bit 21 is on, this
indicates that the catching form will accept multiple values.  See section
@ref[Catch] for details.

@index [Catch-All object]
Catch-All@\Object used as the catch tag for unwind-protects.  Special things
happen when a catch frame with this as its tag is encountered during a throw.
See section @ref[Catch] for details.
@end [description]

@section [Pointer-Type Objects and Spaces]
@index [Pointer object format]
@index [Virtual memory]

Each of the pointer-type lisp objects points into a different space in virtual
memory.  There are separate spaces for Bit-Vectors, Symbols, Lists, and so on.
The 5-bit type-code provides the high-order virtual address bits for the
object, followed by the 2-bit space code, followed by the 25-bit pointer
address.  This gives a 31-bit virtual address to a 32-bit word; since the PERQ
is a word-addressed machine, the low-order bit will be 0, and under Accent, the
high order bit will be 0 (because the operating system lives in the upper half
of the address space).  This leaves us with a 30-bit virtual address.  In
effect we have carved a 30-bit space into a fixed set of 24-bit subspaces, not
all of which are used.

@index [Space codes]
The space code divides each of the type spaces into four sub-spaces,
as shown in the table above.  At any given time, one of the dynamic
spaces is considered newspace, while the other is oldspace.  The
garbage collector continuously moves accessible objects from oldspace
into newspace.  When oldspace contains no more accessible objects it
is considered empty.  A ``flip'' can then be done, turning the old
newspace into the new oldspace.  All type-spaces are flipped at once.
Allocation of new dynamic objects always occurs in newspace.

@index [Static space]
@index [Read-only space]
Optionally, the user (or system functions) may allocate objects in
static or read-only space.  Such objects are never reclaimed once they
are allocated -- they occupy the space in which they were initially
allocated for the lifetime of the Lisp process.  The advantage of
static allocation is that the GC never has to move these objects,
thereby saving a significant amount of work, especially if the objects
are large.  Objects in read-only space are static, in that they are
never moved or reclaimed; in addition, they cannot be altered once
they are set up.  Pointers in read-only space may only point to
read-only or static space, never to dynamic space.  This saves even
more work, since read-only space does not need to be scavenged, and
pages of read-only material do not need to be written back onto the
disk during paging.

Objects in a particular type-space will contain either pointers to
garbage-collectable objects or words of raw non-garbage-collectable bits, but
not both.  Similarly, a space will contain either fixed-length objects or
variable-length objects, but not both.  A variable-length object always
contains a 24-bit length field right-justified in the first word, with
the fixnum type-code in the high-order four bits.  The remaining four
bits can be used for sub-type information.  The length field gives the
size of the object in 32-bit words, including the header word.  The
garbage collector needs this information when the object is moved, and
it is also useful for bounds checking.

The format of objects in each space are as follows:

@begin [description]
@index [Symbol]
@index [Value cell]
@index [Definition cell]
@index [Property list cell]
@index [Plist cell]
@index [Print name cell]
@index [Pname cell]
@index [Package cell]
Symbol@\Each symbol is represented as a
fixed-length block of boxed Lisp cells.  The number of cells
per symbol is 5, in the following order:
@begin [verbatim, group]
0  Value cell for shallow binding.
1  Definition cell: a function or list.
2  Property list: a list of attribute-value pairs.
3  Print name: a string.
4  Package: the obarray holding this symbol.
@end [verbatim]

@index [List cell]
List@\A fixed-length block of two boxed Lisp cells, the CAR and the CDR.

@index [General-Vector format]
@index [G-Vector format]
@index [Vector format]
General-Vector@\Vector of lisp objects, any length.  The first word is a fixnum
giving the number of words allocated for the vector (up to 24 bits).  The
highest legal index is this number minus 2.  The second word is vector entry 0,
and additional entries are allocated contiguously in virtual memory.  General
vectors are sometimes called G-Vectors.  (See section @ref[Vectors] for further
details.)

@index [Integer-Vector format]
@index [I-Vector format]
@index [Vector format]
Integer-Vector@\Vector of integers, any length.  The 24 low bits of the first
word give the allocated length in 32-bit words.  The low-order 28 bits of the
second word gives the length of the vector in entries, whatever the length of
the individual entries may be.  The high-order 4 bits of the second word
contain access-type information that yields, among other things, the number of
bits per entry.  Entry 0 is right-justified in the third word of the vector.
Bits per entry will normally be powers of 2, so they will fit neatly into
32-bit words, but if necessary some empty space may be left at the high-order
end of each word.  Integer vectors are sometimes called I-Vectors.  (See
section @ref[Vectors] for details.)

@index [Bit-Vector format]
@index [Vector format]
Bit-Vector@\Vector of bits, any length.  Bit-Vectors are represented in a form
identical to I-Vectors, but live in a different space for efficiency reasons.

@index [Bignum format]
@label [Bignums]
Bignum@\Bignums are infinite-precision integers, represented in a format
identical to I-Vectors.  Each bignum is stored as a series of 8-bit bytes, with
the low-order byte stored first.  The representation is two's complement, but
the sign of the number is redundantly encoded in the subtype field of the
bignum: positive bignums are sub-type 0, negative bignums sub-type 1.  The
access-type code is always 8-Bit.

@index [Long-Flonum format]
@index [Flonum formats]
@index [Floating point formats]
Long-Float@\Long floats are stored as two consecutive words of bits, in the
following format:
@begin [verbatim, group]
      31      30               20 19                         0
---------------------------------------------------------------
|  Sign (1)  |   Exponent (11)   |        Fraction (20)       |
---------------------------------------------------------------
|                       Fraction (32)                         |
---------------------------------------------------------------
@end [verbatim]
The exponent is biased by 1023.  Exponents of 0 and 2047 are reserved.  The
most significant bit of the fraction is stripped off since it is always the
complement of the sign bit, and carries no information.

@index [Ratio format]
Ratio@\Ratios are stored as two consecutive words of Lisp objects, which should
both be integers.

@index [Complex number format]
Complex@\Complex numbers are stored as two consecutive words of Lisp objects,
which should both be numbers.

@index [Array format]
Array@\This is actually a header which holds the accessing information and
other information about the array.  The actual array contents are held in a
vector (either an I-Vector or G-Vector) pointed to by an entry in
the header.  The header is identical in format to a G-Vector.  For
details on what the array header contains, see section @ref[Arrays].

@index [String format]
String@\A vector of bytes.  Identical in form to I-Vectors with the access type
always 8-Bit.  However, instead of accepting and returning fixnums, string
accesses accept and return character objects.  Only the 8-bit code field is
actually stored, and the returned character object always has bit and font
values of 0.

@index [Function object format]
Function @\A compiled Spice Lisp function consists of both lisp objects and raw
bits for the code.  The Lisp objects are stored in the Function space in a
format identical to that used for general vectors, with a 24-bit length field
in the first word.  This object contains assorted parameters needed by the
calling machinery, a pointer to an 8-bit I-Vector containing the compiled byte
codes, a number of pointers to symbols used as special variables within the
function, and a number of lisp objects used as constants by the function.  For
details of the code format and definitions of the byte codes, see section
@ref[Macro-codes].
@end [description]

@section [Forwarding Pointers]
@index [Forwarding pointers]

@begin [description]
@index [GC-Forward pointer]
GC-Forward@\When a data structure is transported into newspace, a GC-Forward
pointer is left behind in the first word of the oldspace object.  This points
to the same type-space in which it is found.  For example, a GC-Forward in
G-Vector space points to a structure in the G-Vector newspace.  GC-Forward
pointers are only found in oldspace.
@end [description]

@section [System and Stack Spaces]
@index [System table space]
@index [Stack spaces]
@index [Control stack space]
@index [Binding stack space]
@index [Special binding stack space]

The virtual addresses below 08000000@-[16] are not occupied by Lisp objects,
since Lisp objects with type code 0 are immediate objects.  Some of this space
is used for other purposes by Lisp.  The current allocations are as follows:

@Begin[verbatim, group]
Address (base 16)            Use
-------------------          ---
00000000 - 01FFFFFF          Microcode tables
02000000 - 03FFFFFF          Control Stack
04000000 - 05FFFFFF          Binding Stack
06000000 - 07FFFFFF          System tables
@End[verbatim]

Microcode tables for a given process are never accessed by Lisp-level code from
that process (the SAVE function looks at the allocation table of another Lisp
process).  These tables contain allocation information for the various spaces
and pointers to functions that are called when escapes to macrocode are done.
There are currently two microcode tables:
@begin[verbatim, group]
Address (base 16)            Use
-------------------          ---
00010000 - 00010100          Allocation table
00020000 - 00020100          Escape function table
@end[verbatim]
The format of the allocation table is described in chapter @ref[Alloc-Chapter],
and the format of the escape function table is described in section
@ref[Escape].

The control stack grows upward (toward higher addresses) in memory, and is a
framed stack.  It contains only general Lisp objects (with some random things
encoded as fixnums or Misc codes).  Every object pointed to by an entry on this
stack is kept alive.  The frame for a function call contains an area for the
function's arguments, an area for local variables, a pointer to the caller's
frame, and a pointer into the binding stack.  The frame for a Catch form
contains similar information.  The precise
stack format can be found in chapter @ref[Runtime].

The special binding stack also grows upward.  This stack is used to hold
previous values of special variables that have been bound.  It grows and
shrinks with the depth of the binding environment, as reflected in the
control stack.  This stack contains symbol-value pairs, with only boxed
Lisp objects present.

System table space is used to interface Lisp to the operating system.  This is
the only part of the address space that contains invalid memory, so all
Accent messages received will appear in this space.  Since files are sent and
received in messages, all files will be mapped into this space.  Data in system
table space may be accessed and altered by the instructions described in section
@ref[System-Hacking-Instructions].

@index [Perq quadword alignment]
@index [Quadword alignment]
There are significant performance advantages to be gained by aligning all
objects on the PERQ's ``quad-word'' (64-bit) boundaries.  This happens
automatically for conses, long-floats, complex numbers, and ratios, which are
all two Lisp-words long.  For all other pointer-type objects, the allocator
makes sure that the object starts on a quad-word boundary, wasting a word with
a Misc-Trap code if necessary.  Thus, every pointer (except possibly for
stack and system area pointers) will have its two low-order bits 0.  User-level
code should never have to notice this distinction.

@section [Vectors and Arrays]
@label [Vectors]
@index [Vectors]

Common Lisp arrays can be represented in a few different ways in Spice Lisp --
different representations have different performance advantages.  Simple
general vectors, simple vectors of integers, and simple strings are basic Spice
Lisp data types, and access to these structures is quicker than access to
non-simple (or ``complex'') arrays.  However, all multi-dimensional arrays in
Spice Lisp are complex arrays, so references to these is always through a
header structure.

@subsection [General Vectors]
@index [General-Vector format]

G-Vectors contain Lisp objects.  The format is as follows:

@begin [verbatim, group]
------------------------------------------------------------------
|  Fixnum code (4) | Subtype (4) |   Allocated length (24)       |
------------------------------------------------------------------
|  Vector entry 0   (Additional entries in subsequent words)     |
------------------------------------------------------------------
@end [verbatim]

Note that the subtype field overlaps the type field -- this means that the
subtype can change the sign bit of the fixnum.  The first word of the vector is
a header indicating its length; the remaining words hold the boxed entries of
the vector, one entry per 32-bit word.  The header word is of type fixnum.  It
contains a 3-bit subtype field, which is used to indicate several special types
of general vectors.  At present, the following subtype codes are defined:

@index [DEFSTRUCT]
@index [Hash tables]
@begin [description]
0 @\Normal.  Used for assorted things.

1 @\Named structure created by DEFSTRUCT, with type name in entry 0.

2 @\EQ Hash Table, last rehashed in dynamic-0 space.

3 @\EQ Hash Table, last rehashed in dynamic-1 space.

4 @\EQ Hash Table, must be rehashed.
@end [description]

Following the subtype is a 24-bit field indicating how many 32-bit words are
allocated for this vector, including the header word.  Legal indices into the
vector range from zero to the number in the allocated length field minus 2,
inclusive.  The index is checked on every access to the vector.  Entry 0 is
stored in the second word of the vector, and subsequent entries follow
contiguously in virtual memory.

Once a vector has been allocated, it is possible to reduce its length by using
the Shrink-Vector instruction, but never to increase its length, even back to
the original size, since the space freed by the reduction may have been
reclaimed.  This reduction simply stores a new smaller value in the length
field of the header word.

It is not an error to create a vector of length 0, though it will always be an
out-of-bounds error to access such an object.  The maximum possible length for
a general vector is 2@+[24]-2 entries, and that is only possible if no other
general vectors are present in the space.

@index [Function object format]
@index [Array format]
Objects of type Function and Array are identical in format to
general vectors, though they have their own spaces.  In both cases, only 0 is
currently used in the sub-type field of the header word.

@subsection [Integer Vectors]
@index [Integer-Vector format]

I-Vectors contain unboxed items of data, and their format is more complex.  The
data items come in a variety of lengths, but are of constant length within a
given vector.  Data going to and from an I-Vector are passed as Fixnums, right
justified.  Internally these integers are stored in packed form, filling 32-bit
words without any type-codes or other overhead.  The format is as follows:

@begin [verbatim, group]
----------------------------------------------------------------
| Fixnum code (4) | Subtype (4) |  Allocated length (24)       |
----------------------------------------------------------------
| Access type (4) | Number of entries (28)                     |
----------------------------------------------------------------
|                                      Entry 0 right justified |
----------------------------------------------------------------
@end [verbatim]

Note that the subtype field overlaps the type field -- this means that the
subtype can change the sign bit of the fixnum.  The first word of an I-Vector
contains the Fixnum type-code in the top 4 bits, a 4-bit subtype code in the
next four bits, and the total allocated length of the vector (in 32-bit words)
in the low-order 24 bits.  At present, the following subtype codes are defined:
@begin [description]
0 @\Normal.  Used for assorted things.

1 @\Code.  This is the code-vector for a function object.
@end [description]

The second word of the vector is the one that is looked at every
time the vector is accessed.  The low-order 28 bits of this word
contain the number of valid entries in the vector, regardless of how
long each entry is.  The lowest legal index into the vector is always
0; the highest legal index is one less than this number-of-entries
field from the second word.  These bounds are checked on every access.
Once a vector is allocated, it can be reduced in size but not increased.
The Shrink-Vector instruction changes both the allocated length field
and the number-of-entries field of an integer vector.

@index [Access-type codes]
The high-order 4 bits of the second word contain an access-type code
which indicates how many bits are occupied by each item (and therefore
how many items are packed into a 32-bit word).  The encoding is as follows:
@begin [verbatim, group]
0   1-Bit			8   Unused
1   2-Bit			9   Unused
2   4-Bit			10  Unused
3   8-Bit			11  Unused
4   16-Bit			12  Unused
5   Unused			13  Unused
6   Unused			14  Unused
7   Unused			15  Unused
@end [verbatim]

In I-Vectors, the data items are packed into the third and subsequent words of
the vector.  Item 0 is right justified in the third word, item 1 is to its
left, and so on until the allocated number of items has been accommodated.  All
of the currently-defined access types happen to pack neatly into 32-bit words,
but if this should not be the case, some unused bits would remain at the left
side of each word.  No attempt will be made to split items between words to use
up these odd bits.  When allocated, an I-Vector is initialized to all 0's.

As with G-Vectors, it is not an error to create an I-Vector of length 0, but it
will always be an error to access such a vector.  The maximum possible length
of an I-Vector is 2@+[28]-1 entries or 2@+[24]-3 words, whichever is smaller.

@index [String format]
Objects of type String are identical in format to I-Vectors, though they have
their own space.  Strings always have subtype 0 and access-type 3 (8-Bit).
Strings differ from normal I-Vectors in that the accessing instructions accept
and return objects of type Character rather than Fixnum.

@index [Bignum format]
Bignums are also identical in format and operation to I-Vectors, though they
may also be operated on directly by microcoded routines.  For details of the
currently-defined sub-types and their access-codes, see section @ref[Bignums].

@subsection [Arrays]
@label [Arrays]
@index [Arrays]

An array header is identical in form to a G-Vector.  Like any G-Vector, its
first word contains a fixnum type-code, a 4-bit subtype code, and a 24-bit
total length field (this is the length of the array header, not of the vector
that holds the data).  At present, the subtype code is always 0.  The entries
in the header-vector are interpreted as follows:

@index [Array header format]
@begin [description]
0 Data Vector @\This is a pointer to the I-Vector, G-Vector, or string that
contains the actual data of the array.  In a multi-dimensional array, the
supplied indices are converted into a single 1-D index which is used to access
the data vector in the usual way.

1 Number of Elements @\This is a fixnum indicating the number of elements for
which there is space in the data vector.

2 Fill Pointer @\This is a fixnum indicating how many elements of the data
vector are actually considered to be in use.  Normally this is initialized to
the same value as the Number of Elements field, but in some array applications
it will be given a smaller value.  Any access beyond the fill pointer is
illegal.

3 Displacement @\This fixnum value is added to the final code-vector index
after the index arithmetic is done but before the access occurs.  Used for
mapping a portion of one array into another.  For most arrays, this is 0.

4 Range of First Index @\This is the number of index values along the first
dimension, or one greater than the largest legal value of this index (since the
arrays are always zero-based).  A fixnum in the range 0 to 2@+[24]-1.  If any
of the indices has a range of 0, the array is legal but will contain no data
and accesses to it will always be out of range.  In a 0-dimension array, this
entry will not be present.

5 - N  Ranges of Subsequent Dimensions
@end [description]

The number of dimensions of an array can be determined by looking at the length
of the array header.  The rank will be this number minus 6.  The maximum array
rank is 65535 - 6, or 65529.

The ranges of all indices are checked on every access, during the conversion to
a single data-vector index.  In this conversion, each index is added to the
accumulating total, then the total is multiplied by the range of the following
dimension, the next index is added in, and so on.  In other words, if the data
vector is scanned linearly, the last array index is the one that varies most
rapidly, then the index before it, and so on.

@section [Symbols Known to the Microcode]
@label [Known-Objects]

A large number of symbols will be pre-defined when a Spice Lisp system is fired
up.  A few of these are so fundamental to the operation of the system that
their addresses have to be assembled into the microcode.  These symbols are
listed here.  All of these symbols are in static space, so they will not be
moving around.

@begin [description]
@index [NIL]
NIL @\5C000000@-[16] The value of NIL is always NIL; it is an error
to alter it.  NIL is unique among symbols in that you can take its CAR
and CDR, yielding NIL in either case.

@index [T]
T @\5C00000C@-[16]  The value of T is always T; it is an error
to alter it.

@index [%SP-Internal-Apply]
%SP-Internal-Apply @\5C000018@-[16] The function stored in the
definition cell of this symbol is called by the microcode whenever
compiled code calls an interpreted function.  See section
@ref[PUSH-LAST] for details.

@index [%SP-Internal-Error]
%SP-Internal-Error @\5C000024@-[16] The function stored in the
definition cell of this symbol is called whenever an error is detected
during the execution of a byte instruction.  See section @ref[Errors]
for details.

@index [%SP-Software-Interrupt-Handler]
%SP-Software-Interrupt-Handler @\5C000030@-[16] The function stored in the
definition cell of this symbol is called whenever a software interrupt occurs.
See section @ref[Interrupts] for details.

@index [%SP-Internal-Throw-Tag]
%SP-Internal-Throw-Tag @\5C00003C@-[16] This symbol is bound to the tag being
thrown when a Catch-All frame is encountered on the stack.  See section
@ref[Catch] for details.
@End[description]

@chapter [Runtime Environment]
@index [Runtime Environment]
@label [Runtime]

@section [Control Registers]
@index [Control registers]
To describe the instructions in chapter @ref[Instr-Chapter] and the complicated
control conventions in chapter @ref[Control-Conventions] requires that we talk
about a number of ``machine registers.''  All of these registers will be
treated as if they contain 32-bit Lisp objects.
@begin [description]
@index [Control-Stack-Pointer register]
Control-Stack-Pointer@\The stack pointer for the control stack, an object of
type Misc-Control-Stack-Pointer.  Points to the first unused word in
Control-Stack space; this upward growing stack uses a
write-increment/decrement-read discipline.

@index [TOS register]
TOS@\The top entry of the control stack, which is kept in a register for
efficiency.  References to local variables are faster if they can assume that
the local in question is on the stack in main memory and that it has not popped
up into the TOS register.  To ensure this, the compiler adds an extra local
variable to each function, so that none of the locals that are actually used
can ever pop into TOS.

@index [Binding-Stack-Pointer register]
Binding-Stack-Pointer@\The stack pointer for the special variable binding
stack, an object of type Misc-Binding-Stack-Pointer.  The binding stack follows
the same write-increment/decrement-read discipline as the control stack.

@index [Active-Frame register]
Active-Frame@\An object of type Misc-Control-Stack-Pointer which points to the
first word of the call frame for the currently executing function.  The virtual
address of the start of the arguments and locals area of the active frame is
this pointer plus a constant (see section @ref[Control-Stack-Format]).

@index [Open-Frame register]
Open-Frame@\An object of type Misc-Control-Stack-Pointer which points to the
first word of the call frame currently being built (i.e. whose arguments are
being evaluated).

@index [Active-Catch register]
Active-Catch@\An object of type Misc-Control-Stack-Pointer which points to the
first word of the most recent catch frame built.

@index [Active-Function register]
Active-Function@\The compiled function object for the function that is
currently being executed.  The virtual address of the start of the symbols and
constants area of the current function is this pointer plus a constant (see
section @ref[Fn-Format]).

@index [Active-Code register]
Active-Code@\The I-Vector of instructions for the currently executing
function.

@index [PC register]
@index [Program Counter register]
PC@\A pointer into I-Vector space that indicates the next quadword from which
the instruction buffer will be filled.  This and the hardware BPC determine the
next instruction to be executed.  When a PC is pushed on the stack by a Call
or Catch instruction, it is stored in the form of a 16-bit offset from the base
of the Active-Code vector and the BPC:
@begin [verbatim, group]
 31                27 26        20 19     16 15              0
---------------------------------------------------------------
| Trap type code (5) | Unused (7) | BPC (4) |   Offset  (16)  |
---------------------------------------------------------------
@end [verbatim]
@end [description]

@section [Function Object Format]
@label [Fn-Format]

Each compiled function is represented in the machine as a Function
Object.  This is identical in form to a G-Vector of lisp objects, and
is treated as such by the garbage collector, but it exists in a
special function space.  (There is no particular reason for this
distinction.  We may decide later to store these things in G-Vector
space, if we become short on spaces or have some reason to believe
that this would improve paging behavior.)  Usually, the function
objects and code vectors will be kept in read-only space, but nothing
should depend on this; some applications may create, compile, and
destroy functions often enough to make dynamic allocation of function
objects worthwhile.

@index [Code vector]
@index [Constants in code]
The function object contains a vector of header information needed by
the function-calling mechanism: a pointer to the I-Vector that holds the
actual code.  Following this is the so-called ``symbols and constants''
area.  The first few entries in this area are fixnums that give the
offsets into the code vector for various numbers of supplied arguments.
Following this begin the true symbols and constants used by the
function.  Any symbol used by the code as a special variable or the name
of another function will appear here.  Fixnum constants in the
range of -256 to +255 can be generated within the byte code, and so do
not need to be stored in the constants area as full-word constants.

After the one-word G-Vector header, the entries of the function object
are as follows:

@begin [verbatim, group]
0  A fixnum with bit fields as follows:
   0  - 14: Number of symbols/constants in this fn object (0 to 32K-1).
	    This number includes the optional-arg offsets.
   15 - 26: Not used.
   27:      0 => All args evaled.  1 => This is a FEXPR.
1  Pointer to the unboxed Code vector holding the macro-instructions.
2  A fixnum with bit fields as follows:
   0  -  7: The minimum legal number of args (0 to 255).
   8  - 15: The maximum number of args, not counting &rest (0 to 255).
   16 - 26: Number of local variables allocated on stack (0 to 2047).
   27:      0 => No &rest arg.     1 => One &rest arg.
3  Name of this function (a symbol).
4  Vector of argument names, in order, for debugging use.
5  The symbols and constants area starts here.
   This word is entry 0 of the symbol/constant area.
   The first few entries in this area are fixnums representing
     the code-vector entry points for various numbers of
     optional arguments.  See section @ref[Push-Last].
@end [verbatim]

@section [Control-Stack Format]
@label [Control-Stack-Format]
@index [Control-stack format]

The Spice Lisp control stack is a framed stack.  Call frames, which hold
information for function calls, are intermixed with catch frames, which hold
information used for non-local exits.  In addition, the control stack is used
as a scratchpad for random computations.

@subsection [Call Frames]
@index [Open frame]
@index [Active frame]

At any given time, the machine contains pointers to the current top of
the control stack, the start of the current active frame (in which the
current function is executing), and the start of the most recent open
frame.  In addition, there is a pointer to the current top of the special
binding stack.  An open frame is one which has been partially built, but
which is still having arguments for it computed.  When all the arguments
have been computed and saved on the frame, the function is then
started.  This means that the call frame is completed, becomes the
current active frame, and the function is executed.  At this time,
special variables may be bound and the old values are saved on the
binding stack.  Upon return, the active frame is popped away and the
result is either sent as an argument to some previously opened frame or
goes to some other destination.  The binding stack is popped and old
values are restored.

The active frame contains pointers to the previously-active frame, to
the most recent open frame, and to the point to which the binding stack
will be popped on exit, among other things.  Following this is a
vector of storage locations for the function's arguments and local
variables.  Space is allocated for the maximum number of arguments that
the function can take, regardless of how many are actually supplied.

In an open frame, the structure is built up to the point where the
arguments are stored.  Thus, as arguments are computed, they can simply
be pushed on the stack.  When the function is finally started, the
remainder of the frame is built.  A call frame looks like this:
@begin [verbatim, group]
0   Header word.  Type Call-Frame-Header.
1   Function object or EXPR for this call.
2   Pointer to previous active frame.  Type Misc-Control-Stack-Ptr.
3   Pointer to previous open frame.  Type Misc-Control-Stack-Ptr.
4   Pointer to previous binding stack.  Type Misc-Binding-Stack-Ptr.
5   Saved PC of caller.  A fixnum.
6   Args-and-locals area starts here.  This is entry 0.
@end [verbatim]
The first slot is pointed to by the Active-Frame register if this frame is
currently active, and by the Open-Frame register if this frame is the currently
opened frame.

@subsection [Catch Frames]
@index [Catch]
@index [Catch frames]

Catch frames contain much of the same information that call frames do, and have
a very similar format.  A catch frame holds the function object for the current
function, a stack pointer to the current active and open frames, a pointer to
the current top of the binding stack, and a pointer to the previous catch
frame.  When a Throw occurs, an operation equivalent to returning from this
catch frame (as if it were a call frame) is performed, and the stacks are
unwound to the proper place for continued execution in the current function.  A
catch frame looks like this:
@begin [verbatim, group]
0   Header word.  Type Catch-Frame-Header.
1   Function object for this call.
2   Pointer to current active frame.
3   Pointer to current open frame.
4   Pointer to current binding stack.
5   Destination PC for a Throw.
6   Tag caught by this catch frame.
7   Pointer to previous catch frame.
@end [verbatim]
The conventions used to manipulate call and catch frames are described in
chapter @ref[Control-Conventions].

@section [Binding-Stack Format]
@index [Binding stack format]

Each entry of the binding-stack consists of two boxed (32-bit) words.  Pushed
first is a pointer to the symbol being bound.  Pushed second is the symbol's
old value (any boxed item) that is to be restored when the binding is popped.

@chapter [Storage Management]
@index [Storage management]
@index [Garbage Collection]
@label [Alloc-Chapter]

@index [Free-Storage pointer]
@index [Clean-Space pointer]
New objects are allocated from the lowest unused addresses within the specified
space.  Each allocation call specifies how many words are wanted, and a
Free-Storage pointer is incremented by that amount.  There is one of these
Free-Storage pointers for each space, and it points to the lowest free address
in the space.  There is also a Clean-Space pointer associated with each space
that is used during garbage collection.  These pointers are stored in a table
in the microcode table area which is indexed by type and space code.  The
address of the Free-Storage pointer for a given space is
@begin[verbatim]
	(+ alloc-table-base (lsh type 4) (lsh space 2)).
@end[verbatim]
The address of the Clean-Space pointer is
@begin[verbatim]
	(+ alloc-table-base (lsh type 4) (lsh space 2) 2).
@end[verbatim]

PERQ Spice Lisp uses a stop-and-copy garbage collector to reclaim storage.  The
Collect-Garbage instruction performs a full GC.  The algorithm used is a
degenerate form of Baker's incremental garbage collection scheme.  When
the Collect-Garbage instruction is executed, the following happens:
@begin[enumerate]
The current newspace becomes oldspace, and the current oldspace becomes
newspace.

The newspace Free-Storage and Clean-Space pointers are initialized to point to
the beginning of their spaces.

The contents of the ``registers inside the barrier'' are transported.  There
are only three such registers: Active-Function, Active-Code, and TOS.  However,
the PC is stored internally as an absolute address, so it must be recomputed if
the code vector in Active-Code is transported.  This is easily done by
subtracting Active-Code from PC before it is transported, and adding it back in
afterwards.  Because the Active-Code vector will be transported from a quadword
boundary to a quadword boundary, the PERQ's internal BPC needn't be modified.

The control stack and binding stack are scavenged.

Each static pointer space is scavenged.

Each new dynamic space is scavenged.  The scavenging of the dynamic spaces is
done until an entire pass through all of them does not result in anything being
transported.  At this point, every live object is in newspace.
@end[enumerate]
A Lisp-level GC function must return the oldspace pages to Accent.

@index [Transporter]
@section [The Transporter]
The transporter moves objects from oldspace to newspace.  It is given an
address @i[A], which contains the object to be transported, @i[B].  If @i[B] is
an immediate object, a pointer into static space, a pointer into read-only
space, or a pointer into newspace, the transporter does nothing.

If @i[B] is a pointer into oldspace, the object it points to must be moved.  It
may, however, already have been moved.  Fetch the first word of @i[B], and call
it @i[C].  If @i[C] is a GC-forwarding pointer, we form a new pointer with the
type code of @i[B] and the low 27 bits of @i[C].  Write this into @i[A].

If @i[C] is not a GC-forwarding pointer, we must copy the object the @i[B]
points to.  Allocate a new object of the same size in newspace, and copy the
contents.  Replace @i[C] with a GC-forwarding pointer to the new structure, and
write the address of the new structure back into @i[A].

Hash tables maintained with an EQ relation need special treatment by the
transporter.  Whenever a G-Vector with subtype 2 or 3 is transported to
newspace, its subtype code is changed to 4.  The Lisp-level hash-table
functions will see that the subtype code has changed, and re-hash the entries
before any access is made.

@index [Scavenger]
@section [The Scavenger]
The scavenger looks through an area of pointers for pointers into oldspace,
transporting the objects they point to into newspace.  The stacks and static
spaces need to be scavenged once, but the new dynamic spaces need to be
scavenged repeatedly, since new objects will be allocated while garbage
collection is in progress.  To keep track of how much a dynamic space has been
scavenged, a Clean-Space pointer is maintained.  The Clean-Space pointer points
to the next word to be scavenged.  Each call to the scavenger scavenges the
area between the Clean-Space pointer and the Free-Storage pointer.  The
Clean-Space pointer is then set to the Free-Storage pointer.  When all
Clean-Space pointers are equal to their Free-Storage pointers, GC is complete.

To maintain (and create) locality of list structures, list space is treated
specially.  Two separate Clean-Space pointers are maintained for list space:
one for cars and one for cdrs.  The scavenger works on the Clean-Cdr pointer
unless it is at the Free-Storage pointer, in which case it works on the
Clean-Car pointer.  When Clean-Car, Clean-Cdr, and the Free-Storage pointer for
list space coincide, list space has been completely scavenged.

@section [Purification]
@index [Purification]
@label [PURIFY]

Garbage is created when the files that make up a Spice Lisp system are loaded.
Many functions are needed only for initialization and bootstrapping (e.g. the
``one-shot'' functions produced by the compiled for random forms between
function definition), and these can be thrown away once a full system is built.
Most of the functions in the system, however, will be used after
initialization.  Rather than bend over backwards to make the compiler dump some
functions in read-only space and others in dynamic space (which involves
dumping their constants in the proper spaces, also), we will dump
@i[everything] into dynamic space, and use the following storage allocation
feature to move what we need after initialization into read-only and static
space.

The Set-Newspace-For-Type instruction lets us set the free pointer of the next
newspace to dynamic or read-only space instead of the corresponding dynamic
space.  When the next GC happens, objects in newspace will be transported to
this other space (static or read-only) instead of dynamic space.  Care must be
taken, of course, to ensure that objects in read-only space point only to
static or read-only space.  Probably the following should be used for
``purifying'' a system:
@begin [example]
	(set-newspace-for-type  1  2)	; bit-vectors to static
	(set-newspace-for-type  2  2)	; likewise for i-vectors
	(set-newspace-for-type  3  2)	; and strings
	(set-newspace-for-type  4  2)	; and bignums
	(set-newspace-for-type  5  2)	; and long-floats
	(set-newspace-for-type  6  3)	; complexes can be read-only
	(set-newspace-for-type  7  3)	; as can ratios
	(set-newspace-for-type  8  2)	; g-vectors should be static
	(set-newspace-for-type  9  3)	; functions should be read-only
	(set-newspace-for-type 10  3)	; arrays can be, also
	(set-newspace-for-type 11  2)	; symbols should be static
	(set-newspace-for-type 12  2)	; as should conses.
@end [example]

@chapter [Macro Instruction Set]
@label [Instr-Chapter]
@index [Macro instruction set]
@index [Byte codes]

The intent is that this instruction set should be a very direct mapping from
the S-expression source it is derived from.  There should therefore never be
any temptation for users to write macrocode by hand; all of the system that is
not in microcode should be written in Lisp.  Since the compiler will run both
in Spice Lisp and in Maclisp, we need not hand-code things even for
bootstrapping.

@section [Macro-Instruction Formats]
@label [Macro-codes]
@index [Macro instruction formats]
@index [Byte code formats]
@index [Effective address]

There are three ways in which instructions fetch their arguments and store
their results.
@begin [enumerate]
Most instructions pop all of their operands off of the stack and push a result
back onto the stack, behaving like little Lisp functions.  There are some
instructions that will take their last operand from a place other than the
stack (an immediate constant, a local variable, etc).

Some instructions modify a value in place.  This value is sometimes the top of
the stack, but could be a local variable, argument, or special variable.  In
the descriptions of the instructions below, these instructions operate on a
pseudo-operand @i[E], the effective address, which is specified as part of the
opcode.

Finally, a few instructions pop the top of the stack but leave no result.  The
Pop, Branch, and Dispatch instructions do this.
@end [enumerate]

All non-branching Spice Lisp instructions are made up of 1 or 2 opcode bytes,
that contain an implicit effective address, and 0 to 2 bytes following the
opcode that are used as part of the effective address.  Branching instructions
have 1 or 2 bytes of opcode followed by a 1 or 2 byte branch offset.  The
possible effective addresses (and their use of additional effective address
bytes) are these:
@begin [description]
Stack@\The operand is taken from the stack.  Then the operation takes place, in
some cases pushing a result onto the stack.  No effective address bytes are
fetched.  The names of instructions that take all stack operands are not
suffixed with an effective address specifier, as others are.  These
instructions are called ``basic'' instructions.  In most cases, the
compiler-writer need concern himself with only these forms of an instruction.
The peephole optimizer will replace sequences of stack referencing instructions
with instructions with differerent addressing modes if the resulting sequence
is faster.

Positive Short Integer Constant@\A byte is fetched and is converted to a
positive fixnum in the range 0 to 255.  This is used as the operand.  The
``-PSIC'' suffix on an instruction name is used for instructions with positive
short integer constant operands.  Some instructions imply a particular short
integer without a second byte.  These are suffixed with ``-PSIC@i[n]'' where
@i[n] is the short integer.  A short integer constant may never be used as a
result effective address, of course.

Negative Short Integer Constant@\A byte is fetched and is converted to a
negative fixnum in the range -1 to -256.  This is used as the operand.  The
``-NSIC'' suffix on an instruction name is used for instructions with negative
short integer constant operands.

Arguments & Locals@\In most cases, one byte is fetched and used as an unsigned
offset (0 - 255) into the arguments and local variables area of the currently
active call frame (``-AL'' suffix).  The contents of this cell are used as the
operand.  For a few instructions, two bytes are fetched to form a 16-bit
offset (0 - 65535).  In fetching this double offset, the low-order byte comes
in first (``-LongAL'' suffix).  Some instructions imply a particular offset
without the need for another offset byte.  These instructions are those that
are suffixed with ``-AL@i[n]'' where @i[n] is an integer which denotes the
implied offset.  When used as a result effective address, the result is stored
in the specified slot of the call frame.

Constants@\In most cases, one byte is fetched and used as an unsigned offset (0
- 255) into the vector of symbols and constants in the code object of the
current function.  The constant in this cell is used directly (``-C'' suffix).
For a few instructions, the next two bytes are fetched to form a 16-bit
unsigned offset (0 - 65535) (``-LongC'' suffix).  In fetching this double
offset, the low-order byte comes in first.  Sometimes an instruction implies an
offset into the symbols and constants vector without the need of another byte
for the offset.  In these instances when the offset is implied, the instruction
will have the suffix ``-C@i[n]'' where @i[n] is an integer denoting the offset.
Constants may not be used as a result effective address.

Symbols@\In most cases, one byte is fetched and used as an unsigned offset (0 -
255) into the vector of symbols and constants in the code object of the current
function.  The constant in this cell is supposed to be a symbol pointer, and
the operand is fetched from its value cell (``-S'' suffix).  If the value is
Misc-Trap, an unbound variable error is signalled.  For some instructions, the
next two bytes are fetched to form a 16-bit offset (``-LongS'' suffix).  In
fetching this double offset, the low-order byte comes in first.  Sometimes an
instruction implies an offset into the symbols and constants vector without the
need of another byte for the offset.  In these instances when the offset is
implied, the instruction will have the suffix ``-S@i[n]'' where @i[n] is an
integer denoting the offset.  When a symbol is used as a result effective
address, its value cell is set to the result.

Ignore@\Specified with a ``-Ignore'' suffix.  This may be used only as a result
effective address.
@end [description]

@index [E (effective address)]
@index [CE (contents of effective address)]
In the following listing, the effective address is called ``@i[E]'' and its
contents are called ``@i[CE]''.  The opcodes for these instructions are defined
in a file read by the microassembler, compiler, error system, and disassembler.
This file lives on CMU-CS-C as
@t[PRVA:<Slisp.Compiler.New-And-Improved>Instrdefs.Slisp] and CMU-Badger as
@t[>Slisp>Instrdefs.Lisp].  It is included in this document as an appendix.

@section [Instructions]

There are 11 classes of instructions: allocation, stack manipulation, list
manipulation, symbol manipulation, array manipulation, type predicate,
arithmetic and logical, branching and dispatching, function call and return,
miscellaneous, and system hacking.  A number of the instructions below
combine the effect of two or more simpler instructions, and are part of the
instruction set for efficiency reasons.  It is envisioned that the compiler
will generate code using the stack forms of most instructions, with lots of
Push and Pop instructions to get operands and store results.  An optimizing
assembler will then collapse sequences of these simple instructions into the
faster, more compact complex instructions.  Each basic instruction is flagged
with an asterisk (@+[*]).

@subsection [Allocation]
@instrsection
All non-immediate objects are allocated in the ``current allocation space,''
which is dynamic space, static space, or read-only space.  The current
allocation space is initially dynamic space, but can be changed by using the
Set-Allocation-Space instruction below.  The current allocation space can be
determined by using the Get-Allocation-Space instruction.  One usually wants to
change the allocation space around some section of code; an unwind protect
should be used to insure that the allocation space is restored to some safe
value.

@index [Get-Allocation-Space]
Get-Allocation-Space (@i[]) pushes 0, 2, or 3 if the current allocation
space is dynamic, static, or read-only respectively.
@binstr[name = "Get-Allocation-Space"]

@index [Set-Allocation-Space]
Set-Allocation-Space (@i[X]) sets the current allocation space to dynamic,
static, or read-only if @i[X] is 0, 2, or 3 respectively.  Pushes @i[X].
@binstr[name = "Set-Allocation-Space"]

@index [Alloc-Bit-Vector]
Alloc-Bit-Vector (Length) pushes a new bit-vector @i[Length] bits long,
which is allocated in the current allocation space.  @i[Length] must be a
positive fixnum.
@binstr[name = "Alloc-Bit-Vector"]

@index [Alloc-I-Vector]
Alloc-I-Vector (@i[Length A]) pushes a new I-Vector @i[Length] bytes long, with
the access code specified by @i[A].  @i[Length] and @i[A] must be positive
fixnums.
@binstr[name = "Alloc-I-Vector"]

@index [Alloc-String]
Alloc-String (@i[Length]) pushes a new string @i[Length] characters long.
@i[Length] must be a fixnum.
@binstr[name = "Alloc-String"]

@index [Alloc-Bignum]
Alloc-Bignum (@i[Length]) pushes a new bignum @i[Length] 8-bit bytes long.
@i[Length] must be a fixnum.
@binstr[name = "Alloc-Bignum"]

@index [Make-Complex]
Make-Complex (@i[Realpart Imagpart]) pushes a new complex number with the
specified @i[Realpart] and @i[Imagpart].  @i[Realpart] and @i[Imagpart] should
be the same type of non-complex number.
@binstr[name = "Make-Complex"]

@index [Make-Ratio]
Make-Ratio (@i[Numerator Denominator]) pushes a new ratio with the specified
@i[Numerator] and @i[Denominator].  @i[Numerator] and @i[Denominator] should be
integers.
@binstr[name = "Make-Ratio"]

@index [Alloc-G-Vector]
Alloc-G-Vector (@i[Length Initial-Element]) pushes a new G-Vector with
@i[Length] elements initialized to @i[Initial-Element].  @i[Length] should be a
fixnum.
@binstr[name = "Alloc-G-Vector"]

@index [Vector]
Vector (@i[Elt@-[0] Elt@-[1] ... Elt@-[Length - 1] Length]) pushes a new
G-Vector containing the specified @i[Length] elements.  @i[Length] should be a
fixnum.
@binstr[name = "Vector"]
@instr[name = "Vector-PSIC"]

@index [Alloc-Function]
Alloc-Function (@i[Length]) pushes a new function with @i[Length] elements.
@i[Length] should be a fixnum.
@binstr[name = "Alloc-Function"]

@index [Alloc-Array]
Alloc-Array (@i[Length]) pushes a new array with @i[Length] elements.
@i[Length] should be a fixnum.
@binstr[name = "Alloc-Array"]

@index [Alloc-Symbol]
Alloc-Symbol (@i[Print-Name]) pushes a new symbol with the print-name as
@i[Print-Name].  The value is initially Misc-Trap, the definition is Misc-Trap,
the property list and the package are initially NIL.  The symbol is not
interned by this operation -- that is done in macrocode.  @i[Print-Name] should
be a simple-string.
@binstr[name = "Alloc-Symbol"]

@index [Cons]
Cons (@i[Car Cdr]) pushes a new cons with the specified @i[Car] and @i[Cdr].
@binstr[name = "Cons"]

@index [Set-LPush]
Set-LPush (@i[Car E]) pushes a new cons with the specified @i[Car] and
@i[CE] as the cdr, and stores the cons back into @i[E].
@begin[format]
@instr[name = "Set-LPush-AL"]
@instr[name = "Set-LPush-S"]
@end[format]

@index [List]
List (@i[Elt@-[0] Elt@-[1] ... Elt@-[CE - 1] Length]) pushes a new list
containing the @i[Length] elements.  @i[Length] should be fixnum.
@begin[format]
@binstr[name = "List"]
@instr[name = "List-PSIC"]
@end[format]

@index [List*]
List* (@i[Elt@-[0] Elt@-[1] ... Elt@-[CE - 1] Length]) pushes a list* formed by
the @i[CE] elements onto the stack.  @i[Length] should be a fixnum.
@begin[format]
@binstr[name = "List*"]
@instr[name = "List*-PSIC"]
@end[format]

@subsection [Stack Manipulation]
@instrsection

@index [Push]
Push (@i[E]) pushes @i[CE] onto the stack.
@begin[format]
@binstr[name = "Push-PSIC"]
@instr[name = "Push-PSIC0"]
@instr[name = "Push-PSIC1"]
@instr[name = "Push-PSIC2"]
@instr[name = "Push-PSIC3"]
@binstr[name = "Psuh-NSIC"]
@binstr[name = "Push-AL"]
@instr[name = "Push-AL0"]
@instr[name = "Push-AL1"]
@instr[name = "Push-AL2"]
@instr[name = "Push-AL3"]
@instr[name = "Push-AL4"]
@instr[name = "Push-AL5"]
@instr[name = "Push-AL6"]
@instr[name = "Push-AL7"]
@binstr[name = "Push-LongAL"]
@binstr[name = "Push-C"]
@binstr[name = "Push-LongC"]
@binstr[name = "Push-S"]
@binstr[name = "Push-LongS"]
@end[format]

@index [Pop]
Pop (@i[E]) pops the stack into @i[E].
@begin[format]
@binstr[name = "Pop-AL"]
@instr[name = "Pop-AL0"]
@instr[name = "Pop-AL1"]
@instr[name = "Pop-AL2"]
@instr[name = "Pop-AL3"]
@instr[name = "Pop-AL4"]
@instr[name = "Pop-AL5"]
@instr[name = "Pop-AL6"]
@instr[name = "Pop-AL7"]
@binstr[name = "Pop-LongAL"]
@binstr[name = "Pop-S"]
@binstr[name = "Pop-LongS"]
@binstr[name = "Pop-Ignore"]
@end[format]

@index [Exchange]
Exchange (@i[]) exchanges the top two elements of the stack.
@binstr[name = "Exchange"]

@index [Copy]
Copy (@i[E]) copies the top of stack to @i[E].
@begin[format]
@binstr[name = "Copy"]
@instr[name = "Copy-AL"]
@end[format]

@index [NPop]
NPop (@i[N]).  If @i[N] is positive, @i[N] items are popped off of the stack.
If @i[N] is negative, NIL is pushed onto the stack -@i[N] times.  @i[N] must be
a fixnum.
@begin[format]
@binstr[name = "NPop-Stack"]
@instr[name = "NPop-PSIC"]
@instr[name = "NPop-NSIC"]
@end[format]

@index [Bind-Null]
Bind-Null (@i[E]) pushes @i[CE] (which must be a symbol) and its current value
onto the binding stack, and sets the value cell of @i[CE] to NIL.
@begin[format]
@binstr[name = "Bind-Null"]
@instr[name = "Bind-Null-C"]
@end[format]

@index [Bind]
Bind (@i[Value Symbol]) pushes @i[Symbol] (which must be a symbol) and its
current value onto the binding stack, and sets the value cell of @i[Symbol] to
@i[Value].
@begin[format]
@binstr[name = "Bind"]
@instr[name = "Bind-C"]
@end[format]

@index [Unbind]
Unbind (@i[N]) undoes the top @i[N] bindings on the binding stack.
@begin[format]
@binstr[name = "Unbind"]
@instr[name = "Unbind-PSIC"]
@end[format]

@subsection [List Manipulation]
@instrsection

@index [Car]
@index [Cdr]
@index [Cadr]
@index [Cddr]
@index [Caar]
@index [Cdar]
C@i[xx]r (@i[L]).  The c@i[xx]r of @i[L] is pushed onto the stack.  @i[L]
should be a list or NIL.
@begin[format]
@binstr[name = "Car"]
@instr[name = "Car-AL"]
@binstr[name = "Cdr"]
@instr[name = "Cdr-AL"]
@binstr[name = "Cadr"]
@instr[name = "Cadr-AL"]
@binstr[name = "Cddr"]
@instr[name = "Cddr-AL"]
@binstr[name = "Cdar"]
@instr[name = "Cdar-AL"]
@binstr[name = "Caar"]
@instr[name = "Caar-AL"]
@end[format]

@index [Set-Cdr]
@index [Set-Cddr]
Set-C@i[xx]r (@i[E]).  The c@i[xx]r of @i[CE] is stored in @i[E].
@i[CE] should be either a list or NIL.
@begin[format]
@instr[name = "Set-Cdr-AL"]
@instr[name = "Set-Cdr-S"]
@instr[name = "Set-Cddr-AL"]
@instr[name = "Set-Cddr-S"]
@end[format]

@index [Set-Lpop]
Set-Lpop (@i[E]). The car of @i[CE] is pushed onto the stack; the cdr
of @i[CE] is stored in @i[E].  @i[CE] should be a list or NIL.
@begin[format]
@instr[name = "Set-Lpop-AL"]
@instr[name = "Set-Lpop-S"]
@end[format]

@index [Spread]
Spread (@i[E]) pushes the elements of the list @i[CE] onto the stack in
left-to-right order.
@begin[format]
@binstr[name = "Spread"]
@instr[name = "Spread-AL"]
@end[format]

@index [Replace-Car]
@index [Replace-Cdr]
Replace-C@i[x]r (@i[List Value]) sets the c@i[x]r of the @i[List] to @i[Value]
and pushes @i[Value] on the stack.
@begin[format]
@binstr[name = "Replace-Car"]
@instr[name = "Replace-Car-AL"]
@binstr[name = "Replace-Cdr"]
@instr[name = "Replace-Cdr-Al"]
@end[format]

@index [Endp]
Endp (@i[X]) pushes T if @i[X] is NIL, or NIL if @i[X] is a cons.  Otherwise an
error is signalled.
@begin[format]
@binstr[name = "Endp"]
@instr[name = "Endp-AL"]
@end[format]

@index [Assoc]
@index [Assq]
Assoc (@i[List Item]) pushes the first cons in the association-list @i[List]
whose car is EQL to @i[Item].  If the = part of the EQL comparison bugs out
(and it can if the numbers are too complicated), a Lisp-level Assoc function is
called with the current cdr of the @i[List].  Assq pushes the first cons in
the association-list @i[List] whose car is EQ to @i[Item].
@binstr[name = "Assoc"]
@binstr[name = "Assq"]

@index [Member]
@index [Memq]
Member (@i[List Item]) pushes the first cons in the list @i[List] whose car is
EQL to @i[Item].  If the = part of the EQL comparison bugs out, a Lisp-level
Member function is called with the current cdr of the @i[List].  Memq pushes
the first cons in @i[List] whose car is EQ to the @i[Item].
@binstr[name = "Member"]
@binstr[name = "Memq"]

@index [GetF]
GetF (@i[List Indicator Default]) searches for the @i[Indicator] in the list
@i[List], cddring down as the Common Lisp form GetF would.  If @i[Indicator] is
found, its associated value is pushed, otherwise @i[Default] is pushed.
@binstr[name = "GetF"]

@subsection [Symbol Manipulation]
@instrsection

@index [Get-Value]
Get-Value (@i[Symbol]) pushes the value of @i[Symbol] (which must be a symbol)
onto the stack.  An error is signalled if @i[CE] is unbound.
@binstr[name = "Get-Value"]

@index [Set-Value]
Set-Value (@i[Symbol Value]) sets the value cell of the symbol @i[Symbol] to
@i[Value].  @i[Value] is left on the top of the stack.
@binstr[name = "Set-Value"]

@index [Get-Definition]
Get-Definition (@i[Symbol]) pushes the definition of the symbol @i[Symbol] onto
the stack.  If @i[Symbol] is undefined, an error is signalled.
@begin[format]
@binstr[name = "Get-Definition"]
@instr[name = "Get-Definition-C"]
@end[format]

@index [Set-Definition]
Set-Definition (@i[Symbol Definition]) sets the definition of the symbol
@i[Symbol] to @i[Definition].  @i[Definition] is left on the top of the stack.
@begin[format]
@binstr[name = "Set-Definition"]
@instr[name = "Set-Definition-C"]
@end[format]

@index [Get-Plist]
Get-Plist (@i[Symbol]) pushes the property list of the symbol @i[Symbol] onto
the stack.
@begin[format]
@binstr[name = "Get-Plist"]
@instr[name = "Get-Plist-C"]
@end[format]

@index [Set-Plist]
Set-Plist (@i[Symbol Plist]) sets the property list of the symbol @i[Symbol] to
@i[Plist].  @i[Plist] is left on the top of the stack.
@begin[format]
@binstr[name = "Set-Plist"]
@instr[name = "Set-Plist-C"]
@end[format]

@index [Get-Pname]
Get-Pname (@i[Symbol]) pushes the print name of the symbol @i[Symbol] onto the
stack.
@binstr[name = "Get-Pname"]

@index [Get-Package]
Get-Package (@i[Symbol]) pushes the package cell of the symbol @i[Symbol] onto
the stack.
@binstr[name = "Get-Package"]

@index [Set-Package]
Set-Package (@i[Symbol Package]) sets the package cell of the symbol @i[Symbol]
to @i[Package].  @i[Package] is left on the top of the stack.
@binstr[name = "Set-Package"]

@index [Boundp]
Boundp (@i[Symbol]) pushes T if the symbol @i[Symbol] is bound; NIL otherwise.
@begin[format]
@binstr[name = "Boundp"]
@instr[name = "Boundp-C"]
@end[format]

@index [FBoundp]
FBoundp (@i[Symbol]) pushes T if the symbol @i[Symbol] is defined; NIL
otherwise.
@begin[format]
@binstr[name = "FBoundp"]
@instr[name = "FBoundp-C"]
@end[format]

@subsection [Array Manipulation]
@instrsection

Common Lisp arrays have many manifestations in Spice Lisp.  The Spice Lisp data
types Bit-Vector, Integer-Vector, String, General-Vector, and Array are used to
implement the collection of data types the Common Lisp manual calls ``arrays.''

In the following instruction descriptions, ``simple-array'' means an array
implemented in Spice Lisp as a Bit-Vector, I-Vector, String, or G-Vector.
``Complex-array'' means an array implemented as a Spice Lisp Array object.
``Complex-bit-vector'' means a bit-vector implemented as a Spice Lisp array;
similar remarks apply for ``complex-string'' and so forth.

@index [Vector-Length]
@index [G-Vector-Length]
@index [Simple-String-Length]
@index [Simple-Bit-Vector-Length]
Vector-Length (@i[Vector]) pushes the length of the one-dimensional Common Lisp
array @i[Vector].  G-Vector-Length, Simple-String-Length, and
Simple-Bit-Vector-Length push the lengths of G-Vectors, Spice Lisp strings, and
Spice Lisp Bit-Vectors respectively.  @i[Vector] should be a vector of the
appropriate type.
@begin[format]
@binstr[name = "Vector-Length"]
@binstr[name = "G-Vector-Length"]
@binstr[name = "Simple-String-Length"]
@binstr[name = "Simple-Bit-Vector-Length"]
@end[format]

@index [Get-Vector-Subtype]
Get-Vector-Subtype (@i[Vector]) pushes the subtype field of the vector
@i[Vector] as an integer.  @i[Vector] should be a vector of some sort.
@binstr[name = "Get-Vector-Subtype"]

@index [Set-Vector-Subtype]
Set-Vector-Subtype (@i[Vector A]) sets the subtype field of the vector
@i[Vector] to @i[A], which must be an fixnum.
@binstr[name = "Set-Vector-Subtype"]

@index [Get-Vector-Access-Code]
Get-Vector-Access-Code (@i[Vector]) pushes the access code of the I-Vector (or
Bit-Vector) @i[Vector] as an integer.
@binstr[name = "Get-Vector-Access-Code"]

@index [Shrink-Vector]
Shrink-Vector (@i[Vector Length]) sets the length field and the
number-of-entries field of the vector @i[Vector] to @i[Length].  If the vector
contains Lisp objects, entries beyond the new end are set to Misc-Trap.  Pushes
the shortened vector.  @i[Length] should be a fixnum.  One cannot shrink array
headers or function headers.
@binstr[name = "Shrink-Vector"]

@index [Typed-Vref]
Typed-Vref (@i[A Vector I]) pushes the @i[I]'th element of the I-Vector
@i[Vector] by indexing into it as if its access-code were @i[A].  @i[A] and
@i[I] should be fixnums.
@binstr[name = "Typed-Vref"]

@index [Typed-Vset]
Typed-Vset (@i[A Vector I Value]) sets the @i[I]'th element of the I-Vector
@i[Vector] to @i[Value] indexing into @i[Vector] as if its access-code were
@i[A].  @i[A], @i[I], and @i[Value] should be fixnums.  @i[Value] is pushed
onto the stack.
@binstr[name = "Typed-Vset"]

@index [Header-Length]
Header-Length (@i[Object]) pushes the number of Lisp objects in the header of
the function or array @i[Object].  This is used to find the number of
dimensions of an array or the number of constants in a function.
@binstr[name = "Header-Length"]

@index [Header-Ref]
Header-Ref (@i[Object I]) pushes the @i[I]'th element of the function or array
header @i[Object].  @i[I] must be a fixnum.
@binstr[name = "Header-Ref"]

@index [Header-Set]
Header-Set (@i[Object I Value]) sets the @i[I]'th element of the function of
array header @i[Object] to @i[Value], and pushes @i[Value].  @i[I] must be a
fixnum.
@binstr[name = "Header-Set"]

The names of the instructions used to reference and set elements of arrays are
somewhat based on the Common Lisp function names.  The SVref, SBit, and SChar
instructions perform the same operation as their Common Lisp namesakes --
referencing elements of simple-vectors, simple-bit-vectors, and simple-strings
respectively.  Aref1 references any kind of one dimensional array.
The names of setting functions are derived by replacing ``ref'' with ``set'',
``char'' with ``charset'', and ``bit'' with ``bitset.''

@index [Aref1]
@index [SVref]
@index [SChar]
@index [SBit]
Aref1 (@i[Array I]) pushes the @i[I]'th element of the one-dimensional array
@i[Array].  SVref pushes an element of a G-Vector; SChar an element of a
string; Sbit an element of a Bit-Vector.  @i[I] should be a fixnum.
@begin[format]
@binstr[name = "Aref1"]
@instr[name = "Aref1-AL"]
@binstr[name = "SVref"]
@instr[name = "SVref-PSIC"]
@instr[name = "SVref-AL"]
@instr[name = "SVref-PSIC0"]
@instr[name = "SVref-PSIC1"]
@instr[name = "SVref-PSIC2"]
@instr[name = "SVref-PSIC3"]
@instr[name = "SVref-PSIC4"]
@instr[name = "SVref-PSIC5"]
@binstr[name = "SChar"]
@instr[name = "SChar-AL"]
@binstr[name = "SBit"]
@end[format]

@index [Aset1]
@index [SVset]
@index [SCharset]
@index [SBitset]
Aset1 (@i[Array I Value]) sets the @i[I]'th element of the one-dimensional
array @i[Array] to @i[Value].  SVset sets an element of a G-Vector; SCharset an
element of a string; SBitset an element of a Bit-Vector.  @i[I] should be a
fixnum and @i[Value] is pushed on the stack.
@begin[format]
@binstr[name = "Aset1"]
@instr[name = "Aset1-AL"]
@binstr[name = "SVset"]
@instr[name = "SVset-AL"]
@binstr[name = "SCharset"]
@instr[name = "SCharset-AL"]
@binstr[name = "SBitset"]
@end[format]

@index [SVset*]
SVset* (@i[Array Value I]) sets the @i[I]'th element of the G-Vector @i[Array]
to @i[Value].  The operands to the instruction are arranged so that the index
can be specified as part of the effective address.  This could not be done in
general, of course, because order of evaluation must be preserved, but for
constant indices (as used in structure accesses) this problem does not come up.
@begin[format]
@instr[name = "SVset*-PSIC"]
@instr[name = "SVset*-PSIC0"]
@instr[name = "SVset*-PSIC1"]
@instr[name = "SVset*-PSIC2"]
@instr[name = "SVset*-PSIC3"]
@instr[name = "SVset*-PSIC4"]
@instr[name = "SVset*-PSIC5"]
@end[format]

@index [CAref2]
@index [CAref3]
CAref2 (@i[Array I1 I2]) pushes the element (@i[I1], @i[I2]) of the
two-dimensional array @i[Array] onto the stack.  @i[I1] and @i[I2] should be
fixnums.  CAref3 pushes the element (@i[I1], @i[I2], @i[I3]).
@begin[format]
@instr[name = "CAref2"]
@instr[name = "CAref3"]
@end[format]

@index [CAset2]
@index [CAset3]
CAset2 (@i[Array I1 I2 Value]) sets the element (@i[I1], @i[I2]) of the
two-dimensional array @i[Array] to @i[Value] and pushes @i[Value] on the stack.
@i[I1] and @i[I2] should be fixnums.  CAset3 sets the element (@i[I1], @i[I2],
@i[I3]).
@begin[format]
@instr[name = "CAset2"]
@instr[name = "CAset3"]
@end[format]

@index [Bit-Bash]
Bit-Bash (@i[V1 V2 V3 Op]).  @i[V1], @i[V2], and @i[V3] should be bit-vectors
and @i[Op] should be a fixnum.  The elements of the bit vector @i[V3] are
filled with the result of @i[Op]'ing the corresponding elements of @i[V1] and
@i[V2].  @i[Op] should be a Boole-style number (see the Boole instruction in
section @ref[Boole-Section]).
@binstr[name = "Bit-Bash"]

The rest of the instructions in this section implement special cases of
sequence or string operations.  Where an operand is referred to as a string, it
may actually be an 8-bit I-Vector or system area pointer.

@index [Byte-BLT]
Byte-BLT (@i[Src-String Src-Start Dst-String Dst-Start Dst-End])
moves bytes from @i[Src-String] into @i[Dst-String] between @i[Dst-Start]
(inclusive) and @i[Dst-End] (exclusive).  @i[Dst-Start] - @i[Dst-End] bytes are
moved.  If the substrings specified overlap, ``the right thing happens,'' i.e.
all the characters are moved to the right place.  This instruction corresponds
to the Common Lisp function REPLACE when the sequences are simple-strings.
@binstr[name = "Byte-BLT"]

@index [Find-Character]
Find-Character (@i[String Start End Character])
searches @i[String] for the @i[Character] from @i[Start] to @i[End].  If the
character is found, the corresponding index into @i[String] is returned,
otherwise NIL is returned.  This instruction corresponds to the Common Lisp
function FIND when the sequence is a simple-string.
@binstr[name = "Find-Character"]

@index [Find-Character-With-Attribute]
Find-Character-With-Attribute (@i[String Start End Table Mask])
The codes of the characters of @i[String] from @i[Start] to @i[End] are used as
indices into the @i[Table], which is an I-Vector of 8-bit bytes.  When the
number picked up from the table bitwise ANDed with @i[Mask] is non-zero, the
current index into the @i[String] is returned.
@binstr[name = "Find-Character-With-Attribute"]

@index [SXHash-Simple-String]
SXHash-Simple-String (@i[String Length]) Computes the hash code of the first
@i[Length] characters of @i[String] and pushes it on the stack.  This
corresponds to the Common Lisp function SXHASH when the object is a
simple-string.  The @i[Length] operand can be Nil, in which case the length of
the string is calculated in microcode.
@binstr[name = "SXHash-Simple-String"]

@subsection [Type Predicates]
@instrsection

@index [Bit-Vector-P]
Bit-Vector-P (@i[Object]) pushes T if @i[Object] is a Common Lisp bit-vector or
NIL if it is not.
@binstr[name = "Bit-Vector-P"]

@index [Simple-Bit-Vector-P]
Simple-Bit-Vector-P (@i[Object]) pushes T if @i[Object] is a Spice Lisp
bit-vector or NIL if it is not.
@binstr[name = "Simple-Bit-Vector-P"]

@index [Simple-Integer-Vector-P]
Simple-Integer-Vector-P (@i[Object]) pushes T if @i[Object] is a Spice Lisp
I-Vector or NIL if it is not.
@binstr[name = "Simple-Integer-Vector-P"]

@index [StringP]
StringP (@i[Object]) pushes T if @i[Object] is a Common Lisp string or NIL if
it is not.
@binstr[name = "StringP"]

@index [Simple-String-P]
Simple-String-P (@i[Object]) pushes T if @i[Object] is a Spice Lisp string or
NIL if it is not.
@binstr[name = "Simple-String-P"]

@index [BignumP]
BignumP (@i[Object]) pushes T if @i[Object] is a bignum or NIL if it is not.
@binstr[name = "BignumP"]

@index [Long-Float-P]
Long-Float-P (@i[Object]) pushes T if @i[Object] is a long-float or NIL if it
is not.
@binstr[name = "Long-Float-P"]

@index [ComplexP]
ComplexP (@i[Object]) pushes T if @i[Object] is a complex number or NIL if it
is not.
@binstr[name = "ComplexP"]

@index [RatioP]
RatioP (@i[Object]) pushes T if @i[Object] is a ratio or NIL if it is not.
@binstr[name = "RatioP"]

@index [IntegerP]
IntegerP (@i[Object]) pushes T if @i[Object] is a fixnum or bignum or NIL if
it is not.
@binstr[name = "IntegerP"]

@index [RationalP]
RationalP (@i[Object]) pushes T if @i[Object] is a fixnum, bignum, or ratio.
@binstr[name = "RationalP"]

@index [FloatP]
FloatP (@i[Object]) pushes T if @i[Object] is a short-float or long-float.
@binstr[name = "FloatP"]

@index [NumberP]
NumberP (@i[Object]) pushes T if @i[Object] is a number or NIL if it is not.
@binstr[name = "NumberP"]

@index [General-Vector-P]
General-Vector-P (@i[Object]) pushes T if @i[Object] is a Common Lisp general
vector or NIL if it is not.
@binstr[name = "General-Vector-P"]

@index [Simple-Vector-P]
Simple-Vector-P (@i[Object]) pushes T if @i[Object] is a Spice Lisp G-Vector
or NIL if it is not.
@binstr[name = "Simple-Vector-P"]

@index [Compiled-Function-P]
Compiled-Function-P (@i[Object]) pushes T if @i[Object] is a compiled function
or NIL if it is not.
@binstr[name = "Compiled-Function-P"]

@index [ArrayP]
ArrayP (@i[Object]) pushes T if @i[Object] is a Common Lisp array or NIL if it
is not.
@binstr[name = "ArrayP"]

@index [VectorP]
VectorP (@i[Object]) pushes T if @i[Object] is a Common Lisp vector of NIL if
it is not.
@binstr[name = "VectorP"]

@index [Complex-Array-P]
Complex-Array-P (@i[Object]) pushes T if @i[Object] is a Spice Lisp array or
NIL if it is not.
@binstr[name = "Complex-Array-P"]

@index [SymbolP]
SymbolP (@i[Object]) pushes T if @i[Object] is a symbol or NIL if it is not.
@binstr[name = "SymbolP"]

@index [ListP]
ListP (@i[Object]) pushes T if @i[Object] is a cons or NIL or NIL if it is
not.
@binstr[name = "ListP"]

@index [ConsP]
ConsP (@i[Object]) pushes T if @i[Object] is a cons or NIL if it is not.
@binstr[name = "ConsP"]

@index [FixnumP]
FixnumP (@i[Object]) pushes T if @i[Object] is a fixnum or NIL if it is not.
@binstr[name = "FixnumP"]

@index [Short-Float-P]
Short-Float-P (@i[Object]) pushes T if @i[Object] is a short-float or NIL if it
is not.
@binstr[name = "Short-Float-P"]

@index [CharacterP]
CharacterP (@i[Object]) pushes T if @i[Object] is a character or NIL if it is
not.
@binstr[name = "CharacterP"]

@subsection [Arithmetic and Logic]
@instrsection

@index [Integer-Length]
Integer-Length (@i[Object]) pushes the integer-length (as defined in the Common
Lisp manual) of the integer @i[Object] onto the stack.
@begin[format]
@binstr[name = "Integer-Length"]
@instr[name = "Integer-Length-AL"]
@end[format]

@index [Float-Short]
Float-Short (@i[Object]) pushes a short-float corresponding to the number
@i[Object].
@binstr[name = "Float-Short"]

@index [Float-Long]
Float-Long (@i[Number]) pushes a long float formed by coercing @i[Number] to a
long float.  This corresponds to the Common Lisp function Float when given a
long float as its second argument.
@binstr[name = "Float-Long"]

@index [Realpart]
Realpart (@i[Number]) pushes the realpart of the @i[Number].
@binstr[name = "Realpart"]

@index [Imagpart]
Imagpart (@i[Number]) pushes the imagpart of the @i[Number].
@binstr[name = "Imagpart"]

@index [Numerator]
Numerator (@i[Number]) pushes the numerator of the rational @i[Number].
@binstr[name = "Numerator"]

@index [Denominator]
Denominator (@i[Number]) pushes the denominator of the rational @i[Number].
@binstr[name = "Denominator"]

@index [Decode-Float]
Decode-Float (@i[Number]) performs the Common Lisp Decode-Float function,
leaving 3 values and a Values-Marker on the stack.
@binstr[name = "Decode-Float"]

@index [Scale-Float]
Scale-Float (@i[Number X]) performs the Common Lisp Scale-Float function,
pushing the result on the stack.
@binstr[name = "Scale-Float"]

@index [=]
@index [<]
@index [>]
= (@i[X Y]) pushes T if @i[X] and @i[Y] are numerically equal, or NIL if
they are not.  If an integer is compared with a flonum, the integer
is floated first; if a short flonum is compared with a long flonum, the
short one is first extended.  Flonums must be exactly identical (after
conversion) for a non-null comparison.  < and > are similar.
@begin[format]
@binstr[name = "="]
@instr[name = "=-AL"]
@instr[name = "=-PSIC"]
@binstr[name = "<"]
@instr[name = "<-AL"]
@instr[name = "<-PSIC"]
@binstr[name = ">"]
@instr[name = ">-AL"]
@instr[name = ">-PSIC"]
@end[format]

@index [Truncate]
Truncate (@i[N X]) performs the Common Lisp TRUNCATE operation.  There are 3
cases depending on @i[X]:
@Begin[Itemize]
If @i[X] is fixnum 1, push three items: a fixnum or bignum
representing the integer part of @i[N] (rounded toward 0), then either 0 if
@i[N] was already an integer or the fractional part of @i[N] represented as a
flonum or ratio with the same type as @i[N], then Values-Marker 2 to
mimic a multiple return of two values.

If @i[X] and @i[N] are both fixnums or bignums and @i[X] is not 1, divide
@i[N] by @i[X].  Push three items: the integer quotient (a fixnum or bignum),
the integer remainder, and Values-Marker 2.

If either @i[X] or @i[N] is a flonum or ratio, push a fixnum or bignum
quotient (the true quotient rounded toward 0), then a flonum or ratio
remainder, then push Values-Marker 2.  The type of the remainder is
determined by the same type-coercion rules as for +.  The value of the
remainder is equal to @i[N] - @i[X] * @i[Quotient].
@End[Itemize]
If Truncate uses the escape-to-macro mechanism (see section @ref[Escape]),
it builds a multiple-value frame header rather than an escape
header.
@begin[format]
@binstr[name = "Truncate"]
@instr[name = "Truncate-AL"]
@instr[name = "Truncate-PSIC"]
@end[format]

@index [+]
@index [-]
@index [*]
@index [/]
+ (@i[N X]) pushes @i[N] + @i[X].  -, *, and / are similar.
@begin[format]
@binstr[name = "+"]
@instr[name = "+-AL"]
@instr[name = "+-PSIC"]
@instr[name = "+-PSIC1"]
@binstr[name = "-"]
@instr[name = "--AL"]
@instr[name = "--PSIC"]
@instr[name = "--PSIC1"]
@binstr[name = "*"]
@instr[name = "*-AL"]
@instr[name = "*-PSIC"]
@binstr[name = "/"]
@instr[name = "/-AL"]
@instr[name = "/-PSIC"]
@end[format]

@index [1+]
1+ (@i[E]) stores @i[CE] + 1 into @i[E].
@instr[name = "1+-AL"]

@index [1-]
1- (@i[E]) stores @i[CE] - 1 into @i[E].
@instr[name = "1--AL"]

@index [Negate]
Negate (@i[N]) pushes -@i[N].
@begin[format]
@binstr[name = "Negate"]
@instr[name = "Negate-AL"]
@end[format]

@index [Abs]
Abs (@i[N]) pushes |@i[N]|.
@begin[format]
@binstr[name = "Abs"]
@instr[name = "Abs-AL"]
@end[format]

@index [Logand]
@index [Logior]
@index [Logxor]
Logand (@i[N X]) pushes the bitwise and of the integers @i[N] and @i[X].
Logior and Logxor are analagous.
@begin[format]
@binstr[name = "Logand"]
@binstr[name = "Logior"]
@binstr[name = "Logxor"]
@end[format]

@index [Lognot]
Lognot (@i[N]) pushes the bitwise complement of @i[N].
@begin[format]
@binstr[name = "Lognot"]
@end[format]

@index [Boole]
@label [Boole-Section]
Boole (@i[Op X Y]) performs the Common Lisp Boole operation @i[Op] on @i[X],
and @i[Y].  The Boole constants for Spice Lisp are these:
@begin [verbatim, group]
	boole-clr	0
	boole-set	1
	boole-1		2
	boole-2		3
	boole-c1	4
	boole-c2	5
	boole-and	6
	boole-ior	7
	boole-xor	8
	boole-eqv	9
	boole-nand	10
	boole-nor	11
	boole-andc1	12
	boole-andc2	13
	boole-orc1	14
	boole-orc2	15
@end [verbatim]
@binstr[name = "Boole"]

@index [Ash]
Ash (@i[N X]) performs the Common Lisp ASH operation on @i[N] and @i[X].
@begin[format]
@binstr[name = "Ash"]
@instr[name = "Ash-PSIC"]
@end[format]

@index [Ldb]
Ldb (@i[S P N]).  All args are integers; @i[S] and @i[P] are non-negative.
Performs the Common Lisp LDB operation with @i[S] and @i[P] being the size and
position of the byte specifier.
@binstr[name = "Ldb"]

@index [Mask-Field]
Mask-Field (@i[S P N]) performs the Common Lisp Mask-Field operation with @i[S]
and @i[P] being the size and position of the byte specifier.
@binstr[name = "Mask-Field"]

@index [Dpb]
Dpb (@i[V S P N]) performs the Common Lisp DPB operation with @i[S] and @i[P]
being the size and position of the byte specifier.
@binstr[name = "Dpb"]

@index [Deposit-Field]
Deposit-Field (@i[V S P N]) performs the Common Lisp Deposit-Field operation
with @i[S] and @i[P] as the size and position of the byte specifier.
@binstr[name = "Deposit-Field"]

@index [Lsh]
Lsh (@i[N X]) pushes a fixnum that is @i[N] shifted left by @i[X] bits, with
0's shifted in on the right.  If @i[X] is negative, @i[N] is shifted to the
right with 0's coming in on the left.  Both @i[N] and @i[X] should be fixnums.
@begin[format]
@binstr[name = "Lsh"]
@instr[name = "Lsh-PSIC"]
@end[format]

@index [Logldb]
Logldb (@i[S P N]).  All args are fixnums.  @i[S] and @i[P] specify a ``byte''
or bit-field of any length within @i[N].  This is extracted and is pushed
right-justified as a fixnum.  @i[S] is the length of the field in bits; @i[P]
is the number of bits from the right of @i[N] to the beginning of the
specified field.  @i[P] = 0 means that the field starts at bit 0 of @i[N], and
so on.  It is an error if the specified field is not entirely within the 28
bits of @i[N]
@binstr[name = "Logldb"]

@index [Logdpb]
Logdpb (@i[V S P N]).  All args are fixnums.  Pushes a number equal to @i[N],
but with the field specified by @i[P] and @i[S] replaced by the @i[S] low-order
bits of @i[V].  It is an error if the field does not fit into the 28 bits of
@i[N].
@binstr[name = "Logdpb"]

@subsection [Branching and Dispatching]
@instrsection

Branch instructions add or subtract a 1 or 2 byte a relative offset to the PC
after the branch instruction and the offset bytes have been fetched.  The
opcode determines the direction of the branch and the number of offset bytes to
be fetched.

@index [Branch]
Branch-Forward (@i[Offset]) adds the 1 byte @i[Offset] to the PC.
Long-Branch-Forward adds a 2 byte @i[Offset].  Branch-Backward and
Long-Branch-Backward subtract 1 or 2 byte @i[Offset]s.
@begin[format]
@binstr[name = "Branch-Forward"]
@binstr[name = "Long-Branch-Forward"]
@binstr[name = "Branch-Backward"]
@binstr[name = "Long-Branch-Backward"]
@end[format]

@index [Branch-Null]
@index [Branch-Not-Null]
Branch-Null (@i[Offset]) pops the top item off the stack and branches if it is
NIL; Branch-Not-Null branches if it is not null.
@begin[format]
@binstr[name = "Branch-Null-Forward"]
@binstr[name = "Long-Branch-Null-Forward"]
@binstr[name = "Branch-Not-Null-Forward"]
@binstr[name = "Long-Branch-Not-Null-Forward"]
@binstr[name = "Branch-Null-Backward"]
@binstr[name = "Long-Branch-Null-Backward"]
@binstr[name = "Branch-Not-Null-Backward"]
@binstr[name = "Long-Branch-Not-Null-Backward"]
@end[format]

@index [Branch-Save-Not-Null]
Branch-Save-Not-Null (@i[Offset]) looks at the value in TOS.  If it is Nil, the
stack it is popped off the stack and we fall through.  Otherwise the stack is
left as is and we take the branch.
@begin[format]
@binstr[name = "Branch-Save-Not-Null-Forward"]
@binstr[name = "Long-Branch-Save-Not-Null-Forward"]
@binstr[name = "Branch-Save-Not-Null-Backward"]
@binstr[name = "Long-Branch-Save-Not-Null-Backward"]
@end[format]

@index[Dispatch]
Dispatch ().  The top of stack (TOS) is used as an index into a dispatch table
located in the current code vector.  The next byte in the instruction is a
limit.  If TOS is not a fixnum, a fixnum less than 0, or a fixnum greater than
or equal to the limit, no branch happens and we fall through, continuing with
the next instruction.  If TOS is within the specified bounds, however, it is
added to a 16-bit number formed by fetching the next 1 or 2 bytes from the
instruction stream.  This result is used as an index into the code vector, and
a 16-bit word is fetched from that memory location.  The offset into the
current code vector is set to this word.  The stack is popped whether or not
we branch.
@begin[format]
@binstr[name = "Dispatch"]
@binstr[name = "Long-Dispatch"]
@end[format]

@subsection [Function Call and Return]
@instrsection

@index [Call]
Call (@i[F]).  @i[F] must be some sort of executable function: a function
object, a lambda-expression, or a symbol with one of these stored in its
function cell.  A call frame for this function is opened.  This is explained in
more detail in the next chapter.
@begin[format]
@binstr[name = "Call"]
@instr[name = "Call-C"]
@instr[name = "Call-AL"]
@end[format]

@index [Call-0]
Call-0 (@i[F]).  @i[F] must be an executable function, as above, but is a
function of 0 arguments.  Thus, there is no need to collect arguments.  The
call frame is opened and activated in a single instruction.
@begin[format]
@binstr[name = "Call-0"]
@instr[name = "Call-0-C"]
@instr[name = "Call-0-AL"]
@end[format]

@index [Call-Multiple]
Call-Multiple (@i[F]).  Just like a Call instruction, but it sets bit 21 of the
frame header word to indicate that multiple values will be accepted.  See
section @ref[Multi].
@begin[format]
@binstr[name = "Call-Multiple"]
@instr[name = "Call-Multiple-C"]
@instr[name = "Call-Multiple-AL"]
@end[format]

@index [Start-Call]
Start-Call () closes the currently open call frame, and initiates a function
call.  See section @ref[Push-Last] for details.
@binstr[name = "Start-Call"]

@index [Push-Last]
Push-Last (@i[X]) pushes @i[X] as an argument, closes the currently open call
frame, and initiates a function call.  See section @ref[Push-Last] for details.
@begin[format]
@instr[name = "Push-Last-AL"]
@instr[name = "Push-Last-C"]
@instr[name = "Push-Last-S"]
@instr[name = "Push-Last-PSIC"]
@end[format]

@index [Return]
Return (@i[X]).  Return from the current function call.  After the current
frame is popped off the stack, @i[X] is pushed as the result being returned.
See section @ref[Return] for more details.
@begin[format]
@binstr[name = "Return"]
@instr[name = "Return-C"]
@instr[name = "Return-AL"]
@end[format]

@index [Escape-Return]
Escape-Return (@i[X]).  If the current call frame has an escape frame header,
this works like a normal return, but the value @i[X] is put in the destination
indicated in the header rather than just being returned on the stack.  If the
current frame is not an escape frame, just return the single value on the stack
as a normal return would.
@binstr[name = "Escape-Return"]

@index [Break-Return]
Break-Return (@i[]).  If the header of the current call frame indicates a break
frame, do a Return, but push no return value on the stack.  If the current
frame is not an escape frame, return NIL.
@binstr[name = "Break-Return"]

@index [Catch]
Catch (@i[]) builds a catch frame.  The top of stack should hold the tag caught
by this catch frame, and the next entry on the stack should be a saved-format
PC (which will come from the constants vector of the function).  See section
@ref[Catch] for details.
@binstr[name = "Catch"]

@index [Catch-Multiple]
Catch-Multiple (@i[]) builds a multiple-value catch frame.  The top of stack
should hold the tag caught by this catch frame, and the next entry on the stack
should be a saved-format PC.  See section @ref[Catch] for details.
@binstr[name = "Catch-Multiple"]

@index [Catch-All]
Catch-All (@i[]) builds a catch frame whose tag is the special Catch-All
object.  The top of stack should hold the saved-format PC, which is the address
to branch to if this frame is thrown through.  See section @ref[Catch]
for details.
@binstr[name = "Catch-All"]

@index [Throw]
Throw (@i[X]).  @i[X] is the throw-tag, normally a symbol.  The value to be
returned, either single or multiple, is on the top of the stack.  See section
@ref[Catch] for a description of how this instruction works.
@begin[format]
@binstr[name = "Throw"]
@instr[name = "Throw-C"]
@end[format]

@subsection [Miscellaneous]
@instrsection

@index [Eq]
Eq (@i[X Y]) pushes T if @i[X] and @i[Y] are the same object, NIL otherwise.
@begin[format]
@binstr[name = "Eq"]
@instr[name = "Eq-AL"]
@instr[name = "Eq-C"]
@end[format]

@index [Eql]
Eql (@i[X Y]) pushes T if @i[X] and @i[Y] are the same object or if @i[X] and
@i[Y] are numbers of the same type with the same value, NIL otherwise.
@begin[format]
@binstr[name = "Eql"]
@instr[name = "Eql-AL"]
@instr[name = "Eql-C"]
@end[format]

@index [Set-Null]
Set-Null (@i[E]) sets @i[CE] to NIL.
@begin[format]
@binstr[name = "Set-Null"]
@instr[name = "Set-Null-AL"]
@end[format]

@index [Set-T]
Set-T (@i[E]) sets @i[CE] to T.
@begin[format]
@binstr[name = "Set-T"]
@instr[name = "Set-T-AL"]
@end[format]

@index [Set-0]
Set-0 (@i[E]) sets @i[CE] to 0.
@begin[format]
@binstr[name = "Set-0"]
@instr[name = "Set-0-AL"]
@end[format]

@index [Make-Predicate]
Make-Predicate (@i[X]) pushes NIL if @i[X] is NIL or T if it is not.
@begin[format]
@binstr[name = "Make-Predicate"]
@instr[name = "Make-Predicate-AL"]
@end[format]

@index [Not-Predicate]
Not-Predicate (@i[X]) pushes T if @i[X] is NIL or NIL if it is not.
@begin[format]
@binstr[name = "Not-Predicate"]
@instr[name = "Not-Predicate-AL"]
@end[format]

@index [Values-To-N]
Values-To-N (@i[V]).  @i[V] must be a Values-Marker.  Returns the number
of values indicated in the low 24 bits of @i[V] as a fixnum.
@instr[name = "Values-To-N"]

@index [N-To-Values]
N-To-Values (@i[N]).  @i[N] is a fixnum.  Returns a Values-Marker with the
same low-order 24 bits as @i[N].
@instr[name = "N-To-Values"]

@index [Force-Values]
Force-Values (@i[]).  If the top of the stack is a Values-Marker, do
nothing; if not, push Values-Marker 1.
@instr[name = "Force-Values"]

@index [Flush-Values]
Flush-Values (@i[]).  If the top of the stack is a Values-Marker, remove
this marker; if not, do nothing.
@instr[name = "Flush-Values"]

@subsection [System Hacking]
@label [System-Hacking-Instructions]
@instrsection

@index [Get-Type]
Get-Type (@i[Object]) pushes the five type bits of the @i[Object] as a fixnum.
@begin[format]
@binstr[name = "Get-Type"]
@instr[name = "Get-Type-AL"]
@end[format]

@index [Get-Space]
Get-Space (@i[Object]) pushes the two space bits of @i[Object] as a fixnum.
@binstr[name = "Get-Space"]

@index [Make-Immediate-Type]
Make-Immediate-Type (@i[X A]) pushes an object whose type bits are the integer
@i[A] and whose other bits come from the immediate object or pointer @i[X].
@i[A] should be an immediate type code.
@binstr[name = "Make-Immediate-Type"]

@index [8bit-System-Ref]
8bit-System-Ref (@i[X I]).  If @i[X] is an I-Vector, pushes the @i[I]'th byte
of @i[X], indexing into @i[X] as an 8-bit I-Vector.  If @i[X] is a system area
pointer, pushes the @i[I]'th byte beyond @i[X] as a fixnum.  @i[I] must be a
fixnum.
@instr[name = "8bit-System-Ref"]

@index [8bit-System-Set]
8bit-System-Set (@i[X I V]).  If @i[X] is an I-Vector, sets the @i[I]'th
element of @i[X] to @i[V], indexing into @i[X] as an 8-bit I-Vector.  If @i[X]
is a system area pointer, sets the @i[I]'th byte beyond @i[X] to @i[V].
@instr[name = "8bit-System-Set"]

@index [16bit-System-Ref]
16bit-System-Ref (@i[X I]).  If @i[X] is an I-Vector, pushes the @i[I]'th
16-bit word of @i[X], indexing into @i[X] as a 16-bit I-Vector.  If @i[X] is a
system area pointer, pushes the @i[I]'th word beyond @i[X] as a fixnum.
@i[I] must be a fixnum.
@instr[name = "16bit-System-Ref"]

@index [16bit-System-Set]
16bit-System-Set (@i[X I V]).  If @i[X] is an I-Vector, sets the @i[I]'th
element of @i[X] to @i[V], indexing into @i[X] as a 16-bit I-Vector.  If
@i[X] is a system area pointer, sets the @i[I]'th word beyond @i[X] to @i[V].
@instr[name = "16bit-System-Set"]

@index [Collect-Garbage]
Collect-Garbage (@i[]) causes a stop-and-copy GC to be performed.
@instr[name = "Collect-Garbage"]

@index [Newspace-Bit]
Newspace-Bit (@i[]) pushes 0 if newspace is currently space 0 or 1 if it is 1.
@instr[name = "Newspace-Bit"]

@index [Set-Newspace-For-Type]
Set-Newspace-For-Type (@i[type space]) sets the next newspace free pointer for
the type corresponding to the @i[type] number to the space corresponding to the
@i[space] number.  There is about one useful thing that you can do with this
instruction; see section @ref[PURIFY].  There are a number of not-so-useful but
very fun things that you can do with this instruction that are not documented
here.
@instr[name = "Set-Newspace-For-Type"]

@index [Kernel-Trap]
Kernel-Trap (@i[Argblock Code]) is for communication with the Accent Kernel.
@i[Code] is the type of trap desired (a fixnum), and @i[Argblock] is an
I-Vector containing assorted argument information.  See section @ref[Trap] for
details.
@instr[name = "Kernel-Trap"]

@index [Halt]
Halt (@i[]) stops the execution of Lisp.  If continued, T is pushed on the
stack.
@instr[name = "Halt"]

@index [Arg-In-Frame]
Arg-In-Frame (@i[N F]).  @i[N] is a fixnum, @i[F] is a control stack pointer as
returned by the Active-Call-Frame and Open-Call-Frame instructions.
Pushes the item in slot @i[N] of the args-and-locals area of call frame @i[F].
@instr[name = "Arg-In-Frame"]

@index [Active-Call-Frame]
Active-Call-Frame (@i[]) pushes a control-stack pointer to the start of the
currently active call frame.  This will be of type Misc-Control-Stack-Pointer.
@instr[name = "Active-Call-Frame"]

@index [Active-Catch-Frame]
Active-Catch-Frame (@i[]) pushes the control-stack pointer to the start of the
currently active catch frame.  This is Nil if there is no active catch.
@instr[name = "Active-Catch-Frame"]

@index [Set-Call-Frame]
Set-Call-Frame (@i[P]).  @i[P] must be a control stack pointer.  This becomes
the current active call frame pointer.
@instr[name = "Set-Call-Frame"]

@index [Current-Open-Frame]
Current-Open-Frame (@i[]) pushes a control-stack pointer to the start of the
currently open call frame.  This will be of type Misc-Control-Stack-Pointer.
@instr[name = "Current-Open-Frame"]

@index [Set-Open-Frame]
Set-Open-Frame (@i[P]).  @i[P] must be a control stack pointer.  This becomes
the current open frame pointer.
@instr[name = "Set-Open-Frame"]

@index [Current-Stack-Pointer]
Current-Stack-Pointer (@i[]) pushes the Misc-Control-Stack-Pointer that points
to the current top of the stack (before the result of this operation is
pushed).  Note: by definition, this points to the first unused word of the
stack, not to the last thing pushed.  The stack manipulation instructions make
it appear as if the stack is all in contiguous virtual memory, despite the fact
that the TOS register will be holding the top word of the stack.
@instr[name = "Current-Stack-Pointer"]

@index [Current-Binding-Pointer]
Current-Binding-Pointer (@i[]) pushes a Misc-Binding-Stack-Pointer that points
to the first word above the current top of the binding stack.
@instr[name = "Current-Binding-Pointer"]

@index [Read-Control-Stack]
Read-Control-Stack (@i[F]).  @i[F] must be a control stack pointer.  Pushes
the Lisp object that resides at this location.  If the addressed object is
totally outside the current stack, this is an error.
@instr[name = "Read-Control-Stack"]

@index [Write-Control-Stack]
Write-Control-Stack (@i[F V]).  @i[F] is a stack pointer, @i[V] is any Lisp
object.  Writes @i[V] into the location addressed.  If the addressed cell is
totally outside the current stack, this is an error.  Obviously, this should
only be used by carefully written and debugged system code, since you can
destroy the world by using this instruction.
@instr[name = "Write-Control-Stack"]

@index [Read-Binding-Stack]
Read-Binding-Stack (@i[B]).  @i[B] must be a binding stack pointer.  Reads and
returns the Lisp object at this location.  An error if the location specified
is outside the current binding stack.
@instr[name = "Read-Binding-Stack"]

@index [Write-Binding-Stack]
Write-Binding-Stack (@i[B V]).  @i[B] must be a binding stack pointer.  Writes
@i[V] into the specified location.  An error if the location specified is
outside the current binding stack.
@instr[name = "Write-Binding-Stack"]

@chapter [Control Conventions]
@label [Control-Conventions]
@index [Hairy stuff]

@section [Function Calls]

@subsection [Starting a Function Call]
@index [Call]
@index [Call-0]
@index [Call-Multiple]

The Call and Call-Multiple instructions open a call frame on the control stack,
but do not transfer control to the called function.  The arguments for the
function are then evaluated and pushed on the stack, and the call is started by
a Push-Last instruction.  Call-Multiple sets bit 21, the
multiple-values-accepted bit, of the call frame to indicate that it will
accept multiple-values.  Call-0 opens the call frame and does the equivalent of
a Start-Call instruction (see below) to start the called function.  All these
instructions take the function to be called as @i[CE].

If @i[CE] is a symbol, we fetch the contents of the symbol's definition cell.
If it is a Misc-Trap or another symbol, we signal an error.  Otherwise, we go
on with this definition as the function.  We do not allow chains of symbols
defined as other symbols.  If @i[CE] is a compiled function, we perform the
following steps:
@begin [enumerate]
Note the current value of the Control-Stack-Pointer register.

Push a Call-Frame-Header on control stack (with bit 21 set if this is a
Call-Multiple).

Push @i[CE] (the function being called).

Push the Active-Frame register.

Push the Open-Frame register.

Push Binding-Stack-Pointer.

Push Fixnum -1 or some other easy-to-generate value.  This will later be
filled with caller's PC.

Open-Frame <== Stack frame pointer saved in step 1.
@end [enumerate]
The open frame is now ready to have arguments pushed.

If @i[CE] is a list, it is probably a lambda-expression or interpreted lexical
closure.  The call proceeds as above, with the list stored in the function slot
of the new frame.  The arguments are pushed normally, and %SP-Internal-Apply
will be called when the Push-Last is executed.  %SP-Internal-Apply verifies
that this function is a lambda or lexical closure.

If @i[CE] is anything else, an Illegal-Function error is signalled.

@subsection [Finishing a Function Call]
@label [Push-Last]
@index [Push-Last]
@index [Start-Call]
@index [Call-0]

Push-Last pushes a final argument @i[X] and starts the function responsible for
the current open frame.  Start-Call just starts the function.  Call-0 opens the
frame and performs the equivalent of a Start-Call immediately, since there
are no arguments to push.

We look at the function entry of the current open frame.  If this contains a
compiled function object, proceed as follows:
@begin [enumerate]
Insert the current PC (points to the NEXT instruction of the caller's code
vector) in the PC slot of the open frame.

Active-Function <== Called function (from slot 1 of open frame).

Active-Code <== Code vector for new active function.

Active-Frame <== Open-Frame

@begin [multiple]
Note number of args pushed by caller.  Let this be K.  We must now
compute the proper entry point in the called function's code vector as a
function of K and the number of args the called function wants.

@begin [enumerate]
If number of args < minimum, signal an error.

If number of args > maximum and no &REST arg is allowed, signal an error.

If number of args > maximum and a &REST arg is present, pop excess
args into a list, push this list back on stack as the &REST arg,
and start at offset 0.

If number of args is between min and max (inclusive), get the starting offset
from the appropriate slot of the called function's function object.
This is stored as a fixnum in slot K - MIN + 6 of the function object.
@end [enumerate]
@end [multiple]

Set up the new PC to point at the right place in the code vector and
return to the macro-code execution loop to run the new function.  This involves
setting up PC, the BPC, and refilling the instruction buffer.
@end [enumerate]

@index [%SP-Internal-Apply]
If the object in the function entry is a list instead of a function object, we
must call %SP-Internal-Apply to interpret the function with the given
arguments.  We proceed as follows:
@begin [enumerate]
Note the number of args pushed in the current open frame (call this N)
and the frame pointer for this frame (call it F).  Also remember the
lambda-expression in this frame (call it L).

Perform steps 1 - 4 of the sequence above for a normal Start-Call.

Perform the equivalent of a Call-Multiple instruction with the symbol
%SP-Internal-Apply as @i[CE].  (This symbol is in a fixed location known to the
microcode.  See section @ref[Known-Objects].)

Push L, N, and F in that order as the three arguments to %SP-Internal-Apply.

Perform the equivalent of a Push-Last-Stack to start the call.
@end [enumerate]
%SP-Internal-Apply, a function of three arguments, now evaluates the call to
the lambda-expression or interpreted lexical closure L, obtaining the arguments
from the frame pointed to by F.  These arguments are obtained using the
Arg-In-Frame instruction.  Prior to returning %SP-Internal-Apply sets the
Active-Frame register to F, so that it returns from frame F.

@subsection [Returning from a Function Call]
@label [Return]
@index [Return]

Return returns from the current function, popping the stack frame and pushing
some number of returned values.  If @i[CE] is a Values-Marker but bit 21
is not on in the current call frame, only one value is returned.  If bit 21 is
on, either multiple values or a single value will be returned.  The steps are
as follows:
@begin [enumerate]
Pop binding stack back to value saved in slot 5 of the active control frame.
For each symbol/value pair popped off the binding stack, restore that value for
the symbol.

Temp <== Previous active frame from slot 3 of current frame.

Open-Frame <== Saved value in current frame.

PC <== Saved value in current frame.  This requires setting up the internal PC,
the BPC, and the instruction buffer.

Active-Function <== Saved value from previous frame.  A pointer to
this frame is in Temp.

Active-Code <== Code Vector obtained from entry in restored
Active-Function object.

Pop current frame off stack:
@begin [display]
Control-Stack-Pointer <== Active-Frame.
Active-Frame <== Temp.
Pop top of stack into TOS register.  Since the active frame is inside
  the barrier, make sure the new top frame has been scavenged, or do it now.
@end [display]

Push the return value onto the stack.

Resume execution of function popped to.
@end[enumerate]

@subsection [Returning Multiple-Values]
@label [Multi]
@index [Multiple values]

If bit 21 is on in the current frame and a Values-Marker indicating N values is
on the top of the stack, we proceed as follows:
@begin [enumerate]
Note the value of the current stack pointer (after @i[CE] is popped off if
it came from the stack) as OLDSP.

Perform steps 1 - 7 of the Return procedure described above.

Do a block transfer loop pushing the N words starting at (OLDSP) - N onto the
stack as return values.  Then push the original @i[CE], which is
Values-Marker N.

Resume execution of the caller.
@end [enumerate]

To do @t[(MULTIPLE-VALUE-LIST (FOO A B))], we could use this sequence of
instructions:
@begin [example]
	(CALL-MULTIPLE (CONSTANT [FOO]))
	(PUSH [A])
	(PUSH-LAST [B])
	(FORCE-VALUES)
	(VALUES-TO-N STACK)
	(LIST STACK)	;Pop N from stack, then listify N things.
@end [example]

To do @t[(MULTIPLE-VALUE-SETQ (X Y Z) (FOO A B))], we could use this code:
@begin [example]
	(CALL-MULTIPLE (CONSTANT [FOO]))
	(PUSH [A])
	(PUSH-LAST [B])
	(FORCE-VALUES)
	(VALUES-TO-N STACK)
	(- (CONSTANT [3]))	;Get number offered - number wanted.
	(NPOP STACK)		;Flush surplus returns or push NILs.
	(POP [Z])		;Now put the three values wherever they
	(POP [Y])		; are supposed to go.
	(POP [X])
@end [example]

In tail recursive situations, such as in the last form of a PROGN, one
function, FOO, may want to call another function, BAR, and return ``whatever
BAR returns.''  Call-Multiple is used in this case.  If BAR returns multiple
values, they will all be passed to FOO.  If FOO's caller wants multiple values,
the values will be returned.  If not, FOO's Return instruction will see that
there are multiple values on the stack, but that multiple values will not be
accepted by FOO's caller.  So Return will return only the first value.

@section [Non-Local Exits]
@label [Catch]
@index [Catch]
@index [Throw]
@index [Catch-All object]
@index [Unwind-Protect]
@index [Non-Local Exits]

The Catch and Unwind-Protect special forms are implemented using catch frames.
Unwind-Protect builds a catch frame whose tag is the Catch-All object.  The
Catch instruction creates a catch frame for a given tag and PC to branch to in
the current instruction.  The Throw instruction looks up the stack by following
the chain of catch frames until it finds a frame with a matching tag or a frame
with the Catch-All object as its tag.  If it finds a frame with a matching tag,
that frame is ``returned from,'' and that function is resumed.  If it finds a
frame with the Catch-All object as its tag, that frame is ``returned from,''
and in addition, %SP-Internal-Throw-Tag is set to the tag being searched for.
So that interrupted cleanup forms behave correctly, %SP-Internal-Throw-Tag
should be bound to the Catch-All object before the Catch-All frame is built.
The protected forms are then executed, and if %SP-Internal-Throw-Tag is not the
Catch-All object, its value is thrown to.  Exactly what we do is this:
@begin [enumerate]
Put the contents of the Active-Catch register into a register, A.  Put NIL into
another register, B.

If A is NIL, the tag we seek isn't on the stack.  Signal an Unseen-Throw-Tag
error.

Look at the tag for the catch frame in register A.  If it's the tag we're
looking for, go to step 4.  If it's the Catch-All object and B is NIL, copy A
to B.  Set A to the previous catch frame and go back to step 2.

If B is non-NIL, we need to execute some cleanup forms.  Return into B's frame
and bind %SP-Internal-Throw-Tag to the tag we're searching for.  When the
cleanup forms are finished executing, they'll throw to this tag again.

If B is NIL, return into this frame, pushing the return value (or BLTing the
multiple values if this frame has bit 21 set and there are multiple values).
@end [enumerate]

If no form inside of a Catch results in a Throw, the catch frame needs to be
removed from the stack before execution of the function containing the throw is
resumed.  For now, the value produced by the forms inside the Catch form are
thrown to the tag.  Some sort of specialized instruction could be used for
this, but right now we'll just go with the throw.  The branch PC specified by a
Catch instruction is part of the constants area of the function object, much
like the function's entry points.  To do
@begin [example]
   (catch 'foo
     (baz)
     (bar))
@end [example]
we could use this code:
@begin [example]
	(PUSH (CONSTANT [PC-FOR-TAG-1]))
	(PUSH (CONSTANT [FOO]))
	(CATCH STACK)
	(CALL-0 (CONSTANT [BAZ]))
	(POP IGNORE)
	(CALL-0 (CONSTANT [BAR]))
	(PUSH (CONSTANT [FOO]))
	(THROW STACK)
	TAG-1
@end [example]

To do
@begin [example]
   (unwind-protect
      (baz)
      (bar))
@end [example]
we could use this code:
@begin [example]
	(PUSH (SYMBOL %CATCH-ALL-OBJECT))
	(PUSH (CONSTANT %SP-INTERNAL-THROW-TAG))
	(BIND STACK)
	(PUSH (CONSTANT [PC-FOR-TAG-1]))
	(CATCH-ALL STACK)
	(CALL-0 (CONSTANT [BAZ]))
	(PUSH (SYMBOL %CATCH-ALL-OBJECT))
	(THROW STACK)
	TAG-1
	(CALL-0 (CONSTANT [BAR]))
	(POP IGNORE)
	(PUSH (SYMBOL %CATCH-ALL-OBJECT))
	(EQ (SYMBOL %SP-INTERNAL-THROW-TAG))
	(BRANCH-NOT-NULL TAG-2)
	(PUSH (SYMBOL %SP-INTERNAL-THROW-TAG))
	(THROW STACK)
	TAG-2
@end [example]

@section [Escaping to Macrocode]
@label [Escape]
@index [Escape to macrocode convention]

Some instructions can be complex (e.g. * given a long-float and a bignum), and
with limited microstore (and microprogrammer time) on the PERQ, we would like
to handle these in Lisp code.  Such cases could be handled by a full-scale
microcode-to-macrocode subroutine call, which upon a return comes back to the
designated return address in the microcode and restores any micro-state that
may have been clobbered.  This may ultimately be needed if we ever implement a
micro-compiler for lisp, but for now we can get by with a simpler scheme.  If
the microcode for any macro-instruction decides that it has a case too
difficult to handle, it can call a macrocoded function that does whatever the
original macro-instruction was supposed to do.  It does this by opening an
escape-type frame on the control stack, pushing an appropriate set of
arguments, and then starting the call as though a push-last had been done in
macrocode.

When the macrocoded escape function returns (the Escape-Return instruction
must be used for this return) the single returned value goes wherever the
original macro-instruction was supposed to place its result, and the original
instruction stream continues on as if the macrocode instruction had exited
normally without an escape.

Instructions can place their return values in any of several destinations.  The
escape call must set up the frame header word to indicate which of these
locations is to get the value returned by the macro-coded escape function.  An
appropriate effective-address code is stored in bits 16-17:
@begin[description]
0 Stack@\The result is pushed onto the stack.

1 AL@\The result is put into the arguments/locals area of the current call
frame.  Bits 0-15 contain a 16-bit offset.

2 Symbol@\The result is put into the value cell of a symbol in the symbols and
constants area of the current function object.  Bits 0-15 contain a 16-bit
offset.

3 Ignore@\The result is thrown away.
@end[description]
Given this information in the frame header, Escape-Return will do the right
thing to make it appear that the original instruction had exited normally.

@index [TRUNCATE]
Some instructions, notably Truncate, may want to return multiple values from an
escape function.  These values will always be returned on the stack.  In this
case, the escape mechanism builds a multiple-value call frame rather than an
escape call frame, then escapes in the usual way.  The escape routine for
Truncate is exited using a normal Return instruction.

A table of pointers to the Lisp-level escape functions is stored in a fixed
location in virtual memory, and the address of the start of this table is known
to the microcode.  This means that microcode routines can select the desired
function by means of a table index, and it is not necessary to assemble the
addresses of all these functions into the microcode.

The escape mechanism is implemented by a micro-subroutine named ESCAPE, which
can be called (or rather, jumped to, since ESCAPE never returns to the caller)
by any microcode that wants to escape to macrocode.  ESCAPE is passed the
index of the macro-function to be called and from 0 to 4 lisp objects as
arguments on the PERQ E-Stack.  ESCAPE then performs the following steps:
@begin [enumerate]
It is determined where the currently executing instruction is going to place
its result, and an appropriate escape-type call header word is generated.

A pointer to the desired function object is fetched from the table of escape
functions, as determined by the index that was passed to ESCAPE.

The equivalent of a Call instruction is executed for this function object, but
the header word determined in step 1 is used instead of the normal header word.

The specified arguments, if any, are pushed onto the control stack.  The new
function is then started by executing the equivalent of a Push-Last
instruction.
@end [enumerate]
A second entry point, ESCAPE-MULTIPLE, does the same thing as ESCAPE but
creates a multiple-value frame header instead of an escape frame header.

@section [Errors]
@label [Errors]
@index [Errors]

When an error occurs during the execution of an instruction, a call to
%SP-Internal-Error is performed.  This call is a break-type call, so if the
error is proceeded (with a Break-Return instruction), no value will be pushed
on the stack.

%SP-Internal-Error is passed a fixnum error code as its first argument.  The
second argument is a fixnum offset into the current code vector that points to
the location immediately following the instruction that encountered the
trouble.  From this offset, the Lisp-level error handler can reconstruct the PC
of the losing instruction, which is not readily available in the micro-machine.
Following the offset, there may be 0 - 2 additional arguments that provide
information of possible use to the error handler.  For example, an
unbound-symbol error will pass the symbol in question as the third arg.

A Lisp-Level error handler may want to provide a result for the instruction.
It can find the losing instruction in the way described above, and look at it's
opcode to find the destination.  The error handler could then store the
user-supplied result in the specified place and proceed executing the errorful
function at the instruction after the losing instruction.

The following error codes are currently defined.  Unless otherwise specified,
only the error code and the code-vector offset are passed as arguments.

@b[The following table is pretty bogus.  After the microcode is written,
and I know what errors are really generated, I'll make a newer table.]

@begin [description]
1  Control Stack Overflow @\The control stack has exceeded the allowable
size, currently 2@+[24] words.

2  Control Stack Underflow @\Can only result from a compiler bug or
misuse of an instruction.

3  Binding Stack Overflow @\The binding stack has exceeded the allowable
size, currently 2@+[24] words.

4  Binding Stack Underflow @\Can only result from a compiler bug or
misuse of an instruction.

5  Virtual Memory Overflow @\Some data space has exceeded the maximum
size of its segment in virtual memory.

6 Unbound Symbol @\Attempted access to the special value of an unbound symbol.
Passes the symbol as the third argument to %Sp-Internal-Error.

7 Undefined Symbol @\Attempted access to the definition cell of an undefined
symbol.  Passes the symbol as the third argument to %Sp-Internal-Error.

8 Unused.

9 Altering T or NIL @\Attempt to bind or setq the special value of T or NIL.

10 Unused.

11 Write Into Read-Only Space @\Self-explanatory.

12 Object Not Character @\The object is passed as the third argument.

13 Object Not System Area Pointer @\The object is passed as the third
argument.

14 Object Not Control Stack Pointer @\The object is passed as the third
argument.

15 Obj     ot Binding Stack Pointer @\The object is passed as the third
argument.

16 Object Not Values Marker @\The object is passed as the third argument.

17 Object Not Fixnum @\The object is passed as the third argument.

18 Object Not Vector-Like @\The object is passed as the third argument.

19 Object Not Integer-Vector @\The object is passed as the third argument.

20 Object Not Symbol @\The object is passed as the third argument.

21 Object Not List @\The object is passed as the third argument.

22 Object Not List or Nil @\The object is passed as the third argument.

23 Object Not String @\The object is passed as the third argument.

24 Object Not Number @\The object is passed as the third argument.

25 Object Not Misc Type @\The object is passed as the third argument.

26 Unused.

27 Illegal Allocation Space Value @\Self explanatory.

28 Illegal Vector Size @\Attempt to allocate a vector with negative size or
size too large for vectors of this type.  Passes the requested size as the
third argument.

29 Illegal Immediate Type Code @\Passes the code as the third argument.

30 Illegal Control Stack Pointer @\Passes the illegal pointer as the third
argument.

31 Illegal Binding Stack Pointer @\Passes the illegal pointer as the third
argument.

32 Illegal Instruction @\Must be due to a compiler error or to using
obsolete code that does not match the current microcode.  No additional args.

33 Unused.

34 Illegal Divisor @\The divisor is integer or floating 0.  Returns the divisor
and dividend as the third and fourth args.

35 Illegal Vector Access Type @\The specified access type is returned as the
third argument.

36 Illegal Vector Index @\The specified index is out of bounds for this vector.
The bad index is passed as the third argument.

37 Illegal Byte Pointer @\Bad S or P value to LDB or related function.  Returns
S and P as the third and fourth arguments.

38 Illegal Function @\Bad object being called as a function.  The object is
passed as the third argument.

39 Too Few Arguments @\Attempt to activate the call to a function with too few
arguments on the stack.  Returns the number of arguments passed as the third
argument, the function being called as the fourth.

40 Too Many Arguments @\Attempt to activate the call to a function with too few
arguments on the stack.  Returns the number of arguments passed as the third
argument, the function being called as the fourth.

41 Unseen Throw Tag @\Returns the tag as the third argument.

42 Null Open Frame @\Attempt to activate a function call, but no frame has been
opened.  No additional args.

43 Undefined Type Code @\Can only result from a bug in the micro-machine.
Returns the strange object as the third argument.

44 Return From Initial Function @\Self-explanatory.

45 GC Forward Not To Newspace @\Can only result from internal errors in the
micro-machine.  No additional args.

46 Attempt To Transport GC Forward @\Can only result from internal errors in
the micro-machine.  No additional args.

47 Object Not Integer @\The object is passed as the third argument.

48 Short-float exponent overflow, underflow @\No additional args.

49 Long-float exponent overflow, underflow @\No additional args.

50 - 63 Unused.
@end [description]
In the Tops-20 virtual machine, the following codes are defined:
@Begin[Description]
64 Illegal File Token @\The bad token is passed as the third argument.

65 Illegal I/O Mode Specifier @\The bad mode is passed as the third argument.
@End[Description]

@section [Trapping to the Accent Kernel]
@label [Trap]
@index [Trapping to the kernel]
@index [Kernel traps]

Most of the primitive calls to the Accent kernel are made through a single
microcode entry point, SVCall, defined in Accent file process.mic.  From Lisp
level, these calls are generated by the Kernel-Trap instruction.

Kernel-Trap takes two operands, an argument block and a trap code, in that
order.  The trap code is a fixnum which specifies the sort of trap call
desired.  The argument block is an I-Vector which contains the argument
information for the trap call.  The size and format of the argument block
depends on which trap code is called.  The return codes and values from the
trap are written into elements of the I-Vector by the kernel.

Internally, the trap code and a pointer to the data portion of the I-Vector are
passed to Accent on the PERQ E-Stack, as follows:
@begin [description]
ETOS @\ The trap code.

ETOS - 1 @\ The low order 16 bits of the virtual address.

ETOS - 2 @\ The high order 16 bits of the virtual address.
@end [description]

All of the kernel traps called by Lisp-level code use the virtual address as a
pointer to an argument block.  An argument block is stored at lisp level as an
I-Vector of 16-bit quantities.  The trap codes are defined in Accent file
accenttype.pas, and the arguments to these calls are described in the @i[Accent
Kernel Interface Manual].

@section [Interrupts]
@label [Interrupts]
@index [Interrupts]

There are three kinds of asynchronous events that the Spice Lisp system must
service: hardware interrupts, process breaks, and software interrupts.

Hardware interrupts must be serviced every 70 microinstructions.  It is
guaranteed that no process registers will be altered and no page faults will
occur, so all a microprogrammer need do is check the Intr-Pending condition
every now and then, and call the hardware interrupt service routine.
Sometimes that routine will set the process break flag, and a process break
should occur.

If there are other runnable processes on the machine, a process break will
result in the de-scheduling of the Lisp process.  Process registers will be
saved by the kernel, and restored when the Lisp runs again.  After a process
break, all cached virtual-to-physical memory translations may be invalid and
the instruction buffer will probably be filled with some other process's
instructions.  The caches must be flushed and the instruction buffer must be
refilled after a process break.

After a process break, it is possible that the Lisp process will have received
an ``emergency message'' from some other process.  If so, the software
interrupt flag will be set.  To service this software interrupt, a break-type
call frame is built to %SP-Software-Interrupt-Handler, which should receive the
message and figure out what to do with it at Lisp level.  The emergency message
might, for example, report that an interrupt character has been typed, and the
interrupt handler could enter a break loop or throw to the Lisp top level.

@appendix [Fasload File Format]
@section [General]

The purpose of Fasload files is to allow concise storage and rapid loading of
Lisp data, particularly function definitions.  The intent is that loading a
Fasload file has the same effect as loading the ASCII file from which the
Fasload file was compiled, but accomplishes the tasks more efficiently.  One
noticeable difference, of course, is that function definitions may be in
compiled form rather than S-expression form.  Another is that Fasload files may
specify in what parts of memory the Lisp data should be allocated.  For
example, constant lists used by compiled code may be regarded as read-only.

In some Lisp implementations, Fasload file formats are designed to allow
sharing of code parts of the file, possibly by direct mapping of pages of the
file into the address space of a process.  This technique produces great
performance improvements in a paged time-sharing system.  Since the Spice
project is to produce a distributed personal-computer network system rather
than a time-sharing system, efficiencies of this type are explicitly @i[not] a
goal for the Spice Lisp Fasload file format.

On the other hand, Spice Lisp is intended to be portable, as it will eventually
run on a variety of machines.  Therefore an explicit goal is that Fasload files
shall be transportable among various implementations, to permit efficient
distribution of programs in compiled form.  The representations of data objects
in Fasload files shall be relatively independent of such considerations as word
length, number of type bits, and so on.  If two implementations interpret the
same macrocode (compiled code format), then Fasload files should be completely
compatible.  If they do not, then files not containing compiled code (so-called
"Fasdump" data files) should still be compatible.  While this may lead to a
format which is not maximally efficient for a particular implementation, the
sacrifice of a small amount of performance is deemed a worthwhile price to pay
to achieve portability.

The primary assumption about data format compatibility is that all
implementations can support I/O on finite streams of eight-bit bytes.  By
"finite" we mean that a definite end-of-file point can be detected irrespective
of the content of the data stream.  A Fasload file will be regarded as such a
byte stream.

@section [Strategy]

A Fasload file may be regarded as a human-readable prefix followed by code in a
funny little language.  When interpreted, this code will cause the construction
of the encoded data structures.  The virtual machine which interprets this code
has a @i[stack] and a @i[table], both initially empty.  The table may be
thought of as an expandable register file; it is used to remember quantities
which are needed more than once.  The elements of both the stack and the table
are Lisp data objects.  Operators of the funny language may take as operands
following bytes of the data stream, or items popped from the stack.  Results
may be pushed back onto the stack or pushed onto the table.  The table is an
indexable stack that is never popped; it is indexed relative to the base, not
the top, so that an item once pushed always has the same index.

More precisely, a Fasload file has the following macroscopic organization.  It
is a sequence of zero or more groups concatenated together.  End-of-file must
occur at the end of the last group.  Each group begins with a series of
seven-bit ASCII characters terminated by one or more bytes of all ones
(FF@-(16)); this is called the @i[header].  Following the bytes which terminate
the header is the @i[body], a stream of bytes in the funny binary language.
The body of necessity begins with a byte other than FF@-(16).  The body is
terminated by the operation @t[FOP-END-GROUP].

The first nine characters of the header must be "@t[FASL FILE]" in upper-case
letters.  The rest may be any ASCII text, but by convention it is formatted in
a certain way.  The header is divided into lines, which are grouped into
paragraphs.  A paragraph begins with a line which does @i[not] begin with a
space or tab character, and contains all lines up to, but not including, the
next such line.  The first word of a paragraph, defined to be all characters up
to but not including the first space, tab, or end-of-line character, is the
@i[name] of the paragraph.  A Fasload file header might look something like
this:
@begin(verbatim)
FASL FILE >SteelesPerq>User>Guy>IoHacks>Pretty-Print.Slisp
Package Pretty-Print
Compiled 31-Mar-1988 09:01:32 by some random luser
Compiler Version 1.6, Lisp Version 3.0.
Functions: INITIALIZE DRIVER HACK HACK1 MUNGE MUNGE1 GAZORCH
	   MINGLE MUDDLE PERTURB OVERDRIVE GOBBLE-KEYBOARD FRY-USER
	   DROP-DEAD HELP CLEAR-MICROCODE %AOS-TRIANGLE
	   %HARASS-READTABLE-MAYBE
Macros:    PUSH POP FROB TWIDDLE
@r[<one or more bytes of FF@-(16)>]
@end(verbatim)
The particular paragraph names and contents shown here are only intended as
suggestions.

@section [Fasload Language]

Each operation in the binary Fasload language is an eight-bit (one-byte)
opcode.  Each has a name beginning with "@t[FOP-]".  In the following
descriptions, the name is followed by operand descriptors.  Each descriptor
denotes operands that follow the opcode in the input stream.  A quantity in
parentheses indicates the number of bytes of data from the stream making up the
operand.  Operands which implicitly come from the stack are noted in the text.
The notation "@z[@@] stack" means that the result is pushed onto the stack;
"@z[@@] table" similarly means that the result is added to the table.  A
construction like "@i[n](1) @i[value](@i[n])" means that first a single byte
@i[n] is read from the input stream, and this byte specifies how many bytes to
read as the operand named @i[value].  All numeric values are unsigned binary
integers unless otherwise specified.  Values described as "signed" are in
two's-complement form unless otherwise specified.  When an integer read from
the stream occupies more than one byte, the first byte read is the least
significant byte, and the last byte read is the most significant (and contains
the sign bit as its high-order bit if the entire integer is signed).

Some of the operations are not necessary, but are rather special cases of or
combinations of others.  These are included to reduce the size of the file or
to speed up important cases.  As an example, nearly all strings are less than
256 bytes long, and so a special form of string operation might take a one-byte
length rather than a four-byte length.  As another example, some
implementations may choose to store bits in an array in a left-to-right format
within each word, rather than right-to-left.  The Fasload file format may
support both formats, with one being significantly more efficient than the
other for a given implementation.  The compiler for any implementation may
generate the more efficient form for that implementation, and yet compatibility
can be maintained by requiring all implementations to support both formats in
Fasload files.

Measurements are to be made to determine which operation codes are worthwhile;
little-used operations may be discarded and new ones added.  After a point the
definition will be "frozen", meaning that existing operations may not be
deleted (though new ones may be added; some operations codes will be reserved
for that purpose).

@begin(description)
0 @t[ ] @t[FOP-NOP] @\
No operation.  (This is included because it is recognized
that some implementations may benefit from alignment of operands to some
operations, for example to 32-bit boundaries.  This operation can be used
to pad the instruction stream to a desired bounary.)

1 @t[ ] @t[FOP-POP] @t[ ] @z[@@] @t[ ] table @\
One item is popped from the stack and added to the table.

2 @t[ ] @t[FOP-PUSH] @t[ ] @i[index](4) @t[ ] @z[@@] @t[ ] stack @\
Item number @i[index] of the table is pushed onto the stack.
The first element of the table is item number zero.

3 @t[ ] @t[FOP-BYTE-PUSH] @t[ ] @i[index](1) @t[ ] @z[@@] @t[ ] stack @\
Item number @i[index] of the table is pushed onto the stack.
The first element of the table is item number zero.

4 @t[ ] @t[FOP-EMPTY-LIST] @t[ ] @z[@@] @t[ ] stack @\
The empty list (@t[()]) is pushed onto the stack.

5 @t[ ] @t[FOP-TRUTH] @t[ ] @z[@@] @t[ ] stack @\
The standard truth value (@t[T]) is pushed onto the stack.

6 @t[ ] @t[FOP-SYMBOL-SAVE] @t[ ] @i[n](4) @t[ ] @i[name](@i[n])
@t[ ] @z[@@] @t[ ] stack & table@\
The four-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the default package,
and the resulting symbol is both pushed onto the stack and added to the table.

7 @t[ ] @t[FOP-SMALL-SYMBOL-SAVE] @t[ ] @i[n](1) @t[ ] @i[name](@i[n]) @t[ ] @z[@@] @t[ ] stack & table@\
The one-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the default package,
and the resulting symbol is both pushed onto the stack and added to the table.

8 @t[ ] @t[FOP-SYMBOL-IN-PACKAGE-SAVE] @t[ ] @i[index](4)
@t[ ] @i[n](4) @t[ ] @i[name](@i[n])
@t[ ] @z[@@] @t[ ] stack & table@\
The four-byte @i[index] specifies a package stored in the table.
The four-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the specified package,
and the resulting symbol is both pushed onto the stack and added to the table.

9 @t[ ] @t[FOP-SMALL-SYMBOL-IN-PACKAGE-SAVE]  @t[ ] @i[index](4)
@t[ ] @i[n](1) @t[ ] @i[name](@i[n]) @t[ ]
@z[@@] @t[ ] stack & table@\
The four-byte @i[index] specifies a package stored in the table.
The one-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the specified package,
and the resulting symbol is both pushed onto the stack and added to the table.

10 @t[ ] @t[FOP-SYMBOL-IN-BYTE-PACKAGE-SAVE] @t[ ] @i[index](1)
@t[ ] @i[n](4) @t[ ] @i[name](@i[n])
@t[ ] @z[@@] @t[ ] stack & table@\
The one-byte @i[index] specifies a package stored in the table.
The four-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the specified package,
and the resulting symbol is both pushed onto the stack and added to the table.

11@t[ ] @t[FOP-SMALL-SYMBOL-IN-BYTE-PACKAGE-SAVE] @t[ ] @i[index](1)
@t[ ] @i[n](1) @t[ ] @i[name](@i[n]) @t[ ]
@z[@@] @t[ ] stack & table@\
The one-byte @i[index] specifies a package stored in the table.
The one-byte operand @i[n] specifies the length of the print name
of a symbol.  The name follows, one character per byte,
with the first byte of the print name being the first read.
The name is interned in the specified package,
and the resulting symbol is both pushed onto the stack and added to the table.

12 Unused.

13 @t[ ] @t[FOP-DEFAULT-PACKAGE] @t[ ] @i[index](4) @\
A package stored in the table entry specified by @i[index] is made
the default package for future @t[FOP-SYMBOL] and @t[FOP-SMALL-SYMBOL]
interning operations. (These package FOPs may change or disappear
as the package system is determined.)

14 @t[ ] @t[FOP-PACKAGE] @t[ ] @z[@@] @t[ ] table @\
An item is popped from the stack; it must be a symbol.  The package of
that name is located and pushed onto the table.

15 @t[ ] @t[FOP-LIST] @t[ ] @i[length](1) @t[ ] @z[@@] @t[ ] stack @\
The unsigned operand @i[length] specifies a number of
operands to be popped from the stack.  These are made into a list
of that length, and the list is pushed onto the stack.
The first item popped from the stack becomes the last element of
the list, and so on.  Hence an iterative loop can start with
the empty list and perform "pop an item and cons it onto the list"
@i[length] times.
(Lists of length greater than 255 can be made by using @t[FOP-LIST*]
repeatedly.)

16 @t[ ] @t[FOP-LIST*] @t[ ] @i[length](1) @t[ ] @z[@@] @t[ ] stack @\
This is like @t[FOP-LIST] except that the constructed list is terminated
not by @t[()] (the empty list), but by an item popped from the stack
before any others are.  Therefore @i[length]+1 items are popped in all.
Hence an iterative loop can start with
a popped item and perform "pop an item and cons it onto the list"
@i[length]+1 times.

17-24 @t[ ] @t[FOP-LIST-1], @t[FOP-LIST-2], ..., @t[FOP-LIST-8] @\
@t[FOP-LIST-@i{k}] is like @t[FOP-LIST] with a byte containing @i[k]
following it.  These exist purely to reduce the size of Fasload files.
Measurements need to be made to determine the useful values of @i[k].

25-32 @t[ ] @t[FOP-LIST*-1], @t[FOP-LIST*-2], ..., @t[FOP-LIST*-8] @\
@t[FOP-LIST*-@i{k}] is like @t[FOP-LIST*] with a byte containing @i[k]
following it.  These exist purely to reduce the size of Fasload files.
Measurements need to be made to determine the useful values of @i[k].

33 @t[ ] @t[FOP-INTEGER] @t[ ] @i[n](4) @t[ ] @i[value](@i[n]) @t[ ]
@z[@@] @t[ ] stack @\
A four-byte unsigned operand specifies the number of following
bytes.  These bytes define the value of a signed integer in two's-complement
form.  The first byte of the value is the least significant byte.

34 @t[ ] @t[FOP-SMALL-INTEGER] @t[ ] @i[n](1) @t[ ] @i[value](@i[n])
@t[ ] @z[@@] @t[ ] stack @\
A one-byte unsigned operand specifies the number of following
bytes.  These bytes define the value of a signed integer in two's-complement
form.  The first byte of the value is the least significant byte.

35 @t[ ] @t[FOP-WORD-INTEGER] @t[ ] @i[value](4) @t[ ] @z[@@] @t[ ] stack @\
A four-byte signed integer (in the range -2@+[31] to 2@+[31]-1) follows the
operation code.  A LISP integer (fixnum or bignum) with that value
is constructed and pushed onto the stack.

36 @t[ ] @t[FOP-BYTE-INTEGER] @t[ ] @i[value](1) @t[ ] @z[@@] @t[ ] stack @\
A one-byte signed integer (in the range -128 to 127) follows the
operation code.  A LISP integer (fixnum or bignum) with that value
is constructed and pushed onto the stack.

37 @t[ ] @t[FOP-STRING] @t[ ] @i[n](4) @t[ ] @i[name](@i[n])
@t[ ] @z[@@] @t[ ] stack @\
The four-byte operand @i[n] specifies the length of a string to
construct.  The characters of the string follow, one per byte.
The constructed string is pushed onto the stack.

38 @t[ ] @t[FOP-SMALL-STRING] @t[ ] @i[n](1) @t[ ] @i[name](@i[n]) @t[ ] @z[@@] @t[ ] stack @\
The one-byte operand @i[n] specifies the length of a string to
construct.  The characters of the string follow, one per byte.
The constructed string is pushed onto the stack.

39 @t[ ] @t[FOP-VECTOR] @t[ ] @i[n](4) @t[ ] @z[@@] @t[ ] stack @\
The four-byte operand @i[n] specifies the length of a vector of LISP objects
to construct.  The elements of the vector are popped off the stack;
the first one popped becomes the last element of the vector.
The constructed vector is pushed onto the stack.

40 @t[ ] @t[FOP-SMALL-VECTOR] @t[ ] @i[n](1) @t[ ] @z[@@] @t[ ] stack @\
The one-byte operand @i[n] specifies the length of a vector of LISP objects
to construct.  The elements of the vector are popped off the stack;
the first one popped becomes the last element of the vector.
The constructed vector is pushed onto the stack.

41 @t[ ] @t[FOP-UNIFORM-VECTOR] @t[ ] @i[n](4) @t[ ] @z[@@] @t[ ] stack @\
The four-byte operand @i[n] specifies the length of a vector of LISP objects
to construct.  A single item is popped from the stack and used to initialize
all elements of the vector.  The constructed vector is pushed onto the stack.

42 @t[ ] @t[FOP-SMALL-UNIFORM-VECTOR] @t[ ] @i[n](1) @t[ ] @z[@@] @t[ ] stack @\
The one-byte operand @i[n] specifies the length of a vector of LISP objects
to construct.  A single item is popped from the stack and used to initialize
all elements of the vector.  The constructed vector is pushed onto the stack.

43 @t[ ] @t[FOP-INT-VECTOR] @t[ ] @i[n](4) @t[ ] @i[size](1) @t[ ] @i[count](1) @t[ ]
@i[data](@z[T]@i[n]/@i[count]@z[U]@z[T]@i[size]*@i[count]/8@z[U]) @t[ ]
@z[@@] @t[ ] stack @\
The four-byte operand @i[n] specifies the length of a vector of 
unsigned integers to be constructed.   Each integer is @i[size]
bits big, and are packed in the data stream in sections of
@i[count] apiece.  Each section occupies an integral number of bytes.
If the bytes of a section are lined up in a row, with the first
byte read at the right, and successive bytes placed to the left,
with the bits within a byte being arranged so that the low-order bit
is to the right, then the integers of the section are successive
groups of @i[size] bits, starting from the right and running across
byte boundaries.  (In other words, this is a consistent
right-to-left convention.)  Any bits wasted at the left end of
a section are ignored, and any wasted groups in the last section
are ignored.
It is permitted for the loading implementation to use a vector
format providing more precision than is required by @i[size].
For example, if @i[size] were 3, it would be permitted to use a vector
of 4-bit integers, or even vector of general LISP objects filled
with integer LISP objects.  However, an implementation is expected
to use the most restrictive format that will suffice, and is expected
to reconstruct objects identical to those output if the Fasload file
was produced by the same implementation.
(For the PERQ U-vector formats, one would have
@i[size] an element of {1, 2, 4, 8, 16}, and @i[count]=32/@i[size];
words could be read directly into the U-vector.
This operation provides a very general format whereby almost
any conceivable implementation can output in its preferred packed format,
and another can read it meaningfully; by checking at the beginning
for good cases, loading can still proceed quickly.)
The constructed vector is pushed onto the stack.

44 @t[ ] @t[FOP-UNIFORM-INT-VECTOR] @t[ ] @i[n](4) @t[ ] @i[size](1) @t[ ]
@i[value](@z[T]@i[size]/8@z[U]) @t[ ] @z[@@] @t[ ] stack @\
The four-byte operand @i[n] specifies the length of a vector of unsigned
integers to construct.
Each integer is @i[size] bits big, and is initialized to the value
of the operand @i[value].
The constructed vector is pushed onto the stack.

45 @t[ ] @t[FOP-FLOAT] @t[ ] @i[n](1) @t[ ] @i[exponent](@z[T]@i[n]/8@z[U]) @t[ ]
@i[m](1) @t[ ] @i[mantissa](@z[T]@i[m]/8@z[U]) @t[ ] @z[@@] @t[ ] stack @\
The first operand @i[n] is one unsigned byte, and describes the number of
@i[bits] in the second operand @i[exponent], which is a signed
integer in two's-complement format.  The high-order bits of
the last (most significant) byte of @i[exponent] shall equal the sign bit.
Similar remarks apply to @i[m] and @i[mantissa].  The value denoted by these
four operands is @i[mantissa]@t[x]2@+(@i[exponent]-length(@i[mantissa])).
A floating-point number shall be constructed which has this value,
and then pushed onto the stack.  That floating-point format should be used
which is the smallest (most compact) provided by the implementation which
nevertheless provides enough accuracy to represent both the exponent
and the mantissa correctly.

46-51 Unused

52 @t[ ] @t[FOP-ALTER] @t[ ] @i[index](1) @\
Two items are popped from the stack; call the first @i[newval] and
the second @i[object].  The component of @i[object] specified by
@i[index] is altered to contain @i[newval].  The precise operation
depends on the type of @i[object]:
@begin(description)
List @\ A zero @i[index] means alter the car (perform @t[RPLACA]),
and @i[index]=1 means alter the cdr (@t[RPLACD]).

Symbol @\ By definition these indices have the following meaning,
and have nothing to do with the actual representation of symbols
in a given implementation:
@begin(description)
0 @\ Alter value cell.

1 @\ Alter function cell.

2 @\ Alter property list (!).
@end(description)

Vector (of any kind) @\ Alter component number @i[index] of the vector.

String @\ Alter character number @i[index] of the string.
@end(description)

53 @t[ ] @t[FOP-EVAL] @t[ ] @z[@@] @t[ ] stack @\
Pop an item from the stack and evaluate it (give it to @t[EVAL]).
Push the result back onto the stack.

54 @t[ ] @t[FOP-EVAL-FOR-EFFECT] @\
Pop an item from the stack and evaluate it (give it to @t[EVAL]).
The result is ignored.

55 @t[ ] @t[FOP-FUNCALL] @t[ ] @i[nargs](1) @t[ ] @z[@@] @t[ ] stack @\
Pop @i[nargs]+1 items from the stack and apply the last one popped
as a function to
all the rest as arguments (the first one popped being the last argument).
Push the result back onto the stack.

56 @t[ ] @t[FOP-FUNCALL-FOR-EFFECT] @t[ ] @i[nargs](1) @\
Pop @i[nargs]+1 items from the stack and apply the last one popped
as a function to
all the rest as arguments (the first one popped being the last argument).
The result is ignored.

57 @t[ ] @t[FOP-CODE-FORMAT] @t[ ] @i[id](1) @\
The operand @i[id] is a unique identifier specifying the format
for following code objects.  The operations @t[FOP-CODE]
and its relatives may not
occur in a group until after @t[FOP-CODE-FORMAT] has appeared;
there is no default format.  This is provided so that several
compiled code formats may co-exist in a file, and so that a loader
can determine whether or not code was compiled by the correct
compiler for the implementation being loaded into.
So far the following code format identifiers are defined:
@begin(description)
0 @\ PERQ

1 @\ VAX
@end(description)

58 @t[ ] @t[FOP-CODE] @t[ ] @i[nitems](4) @t[ ] @i[size](4) @t[ ]
@i[code](@i[size]) @t[ ] @z[@@] @t[ ] stack @\
A compiled function is constructed and pushed onto the stack.
This object is in the format specified by the most recent
occurrence of @t[FOP-CODE-FORMAT].
The operand @i[nitems] specifies a number of items to pop off
the stack to use in the "boxed storage" section.  The operand @i[code]
is a string of bytes constituting the compiled executable code.

59 @t[ ] @t[FOP-SMALL-CODE] @t[ ] @i[nitems](1) @t[ ] @i[size](2) @t[ ]
@i[code](@i[size]) @t[ ] @z[@@] @t[ ] stack @\
A compiled function is constructed and pushed onto the stack.
This object is in the format specified by the most recent
occurrence of @t[FOP-CODE-FORMAT].
The operand @i[nitems] specifies a number of items to pop off
the stack to use in the "boxed storage" section.  The operand @i[code]
is a string of bytes constituting the compiled executable code.

60 @t[ ] @t[FOP-STATIC-HEAP] @\
Until further notice operations which allocate data structures
may allocate them in the static area rather than the dynamic area.
(The default area for allocation is the dynamic area; this
default is reset whenever a new group is begun.
This command is of an advisory nature; implementations with no
static heap can ignore it.)

61 @t[ ] @t[FOP-DYNAMIC-HEAP] @\
Following storage allocation should be in the dynamic area.

62 @t[ ] @t[FOP-VERIFY-TABLE-SIZE] @t[ ] @i[size](4) @\
If the current size of the table is not equal to @i[size],
then an inconsistency has been detected.  This operation
is inserted into a Fasload file purely for error-checking purposes.
It is good practice for a compiler to output this at least at the
end of every group, if not more often.

63 @t[ ] @t[FOP-VERIFY-EMPTY-STACK] @\
If the stack is not currently empty,
then an inconsistency has been detected.  This operation
is inserted into a Fasload file purely for error-checking purposes.
It is good practice for a compiler to output this at least at the
end of every group, if not more often.

64 @t[ ] @t[FOP-END-GROUP] @\
This is the last operation of a group.  If this is not the
last byte of the file, then a new group follows; the next
nine bytes must be "@t[FASL FILE]".

65 @t[ ] @t[FOP-POP-FOR-EFFECT] @t[ ] stack @t[ ] @z[@@] @t[ ] @\
One item is popped from the stack.

66 @t[ ] @t[FOP-MISC-TRAP] @t[ ] @z[@@] @t[ ] stack @\
A trap object is pushed onto the stack.

67 @t[ ] @t[FOP-READ-ONLY-HEAP] @\
Following storage allocation may be in a read-only heap.
(For symbols, the symbol itself may not be in a read-only area,
but its print name (a string) may be.
This command is of an advisory nature; implementations with no
read-only heap can ignore it, or use a static heap.)

68 @t[ ] @t[FOP-CHARACTER] @t[ ] @i[character](3) @t[ ] @z[@@] @t[ ] stack @\
The three bytes specify the 24 bits of a Spice Lisp character object.
The bytes, lowest first, represent the code, control, and font bits.
A character is constructed and pushed onto the stack.

69 @t[ ] @t[FOP-SHORT-CHARACTER] @t[ ] @i[character](1) @t[ ]
@z[@@] @t[ ] stack @\
The one byte specifies the lower eight bits of a spice lisp character
object (the code).  A character is constructed with zero control
and zero font attributes and pushed onto the stack.

70 @t[ ] @t[FOP-RATIO] @t[ ] @z[@@] @t[ ] stack @\
Creates a ratio from two integers popped from the stack.
The denominator is popped first, the numerator second.

71 @t[ ] @t[FOP-COMPLEX] @t[ ] @z[@@] @t[ ] stack @\
Creates a complex number from two numbers popped from the stack.
The imaginary part is popped first, the real part second.

72 @t[ ] @t[FOP-LINK-ADDRESS-FIXUP] @t[ ] @i[nargs](1) @t[ ] @i[restp](1)
@t[ ] @i[offset](4) @t[ ] @z[@@] @t[ ] stack @\
Valid only for when FOP-CODE-FORMAT corresponds to the Vax.
This operation pops a symbol and a code object from the stack and pushes
a modified code object back onto the stack according to the needs of the
runtime Vax code linker.

73 @t[ ] @t[FOP-LINK-FUNCTION-FIXUP] @t[ ] @i[offset](4) @t[ ]
@z[@@] @t[ ] stack @\
Valid only for when FOP-CODE-FORMAT corresponds to the Vax.
This operation pops a symbol and a code object from the stack and pushes
a modified code object back onto the stack according to the needs of the
runtime Vax code linker.

74 @t[ ] @t[FOP-FSET] @t[ ] @\
Pops the top two things off of the stack and uses them as arguments to FSET
(i.e. SETF of SYMBOL-FUNCTION).

255 @t[ ] @t[FOP-END-HEADER] @\
Indicates the end of a group header, as described above.
@end(description)

@appendix [The Opcode Definition File]
@begin [verbatim]
@include [PRVA:<Slisp.Compiler.New-And-Improved>Instrdefs.Slisp]
@end [verbatim]
