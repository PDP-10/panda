/*
 *	+++ NAME +++
 *
 *	 SIN	Double precision sine
 *
 *	+++ INDEX +++
 *
 *	 SIN
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision sine of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double sin(x)
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
 *	Additional modifications after v.6, 19-Jan-1988 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the sin()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.21
 *
 *	+++ INTERNALS +++
 *
 *	Computes sin(X) from:
 *
 *		(1)	Reduce argument X to range -PI to PI.
 *
 *		(2)	If X > PI/2 then call sin recursively
 *			using relation sin(X) = -sin(X - PI).
 *
 *		(3)	If X < -PI/2 then call sin recursively
 *			using relation sin(X) = -sin(X + PI).
 *
 *		(4)	If X > PI/4 then call cos using
 *			relation sin(X) = cos(PI/2 - X).
 *
 *		(5)	If X < -PI/4 then call cos using
 *			relation sin(X) = -cos(PI/2 + X).
 *
 *		(6)	If X is small enough that polynomial
 *			evaluation would cause underflow
 *			then return X, since sin(X)
 *			approaches X as X approaches zero.
 *
 *		(7)	By now X has been reduced to range
 *			-PI/4 to PI/4 and the approximation
 *			from HART pg. 118 can be used:
 *
 *			sin(X) = Y * ( P(Y) / Q(Y) )
 *			Where:
 *
 *			Y    =  X * (4/PI)
 *
 *			P(Y) =  SUM [ Pj * (Y**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			Q(Y) =  SUM [ Qj * (Y**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			P0   =  0.206643433369958582409167054e+7
 *			P1   =  -0.18160398797407332550219213e+6
 *			P2   =  0.359993069496361883172836e+4
 *			P3   =  -0.2010748329458861571949e+2
 *			Q0   =  0.263106591026476989637710307e+7
 *			Q1   =  0.3927024277464900030883986e+5
 *			Q2   =  0.27811919481083844087953e+3
 *			Q3   =  1.0000...
 *			(coefficients from HART table #3063 pg 234)
 *
 *
 *	**** NOTE ****	  The range reduction relations used in
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
#include "pml.h"

static double sin_pcoeffs[] = {
    0.20664343336995858240e7,
   -0.18160398797407332550e6,
    0.35999306949636188317e4,
   -0.20107483294588615719e2
};

static double sin_qcoeffs[] = {
    0.26310659102647698963e7,
    0.39270242774649000308e5,
    0.27811919481083844087e3,
    1.0
};

#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define MIN(a,b) ((a) < (b) ? (a) : (b))

double sin(x)
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
	return -sin(MAX(-HALFPI, x - PI));
    else if (x < -HALFPI)
	return -sin(MIN(PI, x + PI));
    else if (x > FOURTHPI)
	return cos(HALFPI - x);
    else if (x < -FOURTHPI)
	return -cos(HALFPI + x);
    else if (x < X6_UNDERFLOWS && x > -X6_UNDERFLOWS)
	return x;
    else {
	y = x / FOURTHPI;
	yt2 = y * y;
	return y * _poly4(sin_pcoeffs, yt2) / _poly4(sin_qcoeffs, yt2);
    }
}
