/*
 *	+++ NAME +++
 *
 *	 COS   Double precision cosine
 *
 *	+++ INDEX +++
 *
 *	 COS
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision cosine of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double cos(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Computer Approximations, J.F. Hart et al, John Wiley & Sons,
 *	1968, pp. 112-120.
 *
 *	+++ RESTRICTIONS +++
 *
 *	The sin and cos routines are interactive in the sense that
 *	in the process of reducing the argument to the range -PI/4
 *	to PI/4, each may call the other.  Ultimately one or the
 *	other uses a polynomial approximation on the reduced
 *	argument.  The sin approximation has a maximum relative error
 *	of 10**(-17.59) and the cos approximation has a maximum
 *	relative error of 10**(-16.18).
 *
 *	These error bounds assume exact arithmetic
 *	in the polynomial evaluation.  Additional rounding and
 *	truncation errors may occur as the argument is reduced
 *	to the range over which the polynomial approximation
 *	is valid, and as the polynomial is evaluated using
 *	finite-precision arithmetic.
 *
 *	+++ PROGRAMMER +++
 *
 *	 Fred Fish
 *	 Goodyear Aerospace Corp, Arizona Div.
 *	 (602) 932-7000 work
 *	 (602) 894-6881 home
 *
 *	Modifications for inclusion in standard C library are
 *	(c) Copyright Ian Macky, SRI International 1985
 *	Additional modifications after v.7, 19-Jan-1988 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the cos()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.7
 *
 *	+++ INTERNALS +++
 *
 *	Computes cos(X) from:
 *
 *		(1)	Reduce argument X to range -PI to PI.
 *
 *		(2)	If X > PI/2 then call cos recursively
 *			using relation cos(X) = -cos(X - PI).
 *
 *		(3)	If X < -PI/2 then call cos recursively
 *			using relation cos(X) = -cos(X + PI).
 *
 *		(4)	If X > PI/4 then call sin using
 *			relation cos(X) = sin(PI/2 - X).
 *
 *		(5)	If X < -PI/4 then call COS using
 *			relation cos(X) = sin(PI/2 + X).
 *
 *		(6)	If X would cause underflow in approx
 *			evaluation arithmetic then return
 *			sqrt(1.0 - X**2).
 *
 *		(7)	By now X has been reduced to range
 *			-PI/4 to PI/4 and the approximation
 *			from HART pg. 119 can be used:
 *
 *			cos(X) = P(Y) / Q(Y)
 *			Where:
 *
 *			Y    =	X * (4/PI)
 *
 *			P(Y) =  SUM [ Pj * (Y**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			Q(Y) =  SUM [ Qj * (Y**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			P0   =	0.12905394659037374438571854e+7
 *			P1   =	-0.3745670391572320471032359e+6
 *			P2   =	0.134323009865390842853673e+5
 *			P3   =	-0.112314508233409330923e+3
 *			Q0   =	0.12905394659037373590295914e+7
 *			Q1   =	0.234677731072458350524124e+5
 *			Q2   =	0.2096951819672630628621e+3
 *			Q3   =	1.0000...
 *			(coefficients from HART table #3843 pg 244)
 *
 *	**** NOTE ****    The range reduction relations used in
 *	this routine depend on the final approximation being valid
 *	over the negative argument range in addition to the positive
 *	argument range.  The particular approximation chosen from
 *	HART satisfies this requirement, although not explicitly
 *	stated in the text.  This may not be true of other
 *	approximations given in the reference.
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

static double cos_pcoeffs[] = {
    0.12905394659037374438e7,
   -0.37456703915723204710e6,
    0.13432300986539084285e5,
   -0.11231450823340933092e3
};

static double cos_qcoeffs[]  = {
    0.12905394659037373590e7,
    0.23467773107245835052e5,
    0.20969518196726306286e3,
    1.0
};

#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define MIN(a,b) ((a) < (b) ? (a) : (b))

double cos(x)
double x;
{
    double y, yt2;

    if (x < -PI || x > PI) {
	x = fmod(x, TWOPI);
        if (x > PI) {
	    x = x - TWOPI;
        } else if (x < -PI) {
	    x = x + TWOPI;
        }
    }

    /* Use MAX and MIN to avoid infinite recursion which can
       occur if x = HALFPI + eps, and (x - PI) = HALFPI - eps */
    if (x > HALFPI)
	return -cos(MAX(-HALFPI, x - PI));
    else if (x < -HALFPI)
	return -cos(MIN(PI, x + PI));
    else if (x > FOURTHPI)
	return sin(HALFPI - x);
    else if (x < -FOURTHPI)
	return sin(HALFPI + x);
    else if (x < X6_UNDERFLOWS && x > -X6_UNDERFLOWS)
	return sqrt(1.0 - x * x);
    else {
	y = x / FOURTHPI;
	yt2 = y * y;
	return _poly4(cos_pcoeffs ,yt2) / _poly4(cos_qcoeffs, yt2);
    }
}
