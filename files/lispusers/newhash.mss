@make(article)
@disable(contents)
@begin(center)
HASH.LSP

A Hash-Coded Dictionary Facility

for Interlisp-10 & Interlisp-D

Christopher Lane

modeled after work by

L. M. Masinter
W. van Melle
R. M. Kaplan

August 1983
@end(center)

@section(Introduction)

The hashfile package provides a facility for storing and retrieving
information on files from within Interlisp.

HASH.LSP is a new implementation of the Interlisp-10 hashfile package
which works in both Interlisp-10 and Interlisp-D, being written in
Interlisp and operating on streams of bytes.  This package implements
both the current Interlisp-10 package as well as the original
implementation of Masinter and van Melle which is still used in EMYCIN
based systems, and will be referred to as the EMYCIN package.  This
document only deals with differences between the various packages.
Users should consult the Interlisp Reference Manual and the EMYCIN
documentation for details.

@section(Basics)

Hashfiles are created by calling CREATEHASHFILE.  A "HashFile", as
referenced in this document, is the datum returned by CREATEHASHFILE
or OPENHASHFILE, currently an array record containing the hashfile
name, and the number of slots in the file, the used slots and other
details.  All other functions with hashfile arguments use this datum.
A NIL hashfile argument still refers to SYSHASHFILE, that is in the
EMYCIN sense of the current hashfile, not a global user hashfile as
in Interlisp-10. Keys are strings or atoms, as in the other systems.

Interlisp-10 hashfiles come in several flavors, according to the values
stored in them.  The EMYCIN system provides even more flexibility.
This system @b(only) supports the most general EXPR type of hashfiles;
the VALUETYPE and ITEMLENGTH arguments are ignored.

Two key hashing @b(is) supported in this system but is discouraged
as it is only in EMYCIN, not in the Interlisp-10 system.  The functions
that manipulate `secret pages' do not exist in this implementation.

The package sysloads the DFOR10.COM package from the LispUsers directory
for Interlisp-10 users.

@section(Functions)
The functions implemented are:

@begin(description)
createhashfile[filename,valuetype,itemlength,#entries]

openhashfile[filename,access(,itemlength)(,#entries)(,smash)]

lookuphashfile[key,value,hashfile,calltype(,key2)]

puthashfile[key,value,hashfile(,key2)]

gethashfile[key,hashfile(,key2)]

hashfiledata[hashfile] (EMYCIN)

hashfilep[hashfile(,write?)]

hashfileprop[hashfile,property]

hashfilename[hashfile]

closehashfile[hashfile(,reopen)]

clearhashfiles[close,release] (EMYCIN)

maphashfile[hashfile,mapfn(,double)]

hashfilesplst[hashfile(,xword)]

collectkeys[hashfile,double,mkstring] (EMYCIN)

rehashfile[hashfile(,newname(,newvaluetype))]

@end(description)


@section(Global Variables)

The variables used by the system of interest to the user.

@begin(description)
HASHTEXTCHAR {^A} The character separating two key hashkeys.

HASHFILERDTBL {ORIG} The hashfile read table.

HFGROWTHFACTOR {3} The ration of total slots to used slots when a
hashfile is created.

REHASHGAG {NIL} Flags whether to print message when rehashing;
initially off.

HASHFILEDEFAULTSIZE {512} Size used when #Entries is omited.

HASHLOADFACTOR {.875} The ratio, used slots/total slots, at which
the system rehashes the file, initially 7/8.

SYSHASHFILE {NIL} The current hashfile.

@end(description)

@section(Implementation)

The hashfile package views files as a sequence of bytes, randomly
accessible.  No notice is made of pages and it is assumed that the
host computer buffers I/O suffieciently.

Hash files consist of a layer of pointers followed by ascii data.
Pointers are 3 bytes wide, preceeded by a status byte.  The pointers
point to key PNAMES in the data section, where each key is followed
by its value.  Deleted key pointers are reused, deleted data space
is not, so rehashing is required if many items have been "replaced".

The data section starts at 4*HASHFILE:SIZE + 9, and consists of
alternating keys and values.  As deleted data is not re-written, files
should not be accessed directly.

When a key hashes into a used slot, a probe value is added to it to
find the next slot to search.  The probe value is a small prime derived
from the original hash key.

@section(Limitations)

The system currently is able to manipulate files on the local disk
and read hashfiles over the network, however, writing hash files over
the network runs into problems with the leaf servers.

Due to the pointer size, only hashfiles of < 6 million intial entries
can be created, though these can grow to 14 million entries before
automatic rehashing exceeds the pointer limit.  The total file length
is limited to 16 million bytes.  No range checking is done for these
limits.
