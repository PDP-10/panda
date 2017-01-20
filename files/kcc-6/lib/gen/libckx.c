/*
**	LIBCKX	- CPU module for extended-addressing loads.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This module is simply a version of CPU.C compiled for
** a CPU of type KLX, i.e. the code is to run in a non-zero section of a KL.
**	Since this is not the normal CPU.REL module, it must be
** kept separate from LIBC.REL.  KCC's -i switch forces an attempt to
** load the CKX library (switch -lckx).
*/

#define CPU_KLX 1
#include "cpu.c"	/* Located in same directory */
